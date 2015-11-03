From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  3 Nov 2015 09:33:54 +0800
Subject: [PATCH v1 1/5] ASoC: rockchip: i2s: Support to set the divider clock
 API
In-Reply-To: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
References: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1446514438-13922-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support more sample rates, add the divider clock api.

As the input source clock to the module is MCLK_I2S,
and by the divider of the module, the clock generator generates
SCLK and LRCK to transmitter and receiver.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v1:
- change the subject and commit.
- remove the print message dev_dbg().

 sound/soc/rockchip/rockchip_i2s.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index b936102..23c867f 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -286,6 +286,32 @@ static int rockchip_i2s_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int rockchip_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai,
+				   int div_id, int div)
+{
+	struct rk_i2s_dev *i2s = to_info(cpu_dai);
+	unsigned int val = 0;
+
+	switch (div_id) {
+	case ROCKCHIP_DIV_BCLK:
+		val |= I2S_CKR_TSD(div);
+		val |= I2S_CKR_RSD(div);
+		regmap_update_bits(i2s->regmap, I2S_CKR,
+				   I2S_CKR_TSD_MASK | I2S_CKR_RSD_MASK,
+				   val);
+		break;
+	case ROCKCHIP_DIV_MCLK:
+		val |= I2S_CKR_MDIV(div);
+		regmap_update_bits(i2s->regmap, I2S_CKR,
+				   I2S_CKR_MDIV_MASK, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int rockchip_i2s_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
 				   unsigned int freq, int dir)
 {
@@ -311,6 +337,7 @@ static int rockchip_i2s_dai_probe(struct snd_soc_dai *dai)
 
 static const struct snd_soc_dai_ops rockchip_i2s_dai_ops = {
 	.hw_params = rockchip_i2s_hw_params,
+	.set_clkdiv = rockchip_i2s_set_clkdiv,
 	.set_sysclk = rockchip_i2s_set_sysclk,
 	.set_fmt = rockchip_i2s_set_fmt,
 	.trigger = rockchip_i2s_trigger,
-- 
1.9.1
