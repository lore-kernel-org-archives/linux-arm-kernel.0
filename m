From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 12 Mar 2012 19:58:53 +0800
Subject: [PATCH v4 06/10] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1331553537-19789-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check /compatible rather than /model to determine the machine name.
The p1022ds older device trees get a different /model from the new
ones, while /compatible is consistent there, so checking /compatible
will save the bother of detecting older p1022ds device trees.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c      |    6 +++---
 sound/soc/fsl/mpc8610_hpcd.c |    2 +-
 sound/soc/fsl/p1022_ds.c     |   32 +++++---------------------------
 3 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 3e06696..2eb407f 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -716,12 +716,12 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	/* Trigger the machine driver's probe function.  The platform driver
-	 * name of the machine driver is taken from the /model property of the
+	 * name of the machine driver is taken from /compatible property of the
 	 * device tree.  We also pass the address of the CPU DAI driver
 	 * structure.
 	 */
-	sprop = of_get_property(of_find_node_by_path("/"), "model", NULL);
-	/* Sometimes the model name has a "fsl," prefix, so we strip that. */
+	sprop = of_get_property(of_find_node_by_path("/"), "compatible", NULL);
+	/* Sometimes the compatible name has a "fsl," prefix, so we strip it. */
 	p = strrchr(sprop, ',');
 	if (p)
 		sprop = p + 1;
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 354b753..8fdc430 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -402,7 +402,7 @@ static struct platform_driver mpc8610_hpcd_driver = {
 	.probe = mpc8610_hpcd_probe,
 	.remove = __devexit_p(mpc8610_hpcd_remove),
 	.driver = {
-		/* The name must match the 'model' property in the device tree,
+		/* The name must match 'compatible' property in the device tree,
 		 * in lowercase letters.
 		 */
 		.name = "snd-soc-mpc8610hpcd",
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index e87cb41..0f42f31 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -403,6 +403,11 @@ static struct platform_driver p1022_ds_driver = {
 	.probe = p1022_ds_probe,
 	.remove = __devexit_p(p1022_ds_remove),
 	.driver = {
+		/*
+		 * The name must match 'compatible' property in the device tree,
+		 * in lowercase letters.
+		 */
+		.name = "snd-soc-p1022ds",
 		.owner = THIS_MODULE,
 	},
 };
@@ -416,33 +421,6 @@ static int __init p1022_ds_init(void)
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
