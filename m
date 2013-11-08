From: fkan@apm.com (Feng Kan)
Date: Fri,  8 Nov 2013 11:13:30 -0800
Subject: [PATCH] arm64: reboot driver missing dts entry and ACPI support for
 storm platform.
Message-ID: <1383938010-15296-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Feng Kan <fkan@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |    5 ++
 drivers/power/reset/Kconfig        |    5 +-
 drivers/power/reset/xgene-reboot.c |   94 +++++++++++++++++++++++++++++++-----
 3 files changed, 88 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index bfdc578..4478bee 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -112,5 +112,10 @@
 			interrupt-parent = <&gic>;
 			interrupts = <0x0 0x4c 0x4>;
 		};
+
+		reboot at 17000014 {
+			compatible = "apm,xgene-reboot";
+			reg = <0x0 0x17000014 0x0 0x4>;
+		};
 	};
 };
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 9b3ea53..84883bc 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -39,7 +39,7 @@ config POWER_RESET_RESTART
 
 config POWER_RESET_VEXPRESS
 	bool "ARM Versatile Express power-off and reset driver"
-	depends on ARM || ARM64
+	depends on (ARM || ARM64) && ARCH_VEXPRESS
 	depends on POWER_RESET && VEXPRESS_CONFIG
 	help
 	  Power off and reset support for the ARM Ltd. Versatile
@@ -47,7 +47,6 @@ config POWER_RESET_VEXPRESS
 
 config POWER_RESET_XGENE
 	bool "APM SoC X-Gene reset driver"
-	depends on ARM64
-	depends on POWER_RESET
+	default y if (ARM64 && ARCH_XGENE && POWER_RESET)
 	help
 	  Reboot support for the APM SoC X-Gene Eval boards.
diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index ecd55f8..856fed1 100644
--- a/drivers/power/reset/xgene-reboot.c
+++ b/drivers/power/reset/xgene-reboot.c
@@ -30,6 +30,8 @@
 #include <linux/platform_device.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
+#include <linux/acpi.h>
+#include <linux/efi.h>
 #include <asm/system_misc.h>
 
 struct xgene_reboot_context {
@@ -40,7 +42,7 @@ struct xgene_reboot_context {
 
 static struct xgene_reboot_context *xgene_restart_ctx;
 
-static void xgene_restart(char str, const char *cmd)
+static void xgene_restart(enum reboot_mode reboot_mode, const char *cmd)
 {
 	struct xgene_reboot_context *ctx = xgene_restart_ctx;
 	unsigned long timeout;
@@ -56,48 +58,114 @@ static void xgene_restart(char str, const char *cmd)
 	dev_emerg(&ctx->pdev->dev, "Unable to restart system\n");
 }
 
+static int xgene_reboot_get_resource(struct platform_device *pdev, int index,
+				     struct resource *res)
+{
+	struct resource *regs;
+	if (efi_enabled(EFI_BOOT)) {
+		regs = platform_get_resource(pdev, IORESOURCE_MEM, index);
+		if (regs == NULL)
+			return -ENODEV;
+		*res = *regs;
+		return 0;
+	}
+	return of_address_to_resource(pdev->dev.of_node, index, res);
+}
+
+static int xgene_reboot_get_u32_param(struct platform_device *pdev,
+				      const char *of_name, char *acpi_name,
+				      u32 *param)
+{
+#ifdef CONFIG_ACPI
+	if (efi_enabled(EFI_BOOT)) {
+		unsigned long long value;
+		acpi_status status;
+		if (acpi_name == NULL)
+			return -ENODEV;
+		status = acpi_evaluate_integer(ACPI_HANDLE(&pdev->dev),
+					       acpi_name, NULL, &value);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+		*param = value;
+		return 0;
+	}
+#endif
+	if (of_name == NULL)
+		return -ENODEV;
+	return of_property_read_u32(pdev->dev.of_node, of_name, param);
+}
+
 static int xgene_reboot_probe(struct platform_device *pdev)
 {
 	struct xgene_reboot_context *ctx;
+	struct resource res;
+	int rc;
+
+	/* Skip the ACPI probe if booting via DTS */
+	if (!efi_enabled(EFI_BOOT) && !pdev->dev.of_node)
+		goto error;
+
+	rc = xgene_reboot_get_resource(pdev, 0, &res);
+	if (rc) {
+		dev_err(&pdev->dev, "no resource address\n");
+		goto error;
+	}
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx) {
 		dev_err(&pdev->dev, "out of memory for context\n");
-		return -ENODEV;
+		goto error;
 	}
 
-	ctx->csr = of_iomap(pdev->dev.of_node, 0);
+	ctx->csr = devm_ioremap(&pdev->dev, res.start, resource_size(&res));
 	if (!ctx->csr) {
-		devm_kfree(&pdev->dev, ctx);
-		dev_err(&pdev->dev, "can not map resource\n");
-		return -ENODEV;
+		dev_err(&pdev->dev, "can't map CSR resource\n");
+		rc = -ENOMEM;
+		goto error;
 	}
 
-	if (of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask))
-		ctx->mask = 0xFFFFFFFF;
+	ctx->mask = 0x1;
+
+	dev_info(&pdev->dev, "X-Gene register reboot driver\n");
 
 	ctx->pdev = pdev;
 	arm_pm_restart = xgene_restart;
 	xgene_restart_ctx = ctx;
-
 	return 0;
+
+error:
+	if (ctx->csr)
+		devm_iounmap(&pdev->dev, ctx->csr);
+	devm_kfree(&pdev->dev, ctx);
+	return rc;
 }
 
 static struct of_device_id xgene_reboot_of_match[] = {
-	{ .compatible = "apm,xgene-reboot" },
+	{.compatible = "apm,xgene-reboot"},
 	{}
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xgene_reset_acpi_ids[] = {
+	{"APMC0D00", 0},
+	{}
+};
+#endif
+
 static struct platform_driver xgene_reboot_driver = {
 	.probe = xgene_reboot_probe,
 	.driver = {
-		.name = "xgene-reboot",
-		.of_match_table = xgene_reboot_of_match,
-	},
+		   .name = "xgene-reboot",
+		   .of_match_table = xgene_reboot_of_match,
+#ifdef CONFIG_ACPI
+		   .acpi_match_table = ACPI_PTR(xgene_reset_acpi_ids),
+#endif
+		   }
 };
 
 static int __init xgene_reboot_init(void)
 {
 	return platform_driver_register(&xgene_reboot_driver);
 }
+
 device_initcall(xgene_reboot_init);
-- 
1.7.6.1
