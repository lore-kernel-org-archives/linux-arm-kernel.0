From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 30 May 2016 11:55:21 +0300
Subject: [PATCH v1 13/14] ASoC: omap-mcpdm: Support for suspend resume
In-Reply-To: <20160530085522.30398-1-peter.ujfalusi@ti.com>
References: <20160530085522.30398-1-peter.ujfalusi@ti.com>
Message-ID: <20160530085522.30398-14-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement ASoC's suspend and resume callbacks.
Since McPDM does not use pcm_trigger for start and stop of the stream due
to strict sequencing needs with the twl6040, the callbacks will stop and
restart the McPDM in case the board suspended during audio activity.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 11bd07cdce22..74d6e6fdcfd0 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -66,6 +66,9 @@ struct omap_mcpdm {
 	/* McPDM needs to be restarted due to runtime reconfiguration */
 	bool restart;
 
+	/* pm state for suspend/resume handling */
+	int pm_active_count;
+
 	struct snd_dmaengine_dai_dma_data dma_data[2];
 };
 
@@ -422,12 +425,55 @@ static int omap_mcpdm_remove(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int omap_mcpdm_suspend(struct snd_soc_dai *dai)
+{
+	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+
+	if (dai->active) {
+		omap_mcpdm_stop(mcpdm);
+		omap_mcpdm_close_streams(mcpdm);
+	}
+
+	mcpdm->pm_active_count = 0;
+	while (pm_runtime_active(mcpdm->dev)) {
+		pm_runtime_put_sync(mcpdm->dev);
+		mcpdm->pm_active_count++;
+	}
+
+	return 0;
+}
+
+static int omap_mcpdm_resume(struct snd_soc_dai *dai)
+{
+	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+
+	if (mcpdm->pm_active_count) {
+		while (mcpdm->pm_active_count--)
+			pm_runtime_get_sync(mcpdm->dev);
+
+		if (dai->active) {
+			omap_mcpdm_open_streams(mcpdm);
+			omap_mcpdm_start(mcpdm);
+		}
+	}
+
+
+	return 0;
+}
+#else
+#define omap_mcpdm_suspend NULL
+#define omap_mcpdm_resume NULL
+#endif
+
 #define OMAP_MCPDM_RATES	(SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 #define OMAP_MCPDM_FORMATS	SNDRV_PCM_FMTBIT_S32_LE
 
 static struct snd_soc_dai_driver omap_mcpdm_dai = {
 	.probe = omap_mcpdm_probe,
 	.remove = omap_mcpdm_remove,
+	.suspend = omap_mcpdm_suspend,
+	.resume = omap_mcpdm_resume,
 	.probe_order = SND_SOC_COMP_ORDER_LATE,
 	.remove_order = SND_SOC_COMP_ORDER_EARLY,
 	.playback = {
-- 
2.8.3
