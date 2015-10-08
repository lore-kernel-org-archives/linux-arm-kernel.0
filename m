From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Thu,  8 Oct 2015 20:40:09 +0800
Subject: [PATCH v2 3/3] ASoC: rockchip: i2s: share tx/rx lrck when
 symmetric_rates enabled
In-Reply-To: <1444308009-29088-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1444308009-29088-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1444308009-29088-4-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

share lrck_tx to lrck_rx when symmetric_rates enabled.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

Changes in v2: 
- new patch

 sound/soc/rockchip/rockchip_i2s.c | 8 ++++++++
 sound/soc/rockchip/rockchip_i2s.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index f07833b..58ee645 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -226,6 +226,7 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct rk_i2s_dev *i2s = to_info(dai);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	unsigned int val = 0;
 
 	switch (params_format(params)) {
@@ -278,6 +279,13 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_RDL_MASK,
 			   I2S_DMACR_RDL(16));
 
+	val = I2S_CKR_TRCM_TXRX;
+	if (dai->driver->symmetric_rates || rtd->dai_link->symmetric_rates)
+		val = I2S_CKR_TRCM_TXSHARE;
+
+	regmap_update_bits(i2s->regmap, I2S_CKR,
+			   I2S_CKR_TRCM_MASK,
+			   val);
 	return 0;
 }
 
diff --git a/sound/soc/rockchip/rockchip_i2s.h b/sound/soc/rockchip/rockchip_i2s.h
index a54ee35..dc6e2c7 100644
--- a/sound/soc/rockchip/rockchip_i2s.h
+++ b/sound/soc/rockchip/rockchip_i2s.h
@@ -78,6 +78,12 @@
  * CKR
  * clock generation register
 */
+#define I2S_CKR_TRCM_SHIFT	28
+#define I2S_CKR_TRCM(x)	(x << I2S_CKR_TRCM_SHIFT)
+#define I2S_CKR_TRCM_TXRX	(0 << I2S_CKR_TRCM_SHIFT)
+#define I2S_CKR_TRCM_TXSHARE	(1 << I2S_CKR_TRCM_SHIFT)
+#define I2S_CKR_TRCM_RXSHARE	(2 << I2S_CKR_TRCM_SHIFT)
+#define I2S_CKR_TRCM_MASK	(3 << I2S_CKR_TRCM_SHIFT)
 #define I2S_CKR_MSS_SHIFT	27
 #define I2S_CKR_MSS_MASTER	(0 << I2S_CKR_MSS_SHIFT)
 #define I2S_CKR_MSS_SLAVE	(1 << I2S_CKR_MSS_SHIFT)
-- 
2.3.6
