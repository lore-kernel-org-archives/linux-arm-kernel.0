From: fkan@apm.com (Feng Kan)
Date: Tue, 14 Jan 2014 17:07:35 -0800
Subject: [PATCH V3 3/3] power: reset: use syscon driver to parse reboot
 register from scu
In-Reply-To: <1389748055-23534-1-git-send-email-fkan@apm.com>
References: <1389748055-23534-1-git-send-email-fkan@apm.com>
Message-ID: <1389748055-23534-4-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the syscon driver to parse out the reboot register map and issue
reboot via the regmap function.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 drivers/power/reset/xgene-reboot.c |   75 +++++++++---------------------------
 1 files changed, 19 insertions(+), 56 deletions(-)

diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index ecd55f8..660ed8a 100644
--- a/drivers/power/reset/xgene-reboot.c
+++ b/drivers/power/reset/xgene-reboot.c
@@ -24,80 +24,43 @@
  * For system shutdown, this is board specify. If a board designer
  * implements GPIO shutdown, use the gpio-poweroff.c driver.
  */
-#include <linux/io.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
-#include <linux/stat.h>
-#include <linux/slab.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/reboot.h>
 #include <asm/system_misc.h>
 
-struct xgene_reboot_context {
-	struct platform_device *pdev;
-	void *csr;
-	u32 mask;
-};
+#define SCU_SRST	0x14
 
-static struct xgene_reboot_context *xgene_restart_ctx;
-
-static void xgene_restart(char str, const char *cmd)
+static void xgene_restart(enum reboot_mode reboot_mode, const char *cmd)
 {
-	struct xgene_reboot_context *ctx = xgene_restart_ctx;
 	unsigned long timeout;
+	struct regmap *map;
+	unsigned int ret;
+	struct device_node *dn;
+
+	dn = of_find_node_by_name(NULL, "reboot");
+	map = syscon_regmap_lookup_by_phandle(dn, "apm,scu");
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		pr_err("Reboot driver failed to get scu regmap: %d\n", ret);
+		return;
+	}
 
-	/* Issue the reboot */
-	if (ctx)
-		writel(ctx->mask, ctx->csr);
+	regmap_write(map, SCU_SRST, 0x1);
 
 	timeout = jiffies + HZ;
 	while (time_before(jiffies, timeout))
 		cpu_relax();
 
-	dev_emerg(&ctx->pdev->dev, "Unable to restart system\n");
+	pr_emerg("Unable to restart system\n");
 }
 
-static int xgene_reboot_probe(struct platform_device *pdev)
+static int __init xgene_reboot_init(void)
 {
-	struct xgene_reboot_context *ctx;
-
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx) {
-		dev_err(&pdev->dev, "out of memory for context\n");
-		return -ENODEV;
-	}
-
-	ctx->csr = of_iomap(pdev->dev.of_node, 0);
-	if (!ctx->csr) {
-		devm_kfree(&pdev->dev, ctx);
-		dev_err(&pdev->dev, "can not map resource\n");
-		return -ENODEV;
-	}
-
-	if (of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask))
-		ctx->mask = 0xFFFFFFFF;
-
-	ctx->pdev = pdev;
 	arm_pm_restart = xgene_restart;
-	xgene_restart_ctx = ctx;
-
 	return 0;
 }
-
-static struct of_device_id xgene_reboot_of_match[] = {
-	{ .compatible = "apm,xgene-reboot" },
-	{}
-};
-
-static struct platform_driver xgene_reboot_driver = {
-	.probe = xgene_reboot_probe,
-	.driver = {
-		.name = "xgene-reboot",
-		.of_match_table = xgene_reboot_of_match,
-	},
-};
-
-static int __init xgene_reboot_init(void)
-{
-	return platform_driver_register(&xgene_reboot_driver);
-}
 device_initcall(xgene_reboot_init);
-- 
1.7.6.1
