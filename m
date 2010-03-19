From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Mar 2010 14:33:11 +0000
Subject: [PATCH v5 3/4] ARM: Add L2x0 outer_sync() support
In-Reply-To: <20100319143047.11748.9186.stgit@e102109-lin.cambridge.arm.com>
References: <20100319143047.11748.9186.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100319143311.11748.76264.stgit@e102109-lin.cambridge.arm.com>
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
index 88a24de..55a2a00 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -763,6 +763,7 @@ config CACHE_L2X0
 		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || ARCH_NOMADIK || ARCH_OMAP4
 	default y
 	select OUTER_CACHE
+	select OUTER_CACHE_SYNC
 	help
 	  This option enables the L2x0 PrimeCell.
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 0733463..21ad68b 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -93,6 +93,15 @@ static inline void l2x0_flush_line(unsigned long addr)
 }
 #endif
 
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
@@ -225,6 +234,7 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	outer_cache.inv_range = l2x0_inv_range;
 	outer_cache.clean_range = l2x0_clean_range;
 	outer_cache.flush_range = l2x0_flush_range;
+	outer_cache.sync = l2x0_cache_sync;
 
 	printk(KERN_INFO "L2X0 cache controller enabled\n");
 }
