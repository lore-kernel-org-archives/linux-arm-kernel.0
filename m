From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 16:53:39 +0200
Subject: [PATCH] ARM: avoid l2x0 build warning for CONFIG_OF=n
Message-ID: <2852268.nkG1OoBDfE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few functions in the l2x0 code are now only used from code that
is DT-only, so we get harmless gcc warnings about unused static
symbols unless these are removed as well.

arch/arm/mm/cache-l2x0.c:167:13: warning: 'l2x0_cache_sync' defined but not used [-Wunused-function]
arch/arm/mm/cache-l2x0.c:184:13: warning: 'l2x0_flush_all' defined but not used [-Wunused-function]
arch/arm/mm/cache-l2x0.c:194:13: warning: 'l2x0_disable' defined but not used [-Wunused-function]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: cf9ea8f130e2 ("ARM: l2c: remove obsolete l2x0 ops for non-OF init")

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 5f2c988a06ac..08670f96281d 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -164,6 +164,7 @@ static inline void debug_writel(unsigned long val)
 }
 #endif
 
+#ifdef CONFIG_OF
 static void l2x0_cache_sync(void)
 {
 	unsigned long flags;
@@ -201,6 +202,7 @@ static void l2x0_disable(void)
 	dsb(st);
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
+#endif
 
 static void l2c_save(void __iomem *base)
 {
