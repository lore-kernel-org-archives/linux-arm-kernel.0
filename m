From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 14 Apr 2014 15:35:33 +0200
Subject: [PATCH v3 03/18] ASoC: fsl-ssi: Use dev_name for DAI driver struct
In-Reply-To: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1397482548-28463-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of creating a name using string manipulation functions, we can
simply use the device name for the DAI driver struct.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 344f752..65d9da1 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1027,17 +1027,13 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (!strcmp(sprop, "ac97-slave"))
 		ac97 = true;
 
-	/* The DAI name is the last part of the full name of the node. */
-	p = strrchr(np->full_name, '/') + 1;
-	ssi_private = devm_kzalloc(&pdev->dev, sizeof(*ssi_private) + strlen(p),
-			      GFP_KERNEL);
+	ssi_private = devm_kzalloc(&pdev->dev, sizeof(*ssi_private),
+			GFP_KERNEL);
 	if (!ssi_private) {
 		dev_err(&pdev->dev, "could not allocate DAI object\n");
 		return -ENOMEM;
 	}
 
-	strcpy(ssi_private->name, p);
-
 	ssi_private->use_dma = !of_property_read_bool(np,
 			"fsl,fiq-stream-filter");
 	ssi_private->hw_type = hw_type;
@@ -1055,7 +1051,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
 		       sizeof(fsl_ssi_dai_template));
 	}
-	ssi_private->cpu_dai_drv.name = ssi_private->name;
+	ssi_private->cpu_dai_drv.name = dev_name(&pdev->dev);
 
 	/* Get the addresses and IRQ */
 	ret = of_address_to_resource(np, 0, &res);
@@ -1203,7 +1199,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	 * different writeable interrupt status registers.
 	 */
 	if (ssi_private->use_dma) {
-		/* The 'name' should not have any slashes in it. */
 		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
 					fsl_ssi_isr, 0, ssi_private->name,
 					ssi_private);
-- 
1.9.1
