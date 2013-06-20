From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Jun 2013 15:20:22 +0200
Subject: [PATCH v9 03/10] ASoC: fsl: Move soc_ac97_ops from imx-ssi to fsl_ssi
In-Reply-To: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1371734429-6081-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fsl_ssi and imx-ssi can be both enabled at the same time. To be able to
add AC97 support to fsl_ssi, soc_ac97_ops have to be available to both
drivers.

fsl_ssi has DT support and should be the only driver at some point in
the future. This patch moves the definition of soc_ac97_ops to fsl_ssi.
imx-ssi copies its own ac97 ops struct into soc_ac97_ops when used in
AC97 mode.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/Kconfig   | 1 +
 sound/soc/fsl/fsl_ssi.c | 8 ++++++++
 sound/soc/fsl/imx-ssi.c | 7 +++++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 7860cc2..74ef96e 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -107,6 +107,7 @@ if SND_IMX_SOC
 
 config SND_SOC_IMX_SSI
 	tristate
+	select SND_SOC_FSL_SSI
 
 config SND_SOC_IMX_PCM_FIQ
 	bool
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 2f2d837..db55499 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -587,6 +587,14 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
 	.name		= "fsl-ssi",
 };
 
+/*
+ * FIXME: As soon as all boards using imx-ssi AC97 mode are able to use
+ * fsl-ssi, soc_ac97_ops can be used exclusively in this driver without copying
+ * the struct. AC97 support can then be removed from imx-ssi.
+ */
+struct snd_ac97_bus_ops soc_ac97_ops;
+EXPORT_SYMBOL_GPL(soc_ac97_ops);
+
 /* Show the statistics of a flag only if its interrupt is enabled.  The
  * compiler will optimze this code to a no-op if the interrupt is not
  * enabled.
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 16ae16d..3760220 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -501,13 +501,14 @@ static void imx_ssi_ac97_warm_reset(struct snd_ac97 *ac97)
 	imx_ssi_ac97_read(ac97, 0);
 }
 
-struct snd_ac97_bus_ops soc_ac97_ops = {
+static struct snd_ac97_bus_ops imx_ssi_soc_ac97_ops = {
 	.read		= imx_ssi_ac97_read,
 	.write		= imx_ssi_ac97_write,
 	.reset		= imx_ssi_ac97_reset,
 	.warm_reset	= imx_ssi_ac97_warm_reset
 };
-EXPORT_SYMBOL_GPL(soc_ac97_ops);
+
+extern struct snd_ac97_bus_ops soc_ac97_ops;
 
 static int imx_ssi_probe(struct platform_device *pdev)
 {
@@ -547,6 +548,8 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	}
 
 	if (ssi->flags & IMX_SSI_USE_AC97) {
+		memcpy(&soc_ac97_ops, &imx_ssi_soc_ac97_ops,
+				sizeof(soc_ac97_ops));
 		if (ac97_ssi) {
 			dev_err(&pdev->dev, "AC'97 SSI already registered\n");
 			ret = -EBUSY;
-- 
1.8.2.1
