From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Mar 2010 13:48:37 +0000
Subject: [PATCH v4 3/4] ARM: Add L2x0 outer_sync() support
In-Reply-To: <20100319134614.14625.18408.stgit@e102109-lin.cambridge.arm.com>
References: <20100319134614.14625.18408.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100319134837.14625.30484.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The L2x0 cache controllers need to explicitly drain their write buffer
even for Normal Noncacheable memory accesses.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/Kconfig      |    1 +
 arch/arm/mm/cache-l2x0.c |   10 ++++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 7dc1f8c..6226413 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -772,6 +772,7 @@ config CACHE_L2X0
 		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || ARCH_NOMADIK || ARCH_OMAP4
 	default y
 	select OUTER_CACHE
+	select OUTER_CACHE_SYNC
 	help
 	  This option enables the L2x0 PrimeCell.
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index af47ea6..9601062 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -150,6 +150,15 @@ static inline void l2x0_flush_line(unsigned long addr)
 }
 #endif
 
+static void l2x0_cache_sync(void)
+{
+	unsigned long flags;
+
+	_l2x0_lock(&l2x0_lock, flags);
+	cache_sync();
+	_l2x0_unlock(&l2x0_lock, flags);
+}
+
 static inline void l2x0_inv_all(void)
 {
 	unsigned long flags;
@@ -287,6 +296,7 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	outer_cache.inv_range = l2x0_inv_range;
 	outer_cache.clean_range = l2x0_clean_range;
 	outer_cache.flush_range = l2x0_flush_range;
+	outer_cache.sync = l2x0_cache_sync;
 
 	pr_info(L2CC_TYPE " cache controller enabled\n");
 }
