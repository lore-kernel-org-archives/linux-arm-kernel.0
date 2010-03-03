From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 03 Mar 2010 12:16:53 +0000
Subject: [PATCH v3 3/4] ARM: Add outer_cache_fns sync function and support
	for L2x0
In-Reply-To: <20100303121307.22029.26151.stgit@e102109-lin.cambridge.arm.com>
References: <20100303121307.22029.26151.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100303121653.22029.26705.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the outer_cache_fns.sync function that can be used
to drain the write buffers of the outer cache. It also initialises this
function for cache-l2x0.c.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/outercache.h |    8 ++++++++
 arch/arm/mm/cache-l2x0.c          |   10 ++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

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
index 5951ded..47149d2 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -43,6 +43,15 @@ static inline void cache_sync(void)
 	cache_wait(base + L2X0_CACHE_SYNC, 1);
 }
 
+static void l2x0_cache_sync(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&l2x0_lock, flags);
+	cache_sync();
+	spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
 static inline void l2x0_inv_all(void)
 {
 	unsigned long flags;
@@ -179,6 +188,7 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	outer_cache.inv_range = l2x0_inv_range;
 	outer_cache.clean_range = l2x0_clean_range;
 	outer_cache.flush_range = l2x0_flush_range;
+	outer_cache.sync = l2x0_cache_sync;
 
 	printk(KERN_INFO "L2X0 cache controller enabled\n");
 }
