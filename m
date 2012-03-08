From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  9 Mar 2012 00:59:45 +0800
Subject: [PATCH v3 06/11] ASoC: fsl: remove helper fsl_asoc_get_codec_dev_name
In-Reply-To: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1331225990-27308-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ASoC core now can support matching codec with device node besides
name, so we can save helper function fsl_asoc_get_codec_dev_name.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/fsl_utils.c    |   44 ------------------------------------------
 sound/soc/fsl/fsl_utils.h    |    1 -
 sound/soc/fsl/mpc8610_hpcd.c |   13 +----------
 sound/soc/fsl/p1022_ds.c     |   13 +----------
 4 files changed, 4 insertions(+), 67 deletions(-)

diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index 4370c28..b9e42b5 100644
--- a/sound/soc/fsl/fsl_utils.c
+++ b/sound/soc/fsl/fsl_utils.c
@@ -12,55 +12,11 @@
 
 #include <linux/module.h>
 #include <linux/of_address.h>
-#include <linux/of_i2c.h>
 #include <sound/soc.h>
 
 #include "fsl_utils.h"
 
 /**
- * fsl_asoc_get_codec_dev_name - determine the dev_name for a codec node
- *
- * @np: pointer to the I2C device tree node
- * @buf: buffer to be filled with the dev_name of the I2C device
- * @len: the length of the buffer
- *
- * This function determines the dev_name for an I2C node.  This is the name
- * that would be returned by dev_name() if this device_node were part of a
- * 'struct device'  It's ugly and hackish, but it works.
- *
- * The dev_name for such devices include the bus number and I2C address. For
- * example, "cs4270.0-004f".
- */
-int fsl_asoc_get_codec_dev_name(struct device_node *np, char *buf, size_t len)
-{
-	const u32 *iprop;
-	u32 addr;
-	char temp[DAI_NAME_SIZE];
-	struct i2c_client *i2c;
-
-	of_modalias_node(np, temp, DAI_NAME_SIZE);
-
-	iprop = of_get_property(np, "reg", NULL);
-	if (!iprop)
-		return -EINVAL;
-
-	addr = be32_to_cpup(iprop);
-
-	/* We need the adapter number */
-	i2c = of_find_i2c_device_by_node(np);
-	if (!i2c) {
-		put_device(&i2c->dev);
-		return -ENODEV;
-	}
-
-	snprintf(buf, len, "%s.%u-%04x", temp, i2c->adapter->nr, addr);
-	put_device(&i2c->dev);
-
-	return 0;
-}
-EXPORT_SYMBOL(fsl_asoc_get_codec_dev_name);
-
-/**
  * fsl_asoc_get_dma_channel - determine the dma channel for a SSI node
  *
  * @ssi_np: pointer to the SSI device tree node
diff --git a/sound/soc/fsl/fsl_utils.h b/sound/soc/fsl/fsl_utils.h
index 44d1436..b295112 100644
--- a/sound/soc/fsl/fsl_utils.h
+++ b/sound/soc/fsl/fsl_utils.h
@@ -18,7 +18,6 @@
 struct snd_soc_dai_link;
 struct device_node;
 
-int fsl_asoc_get_codec_dev_name(struct device_node *np, char *buf, size_t len);
 int fsl_asoc_get_dma_channel(struct device_node *ssi_np, const char *name,
 			     struct snd_soc_dai_link *dai,
 			     unsigned int *dma_channel_id,
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 7ead1e5..354b753 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -41,7 +41,6 @@ struct mpc8610_hpcd_data {
 	unsigned int dma_id[2];		/* 0 = DMA1, 1 = DMA2, etc */
 	unsigned int dma_channel_id[2]; /* 0 = ch 0, 1 = ch 1, etc*/
 	char codec_dai_name[DAI_NAME_SIZE];
-	char codec_name[DAI_NAME_SIZE];
 	char platform_name[2][DAI_NAME_SIZE]; /* One for each DMA channel */
 };
 
@@ -215,16 +214,8 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	machine_data->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
 	machine_data->dai[0].ops = &mpc8610_hpcd_ops;
 
-	/* Determine the codec name, it will be used as the codec DAI name */
-	ret = fsl_asoc_get_codec_dev_name(codec_np, machine_data->codec_name,
-					  DAI_NAME_SIZE);
-	if (ret) {
-		dev_err(&pdev->dev, "invalid codec node %s\n",
-			codec_np->full_name);
-		ret = -EINVAL;
-		goto error;
-	}
-	machine_data->dai[0].codec_name = machine_data->codec_name;
+	/* ASoC core can match codec with device node */
+	machine_data->dai[0].codec_of_node = codec_np;
 
 	/* The DAI name from the codec (snd_soc_dai_driver.name) */
 	machine_data->dai[0].codec_dai_name = "cs4270-hifi";
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 60f7bb8..e87cb41 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -73,7 +73,6 @@ struct machine_data {
 	unsigned int ssi_id;		/* 0 = SSI1, 1 = SSI2, etc */
 	unsigned int dma_id[2];		/* 0 = DMA1, 1 = DMA2, etc */
 	unsigned int dma_channel_id[2]; /* 0 = ch 0, 1 = ch 1, etc*/
-	char codec_name[DAI_NAME_SIZE];
 	char platform_name[2][DAI_NAME_SIZE]; /* One for each DMA channel */
 };
 
@@ -225,16 +224,8 @@ static int p1022_ds_probe(struct platform_device *pdev)
 	mdata->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
 	mdata->dai[0].ops = &p1022_ds_ops;
 
-	/* Determine the codec name, it will be used as the codec DAI name */
-	ret = fsl_asoc_get_codec_dev_name(codec_np, mdata->codec_name,
-					  DAI_NAME_SIZE);
-	if (ret) {
-		dev_err(&pdev->dev, "invalid codec node %s\n",
-			codec_np->full_name);
-		ret = -EINVAL;
-		goto error;
-	}
-	mdata->dai[0].codec_name = mdata->codec_name;
+	/* ASoC core can match codec with device node */
+	mdata->dai[0].codec_of_node = codec_np;
 
 	/* We register two DAIs per SSI, one for playback and the other for
 	 * capture.  We support codecs that have separate DAIs for both playback
-- 
1.7.5.4
