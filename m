From: broonie@kernel.org (Mark Brown)
Date: Thu, 05 May 2016 16:56:23 +0100
Subject: Applied "ASoC: rockchip: Revert "ASoC: rockchip: i2s: remove unused
 variables"" to the asoc tree
In-Reply-To: <1462373686-21794-1-git-send-email-john@metanate.com>
Message-ID: <E1ayLdX-0004kH-IJ@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: Revert "ASoC: rockchip: i2s: remove unused variables"

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

>From a6e806c49e3265494ac6fe6ec88ed5c010652e0d Mon Sep 17 00:00:00 2001
From: John Keeping <john@metanate.com>
Date: Wed, 4 May 2016 17:21:56 +0100
Subject: [PATCH] ASoC: rockchip: Revert "ASoC: rockchip: i2s: remove unused
 variables"

This reverts commit 5938448b99275cba95167c3f9d39ca9225fdad38.

It turns out that the commit that made these variables unused is wrong
so we're about to revert it.  Bring back the variables in prepration.

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
2.8.1
