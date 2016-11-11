From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 11 Nov 2016 10:44:53 +0800
Subject: [PATCH v2 1/3] pinctrl: sunxi: Fix PIN_CONFIG_BIAS_PULL_{DOWN,
 UP} argument
In-Reply-To: <20161111024455.16883-1-wens@csie.org>
References: <20161111024455.16883-1-wens@csie.org>
Message-ID: <20161111024455.16883-2-wens@csie.org>
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
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index e199d95af8c0..e04edda8629d 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -291,12 +291,16 @@ static unsigned long *sunxi_pctrl_build_pin_config(struct device_node *node,
 
 	if (sunxi_pctrl_has_bias_prop(node)) {
 		int pull = sunxi_pctrl_parse_bias_prop(node);
+		int arg = 0;
 		if (pull < 0) {
 			ret = pull;
 			goto err_free;
 		}
 
-		pinconfig[idx++] = pinconf_to_config_packed(pull, 0);
+		if (pull != PIN_CONFIG_BIAS_DISABLE)
+			arg = 1; /* hardware uses weak pull resistors */
+
+		pinconfig[idx++] = pinconf_to_config_packed(pull, arg);
 	}
 
 
-- 
2.10.2
