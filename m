From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Sat, 28 Apr 2018 22:51:40 +0200
Subject: [PATCH 3/5] ASoC: cirrus: i2s: Stop enabling I2S2 and I2S3 FIFOs
In-Reply-To: <20180428205142.31921-1-alexander.sverdlin@gmail.com>
References: <20180428205142.31921-1-alexander.sverdlin@gmail.com>
Message-ID: <20180428205142.31921-4-alexander.sverdlin@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver never supported more than 2 channels because of
ep93xx_i2s_dma_data[] supporting only 1 DMA channel in each
direction.
Stop enabling two unused I2S controller FIFOs, this will simplify
future interrupt support.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 sound/soc/cirrus/ep93xx-i2s.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 0dc3852c4621..42cc6d22baac 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -98,7 +98,6 @@ static inline unsigned ep93xx_i2s_read_reg(struct ep93xx_i2s_info *info,
 static void ep93xx_i2s_enable(struct ep93xx_i2s_info *info, int stream)
 {
 	unsigned base_reg;
-	int i;
 
 	if ((ep93xx_i2s_read_reg(info, EP93XX_I2S_TX0EN) & 0x1) == 0 &&
 	    (ep93xx_i2s_read_reg(info, EP93XX_I2S_RX0EN) & 0x1) == 0) {
@@ -111,27 +110,24 @@ static void ep93xx_i2s_enable(struct ep93xx_i2s_info *info, int stream)
 		ep93xx_i2s_write_reg(info, EP93XX_I2S_GLCTRL, 1);
 	}
 
-	/* Enable fifos */
+	/* Enable fifo */
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 		base_reg = EP93XX_I2S_TX0EN;
 	else
 		base_reg = EP93XX_I2S_RX0EN;
-	for (i = 0; i < 3; i++)
-		ep93xx_i2s_write_reg(info, base_reg + (i * 4), 1);
+	ep93xx_i2s_write_reg(info, base_reg, 1);
 }
 
 static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info, int stream)
 {
 	unsigned base_reg;
-	int i;
 
-	/* Disable fifos */
+	/* Disable fifo */
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 		base_reg = EP93XX_I2S_TX0EN;
 	else
 		base_reg = EP93XX_I2S_RX0EN;
-	for (i = 0; i < 3; i++)
-		ep93xx_i2s_write_reg(info, base_reg + (i * 4), 0);
+	ep93xx_i2s_write_reg(info, base_reg, 0);
 
 	if ((ep93xx_i2s_read_reg(info, EP93XX_I2S_TX0EN) & 0x1) == 0 &&
 	    (ep93xx_i2s_read_reg(info, EP93XX_I2S_RX0EN) & 0x1) == 0) {
-- 
2.16.2
