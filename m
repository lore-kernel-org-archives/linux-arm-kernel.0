From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 12 Mar 2012 19:58:55 +0800
Subject: [PATCH v4 08/10] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1331553537-19789-9-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As Documentation/devicetree/bindings/powerpc/fsl/ssi.txt documented,
codec-handle is an optional property, so missing it should not be a
fatal error.

More importantly, the imx machine drivers to be added working with
fsl_ssi will not have this property, as they use new ASoC machine
driver binding mechanism.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index db9a734..0192c02 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -642,12 +642,6 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 	if (!of_device_is_available(np))
 		return -ENODEV;
 
-	/* Check for a codec-handle property. */
-	if (!of_get_property(np, "codec-handle", NULL)) {
-		dev_err(&pdev->dev, "missing codec-handle property\n");
-		return -ENODEV;
-	}
-
 	/* We only support the SSI in "I2S Slave" mode */
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (!sprop || strcmp(sprop, "i2s-slave")) {
-- 
1.7.5.4
