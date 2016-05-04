From: john@metanate.com (John Keeping)
Date: Wed,  4 May 2016 15:54:46 +0100
Subject: [PATCH 2/2] Revert "ASoC: rockchip: i2s: separate capture and
 playback"
In-Reply-To: <1462373686-21794-1-git-send-email-john@metanate.com>
References: <1462373686-21794-1-git-send-email-john@metanate.com>
Message-ID: <1462373686-21794-2-git-send-email-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit eba65d179c1149cf79e68608d452631f33d7f017.

This broke audio on Veyron Jerry Chromebooks and I now cannot reproduce
the problem I was trying to fix even with this commit reverted, so it
seems that this was completely the wrong thing to do.

Reported-by: Enric Balletbo Serra <eballetbo@gmail.com>
Signed-off-by: John Keeping <john@metanate.com>
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
2.8.0.rc4.238.g874082a
