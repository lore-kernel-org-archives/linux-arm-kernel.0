From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Fri,  9 Jun 2017 16:52:46 +0800
Subject: [PATCH v1 1/4] ASoC: rockchip: i2s: add a delay before i2s clear
In-Reply-To: <1496998369-30556-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1496998369-30556-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1496998369-30556-2-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in order to guarantee i2s lrck signal integrity, when i2s stop,
need at least one lrck cycle to ensure signal integrity.

the max delay time is when lrck is 8khz, the delay time is
125us(1/8khz), using udelay(150) with a 25us margin.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_i2s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 974915c..f548433 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -116,6 +116,7 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 					   I2S_XFER_TXS_STOP |
 					   I2S_XFER_RXS_STOP);
 
+			udelay(150);
 			regmap_update_bits(i2s->regmap, I2S_CLR,
 					   I2S_CLR_TXC | I2S_CLR_RXC,
 					   I2S_CLR_TXC | I2S_CLR_RXC);
@@ -162,6 +163,7 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 					   I2S_XFER_TXS_STOP |
 					   I2S_XFER_RXS_STOP);
 
+			udelay(150);
 			regmap_update_bits(i2s->regmap, I2S_CLR,
 					   I2S_CLR_TXC | I2S_CLR_RXC,
 					   I2S_CLR_TXC | I2S_CLR_RXC);
-- 
1.9.1
