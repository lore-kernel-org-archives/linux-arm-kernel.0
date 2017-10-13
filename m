From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 13 Oct 2017 14:32:55 +0100
Subject: [PATCH v4 1/2] arm_arch_timer: Expose event stream status
In-Reply-To: <1507901576-34641-1-git-send-email-julien.thierry@arm.com>
References: <1507901576-34641-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1507901576-34641-2-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch timer configuration for a CPU might get reset after suspending
said CPU.

In order to reliably use the event stream in the kernel (e.g. for delays),
we keep track of the state where we can safely consider the event stream as
properly configured.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/arch_timer.h    |  1 +
 arch/arm64/include/asm/arch_timer.h  |  1 +
 drivers/clocksource/arm_arch_timer.c | 25 ++++++++++++++++++++++---
 include/clocksource/arm_arch_timer.h |  6 ++++++
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index d4ebf56..0b6e104 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -106,6 +106,7 @@ static inline u32 arch_timer_get_cntkctl(void)
 static inline void arch_timer_set_cntkctl(u32 cntkctl)
 {
 	asm volatile("mcr p15, 0, %0, c14, c1, 0" : : "r" (cntkctl));
+	isb();
 }

 #endif
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index a652ce0..bdedd8f 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -144,6 +144,7 @@ static inline u32 arch_timer_get_cntkctl(void)
 static inline void arch_timer_set_cntkctl(u32 cntkctl)
 {
 	write_sysreg(cntkctl, cntkctl_el1);
+	isb();
 }

 static inline u64 arch_counter_get_cntpct(void)
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fd4b7f6..13e6baa 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -77,6 +77,7 @@ struct arch_timer {
 static bool arch_counter_suspend_stop;
 static bool vdso_default = true;

+static cpumask_t evtstrm_available = CPU_MASK_NONE;
 static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);

 static int __init early_evtstrm_cfg(char *buf)
@@ -740,6 +741,7 @@ static void arch_timer_evtstrm_enable(int divider)
 #ifdef CONFIG_COMPAT
 	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
 #endif
+	cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
 }

 static void arch_timer_configure_evtstream(void)
@@ -864,6 +866,16 @@ u32 arch_timer_get_rate(void)
 	return arch_timer_rate;
 }

+bool arch_timer_evtstrm_available(void)
+{
+	/*
+	 * We might get called from a preemptible context. This is fine
+	 * because availability of the event stream should be always the same
+	 * for a preemptible context and context where we might resume a task.
+	 */
+	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
+}
+
 static u64 arch_counter_get_cntvct_mem(void)
 {
 	u32 vct_lo, vct_hi, tmp_hi;
@@ -929,6 +941,8 @@ static int arch_timer_dying_cpu(unsigned int cpu)
 {
 	struct clock_event_device *clk = this_cpu_ptr(arch_timer_evt);

+	cpumask_clear_cpu(smp_processor_id(), &evtstrm_available);
+
 	arch_timer_stop(clk);
 	return 0;
 }
@@ -938,10 +952,16 @@ static int arch_timer_dying_cpu(unsigned int cpu)
 static int arch_timer_cpu_pm_notify(struct notifier_block *self,
 				    unsigned long action, void *hcpu)
 {
-	if (action == CPU_PM_ENTER)
+	if (action == CPU_PM_ENTER) {
 		__this_cpu_write(saved_cntkctl, arch_timer_get_cntkctl());
-	else if (action == CPU_PM_ENTER_FAILED || action == CPU_PM_EXIT)
+
+		cpumask_clear_cpu(smp_processor_id(), &evtstrm_available);
+	} else if (action == CPU_PM_ENTER_FAILED || action == CPU_PM_EXIT) {
 		arch_timer_set_cntkctl(__this_cpu_read(saved_cntkctl));
+
+		if (elf_hwcap & HWCAP_EVTSTRM)
+			cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
+	}
 	return NOTIFY_OK;
 }

@@ -1017,7 +1037,6 @@ static int __init arch_timer_register(void)
 	if (err)
 		goto out_unreg_notify;

-
 	/* Register and immediately configure the timer on the boot CPU */
 	err = cpuhp_setup_state(CPUHP_AP_ARM_ARCH_TIMER_STARTING,
 				"clockevents/arm/arch_timer:starting",
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index cc805b7..4e28283 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -93,6 +93,7 @@ struct arch_timer_mem {
 extern u32 arch_timer_get_rate(void);
 extern u64 (*arch_timer_read_counter)(void);
 extern struct arch_timer_kvm_info *arch_timer_get_kvm_info(void);
+extern bool arch_timer_evtstrm_available(void);

 #else

@@ -106,6 +107,11 @@ static inline u64 arch_timer_read_counter(void)
 	return 0;
 }

+static inline bool arch_timer_evtstrm_available(void)
+{
+	return false;
+}
+
 #endif

 #endif
--
1.9.1
