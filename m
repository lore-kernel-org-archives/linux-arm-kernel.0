From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Feb 2012 22:09:40 +0800
Subject: [PATCH 5/6] ASoC: fsl: use platform_device_id table to match p1022_ds
 device
In-Reply-To: <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330092582-21180-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of run-time detecting driver name from device tree model
property for binding the correct platform device created in fsl_ssi
probe function, we can simply use platform_device_id table to match
the p1022_ds device.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/p1022_ds.c |   36 +++++++++---------------------------
 1 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 60f7bb8..a6f4a8a 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -408,10 +408,19 @@ static int __devexit p1022_ds_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct platform_device_id p1022_ds_ids[] = {
+	{ .name = "snd-soc-p1022ds", },
+	{ .name = "snd-soc-p1022", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, p1022_ds_ids);
+
 static struct platform_driver p1022_ds_driver = {
 	.probe = p1022_ds_probe,
 	.remove = __devexit_p(p1022_ds_remove),
+	.id_table = p1022_ds_ids,
 	.driver = {
+		.name = "p1022_ds",
 		.owner = THIS_MODULE,
 	},
 };
@@ -425,33 +434,6 @@ static int __init p1022_ds_init(void)
 {
 	struct device_node *guts_np;
 	struct resource res;
-	const char *sprop;
-
-	/*
-	 * Check if we're actually running on a P1022DS.  Older device trees
-	 * have a model of "fsl,P1022" and newer ones use "fsl,P1022DS", so we
-	 * need to support both.  The SSI driver uses that property to link to
-	 * the machine driver, so have to match it.
-	 */
-	sprop = of_get_property(of_find_node_by_path("/"), "model", NULL);
-	if (!sprop) {
-		pr_err("snd-soc-p1022ds: missing /model node");
-		return -ENODEV;
-	}
-
-	pr_debug("snd-soc-p1022ds: board model name is %s\n", sprop);
-
-	/*
-	 * The name of this board, taken from the device tree.  Normally, this is a*
-	 * fixed string, but some P1022DS device trees have a /model property of
-	 * "fsl,P1022", and others have "fsl,P1022DS".
-	 */
-	if (strcasecmp(sprop, "fsl,p1022ds") == 0)
-		p1022_ds_driver.driver.name = "snd-soc-p1022ds";
-	else if (strcasecmp(sprop, "fsl,p1022") == 0)
-		p1022_ds_driver.driver.name = "snd-soc-p1022";
-	else
-		return -ENODEV;
 
 	/* Get the physical address of the global utilities registers */
 	guts_np = of_find_compatible_node(NULL, NULL, "fsl,p1022-guts");
-- 
1.7.5.4
