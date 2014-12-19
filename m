From: andrew.jackson@arm.com (Andrew Jackson)
Date: Fri, 19 Dec 2014 16:18:05 +0000
Subject: [PATCH v3 1/5] ASoC: dwc: Ensure FIFOs are flushed to prevent channel
 swap
In-Reply-To: <cover.1418826016.git.Andrew.Jackson@arm.com>
References: <cover.1418826016.git.Andrew.Jackson@arm.com>
Message-ID: <8f40608d5665e80bfd3e9723784ec3bc2078e0d2.1418826016.git.Andrew.Jackson@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

Flush the FIFOs when the stream is prepared for use.  This avoids
an inadvertent swapping of the left/right channels if the FIFOs are
not empty at startup.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 sound/soc/dwc/designware_i2s.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index f81e747..5c13303 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -263,6 +263,19 @@ static void dw_i2s_shutdown(struct snd_pcm_substream *substream,
 	snd_soc_dai_set_dma_data(dai, substream, NULL);
 }
 
+static int dw_i2s_prepare(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		i2s_write_reg(dev->i2s_base, TXFFR, 1);
+	else
+		i2s_write_reg(dev->i2s_base, RXFFR, 1);
+
+	return 0;
+}
+
 static int dw_i2s_trigger(struct snd_pcm_substream *substream,
 		int cmd, struct snd_soc_dai *dai)
 {
@@ -294,6 +307,7 @@ static struct snd_soc_dai_ops dw_i2s_dai_ops = {
 	.startup	= dw_i2s_startup,
 	.shutdown	= dw_i2s_shutdown,
 	.hw_params	= dw_i2s_hw_params,
+	.prepare	= dw_i2s_prepare,
 	.trigger	= dw_i2s_trigger,
 };
 
-- 
1.7.1
