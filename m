From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Feb 2013 23:25:46 +0800
Subject: [PATCH 10/12] ASoC: mxs: move to use generic DMA helper
In-Reply-To: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1361978748-25281-11-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the generic DMA device tree helper supported by mxs-dma driver,
client devices only need to call dma_request_slave_channel() for
requesting a DMA channel from dmaengine.

Call snd_dmaengine_pcm_open() with NULL filter_fn, and having
parameters needed by dma_request_slave_channel() wrap into
snd_dma_channel_params and pass it in as filter_data, so that
dmaengine_pcm will call the helper rather than dma_request_channel()
to request DMA channel.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel at alsa-project.org
---
 .../devicetree/bindings/sound/mxs-saif.txt         |   18 ++++----
 sound/soc/mxs/mxs-pcm.c                            |   43 ++------------------
 sound/soc/mxs/mxs-pcm.h                            |    5 ---
 sound/soc/mxs/mxs-saif.c                           |   28 ++-----------
 sound/soc/mxs/mxs-saif.h                           |    3 +-
 5 files changed, 20 insertions(+), 77 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mxs-saif.txt b/Documentation/devicetree/bindings/sound/mxs-saif.txt
index c37ba61..da221b4 100644
--- a/Documentation/devicetree/bindings/sound/mxs-saif.txt
+++ b/Documentation/devicetree/bindings/sound/mxs-saif.txt
@@ -3,8 +3,11 @@
 Required properties:
 - compatible: Should be "fsl,<chip>-saif"
 - reg: Should contain registers location and length
-- interrupts: Should contain ERROR and DMA interrupts
-- fsl,saif-dma-channel: APBX DMA channel for the SAIF
+- interrupts: Should contain ERROR interrupt number
+- dmas: DMA specifier, consisting of a phandle to DMA controller node
+  and SAIF DMA channel ID.
+  Refer to dma.txt and fsl-mxs-dma.txt for details.
+- dma-names: Must be "saif".
 
 Optional properties:
 - fsl,saif-master: phandle to the master SAIF.  It's only required for
@@ -23,14 +26,15 @@ aliases {
 saif0: saif at 80042000 {
 	compatible = "fsl,imx28-saif";
 	reg = <0x80042000 2000>;
-	interrupts = <59 80>;
-	fsl,saif-dma-channel = <4>;
+	interrupts = <59>;
+	dmas = <&dma_apbx 4>;
+	dma-names = "saif";
 };
 
 saif1: saif at 80046000 {
 	compatible = "fsl,imx28-saif";
 	reg = <0x80046000 2000>;
-	interrupts = <58 81>;
-	fsl,saif-dma-channel = <5>;
-	fsl,saif-master = <&saif0>;
+	interrupts = <58>;
+	dmas = <&dma_apbx 5>;
+	dma-names = "saif";
 };
diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index 564b5b6..74cb4b5 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -28,7 +28,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/dmaengine.h>
-#include <linux/fsl/mxs-dma.h>
 
 #include <sound/core.h>
 #include <sound/initval.h>
@@ -39,11 +38,6 @@
 
 #include "mxs-pcm.h"
 
-struct mxs_pcm_dma_data {
-	struct mxs_dma_data dma_data;
-	struct mxs_pcm_dma_params *dma_params;
-};
-
 static struct snd_pcm_hardware snd_mxs_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
@@ -64,22 +58,6 @@ static struct snd_pcm_hardware snd_mxs_hardware = {
 
 };
 
-static bool filter(struct dma_chan *chan, void *param)
-{
-	struct mxs_pcm_dma_data *pcm_dma_data = param;
-	struct mxs_pcm_dma_params *dma_params = pcm_dma_data->dma_params;
-
-	if (!mxs_dma_is_apbx(chan))
-		return false;
-
-	if (chan->chan_id != dma_params->chan_num)
-		return false;
-
-	chan->private = &pcm_dma_data->dma_data;
-
-	return true;
-}
-
 static int snd_mxs_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
@@ -91,35 +69,22 @@ static int snd_mxs_pcm_hw_params(struct snd_pcm_substream *substream,
 static int snd_mxs_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mxs_pcm_dma_data *pcm_dma_data;
+	struct snd_dma_channel_params *params;
 	int ret;
 
-	pcm_dma_data = kzalloc(sizeof(*pcm_dma_data), GFP_KERNEL);
-	if (pcm_dma_data == NULL)
-		return -ENOMEM;
-
-	pcm_dma_data->dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-	pcm_dma_data->dma_data.chan_irq = pcm_dma_data->dma_params->chan_irq;
-
-	ret = snd_dmaengine_pcm_open(substream, filter, pcm_dma_data);
-	if (ret) {
-		kfree(pcm_dma_data);
+	params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+	ret = snd_dmaengine_pcm_open(substream, NULL, params);
+	if (ret)
 		return ret;
-	}
 
 	snd_soc_set_runtime_hwparams(substream, &snd_mxs_hardware);
 
-	snd_dmaengine_pcm_set_data(substream, pcm_dma_data);
-
 	return 0;
 }
 
 static int snd_mxs_close(struct snd_pcm_substream *substream)
 {
-	struct mxs_pcm_dma_data *pcm_dma_data = snd_dmaengine_pcm_get_data(substream);
-
 	snd_dmaengine_pcm_close(substream);
-	kfree(pcm_dma_data);
 
 	return 0;
 }
diff --git a/sound/soc/mxs/mxs-pcm.h b/sound/soc/mxs/mxs-pcm.h
index 35ba2ca..bc685b6 100644
--- a/sound/soc/mxs/mxs-pcm.h
+++ b/sound/soc/mxs/mxs-pcm.h
@@ -19,11 +19,6 @@
 #ifndef _MXS_PCM_H
 #define _MXS_PCM_H
 
-struct mxs_pcm_dma_params {
-	int chan_irq;
-	int chan_num;
-};
-
 int mxs_pcm_platform_register(struct device *dev);
 void mxs_pcm_platform_unregister(struct device *dev);
 
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 3a2aa1d..9f6abb8 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -26,7 +26,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/time.h>
-#include <linux/fsl/mxs-dma.h>
 #include <linux/pinctrl/consumer.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -659,7 +658,7 @@ static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
 static int mxs_saif_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct resource *iores, *dmares;
+	struct resource *iores;
 	struct mxs_saif *saif;
 	struct pinctrl *pinctrl;
 	int ret = 0;
@@ -721,22 +720,6 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	if (IS_ERR(saif->base))
 		return PTR_ERR(saif->base);
 
-	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!dmares) {
-		/*
-		 * TODO: This is a temporary solution and should be changed
-		 * to use generic DMA binding later when the helplers get in.
-		 */
-		ret = of_property_read_u32(np, "fsl,saif-dma-channel",
-					   &saif->dma_param.chan_num);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to get dma channel\n");
-			return ret;
-		}
-	} else {
-		saif->dma_param.chan_num = dmares->start;
-	}
-
 	saif->irq = platform_get_irq(pdev, 0);
 	if (saif->irq < 0) {
 		ret = saif->irq;
@@ -753,13 +736,8 @@ static int mxs_saif_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	saif->dma_param.chan_irq = platform_get_irq(pdev, 1);
-	if (saif->dma_param.chan_irq < 0) {
-		ret = saif->dma_param.chan_irq;
-		dev_err(&pdev->dev, "failed to get dma irq resource: %d\n",
-			ret);
-		return ret;
-	}
+	saif->dma_param.dev = saif->dev;
+	saif->dma_param.name = "saif";
 
 	platform_set_drvdata(pdev, saif);
 
diff --git a/sound/soc/mxs/mxs-saif.h b/sound/soc/mxs/mxs-saif.h
index 3cb342e..32b4310 100644
--- a/sound/soc/mxs/mxs-saif.h
+++ b/sound/soc/mxs/mxs-saif.h
@@ -108,6 +108,7 @@
 
 #define MXS_SAIF_MCLK		0
 
+#include <sound/dmaengine_pcm.h>
 #include "mxs-pcm.h"
 
 struct mxs_saif {
@@ -117,7 +118,7 @@ struct mxs_saif {
 	unsigned int mclk_in_use;
 	void __iomem *base;
 	int irq;
-	struct mxs_pcm_dma_params dma_param;
+	struct snd_dma_channel_params dma_param;
 	unsigned int id;
 	unsigned int master_id;
 	unsigned int cur_rate;
-- 
1.7.9.5
