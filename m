From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 16 May 2017 15:18:05 +0100
Subject: [PATCHv5] arm64/cpufeature: don't use mutex in bringup path
Message-ID: <1494944285-12152-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, cpus_set_cap() calls static_branch_enable_cpuslocked(), which
must take the jump_label mutex.

We call cpus_set_cap() in the secondary bringup path, from the idle
thread where interrupts are disabled. Taking a mutex in this path "is a
NONO" regardless of whether it's contended, and something we must avoid.
We didn't spot this until recently, as ___might_sleep() won't warn for
this case until all CPUs have been brought up.

This patch avoids taking the mutex in the secondary bringup path. The
poking of static keys is deferred until enable_cpu_capabilities(), which
runs in a suitable context on the boot CPU. To account for the static
keys being set later, cpus_have_const_cap() is updated to use another
static key to check whether the const cap keys have been initialised,
falling back to the caps bitmap until this is the case.

This means that users of cpus_have_const_cap() gain should only gain a
single additional NOP in the fast path once the const caps are
initialised, but should always see the current cap value.

The hyp code should never dereference the caps array, since the caps are
initialized before we run the module initcall to initialise hyp. A check
is added to the hyp init code to document this requirement.

This change will sidestep a number of issues when the upcoming hotplug
locking rework is merged.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyniger <marc.zyngier@arm.com>
Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm64/include/asm/cpufeature.h | 12 ++++++++++--
 arch/arm64/include/asm/kvm_host.h   |  8 ++++++--
 arch/arm64/kernel/cpufeature.c      | 23 +++++++++++++++++++++--
 3 files changed, 37 insertions(+), 6 deletions(-)

Catalin, can you take this as a fix for v4.12?

Thomas has zapped the tip smp/hotplug branch, so we won't see a conflict in
linux-next with the prior attempt to clean this up.

Thanks,
Mark.

Since v1 [1]:
* Kill redundant update_cpu_errata_workarounds() prototype
* Introduce arm64_const_caps_ready
Since v2 [2]:
* Add hyp init check
* Clean up commit message
* Drop fixes tag
Since v3 [3]:
* Fix typos
* Accumulate tags
Since v4 [4]:
* Rebase to v4.12-rc1, so this can go via the arm64 tree
* Clean up commit message

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/505731.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/505763.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/505887.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/505964.html

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index e7f84a7..428ee1f 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -115,6 +115,7 @@ struct arm64_cpu_capabilities {
 
 extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
+extern struct static_key_false arm64_const_caps_ready;
 
 bool this_cpu_has_cap(unsigned int cap);
 
@@ -124,7 +125,7 @@ static inline bool cpu_have_feature(unsigned int num)
 }
 
 /* System capability check for constant caps */
-static inline bool cpus_have_const_cap(int num)
+static inline bool __cpus_have_const_cap(int num)
 {
 	if (num >= ARM64_NCAPS)
 		return false;
@@ -138,6 +139,14 @@ static inline bool cpus_have_cap(unsigned int num)
 	return test_bit(num, cpu_hwcaps);
 }
 
+static inline bool cpus_have_const_cap(int num)
+{
+	if (static_branch_likely(&arm64_const_caps_ready))
+		return __cpus_have_const_cap(num);
+	else
+		return cpus_have_cap(num);
+}
+
 static inline void cpus_set_cap(unsigned int num)
 {
 	if (num >= ARM64_NCAPS) {
@@ -145,7 +154,6 @@ static inline void cpus_set_cap(unsigned int num)
 			num, ARM64_NCAPS);
 	} else {
 		__set_bit(num, cpu_hwcaps);
-		static_branch_enable(&cpu_hwcap_keys[num]);
 	}
 }
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 5e19165..1f252a9 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -24,6 +24,7 @@
 
 #include <linux/types.h>
 #include <linux/kvm_types.h>
+#include <asm/cpufeature.h>
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmio.h>
@@ -355,9 +356,12 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 				       unsigned long vector_ptr)
 {
 	/*
-	 * Call initialization code, and switch to the full blown
-	 * HYP code.
+	 * Call initialization code, and switch to the full blown HYP code.
+	 * If the cpucaps haven't been finalized yet, something has gone very
+	 * wrong, and hyp will crash and burn when it uses any
+	 * cpus_have_const_cap() wrapper.
 	 */
+	BUG_ON(!static_branch_likely(&arm64_const_caps_ready));
 	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr);
 }
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 94b8f7f..817ce33 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -985,8 +985,16 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
  */
 void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 {
-	for (; caps->matches; caps++)
-		if (caps->enable && cpus_have_cap(caps->capability))
+	for (; caps->matches; caps++) {
+		unsigned int num = caps->capability;
+
+		if (!cpus_have_cap(num))
+			continue;
+
+		/* Ensure cpus_have_const_cap(num) works */
+		static_branch_enable(&cpu_hwcap_keys[num]);
+
+		if (caps->enable) {
 			/*
 			 * Use stop_machine() as it schedules the work allowing
 			 * us to modify PSTATE, instead of on_each_cpu() which
@@ -994,6 +1002,8 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 			 * we return.
 			 */
 			stop_machine(caps->enable, NULL, cpu_online_mask);
+		}
+	}
 }
 
 /*
@@ -1096,6 +1106,14 @@ static void __init setup_feature_capabilities(void)
 	enable_cpu_capabilities(arm64_features);
 }
 
+DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
+EXPORT_SYMBOL(arm64_const_caps_ready);
+
+static void __init mark_const_caps_ready(void)
+{
+	static_branch_enable(&arm64_const_caps_ready);
+}
+
 /*
  * Check if the current CPU has a given feature capability.
  * Should be called from non-preemptible context.
@@ -1131,6 +1149,7 @@ void __init setup_cpu_features(void)
 	/* Set the CPU feature capabilies */
 	setup_feature_capabilities();
 	enable_errata_workarounds();
+	mark_const_caps_ready();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0())
-- 
1.9.1
