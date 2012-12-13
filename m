From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 13 Dec 2012 16:12:52 +0530
Subject: [PATCH V5 1/2] ASoC: Samsung: Rename samsung i2s secondary device name
In-Reply-To: <1355395373-22058-1-git-send-email-padma.v@samsung.com>
References: <1355395373-22058-1-git-send-email-padma.v@samsung.com>
Message-ID: <1355395373-22058-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Samsung SoCs has max 3 i2s controllers. So the i2s secondary fifo
interface device id was named as samsung-i2s.4. Renaming this to
"samsung-i2s-sec" to support device tree in i2s driver.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 sound/soc/samsung/i2s.c         |   31 ++++++++++++++++++++++++++++---
 sound/soc/samsung/i2s.h         |    7 -------
 sound/soc/samsung/smdk_wm8580.c |    7 ++-----
 sound/soc/samsung/smdk_wm8994.c |    4 ++--
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index d2d124f..ed5eeae 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -29,6 +29,11 @@
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 
+enum samsung_dai_type {
+	TYPE_PRI,
+	TYPE_SEC,
+};
+
 struct i2s_dai {
 	/* Platform device for this DAI */
 	struct platform_device *pdev;
@@ -981,8 +986,7 @@ static struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 		i2s->i2s_dai_drv.capture.formats = SAMSUNG_I2S_FMTS;
 	} else {	/* Create a new platform_device for Secondary */
 		i2s->pdev = platform_device_register_resndata(NULL,
-				pdev->name, pdev->id + SAMSUNG_I2S_SECOFF,
-				NULL, 0, NULL, 0);
+				"samsung-i2s-sec", -1, NULL, 0, NULL, 0);
 		if (IS_ERR(i2s->pdev))
 			return NULL;
 	}
@@ -993,6 +997,11 @@ static struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 	return i2s;
 }
 
+static inline int samsung_i2s_get_driver_data(struct platform_device *pdev)
+{
+	return platform_get_device_id(pdev)->driver_data;
+}
+
 static int samsung_i2s_probe(struct platform_device *pdev)
 {
 	u32 dma_pl_chan, dma_cp_chan, dma_pl_sec_chan;
@@ -1001,10 +1010,13 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	struct samsung_i2s *i2s_cfg;
 	struct resource *res;
 	u32 regs_base, quirks;
+	enum samsung_dai_type samsung_dai_type;
 	int ret = 0;
 
 	/* Call during Seconday interface registration */
-	if (pdev->id >= SAMSUNG_I2S_SECOFF) {
+	samsung_dai_type = samsung_i2s_get_driver_data(pdev);
+
+	if (samsung_dai_type == TYPE_SEC) {
 		sec_dai = dev_get_drvdata(&pdev->dev);
 		snd_soc_register_dai(&sec_dai->pdev->dev,
 			&sec_dai->i2s_dai_drv);
@@ -1143,9 +1155,22 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct platform_device_id samsung_i2s_driver_ids[] = {
+	{
+		.name           = "samsung-i2s",
+		.driver_data	= TYPE_PRI,
+	}, {
+		.name           = "samsung-i2s-sec",
+		.driver_data	= TYPE_SEC,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(platform, samsung-i2s-driver-ids);
+
 static struct platform_driver samsung_i2s_driver = {
 	.probe  = samsung_i2s_probe,
 	.remove = samsung_i2s_remove,
+	.id_table = samsung_i2s_driver_ids,
 	.driver = {
 		.name = "samsung-i2s",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/samsung/i2s.h b/sound/soc/samsung/i2s.h
index d420a7c..7966afc 100644
--- a/sound/soc/samsung/i2s.h
+++ b/sound/soc/samsung/i2s.h
@@ -13,13 +13,6 @@
 #ifndef __SND_SOC_SAMSUNG_I2S_H
 #define __SND_SOC_SAMSUNG_I2S_H
 
-/*
- * Maximum number of I2S blocks that any SoC can have.
- * The secondary interface of a CPU dai(if there exists any),
- * is indexed at [cpu-dai's ID + SAMSUNG_I2S_SECOFF]
- */
-#define SAMSUNG_I2S_SECOFF	4
-
 #define SAMSUNG_I2S_DIV_BCLK	1
 
 #define SAMSUNG_I2S_RCLKSRC_0	0
diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index 7e2b710..7a16b32 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -193,9 +193,9 @@ static struct snd_soc_dai_link smdk_dai[] = {
 	[SEC_PLAYBACK] = { /* Sec_Fifo Playback i/f */
 		.name = "Sec_FIFO TX",
 		.stream_name = "Playback",
-		.cpu_dai_name = "samsung-i2s.x",
+		.cpu_dai_name = "samsung-i2s-sec",
 		.codec_dai_name = "wm8580-hifi-playback",
-		.platform_name = "samsung-i2s.x",
+		.platform_name = "samsung-i2s-sec",
 		.codec_name = "wm8580.0-001b",
 		.ops = &smdk_ops,
 	},
@@ -223,9 +223,6 @@ static int __init smdk_audio_init(void)
 	if (machine_is_smdkc100()
 			|| machine_is_smdkv210() || machine_is_smdkc110()) {
 		smdk.num_links = 3;
-		/* Secondary is at offset SAMSUNG_I2S_SECOFF from Primary */
-		str = (char *)smdk_dai[SEC_PLAYBACK].cpu_dai_name;
-		str[strlen(str) - 1] = '0' + SAMSUNG_I2S_SECOFF;
 	} else if (machine_is_smdk6410()) {
 		str = (char *)smdk_dai[PRI_PLAYBACK].cpu_dai_name;
 		str[strlen(str) - 1] = '2';
diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index b0d0ab8..cc2f407 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -134,9 +134,9 @@ static struct snd_soc_dai_link smdk_dai[] = {
 	}, { /* Sec_Fifo Playback i/f */
 		.name = "Sec_FIFO TX",
 		.stream_name = "Sec_Dai",
-		.cpu_dai_name = "samsung-i2s.4",
+		.cpu_dai_name = "samsung-i2s-sec",
 		.codec_dai_name = "wm8994-aif1",
-		.platform_name = "samsung-i2s.4",
+		.platform_name = "samsung-i2s-sec",
 		.codec_name = "wm8994-codec",
 		.ops = &smdk_ops,
 	},
-- 
1.7.4.4
