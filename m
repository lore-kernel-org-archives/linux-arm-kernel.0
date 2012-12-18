From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 18 Dec 2012 10:30:58 +0800
Subject: [PATCH V3 2/5] ARM: tegra20: cpuidle: add powered-down state for
 secondary CPU
In-Reply-To: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
References: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
Message-ID: <1355797861-12759-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The powered-down state of Tegra20 requires power gating both CPU cores.
When the secondary CPU requests to enter powered-down state, it saves
its own contexts and then enters WFI. The Tegra20 had a limition to
power down both CPU cores. The secondary CPU must waits for CPU0 in
powered-down state too. If the secondary CPU be woken up before CPU0
entering powered-down state, then it needs to restore its CPU states
and waits for next chance.

Be aware of that, you may see the legacy power state "LP2" in the code
which is exactly the same meaning of "CPU power down".

Based on the work by:
Colin Cross <ccross@android.com>
Gary King <gking@nvidia.com>

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* dynamic checking of the number of the state counts
* fix the code sequence for aborting cpu_suspend in
  tegra20_sleep_cpu_secondary_finish
V2:
* no change
---
 arch/arm/mach-tegra/cpuidle-tegra20.c |   94 ++++++++++++++++++++-
 arch/arm/mach-tegra/pm.c              |    2 +
 arch/arm/mach-tegra/sleep-tegra20.S   |  147 +++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/sleep.h           |   23 +++++
 4 files changed, 261 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index d32e8b0..716aef3 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -22,28 +22,112 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+#include <linux/clockchips.h>
 
 #include <asm/cpuidle.h>
+#include <asm/proc-fns.h>
+#include <asm/suspend.h>
+#include <asm/smp_plat.h>
+
+#include "pm.h"
+#include "sleep.h"
+
+#ifdef CONFIG_PM_SLEEP
+static int tegra20_idle_lp2(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv,
+			    int index);
+#endif
+
+static struct cpuidle_state tegra_idle_states[] = {
+	[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
+#ifdef CONFIG_PM_SLEEP
+	[1] = {
+		.enter			= tegra20_idle_lp2,
+		.exit_latency		= 5000,
+		.target_residency	= 10000,
+		.power_usage		= 0,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "powered-down",
+		.desc			= "CPU power gated",
+	},
+#endif
+};
 
 static struct cpuidle_driver tegra_idle_driver = {
 	.name = "tegra_idle",
 	.owner = THIS_MODULE,
 	.en_core_tk_irqen = 1,
-	.state_count = 1,
-	.states = {
-		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
-	},
 };
 
 static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
 
+#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_SMP
+static bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
+					 struct cpuidle_driver *drv,
+					 int index)
+{
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+
+	cpu_suspend(0, tegra20_sleep_cpu_secondary_finish);
+
+	tegra20_cpu_clear_resettable();
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+
+	return true;
+}
+#else
+static inline bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
+						struct cpuidle_driver *drv,
+						int index)
+{
+	return true;
+}
+#endif
+
+static int __cpuinit tegra20_idle_lp2(struct cpuidle_device *dev,
+				      struct cpuidle_driver *drv,
+				      int index)
+{
+	u32 cpu = is_smp() ? cpu_logical_map(dev->cpu) : dev->cpu;
+	bool entered_lp2 = false;
+
+	local_fiq_disable();
+
+	tegra_set_cpu_in_lp2(cpu);
+	cpu_pm_enter();
+
+	if (cpu == 0)
+		cpu_do_idle();
+	else
+		entered_lp2 = tegra20_idle_enter_lp2_cpu_1(dev, drv, index);
+
+	cpu_pm_exit();
+	tegra_clear_cpu_in_lp2(cpu);
+
+	local_fiq_enable();
+
+	smp_rmb();
+
+	return entered_lp2 ? index : 0;
+}
+#endif
+
 int __init tegra20_cpuidle_init(void)
 {
-	int ret;
+	int ret, i;
 	unsigned int cpu;
 	struct cpuidle_device *dev;
 	struct cpuidle_driver *drv = &tegra_idle_driver;
 
+	drv->state_count = sizeof(tegra_idle_states) /
+			   sizeof(struct cpuidle_state);
+	for (i = 0; i < drv->state_count; i++)
+		memcpy(&drv->states[i], &tegra_idle_states[i],
+		       sizeof(struct cpuidle_state));
+
 	ret = cpuidle_register_driver(&tegra_idle_driver);
 	if (ret) {
 		pr_err("CPUidle driver registration failed\n");
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 1b11707..db72ea9 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -173,6 +173,8 @@ bool __cpuinit tegra_set_cpu_in_lp2(int phy_cpu_id)
 
 	if ((phy_cpu_id == 0) && cpumask_equal(cpu_lp2_mask, cpu_online_mask))
 		last_cpu = true;
+	else if (phy_cpu_id == 1)
+		tegra20_cpu_set_resettable_soon();
 
 	spin_unlock(&tegra_lp2_lock);
 	return last_cpu;
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index 72ce709..d04693b 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -21,6 +21,8 @@
 #include <linux/linkage.h>
 
 #include <asm/assembler.h>
+#include <asm/proc-fns.h>
+#include <asm/cp15.h>
 
 #include "sleep.h"
 #include "flowctrl.h"
@@ -78,3 +80,148 @@ ENTRY(tegra20_cpu_shutdown)
 	mov	pc, lr
 ENDPROC(tegra20_cpu_shutdown)
 #endif
+
+#ifdef CONFIG_PM_SLEEP
+/*
+ * tegra_pen_lock
+ *
+ * spinlock implementation with no atomic test-and-set and no coherence
+ * using Peterson's algorithm on strongly-ordered registers
+ * used to synchronize a cpu waking up from wfi with entering lp2 on idle
+ *
+ * The reference link of Peterson's algorithm:
+ * http://en.wikipedia.org/wiki/Peterson's_algorithm
+ *
+ * SCRATCH37 = r1 = !turn (inverted from Peterson's algorithm)
+ * on cpu 0:
+ * r2 = flag[0] (in SCRATCH38)
+ * r3 = flag[1] (in SCRATCH39)
+ * on cpu1:
+ * r2 = flag[1] (in SCRATCH39)
+ * r3 = flag[0] (in SCRATCH38)
+ *
+ * must be called with MMU on
+ * corrupts r0-r3, r12
+ */
+ENTRY(tegra_pen_lock)
+	mov32	r3, TEGRA_PMC_VIRT
+	cpu_id	r0
+	add	r1, r3, #PMC_SCRATCH37
+	cmp	r0, #0
+	addeq	r2, r3, #PMC_SCRATCH38
+	addeq	r3, r3, #PMC_SCRATCH39
+	addne	r2, r3, #PMC_SCRATCH39
+	addne	r3, r3, #PMC_SCRATCH38
+
+	mov	r12, #1
+	str	r12, [r2]		@ flag[cpu] = 1
+	dsb
+	str	r12, [r1]		@ !turn = cpu
+1:	dsb
+	ldr	r12, [r3]
+	cmp	r12, #1			@ flag[!cpu] == 1?
+	ldreq	r12, [r1]
+	cmpeq	r12, r0			@ !turn == cpu?
+	beq	1b			@ while !turn == cpu && flag[!cpu] == 1
+
+	mov	pc, lr			@ locked
+ENDPROC(tegra_pen_lock)
+
+ENTRY(tegra_pen_unlock)
+	dsb
+	mov32	r3, TEGRA_PMC_VIRT
+	cpu_id	r0
+	cmp	r0, #0
+	addeq	r2, r3, #PMC_SCRATCH38
+	addne	r2, r3, #PMC_SCRATCH39
+	mov	r12, #0
+	str	r12, [r2]
+	mov     pc, lr
+ENDPROC(tegra_pen_unlock)
+
+/*
+ * tegra20_cpu_clear_resettable(void)
+ *
+ * Called to clear the "resettable soon" flag in PMC_SCRATCH41 when
+ * it is expected that the secondary CPU will be idle soon.
+ */
+ENTRY(tegra20_cpu_clear_resettable)
+	mov32	r1, TEGRA_PMC_VIRT + PMC_SCRATCH41
+	mov	r12, #CPU_NOT_RESETTABLE
+	str	r12, [r1]
+	mov	pc, lr
+ENDPROC(tegra20_cpu_clear_resettable)
+
+/*
+ * tegra20_cpu_set_resettable_soon(void)
+ *
+ * Called to set the "resettable soon" flag in PMC_SCRATCH41 when
+ * it is expected that the secondary CPU will be idle soon.
+ */
+ENTRY(tegra20_cpu_set_resettable_soon)
+	mov32	r1, TEGRA_PMC_VIRT + PMC_SCRATCH41
+	mov	r12, #CPU_RESETTABLE_SOON
+	str	r12, [r1]
+	mov	pc, lr
+ENDPROC(tegra20_cpu_set_resettable_soon)
+
+/*
+ * tegra20_sleep_cpu_secondary_finish(unsigned long v2p)
+ *
+ * Enters WFI on secondary CPU by exiting coherency.
+ */
+ENTRY(tegra20_sleep_cpu_secondary_finish)
+	stmfd	sp!, {r4-r11, lr}
+
+	mrc	p15, 0, r11, c1, c0, 1  @ save actlr before exiting coherency
+
+	/* Flush and disable the L1 data cache */
+	bl	tegra_disable_clean_inv_dcache
+
+	mov32	r0, TEGRA_PMC_VIRT + PMC_SCRATCH41
+	mov	r3, #CPU_RESETTABLE
+	str	r3, [r0]
+
+	bl	cpu_do_idle
+
+	/*
+	 * cpu may be reset while in wfi, which will return through
+	 * tegra_resume to cpu_resume
+	 * or interrupt may wake wfi, which will return here
+	 * cpu state is unchanged - MMU is on, cache is on, coherency
+	 * is off, and the data cache is off
+	 *
+	 * r11 contains the original actlr
+	 */
+
+	bl	tegra_pen_lock
+
+	mov32	r3, TEGRA_PMC_VIRT
+	add	r0, r3, #PMC_SCRATCH41
+	mov	r3, #CPU_NOT_RESETTABLE
+	str	r3, [r0]
+
+	bl	tegra_pen_unlock
+
+	/* Re-enable the data cache */
+	mrc	p15, 0, r10, c1, c0, 0
+	orr	r10, r10, #CR_C
+	mcr	p15, 0, r10, c1, c0, 0
+	isb
+
+	mcr	p15, 0, r11, c1, c0, 1	@ reenable coherency
+
+	/* Invalidate the TLBs & BTAC */
+	mov	r1, #0
+	mcr	p15, 0, r1, c8, c3, 0	@ invalidate shared TLBs
+	mcr	p15, 0, r1, c7, c1, 6	@ invalidate shared BTAC
+	dsb
+	isb
+
+	/* the cpu was running with coherency disabled,
+	 * caches may be out of date */
+	bl	v7_flush_kern_cache_louis
+
+	ldmfd	sp!, {r4 - r11, pc}
+ENDPROC(tegra20_sleep_cpu_secondary_finish)
+#endif
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 9821ee7..a02f71a 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -25,6 +25,19 @@
 					+ IO_PPSB_VIRT)
 #define TEGRA_CLK_RESET_VIRT (TEGRA_CLK_RESET_BASE - IO_PPSB_PHYS \
 					+ IO_PPSB_VIRT)
+#define TEGRA_PMC_VIRT	(TEGRA_PMC_BASE - IO_APB_PHYS + IO_APB_VIRT)
+
+/* PMC_SCRATCH37-39 and 41 are used for tegra_pen_lock and idle */
+#define PMC_SCRATCH37	0x130
+#define PMC_SCRATCH38	0x134
+#define PMC_SCRATCH39	0x138
+#define PMC_SCRATCH41	0x140
+
+#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+#define CPU_RESETTABLE		2
+#define CPU_RESETTABLE_SOON	1
+#define CPU_NOT_RESETTABLE	0
+#endif
 
 #ifdef __ASSEMBLY__
 /* returns the offset of the flow controller halt register for a cpu */
@@ -104,6 +117,8 @@ exit_l2_resume:
 .endm
 #endif /* CONFIG_CACHE_L2X0 */
 #else
+void tegra_pen_lock(void);
+void tegra_pen_unlock(void);
 void tegra_resume(void);
 int tegra_sleep_cpu_finish(unsigned long);
 
@@ -115,6 +130,14 @@ static inline void tegra20_hotplug_init(void) {}
 static inline void tegra30_hotplug_init(void) {}
 #endif
 
+void tegra20_cpu_clear_resettable(void);
+#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+void tegra20_cpu_set_resettable_soon(void);
+#else
+static inline void tegra20_cpu_set_resettable_soon(void) {}
+#endif
+
+int tegra20_sleep_cpu_secondary_finish(unsigned long);
 int tegra30_sleep_cpu_secondary_finish(unsigned long);
 void tegra30_tear_down_cpu(void);
 
-- 
1.7.0.4
