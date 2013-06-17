From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 17 Jun 2013 17:11:23 -0400
Subject: [PATCH] arm: delete __cpuinit usage from all users
Message-ID: <1371503483-2382-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __cpuinit type of throwaway sections might have made sense
some time ago when RAM was more constrained, but now the savings
do not offset the cost and complications.  For example, the fix in
commit 5e427ec2d0 ("x86: Fix bit corruption at CPU resume time")
is a good example of the nasty type of bugs that can be created
with improper use of the various __init prefixes.

After a discussion on LKML[1] it was decided that cpuinit should go
the way of devinit and be phased out.  Once all the users are gone,
we can then finally remove the macros themselves from linux/init.h.

This removes all the ARM uses of the __cpuinit macros.

[1] https://lkml.org/lkml/2013/5/20/589

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[This was generated against today's linux-next tree ; I'm assuming
 most/all pending ARM changes are in there currently.]

 arch/arm/common/mcpm_platsmp.c            |  4 ++--
 arch/arm/include/asm/arch_timer.h         |  2 +-
 arch/arm/kernel/hw_breakpoint.c           |  4 ++--
 arch/arm/kernel/perf_event_cpu.c          |  6 +++---
 arch/arm/kernel/psci_smp.c                |  3 +--
 arch/arm/kernel/smp.c                     | 18 +++++++++---------
 arch/arm/kernel/smp_twd.c                 |  6 +++---
 arch/arm/lib/delay.c                      |  2 +-
 arch/arm/mach-exynos/platsmp.c            |  4 ++--
 arch/arm/mach-highbank/platsmp.c          |  2 +-
 arch/arm/mach-imx/platsmp.c               |  2 +-
 arch/arm/mach-msm/platsmp.c               |  6 +++---
 arch/arm/mach-msm/timer.c                 |  4 ++--
 arch/arm/mach-mvebu/coherency.c           |  2 +-
 arch/arm/mach-mvebu/platsmp.c             |  5 ++---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |  2 +-
 arch/arm/mach-omap2/omap-smp.c            |  4 ++--
 arch/arm/mach-omap2/omap-wakeupgen.c      |  4 ++--
 arch/arm/mach-prima2/platsmp.c            |  4 ++--
 arch/arm/mach-shmobile/smp-emev2.c        |  2 +-
 arch/arm/mach-shmobile/smp-r8a7779.c      |  2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c       |  2 +-
 arch/arm/mach-socfpga/platsmp.c           |  2 +-
 arch/arm/mach-spear/generic.h             |  2 +-
 arch/arm/mach-spear/platsmp.c             |  4 ++--
 arch/arm/mach-tegra/platsmp.c             |  4 ++--
 arch/arm/mach-tegra/pm.c                  |  2 +-
 arch/arm/mach-ux500/platsmp.c             |  4 ++--
 arch/arm/mach-zynq/common.h               |  2 +-
 arch/arm/mach-zynq/platsmp.c              |  6 +++---
 arch/arm/plat-versatile/platsmp.c         |  6 +++---
 31 files changed, 60 insertions(+), 62 deletions(-)

diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
index 510e5b1..1bc34c7 100644
--- a/arch/arm/common/mcpm_platsmp.c
+++ b/arch/arm/common/mcpm_platsmp.c
@@ -19,7 +19,7 @@
 #include <asm/smp.h>
 #include <asm/smp_plat.h>
 
-static int __cpuinit mcpm_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int mcpm_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned int mpidr, pcpu, pcluster, ret;
 	extern void secondary_startup(void);
@@ -40,7 +40,7 @@ static int __cpuinit mcpm_boot_secondary(unsigned int cpu, struct task_struct *i
 	return 0;
 }
 
-static void __cpuinit mcpm_secondary_init(unsigned int cpu)
+static void mcpm_secondary_init(unsigned int cpu)
 {
 	mcpm_cpu_powered_up();
 }
diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 7c1bfc0..625ef40 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -98,7 +98,7 @@ static inline u64 arch_counter_get_cntvct(void)
 	return cval;
 }
 
-static inline void __cpuinit arch_counter_set_user_access(void)
+static inline void arch_counter_set_user_access(void)
 {
 	u32 cntkctl;
 
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 1fd749e..7b95de6 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -1020,7 +1020,7 @@ out_mdbgen:
 		cpumask_or(&debug_err_mask, &debug_err_mask, cpumask_of(cpu));
 }
 
-static int __cpuinit dbg_reset_notify(struct notifier_block *self,
+static int dbg_reset_notify(struct notifier_block *self,
 				      unsigned long action, void *cpu)
 {
 	if ((action & ~CPU_TASKS_FROZEN) == CPU_ONLINE)
@@ -1029,7 +1029,7 @@ static int __cpuinit dbg_reset_notify(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __cpuinitdata dbg_reset_nb = {
+static struct notifier_block dbg_reset_nb = {
 	.notifier_call = dbg_reset_notify,
 };
 
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 1f2740e..aebe0e9 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -157,8 +157,8 @@ static void cpu_pmu_init(struct arm_pmu *cpu_pmu)
  * UNKNOWN at reset, the PMU must be explicitly reset to avoid reading
  * junk values out of them.
  */
-static int __cpuinit cpu_pmu_notify(struct notifier_block *b,
-				    unsigned long action, void *hcpu)
+static int cpu_pmu_notify(struct notifier_block *b, unsigned long action,
+			  void *hcpu)
 {
 	if ((action & ~CPU_TASKS_FROZEN) != CPU_STARTING)
 		return NOTIFY_DONE;
@@ -171,7 +171,7 @@ static int __cpuinit cpu_pmu_notify(struct notifier_block *b,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __cpuinitdata cpu_pmu_hotplug_notifier = {
+static struct notifier_block cpu_pmu_hotplug_notifier = {
 	.notifier_call = cpu_pmu_notify,
 };
 
diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index 219f1d7..70ded3f 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -46,8 +46,7 @@
 
 extern void secondary_startup(void);
 
-static int __cpuinit psci_boot_secondary(unsigned int cpu,
-					 struct task_struct *idle)
+static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	if (psci_ops.cpu_on)
 		return psci_ops.cpu_on(cpu_logical_map(cpu),
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 550d63c..d56eccf 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -57,7 +57,7 @@ struct secondary_data secondary_data;
  * control for which core is the next to come out of the secondary
  * boot "holding pen"
  */
-volatile int __cpuinitdata pen_release = -1;
+volatile int pen_release = -1;
 
 enum ipi_msg_type {
 	IPI_WAKEUP,
@@ -78,7 +78,7 @@ void __init smp_set_ops(struct smp_operations *ops)
 		smp_ops = *ops;
 };
 
-int __cpuinit __cpu_up(unsigned int cpu, struct task_struct *idle)
+int __cpu_up(unsigned int cpu, struct task_struct *idle)
 {
 	int ret;
 
@@ -125,7 +125,7 @@ void __init smp_init_cpus(void)
 		smp_ops.smp_init_cpus();
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+int boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	if (smp_ops.smp_boot_secondary)
 		return smp_ops.smp_boot_secondary(cpu, idle);
@@ -157,7 +157,7 @@ static int platform_cpu_disable(unsigned int cpu)
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
-int __cpuinit __cpu_disable(void)
+int __cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
 	int ret;
@@ -203,7 +203,7 @@ static DECLARE_COMPLETION(cpu_died);
  * called on the thread which is asking for a CPU to be shutdown -
  * waits until shutdown has completed, or it is timed out.
  */
-void __cpuinit __cpu_die(unsigned int cpu)
+void __cpu_die(unsigned int cpu)
 {
 	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
 		pr_err("CPU%u: cpu didn't die\n", cpu);
@@ -293,7 +293,7 @@ void __ref cpu_die(void)
  * Called by both boot and secondaries to move global data into
  * per-processor storage.
  */
-static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
+static void smp_store_cpu_info(unsigned int cpuid)
 {
 	struct cpuinfo_arm *cpu_info = &per_cpu(cpu_data, cpuid);
 
@@ -309,7 +309,7 @@ static void percpu_timer_setup(void);
  * This is the secondary CPU boot entry.  We're using this CPUs
  * idle thread stack, but a set of temporary page tables.
  */
-asmlinkage void __cpuinit secondary_start_kernel(void)
+asmlinkage void secondary_start_kernel(void)
 {
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu;
@@ -508,7 +508,7 @@ static void broadcast_timer_set_mode(enum clock_event_mode mode,
 {
 }
 
-static void __cpuinit broadcast_timer_setup(struct clock_event_device *evt)
+static void broadcast_timer_setup(struct clock_event_device *evt)
 {
 	evt->name	= "dummy_timer";
 	evt->features	= CLOCK_EVT_FEAT_ONESHOT |
@@ -537,7 +537,7 @@ int local_timer_register(struct local_timer_ops *ops)
 }
 #endif
 
-static void __cpuinit percpu_timer_setup(void)
+static void percpu_timer_setup(void)
 {
 	unsigned int cpu = smp_processor_id();
 	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 90525d9..ed5cb75 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -187,7 +187,7 @@ core_initcall(twd_cpufreq_init);
 
 #endif
 
-static void __cpuinit twd_calibrate_rate(void)
+static void twd_calibrate_rate(void)
 {
 	unsigned long count;
 	u64 waitjiffies;
@@ -265,7 +265,7 @@ static void twd_get_clock(struct device_node *np)
 /*
  * Setup the local clock events for a CPU.
  */
-static int __cpuinit twd_timer_setup(struct clock_event_device *clk)
+static int twd_timer_setup(struct clock_event_device *clk)
 {
 	struct clock_event_device **this_cpu_clk;
 	int cpu = smp_processor_id();
@@ -308,7 +308,7 @@ static int __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	return 0;
 }
 
-static struct local_timer_ops twd_lt_ops __cpuinitdata = {
+static struct local_timer_ops twd_lt_ops = {
 	.setup	= twd_timer_setup,
 	.stop	= twd_timer_stop,
 };
diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 64dbfa5..5306de3 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -86,7 +86,7 @@ void __init register_current_timer_delay(const struct delay_timer *timer)
 	}
 }
 
-unsigned long __cpuinit calibrate_delay_is_known(void)
+unsigned long calibrate_delay_is_known(void)
 {
 	delay_calibrated = true;
 	return lpj_fine;
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index d9c6d0a..42eccb6 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -73,7 +73,7 @@ static void __iomem *scu_base_addr(void)
 
 static DEFINE_SPINLOCK(boot_lock);
 
-static void __cpuinit exynos_secondary_init(unsigned int cpu)
+static void exynos_secondary_init(unsigned int cpu)
 {
 	/*
 	 * let the primary processor know we're out of the
@@ -88,7 +88,7 @@ static void __cpuinit exynos_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-static int __cpuinit exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 	unsigned long phys_cpu = cpu_logical_map(cpu);
diff --git a/arch/arm/mach-highbank/platsmp.c b/arch/arm/mach-highbank/platsmp.c
index a984573..32d75cf5 100644
--- a/arch/arm/mach-highbank/platsmp.c
+++ b/arch/arm/mach-highbank/platsmp.c
@@ -24,7 +24,7 @@
 
 extern void secondary_startup(void);
 
-static int __cpuinit highbank_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int highbank_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	highbank_set_cpu_jump(cpu, secondary_startup);
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index c6e1ab5..1f24c1f 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -53,7 +53,7 @@ void imx_scu_standby_enable(void)
 	writel_relaxed(val, scu_base);
 }
 
-static int __cpuinit imx_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int imx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	imx_set_cpu_jump(cpu, v7_secondary_startup);
 	imx_enable_cpu(cpu, true);
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 00cdb0a..3f06edc 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -38,7 +38,7 @@ static inline int get_core_count(void)
 	return ((read_cpuid_id() >> 4) & 3) + 1;
 }
 
-static void __cpuinit msm_secondary_init(unsigned int cpu)
+static void msm_secondary_init(unsigned int cpu)
 {
 	/*
 	 * let the primary processor know we're out of the
@@ -54,7 +54,7 @@ static void __cpuinit msm_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-static __cpuinit void prepare_cold_cpu(unsigned int cpu)
+static void prepare_cold_cpu(unsigned int cpu)
 {
 	int ret;
 	ret = scm_set_boot_addr(virt_to_phys(msm_secondary_startup),
@@ -73,7 +73,7 @@ static __cpuinit void prepare_cold_cpu(unsigned int cpu)
 				  "address\n");
 }
 
-static int __cpuinit msm_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int msm_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 	static int cold_boot_done;
diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 284313f..817afa7 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -139,7 +139,7 @@ static struct clocksource msm_clocksource = {
 };
 
 #ifdef CONFIG_LOCAL_TIMERS
-static int __cpuinit msm_local_timer_setup(struct clock_event_device *evt)
+static int msm_local_timer_setup(struct clock_event_device *evt)
 {
 	/* Use existing clock_event for cpu 0 */
 	if (!smp_processor_id())
@@ -164,7 +164,7 @@ static void msm_local_timer_stop(struct clock_event_device *evt)
 	disable_percpu_irq(evt->irq);
 }
 
-static struct local_timer_ops msm_local_timer_ops __cpuinitdata = {
+static struct local_timer_ops msm_local_timer_ops = {
 	.setup	= msm_local_timer_setup,
 	.stop	= msm_local_timer_stop,
 };
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 32fcf69..9d49ed7 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -28,7 +28,7 @@
 #include <asm/cacheflush.h>
 #include "armada-370-xp.h"
 
-unsigned long __cpuinitdata coherency_phys_base;
+unsigned long coherency_phys_base;
 static void __iomem *coherency_base;
 static void __iomem *coherency_cpu_base;
 
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 93f2f3a..ce81d30 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -71,13 +71,12 @@ void __init set_secondary_cpus_clock(void)
 	}
 }
 
-static void __cpuinit armada_xp_secondary_init(unsigned int cpu)
+static void armada_xp_secondary_init(unsigned int cpu)
 {
 	armada_xp_mpic_smp_cpu_init();
 }
 
-static int __cpuinit armada_xp_boot_secondary(unsigned int cpu,
-					      struct task_struct *idle)
+static int armada_xp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	pr_info("Booting CPU %d\n", cpu);
 
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index f993a41..f991016 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -291,7 +291,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
  * @cpu : CPU ID
  * @power_state: CPU low power state.
  */
-int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
+int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 {
 	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu);
 	unsigned int cpu_state = 0;
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 98a1146..8708b2a 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -51,7 +51,7 @@ void __iomem *omap4_get_scu_base(void)
 	return scu_base;
 }
 
-static void __cpuinit omap4_secondary_init(unsigned int cpu)
+static void omap4_secondary_init(unsigned int cpu)
 {
 	/*
 	 * Configure ACTRL and enable NS SMP bit access on CPU1 on HS device.
@@ -72,7 +72,7 @@ static void __cpuinit omap4_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	static struct clockdomain *cpu1_clkdm;
 	static bool booted;
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index f8bb3b9..813c615 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -323,8 +323,8 @@ static void irq_save_secure_context(void)
 #endif
 
 #ifdef CONFIG_HOTPLUG_CPU
-static int __cpuinit irq_cpu_hotplug_notify(struct notifier_block *self,
-					 unsigned long action, void *hcpu)
+static int irq_cpu_hotplug_notify(struct notifier_block *self,
+				  unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned int)hcpu;
 
diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
index 1c3de7b..3dbcb1a 100644
--- a/arch/arm/mach-prima2/platsmp.c
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -44,7 +44,7 @@ void __init sirfsoc_map_scu(void)
 	scu_base = (void __iomem *)SIRFSOC_VA(base);
 }
 
-static void __cpuinit sirfsoc_secondary_init(unsigned int cpu)
+static void sirfsoc_secondary_init(unsigned int cpu)
 {
 	/*
 	 * let the primary processor know we're out of the
@@ -65,7 +65,7 @@ static struct of_device_id rsc_ids[]  = {
 	{},
 };
 
-static int __cpuinit sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 	struct device_node *np;
diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index 80991b3..22a05a8 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -30,7 +30,7 @@
 
 #define EMEV2_SCU_BASE 0x1e000000
 
-static int __cpuinit emev2_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int emev2_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu_logical_map(cpu)));
 	return 0;
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 526cfaa..9bdf810 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -81,7 +81,7 @@ static int r8a7779_platform_cpu_kill(unsigned int cpu)
 	return ret ? ret : 1;
 }
 
-static int __cpuinit r8a7779_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int r8a7779_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	struct r8a7779_pm_ch *ch = NULL;
 	int ret = -EIO;
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index d613113..d5fc3ed 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -48,7 +48,7 @@ void __init sh73a0_register_twd(void)
 }
 #endif
 
-static int __cpuinit sh73a0_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int sh73a0_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	cpu = cpu_logical_map(cpu);
 
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index b51ce8c..5356a72 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -29,7 +29,7 @@
 
 #include "core.h"
 
-static int __cpuinit socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
 
diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
index a9fd453..0fce174 100644
--- a/arch/arm/mach-spear/generic.h
+++ b/arch/arm/mach-spear/generic.h
@@ -35,7 +35,7 @@ void __init spear13xx_l2x0_init(void);
 void spear_restart(char, const char *);
 
 void spear13xx_secondary_startup(void);
-void __cpuinit spear13xx_cpu_die(unsigned int cpu);
+void spear13xx_cpu_die(unsigned int cpu);
 
 extern struct smp_operations spear13xx_smp_ops;
 
diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
index 9c4c722..5c4a198 100644
--- a/arch/arm/mach-spear/platsmp.c
+++ b/arch/arm/mach-spear/platsmp.c
@@ -24,7 +24,7 @@ static DEFINE_SPINLOCK(boot_lock);
 
 static void __iomem *scu_base = IOMEM(VA_SCU_BASE);
 
-static void __cpuinit spear13xx_secondary_init(unsigned int cpu)
+static void spear13xx_secondary_init(unsigned int cpu)
 {
 	/*
 	 * let the primary processor know we're out of the
@@ -40,7 +40,7 @@ static void __cpuinit spear13xx_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-static int __cpuinit spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 24db4ac..97b33a2 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -35,7 +35,7 @@
 
 static cpumask_t tegra_cpu_init_mask;
 
-static void __cpuinit tegra_secondary_init(unsigned int cpu)
+static void tegra_secondary_init(unsigned int cpu)
 {
 	cpumask_set_cpu(cpu, &tegra_cpu_init_mask);
 }
@@ -167,7 +167,7 @@ static int tegra114_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return ret;
 }
 
-static int __cpuinit tegra_boot_secondary(unsigned int cpu,
+static int tegra_boot_secondary(unsigned int cpu,
 					  struct task_struct *idle)
 {
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) && tegra_chip_id == TEGRA20)
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 94e69be..261fec1 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -191,7 +191,7 @@ static const char *lp_state[TEGRA_MAX_SUSPEND_MODE] = {
 	[TEGRA_SUSPEND_LP0] = "LP0",
 };
 
-static int __cpuinit tegra_suspend_enter(suspend_state_t state)
+static int tegra_suspend_enter(suspend_state_t state)
 {
 	enum tegra_suspend_mode mode = tegra_pmc_get_suspend_mode();
 
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 14d9046..1f296e7 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -54,7 +54,7 @@ static void __iomem *scu_base_addr(void)
 
 static DEFINE_SPINLOCK(boot_lock);
 
-static void __cpuinit ux500_secondary_init(unsigned int cpu)
+static void ux500_secondary_init(unsigned int cpu)
 {
 	/*
 	 * let the primary processor know we're out of the
@@ -69,7 +69,7 @@ static void __cpuinit ux500_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-static int __cpuinit ux500_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int ux500_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index fbbd0e2..3040d21 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -27,7 +27,7 @@ extern void secondary_startup(void);
 extern char zynq_secondary_trampoline;
 extern char zynq_secondary_trampoline_jump;
 extern char zynq_secondary_trampoline_end;
-extern int __cpuinit zynq_cpun_start(u32 address, int cpu);
+extern int zynq_cpun_start(u32 address, int cpu);
 extern struct smp_operations zynq_smp_ops __initdata;
 #endif
 
diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index 5fc167e..efd3c05 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -30,11 +30,11 @@
 /*
  * Store number of cores in the system
  * Because of scu_get_core_count() must be in __init section and can't
- * be called from zynq_cpun_start() because it is in __cpuinit section.
+ * be called from zynq_cpun_start() because it is not in __init section.
  */
 static int ncores;
 
-int __cpuinit zynq_cpun_start(u32 address, int cpu)
+int zynq_cpun_start(u32 address, int cpu)
 {
 	u32 trampoline_code_size = &zynq_secondary_trampoline_end -
 						&zynq_secondary_trampoline;
@@ -92,7 +92,7 @@ int __cpuinit zynq_cpun_start(u32 address, int cpu)
 }
 EXPORT_SYMBOL(zynq_cpun_start);
 
-static int __cpuinit zynq_boot_secondary(unsigned int cpu,
+static int zynq_boot_secondary(unsigned int cpu,
 						struct task_struct *idle)
 {
 	return zynq_cpun_start(virt_to_phys(secondary_startup), cpu);
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 1e1b2d7..39895d8 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -23,7 +23,7 @@
  * observers, irrespective of whether they're taking part in coherency
  * or not.  This is necessary for the hotplug code to work reliably.
  */
-static void __cpuinit write_pen_release(int val)
+static void write_pen_release(int val)
 {
 	pen_release = val;
 	smp_wmb();
@@ -33,7 +33,7 @@ static void __cpuinit write_pen_release(int val)
 
 static DEFINE_SPINLOCK(boot_lock);
 
-void __cpuinit versatile_secondary_init(unsigned int cpu)
+void versatile_secondary_init(unsigned int cpu)
 {
 	/*
 	 * let the primary processor know we're out of the
@@ -48,7 +48,7 @@ void __cpuinit versatile_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-int __cpuinit versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
+int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 
-- 
1.8.1.2
