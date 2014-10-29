From: jay.xu@rock-chips.com (Jianqun)
Date: Wed, 29 Oct 2014 17:45:51 +0800
Subject: [PATCH] ASoC: rockchip-i2s: fix infinite loop in rockchip_snd_rxctrl
Message-ID: <1414575951-18015-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can get into an infinite loop if the I2S_CLR register fails to
clear due to a missing break statement, so add that.

Signed-off-by: Jianqun <jay.xu@rock-chips.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index f373e37..c74ba37 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -154,8 +154,10 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 			while (val) {
 				regmap_read(i2s->regmap, I2S_CLR, &val);
 				retry--;
-				if (!retry)
+				if (!retry) {
 					dev_warn(i2s->dev, "fail to clear\n");
+					break;
+				}
 			}
 		}
 	}
-- 
1.9.1
