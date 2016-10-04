From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  4 Oct 2016 09:51:11 +0800
Subject: [PATCH 2/3] pinctrl: sunxi: Fix PIN_CONFIG_BIAS_PULL_{DOWN,
 UP} argument
In-Reply-To: <20161004015112.20833-1-wens@csie.org>
References: <20161004015112.20833-1-wens@csie.org>
Message-ID: <20161004015112.20833-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to pinconf-generic.h, the argument for
PIN_CONFIG_BIAS_PULL_{DOWN,UP} is non-zero if the bias is enabled
with a pull up/down resistor, zero if it is directly connected
to VDD or ground.

Since Allwinner hardware uses a weak pull resistor internally,
the argument should be 1.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 609843c9a65c..236272a2339d 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -234,7 +234,7 @@ static int sunxi_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 				pull = PIN_CONFIG_BIAS_PULL_UP;
 			else if (val == 2)
 				pull = PIN_CONFIG_BIAS_PULL_DOWN;
-			pinconfig[j++] = pinconf_to_config_packed(pull, 0);
+			pinconfig[j++] = pinconf_to_config_packed(pull, 1);
 		}
 
 		(*map)[i].data.configs.configs = pinconfig;
-- 
2.9.3
