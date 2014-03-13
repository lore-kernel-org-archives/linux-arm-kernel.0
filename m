From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 13 Mar 2014 11:18:40 +0200
Subject: [PATCH 18/18] ASoC: davinci-mcasp: Place constraint on the period
 size based on FIFO config
In-Reply-To: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1394702320-21743-19-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to place constraint on the period size (and indirectly to buffer
size) if the read or write AFIFO is enabled and it is configured for more
than one word otherwise the DMA will fail in buffer configuration where
the sizes are not aligned with the requested FIFO configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 958933614ca4..17d1112bce24 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -717,7 +717,27 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *cpu_dai)
+{
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
+	int afifo_numevt;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		afifo_numevt = mcasp->txnumevt;
+	else
+		afifo_numevt = mcasp->rxnumevt;
+
+	if (afifo_numevt > 1)
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					   afifo_numevt);
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
+	.startup	= davinci_mcasp_startup,
 	.trigger	= davinci_mcasp_trigger,
 	.hw_params	= davinci_mcasp_hw_params,
 	.set_fmt	= davinci_mcasp_set_dai_fmt,
-- 
1.9.0
