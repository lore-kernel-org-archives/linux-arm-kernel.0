From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  5 Mar 2012 22:31:02 +0800
Subject: [PATCH v2 14/17] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330957865-19085-15-git-send-email-shawn.guo@linaro.org>
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
index d31d1ba..290728d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -638,12 +638,6 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
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
