From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Feb 2010 11:01:21 +0000
Subject: [PATCH 3/4] ARM: Add outer_cache_fns sync function and support for
	L2x0
Message-ID: <20100223110121.11048.45255.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the outer_cache_fns.sync function that can be used
to drain the write buffers of the outer cache. It also initialises this
function for cache-l2x0.c.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/outercache.h |    8 ++++++++
 arch/arm/mm/cache-l2x0.c          |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index c8571cb..c94bfe1 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -25,6 +25,7 @@ struct outer_cache_fns {
 	void (*inv_range)(unsigned long, unsigned long);
 	void (*clean_range)(unsigned long, unsigned long);
 	void (*flush_range)(unsigned long, unsigned long);
+	void (*sync)(void);
 };
 
 #ifdef CONFIG_OUTER_CACHE
@@ -46,6 +47,11 @@ static inline void outer_flush_range(unsigned long start, unsigned long end)
 	if (outer_cache.flush_range)
 		outer_cache.flush_range(start, end);
 }
+static inline void outer_sync(void)
+{
+	if (outer_cache.sync)
+		outer_cache.sync();
+}
 
 #else
 
@@ -55,6 +61,8 @@ static inline void outer_clean_range(unsigned long start, unsigned long end)
 { }
 static inline void outer_flush_range(unsigned long start, unsigned long end)
 { }
+static inline void outer_sync(void)
+{ }
 
 #endif
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 5951ded..4776a1c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -179,6 +179,7 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	outer_cache.inv_range = l2x0_inv_range;
 	outer_cache.clean_range = l2x0_clean_range;
 	outer_cache.flush_range = l2x0_flush_range;
+	outer_cache.sync = cache_sync;
 
 	printk(KERN_INFO "L2X0 cache controller enabled\n");
 }
