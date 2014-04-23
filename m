From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 23 Apr 2014 14:28:59 +0200
Subject: [PATCH 2/2] pinctrl: rockchip: implement PIN_CONFIG_OUTPUT handling
In-Reply-To: <7604038.VoEVFUfvet@phil>
References: <7604038.VoEVFUfvet@phil>
Message-ID: <1574132.ZxCpxPcbBr@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases it is nice to be able to simply control a gpio output
via the PIN_CONFIG_OUTPUT option without having a driver control it.
Thus add support for it to the rockchip pinctrl driver.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index ae3dfe7..2e198a4 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -329,6 +329,23 @@ static const struct pinctrl_ops rockchip_pctrl_ops = {
  * Hardware access
  */
 
+static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+	void __iomem *reg = info->reg_base + info->ctrl->mux_offset;
+	u8 bit;
+
+	if (bank->bank_type == RK3188_BANK0 && pin < 16)
+		return RK_FUNC_GPIO;
+
+	/* get basic quadrupel of mux registers and the correct reg inside */
+	reg += bank->bank_num * 0x10;
+	reg += (pin / 8) * 4;
+	bit = (pin % 8) * 2;
+
+	return ((readl(reg) >> bit) & 3);
+}
+
 /*
  * Set a new mux function for a pin.
  *
@@ -687,6 +704,10 @@ static bool rockchip_pinconf_pull_valid(struct rockchip_pin_ctrl *ctrl,
 	return false;
 }
 
+static int rockchip_gpio_direction_output(struct gpio_chip *gc,
+					  unsigned offset, int value);
+static int rockchip_gpio_get(struct gpio_chip *gc, unsigned offset);
+
 /* set the pin config settings for a specified pin */
 static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 				unsigned long *configs, unsigned num_configs)
@@ -724,6 +745,13 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			if (rc)
 				return rc;
 			break;
+		case PIN_CONFIG_OUTPUT:
+			rc = rockchip_gpio_direction_output(&bank->gpio_chip,
+							    pin - bank->pin_base,
+							    arg);
+			if (rc)
+				return rc;
+			break;
 		default:
 			return -ENOTSUPP;
 			break;
@@ -741,6 +769,7 @@ static int rockchip_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 	struct rockchip_pin_bank *bank = pin_to_bank(info, pin);
 	enum pin_config_param param = pinconf_to_config_param(*config);
 	u16 arg;
+	int rc;
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
@@ -761,6 +790,17 @@ static int rockchip_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		arg = 1;
 		break;
+	case PIN_CONFIG_OUTPUT:
+		rc = rockchip_get_mux(bank, pin - bank->pin_base);
+		if (rc != RK_FUNC_GPIO)
+			return -EINVAL;
+
+		rc = rockchip_gpio_get(&bank->gpio_chip, pin - bank->pin_base);
+		if (rc < 0)
+			return rc;
+
+		arg = rc ? 1 : 0;
+		break;
 	default:
 		return -ENOTSUPP;
 		break;
-- 
1.9.0
