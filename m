From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Tue, 23 Dec 2014 17:08:29 +0800
Subject: [PATCH 2/2] ASoC: rockchip: i2s: set TDL and RDL to 16 bits
In-Reply-To: <1419325709-15374-1-git-send-email-jay.xu@rock-chips.com>
References: <1419325709-15374-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1419325709-15374-3-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set Transmit Data Level(TDL) and Receive Data Level(RDL) to 16 bits.
Without this setting, the TDL is default to be 0x00 (means 1 bit),
and the RDL is default to be 0x1f (means 16 bits).

This patch is helpful to fix pop sound, tested on rk3288 board.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index c74ba37..1cd7efc 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -247,6 +247,10 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(i2s->regmap, I2S_TXCR, I2S_TXCR_VDW_MASK, val);
 	regmap_update_bits(i2s->regmap, I2S_RXCR, I2S_RXCR_VDW_MASK, val);
+	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_TDL_MASK,
+			   I2S_DMACR_TDL(16));
+	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_RDL_MASK,
+			   I2S_DMACR_RDL(16));
 
 	return 0;
 }
-- 
1.9.1
