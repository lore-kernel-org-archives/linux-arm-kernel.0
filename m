From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 17 Jan 2013 11:33:55 +0800
Subject: [PATCH V5 5/5] ARM: tegra20: cpuidle: apply coupled cpuidle for
 powered-down mode
Message-ID: <1358393635-30347-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "powered-down" cpuidle mode of Tegra20 needs the CPU0 be the last one
core to go into this mode before other core. The coupled cpuidle framework
can help to sync the MPCore to coupled state then go into "powered-down"
idle mode together. The driver can just assume the MPCore come into
"powered-down" mode at the same time. No need to take care if the CPU_0
goes into this mode along and only can put it into safe idle mode (WFI).

The powered-down state of Tegra20 requires power gating both CPU cores.
When the secondary CPU requests to enter powered-down state, it saves
its own contexts and then enters WFI for waiting CPU0 in the same state.
When the CPU0 requests powered-down state, it attempts to put the secondary
CPU into reset to prevent it from waking up. Then power down both CPUs
together and power off the cpu rail.

Be aware of that, you may see the legacy power state "LP2" in the code
which is exactly the same meaning of "CPU power down".

Based on the work by:
Colin Cross <ccross@android.com>
Gary King <gking@nvidia.com>

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Colin Cross <ccross@android.com>
---
V5:
* take care the comments that from Colin in the previous version
V4:
* rename the function to "tegra20_wake_cpu1_from_reset"
* make the coupled cpuidle can be disabled if SMP is disabled
V3:
* sqash last two patch in previous version to support coupled cpuidle
  directly
V2:
* refine the cpu control function that dedicate for CPU_1
* rename "tegra_cpu_pllp" to "tegra_switch_cpu_to_pllp"
---
 arch/arm/mach-tegra/Kconfig           |   1 +
 arch/arm/mach-tegra/cpuidle-tegra20.c | 125 +++++++++++++++++++++++++++++++---
 arch/arm/mach-tegra/sleep-tegra20.S   |  53 ++++++++++++++
 arch/arm/mach-tegra/sleep.S           |  19 ++++++
 arch/arm/mach-tegra/sleep.h           |   3 +
 5 files changed, 192 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 1ec7f80..abc688f 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -4,6 +4,7 @@ comment "NVIDIA Tegra options"
 
 config ARCH_TEGRA_2x_SOC
 	bool "Enable support for Tegra20 family"
+	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_742230 if SMP
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 50f984d..825ced4 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -24,6 +24,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/clockchips.h>
+#include <linux/clk/tegra.h>
 
 #include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
@@ -32,22 +33,28 @@
 
 #include "pm.h"
 #include "sleep.h"
+#include "iomap.h"
+#include "irq.h"
+#include "flowctrl.h"
 
 #ifdef CONFIG_PM_SLEEP
-static int tegra20_idle_lp2(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv,
-			    int index);
+static bool abort_flag;
+static atomic_t abort_barrier;
+static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
+				    struct cpuidle_driver *drv,
+				    int index);
 #endif
 
 static struct cpuidle_state tegra_idle_states[] = {
 	[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
 #ifdef CONFIG_PM_SLEEP
 	[1] = {
-		.enter			= tegra20_idle_lp2,
+		.enter			= tegra20_idle_lp2_coupled,
 		.exit_latency		= 5000,
 		.target_residency	= 10000,
 		.power_usage		= 0,
-		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.flags			= CPUIDLE_FLAG_TIME_VALID |
+					  CPUIDLE_FLAG_COUPLED,
 		.name			= "powered-down",
 		.desc			= "CPU power gated",
 	},
@@ -64,6 +71,88 @@ static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
 
 #ifdef CONFIG_PM_SLEEP
 #ifdef CONFIG_SMP
+static void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
+
+static int tegra20_reset_sleeping_cpu_1(void)
+{
+	int ret = 0;
+
+	tegra_pen_lock();
+
+	if (readl(pmc + PMC_SCRATCH41) == CPU_RESETTABLE)
+		tegra20_cpu_shutdown(1);
+	else
+		ret = -EINVAL;
+
+	tegra_pen_unlock();
+
+	return ret;
+}
+
+static void tegra20_wake_cpu1_from_reset(void)
+{
+	tegra_pen_lock();
+
+	tegra20_cpu_clear_resettable();
+
+	/* enable cpu clock on cpu */
+	tegra_enable_cpu_clock(1);
+
+	/* take the CPU out of reset */
+	tegra_cpu_out_of_reset(1);
+
+	/* unhalt the cpu */
+	flowctrl_write_cpu_halt(1, 0);
+
+	tegra_pen_unlock();
+}
+
+static int tegra20_reset_cpu_1(void)
+{
+	if (!cpu_online(1) || !tegra20_reset_sleeping_cpu_1())
+		return 0;
+
+	tegra20_wake_cpu1_from_reset();
+	return -EBUSY;
+}
+#else
+static inline void tegra20_wake_cpu1_from_reset(void)
+{
+}
+
+static inline int tegra20_reset_cpu_1(void)
+{
+	return 0;
+}
+#endif
+
+static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
+					   struct cpuidle_driver *drv,
+					   int index)
+{
+	struct cpuidle_state *state = &drv->states[index];
+	u32 cpu_on_time = state->exit_latency;
+	u32 cpu_off_time = state->target_residency - state->exit_latency;
+
+	while (tegra20_cpu_is_resettable_soon())
+		cpu_relax();
+
+	if (tegra20_reset_cpu_1() || !tegra_cpu_rail_off_ready())
+		return false;
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+
+	tegra_idle_lp2_last(cpu_on_time, cpu_off_time);
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+
+	if (cpu_online(1))
+		tegra20_wake_cpu1_from_reset();
+
+	return true;
+}
+
+#ifdef CONFIG_SMP
 static bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
 					 struct cpuidle_driver *drv,
 					 int index)
@@ -87,20 +176,31 @@ static inline bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
 }
 #endif
 
-static int tegra20_idle_lp2(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv,
-			    int index)
+static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
+				    struct cpuidle_driver *drv,
+				    int index)
 {
 	u32 cpu = is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;
 	bool entered_lp2 = false;
 
+	if (tegra_pending_sgi())
+		ACCESS_ONCE(abort_flag) = true;
+
+	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
+
+	if (abort_flag) {
+		cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
+		abort_flag = false;	/* clean flag for next coming */
+		return -EINTR;
+	}
+
 	local_fiq_disable();
 
 	tegra_set_cpu_in_lp2(cpu);
 	cpu_pm_enter();
 
 	if (cpu == 0)
-		cpu_do_idle();
+		entered_lp2 = tegra20_cpu_cluster_power_down(dev, drv, index);
 	else
 		entered_lp2 = tegra20_idle_enter_lp2_cpu_1(dev, drv, index);
 
@@ -122,6 +222,10 @@ int __init tegra20_cpuidle_init(void)
 	struct cpuidle_device *dev;
 	struct cpuidle_driver *drv = &tegra_idle_driver;
 
+#ifdef CONFIG_PM_SLEEP
+	tegra_tear_down_cpu = tegra20_tear_down_cpu;
+#endif
+
 	drv->state_count = ARRAY_SIZE(tegra_idle_states);
 	memcpy(drv->states, tegra_idle_states,
 			drv->state_count * sizeof(drv->states[0]));
@@ -135,6 +239,9 @@ int __init tegra20_cpuidle_init(void)
 	for_each_possible_cpu(cpu) {
 		dev = &per_cpu(tegra_idle_device, cpu);
 		dev->cpu = cpu;
+#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
+		dev->coupled_cpus = *cpu_possible_mask;
+#endif
 
 		dev->state_count = drv->state_count;
 		ret = cpuidle_register_device(dev);
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index 1074364..9f6bfaf 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -57,6 +57,9 @@ ENDPROC(tegra20_hotplug_shutdown)
 ENTRY(tegra20_cpu_shutdown)
 	cmp	r0, #0
 	moveq	pc, lr			@ must not be called for CPU 0
+	mov32	r1, TEGRA_PMC_VIRT + PMC_SCRATCH41
+	mov	r12, #CPU_RESETTABLE
+	str	r12, [r1]
 
 	cpu_to_halt_reg r1, r0
 	ldr	r3, =TEGRA_FLOW_CTRL_VIRT
@@ -163,6 +166,21 @@ ENTRY(tegra20_cpu_set_resettable_soon)
 ENDPROC(tegra20_cpu_set_resettable_soon)
 
 /*
+ * tegra20_cpu_is_resettable_soon(void)
+ *
+ * Returns true if the "resettable soon" flag in PMC_SCRATCH41 has been
+ * set because it is expected that the secondary CPU will be idle soon.
+ */
+ENTRY(tegra20_cpu_is_resettable_soon)
+	mov32	r1, TEGRA_PMC_VIRT + PMC_SCRATCH41
+	ldr	r12, [r1]
+	cmp	r12, #CPU_RESETTABLE_SOON
+	moveq	r0, #1
+	movne	r0, #0
+	mov	pc, lr
+ENDPROC(tegra20_cpu_is_resettable_soon)
+
+/*
  * tegra20_sleep_cpu_secondary_finish(unsigned long v2p)
  *
  * Enters WFI on secondary CPU by exiting coherency.
@@ -221,4 +239,39 @@ ENTRY(tegra20_sleep_cpu_secondary_finish)
 
 	ldmfd	sp!, {r4 - r11, pc}
 ENDPROC(tegra20_sleep_cpu_secondary_finish)
+
+/*
+ * tegra20_tear_down_cpu
+ *
+ * Switches the CPU cluster to PLL-P and enters sleep.
+ */
+ENTRY(tegra20_tear_down_cpu)
+	bl	tegra_switch_cpu_to_pllp
+	b	tegra20_enter_sleep
+ENDPROC(tegra20_tear_down_cpu)
+
+/*
+ * tegra20_enter_sleep
+ *
+ * uses flow controller to enter sleep state
+ * executes from IRAM with SDRAM in selfrefresh when target state is LP0 or LP1
+ * executes from SDRAM with target state is LP2
+ */
+tegra20_enter_sleep:
+	mov32   r6, TEGRA_FLOW_CTRL_BASE
+
+	mov     r0, #FLOW_CTRL_WAIT_FOR_INTERRUPT
+	orr	r0, r0, #FLOW_CTRL_HALT_CPU_IRQ | FLOW_CTRL_HALT_CPU_FIQ
+	cpu_id	r1
+	cpu_to_halt_reg r1, r1
+	str	r0, [r6, r1]
+	dsb
+	ldr	r0, [r6, r1] /* memory barrier */
+
+halted:
+	dsb
+	wfe	/* CPU should be power gated here */
+	isb
+	b	halted
+
 #endif
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index addae35..364d845 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -34,6 +34,9 @@
 #include "flowctrl.h"
 #include "sleep.h"
 
+#define CLK_RESET_CCLK_BURST	0x20
+#define CLK_RESET_CCLK_DIVIDER  0x24
+
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_PM_SLEEP)
 /*
  * tegra_disable_clean_inv_dcache
@@ -110,4 +113,20 @@ ENTRY(tegra_shut_off_mmu)
 	mov	pc, r0
 ENDPROC(tegra_shut_off_mmu)
 	.popsection
+
+/*
+ * tegra_switch_cpu_to_pllp
+ *
+ * In LP2 the normal cpu clock pllx will be turned off. Switch the CPU to pllp
+ */
+ENTRY(tegra_switch_cpu_to_pllp)
+	/* in LP2 idle (SDRAM active), set the CPU burst policy to PLLP */
+	mov32	r5, TEGRA_CLK_RESET_BASE
+	mov	r0, #(2 << 28)			@ burst policy = run mode
+	orr	r0, r0, #(4 << 4)		@ use PLLP in run mode burst
+	str	r0, [r5, #CLK_RESET_CCLK_BURST]
+	mov	r0, #0
+	str	r0, [r5, #CLK_RESET_CCLK_DIVIDER]
+	mov	pc, lr
+ENDPROC(tegra_switch_cpu_to_pllp)
 #endif
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index e39a56b..4ffae54 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -131,6 +131,8 @@ static inline void tegra20_hotplug_init(void) {}
 static inline void tegra30_hotplug_init(void) {}
 #endif
 
+void tegra20_cpu_shutdown(int cpu);
+int tegra20_cpu_is_resettable_soon(void);
 void tegra20_cpu_clear_resettable(void);
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 void tegra20_cpu_set_resettable_soon(void);
@@ -139,6 +141,7 @@ static inline void tegra20_cpu_set_resettable_soon(void) {}
 #endif
 
 int tegra20_sleep_cpu_secondary_finish(unsigned long);
+void tegra20_tear_down_cpu(void);
 int tegra30_sleep_cpu_secondary_finish(unsigned long);
 void tegra30_tear_down_cpu(void);
 
-- 
1.8.0.3
