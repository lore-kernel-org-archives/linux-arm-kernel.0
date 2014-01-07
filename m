From: fkan@apm.com (Feng Kan)
Date: Tue,  7 Jan 2014 14:50:40 -0800
Subject: [PATCH V2 5/6] power: reset: change xgene reboot driver to use both
 acpi and dts resource for reboot.
In-Reply-To: <1389135041-16062-1-git-send-email-fkan@apm.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
Message-ID: <1389135041-16062-6-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the X-Gene reboot driver to use either the ACPI or the DTS
resource using the platform driver method.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 drivers/power/reset/xgene-reboot.c |   33 ++++++++++++++++++++++++++++-----
 1 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index 683238c..e3223c2 100644
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
@@ -59,6 +61,14 @@ static void xgene_restart(enum reboot_mode reboot_mode, const char *cmd)
 static int xgene_reboot_probe(struct platform_device *pdev)
 {
 	struct xgene_reboot_context *ctx;
+	struct resource *res;
+	int rc;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "no resource address\n");
+		return -ENODEV;
+	}
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx) {
@@ -66,20 +76,27 @@ static int xgene_reboot_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ctx->csr = of_iomap(pdev->dev.of_node, 0);
+	ctx->csr = devm_ioremap_resource(&pdev->dev, res);
 	if (!ctx->csr) {
-		devm_kfree(&pdev->dev, ctx);
-		dev_err(&pdev->dev, "can not map resource\n");
-		return -ENODEV;
+		dev_err(&pdev->dev, "can't map CSR resource\n");
+		rc  = -ENOMEM;
+		goto error;
 	}
 
 	ctx->mask = 0x1;
 
+	dev_info(&pdev->dev, "X-Gene register reboot driver\n");
+
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
@@ -87,11 +104,17 @@ static struct of_device_id xgene_reboot_of_match[] = {
 	{}
 };
 
+static const struct acpi_device_id xgene_reset_acpi_ids[] = {
+	{ "APMC0D08", 0 },
+	{}
+};
+
 static struct platform_driver xgene_reboot_driver = {
 	.probe = xgene_reboot_probe,
 	.driver = {
 		.name = "xgene-reboot",
 		.of_match_table = xgene_reboot_of_match,
+		.acpi_match_table = ACPI_PTR(xgene_reset_acpi_ids),
 	},
 };
 
-- 
1.7.6.1
