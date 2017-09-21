From: mchitale@apm.com (Mayuresh Chitale)
Date: Thu, 21 Sep 2017 12:42:17 +0530
Subject: [PATCH] tee: ACPI support for optee driver
Message-ID: <1505977937-25034-1-git-send-email-mchitale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the optee driver to add support for parsing
the conduit method from an ACPI node.

Signed-off-by: Mayuresh Chitale <mchitale@apm.com>
---
 drivers/tee/optee/core.c | 112 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 35 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 58169e5..8b15c49 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -14,6 +14,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -30,6 +31,7 @@
 #include "optee_smc.h"
 
 #define DRIVER_NAME "optee"
+#define OPTEE_DEVICE "\\_SB.OPTE"
 
 #define OPTEE_SHM_NUM_PRIV_PAGES	1
 
@@ -425,29 +427,87 @@ static void optee_smccc_hvc(unsigned long a0, unsigned long a1,
 	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
 }
 
-static optee_invoke_fn *get_invoke_func(struct device_node *np)
+static const struct of_device_id optee_match[] = {
+	{ .compatible = "linaro,optee-tz" },
+	{},
+};
+
+#ifdef CONFIG_ACPI
+static const char *get_invoke_str_acpi(void)
 {
-	const char *method;
+	struct acpi_device_info *info;
+	const union acpi_object *obj;
+	struct acpi_device *adev;
+	acpi_status status;
+	acpi_handle handle;
 
-	pr_info("probing for conduit method from DT.\n");
+	status = acpi_get_handle(ACPI_ROOT_OBJECT, OPTEE_DEVICE, &handle);
+	if (ACPI_FAILURE(status))
+		return NULL;
 
-	if (of_property_read_string(np, "method", &method)) {
+	status = acpi_get_object_info(handle, &info);
+	if (ACPI_FAILURE(status) || !(info->valid & ACPI_VALID_HID))
+		return NULL;
+
+	if (acpi_bus_get_device(handle, &adev))
+		return NULL;
+
+	if (acpi_dev_get_property(adev, "method",
+				ACPI_TYPE_ANY, &obj))
+		return NULL;
+
+	return obj->string.pointer;
+}
+#endif
+
+static const char *get_invoke_str_of(void)
+{
+	struct device_node *fw_np;
+	const char *method = NULL;
+	struct device_node *np;
+
+	/* Node is supposed to be below /firmware */
+	fw_np = of_find_node_by_name(NULL, "firmware");
+	if (!fw_np)
+		return NULL;
+
+	np = of_find_matching_node(fw_np, optee_match);
+	of_node_put(fw_np);
+	if (!np)
+		return NULL;
+
+	pr_info("probing for conduit method from DT.\n");
+	if (of_property_read_string(np, "method", &method))
 		pr_warn("missing \"method\" property\n");
-		return ERR_PTR(-ENXIO);
-	}
 
-	if (!strcmp("hvc", method))
-		return optee_smccc_hvc;
-	else if (!strcmp("smc", method))
-		return optee_smccc_smc;
+	of_node_put(np);
+	return method;
+}
+
+static optee_invoke_fn *get_invoke_func(void)
+{
+	const char *method;
+
+#ifdef CONFIG_ACPI
+	if (!acpi_disabled)
+		method = get_invoke_str_acpi();
+	else
+#endif
+		method = get_invoke_str_of();
+
+	if (method) {
+		if (!strcmp("hvc", method))
+			return optee_smccc_hvc;
+		else if (!strcmp("smc", method))
+			return optee_smccc_smc;
+	}
 
 	pr_warn("invalid \"method\" property: %s\n", method);
 	return ERR_PTR(-EINVAL);
 }
 
-static struct optee *optee_probe(struct device_node *np)
+static struct optee *optee_probe(optee_invoke_fn *invoke_fn)
 {
-	optee_invoke_fn *invoke_fn;
 	struct tee_shm_pool *pool;
 	struct optee *optee = NULL;
 	void *memremaped_shm = NULL;
@@ -455,10 +515,6 @@ static struct optee *optee_probe(struct device_node *np)
 	u32 sec_caps;
 	int rc;
 
-	invoke_fn = get_invoke_func(np);
-	if (IS_ERR(invoke_fn))
-		return (void *)invoke_fn;
-
 	if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
 		pr_warn("api uid mismatch\n");
 		return ERR_PTR(-EINVAL);
@@ -570,32 +626,18 @@ static void optee_remove(struct optee *optee)
 	kfree(optee);
 }
 
-static const struct of_device_id optee_match[] = {
-	{ .compatible = "linaro,optee-tz" },
-	{},
-};
-
 static struct optee *optee_svc;
 
 static int __init optee_driver_init(void)
 {
-	struct device_node *fw_np;
-	struct device_node *np;
+	optee_invoke_fn *invoke_fn;
 	struct optee *optee;
 
-	/* Node is supposed to be below /firmware */
-	fw_np = of_find_node_by_name(NULL, "firmware");
-	if (!fw_np)
-		return -ENODEV;
-
-	np = of_find_matching_node(fw_np, optee_match);
-	of_node_put(fw_np);
-	if (!np)
-		return -ENODEV;
-
-	optee = optee_probe(np);
-	of_node_put(np);
+	invoke_fn = get_invoke_func();
+	if (IS_ERR(invoke_fn))
+		return PTR_ERR(invoke_fn);
 
+	optee = optee_probe(invoke_fn);
 	if (IS_ERR(optee))
 		return PTR_ERR(optee);
 
-- 
1.9.1
