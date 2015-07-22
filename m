From: koro.chen@mediatek.com (Koro Chen)
Date: Wed, 22 Jul 2015 17:39:35 +0800
Subject: [PATCH] ASoC: mediatek: Add suspend/resume callbacks
Message-ID: <1437557975-48183-1-git-send-email-koro.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds suspend/resume callbacks, which are common for each DAI.
To be able to continue the last playback/capture after resume
when suspend was done during a playback/capture, in the callbacks
we do backup/restore of registers which were set before prepare stage.
Registers to be backup/restore are defined in a backup list array.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/mediatek/mtk-afe-common.h |  8 ----
 sound/soc/mediatek/mtk-afe-pcm.c    | 77 +++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/sound/soc/mediatek/mtk-afe-common.h b/sound/soc/mediatek/mtk-afe-common.h
index a88b175..cc4393c 100644
--- a/sound/soc/mediatek/mtk-afe-common.h
+++ b/sound/soc/mediatek/mtk-afe-common.h
@@ -98,12 +98,4 @@ struct mtk_afe_memif {
 	const struct mtk_afe_irq_data *irqdata;
 };
 
-struct mtk_afe {
-	/* address for ioremap audio hardware register */
-	void __iomem *base_addr;
-	struct device *dev;
-	struct regmap *regmap;
-	struct mtk_afe_memif memif[MTK_AFE_MEMIF_NUM];
-	struct clk *clocks[MTK_CLK_NUM];
-};
 #endif
diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index de38d2e..55471ee 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -45,18 +45,21 @@
 /* Memory interface */
 #define AFE_DL1_BASE		0x0040
 #define AFE_DL1_CUR		0x0044
+#define AFE_DL1_END		0x0048
 #define AFE_DL2_BASE		0x0050
 #define AFE_DL2_CUR		0x0054
 #define AFE_AWB_BASE		0x0070
 #define AFE_AWB_CUR		0x007c
 #define AFE_VUL_BASE		0x0080
 #define AFE_VUL_CUR		0x008c
+#define AFE_VUL_END		0x0088
 #define AFE_DAI_BASE		0x0090
 #define AFE_DAI_CUR		0x009c
 #define AFE_MOD_PCM_BASE	0x0330
 #define AFE_MOD_PCM_CUR		0x033c
 #define AFE_HDMI_OUT_BASE	0x0374
 #define AFE_HDMI_OUT_CUR	0x0378
+#define AFE_HDMI_OUT_END	0x037c
 
 #define AFE_ADDA2_TOP_CON0	0x0600
 
@@ -127,6 +130,34 @@ enum afe_tdm_ch_start {
 	AFE_TDM_CH_ZERO,
 };
 
+static const unsigned int mtk_afe_backup_list[] = {
+	AUDIO_TOP_CON0,
+	AFE_CONN1,
+	AFE_CONN2,
+	AFE_CONN7,
+	AFE_CONN8,
+	AFE_DAC_CON1,
+	AFE_DL1_BASE,
+	AFE_DL1_END,
+	AFE_VUL_BASE,
+	AFE_VUL_END,
+	AFE_HDMI_OUT_BASE,
+	AFE_HDMI_OUT_END,
+	AFE_HDMI_CONN0,
+	AFE_DAC_CON0,
+};
+
+struct mtk_afe {
+	/* address for ioremap audio hardware register */
+	void __iomem *base_addr;
+	struct device *dev;
+	struct regmap *regmap;
+	struct mtk_afe_memif memif[MTK_AFE_MEMIF_NUM];
+	struct clk *clocks[MTK_CLK_NUM];
+	unsigned int backup_regs[ARRAY_SIZE(mtk_afe_backup_list)];
+	bool suspended;
+};
+
 static const struct snd_pcm_hardware mtk_afe_hardware = {
 	.info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_MMAP_VALID),
@@ -722,11 +753,53 @@ static const struct snd_soc_dai_ops mtk_afe_hdmi_ops = {
 
 };
 
+static int mtk_afe_runtime_suspend(struct device *dev);
+static int mtk_afe_runtime_resume(struct device *dev);
+
+static int mtk_afe_dai_suspend(struct snd_soc_dai *dai)
+{
+	struct mtk_afe *afe = snd_soc_dai_get_drvdata(dai);
+	int i;
+
+	dev_dbg(afe->dev, "%s\n", __func__);
+	if (pm_runtime_status_suspended(afe->dev) || afe->suspended)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(mtk_afe_backup_list); i++)
+		regmap_read(afe->regmap, mtk_afe_backup_list[i],
+			    &afe->backup_regs[i]);
+
+	afe->suspended = true;
+	mtk_afe_runtime_suspend(afe->dev);
+	return 0;
+}
+
+static int mtk_afe_dai_resume(struct snd_soc_dai *dai)
+{
+	struct mtk_afe *afe = snd_soc_dai_get_drvdata(dai);
+	int i = 0;
+
+	dev_dbg(afe->dev, "%s\n", __func__);
+	if (pm_runtime_status_suspended(afe->dev) || !afe->suspended)
+		return 0;
+
+	mtk_afe_runtime_resume(afe->dev);
+
+	for (i = 0; i < ARRAY_SIZE(mtk_afe_backup_list); i++)
+		regmap_write(afe->regmap, mtk_afe_backup_list[i],
+			     afe->backup_regs[i]);
+
+	afe->suspended = false;
+	return 0;
+}
+
 static struct snd_soc_dai_driver mtk_afe_pcm_dais[] = {
 	/* FE DAIs: memory intefaces to CPU */
 	{
 		.name = "DL1", /* downlink 1 */
 		.id = MTK_AFE_MEMIF_DL1,
+		.suspend = mtk_afe_dai_suspend,
+		.resume = mtk_afe_dai_resume,
 		.playback = {
 			.stream_name = "DL1",
 			.channels_min = 1,
@@ -738,6 +811,8 @@ static struct snd_soc_dai_driver mtk_afe_pcm_dais[] = {
 	}, {
 		.name = "VUL", /* voice uplink */
 		.id = MTK_AFE_MEMIF_VUL,
+		.suspend = mtk_afe_dai_suspend,
+		.resume = mtk_afe_dai_resume,
 		.capture = {
 			.stream_name = "VUL",
 			.channels_min = 1,
@@ -774,6 +849,8 @@ static struct snd_soc_dai_driver mtk_afe_hdmi_dais[] = {
 	{
 		.name = "HDMI",
 		.id = MTK_AFE_MEMIF_HDMI,
+		.suspend = mtk_afe_dai_suspend,
+		.resume = mtk_afe_dai_resume,
 		.playback = {
 			.stream_name = "HDMI",
 			.channels_min = 2,
-- 
1.8.1.1.dirty
