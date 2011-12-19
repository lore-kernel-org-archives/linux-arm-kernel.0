From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:33 -0500
Subject: [PATCH 04/20] ARM: mach-exynos: use standard arch_idle()
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-5-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is equivalent and more similar to existing architectures.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-exynos/cpu.c                 |   12 ------------
 arch/arm/mach-exynos/include/mach/system.h |    2 +-
 2 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-exynos/cpu.c b/arch/arm/mach-exynos/cpu.c
index d933cb106f..c9d0f0dfbb 100644
--- a/arch/arm/mach-exynos/cpu.c
+++ b/arch/arm/mach-exynos/cpu.c
@@ -140,14 +140,6 @@ static struct map_desc exynos4_iodesc1[] __initdata = {
 	},
 };
 
-static void exynos_idle(void)
-{
-	if (!need_resched())
-		cpu_do_idle();
-
-	local_irq_enable();
-}
-
 void exynos4_restart(char mode, const char *cmd)
 {
 	__raw_writel(0x1, S5P_SWRESET);
@@ -285,9 +277,5 @@ early_initcall(exynos4_l2x0_cache_init);
 int __init exynos_init(void)
 {
 	printk(KERN_INFO "EXYNOS: Initializing architecture\n");
-
-	/* set idle function */
-	pm_idle = exynos_idle;
-
 	return sysdev_register(&exynos4_sysdev);
 }
diff --git a/arch/arm/mach-exynos/include/mach/system.h b/arch/arm/mach-exynos/include/mach/system.h
index 5e3220c18f..4d5a9d73fb 100644
--- a/arch/arm/mach-exynos/include/mach/system.h
+++ b/arch/arm/mach-exynos/include/mach/system.h
@@ -17,6 +17,6 @@
 
 static void arch_idle(void)
 {
-	/* nothing here yet */
+	cpu_do_idle();
 }
 #endif /* __ASM_ARCH_SYSTEM_H */
-- 
1.7.7.1.431.g10b2a
