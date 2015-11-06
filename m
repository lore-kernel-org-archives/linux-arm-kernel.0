From: wxt@rock-chips.com (Caesar Wang)
Date: Fri,  6 Nov 2015 19:38:14 +0800
Subject: [PATCH v2 1/3] ASoC: rockchip: i2s: change bclk and lrck according to
 sample rates
In-Reply-To: <1446809896-11254-1-git-send-email-wxt@rock-chips.com>
References: <1446809896-11254-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1446809896-11254-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets the dividers autonomously.

when i2s works on master mode, and sample rates changed. We need to change
bclk and lrck at the same time for cpu internal side.

As the input source clock to the module is MCLK_I2S,
and by the divider of the module, the clock generator generates
SCLK and LRCK to transmitter and receiver.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v2:
- move the set clock divider into rockchip i2s.

 sound/soc/rockchip/rockchip_i2s.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index b936102..b349935 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -41,6 +41,7 @@ struct rk_i2s_dev {
 */
 	bool tx_start;
 	bool rx_start;
+	bool is_master_mode;
 };
 
 static int i2s_runtime_suspend(struct device *dev)
@@ -174,9 +175,11 @@ static int rockchip_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 	case SND_SOC_DAIFMT_CBS_CFS:
 		/* Set source clock in Master mode */
 		val = I2S_CKR_MSS_MASTER;
+		i2s->is_master_mode = true;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		val = I2S_CKR_MSS_SLAVE;
+		i2s->is_master_mode = false;
 		break;
 	default:
 		return -EINVAL;
@@ -227,6 +230,26 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 {
 	struct rk_i2s_dev *i2s = to_info(dai);
 	unsigned int val = 0;
+	unsigned int mclk_rate, bclk_rate, div_bclk, div_lrck;
+
+	if (i2s->is_master_mode) {
+		mclk_rate = clk_get_rate(i2s->mclk);
+		bclk_rate = 2 * 32 * params_rate(params);
+		if (bclk_rate && mclk_rate % bclk_rate)
+			return -EINVAL;
+
+		div_bclk = mclk_rate / bclk_rate;
+		div_lrck = bclk_rate / params_rate(params);
+		regmap_update_bits(i2s->regmap, I2S_CKR,
+				   I2S_CKR_MDIV_MASK,
+				   I2S_CKR_MDIV(div_bclk));
+
+		regmap_update_bits(i2s->regmap, I2S_CKR,
+				   I2S_CKR_TSD_MASK |
+				   I2S_CKR_RSD_MASK,
+				   I2S_CKR_TSD(div_lrck) |
+				   I2S_CKR_RSD(div_lrck));
+	}
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
-- 
1.9.1
