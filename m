From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 May 2018 18:32:22 +0100
Subject: [PATCHv2 3/4] firmware/psci: use common SMCCC_CONDUIT_*
In-Reply-To: <20180531173223.9668-1-mark.rutland@arm.com>
References: <20180531173223.9668-1-mark.rutland@arm.com>
Message-ID: <20180531173223.9668-4-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have common SMCCC_CONDUIT_* definitions, migrate the PSCI
code over to them, and kill off the old PSCI_CONDUIT_* definitions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 drivers/firmware/psci.c | 25 +++++++++----------------
 include/linux/psci.h    |  9 ++-------
 2 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index d855c20de663..6d7d3ccc3a39 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -60,7 +60,7 @@ bool psci_tos_resident_on(int cpu)
 }
 
 struct psci_operations psci_ops = {
-	.conduit = PSCI_CONDUIT_NONE,
+	.conduit = SMCCC_CONDUIT_NONE,
 	.smccc_version = SMCCC_VERSION_1_0,
 };
 
@@ -69,14 +69,7 @@ enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
 	if (psci_ops.smccc_version < SMCCC_VERSION_1_1)
 		return SMCCC_CONDUIT_NONE;
 
-	switch (psci_ops.conduit) {
-	case PSCI_CONDUIT_SMC:
-		return SMCCC_CONDUIT_SMC;
-	case PSCI_CONDUIT_HVC:
-		return SMCCC_CONDUIT_HVC;
-	default:
-		return SMCCC_CONDUIT_NONE;
-	}
+	return psci_ops.conduit;
 }
 
 typedef unsigned long (psci_fn)(unsigned long, unsigned long,
@@ -228,13 +221,13 @@ static unsigned long psci_migrate_info_up_cpu(void)
 			      0, 0, 0);
 }
 
-static void set_conduit(enum psci_conduit conduit)
+static void set_conduit(enum arm_smccc_conduit conduit)
 {
 	switch (conduit) {
-	case PSCI_CONDUIT_HVC:
+	case SMCCC_CONDUIT_HVC:
 		invoke_psci_fn = __invoke_psci_fn_hvc;
 		break;
-	case PSCI_CONDUIT_SMC:
+	case SMCCC_CONDUIT_SMC:
 		invoke_psci_fn = __invoke_psci_fn_smc;
 		break;
 	default:
@@ -256,9 +249,9 @@ static int get_set_conduit_method(struct device_node *np)
 	}
 
 	if (!strcmp("hvc", method)) {
-		set_conduit(PSCI_CONDUIT_HVC);
+		set_conduit(SMCCC_CONDUIT_HVC);
 	} else if (!strcmp("smc", method)) {
-		set_conduit(PSCI_CONDUIT_SMC);
+		set_conduit(SMCCC_CONDUIT_SMC);
 	} else {
 		pr_warn("invalid \"method\" property: %s\n", method);
 		return -EINVAL;
@@ -714,9 +707,9 @@ int __init psci_acpi_init(void)
 	pr_info("probing for conduit method from ACPI.\n");
 
 	if (acpi_psci_use_hvc())
-		set_conduit(PSCI_CONDUIT_HVC);
+		set_conduit(SMCCC_CONDUIT_HVC);
 	else
-		set_conduit(PSCI_CONDUIT_SMC);
+		set_conduit(SMCCC_CONDUIT_SMC);
 
 	return psci_probe();
 }
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 8b1b3b5935ab..affcd2128df8 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -14,6 +14,7 @@
 #ifndef __LINUX_PSCI_H
 #define __LINUX_PSCI_H
 
+#include <linux/arm-smccc.h>
 #include <linux/init.h>
 #include <linux/types.h>
 
@@ -25,12 +26,6 @@ bool psci_tos_resident_on(int cpu);
 int psci_cpu_init_idle(unsigned int cpu);
 int psci_cpu_suspend_enter(unsigned long index);
 
-enum psci_conduit {
-	PSCI_CONDUIT_NONE,
-	PSCI_CONDUIT_SMC,
-	PSCI_CONDUIT_HVC,
-};
-
 enum smccc_version {
 	SMCCC_VERSION_1_0,
 	SMCCC_VERSION_1_1,
@@ -45,7 +40,7 @@ struct psci_operations {
 	int (*affinity_info)(unsigned long target_affinity,
 			unsigned long lowest_affinity_level);
 	int (*migrate_info_type)(void);
-	enum psci_conduit conduit;
+	enum arm_smccc_conduit conduit;
 	enum smccc_version smccc_version;
 };
 
-- 
2.11.0
