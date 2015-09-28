From: yitian.bu@tangramtek.com (yitian)
Date: Mon, 28 Sep 2015 17:48:14 +0800
Subject: [PATCH v2 1/1] ASoC: dwc: fix dma stop transferring issue
Message-ID: <037a01d0f9d2$cec8aa10$6c59fe30$@tangramtek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Designware I2S uses tx empty and rx available signals as the DMA
handshaking signals. during music playing, if XRUN occurs,
i2s_stop() function will be executed and both tx and rx irq are
masked, when music contintes to be played, i2s_start() is executed
but both tx and rx irq are not unmasked which cause I2S stop
sending DMA handshaking signal to DMA controller, and it finally
cause music playing will be stopped once XRUN occurs for the first
time.

Signed-off-by: Yitian Bu <yitian.bu@tangramtek.com>
---
changes in V2:
 - add definition for i and irq
---
 sound/soc/dwc/designware_i2s.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index a3e97b4..76b2e19 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -141,13 +141,22 @@ static inline void i2s_clear_irqs(struct dw_i2s_dev
*dev, u32 stream)
 static void i2s_start(struct dw_i2s_dev *dev,
 		      struct snd_pcm_substream *substream)
 {
-
+	u32 i, irq;
 	i2s_write_reg(dev->i2s_base, IER, 1);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		for (i = 0; i < 4; i++) {
+			irq = i2s_read_reg(dev->i2s_base, IMR(i));
+			i2s_write_reg(dev->i2s_base, IMR(i), irq & ~0x30);
+		}
 		i2s_write_reg(dev->i2s_base, ITER, 1);
-	else
+	} else {
+		for (i = 0; i < 4; i++) {
+			irq = i2s_read_reg(dev->i2s_base, IMR(i));
+			i2s_write_reg(dev->i2s_base, IMR(i), irq & ~0x03);
+		}
 		i2s_write_reg(dev->i2s_base, IRER, 1);
+	}
 
 	i2s_write_reg(dev->i2s_base, CER, 1);
 }
-- 

1.7.12.4
