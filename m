From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 13 Oct 2015 18:22:22 +0100
Subject: [PATCH v3 14/24] arm64: Delay cpu feature capability checks
In-Reply-To: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
References: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444756952-31145-15-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment we run through the arm64_features capability list for
each CPU and set the capability if one of the CPU supports it. This
could be problematic in a heterogeneous system with differing capabilities.
Delay the CPU feature checks until all the enabled CPUs are up(i.e,
smp_cpus_done(), so that we can make better decisions based on the
overall system capability. Once we decide and advertise the capabilities
the alternatives can be applied. From this state, we cannot roll back
a feature to disabled based on the values from a new hotplugged CPU,
due to the runtime patching and other reasons. So, for all new CPUs,
we need to make sure that they have the established system capabilities.
Failing which, we bring the CPU down, preventing it from turning online.
Adds a hotplug notifier to run through the system capabilities and
and ensure that the new hotplugged CPU has all the enabled capabilities
and also invokes the respective enable() method on the CPU.

The CPU errata checks are not delayed and is still executed per-CPU
to detect the respective capabilities. If we ever come across a non-errata
capability that needs to be checked on each-CPU, we could introduce them via
a new capability table(or introduce a flag), which can be processed per CPU.

Renames the check_local_cpu_features() => check_cpu_features().
The next patch will make the feature checks use the system wide
safe value of a feature register.

NOTE: The enable() methods associated with the capability is scheduled
on all the CPUs (which is the only use case). If we need a different type
of 'enable()' which only needs to be run once on any CPU, we should be
able to handle that when needed.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
Changes since V2:
  - Invoke cpu_die() for incapable cpu
  - Add wfi to the trap for incapable cpu
  - Mark the incapable cpu !present
---
 arch/arm64/include/asm/cpufeature.h |    3 +-
 arch/arm64/include/asm/processor.h  |    2 +-
 arch/arm64/kernel/cpufeature.c      |   79 ++++++++++++++++++++++++++++++++---
 arch/arm64/kernel/cpuinfo.c         |    1 -
 arch/arm64/mm/fault.c               |    2 +-
 5 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 5f1ba6d..4a02a18 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -70,7 +70,7 @@ struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
 	bool (*matches)(const struct arm64_cpu_capabilities *);
-	void (*enable)(void);
+	void (*enable)(void *);
 	union {
 		struct {	/* To be used for erratum handling only */
 			u32 midr_model;
@@ -140,7 +140,6 @@ void __init setup_cpu_features(void);
 void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info);
 void check_local_cpu_errata(void);
-void check_local_cpu_features(void);
 
 u64 read_system_reg(u32 id);
 
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
index 0d1b57e..4360637 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -19,9 +19,11 @@
 #define pr_fmt(fmt) "CPU features: " fmt
 
 #include <linux/bsearch.h>
+#include <linux/notifier.h>
 #include <linux/types.h>
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
+#include <asm/cpu_ops.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
 
@@ -617,16 +619,82 @@ void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 		cpus_set_cap(caps[i].capability);
 	}
 
-	/* second pass allows enable() to consider interacting capabilities */
-	for (i = 0; caps[i].desc; i++) {
-		if (cpus_have_cap(caps[i].capability) && caps[i].enable)
-			caps[i].enable();
+	/*
+	 * For each available capability, invokes enable() on all active CPUs
+	 */
+	for (i = 0; caps[i].desc; i++)
+		if (caps[i].enable && cpus_have_cap(caps[i].capability))
+			on_each_cpu(caps[i].enable, NULL, true);
+}
+
+/*
+ * Park the CPU which doesn't have the capability as advertised
+ * by the system.
+ */
+static void fail_incapable_cpu(char *cap_type,
+				 const struct arm64_cpu_capabilities *cap)
+{
+	int cpu = smp_processor_id();
+
+	pr_crit("CPU%d: missing %s : %s\n", cpu, cap_type, cap->desc);
+	/* Mark this CPU absent */
+	set_cpu_present(cpu, 0);
+	/* Check if we can park ourselves */
+	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
+		cpu_ops[cpu]->cpu_die(cpu);
+
+	asm volatile(
+			" 1:	wfe \n\t"
+			"	wfi \n\t"
+			"	b 1b\n"
+		    );
+}
+
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
+	for(i = 0; caps[i].desc; i++) {
+		if(!cpus_have_cap(caps[i].capability))
+			continue;
+		/*
+		 * If the new CPU misses an advertised feature, we cannot proceed
+		 * further, park the cpu.
+		 */
+		if (!caps[i].matches(&caps[i]))
+			fail_incapable_cpu("arm64_features", &caps[i]);
+		if (caps[i].enable)
+			caps[i].enable(NULL);
 	}
 }
 
-void check_local_cpu_features(void)
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
 
 void __init setup_cpu_features(void)
@@ -636,6 +704,7 @@ void __init setup_cpu_features(void)
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
