From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 May 2015 11:38:17 +0100
Subject: [PATCHv2 06/12] arm64: psci: account for Trusted OS instances
In-Reply-To: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1431945503-6939-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Software resident in the secure world (a "Trusted OS") may cause CPU_OFF
calls for the CPU it is resident on to be denied. Such a denial would be
fatal for the kernel, and so we must detect when this can happen before
the point of no return.

This patch implements Trusted OS detection for PSCI 0.2+ systems, using
MIGRATE_INFO_TYPE and MIGRATE_INFO_UP_CPU. When a trusted OS is detected
as resident on a particular CPU, attempts to hot unplug that CPU will be
denied early, before they can prove fatal.

Trusted OS migration is not implemented by this patch. Implementation of
migratable UP trusted OSs seems unlikely, and the right policy for
migration is unclear (and will likely differ across implementations). As
such, it is likely that migration will require cooperation with Trusted
OS drivers.

PSCI implementations prior to 0.1 do not provide the facility to detect
the presence of a Trusted OS, nor the CPU any such OS is resident on, so
without additional information it is not possible to handle Trusted OSs
with PSCI 0.1.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/psci.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 9c4de4b..3ef677e 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -43,6 +43,19 @@ struct psci_power_state {
 	u8	affinity_level;
 };
 
+/*
+ * The CPU any Trusted OS is resident on. The trusted OS may reject CPU_OFF
+ * calls to its resident CPU, so we must avoid issuing those. We never migrate
+ * a Trusted OS even if it claims to be capable of migration -- doing so will
+ * require cooperation with a Trusted OS driver.
+ */
+static int resident_cpu = -1;
+
+static bool psci_tos_resident_on(int cpu)
+{
+	return cpu == resident_cpu;
+}
+
 struct psci_operations {
 	int (*cpu_suspend)(struct psci_power_state state,
 			   unsigned long entry_point);
@@ -172,6 +185,11 @@ static int psci_migrate_info_type(void)
 	return invoke_psci_fn(PSCI_0_2_FN_MIGRATE_INFO_TYPE, 0, 0, 0);
 }
 
+static unsigned long psci_migrate_info_up_cpu(void)
+{
+	return invoke_psci_fn(PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU, 0, 0, 0);
+}
+
 static int __maybe_unused cpu_psci_cpu_init_idle(struct device_node *cpu_node,
 						 unsigned int cpu)
 {
@@ -261,6 +279,40 @@ static void psci_sys_poweroff(void)
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
 }
 
+/*
+ * Detect the presence of a resident Trusted OS which may cause CPU_OFF to
+ * return DENIED (which would be fatal).
+ */
+static void __init psci_init_migrate(void)
+{
+	unsigned long cpuid;
+	int type, cpu;
+
+	type = psci_ops.migrate_info_type();
+
+	if (type == PSCI_0_2_TOS_MP) {
+		pr_info("Trusted OS migration not required\n");
+		return;
+	}
+
+	if (type == PSCI_RET_NOT_SUPPORTED) {
+		pr_info("MIGRATE_INFO_TYPE not supported.\n");
+		return;
+	}
+
+	if (type != PSCI_0_2_TOS_UP_MIGRATE &&
+	    type != PSCI_0_2_TOS_UP_NO_MIGRATE) {
+		pr_err("MIGRATE_INFO_TYPE returned unknown type (%d)\n", type);
+		return;
+	}
+
+	cpuid = psci_migrate_info_up_cpu();
+	cpu = get_logical_index(cpuid);
+	resident_cpu = cpu >= 0 ? cpu : -1;
+
+	pr_info("Trusted OS resident on physical CPU 0x%lx\n", cpuid);
+}
+
 static void __init psci_0_2_set_functions(void)
 {
 	pr_info("Using standard PSCI v0.2 function IDs\n");
@@ -303,6 +355,8 @@ static int __init psci_probe(void)
 
 	psci_0_2_set_functions();
 
+	psci_init_migrate();
+
 	return 0;
 }
 
@@ -449,6 +503,11 @@ static int cpu_psci_cpu_disable(unsigned int cpu)
 	/* Fail early if we don't have CPU_OFF support */
 	if (!psci_ops.cpu_off)
 		return -EOPNOTSUPP;
+
+	/* Trusted OS will deny CPU_OFF */
+	if (psci_tos_resident_on(cpu))
+		return -EPERM;
+
 	return 0;
 }
 
-- 
1.9.1
