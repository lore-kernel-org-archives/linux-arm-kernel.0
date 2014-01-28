From: chao.xie@marvell.com (Chao Xie)
Date: Tue, 28 Jan 2014 15:20:44 +0800
Subject: [PATCH] pinctrl: single: add low powr mode support
Message-ID: <1390893644-3458-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

For some silicons, the pin configuration register can control
the output of the pin when the pad including the pin enter
low power mode.
For example, the pin can be "Drive 1", "Drive 0", "Float" when
the pad including the pin enter low power mode.
It is very useful when you want to control the power leakeage
when the SOC enter low power mode, and can save more power for
the low power mode.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt | 7 +++++++
 drivers/pinctrl/pinctrl-single.c                             | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
index bc0dfdf..66dcaa9 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
@@ -63,6 +63,13 @@ Optional properties:
 		/* input, enable bits, disable bits, mask */
 		pinctrl-single,input-schmitt-enable = <0x30 0x40 0 0x70>;
 
+- pinctrl-single,low-power-mode : array of value that are used to configure
+  low power mode of this pin. For some silicons, the low power mode will
+  control the output of the pin when the pad including the pin enter low
+  power mode.
+		/* low power mode value, mask */
+		pinctrl-single,low-power-mode = <0x288 0x388>;
+
 - pinctrl-single,gpio-range : list of value that are used to configure a GPIO
   range. They're value of subnode phandle, pin base in pinctrl device, pin
   number in this range, GPIO function value of this GPIO range.
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 41f1cfe..18ed6b6 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -661,6 +661,7 @@ static int pcs_pinconf_get(struct pinctrl_dev *pctldev,
 			break;
 		case PIN_CONFIG_DRIVE_STRENGTH:
 		case PIN_CONFIG_SLEW_RATE:
+		case PIN_CONFIG_LOW_POWER_MODE:
 		default:
 			*config = data;
 			break;
@@ -698,6 +699,7 @@ static int pcs_pinconf_set(struct pinctrl_dev *pctldev,
 			case PIN_CONFIG_INPUT_SCHMITT:
 			case PIN_CONFIG_DRIVE_STRENGTH:
 			case PIN_CONFIG_SLEW_RATE:
+			case PIN_CONFIG_LOW_POWER_MODE:
 				shift = ffs(func->conf[i].mask) - 1;
 				data &= ~func->conf[i].mask;
 				data |= (arg << shift) & func->conf[i].mask;
@@ -1100,6 +1102,7 @@ static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
 		{ "pinctrl-single,drive-strength", PIN_CONFIG_DRIVE_STRENGTH, },
 		{ "pinctrl-single,slew-rate", PIN_CONFIG_SLEW_RATE, },
 		{ "pinctrl-single,input-schmitt", PIN_CONFIG_INPUT_SCHMITT, },
+		{ "pinctrl-single,low-power-mode", PIN_CONFIG_LOW_POWER_MODE, },
 	};
 	struct pcs_conf_type prop4[] = {
 		{ "pinctrl-single,bias-pullup", PIN_CONFIG_BIAS_PULL_UP, },
-- 
1.8.3.2
