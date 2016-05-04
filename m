From: john@metanate.com (John Keeping)
Date: Wed,  4 May 2016 17:21:56 +0100
Subject: [PATCH v2 1/2] ASoC: rockchip: Revert "ASoC: rockchip: i2s: remove
 unused variables"
Message-ID: <1462378917-24135-1-git-send-email-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 5938448b99275cba95167c3f9d39ca9225fdad38.

It turns out that the commit that made these variables unused is wrong
so we're about to revert it.  Bring back the variables in prepration.

Signed-off-by: John Keeping <john@metanate.com>
---
v2: Add "ASoC: rockchip: " prefix to subject

 sound/soc/rockchip/rockchip_i2s.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 2f8e20416bd3..34743ec61c49 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -34,6 +34,13 @@ struct rk_i2s_dev {
 
 	struct regmap *regmap;
 
+/*
+ * Used to indicate the tx/rx status.
+ * I2S controller hopes to start the tx and rx together,
+ * also to stop them when they are both try to stop.
+*/
+	bool tx_start;
+	bool rx_start;
 	bool is_master_mode;
 };
 
@@ -77,7 +84,11 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 		regmap_update_bits(i2s->regmap, I2S_XFER,
 				   I2S_XFER_TXS_START,
 				   I2S_XFER_TXS_START);
+
+		i2s->tx_start = true;
 	} else {
+		i2s->tx_start = false;
+
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_DISABLE);
 
@@ -115,7 +126,11 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 		regmap_update_bits(i2s->regmap, I2S_XFER,
 				   I2S_XFER_RXS_START,
 				   I2S_XFER_RXS_START);
+
+		i2s->rx_start = true;
 	} else {
+		i2s->rx_start = false;
+
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_RDE_ENABLE, I2S_DMACR_RDE_DISABLE);
 
-- 
2.8.0.rc4.238.g874082a
