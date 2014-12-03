From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Wed, 03 Dec 2014 16:39:14 +0000
Subject: [PATCH 5/5] ASoC: dwc: Ensure FIFOs are flushed to prevent channel
 swap
Message-ID: <547F3CB2.5070306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the FIFOs aren't flushed, the left/right channels may be swapped:
this may occur if the FIFOs are not empty when the streams start.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 sound/soc/dwc/designware_i2s.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 083779d..932abfd 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -258,6 +258,7 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 	/* Iterate over set of channels - independently controlled. */
 	do {
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			i2s_write_reg(dev->i2s_base, TXFFR, 1);
 			i2s_write_reg(dev->i2s_base, TCR(ch_reg),
 				      xfer_resolution);
 			i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
@@ -265,6 +266,7 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
 			i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
 		} else {
+			i2s_write_reg(dev->i2s_base, RXFFR, 1);
 			i2s_write_reg(dev->i2s_base, RCR(ch_reg),
 				      xfer_resolution);
 			i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
-- 
1.7.1
