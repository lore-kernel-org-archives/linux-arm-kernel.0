From: andrew.jackson@arm.com (Andrew Jackson)
Date: Fri, 19 Dec 2014 16:18:06 +0000
Subject: [PATCH v3 2/5] ASoC: dwc: Iterate over all channels
In-Reply-To: <cover.1418826016.git.Andrew.Jackson@arm.com>
References: <cover.1418826016.git.Andrew.Jackson@arm.com>
Message-ID: <67cea1f0a74c333ec2048c7796cda37302d45e95.1418826016.git.Andrew.Jackson@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jackson <Andrew.Jackson@arm.com>

The Designware core can be configured with up to four stereo channels.
Each stereo channel is individually configured so, when the driver's
hw_params call is made, each requested stereo channel has to be
programmed.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 sound/soc/dwc/designware_i2s.c |   35 ++++++++++++++++-------------------
 1 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 5c13303..2ba1e2e 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -209,16 +209,9 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	switch (config->chan_nr) {
 	case EIGHT_CHANNEL_SUPPORT:
-		ch_reg = 3;
-		break;
 	case SIX_CHANNEL_SUPPORT:
-		ch_reg = 2;
-		break;
 	case FOUR_CHANNEL_SUPPORT:
-		ch_reg = 1;
-		break;
 	case TWO_CHANNEL_SUPPORT:
-		ch_reg = 0;
 		break;
 	default:
 		dev_err(dev->dev, "channel not supported\n");
@@ -227,18 +220,22 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	i2s_disable_channels(dev, substream->stream);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		i2s_write_reg(dev->i2s_base, TCR(ch_reg), xfer_resolution);
-		i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
-		irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
-		i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
-		i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
-	} else {
-		i2s_write_reg(dev->i2s_base, RCR(ch_reg), xfer_resolution);
-		i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
-		irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
-		i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
-		i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
+	for (ch_reg = 0; ch_reg < (config->chan_nr / 2); ch_reg++) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			i2s_write_reg(dev->i2s_base, TCR(ch_reg),
+				      xfer_resolution);
+			i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
+			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
+			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
+			i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
+		} else {
+			i2s_write_reg(dev->i2s_base, RCR(ch_reg),
+				      xfer_resolution);
+			i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
+			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
+			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
+			i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
+		}
 	}
 
 	i2s_write_reg(dev->i2s_base, CCR, ccr);
-- 
1.7.1
