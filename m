From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 2 Jan 2018 19:47:32 +0800
Subject: [PATCH 07/12] ASoC: mediatek: modify MT2701 AFE driver to adapt
 subsystem wrapper
In-Reply-To: <cover.1514881870.git.ryder.lee@mediatek.com>
References: <cover.1514881870.git.ryder.lee@mediatek.com>
Message-ID: <f1d6e5ebbfc6276f17e94f9a2669f6074ed65d41.1514881870.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the new audio subsystem wrapper is in place, modify MT2701 AFE driver
to adapt it.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 42 ++++++++++++------------------
 sound/soc/mediatek/mt2701/mt2701-reg.h     |  1 -
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 0edadca..de4ce3a 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1368,14 +1368,6 @@ static int mt2701_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 	},
 };
 
-static const struct regmap_config mt2701_afe_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = AFE_END_ADDR,
-	.cache_type = REGCACHE_NONE,
-};
-
 static irqreturn_t mt2701_asys_isr(int irq_id, void *dev)
 {
 	int id;
@@ -1414,9 +1406,9 @@ static int mt2701_afe_runtime_resume(struct device *dev)
 
 static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 {
+	struct snd_soc_component *component;
 	struct mtk_base_afe *afe;
 	struct mt2701_afe_private *afe_priv;
-	struct resource *res;
 	struct device *dev;
 	int i, irq_id, ret;
 
@@ -1446,17 +1438,9 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	afe->base_addr = devm_ioremap_resource(&pdev->dev, res);
-
-	if (IS_ERR(afe->base_addr))
-		return PTR_ERR(afe->base_addr);
-
-	afe->regmap = devm_regmap_init_mmio(&pdev->dev, afe->base_addr,
-		&mt2701_afe_regmap_config);
-	if (IS_ERR(afe->regmap))
-		return PTR_ERR(afe->regmap);
+	afe->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!afe->regmap)
+		return -ENODEV;
 
 	mutex_init(&afe->irq_alloc_lock);
 
@@ -1490,6 +1474,12 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 			= &mt2701_i2s_data[i][I2S_IN];
 	}
 
+	component = kzalloc(sizeof(*component), GFP_KERNEL);
+	if (!component)
+		return -ENOMEM;
+
+	component->regmap = afe->regmap;
+
 	afe->mtk_afe_hardware = &mt2701_afe_hardware;
 	afe->memif_fs = mt2701_memif_fs;
 	afe->irq_fs = mt2701_irq_fs;
@@ -1502,7 +1492,7 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 	ret = mt2701_init_clock(afe);
 	if (ret) {
 		dev_err(dev, "init clock error\n");
-		return ret;
+		goto err_init_clock;
 	}
 
 	platform_set_drvdata(pdev, afe);
@@ -1521,10 +1511,10 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 		goto err_platform;
 	}
 
-	ret = snd_soc_register_component(&pdev->dev,
-					 &mt2701_afe_pcm_dai_component,
-					 mt2701_afe_pcm_dais,
-					 ARRAY_SIZE(mt2701_afe_pcm_dais));
+	ret = snd_soc_add_component(dev, component,
+				    &mt2701_afe_pcm_dai_component,
+				    mt2701_afe_pcm_dais,
+				    ARRAY_SIZE(mt2701_afe_pcm_dais));
 	if (ret) {
 		dev_warn(dev, "err_dai_component\n");
 		goto err_dai_component;
@@ -1538,6 +1528,8 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 err_pm_disable:
 	pm_runtime_disable(dev);
+err_init_clock:
+	kfree(component);
 
 	return ret;
 }
diff --git a/sound/soc/mediatek/mt2701/mt2701-reg.h b/sound/soc/mediatek/mt2701/mt2701-reg.h
index f17c76f..18e6769 100644
--- a/sound/soc/mediatek/mt2701/mt2701-reg.h
+++ b/sound/soc/mediatek/mt2701/mt2701-reg.h
@@ -145,5 +145,4 @@
 #define ASYS_I2S_CON_WIDE_MODE_SET(x)	((x) << 1)
 #define ASYS_I2S_IN_PHASE_FIX		(0x1 << 31)
 
-#define AFE_END_ADDR 0x15e0
 #endif
-- 
1.9.1
