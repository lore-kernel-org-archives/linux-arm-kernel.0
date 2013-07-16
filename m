From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 16:17:21 -0600
Subject: [PATCH 2/4] ARM: tegra: remove use of CONFIG_ARCH_TEGRA_*_SOC
In-Reply-To: <1374013043-4693-1-git-send-email-swarren@wwwdotorg.org>
References: <1374013043-4693-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1374013043-4693-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Modify code in mach-tegra not to use ARCH_TEGRA_*_SOC, but just
ARCH_TEGRA. This simplifies various conditional logic.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig         |  2 +-
 arch/arm/mach-tegra/Makefile        | 30 ++++++++++++------------------
 arch/arm/mach-tegra/board.h         |  2 +-
 arch/arm/mach-tegra/cpuidle.c       |  9 +++------
 arch/arm/mach-tegra/fuse.h          | 14 --------------
 arch/arm/mach-tegra/hotplug.c       | 11 ++++++++---
 arch/arm/mach-tegra/platsmp.c       | 12 +++++++-----
 arch/arm/mach-tegra/pm.c            |  6 ++----
 arch/arm/mach-tegra/reset-handler.S | 16 ++--------------
 arch/arm/mach-tegra/sleep.h         |  6 ------
 arch/arm/mach-tegra/tegra.c         |  3 +--
 11 files changed, 37 insertions(+), 74 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 44cb28c..9a4ec62 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -54,7 +54,7 @@ config ARCH_TEGRA_114_SOC
 
 config TEGRA_PCI
 	bool "PCI Express support"
-	depends on ARCH_TEGRA_2x_SOC
+	depends on ARCH_TEGRA
 	select PCI
 
 config TEGRA_AHB
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 98b184e..efb1e01 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -14,27 +14,21 @@ obj-y					+= reset-handler.o
 obj-y					+= sleep.o
 obj-y					+= tegra.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra20_speedo.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-tegra20.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= cpuidle-tegra20.o
-endif
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_speedo.o
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-tegra30.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= cpuidle-tegra30.o
-endif
+obj-y					+= tegra20_speedo.o
+obj-y					+= tegra2_emc.o
+obj-y					+= sleep-tegra20.o
+obj-$(CONFIG_CPU_IDLE)			+= cpuidle-tegra20.o
+obj-y					+= tegra30_speedo.o
+obj-y					+= sleep-tegra30.o
+obj-$(CONFIG_CPU_IDLE)			+= cpuidle-tegra30.o
 obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
 
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= tegra114_speedo.o
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= sleep-tegra30.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= cpuidle-tegra114.o
-endif
+obj-y					+= tegra114_speedo.o
+obj-y					+= sleep-tegra30.o
+obj-$(CONFIG_CPU_IDLE)			+= cpuidle-tegra114.o
 
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-harmony-pcie.o
+obj-y		+= board-harmony-pcie.o
 
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-paz00.o
+obj-y		+= board-paz00.o
diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index 9a6659f..e86604f 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -42,7 +42,7 @@ static inline int tegra_clk_debugfs_init(void) { return 0; }
 #endif
 
 int __init tegra_powergate_init(void);
-#if defined(CONFIG_ARCH_TEGRA_2x_SOC) && defined(CONFIG_DEBUG_FS)
+#if defined(CONFIG_DEBUG_FS)
 int __init tegra_powergate_debugfs_init(void);
 #else
 static inline int tegra_powergate_debugfs_init(void) { return 0; }
diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
index e85973c..44bad5d 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -31,16 +31,13 @@ void __init tegra_cpuidle_init(void)
 {
 	switch (tegra_chip_id) {
 	case TEGRA20:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
-			tegra20_cpuidle_init();
+		tegra20_cpuidle_init();
 		break;
 	case TEGRA30:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
-			tegra30_cpuidle_init();
+		tegra30_cpuidle_init();
 		break;
 	case TEGRA114:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC))
-			tegra114_cpuidle_init();
+		tegra114_cpuidle_init();
 		break;
 	}
 }
diff --git a/arch/arm/mach-tegra/fuse.h b/arch/arm/mach-tegra/fuse.h
index def7968..e589322 100644
--- a/arch/arm/mach-tegra/fuse.h
+++ b/arch/arm/mach-tegra/fuse.h
@@ -56,23 +56,9 @@ void tegra_init_fuse(void);
 bool tegra_spare_fuse(int bit);
 u32 tegra_fuse_readl(unsigned long offset);
 
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
 void tegra20_init_speedo_data(void);
-#else
-static inline void tegra20_init_speedo_data(void) {}
-#endif
-
-#ifdef CONFIG_ARCH_TEGRA_3x_SOC
 void tegra30_init_speedo_data(void);
-#else
-static inline void tegra30_init_speedo_data(void) {}
-#endif
-
-#ifdef CONFIG_ARCH_TEGRA_114_SOC
 void tegra114_init_speedo_data(void);
-#else
-static inline void tegra114_init_speedo_data(void) {}
-#endif
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index a52c10e..8b79d83 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -62,10 +62,15 @@ void __init tegra_hotplug_init(void)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return;
 
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) && tegra_chip_id == TEGRA20)
+	switch (tegra_chip_id) {
+	case TEGRA20:
 		tegra_hotplug_shutdown = tegra20_hotplug_shutdown;
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) && tegra_chip_id == TEGRA30)
+		break;
+	case TEGRA30:
 		tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) && tegra_chip_id == TEGRA114)
+		break;
+	case TEGRA114:
 		tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
+		break;
+	}
 }
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 97b33a2..b76a5d8 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -170,14 +170,16 @@ static int tegra114_boot_secondary(unsigned int cpu, struct task_struct *idle)
 static int tegra_boot_secondary(unsigned int cpu,
 					  struct task_struct *idle)
 {
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) && tegra_chip_id == TEGRA20)
+	switch (tegra_chip_id) {
+	case TEGRA20:
 		return tegra20_boot_secondary(cpu, idle);
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) && tegra_chip_id == TEGRA30)
+	case TEGRA30:
 		return tegra30_boot_secondary(cpu, idle);
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) && tegra_chip_id == TEGRA114)
+	case TEGRA114:
 		return tegra114_boot_secondary(cpu, idle);
-
-	return -EINVAL;
+	default:
+		return -EINVAL;
+	}
 }
 
 static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 261fec1..cae6894 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -48,12 +48,10 @@ static void tegra_tear_down_cpu_init(void)
 {
 	switch (tegra_chip_id) {
 	case TEGRA20:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
-			tegra_tear_down_cpu = tegra20_tear_down_cpu;
+		tegra_tear_down_cpu = tegra20_tear_down_cpu;
 		break;
 	case TEGRA30:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
-			tegra_tear_down_cpu = tegra30_tear_down_cpu;
+		tegra_tear_down_cpu = tegra30_tear_down_cpu;
 		break;
 	}
 }
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 39dc9e78..57fafb7 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -123,10 +123,9 @@ ENTRY(__tegra_cpu_reset_handler)
 	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
 
 	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
 t20_check:
 	cmp	r6, #TEGRA20
-	bne	after_t20_check
+	bne	t30_check
 t20_errata:
 	# Tegra20 is a Cortex-A9 r1p1
 	mrc	p15, 0, r0, c1, c0, 0   @ read system control register
@@ -137,12 +136,9 @@ t20_errata:
 	orr	r0, r0, #1 << 11        @ erratum 751472
 	mcr	p15, 0, r0, c15, c0, 1  @ write diagnostic register
 	b	after_errata
-after_t20_check:
-#endif
-#ifdef CONFIG_ARCH_TEGRA_3x_SOC
 t30_check:
 	cmp	r6, #TEGRA30
-	bne	after_t30_check
+	bne	after_errata
 t30_errata:
 	# Tegra30 is a Cortex-A9 r2p9
 	mrc	p15, 0, r0, c15, c0, 1  @ read diagnostic register
@@ -150,8 +146,6 @@ t30_errata:
 	orr	r0, r0, #1 << 11        @ erratum 751472
 	mcr	p15, 0, r0, c15, c0, 1  @ write diagnostic register
 	b	after_errata
-after_t30_check:
-#endif
 after_errata:
 	mrc	p15, 0, r10, c0, c0, 5		@ MPIDR
 	and	r10, r10, #0x3			@ R10 = CPU number
@@ -166,7 +160,6 @@ after_errata:
 	bleq	__die				@ CPU not present (to OS)
 #endif
 
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
 	/* Are we on Tegra20? */
 	cmp	r6, #TEGRA20
 	bne	1f
@@ -176,7 +169,6 @@ after_errata:
 	cmp	r10, #0
 	strne	r0, [r5, #PMC_SCRATCH41]
 1:
-#endif
 
 	/* Waking up from LP2? */
 	ldr	r9, [r12, #RESET_DATA(MASK_LP2)]
@@ -221,13 +213,10 @@ __die:
 	cmp	r6, #TEGRA20
 	bne	1f
 
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
 	mov32	r0, 0x1111
 	mov	r1, r0, lsl r10
 	str	r1, [r7, #0x340]		@ CLK_RST_CPU_CMPLX_SET
-#endif
 1:
-#ifdef CONFIG_ARCH_TEGRA_3x_SOC
 	mov32	r6, TEGRA_FLOW_CTRL_BASE
 
 	cmp	r10, #0
@@ -257,7 +246,6 @@ __die:
 
 	mov	r0, r11, lsl #8
 	str	r0, [r7, #348]			@ CLK_CPU_CMPLX_SET
-#endif
 
 	/* If the CPU still isn't dead, just spin here. */
 	b	.
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 98b7da6..461ff1b 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -35,11 +35,9 @@
 #define PMC_SCRATCH39	0x138
 #define PMC_SCRATCH41	0x140
 
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
 #define CPU_RESETTABLE		2
 #define CPU_RESETTABLE_SOON	1
 #define CPU_NOT_RESETTABLE	0
-#endif
 
 #ifdef __ASSEMBLY__
 /* returns the offset of the flow controller halt register for a cpu */
@@ -157,11 +155,7 @@ static inline void tegra_hotplug_init(void) {}
 void tegra20_cpu_shutdown(int cpu);
 int tegra20_cpu_is_resettable_soon(void);
 void tegra20_cpu_clear_resettable(void);
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
 void tegra20_cpu_set_resettable_soon(void);
-#else
-static inline void tegra20_cpu_set_resettable_soon(void) {}
-#endif
 
 int tegra20_sleep_cpu_secondary_finish(unsigned long);
 void tegra20_tear_down_cpu(void);
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index fc97cfd..5334252 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -104,8 +104,7 @@ static void __init harmony_init(void)
 
 static void __init paz00_init(void)
 {
-	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
-		tegra_paz00_wifikill_init();
+	tegra_paz00_wifikill_init();
 }
 
 static struct {
-- 
1.8.1.5
