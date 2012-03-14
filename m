From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Mar 2012 07:26:30 -0700
Subject: [PATCH 5/5] ARM: EXYNOS: Support suspend and resume for EXYNOS5250
In-Reply-To: <1331735190-28773-1-git-send-email-kgene.kim@samsung.com>
References: <1331735190-28773-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1331735190-28773-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds function for suspend and resume of Exynos5250.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/include/mach/pm-core.h |    2 +-
 arch/arm/mach-exynos/pm.c                   |  123 ++++++++++++++++-----------
 arch/arm/mach-exynos/pmu.c                  |   59 +++++++++++++
 arch/arm/plat-samsung/include/plat/cpu.h    |    1 +
 4 files changed, 135 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/pm-core.h b/arch/arm/mach-exynos/include/mach/pm-core.h
index 9d8da51e3..a67ecfa 100644
--- a/arch/arm/mach-exynos/include/mach/pm-core.h
+++ b/arch/arm/mach-exynos/include/mach/pm-core.h
@@ -33,7 +33,7 @@ static inline void s3c_pm_arch_prepare_irqs(void)
 	__raw_writel(tmp, S5P_WAKEUP_MASK);
 
 	__raw_writel(s3c_irqwake_intmask, S5P_WAKEUP_MASK);
-	__raw_writel(s3c_irqwake_eintmask, S5P_EINT_WAKEUP_MASK);
+	__raw_writel(s3c_irqwake_eintmask & 0xFFFFFFFE, S5P_EINT_WAKEUP_MASK);
 }
 
 static inline void s3c_pm_arch_stop_clocks(void)
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index abc1def..94faa3e 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -84,7 +84,14 @@ static unsigned int save_arm_register[2];
 
 static int exynos_cpu_suspend(unsigned long arg)
 {
+#ifdef CONFIG_CACHE_L2X0
 	outer_flush_all();
+#endif
+	/*
+	 * To enter suspend mode, GPS LPI register must be set.
+	 */
+	if (soc_is_exynos5250())
+		__raw_writel(0x10000, EXYNOS5_GPS_LPI);
 
 	/* issue the standby signal into the pm unit. */
 	cpu_do_idle();
@@ -95,27 +102,35 @@ static int exynos_cpu_suspend(unsigned long arg)
 
 static void exynos_pm_prepare(void)
 {
-	u32 tmp;
+	unsigned int tmp;
 
 	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
-	s3c_pm_do_save(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
-	s3c_pm_do_save(exynos4_epll_save, ARRAY_SIZE(exynos4_epll_save));
-	s3c_pm_do_save(exynos4_vpll_save, ARRAY_SIZE(exynos4_vpll_save));
 
-	tmp = __raw_readl(S5P_INFORM1);
+	if (!soc_is_exynos5250()) {
+		s3c_pm_do_save(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
+		s3c_pm_do_save(exynos4_epll_save, ARRAY_SIZE(exynos4_epll_save));
+		s3c_pm_do_save(exynos4_vpll_save, ARRAY_SIZE(exynos4_vpll_save));
+	} else {
+		/* Disable USE_RETENTION of JPEG_MEM_OPTION */
+		tmp = __raw_readl(EXYNOS5_JPEG_MEM_OPTION);
+		tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
+		__raw_writel(tmp, EXYNOS5_JPEG_MEM_OPTION);
+	}
 
 	/* Set value of power down register for sleep mode */
-
 	exynos4_sys_powerdown_conf(SYS_SLEEP);
 	__raw_writel(S5P_CHECK_SLEEP, S5P_INFORM1);
 
 	/* ensure at least INFORM0 has the resume address */
-
 	__raw_writel(virt_to_phys(s3c_cpu_resume), S5P_INFORM0);
 
-	/* Before enter central sequence mode, clock src register have to set */
-
-	s3c_pm_do_restore_core(exynos4_set_clksrc, ARRAY_SIZE(exynos4_set_clksrc));
+	/*
+	 * Before enter central sequence mode,
+	 * clock src register have to set.
+	 */
+	if (!soc_is_exynos5250())
+		s3c_pm_do_restore_core(exynos4_set_clksrc,
+				ARRAY_SIZE(exynos4_set_clksrc));
 
 	if (soc_is_exynos4210())
 		s3c_pm_do_restore_core(exynos4210_set_clksrc, ARRAY_SIZE(exynos4210_set_clksrc));
@@ -197,12 +212,18 @@ static void exynos4_restore_pll(void)
 	} while (epll_wait || vpll_wait);
 }
 
-static struct subsys_interface exynos_pm_interface = {
-	.name		= "exynos4_pm",
+static struct subsys_interface exynos4_pm_interface = {
+	.name		= "exynos_pm",
 	.subsys		= &exynos4_subsys,
 	.add_dev	= exynos_pm_add,
 };
 
+static struct subsys_interface exynos5_pm_interface = {
+	.name		= "exynos_pm",
+	.subsys		= &exynos5_subsys,
+	.add_dev	= exynos_pm_add,
+};
+
 static __init int exynos_pm_drvinit(void)
 {
 	struct clk *pll_base;
@@ -224,8 +245,10 @@ static __init int exynos_pm_drvinit(void)
 			clk_put(pll_base);
 		}
 	}
-
-	return subsys_interface_register(&exynos_pm_interface);
+	if (soc_is_exynos5250())
+		return subsys_interface_register(&exynos5_pm_interface);
+	else
+		return subsys_interface_register(&exynos4_pm_interface);
 }
 arch_initcall(exynos_pm_drvinit);
 
@@ -234,27 +257,25 @@ static int exynos_pm_suspend(void)
 	unsigned long tmp;
 
 	/* Setting Central Sequence Register for power down mode */
-
 	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
 	tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
 	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
 
-	if (soc_is_exynos4212()) {
-		tmp = __raw_readl(S5P_CENTRAL_SEQ_OPTION);
-		tmp &= ~(S5P_USE_STANDBYWFI_ISP_ARM |
-			 S5P_USE_STANDBYWFE_ISP_ARM);
-		__raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
-	}
-
-	/* Save Power control register */
-	asm ("mrc p15, 0, %0, c15, c0, 0"
-	     : "=r" (tmp) : : "cc");
-	save_arm_register[0] = tmp;
+	/* Setting SEQ_OPTION register */
+	tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
+	__raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
 
-	/* Save Diagnostic register */
-	asm ("mrc p15, 0, %0, c15, c0, 1"
-	     : "=r" (tmp) : : "cc");
-	save_arm_register[1] = tmp;
+	if (!soc_is_exynos5250()) {
+		/* Save Power control register */
+		asm ("mrc p15, 0, %0, c15, c0, 0"
+		     : "=r" (tmp) : : "cc");
+		save_arm_register[0] = tmp;
+
+		/* Save Diagnostic register */
+		asm ("mrc p15, 0, %0, c15, c0, 1"
+		     : "=r" (tmp) : : "cc");
+		save_arm_register[1] = tmp;
+	}
 
 	return 0;
 }
@@ -276,17 +297,19 @@ static void exynos_pm_resume(void)
 		/* No need to perform below restore code */
 		goto early_wakeup;
 	}
-	/* Restore Power control register */
-	tmp = save_arm_register[0];
-	asm volatile ("mcr p15, 0, %0, c15, c0, 0"
-		      : : "r" (tmp)
-		      : "cc");
-
-	/* Restore Diagnostic register */
-	tmp = save_arm_register[1];
-	asm volatile ("mcr p15, 0, %0, c15, c0, 1"
-		      : : "r" (tmp)
-		      : "cc");
+	if (!soc_is_exynos5250()) {
+		/* Restore Power control register */
+		tmp = save_arm_register[0];
+		asm volatile ("mcr p15, 0, %0, c15, c0, 0"
+			      : : "r" (tmp)
+			      : "cc");
+
+		/* Restore Diagnostic register */
+		tmp = save_arm_register[1];
+		asm volatile ("mcr p15, 0, %0, c15, c0, 1"
+			      : : "r" (tmp)
+			      : "cc");
+	}
 
 	/* For release retention */
 
@@ -300,18 +323,20 @@ static void exynos_pm_resume(void)
 
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	exynos4_restore_pll();
+	if (!soc_is_exynos5250()) {
+		exynos4_restore_pll();
 
 #ifdef CONFIG_SMP
-	scu_enable(S5P_VA_SCU);
+		scu_enable(S5P_VA_SCU);
 #endif
 
 #ifdef CONFIG_CACHE_L2X0
-	s3c_pm_do_restore_core(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
-	outer_inv_all();
-	/* enable L2X0*/
-	writel_relaxed(1, S5P_VA_L2CC + L2X0_CTRL);
+		s3c_pm_do_restore_core(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
+		outer_inv_all();
+		/* enable L2X0*/
+		writel_relaxed(1, S5P_VA_L2CC + L2X0_CTRL);
 #endif
+	}
 
 early_wakeup:
 	return;
@@ -322,9 +347,9 @@ static struct syscore_ops exynos_pm_syscore_ops = {
 	.resume		= exynos_pm_resume,
 };
 
-static __init int exynos4_pm_syscore_init(void)
+static __init int exynos_pm_syscore_init(void)
 {
 	register_syscore_ops(&exynos_pm_syscore_ops);
 	return 0;
 }
-arch_initcall(exynos4_pm_syscore_init);
+arch_initcall(exynos_pm_syscore_init);
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 5c7eb15..51aa1ec 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -309,10 +309,69 @@ static struct exynos4_pmu_conf exynos5250_pmu_config[] = {
 	{ PMU_TABLE_END,},
 };
 
+void __iomem *exynos5_list_both_cnt_feed[] = {
+	EXYNOS5_ARM_CORE0_OPTION,
+	EXYNOS5_ARM_CORE1_OPTION,
+	EXYNOS5_ARM_COMMON_OPTION,
+	EXYNOS5_GSCL_OPTION,
+	EXYNOS5_ISP_OPTION,
+	EXYNOS5_MFC_OPTION,
+	EXYNOS5_G3D_OPTION,
+	EXYNOS5_DISP1_OPTION,
+	EXYNOS5_MAU_OPTION,
+	EXYNOS5_GPS_OPTION,
+	EXYNOS5_TOP_PWR_OPTION,
+	EXYNOS5_TOP_PWR_SYSMEM_OPTION,
+};
+
+void __iomem *exynos5_list_diable_wfi_wfe[] = {
+	EXYNOS5_ARM_CORE1_OPTION,
+	EXYNOS5_FSYS_ARM_OPTION,
+	EXYNOS5_ISP_ARM_OPTION,
+};
+
+static void exynos5_init_pmu(void)
+{
+	unsigned int i;
+	unsigned int tmp;
+
+	/*
+	 * Enable both SC_FEEDBACK and SC_COUNTER
+	 */
+	for (i = 0 ; i < ARRAY_SIZE(exynos5_list_both_cnt_feed) ; i++) {
+		tmp = __raw_readl(exynos5_list_both_cnt_feed[i]);
+		tmp |= (EXYNOS5_USE_SC_FEEDBACK |
+			EXYNOS5_USE_SC_COUNTER);
+		__raw_writel(tmp, exynos5_list_both_cnt_feed[i]);
+	}
+
+	/*
+	 * SKIP_DEACTIVATE_ACEACP_IN_PWDN_BITFIELD Enable
+	 * MANUAL_L2RSTDISABLE_CONTROL_BITFIELD Enable
+	 */
+	tmp = __raw_readl(EXYNOS5_ARM_COMMON_OPTION);
+	tmp |= (EXYNOS5_MANUAL_L2RSTDISABLE_CONTROL |
+		EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN);
+	__raw_writel(tmp, EXYNOS5_ARM_COMMON_OPTION);
+
+	/*
+	 * Disable WFI/WFE on XXX_OPTION
+	 */
+	for (i = 0 ; i < ARRAY_SIZE(exynos5_list_diable_wfi_wfe) ; i++) {
+		tmp = __raw_readl(exynos5_list_diable_wfi_wfe[i]);
+		tmp &= ~(EXYNOS5_OPTION_USE_STANDBYWFE |
+			 EXYNOS5_OPTION_USE_STANDBYWFI);
+		__raw_writel(tmp, exynos5_list_diable_wfi_wfe[i]);
+	}
+}
+
 void exynos4_sys_powerdown_conf(enum sys_powerdown mode)
 {
 	unsigned int i;
 
+	if (soc_is_exynos5250())
+		exynos5_init_pmu();
+
 	for (i = 0; (exynos4_pmu_config[i].reg != PMU_TABLE_END) ; i++)
 		__raw_writel(exynos4_pmu_config[i].val[mode],
 				exynos4_pmu_config[i].reg);
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 787ceac..747c27d 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -203,6 +203,7 @@ extern struct bus_type s3c6410_subsys;
 extern struct bus_type s5p64x0_subsys;
 extern struct bus_type s5pv210_subsys;
 extern struct bus_type exynos4_subsys;
+extern struct bus_type exynos5_subsys;
 
 extern void (*s5pc1xx_idle)(void);
 
-- 
1.7.4.4
