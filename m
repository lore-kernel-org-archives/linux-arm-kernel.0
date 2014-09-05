From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 05 Sep 2014 14:34:55 +0200
Subject: [PATCH v5 RESEND 3/3] ARM: exynos4: hotplug: Fix CPU idle clock down
 after CPU off
In-Reply-To: <1409920495-16533-1-git-send-email-k.kozlowski@samsung.com>
References: <1409920495-16533-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1409920495-16533-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Exynos4 USE_DELAYED_RESET_ASSERTION must be set in
ARM_COREx_OPTION register during CPU power down. This is the proper way
of powering down CPU on Exynos4.

Additionally on Exynos4212 without this the CPU clock down feature won't
work after powering down some CPU and the online CPUs will work at full
frequency chosen by CPUfreq governor.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>

---
Changes since v4:
1. Rebase on linux-next-20140804.
2. Add Reviewed-by Tomasz Figa.

Changes since v3:
1. Add patches moving hotplug code to platsmp.c file (patches 1 and 2).
   Suggested by Tomasz Figa.
2. Remove declaration of exynos_clear_delayed_reset_assertion() in
   header because hotplug code is integrated into platsmp.c file.
   Suggested by Tomasz Figa.
3. Replace 'clear' helper with 'set' helper. Suggested by Tomasz Figa.

Changes since v2:
1. Add missing disable of the "use delayed reset assertion" feature
   when starting secondary CPU (suggested by Tomasz Figa).

Changes since v1:
1. Use delayed reset assertion on all Exynos4 family and all cores, not
   only on core 1 of Exynos4212.
2. Rebase on Tomasz Figa's patch:
   ARM: EXYNOS: Fix core ID used by platsmp and hotplug code
   http://www.spinics.net/lists/linux-samsung-soc/msg31604.html
   Tomasz's patch is currently applied to Kukjin's v3.16-samsung-fixes-4
---
 arch/arm/mach-exynos/platsmp.c  | 43 +++++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-exynos/regs-pmu.h |  3 +++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 83b20a38a598..99c151bf30ad 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -34,8 +34,32 @@
 
 extern void exynos4_secondary_startup(void);
 
+/*
+ * Set or clear the USE_DELAYED_RESET_ASSERTION option, set on Exynos4 SoCs
+ * during hot-(un)plugging CPUx.
+ *
+ * The feature can be cleared safely during first boot of secondary CPU.
+ *
+ * Exynos4 SoCs require setting USE_DELAYED_RESET_ASSERTION during powering
+ * down a CPU so the CPU idle clock down feature could properly detect global
+ * idle state when CPUx is off.
+ */
+static void exynos_set_delayed_reset_assertion(u32 core_id, bool enable)
+{
+	if (soc_is_exynos4()) {
+		unsigned int tmp;
+
+		tmp = pmu_raw_readl(EXYNOS_ARM_CORE_OPTION(core_id));
+		if (enable)
+			tmp |= S5P_USE_DELAYED_RESET_ASSERTION;
+		else
+			tmp &= ~(S5P_USE_DELAYED_RESET_ASSERTION);
+		pmu_raw_writel(tmp, EXYNOS_ARM_CORE_OPTION(core_id));
+	}
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
-static inline void cpu_leave_lowpower(void)
+static inline void cpu_leave_lowpower(u32 core_id)
 {
 	unsigned int v;
 
@@ -49,6 +73,8 @@ static inline void cpu_leave_lowpower(void)
 	  : "=&r" (v)
 	  : "Ir" (CR_C), "Ir" (0x40)
 	  : "cc");
+
+	 exynos_set_delayed_reset_assertion(core_id, false);
 }
 
 static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
@@ -61,6 +87,14 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 		/* Turn the CPU off on next WFI instruction. */
 		exynos_cpu_power_down(core_id);
 
+		/*
+		 * Exynos4 SoCs require setting
+		 * USE_DELAYED_RESET_ASSERTION so the CPU idle
+		 * clock down feature could properly detect
+		 * global idle state when CPUx is off.
+		 */
+		exynos_set_delayed_reset_assertion(core_id, true);
+
 		wfi();
 
 		if (pen_release == core_id) {
@@ -286,6 +320,9 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 		udelay(10);
 	}
 
+	/* No harm if this is called during first boot of secondary CPU */
+	exynos_set_delayed_reset_assertion(core_id, false);
+
 	/*
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
@@ -376,6 +413,8 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 static void exynos_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
+	u32 mpidr = cpu_logical_map(cpu);
+	u32 core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 
 	v7_exit_coherency_flush(louis);
 
@@ -385,7 +424,7 @@ static void exynos_cpu_die(unsigned int cpu)
 	 * bring this CPU back into the world of cache
 	 * coherency, and then restore interrupts
 	 */
-	cpu_leave_lowpower();
+	cpu_leave_lowpower(core_id);
 
 	if (spurious)
 		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 96a1569262b5..4e9b4440e2bd 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -20,6 +20,7 @@
 
 #define S5P_USE_STANDBY_WFI0			(1 << 16)
 #define S5P_USE_STANDBY_WFE0			(1 << 24)
+#define S5P_USE_DELAYED_RESET_ASSERTION		BIT(12)
 
 #define EXYNOS_SWRESET				0x0400
 #define EXYNOS5440_SWRESET			0x00C4
@@ -106,6 +107,8 @@
 			(EXYNOS_ARM_CORE0_CONFIGURATION + (0x80 * (_nr)))
 #define EXYNOS_ARM_CORE_STATUS(_nr)		\
 			(EXYNOS_ARM_CORE_CONFIGURATION(_nr) + 0x4)
+#define EXYNOS_ARM_CORE_OPTION(_nr)		\
+			(EXYNOS_ARM_CORE_CONFIGURATION(_nr) + 0x8)
 
 #define EXYNOS_ARM_COMMON_CONFIGURATION		0x2500
 #define EXYNOS_COMMON_CONFIGURATION(_nr)	\
-- 
1.9.1
