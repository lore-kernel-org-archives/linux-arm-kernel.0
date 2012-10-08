From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 8 Oct 2012 18:26:21 +0800
Subject: [PATCH 7/7] ARM: tegra30: cpuidle: add LP2 driver for CPU0
In-Reply-To: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
Message-ID: <1349691981-31038-8-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpuidle LP2 is a power gating idle mode. It support power gating
vdd_cpu rail after all cpu cores in LP2. For Tegra30, the CPU0 must
be last one to go into LP2. We need to take care and make sure whole
secondary CPUs were in LP2 by checking CPU and power gate status.
After that, the CPU0 can go into LP2 safely. Then power gating the
CPU rail.

Base on the work by:
Scott Williams <scwilliams@nvidia.com>

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/cpuidle-tegra30.c |   39 ++++++++-
 arch/arm/mach-tegra/pm.c              |  152 +++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/pm.h              |    3 +
 arch/arm/mach-tegra/sleep-tegra30.S   |   44 ++++++++++
 arch/arm/mach-tegra/sleep.S           |   44 ++++++++++
 arch/arm/mach-tegra/sleep.h           |    2 +
 6 files changed, 280 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index 842fef4..1fd938b 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -28,6 +28,7 @@
 
 #include "pm.h"
 #include "sleep.h"
+#include "tegra_cpu_car.h"
 
 #ifdef CONFIG_PM_SLEEP
 static int tegra30_idle_lp2(struct cpuidle_device *dev,
@@ -59,6 +60,28 @@ static struct cpuidle_driver tegra_idle_driver = {
 static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
 
 #ifdef CONFIG_PM_SLEEP
+static bool tegra30_idle_enter_lp2_cpu_0(struct cpuidle_device *dev,
+					 struct cpuidle_driver *drv,
+					 int index)
+{
+	struct cpuidle_state *state = &drv->states[index];
+	u32 cpu_on_time = state->exit_latency;
+	u32 cpu_off_time = state->target_residency - state->exit_latency;
+
+	if (num_online_cpus() > 1 && !tegra_cpu_rail_off_ready()) {
+		cpu_do_idle();
+		return false;
+	}
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+
+	tegra_idle_lp2_last(cpu_on_time, cpu_off_time);
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+
+	return true;
+}
+
 static bool tegra30_idle_enter_lp2_cpu_n(struct cpuidle_device *dev,
 					 struct cpuidle_driver *drv,
 					 int index)
@@ -85,16 +108,22 @@ static int __cpuinit tegra30_idle_lp2(struct cpuidle_device *dev,
 				      int index)
 {
 	bool entered_lp2 = false;
+	bool last_cpu;
 
 	local_fiq_disable();
 
-	tegra_set_cpu_in_lp2(dev->cpu);
+	last_cpu = tegra_set_cpu_in_lp2(dev->cpu);
 	cpu_pm_enter();
 
-	if (dev->cpu == 0)
-		cpu_do_idle();
-	else
+	if (dev->cpu == 0) {
+		if (last_cpu)
+			entered_lp2 = tegra30_idle_enter_lp2_cpu_0(dev, drv,
+								   index);
+		else
+			cpu_do_idle();
+	} else {
 		entered_lp2 = tegra30_idle_enter_lp2_cpu_n(dev, drv, index);
+	}
 
 	cpu_pm_exit();
 	tegra_clear_cpu_in_lp2(dev->cpu);
@@ -116,6 +145,8 @@ int __init tegra30_cpuidle_init(void)
 
 #ifndef CONFIG_PM_SLEEP
 	drv->state_count = 1;	/* support clockgating only */
+#else
+	tegra_tear_down_cpu = tegra30_tear_down_cpu;
 #endif
 
 	ret = cpuidle_register_driver(&tegra_idle_driver);
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 4655383..2e71bad 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -20,15 +20,38 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/cpu_pm.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+
+#include <asm/smp_plat.h>
+#include <asm/cacheflush.h>
+#include <asm/suspend.h>
+#include <asm/idmap.h>
+#include <asm/proc-fns.h>
+#include <asm/tlbflush.h>
 
 #include <mach/iomap.h>
 
 #include "reset.h"
+#include "flowctrl.h"
+#include "sleep.h"
+#include "tegra_cpu_car.h"
+
+#define TEGRA_POWER_CPU_PWRREQ_OE	(1 << 16)  /* CPU pwr req enable */
+
+#define PMC_CTRL		0x0
+#define PMC_CPUPWRGOOD_TIMER	0xc8
+#define PMC_CPUPWROFF_TIMER	0xcc
 
 #ifdef CONFIG_PM_SLEEP
 static unsigned int g_diag_reg;
 static DEFINE_SPINLOCK(tegra_lp2_lock);
 static cpumask_t tegra_in_lp2;
+static void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
+static struct clk *tegra_pclk;
+void (*tegra_tear_down_cpu)(void);
 
 void save_cpu_arch_register(void)
 {
@@ -44,6 +67,96 @@ void restore_cpu_arch_register(void)
 	return;
 }
 
+static void set_power_timers(unsigned long us_on, unsigned long us_off)
+{
+	unsigned long long ticks;
+	unsigned long long pclk;
+	unsigned long rate;
+	static unsigned long tegra_last_pclk;
+
+	if (tegra_pclk == NULL) {
+		tegra_pclk = clk_get_sys(NULL, "pclk");
+		if (IS_ERR(tegra_pclk)) {
+			/*
+			 * pclk not been init or not exist.
+			 * Use sclk to take the place of it.
+			 * The default setting was pclk=sclk.
+			 */
+			tegra_pclk = clk_get_sys(NULL, "sclk");
+		}
+	}
+
+	rate = clk_get_rate(tegra_pclk);
+
+	if (WARN_ON_ONCE(rate <= 0))
+		pclk = 100000000;
+	else
+		pclk = rate;
+
+	if ((rate != tegra_last_pclk)) {
+		ticks = (us_on * pclk) + 999999ull;
+		do_div(ticks, 1000000);
+		writel((unsigned long)ticks, pmc + PMC_CPUPWRGOOD_TIMER);
+
+		ticks = (us_off * pclk) + 999999ull;
+		do_div(ticks, 1000000);
+		writel((unsigned long)ticks, pmc + PMC_CPUPWROFF_TIMER);
+		wmb();
+	}
+	tegra_last_pclk = pclk;
+}
+
+/*
+ * restore_cpu_complex
+ *
+ * restores cpu clock setting, clears flow controller
+ *
+ * Always called on CPU 0.
+ */
+static void restore_cpu_complex(void)
+{
+	int cpu = smp_processor_id();
+
+	BUG_ON(cpu != 0);
+
+#ifdef CONFIG_SMP
+	cpu = cpu_logical_map(cpu);
+#endif
+
+	/* Restore the CPU clock settings */
+	tegra_cpu_clock_resume();
+
+	flowctrl_cpu_suspend_exit(cpu);
+
+	restore_cpu_arch_register();
+}
+
+/*
+ * suspend_cpu_complex
+ *
+ * saves pll state for use by restart_plls, prepares flow controller for
+ * transition to suspend state
+ *
+ * Must always be called on cpu 0.
+ */
+static void suspend_cpu_complex(void)
+{
+	int cpu = smp_processor_id();
+
+	BUG_ON(cpu != 0);
+
+#ifdef CONFIG_SMP
+	cpu = cpu_logical_map(cpu);
+#endif
+
+	/* Save the CPU clock settings */
+	tegra_cpu_clock_suspend();
+
+	flowctrl_cpu_suspend_enter(cpu);
+
+	save_cpu_arch_register();
+}
+
 void __cpuinit tegra_clear_cpu_in_lp2(int cpu)
 {
 	spin_lock(&tegra_lp2_lock);
@@ -85,4 +198,43 @@ bool __cpuinit tegra_set_cpu_in_lp2(int cpu)
 	spin_unlock(&tegra_lp2_lock);
 	return last_cpu;
 }
+
+static int tegra_sleep_cpu(unsigned long v2p)
+{
+	/* Switch to the identity mapping. */
+	cpu_switch_mm(idmap_pgd, &init_mm);
+
+	/* Flush the TLB. */
+	local_flush_tlb_all();
+
+	tegra_sleep_cpu_finish(v2p);
+
+	/* should never here */
+	BUG();
+
+	return 0;
+}
+
+void tegra_idle_lp2_last(u32 cpu_on_time, u32 cpu_off_time)
+{
+	u32 mode;
+
+	/* Only the last cpu down does the final suspend steps */
+	mode = readl(pmc + PMC_CTRL);
+	mode |= TEGRA_POWER_CPU_PWRREQ_OE;
+	writel(mode, pmc + PMC_CTRL);
+
+	set_power_timers(cpu_on_time, cpu_off_time);
+
+	cpu_cluster_pm_enter();
+	suspend_cpu_complex();
+	flush_cache_all();
+	outer_disable();
+
+	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
+
+	outer_resume();
+	restore_cpu_complex();
+	cpu_cluster_pm_exit();
+}
 #endif
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 21858d6..63ffe02 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -27,4 +27,7 @@ void restore_cpu_arch_register(void);
 void tegra_clear_cpu_in_lp2(int cpu);
 bool tegra_set_cpu_in_lp2(int cpu);
 
+void tegra_idle_lp2_last(u32 cpu_on_time, u32 cpu_off_time);
+extern void (*tegra_tear_down_cpu)(void);
+
 #endif /* _MACH_TEGRA_PM_H_ */
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 67b1cba..aef5ce7 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -130,4 +130,48 @@ ENTRY(tegra30_sleep_cpu_secondary_finish)
 	mov	r0, #1                          @ never return here
 	mov	pc, r7
 ENDPROC(tegra30_sleep_cpu_secondary_finish)
+
+/*
+ * tegra30_tear_down_cpu
+ *
+ * Switches the CPU to enter sleep.
+ */
+ENTRY(tegra30_tear_down_cpu)
+	mov32	r6, TEGRA_FLOW_CTRL_BASE
+
+	b	tegra30_enter_sleep
+ENDPROC(tegra30_tear_down_cpu)
+
+/*
+ * tegra30_enter_sleep
+ *
+ * uses flow controller to enter sleep state
+ * executes from IRAM with SDRAM in selfrefresh when target state is LP0 or LP1
+ * executes from SDRAM with target state is LP2
+ * r6 = TEGRA_FLOW_CTRL_BASE
+ */
+tegra30_enter_sleep:
+	cpu_id	r1
+
+	cpu_to_csr_reg	r2, r1
+	ldr	r0, [r6, r2]
+	orr	r0, r0, #FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
+	orr	r0, r0, #FLOW_CTRL_CSR_ENABLE
+	str	r0, [r6, r2]
+
+	mov	r0, #FLOW_CTRL_WAIT_FOR_INTERRUPT
+	orr	r0, r0, #FLOW_CTRL_HALT_CPU_IRQ | FLOW_CTRL_HALT_CPU_FIQ
+	cpu_to_halt_reg r2, r1
+	str	r0, [r6, r2]
+	dsb
+	ldr	r0, [r6, r2] /* memory barrier */
+
+halted:
+	isb
+	dsb
+	wfi	/* CPU should be power gated here */
+
+	/* !!!FIXME!!! Implement halt failure handler */
+	b	halted
+
 #endif
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 7748fdb..3ab1e82 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -25,6 +25,7 @@
 #include <linux/linkage.h>
 
 #include <asm/assembler.h>
+#include <asm/cache.h>
 #include <asm/cp15.h>
 
 #include <mach/iomap.h>
@@ -96,4 +97,47 @@ finished:
 	mov	pc, lr
 ENDPROC(tegra_flush_l1_cache)
 
+/*
+ * tegra_sleep_cpu_finish(unsigned long v2p)
+ *
+ * enters suspend in LP2 by turning off the mmu and jumping to
+ * tegra?_tear_down_cpu
+ */
+ENTRY(tegra_sleep_cpu_finish)
+	/* Flush and disable the L1 data cache */
+	bl	tegra_flush_l1_cache
+	/* Trun off coherency */
+	exit_smp r4, r5
+
+	mov32	r6, tegra_tear_down_cpu
+	ldr	r1, [r6]
+	add	r1, r1, r0
+
+	mov32	r3, tegra_shut_off_mmu
+	add	r3, r3, r0
+	mov	r0, r1
+
+	mov	pc, r3
+ENDPROC(tegra_sleep_cpu_finish)
+
+/*
+ * tegra_shut_off_mmu
+ *
+ * r0 = physical address to jump to with mmu off
+ *
+ * called with VA=PA mapping
+ * turns off MMU, icache, dcache and branch prediction
+ */
+	.align	L1_CACHE_SHIFT
+	.pushsection	.idmap.text, "ax"
+ENTRY(tegra_shut_off_mmu)
+	mrc	p15, 0, r3, c1, c0, 0
+	movw	r2, #CR_I | CR_Z | CR_C | CR_M
+	bic	r3, r3, r2
+	dsb
+	mcr	p15, 0, r3, c1, c0, 0
+	isb
+	mov	pc, r0
+ENDPROC(tegra_shut_off_mmu)
+	.popsection
 #endif
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 220fbd1..001920f 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -73,6 +73,7 @@
 .endm
 #else
 void tegra_resume(void);
+int tegra_sleep_cpu_finish(unsigned long);
 
 #ifdef CONFIG_HOTPLUG_CPU
 void tegra20_hotplug_init(void);
@@ -83,6 +84,7 @@ static inline void tegra30_hotplug_init(void) {}
 #endif
 
 int tegra30_sleep_cpu_secondary_finish(unsigned long);
+void tegra30_tear_down_cpu(void);
 
 #endif
 #endif
-- 
1.7.0.4
