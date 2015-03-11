From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 11 Mar 2015 20:39:36 +0800
Subject: [PATCH v10 10/21] ARM64 / ACPI: Get PSCI flags in FADT for PSCI init
In-Reply-To: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1426077587-1561-11-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graeme Gregory <graeme.gregory@linaro.org>

There are two flags: PSCI_COMPLIANT and PSCI_USE_HVC. When set,
the former signals to the OS that the firmware is PSCI compliant.
The latter selects the appropriate conduit for PSCI calls by
toggling between Hypervisor Calls (HVC) and Secure Monitor Calls
(SMC).

FADT table contains such information in ACPI 5.1, FADT table was
parsed in ACPI table init and copy to struct acpi_gbl_FADT, so
use the flags in struct acpi_gbl_FADT for PSCI init.

Since ACPI 5.1 doesn't support self defined PSCI function IDs,
which means that only PSCI 0.2+ is supported in ACPI.

CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Jon Masters <jcm@redhat.com>
Tested-by: Timur Tabi <timur@codeaurora.org>
Tested-by: Robert Richter <rrichter@cavium.com>
Acked-by: Robert Richter <rrichter@cavium.com>
Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/acpi.h | 15 +++++++++
 arch/arm64/include/asm/psci.h |  3 +-
 arch/arm64/kernel/psci.c      | 78 ++++++++++++++++++++++++++++++-------------
 arch/arm64/kernel/setup.c     |  8 +++--
 4 files changed, 76 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index c5a9b97..9ea650c 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -32,6 +32,18 @@ extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
 
+/* 1 to indicate PSCI 0.2+ is implemented */
+static inline bool acpi_psci_present(void)
+{
+	return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_COMPLIANT;
+}
+
+/* 1 to indicate HVC must be used instead of SMC as the PSCI conduit */
+static inline bool acpi_psci_use_hvc(void)
+{
+	return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_USE_HVC;
+}
+
 static inline void disable_acpi(void)
 {
 	acpi_disabled = 1;
@@ -60,6 +72,9 @@ static inline bool acpi_has_cpu_in_madt(void)
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 
+#else
+static inline bool acpi_psci_present(void) { return false; }
+static inline bool acpi_psci_use_hvc(void) { return false; }
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/arm64/include/asm/psci.h b/arch/arm64/include/asm/psci.h
index e5312ea..2454bc5 100644
--- a/arch/arm64/include/asm/psci.h
+++ b/arch/arm64/include/asm/psci.h
@@ -14,6 +14,7 @@
 #ifndef __ASM_PSCI_H
 #define __ASM_PSCI_H
 
-int psci_init(void);
+int psci_dt_init(void);
+int psci_acpi_init(void);
 
 #endif /* __ASM_PSCI_H */
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 9b8a70a..d3c52ce 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -15,6 +15,7 @@
 
 #define pr_fmt(fmt) "psci: " fmt
 
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/smp.h>
@@ -24,6 +25,7 @@
 #include <linux/slab.h>
 #include <uapi/linux/psci.h>
 
+#include <asm/acpi.h>
 #include <asm/compiler.h>
 #include <asm/cpu_ops.h>
 #include <asm/errno.h>
@@ -273,6 +275,33 @@ static void psci_sys_poweroff(void)
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
 }
 
+static void __init psci_0_2_set_functions(void)
+{
+	pr_info("Using standard PSCI v0.2 function IDs\n");
+	psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_0_2_FN64_CPU_SUSPEND;
+	psci_ops.cpu_suspend = psci_cpu_suspend;
+
+	psci_function_id[PSCI_FN_CPU_OFF] = PSCI_0_2_FN_CPU_OFF;
+	psci_ops.cpu_off = psci_cpu_off;
+
+	psci_function_id[PSCI_FN_CPU_ON] = PSCI_0_2_FN64_CPU_ON;
+	psci_ops.cpu_on = psci_cpu_on;
+
+	psci_function_id[PSCI_FN_MIGRATE] = PSCI_0_2_FN64_MIGRATE;
+	psci_ops.migrate = psci_migrate;
+
+	psci_function_id[PSCI_FN_AFFINITY_INFO] = PSCI_0_2_FN64_AFFINITY_INFO;
+	psci_ops.affinity_info = psci_affinity_info;
+
+	psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE] =
+		PSCI_0_2_FN_MIGRATE_INFO_TYPE;
+	psci_ops.migrate_info_type = psci_migrate_info_type;
+
+	arm_pm_restart = psci_sys_reset;
+
+	pm_power_off = psci_sys_poweroff;
+}
+
 /*
  * PSCI Function IDs for v0.2+ are well defined so use
  * standard values.
@@ -306,29 +335,7 @@ static int __init psci_0_2_init(struct device_node *np)
 		}
 	}
 
-	pr_info("Using standard PSCI v0.2 function IDs\n");
-	psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_0_2_FN64_CPU_SUSPEND;
-	psci_ops.cpu_suspend = psci_cpu_suspend;
-
-	psci_function_id[PSCI_FN_CPU_OFF] = PSCI_0_2_FN_CPU_OFF;
-	psci_ops.cpu_off = psci_cpu_off;
-
-	psci_function_id[PSCI_FN_CPU_ON] = PSCI_0_2_FN64_CPU_ON;
-	psci_ops.cpu_on = psci_cpu_on;
-
-	psci_function_id[PSCI_FN_MIGRATE] = PSCI_0_2_FN64_MIGRATE;
-	psci_ops.migrate = psci_migrate;
-
-	psci_function_id[PSCI_FN_AFFINITY_INFO] = PSCI_0_2_FN64_AFFINITY_INFO;
-	psci_ops.affinity_info = psci_affinity_info;
-
-	psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE] =
-		PSCI_0_2_FN_MIGRATE_INFO_TYPE;
-	psci_ops.migrate_info_type = psci_migrate_info_type;
-
-	arm_pm_restart = psci_sys_reset;
-
-	pm_power_off = psci_sys_poweroff;
+	psci_0_2_set_functions();
 
 out_put_node:
 	of_node_put(np);
@@ -381,7 +388,7 @@ static const struct of_device_id psci_of_match[] __initconst = {
 	{},
 };
 
-int __init psci_init(void)
+int __init psci_dt_init(void)
 {
 	struct device_node *np;
 	const struct of_device_id *matched_np;
@@ -396,6 +403,29 @@ int __init psci_init(void)
 	return init_fn(np);
 }
 
+/*
+ * We use PSCI 0.2+ when ACPI is deployed on ARM64 and it's
+ * explicitly clarified in SBBR
+ */
+int __init psci_acpi_init(void)
+{
+	if (!acpi_psci_present()) {
+		pr_info("is not implemented in ACPI.\n");
+		return -EOPNOTSUPP;
+	}
+
+	pr_info("probing for conduit method from ACPI.\n");
+
+	if (acpi_psci_use_hvc())
+		invoke_psci_fn = __invoke_psci_fn_hvc;
+	else
+		invoke_psci_fn = __invoke_psci_fn_smc;
+
+	psci_0_2_set_functions();
+
+	return 0;
+}
+
 #ifdef CONFIG_SMP
 
 static int __init cpu_psci_cpu_init(struct device_node *dn, unsigned int cpu)
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index e8c7000..97fa7f3 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -390,10 +390,12 @@ void __init setup_arch(char **cmdline_p)
 
 	early_ioremap_reset();
 
-	if (acpi_disabled)
+	if (acpi_disabled) {
 		unflatten_device_tree();
-
-	psci_init();
+		psci_dt_init();
+	} else {
+		psci_acpi_init();
+	}
 
 	cpu_read_bootcpu_ops();
 #ifdef CONFIG_SMP
-- 
1.9.1
