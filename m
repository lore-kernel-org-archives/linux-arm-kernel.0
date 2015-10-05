From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  5 Oct 2015 18:02:01 +0100
Subject: [PATCH v2 12/22] arm64: Delay cpu feature checks
In-Reply-To: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444064531-25607-13-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment we run through the arm64_features capability list for
each CPU and set the capability if one of the CPU supports it. This
could be problematic in a heterogeneous system with differing capabilities.
Delay the CPU feature checks until all the enabled CPUs are up, so that
we can make better decisions based on the overall system capability.

The CPU errata checks are not delayed and is still executed per-CPU
to detect the respective capabilities. If we ever come across a non-errata
capability that needs to be checked on each-CPU, we could introduce them via
a new capability table(or introduce a flag), which can be processed per CPU.

Registers a hotplug notifier to run through the system capabilities and
and ensure that the new hotplugged CPU has all the enabled capabilities
and enables it on this CPU. If the CPU is missing at least one of the
capabilities established at boot up, the CPU is prevented from being marked
online to avoid unexpected system behavior.

Renames the check_local_cpu_features() => check_cpu_features().
The next patch will make the feature checks use the system wide
safe value of a feature register.

NOTE: The enable() methods associated with the capability is scheduled
on all the CPUs (which is the only use case). If we need a different type
of 'enable()' which only needs to be run once on any CPU, we should be
able to handle that when needed.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    3 +-
 arch/arm64/include/asm/processor.h  |    2 +-
 arch/arm64/kernel/cpufeature.c      |  115 +++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/cpuinfo.c         |    1 -
 arch/arm64/mm/fault.c               |    2 +-
 5 files changed, 113 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 2e17f9b..cbf3c62 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -71,7 +71,7 @@ struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
 	bool (*matches)(const struct arm64_cpu_capabilities *);
-	void (*enable)(void);
+	void (*enable)(void *);
 	union {
 		struct {	/* To be used for erratum handling only */
 			u32 midr_model;
@@ -141,7 +141,6 @@ void __init setup_cpu_features(void);
 void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info);
 void check_local_cpu_errata(void);
-void check_local_cpu_features(void);
 bool cpu_supports_mixed_endian_el0(void);
 bool system_supports_mixed_endian_el0(void);
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 98f3235..4acb7ca 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -186,6 +186,6 @@ static inline void spin_lock_prefetch(const void *x)
 
 #endif
 
-void cpu_enable_pan(void);
+void cpu_enable_pan(void *__unused);
 
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 3506876..573a244 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -18,6 +18,7 @@
 
 #define pr_fmt(fmt) "CPU features: " fmt
 
+#include <linux/notifier.h>
 #include <linux/types.h>
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
@@ -647,16 +648,119 @@ void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 		cpus_set_cap(caps[i].capability);
 	}
 
-	/* second pass allows enable() to consider interacting capabilities */
-	for (i = 0; caps[i].desc; i++) {
-		if (cpus_have_cap(caps[i].capability) && caps[i].enable)
-			caps[i].enable();
+	/*
+	 * second pass allows enable() invoked on active each CPU
+	 * to consider interacting capabilities.
+	 */
+	for (i = 0; caps[i].desc; i++)
+		if (caps[i].enable && cpus_have_cap(caps[i].capability))
+			on_each_cpu(caps[i].enable, NULL, true);
+}
+
+/*
+ * read_cpu_sysreg() - Used by a STARTING cpu before cpuinfo is populated.
+ */
+static u64 read_cpu_sysreg(u32 sys_id)
+{
+	switch(sys_id) {
+	case SYS_ID_PFR0_EL1:		return (u64)read_cpuid(ID_PFR0_EL1);
+	case SYS_ID_PFR1_EL1:		return (u64)read_cpuid(ID_PFR1_EL1);
+	case SYS_ID_DFR0_EL1:		return (u64)read_cpuid(ID_DFR0_EL1);
+	case SYS_ID_MMFR0_EL1:		return (u64)read_cpuid(ID_MMFR0_EL1);
+	case SYS_ID_MMFR1_EL1:		return (u64)read_cpuid(ID_MMFR1_EL1);
+	case SYS_ID_MMFR2_EL1:		return (u64)read_cpuid(ID_MMFR2_EL1);
+	case SYS_ID_MMFR3_EL1:		return (u64)read_cpuid(ID_MMFR3_EL1);
+	case SYS_ID_ISAR0_EL1:		return (u64)read_cpuid(ID_ISAR0_EL1);
+	case SYS_ID_ISAR1_EL1:		return (u64)read_cpuid(ID_ISAR1_EL1);
+	case SYS_ID_ISAR2_EL1:		return (u64)read_cpuid(ID_ISAR2_EL1);
+	case SYS_ID_ISAR3_EL1:		return (u64)read_cpuid(ID_ISAR3_EL1);
+	case SYS_ID_ISAR4_EL1:		return (u64)read_cpuid(ID_ISAR4_EL1);
+	case SYS_ID_ISAR5_EL1:		return (u64)read_cpuid(ID_ISAR4_EL1);
+	case SYS_MVFR0_EL1:		return (u64)read_cpuid(MVFR0_EL1);
+	case SYS_MVFR1_EL1:		return (u64)read_cpuid(MVFR1_EL1);
+	case SYS_MVFR2_EL1:		return (u64)read_cpuid(MVFR2_EL1);
+
+	case SYS_ID_AA64PFR0_EL1:	return (u64)read_cpuid(ID_AA64PFR0_EL1);
+	case SYS_ID_AA64PFR1_EL1:	return (u64)read_cpuid(ID_AA64PFR0_EL1);
+	case SYS_ID_AA64DFR0_EL1:	return (u64)read_cpuid(ID_AA64DFR0_EL1);
+	case SYS_ID_AA64DFR1_EL1:	return (u64)read_cpuid(ID_AA64DFR0_EL1);
+	case SYS_ID_AA64MMFR0_EL1:	return (u64)read_cpuid(ID_AA64MMFR0_EL1);
+	case SYS_ID_AA64MMFR1_EL1:	return (u64)read_cpuid(ID_AA64MMFR1_EL1);
+	case SYS_ID_AA64ISAR0_EL1:	return (u64)read_cpuid(ID_AA64ISAR0_EL1);
+	case SYS_ID_AA64ISAR1_EL1:	return (u64)read_cpuid(ID_AA64ISAR1_EL1);
+
+	case SYS_CNTFRQ_EL0:		return (u64)read_cpuid(CNTFRQ_EL0);
+	case SYS_CTR_EL0:		return (u64)read_cpuid(CTR_EL0);
+	case SYS_DCZID_EL0:		return (u64)read_cpuid(DCZID_EL0);
+	default:
+		BUG();
+		return 0;
 	}
 }
 
-void check_local_cpu_features(void)
+/*
+ * Park the CPU which doesn't have the capability as advertised
+ * by the system.
+ */
+static void fail_incapable_cpu(char *cap_type,
+				 const struct arm64_cpu_capabilities *cap)
+{
+	/*XXX: Are we really safe to call printk here ? */
+	pr_crit("FATAL: CPU%d is missing %s : %s \n",
+			smp_processor_id(), cap_type, cap->desc);
+	asm volatile(
+			" 1:	wfe \n\t"
+			"	b 1b\n"
+		    );
+}
+/*
+ * Run through the enabled system capabilities and enable() it on this CPU.
+ * The capabilities were decided based on the available CPUs at the boot time.
+ * Any new CPU should match the system wide status of the capability. If the
+ * new CPU doesn't have a capability which the system now has enabled, we
+ * cannot do anything to fix it up and could cause unexpected failures. So
+ * we hold the CPU in a black hole.
+ */
+void cpu_enable_features(void)
+{
+	int i;
+	const struct arm64_cpu_capabilities *caps = arm64_features;
+
+	for(i = 0; caps[i].desc; i++)
+		if (caps[i].enable && cpus_have_cap(caps[i].capability))
+			caps[i].enable(NULL);
+	for(i = 0; caps[i].desc; i++) {
+		if(!cpus_have_cap(caps[i].capability) || !caps[i].sys_reg)
+			continue;
+		/*
+		 * If the new CPU misses an advertised feature, we cannot proceed
+		 * further, park the cpu.
+		 */
+		if (!feature_matches(read_cpu_sysreg(caps[i].sys_reg), &caps[i]))
+			fail_incapable_cpu("arm64_features", &caps[i]);
+		if (caps[i].enable)
+			caps[i].enable(NULL);
+	}
+}
+
+static int cpu_feature_hotplug_notify(struct notifier_block *nb,
+				unsigned long action, void *hcpu)
+{
+	if ((action & ~CPU_TASKS_FROZEN) == CPU_STARTING)
+		cpu_enable_features();
+	return notifier_from_errno(0);
+}
+
+/* Run the notifier before initialising GIC CPU interface. */
+static struct notifier_block cpu_feature_notifier = {
+	.notifier_call = cpu_feature_hotplug_notify,
+	.priority = 101,
+};
+
+void check_cpu_features(void)
 {
 	check_cpu_capabilities(arm64_features, "detected feature:");
+	register_cpu_notifier(&cpu_feature_notifier);
 }
 
 bool cpu_supports_mixed_endian_el0(void)
@@ -676,6 +780,7 @@ void __init setup_cpu_features(void)
 	u32 cwg;
 	int cls;
 
+	check_cpu_features();
 	/*
 	 * Check for sane CTR_EL0.CWG value.
 	 */
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index f25869e..789fbea 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -229,7 +229,6 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	cpuinfo_detect_icache_policy(info);
 
 	check_local_cpu_errata();
-	check_local_cpu_features();
 }
 
 void cpuinfo_store_cpu(void)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index aba9ead..066d5ae 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -555,7 +555,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 }
 
 #ifdef CONFIG_ARM64_PAN
-void cpu_enable_pan(void)
+void cpu_enable_pan(void *__unused)
 {
 	config_sctlr_el1(SCTLR_EL1_SPAN, 0);
 }
-- 
1.7.9.5
