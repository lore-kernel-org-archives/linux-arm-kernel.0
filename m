From: broonie@kernel.org (Mark Brown)
Date: Thu, 05 May 2016 16:56:20 +0100
Subject: Applied "ASoC: rockchip: Revert "ASoC: rockchip: i2s: separate
 capture and playback"" to the asoc tree
In-Reply-To: <1462373686-21794-2-git-send-email-john@metanate.com>
Message-ID: <E1ayLdU-0004jH-K0@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: Revert "ASoC: rockchip: i2s: separate capture and playback"

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7e885d211f023dfd201fad8246bbf3c3bd126c61 Mon Sep 17 00:00:00 2001
From: John Keeping <john@metanate.com>
Date: Wed, 4 May 2016 17:21:57 +0100
Subject: [PATCH] ASoC: rockchip: Revert "ASoC: rockchip: i2s: separate capture
 and playback"

This reverts commit eba65d179c1149cf79e68608d452631f33d7f017.

This broke audio on Veyron Jerry Chromebooks and I now cannot reproduce
the problem I was trying to fix even with this commit reverted, so it
seems that this was completely the wrong thing to do.

Reported-by: Enric Balletbo Serra <eballetbo@gmail.com>
Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 72 ++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 34743ec61c49..574c6af28c06 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -82,8 +82,8 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 				   I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_ENABLE);
 
 		regmap_update_bits(i2s->regmap, I2S_XFER,
-				   I2S_XFER_TXS_START,
-				   I2S_XFER_TXS_START);
+				   I2S_XFER_TXS_START | I2S_XFER_RXS_START,
+				   I2S_XFER_TXS_START | I2S_XFER_RXS_START);
 
 		i2s->tx_start = true;
 	} else {
@@ -92,23 +92,27 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_DISABLE);
 
-		regmap_update_bits(i2s->regmap, I2S_XFER,
-				   I2S_XFER_TXS_START,
-				   I2S_XFER_TXS_STOP);
-
-		regmap_update_bits(i2s->regmap, I2S_CLR,
-				   I2S_CLR_TXC,
-				   I2S_CLR_TXC);
+		if (!i2s->rx_start) {
+			regmap_update_bits(i2s->regmap, I2S_XFER,
+					   I2S_XFER_TXS_START |
+					   I2S_XFER_RXS_START,
+					   I2S_XFER_TXS_STOP |
+					   I2S_XFER_RXS_STOP);
 
-		regmap_read(i2s->regmap, I2S_CLR, &val);
+			regmap_update_bits(i2s->regmap, I2S_CLR,
+					   I2S_CLR_TXC | I2S_CLR_RXC,
+					   I2S_CLR_TXC | I2S_CLR_RXC);
 
-		/* Should wait for clear operation to finish */
-		while (val & I2S_CLR_TXC) {
 			regmap_read(i2s->regmap, I2S_CLR, &val);
-			retry--;
-			if (!retry) {
-				dev_warn(i2s->dev, "fail to clear\n");
-				break;
+
+			/* Should wait for clear operation to finish */
+			while (val) {
+				regmap_read(i2s->regmap, I2S_CLR, &val);
+				retry--;
+				if (!retry) {
+					dev_warn(i2s->dev, "fail to clear\n");
+					break;
+				}
 			}
 		}
 	}
@@ -124,8 +128,8 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 				   I2S_DMACR_RDE_ENABLE, I2S_DMACR_RDE_ENABLE);
 
 		regmap_update_bits(i2s->regmap, I2S_XFER,
-				   I2S_XFER_RXS_START,
-				   I2S_XFER_RXS_START);
+				   I2S_XFER_TXS_START | I2S_XFER_RXS_START,
+				   I2S_XFER_TXS_START | I2S_XFER_RXS_START);
 
 		i2s->rx_start = true;
 	} else {
@@ -134,23 +138,27 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_RDE_ENABLE, I2S_DMACR_RDE_DISABLE);
 
-		regmap_update_bits(i2s->regmap, I2S_XFER,
-				   I2S_XFER_RXS_START,
-				   I2S_XFER_RXS_STOP);
-
-		regmap_update_bits(i2s->regmap, I2S_CLR,
-				   I2S_CLR_RXC,
-				   I2S_CLR_RXC);
+		if (!i2s->tx_start) {
+			regmap_update_bits(i2s->regmap, I2S_XFER,
+					   I2S_XFER_TXS_START |
+					   I2S_XFER_RXS_START,
+					   I2S_XFER_TXS_STOP |
+					   I2S_XFER_RXS_STOP);
 
-		regmap_read(i2s->regmap, I2S_CLR, &val);
+			regmap_update_bits(i2s->regmap, I2S_CLR,
+					   I2S_CLR_TXC | I2S_CLR_RXC,
+					   I2S_CLR_TXC | I2S_CLR_RXC);
 
-		/* Should wait for clear operation to finish */
-		while (val & I2S_CLR_RXC) {
 			regmap_read(i2s->regmap, I2S_CLR, &val);
-			retry--;
-			if (!retry) {
-				dev_warn(i2s->dev, "fail to clear\n");
-				break;
+
+			/* Should wait for clear operation to finish */
+			while (val) {
+				regmap_read(i2s->regmap, I2S_CLR, &val);
+				retry--;
+				if (!retry) {
+					dev_warn(i2s->dev, "fail to clear\n");
+					break;
+				}
 			}
 		}
 	}
-- 
2.8.1
