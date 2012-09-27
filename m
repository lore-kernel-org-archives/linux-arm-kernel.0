From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 27 Sep 2012 15:55:32 +0530
Subject: [PATCH V2] ASoC: SAMSUNG: Add DT support for i2s
Message-ID: <1348741532-29412-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for device based discovery.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 .../devicetree/bindings/sound/samsung-i2s.txt      |   62 +++++
 sound/soc/samsung/dma.c                            |    1 +
 sound/soc/samsung/dma.h                            |    1 +
 sound/soc/samsung/i2s.c                            |  233 +++++++++++++++----
 4 files changed, 248 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
new file mode 100644
index 0000000..e2a1be5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
@@ -0,0 +1,62 @@
+* Samsung I2S controller
+
+Required SoC Specific properties:
+
+- compatible : "samsung,samsung-i2s"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- tx-dma-channel-secondary: The dma channel specifier for secondary tx
+  operations. The format of the dma specifier depends on the dma
+  controller.
+- tx-dma-channel: The dma channel specifier for tx operations. The format of
+  the dma specifier depends on the dma controller.
+- rx-dma-channel: The dma channel specifier for rx operations. The format of
+  the dma specifier depends on the dma controller.
+- supports-6ch: If the I2S Primary sound source has 5.1 Channel support, this
+  flag is enabled.
+- supports-rstclr: This flag should be set if I2S software reset bit control is
+  required. When this flag is set I2S software reset bit will be enabled or
+  disabled based on need.
+- supports-secdai:If I2S block has a secondary FIFO and internal DMA, then this
+  flag is enabled.
+
+Required Board Specific Properties:
+
+- gpios: The gpio specifier for data out,data in, LRCLK, CDCLK and SCLK
+  interface lines. The format of the gpio specifier depends on the gpio
+  controller.
+- idma-addr: Internal DMA register base address of the audio sub system(used in
+  secondary sound source).
+
+Aliases:
+
+- All the I2S controller nodes should be represented in the aliases node using
+  the following format 'i2s{n}' where n is a unique number for the alias.
+
+Example:
+
+- SoC Specific Portion:
+
+i2s at 03830000 {
+	compatible = "samsung,samsung-i2s";
+	reg = <0x03830000 0x100>;
+	tx-dma-channel-secondary = <&pdma0 8>;
+	tx-dma-channel = <&pdma0 10>;
+	rx-dma-channel = <&pdma0 9>;
+	supports-6ch;
+	supports-rstclr;
+	supports-secdai;
+};
+
+- Board Specific Portion:
+
+i2s_0: i2s at 03830000 {
+	gpios = <&gpz 0 2 0 0>,
+		<&gpz 1 2 0 0>,
+		<&gpz 2 2 0 0>,
+		<&gpz 3 2 0 0>,
+		<&gpz 4 2 0 0>,
+		<&gpz 5 2 0 0>,
+		<&gpz 6 2 0 0>;
+	idma-addr = <0x03000000>;
+};
diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index b70964e..359708c 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -168,6 +168,7 @@ static int dma_hw_params(struct snd_pcm_substream *substream,
 		req.cap = (samsung_dma_has_circular() ?
 			DMA_CYCLIC : DMA_SLAVE);
 		req.client = prtd->params->client;
+		req.dt_dmach_prop = prtd->params->dma_prop;
 		config.direction =
 			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK
 			? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM);
diff --git a/sound/soc/samsung/dma.h b/sound/soc/samsung/dma.h
index 7d1ead7..2e60415 100644
--- a/sound/soc/samsung/dma.h
+++ b/sound/soc/samsung/dma.h
@@ -19,6 +19,7 @@ struct s3c_dma_params {
 	int dma_size;			/* Size of the DMA transfer */
 	unsigned ch;
 	struct samsung_dma_ops *ops;
+	struct property *dma_prop;
 };
 
 #endif
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 6ac7b82..d292098 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -15,11 +15,15 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
+#include <mach/dma.h>
+
 #include <plat/audio.h>
 
 #include "dma.h"
@@ -49,8 +53,6 @@ struct i2s_dai {
 	struct clk *clk;
 	/* Clock for generating I2S signals */
 	struct clk *op_clk;
-	/* Array of clock names for op_clk */
-	const char **src_clk;
 	/* Pointer to the Primary_Fifo if this is Sec_Fifo, NULL otherwise */
 	struct i2s_dai *pri_dai;
 	/* Pointer to the Secondary_Fifo if it has one, NULL otherwise */
@@ -68,6 +70,8 @@ struct i2s_dai {
 	u32	suspend_i2smod;
 	u32	suspend_i2scon;
 	u32	suspend_i2spsr;
+	unsigned long gpios[7];	/* i2s gpio line numbers */
+	int	dev_id;		/* i2s dev id */
 };
 
 /* Lock for cross i/f checks */
@@ -385,6 +389,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
 	u32 mod = readl(i2s->addr + I2SMOD);
+	char clk_name[16];
 
 	switch (clk_id) {
 	case SAMSUNG_I2S_CDCLK:
@@ -432,8 +437,9 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 				}
 			}
 
+			sprintf(clk_name, "i2s_opclk%d", clk_id);
 			i2s->op_clk = clk_get(&i2s->pdev->dev,
-						i2s->src_clk[clk_id]);
+						clk_name);
 			clk_enable(i2s->op_clk);
 			i2s->rclk_srcrate = clk_get_rate(i2s->op_clk);
 
@@ -980,8 +986,9 @@ struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 		i2s->i2s_dai_drv.capture.formats = SAMSUNG_I2S_FMTS;
 	} else {	/* Create a new platform_device for Secondary */
 		i2s->pdev = platform_device_register_resndata(NULL,
-				pdev->name, pdev->id + SAMSUNG_I2S_SECOFF,
-				NULL, 0, NULL, 0);
+				"samsung-i2s",
+				i2s->dev_id + SAMSUNG_I2S_SECOFF, NULL, 0,
+				NULL, 0);
 		if (IS_ERR(i2s->pdev))
 			return NULL;
 	}
@@ -992,49 +999,153 @@ struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 	return i2s;
 }
 
+#ifdef CONFIG_OF
+static int samsung_i2s_parse_dt_gpio(struct i2s_dai *i2s)
+{
+	struct device *dev = &i2s->pdev->dev;
+	int index, gpio, ret;
+
+	for (index = 0; index < 7; index++) {
+		gpio = of_get_gpio(dev->of_node, index);
+		if (!gpio_is_valid(gpio)) {
+			dev_err(dev, "invalid gpio[%d]: %d\n", index, gpio);
+			goto free_gpio;
+		}
+
+		ret = gpio_request(gpio, dev_name(dev));
+		if (ret) {
+			dev_err(dev, "gpio [%d] request failed\n", gpio);
+			goto free_gpio;
+		}
+		i2s->gpios[index] = gpio;
+	}
+	return 0;
+
+free_gpio:
+	while (--index >= 0)
+		gpio_free(i2s->gpios[index]);
+	return -EINVAL;
+}
+
+static void samsung_i2s_dt_gpio_free(struct i2s_dai *i2s)
+{
+	unsigned int index;
+	for (index = 0; index < 7; index++)
+		gpio_free(i2s->gpios[index]);
+}
+#else
+static int samsung_i2s_parse_dt_gpio(struct i2s_dai *dai)
+{
+	return -EINVAL;
+}
+
+static void samsung_i2s_dt_gpio_free(struct i2s_dai *dai)
+{
+}
+
+#endif
+
 static __devinit int samsung_i2s_probe(struct platform_device *pdev)
 {
-	u32 dma_pl_chan, dma_cp_chan, dma_pl_sec_chan;
+	u32 dma_pl_chan, dma_cp_chan;
+	u32 dma_pl_sec_chan = 0;
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
-	struct s3c_audio_pdata *i2s_pdata;
-	struct samsung_i2s *i2s_cfg;
+	struct s3c_audio_pdata *i2s_pdata = pdev->dev.platform_data;
+	struct samsung_i2s *i2s_cfg = NULL;
 	struct resource *res;
-	u32 regs_base, quirks;
-	int ret = 0;
+	u32 regs_base, quirks = 0, idma_addr = 0;
+	struct property *prop;
+	struct device_node *np = pdev->dev.of_node;
+	int ret = 0, id;
 
 	/* Call during Seconday interface registration */
-	if (pdev->id >= SAMSUNG_I2S_SECOFF) {
+	if (np) {
+		id = of_alias_get_id(np, "i2s");
+		if (id < 0) {
+			dev_err(&pdev->dev, "failed to get alias id:%d\n", id);
+			return id;
+		}
+	} else {
+		id = pdev->id;
+	}
+
+	if (id >= SAMSUNG_I2S_SECOFF) {
 		sec_dai = dev_get_drvdata(&pdev->dev);
 		snd_soc_register_dai(&sec_dai->pdev->dev,
 			&sec_dai->i2s_dai_drv);
 		return 0;
 	}
 
-	i2s_pdata = pdev->dev.platform_data;
-	if (i2s_pdata == NULL) {
-		dev_err(&pdev->dev, "Can't work without s3c_audio_pdata\n");
-		return -EINVAL;
+	pri_dai = i2s_alloc_dai(pdev, false);
+	if (!pri_dai) {
+		dev_err(&pdev->dev, "Unable to alloc I2S_pri\n");
+		return -ENOMEM;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Unable to get I2S-TX dma resource\n");
-		return -ENXIO;
-	}
-	dma_pl_chan = res->start;
+	if (!np) {
+		res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+		if (!res) {
+			dev_err(&pdev->dev,
+				"Unable to get I2S-TX dma resource\n");
+			return -ENXIO;
+		}
+		dma_pl_chan = res->start;
 
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!res) {
-		dev_err(&pdev->dev, "Unable to get I2S-RX dma resource\n");
-		return -ENXIO;
-	}
-	dma_cp_chan = res->start;
+		res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+		if (!res) {
+			dev_err(&pdev->dev,
+				"Unable to get I2S-RX dma resource\n");
+			return -ENXIO;
+		}
+		dma_cp_chan = res->start;
 
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 2);
-	if (res)
-		dma_pl_sec_chan = res->start;
-	else
-		dma_pl_sec_chan = 0;
+		res = platform_get_resource(pdev, IORESOURCE_DMA, 2);
+		if (res)
+			dma_pl_sec_chan = res->start;
+
+		if (&i2s_pdata->type)
+			i2s_cfg = &i2s_pdata->type.i2s;
+
+		if (i2s_cfg) {
+			quirks = i2s_cfg->quirks;
+			idma_addr = i2s_cfg->idma_addr;
+		}
+	} else {
+		prop = of_find_property(np, "tx-dma-channel", NULL);
+		if (!prop) {
+			dev_err(&pdev->dev, "tx dma channel property not"\
+					"specified\n");
+			return -ENXIO;
+		}
+		dma_pl_chan = DMACH_DT_PROP;
+		pri_dai->dma_playback.dma_prop = prop;
+
+		prop = of_find_property(np, "rx-dma-channel", NULL);
+		if (!prop) {
+			dev_err(&pdev->dev, "tx dma channel property not"\
+					"specified\n");
+			return -ENXIO;
+		}
+		dma_cp_chan = DMACH_DT_PROP;
+		pri_dai->dma_capture.dma_prop = prop;
+
+		if (of_find_property(np, "supports-6ch", NULL))
+			quirks |= QUIRK_PRI_6CHAN;
+
+		if (of_find_property(np, "supports-secdai", NULL))
+			quirks |= QUIRK_SEC_DAI;
+
+		if (of_find_property(np, "supports-rstclr", NULL))
+			quirks |= QUIRK_NEED_RSTCLR;
+
+		if (of_property_read_u32(np, "idma-addr", &idma_addr)) {
+			if (quirks & QUIRK_SEC_DAI) {
+				dev_err(&pdev->dev, "idma address is not"\
+						"specified");
+				return -EINVAL;
+			}
+		}
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -1049,16 +1160,6 @@ static __devinit int samsung_i2s_probe(struct platform_device *pdev)
 	}
 	regs_base = res->start;
 
-	i2s_cfg = &i2s_pdata->type.i2s;
-	quirks = i2s_cfg->quirks;
-
-	pri_dai = i2s_alloc_dai(pdev, false);
-	if (!pri_dai) {
-		dev_err(&pdev->dev, "Unable to alloc I2S_pri\n");
-		ret = -ENOMEM;
-		goto err;
-	}
-
 	pri_dai->dma_playback.dma_addr = regs_base + I2STXD;
 	pri_dai->dma_capture.dma_addr = regs_base + I2SRXD;
 	pri_dai->dma_playback.client =
@@ -1067,11 +1168,11 @@ static __devinit int samsung_i2s_probe(struct platform_device *pdev)
 		(struct s3c2410_dma_client *)&pri_dai->dma_capture;
 	pri_dai->dma_playback.channel = dma_pl_chan;
 	pri_dai->dma_capture.channel = dma_cp_chan;
-	pri_dai->src_clk = i2s_cfg->src_clk;
 	pri_dai->dma_playback.dma_size = 4;
 	pri_dai->dma_capture.dma_size = 4;
 	pri_dai->base = regs_base;
 	pri_dai->quirks = quirks;
+	pri_dai->dev_id = id;
 
 	if (quirks & QUIRK_PRI_6CHAN)
 		pri_dai->i2s_dai_drv.playback.channels_max = 6;
@@ -1086,21 +1187,42 @@ static __devinit int samsung_i2s_probe(struct platform_device *pdev)
 		sec_dai->dma_playback.dma_addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.client =
 			(struct s3c2410_dma_client *)&sec_dai->dma_playback;
+
+		if (np) {
+			prop = of_find_property(np, "tx-dma-channel-secondary",
+						NULL);
+			if (!prop) {
+				dev_err(&pdev->dev, "tx dma channel property"\
+						"not specified\n");
+				ret = -ENXIO;
+				goto err;
+			}
+			sec_dai->dma_playback.dma_prop = prop;
+		}
+
 		/* Use iDMA always if SysDMA not provided */
 		sec_dai->dma_playback.channel = dma_pl_sec_chan ? : -1;
-		sec_dai->src_clk = i2s_cfg->src_clk;
 		sec_dai->dma_playback.dma_size = 4;
 		sec_dai->base = regs_base;
 		sec_dai->quirks = quirks;
-		sec_dai->idma_playback.dma_addr = i2s_cfg->idma_addr;
+		sec_dai->dev_id = id;
+		sec_dai->idma_playback.dma_addr = idma_addr;
 		sec_dai->pri_dai = pri_dai;
 		pri_dai->sec_dai = sec_dai;
 	}
 
-	if (i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
-		dev_err(&pdev->dev, "Unable to configure gpio\n");
-		ret = -EINVAL;
-		goto err;
+	if (np) {
+		if (samsung_i2s_parse_dt_gpio(pri_dai)) {
+			dev_err(&pdev->dev, "Unable to configure gpio\n");
+			ret = -EINVAL;
+			goto err;
+		}
+	} else {
+		if (i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
+			dev_err(&pdev->dev, "Unable to configure gpio\n");
+			ret = -EINVAL;
+			goto err;
+		}
 	}
 
 	snd_soc_register_dai(&pri_dai->pdev->dev, &pri_dai->i2s_dai_drv);
@@ -1118,10 +1240,14 @@ static __devexit int samsung_i2s_remove(struct platform_device *pdev)
 {
 	struct i2s_dai *i2s, *other;
 	struct resource *res;
+	struct s3c_audio_pdata *i2s_pdata = pdev->dev.platform_data;
 
 	i2s = dev_get_drvdata(&pdev->dev);
 	other = i2s->pri_dai ? : i2s->sec_dai;
 
+	if (!i2s_pdata->cfg_gpio && pdev->dev.of_node)
+		samsung_i2s_dt_gpio_free(i2s->pri_dai);
+
 	if (other) {
 		other->pri_dai = NULL;
 		other->sec_dai = NULL;
@@ -1140,12 +1266,21 @@ static __devexit int samsung_i2s_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id exynos_i2s_match[] = {
+	{ .compatible = "samsung,samsung-i2s" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, exynos_i2s_match);
+#endif
+
 static struct platform_driver samsung_i2s_driver = {
 	.probe  = samsung_i2s_probe,
 	.remove = __devexit_p(samsung_i2s_remove),
 	.driver = {
 		.name = "samsung-i2s",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(exynos_i2s_match),
 	},
 };
 
-- 
1.7.4.4
