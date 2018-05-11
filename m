From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 May 2018 03:37:34 +0100 (BST)
Subject: Applied "ASoC: cirrus: i2s: Stop enabling I2S2 and I2S3 FIFOs" to the
 asoc tree
In-Reply-To: <20180428205142.31921-4-alexander.sverdlin@gmail.com>
Message-ID: <20180511023735.0546244007A@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: cirrus: i2s: Stop enabling I2S2 and I2S3 FIFOs

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From cc27062b3eee3beb2e3830641b23ba9a52a8a04a Mon Sep 17 00:00:00 2001
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Date: Sat, 28 Apr 2018 22:51:40 +0200
Subject: [PATCH] ASoC: cirrus: i2s: Stop enabling I2S2 and I2S3 FIFOs

The driver never supported more than 2 channels because of
ep93xx_i2s_dma_data[] supporting only 1 DMA channel in each
direction.
Stop enabling two unused I2S controller FIFOs, this will simplify
future interrupt support.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.17.0
