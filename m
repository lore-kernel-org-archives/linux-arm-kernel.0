From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 May 2016 17:25:59 +0100
Subject: Applied "ASoC: rockchip: i2s: rename I2S_CKR_TRCM_TX/RXSHARE to
 I2S_CKR_TRCM_TX/RXONLY" to the asoc tree
In-Reply-To: <1464061667-16477-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <E1b5F9b-0003ax-0p@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: i2s: rename I2S_CKR_TRCM_TX/RXSHARE to I2S_CKR_TRCM_TX/RXONLY

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

>From 7ec4a1c34a190297540626dfa240dc033beca196 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Tue, 24 May 2016 11:47:46 +0800
Subject: [PATCH] ASoC: rockchip: i2s: rename I2S_CKR_TRCM_TX/RXSHARE to
 I2S_CKR_TRCM_TX/RXONLY

this patch make it more reasonable and readable, because when we chose
I2S_CKR_TRCM_TXONLY, we only output clk_lrck_tx, and hardware need to
confirm this signal is wired to external codec lrck_tx/rx at the same time.

for convenience, we just handle lrck_txonly if we enable symmetric_rates
in driver and dai_link. otherwise, we use the separate lrck_tx/rx.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 4 ++--
 sound/soc/rockchip/rockchip_i2s.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index d4f7eac5cfd4..ca1cf3b085a4 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -316,8 +316,8 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 			   I2S_DMACR_RDL(16));
 
 	val = I2S_CKR_TRCM_TXRX;
-	if (dai->driver->symmetric_rates || rtd->dai_link->symmetric_rates)
-		val = I2S_CKR_TRCM_TXSHARE;
+	if (dai->driver->symmetric_rates && rtd->dai_link->symmetric_rates)
+		val = I2S_CKR_TRCM_TXONLY;
 
 	regmap_update_bits(i2s->regmap, I2S_CKR,
 			   I2S_CKR_TRCM_MASK,
diff --git a/sound/soc/rockchip/rockchip_i2s.h b/sound/soc/rockchip/rockchip_i2s.h
index 8e239d301bc7..31f11fd25393 100644
--- a/sound/soc/rockchip/rockchip_i2s.h
+++ b/sound/soc/rockchip/rockchip_i2s.h
@@ -81,8 +81,8 @@
 #define I2S_CKR_TRCM_SHIFT	28
 #define I2S_CKR_TRCM(x)	(x << I2S_CKR_TRCM_SHIFT)
 #define I2S_CKR_TRCM_TXRX	(0 << I2S_CKR_TRCM_SHIFT)
-#define I2S_CKR_TRCM_TXSHARE	(1 << I2S_CKR_TRCM_SHIFT)
-#define I2S_CKR_TRCM_RXSHARE	(2 << I2S_CKR_TRCM_SHIFT)
+#define I2S_CKR_TRCM_TXONLY	(1 << I2S_CKR_TRCM_SHIFT)
+#define I2S_CKR_TRCM_RXONLY	(2 << I2S_CKR_TRCM_SHIFT)
 #define I2S_CKR_TRCM_MASK	(3 << I2S_CKR_TRCM_SHIFT)
 #define I2S_CKR_MSS_SHIFT	27
 #define I2S_CKR_MSS_MASTER	(0 << I2S_CKR_MSS_SHIFT)
-- 
2.8.1
