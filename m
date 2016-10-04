From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  4 Oct 2016 09:51:12 +0800
Subject: [PATCH 3/3] pinctrl: sunxi: Make sunxi_pconf_group_set use
 sunxi_pconf_reg helper
In-Reply-To: <20161004015112.20833-1-wens@csie.org>
References: <20161004015112.20833-1-wens@csie.org>
Message-ID: <20161004015112.20833-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi_pconf_reg helper introduced in the last patch gives us the
chance to rework sunxi_pconf_group_set to have it match the structure
of sunxi_pconf_(group_)get and make it easier to understand.

For each config to set, it:

    1. checks if the parameter is supported.
    2. checks if the argument is within limits.
    3. converts argument to the register value.
    4. writes to the register with spinlock held.

As a result the function now blocks unsupported config parameters,
instead of silently ignoring them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 65 +++++++++++++++++++----------------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h |  1 -
 2 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 236272a2339d..1f02c4cd55c7 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -364,23 +364,27 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	struct sunxi_pinctrl_group *g = &pctl->groups[group];
-	unsigned long flags;
 	unsigned pin = g->pin - pctl->desc->pin_base;
-	u32 val, mask;
-	u16 strength;
-	u8 dlevel;
 	int i;
 
-	spin_lock_irqsave(&pctl->lock, flags);
-
 	for (i = 0; i < num_configs; i++) {
-		switch (pinconf_to_config_param(configs[i])) {
+		enum pin_config_param param;
+		unsigned long flags;
+		u32 offset, shift, mask, val;
+		u16 arg;
+		int ret;
+
+		param = pinconf_to_config_param(configs[i]);
+		arg = pinconf_to_config_argument(configs[i]);
+
+		ret = sunxi_pconf_reg(pin, param, &offset, &shift, &mask);
+		if (ret < 0)
+			return ret;
+
+		switch (param) {
 		case PIN_CONFIG_DRIVE_STRENGTH:
-			strength = pinconf_to_config_argument(configs[i]);
-			if (strength > 40) {
-				spin_unlock_irqrestore(&pctl->lock, flags);
+			if (arg < 10 || arg > 40)
 				return -EINVAL;
-			}
 			/*
 			 * We convert from mA to what the register expects:
 			 *   0: 10mA
@@ -388,33 +392,34 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
 			 *   2: 30mA
 			 *   3: 40mA
 			 */
-			dlevel = strength / 10 - 1;
-			val = readl(pctl->membase + sunxi_dlevel_reg(pin));
-			mask = DLEVEL_PINS_MASK << sunxi_dlevel_offset(pin);
-			writel((val & ~mask)
-				| dlevel << sunxi_dlevel_offset(pin),
-				pctl->membase + sunxi_dlevel_reg(pin));
+			arg = arg / 10 - 1;
 			break;
 		case PIN_CONFIG_BIAS_PULL_UP:
-			val = readl(pctl->membase + sunxi_pull_reg(pin));
-			mask = PULL_PINS_MASK << sunxi_pull_offset(pin);
-			writel((val & ~mask) | 1 << sunxi_pull_offset(pin),
-				pctl->membase + sunxi_pull_reg(pin));
+			if (arg == 0)
+				return -EINVAL;
+			arg = 1;
 			break;
 		case PIN_CONFIG_BIAS_PULL_DOWN:
-			val = readl(pctl->membase + sunxi_pull_reg(pin));
-			mask = PULL_PINS_MASK << sunxi_pull_offset(pin);
-			writel((val & ~mask) | 2 << sunxi_pull_offset(pin),
-				pctl->membase + sunxi_pull_reg(pin));
+			if (arg == 0)
+				return -EINVAL;
+			arg = 2;
 			break;
-		default:
+		case PIN_CONFIG_BIAS_DISABLE:
+			arg = 0;
 			break;
+
+		default:
+			/* sunxi_pconf_reg should catch anything unsupported */
+			WARN_ON(1);
+			return -ENOTSUPP;
 		}
-		/* cache the config value */
-		g->config = configs[i];
-	} /* for each config */
 
-	spin_unlock_irqrestore(&pctl->lock, flags);
+		spin_lock_irqsave(&pctl->lock, flags);
+		val = readl(pctl->membase + offset);
+		val &= ~(mask << shift);
+		writel(val | arg << shift, pctl->membase + offset);
+		spin_unlock_irqrestore(&pctl->lock, flags);
+	} /* for each config */
 
 	return 0;
 }
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 0afce1ab12d0..a7efb31d6523 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -109,7 +109,6 @@ struct sunxi_pinctrl_function {
 
 struct sunxi_pinctrl_group {
 	const char	*name;
-	unsigned long	config;
 	unsigned	pin;
 };
 
-- 
2.9.3
