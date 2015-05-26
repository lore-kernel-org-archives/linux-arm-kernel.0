From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 14:52:28 +0100
Subject: [PATCHv3 10/12] drivers: psci: support native SMC{32,64} calls
In-Reply-To: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
References: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1432648350-5454-11-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A 32-bit OS cannot make calls with SMC64 IDs, while a 64-bit OS must
invoke some PSCI functions with SMC64 IDs.

This patch introduces and makes use of a new macro to choose the
appropriate IDs based on the register width of the OS, which will allow
32-bit callers to use the PSCI client code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/firmware/psci.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 07b2daa..81b70da 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -28,6 +28,18 @@
 #include <asm/smp_plat.h>
 
 /*
+ * While a 64-bit OS can make calls with SMC32 calling conventions, for some
+ * calls it is necessary to use SMC64 to pass or return 64-bit values. For such
+ * calls PSCI_0_2_FN_NATIVE(x) will choose the appropriate (native-width)
+ * function ID.
+ */
+#ifdef CONFIG_64BIT
+#define PSCI_0_2_FN_NATIVE(name)	PSCI_0_2_FN64_##name
+#else
+#define PSCI_0_2_FN_NATIVE(name)	PSCI_0_2_FN_##name
+#endif
+
+/*
  * The CPU any Trusted OS is resident on. The trusted OS may reject CPU_OFF
  * calls to its resident CPU, so we must avoid issuing those. We never migrate
  * a Trusted OS even if it claims to be capable of migration -- doing so will
@@ -122,8 +134,8 @@ static int psci_migrate(unsigned long cpuid)
 static int psci_affinity_info(unsigned long target_affinity,
 		unsigned long lowest_affinity_level)
 {
-	return invoke_psci_fn(PSCI_0_2_FN64_AFFINITY_INFO, target_affinity,
-			      lowest_affinity_level, 0);
+	return invoke_psci_fn(PSCI_0_2_FN_NATIVE(AFFINITY_INFO),
+			      target_affinity, lowest_affinity_level, 0);
 }
 
 static int psci_migrate_info_type(void)
@@ -133,7 +145,8 @@ static int psci_migrate_info_type(void)
 
 static unsigned long psci_migrate_info_up_cpu(void)
 {
-	return invoke_psci_fn(PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU, 0, 0, 0);
+	return invoke_psci_fn(PSCI_0_2_FN_NATIVE(MIGRATE_INFO_UP_CPU),
+			      0, 0, 0);
 }
 
 static int get_set_conduit_method(struct device_node *np)
@@ -211,16 +224,16 @@ static void __init psci_init_migrate(void)
 static void __init psci_0_2_set_functions(void)
 {
 	pr_info("Using standard PSCI v0.2 function IDs\n");
-	psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_0_2_FN64_CPU_SUSPEND;
+	psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_0_2_FN_NATIVE(CPU_SUSPEND);
 	psci_ops.cpu_suspend = psci_cpu_suspend;
 
 	psci_function_id[PSCI_FN_CPU_OFF] = PSCI_0_2_FN_CPU_OFF;
 	psci_ops.cpu_off = psci_cpu_off;
 
-	psci_function_id[PSCI_FN_CPU_ON] = PSCI_0_2_FN64_CPU_ON;
+	psci_function_id[PSCI_FN_CPU_ON] = PSCI_0_2_FN_NATIVE(CPU_ON);
 	psci_ops.cpu_on = psci_cpu_on;
 
-	psci_function_id[PSCI_FN_MIGRATE] = PSCI_0_2_FN64_MIGRATE;
+	psci_function_id[PSCI_FN_MIGRATE] = PSCI_0_2_FN_NATIVE(MIGRATE);
 	psci_ops.migrate = psci_migrate;
 
 	psci_ops.affinity_info = psci_affinity_info;
-- 
1.9.1
