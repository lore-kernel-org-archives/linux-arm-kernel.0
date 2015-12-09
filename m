From: john@metanate.com (John Keeping)
Date: Wed,  9 Dec 2015 10:32:26 +0000
Subject: [PATCH 1/2] ASoC: rockchip: i2s: separate capture and playback
Message-ID: <1449657147-26959-1-git-send-email-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we only clear the tx/rx state when both are disabled it is not
possible to start/stop one multiple times while the other is running.
Since the two are independently controlled, treat them as such and
remove the false dependency between capture and playback.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 72 +++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 83b1b9c..acc6225 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -82,8 +82,8 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 				   I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_ENABLE);
 
 		regmap_update_bits(i2s->regmap, I2S_XFER,
-				   I2S_XFER_TXS_START | I2S_XFER_RXS_START,
-				   I2S_XFER_TXS_START | I2S_XFER_RXS_START);
+				   I2S_XFER_TXS_START,
+				   I2S_XFER_TXS_START);
 
 		i2s->tx_start = true;
 	} else {
@@ -92,27 +92,23 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_DISABLE);
 
-		if (!i2s->rx_start) {
-			regmap_update_bits(i2s->regmap, I2S_XFER,
-					   I2S_XFER_TXS_START |
-					   I2S_XFER_RXS_START,
-					   I2S_XFER_TXS_STOP |
-					   I2S_XFER_RXS_STOP);
+		regmap_update_bits(i2s->regmap, I2S_XFER,
+				   I2S_XFER_TXS_START,
+				   I2S_XFER_TXS_STOP);
 
-			regmap_update_bits(i2s->regmap, I2S_CLR,
-					   I2S_CLR_TXC | I2S_CLR_RXC,
-					   I2S_CLR_TXC | I2S_CLR_RXC);
+		regmap_update_bits(i2s->regmap, I2S_CLR,
+				   I2S_CLR_TXC,
+				   I2S_CLR_TXC);
 
-			regmap_read(i2s->regmap, I2S_CLR, &val);
+		regmap_read(i2s->regmap, I2S_CLR, &val);
 
-			/* Should wait for clear operation to finish */
-			while (val) {
-				regmap_read(i2s->regmap, I2S_CLR, &val);
-				retry--;
-				if (!retry) {
-					dev_warn(i2s->dev, "fail to clear\n");
-					break;
-				}
+		/* Should wait for clear operation to finish */
+		while (val & I2S_CLR_TXC) {
+			regmap_read(i2s->regmap, I2S_CLR, &val);
+			retry--;
+			if (!retry) {
+				dev_warn(i2s->dev, "fail to clear\n");
+				break;
 			}
 		}
 	}
@@ -128,8 +124,8 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 				   I2S_DMACR_RDE_ENABLE, I2S_DMACR_RDE_ENABLE);
 
 		regmap_update_bits(i2s->regmap, I2S_XFER,
-				   I2S_XFER_TXS_START | I2S_XFER_RXS_START,
-				   I2S_XFER_TXS_START | I2S_XFER_RXS_START);
+				   I2S_XFER_RXS_START,
+				   I2S_XFER_RXS_START);
 
 		i2s->rx_start = true;
 	} else {
@@ -138,27 +134,23 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_RDE_ENABLE, I2S_DMACR_RDE_DISABLE);
 
-		if (!i2s->tx_start) {
-			regmap_update_bits(i2s->regmap, I2S_XFER,
-					   I2S_XFER_TXS_START |
-					   I2S_XFER_RXS_START,
-					   I2S_XFER_TXS_STOP |
-					   I2S_XFER_RXS_STOP);
+		regmap_update_bits(i2s->regmap, I2S_XFER,
+				   I2S_XFER_RXS_START,
+				   I2S_XFER_RXS_STOP);
 
-			regmap_update_bits(i2s->regmap, I2S_CLR,
-					   I2S_CLR_TXC | I2S_CLR_RXC,
-					   I2S_CLR_TXC | I2S_CLR_RXC);
+		regmap_update_bits(i2s->regmap, I2S_CLR,
+				   I2S_CLR_RXC,
+				   I2S_CLR_RXC);
 
-			regmap_read(i2s->regmap, I2S_CLR, &val);
+		regmap_read(i2s->regmap, I2S_CLR, &val);
 
-			/* Should wait for clear operation to finish */
-			while (val) {
-				regmap_read(i2s->regmap, I2S_CLR, &val);
-				retry--;
-				if (!retry) {
-					dev_warn(i2s->dev, "fail to clear\n");
-					break;
-				}
+		/* Should wait for clear operation to finish */
+		while (val & I2S_CLR_RXC) {
+			regmap_read(i2s->regmap, I2S_CLR, &val);
+			retry--;
+			if (!retry) {
+				dev_warn(i2s->dev, "fail to clear\n");
+				break;
 			}
 		}
 	}
-- 
2.6.3.462.gbe2c914
