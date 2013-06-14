From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 14 Jun 2013 17:44:20 +0200
Subject: [PATCH 5/5] pinctrl: rockchip: correctly handle arguments of pinconf
 options
In-Reply-To: <201306141741.46077.heiko@sntech.de>
References: <201306141741.46077.heiko@sntech.de>
Message-ID: <201306141744.21117.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the rockchip pinctrl driver to handle the arguments of 0 or 1 to
the pull pinconfig options correctly, so that the pull gets disabled when
either the bias_disable options is set or the pull option has the argument 0.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c |   37 +++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index c605b63..2568afc 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -563,6 +563,25 @@ static const struct pinmux_ops rockchip_pmx_ops = {
  * Pinconf_ops handling
  */
 
+static bool rockchip_pinconf_pull_valid(struct rockchip_pin_ctrl *ctrl,
+					enum pin_config_param pull)
+{
+	/* rk3066b does support any pulls */
+	if (!ctrl->pull_offset)
+		return pull ? false : true;
+
+	if (ctrl->pull_auto) {
+		if (pull != PIN_CONFIG_BIAS_PULL_PIN_DEFAULT &&
+					pull != PIN_CONFIG_BIAS_DISABLE)
+			return false;
+	} else {
+		if (pull == PIN_CONFIG_BIAS_PULL_PIN_DEFAULT)
+			return false;
+	}
+
+	return true;
+}
+
 /* set the pin config settings for a specified pin */
 static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 							unsigned long config)
@@ -570,12 +589,21 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	struct rockchip_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
 	struct rockchip_pin_bank *bank = pin_to_bank(info, pin);
 	enum pin_config_param param = pinconf_to_config_param(config);
+	u16 arg = pinconf_to_config_argument(config);
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
+		return rockchip_set_pull(bank, pin - bank->pin_base, param);
+		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
 	case PIN_CONFIG_BIAS_PULL_DOWN:
 	case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
+		if (!rockchip_pinconf_pull_valid(info->ctrl, param))
+			return -ENOTSUPP;
+
+		if (!arg)
+			param = PIN_CONFIG_BIAS_DISABLE;
+
 		return rockchip_set_pull(bank, pin - bank->pin_base, param);
 		break;
 	default:
@@ -600,12 +628,11 @@ static int rockchip_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 	case PIN_CONFIG_BIAS_PULL_UP:
 	case PIN_CONFIG_BIAS_PULL_DOWN:
 	case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
-		pull = rockchip_get_pull(bank, pin - bank->pin_base);
-
-		if (pull != param)
-			return -EINVAL;
+		if (!rockchip_pinconf_pull_valid(info->ctrl, param))
+			return -ENOTSUPP;
 
-		*config = 0;
+		pull = rockchip_get_pull(bank, pin - bank->pin_base);
+		*config = (pull == param) ? 1 : 0;
 		break;
 	default:
 		return -ENOTSUPP;
-- 
1.7.10.4
