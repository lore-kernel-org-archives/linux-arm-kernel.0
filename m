From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 23 Apr 2013 17:46:31 +0200
Subject: [PATCH v3 10/13] ARM: SAMSUNG: Do not register legacy timer interrupts
 on Exynos
In-Reply-To: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
References: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
Message-ID: <1366731994-7478-11-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes legacy PWM timer interrupt initialization from
exynos{4,5}_init_irq() functions, since it conflicts with internal
interrupt handling of the new PWM clocksource driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.c | 15 ---------------
 arch/arm/plat-samsung/Kconfig |  4 ++--
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 64ef39e..9574498 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -492,13 +492,6 @@ void __init exynos4_init_irq(void)
 		combiner_init(S5P_VA_COMBINER_BASE, NULL,
 			      max_combiner_nr(), COMBINER_IRQ(0, 0));
 
-	/*
-	 * The parameters of s5p_init_irq() are for VIC init.
-	 * Theses parameters should be NULL and 0 because EXYNOS4
-	 * uses GIC instead of VIC.
-	 */
-	s5p_init_irq(NULL, 0);
-
 	gic_arch_extn.irq_set_wake = s3c_irq_wake;
 }
 
@@ -507,14 +500,6 @@ void __init exynos5_init_irq(void)
 #ifdef CONFIG_OF
 	irqchip_init();
 #endif
-	/*
-	 * The parameters of s5p_init_irq() are for VIC init.
-	 * Theses parameters should be NULL and 0 because EXYNOS4
-	 * uses GIC instead of VIC.
-	 */
-	if (!of_machine_is_compatible("samsung,exynos5440"))
-		s5p_init_irq(NULL, 0);
-
 	gic_arch_extn.irq_set_wake = s3c_irq_wake;
 }
 
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 53e7eeb..04410da 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -97,9 +97,9 @@ config SAMSUNG_IRQ_VIC_TIMER
          Internal configuration to build the VIC timer interrupt code.
 
 config S5P_IRQ
-	def_bool (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS)
+	def_bool (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210)
 	help
-	  Support common interrup part for ARCH_S5P and ARCH_EXYNOS SoCs
+	  Support common interrupt part for ARCH_S5P SoCs
 
 config S5P_EXT_INT
 	bool
-- 
1.8.2.1
