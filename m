From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 5 Dec 2012 18:01:52 +0800
Subject: [PATCH V2 5/6] ARM: tegra20: cpuidle: add powered-down state for CPU0
In-Reply-To: <1354701715-24150-1-git-send-email-josephl@nvidia.com>
References: <1354701715-24150-1-git-send-email-josephl@nvidia.com>
Message-ID: <1354701715-24150-6-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
V2:
* refine the cpu control function that dedicate for CPU_1
* rename "tegra_cpu_pllp" to "tegra_switch_cpu_to_pllp"
---
 arch/arm/mach-tegra/cpuidle-tegra20.c |  103 +++++++++++++++++++++++++++++++-
 arch/arm/mach-tegra/sleep-tegra20.S   |   53 +++++++++++++++++
 arch/arm/mach-tegra/sleep.S           |   19 ++++++
 arch/arm/mach-tegra/sleep.h           |    3 +
 4 files changed, 174 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 9d59a46..a83a53b 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -32,6 +32,9 @@
 
 #include "pm.h"
 #include "sleep.h"
+#include "iomap.h"
+#include "tegra_cpu_car.h"
+#include "flowctrl.h"
 
 #ifdef CONFIG_PM_SLEEP
 static int tegra20_idle_lp2(struct cpuidle_device *dev,
@@ -68,6 +71,88 @@ static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
 
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
+static void tegra20_wake_reset_cpu_1(void)
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
+	tegra20_wake_reset_cpu_1();
+	return -EBUSY;
+}
+#else
+static inline void tegra20_wake_reset_cpu_1(void)
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
+		tegra20_wake_reset_cpu_1();
+
+	return true;
+}
+
+#ifdef CONFIG_SMP
 static bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
 					 struct cpuidle_driver *drv,
 					 int index)
@@ -99,16 +184,22 @@ static int __cpuinit tegra20_idle_lp2(struct cpuidle_device *dev,
 {
 	u32 cpu = is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;
 	bool entered_lp2 = false;
+	bool last_cpu;
 
 	local_fiq_disable();
 
-	tegra_set_cpu_in_lp2(cpu);
+	last_cpu =  tegra_set_cpu_in_lp2(cpu);
 	cpu_pm_enter();
 
-	if (cpu == 0)
-		cpu_do_idle();
-	else
+	if (cpu == 0) {
+		if (last_cpu)
+			entered_lp2 = tegra20_cpu_cluster_power_down(dev, drv,
+								     index);
+		else
+			cpu_do_idle();
+	} else {
 		entered_lp2 = tegra20_idle_enter_lp2_cpu_1(dev, drv, index);
+	}
 
 	cpu_pm_exit();
 	tegra_clear_cpu_in_lp2(cpu);
@@ -128,6 +219,10 @@ int __init tegra20_cpuidle_init(void)
 	struct cpuidle_device *dev;
 	struct cpuidle_driver *drv = &tegra_idle_driver;
 
+#ifdef CONFIG_PM_SLEEP
+	tegra_tear_down_cpu = tegra20_tear_down_cpu;
+#endif
+
 	ret = cpuidle_register_driver(&tegra_idle_driver);
 	if (ret) {
 		pr_err("CPUidle driver registration failed\n");
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index dfb2be5..0175ac4 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -60,6 +60,9 @@ ENDPROC(tegra20_hotplug_shutdown)
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
@@ -222,4 +240,39 @@ ENTRY(tegra20_sleep_cpu_secondary_finish)
 	mov     sp, r2			@ sp is stored in r2 by __cpu_suspend
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
index 26afa7c..bbda6e9 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -34,6 +34,9 @@
 #include "flowctrl.h"
 #include "sleep.h"
 
+#define CLK_RESET_CCLK_BURST	0x20
+#define CLK_RESET_CCLK_DIVIDER  0x24
+
 #ifdef CONFIG_PM_SLEEP
 /*
  * tegra_disable_clean_inv_dcache
@@ -108,4 +111,20 @@ ENTRY(tegra_shut_off_mmu)
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
index a02f71a..4d2b173 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -130,6 +130,8 @@ static inline void tegra20_hotplug_init(void) {}
 static inline void tegra30_hotplug_init(void) {}
 #endif
 
+void tegra20_cpu_shutdown(int cpu);
+int tegra20_cpu_is_resettable_soon(void);
 void tegra20_cpu_clear_resettable(void);
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 void tegra20_cpu_set_resettable_soon(void);
@@ -138,6 +140,7 @@ static inline void tegra20_cpu_set_resettable_soon(void) {}
 #endif
 
 int tegra20_sleep_cpu_secondary_finish(unsigned long);
+void tegra20_tear_down_cpu(void);
 int tegra30_sleep_cpu_secondary_finish(unsigned long);
 void tegra30_tear_down_cpu(void);
 
-- 
1.7.0.4
