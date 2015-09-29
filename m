From: yitian.bu@tangramtek.com (yitian)
Date: Tue, 29 Sep 2015 22:39:00 +0800
Subject: [RESEND PATCH 1/1] ASoC: dwc: correct irq clear method
Message-ID: <006301d0fac4$94eb5890$bec209b0$@tangramtek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

from Designware I2S datasheet, irq is cleared by reading from
TOR/ROR registers, rather than by writing into them.

Signed-off-by: Yitian Bu <yitian.bu@tangramtek.com>
---
 sound/soc/dwc/designware_i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index a3e97b4..0d28e3b 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -131,10 +131,10 @@ static inline void i2s_clear_irqs(struct dw_i2s_dev
*dev, u32 stream)
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		for (i = 0; i < 4; i++)
-			i2s_write_reg(dev->i2s_base, TOR(i), 0);
+			i2s_read_reg(dev->i2s_base, TOR(i));
 	} else {
 		for (i = 0; i < 4; i++)
-			i2s_write_reg(dev->i2s_base, ROR(i), 0);
+			i2s_read_reg(dev->i2s_base, ROR(i));
 	}
 }
 
-- 
1.7.12.4
