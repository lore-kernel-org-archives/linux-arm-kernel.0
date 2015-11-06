From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Fri,  6 Nov 2015 09:38:11 +0800
Subject: [PATCH v3 3/3] ASoC: rockchip: i2s: share tx/rx lrck when
 symmetric_rates enabled
In-Reply-To: <1446773891-32174-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1446773891-32174-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1446773891-32174-4-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we share lrck_tx to lrck_rx only if when both i2s symmetric_rates and
dai_link symmetric_rates enabled.

if only lrck_tx is wired into external codec, we should enable this to
provider lrck for rx logic inside i2s module.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

Changes in v3:
- modify the judgment condition

Changes in v2:
- new patch

 sound/soc/rockchip/rockchip_i2s.c | 8 ++++++++
 sound/soc/rockchip/rockchip_i2s.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index f07833b..5190199 100644
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
+	if (dai->driver->symmetric_rates && rtd->dai_link->symmetric_rates)
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
