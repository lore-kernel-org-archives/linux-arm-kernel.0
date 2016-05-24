From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 24 May 2016 11:47:46 +0800
Subject: [PATCH] ASoC: rockchip: i2s: rename I2S_CKR_TRCM_TX/RXSHARE to
 I2S_CKR_TRCM_TX/RXONLY
Message-ID: <1464061667-16477-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sugar Zhang <sugar.zhang@rock-chips.com>

this patch make it more reasonable and readable, because when we chose
I2S_CKR_TRCM_TXONLY, we only output clk_lrck_tx, and hardware need to
confirm this signal is wired to external codec lrck_tx/rx at the same time.

for convenience, we just handle lrck_txonly if we enable symmetric_rates
in driver and dai_link. otherwise, we use the separate lrck_tx/rx.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 sound/soc/rockchip/rockchip_i2s.c |    4 ++--
 sound/soc/rockchip/rockchip_i2s.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 574c6af..92a405f 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -306,8 +306,8 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 			   I2S_DMACR_RDL(16));
 
 	val = I2S_CKR_TRCM_TXRX;
-	if (dai->driver->symmetric_rates || rtd->dai_link->symmetric_rates)
-		val = I2S_CKR_TRCM_TXSHARE;
+	if (dai->driver->symmetric_rates && rtd->dai_link->symmetric_rates)
+		val = I2S_CKR_TRCM_TXONLY;
 
 	regmap_update_bits(i2s->regmap, I2S_CKR,
 			   I2S_CKR_TRCM_MASK,
diff --git a/sound/soc/rockchip/rockchip_i2s.h b/sound/soc/rockchip/rockchip_i2s.h
index dc6e2c7..13b1d44 100644
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
1.7.9.5
