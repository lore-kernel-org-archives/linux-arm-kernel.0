From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Feb 2012 22:09:41 +0800
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the machine
 name
In-Reply-To: <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fsl_ssi probe function detects the client machine name using model
property of the device tree.  But it will not work for the ARM client
machines which are to be added.  The model property is given as a
descriptive string on all ARM device tree (arch/arm/boot/*.dts).
Instead, the compatible property gives the machine name.

It seems the fsl_ssi PowerPC users, machine mpc8610_hpcd and p1022ds,
basically have the same thing in model and compatible properties.
Detecting machine name using compatible property becomes a solution
working for both PowerPC and ARM users of fsl_ssi.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c      |    6 +++---
 sound/soc/fsl/mpc8610_hpcd.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 32fc84b..ff570a6 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -733,12 +733,12 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
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
index 7ead1e5..4195182 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -411,7 +411,7 @@ static struct platform_driver mpc8610_hpcd_driver = {
 	.probe = mpc8610_hpcd_probe,
 	.remove = __devexit_p(mpc8610_hpcd_remove),
 	.driver = {
-		/* The name must match the 'model' property in the device tree,
+		/* The name must match 'compatible' property in the device tree,
 		 * in lowercase letters.
 		 */
 		.name = "snd-soc-mpc8610hpcd",
-- 
1.7.5.4
