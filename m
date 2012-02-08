From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Feb 2012 00:30:59 +0000
Subject: [PATCH v6 15/15] ARM: hotplug: add cpu_lowpower as an alternative to
 cpu_die
In-Reply-To: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1328661059-24584-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most platforms don't actually implement cpu_die, but instead
a "go into low power mode" operation.

Factor these similar implementations into a single one called
from platform_cpu_die().

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Colin Cross <ccross@android.com>
Cc: David Brown <davidb@codeaurora.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/soc.h               |    1 +
 arch/arm/kernel/smp.c                    |   16 ++++++++-
 arch/arm/mach-exynos/common.h            |    2 +-
 arch/arm/mach-exynos/hotplug.c           |   27 +--------------
 arch/arm/mach-exynos/platsmp.c           |    2 +-
 arch/arm/mach-msm/core.h                 |    2 +-
 arch/arm/mach-msm/hotplug.c              |   22 +-----------
 arch/arm/mach-msm/platsmp.c              |    2 +-
 arch/arm/mach-realview/core.h            |    2 +-
 arch/arm/mach-realview/hotplug.c         |   27 +--------------
 arch/arm/mach-realview/platsmp.c         |    2 +-
 arch/arm/mach-tegra/common.h             |    2 +-
 arch/arm/mach-tegra/hotplug.c            |   53 ++++--------------------------
 arch/arm/mach-tegra/platsmp.c            |    2 +-
 arch/arm/mach-ux500/hotplug.c            |   14 +-------
 arch/arm/mach-ux500/include/mach/setup.h |    2 +-
 arch/arm/mach-ux500/platsmp.c            |    2 +-
 arch/arm/mach-vexpress/core.h            |    2 +-
 arch/arm/mach-vexpress/hotplug.c         |   27 +--------------
 arch/arm/mach-vexpress/platsmp.c         |    2 +-
 20 files changed, 44 insertions(+), 167 deletions(-)

diff --git a/arch/arm/include/asm/soc.h b/arch/arm/include/asm/soc.h
index 1bcc58c..f1b6c45 100644
--- a/arch/arm/include/asm/soc.h
+++ b/arch/arm/include/asm/soc.h
@@ -38,6 +38,7 @@ struct arm_soc_smp_ops {
 #ifdef CONFIG_HOTPLUG_CPU
 	int  (*cpu_kill)(unsigned int cpu);
 	void (*cpu_die)(unsigned int cpu);
+	void (*cpu_lowpower)(unsigned int cpu, int *spurious);
 	int  (*cpu_disable)(unsigned int cpu);
 #endif
 };
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index e0d1622..34318aa 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -202,8 +202,20 @@ static int __cpuinit platform_cpu_kill(unsigned int cpu)
 
 static void __cpuinit platform_cpu_die(unsigned int cpu)
 {
-	if (soc_smp_ops && soc_smp_ops->cpu_die)
-		soc_smp_ops->cpu_die(cpu);
+	if (soc_smp_ops) {
+		if (soc_smp_ops->cpu_die) {
+			soc_smp_ops->cpu_die(cpu);
+			return;
+		}
+
+		if (soc_smp_ops->cpu_lowpower) {
+			int spurious = 0;
+			soc_smp_ops->cpu_lowpower(cpu, &spurious);
+			if (spurious)
+				pr_warn("CPU%u: %u spurious wakeup calls\n",
+					cpu, spurious);
+		}
+	}
 }
 
 static int __cpuinit platform_cpu_disable(unsigned int cpu)
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index f13631a..d664f6e 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -31,7 +31,7 @@ extern struct arm_soc_smp_init_ops	exynos4_soc_smp_init_ops;
 extern struct arm_soc_smp_ops		exynos4_soc_smp_ops;
 extern struct arm_soc_desc		exynos4_soc_desc;
 
-extern void exynos4_cpu_die(unsigned int cpu);
+extern void exynos4_cpu_lowpower(unsigned int cpu, int *spurious);
 
 #ifdef CONFIG_ARCH_EXYNOS
 extern  int exynos_init(void);
diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index be7a96b..aed75cb 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -62,8 +62,9 @@ static inline void cpu_leave_lowpower(void)
 	  : "cc");
 }
 
-static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
+void exynos4_cpu_lowpower(unsigned int cpu, int *spurious)
 {
+	cpu_enter_lowpower();
 	for (;;) {
 
 		/* make cpu1 to be turned off at next WFI command */
@@ -94,29 +95,5 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 		 */
 		(*spurious)++;
 	}
-}
-
-/*
- * platform-specific code to shutdown a CPU
- *
- * Called with IRQs disabled
- */
-void exynos4_cpu_die(unsigned int cpu)
-{
-	int spurious = 0;
-
-	/*
-	 * we're ready for shutdown now, so do it
-	 */
-	cpu_enter_lowpower();
-	platform_do_lowpower(cpu, &spurious);
-
-	/*
-	 * bring this CPU back into the world of cache
-	 * coherency, and then restore interrupts
-	 */
 	cpu_leave_lowpower();
-
-	if (spurious)
-		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
 }
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 4d22c2a..8469ac8 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -208,7 +208,7 @@ struct arm_soc_smp_ops exynos4_soc_smp_ops __initdata = {
 	.smp_boot_secondary	= exynos4_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= dummy_cpu_kill,
-	.cpu_die		= exynos4_cpu_die,
+	.cpu_lowpower		= exynos4_cpu_lowpower,
 	.cpu_disable		= dummy_cpu_disable,
 #endif
 };
diff --git a/arch/arm/mach-msm/core.h b/arch/arm/mach-msm/core.h
index 623474a..a5c50c4 100644
--- a/arch/arm/mach-msm/core.h
+++ b/arch/arm/mach-msm/core.h
@@ -4,4 +4,4 @@ extern struct arm_soc_smp_init_ops	msm_soc_smp_init_ops;
 extern struct arm_soc_smp_ops		msm_soc_smp_ops;
 extern struct arm_soc_desc		msm_soc_desc;
 
-extern void msm_cpu_die(unsigned int cpu);
+extern void msm_cpu_lowpower(unsigned int cpu, int *spurious);
diff --git a/arch/arm/mach-msm/hotplug.c b/arch/arm/mach-msm/hotplug.c
index d0f79e8..6e6ed2d 100644
--- a/arch/arm/mach-msm/hotplug.c
+++ b/arch/arm/mach-msm/hotplug.c
@@ -28,9 +28,10 @@ static inline void cpu_leave_lowpower(void)
 {
 }
 
-static inline void platform_do_lowpower(unsigned int cpu)
+void msm_cpu_lowpower(unsigned int cpu, int *spurious)
 {
 	/* Just enter wfi for now. TODO: Properly shut off the cpu. */
+	cpu_enter_lowpower();
 	for (;;) {
 		/*
 		 * here's the WFI
@@ -57,24 +58,5 @@ static inline void platform_do_lowpower(unsigned int cpu)
 		 */
 		pr_debug("CPU%u: spurious wakeup call\n", cpu);
 	}
-}
-
-/*
- * platform-specific code to shutdown a CPU
- *
- * Called with IRQs disabled
- */
-void msm_cpu_die(unsigned int cpu)
-{
-	/*
-	 * we're ready for shutdown now, so do it
-	 */
-	cpu_enter_lowpower();
-	platform_do_lowpower(cpu);
-
-	/*
-	 * bring this CPU back into the world of cache
-	 * coherency, and then restore interrupts
-	 */
 	cpu_leave_lowpower();
 }
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index f7e27d9..5e153cf 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -184,7 +184,7 @@ struct arm_soc_smp_ops msm_soc_smp_ops __initdata = {
 	.smp_boot_secondary	= msm_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= dummy_cpu_kill,
-	.cpu_die		= msm_cpu_die,
+	.cpu_lowpower		= msm_cpu_lowpower,
 	.cpu_disable		= dummy_cpu_disable,
 #endif
 };
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index dd4bcdb..b593b36 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -71,6 +71,6 @@ extern struct arm_soc_desc		realview_soc_desc;
 extern struct arm_soc_smp_init_ops	realview_soc_smp_init_ops;
 extern struct arm_soc_smp_ops		realview_soc_smp_ops;
 
-extern void realview_cpu_die(unsigned int cpu);
+extern void realview_cpu_lowpower(unsigned int cpu, int *spurious);
 
 #endif
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index 12af634..4d45d07 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -54,13 +54,14 @@ static inline void cpu_leave_lowpower(void)
 	  : "cc");
 }
 
-static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
+void realview_cpu_lowpower(unsigned int cpu, int *spurious)
 {
 	/*
 	 * there is no power-control hardware on this platform, so all
 	 * we can do is put the core into WFI; this is safe as the calling
 	 * code will have already disabled interrupts
 	 */
+	cpu_enter_lowpower();
 	for (;;) {
 		/*
 		 * here's the WFI
@@ -86,29 +87,5 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 		 */
 		(*spurious)++;
 	}
-}
-
-/*
- * platform-specific code to shutdown a CPU
- *
- * Called with IRQs disabled
- */
-void realview_cpu_die(unsigned int cpu)
-{
-	int spurious = 0;
-
-	/*
-	 * we're ready for shutdown now, so do it
-	 */
-	cpu_enter_lowpower();
-	platform_do_lowpower(cpu, &spurious);
-
-	/*
-	 * bring this CPU back into the world of cache
-	 * coherency, and then restore interrupts
-	 */
 	cpu_leave_lowpower();
-
-	if (spurious)
-		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
 }
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 5b7535d..eb6b532 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -90,7 +90,7 @@ struct arm_soc_smp_ops realview_soc_smp_ops __initdata = {
 	.smp_boot_secondary	= versatile_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= dummy_cpu_kill,
-	.cpu_die		= realview_cpu_die,
+	.cpu_lowpower		= realview_cpu_lowpower,
 	.cpu_disable		= dummy_cpu_disable,
 #endif
 };
diff --git a/arch/arm/mach-tegra/common.h b/arch/arm/mach-tegra/common.h
index b02cc87..38b9ea4 100644
--- a/arch/arm/mach-tegra/common.h
+++ b/arch/arm/mach-tegra/common.h
@@ -6,4 +6,4 @@ struct arm_soc_smp_ops;
 extern struct arm_soc_smp_init_ops	tegra_soc_smp_init_ops;
 extern struct arm_soc_smp_ops		tegra_soc_smp_ops;
 
-extern void tegra_cpu_die(unsigned int cpu);
+extern void tegra_cpu_lowpower(unsigned int cpu, int *spurious);
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index 15433b2..455a077 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -52,61 +52,22 @@ static inline void cpu_leave_lowpower(void)
 	  : "cc");
 }
 
-static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
+void tegra_cpu_lowpower(unsigned int cpu, int *spurious)
 {
 	/*
 	 * there is no power-control hardware on this platform, so all
 	 * we can do is put the core into WFI; this is safe as the calling
 	 * code will have already disabled interrupts
 	 */
-	for (;;) {
-		/*
-		 * here's the WFI
-		 */
-		asm(".word	0xe320f003\n"
-		    :
-		    :
-		    : "memory", "cc");
-
-		/*if (pen_release == cpu) {*/
-			/*
-			 * OK, proper wakeup, we're done
-			 */
-			break;
-		/*}*/
-
-		/*
-		 * Getting here, means that we have come out of WFI without
-		 * having been woken up - this shouldn't happen
-		 *
-		 * Just note it happening - when we're woken, we can report
-		 * its occurrence.
-		 */
-		(*spurious)++;
-	}
-}
-
-/*
- * platform-specific code to shutdown a CPU
- *
- * Called with IRQs disabled
- */
-void tegra_cpu_die(unsigned int cpu)
-{
-	int spurious = 0;
-
-	/*
-	 * we're ready for shutdown now, so do it
-	 */
 	cpu_enter_lowpower();
-	platform_do_lowpower(cpu, &spurious);
 
 	/*
-	 * bring this CPU back into the world of cache
-	 * coherency, and then restore interrupts
+	 * here's the WFI
 	 */
-	cpu_leave_lowpower();
+	asm("wfi\n"
+	    :
+	    :
+	    : "memory", "cc");
 
-	if (spurious)
-		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
+	cpu_leave_lowpower();
 }
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 4edc8ab..5d1593c 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -146,7 +146,7 @@ struct arm_soc_smp_ops tegra_soc_smp_ops __initdata = {
 	.smp_boot_secondary	= tegra_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= dummy_cpu_kill,
-	.cpu_die		= tegra_cpu_die,
+	.cpu_lowpower		= tegra_cpu_lowpower,
 	.cpu_disable		= dummy_cpu_disable,
 #endif
 };
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
index ec1c77f..c46b01d 100644
--- a/arch/arm/mach-ux500/hotplug.c
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -19,7 +19,7 @@
 
 extern volatile int pen_release;
 
-static inline void platform_do_lowpower(unsigned int cpu)
+void ux500_cpu_lowpower(unsigned int cpu, int *spurious)
 {
 	flush_cache_all();
 
@@ -33,16 +33,6 @@ static inline void platform_do_lowpower(unsigned int cpu)
 			 */
 			break;
 		}
+		(*spurious)++;
 	}
 }
-
-/*
- * platform-specific code to shutdown a CPU
- *
- * Called with IRQs disabled
- */
-void ux500_cpu_die(unsigned int cpu)
-{
-	/* directly enter low power state, skipping secure registers */
-	platform_do_lowpower(cpu);
-}
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index 2935f85..127fd0b 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -55,6 +55,6 @@ extern struct arm_soc_smp_init_ops ux500_soc_smp_init_ops;
 extern struct arm_soc_smp_ops ux500_soc_smp_ops;
 extern struct arm_soc_desc ux500_soc_desc;
 
-extern void ux500_cpu_die(unsigned int cpu);
+extern void ux500_cpu_lowpower(unsigned int cpu, int *spurious)l
 
 #endif /*  __ASM_ARCH_SETUP_H */
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index bbd6480..f19ba4e 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -186,7 +186,7 @@ struct arm_soc_smp_ops ux500_soc_smp_ops __initdata = {
 	.smp_boot_secondary	= ux500_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= dummy_cpu_kill,
-	.cpu_die		= ux500_cpu_die,
+	.cpu_lowpower		= ux500_cpu_lowpower,
 	.cpu_disable		= dummy_cpu_disable,
 #endif
 };
diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index d9b1ec0..413e889 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -24,4 +24,4 @@ struct arm_soc_smp_ops;
 extern struct arm_soc_smp_init_ops	vexpress_soc_smp_init_ops;
 extern struct arm_soc_smp_ops		vexpress_soc_smp_ops;
 
-extern void vexpress_cpu_die(unsigned int cpu);
+extern void vexpress_cpu_lowpower(unsigned int cpu, int *spurious)
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
index e1a7fef..4c87adc 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -56,13 +56,14 @@ static inline void cpu_leave_lowpower(void)
 	  : "cc");
 }
 
-static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
+void vexpress_cpu_lowpower(unsigned int cpu, int *spurious)
 {
 	/*
 	 * there is no power-control hardware on this platform, so all
 	 * we can do is put the core into WFI; this is safe as the calling
 	 * code will have already disabled interrupts
 	 */
+	cpu_enter_lowpower();
 	for (;;) {
 		wfi();
 
@@ -82,29 +83,5 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 		 */
 		(*spurious)++;
 	}
-}
-
-/*
- * platform-specific code to shutdown a CPU
- *
- * Called with IRQs disabled
- */
-void vexpress_cpu_die(unsigned int cpu)
-{
-	int spurious = 0;
-
-	/*
-	 * we're ready for shutdown now, so do it
-	 */
-	cpu_enter_lowpower();
-	platform_do_lowpower(cpu, &spurious);
-
-	/*
-	 * bring this CPU back into the world of cache
-	 * coherency, and then restore interrupts
-	 */
 	cpu_leave_lowpower();
-
-	if (spurious)
-		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
 }
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index a5196f87..5630d2b 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -61,7 +61,7 @@ struct arm_soc_smp_ops vexpress_soc_smp_ops __initdata = {
 	.smp_boot_secondary	= versatile_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= dummy_cpu_kill,
-	.cpu_die		= vexpress_cpu_die,
+	.cpu_lowpower		= vexpress_cpu_lowpower,
 	.cpu_disable		= dummy_cpu_disable,
 #endif
 };
-- 
1.7.3.4
