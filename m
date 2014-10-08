From: sonnyrao@chromium.org (Sonny Rao)
Date: Wed,  8 Oct 2014 00:58:51 -0700
Subject: [PATCH] ASoC: rockchip-i2s: fix infinite loop in rockchip_snd_txctrl
Message-ID: <1412755131-27542-1-git-send-email-sonnyrao@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can get into an infinite loop if the I2S_CLR register fails to
clear due to a missing break statement, so add that.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 033487c..f373e37 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -108,8 +108,10 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
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
1.8.3.2
