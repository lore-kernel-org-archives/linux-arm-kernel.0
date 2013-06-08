From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  8 Jun 2013 12:05:43 +0200
Subject: [PATCH 1/4] pinctrl: sunxi: Search the description array by pin id
In-Reply-To: <1370685946-3718-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1370685946-3718-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1370685946-3718-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to use expensive string manipulation functions and search by pin
id when possible.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.c | 50 ++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index c52fc2c..0e7961c 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -1399,6 +1399,31 @@ sunxi_pinctrl_desc_find_function_by_name(struct sunxi_pinctrl *pctl,
 	return NULL;
 }
 
+static struct sunxi_desc_function *
+sunxi_pinctrl_desc_find_function_by_pin(struct sunxi_pinctrl *pctl,
+					const u16 pin_num,
+					const char *func_name)
+{
+	int i;
+
+	for (i = 0; i < pctl->desc->npins; i++) {
+		const struct sunxi_desc_pin *pin = pctl->desc->pins + i;
+
+		if (pin->pin.number == pin_num) {
+			struct sunxi_desc_function *func = pin->functions;
+
+			while (func->name) {
+				if (!strcmp(func->name, func_name))
+					return func;
+
+				func++;
+			}
+		}
+	}
+
+	return NULL;
+}
+
 static int sunxi_pctrl_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
@@ -1680,37 +1705,20 @@ sunxi_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	struct sunxi_desc_function *desc;
-	char pin_name[SUNXI_PIN_NAME_MAX_LEN];
 	const char *func;
-	u8 bank, pin;
-	int ret;
-
-	bank = (offset) / PINS_PER_BANK;
-	pin = (offset) % PINS_PER_BANK;
-
-	ret = sprintf(pin_name, "P%c%d", 'A' + bank, pin);
-	if (!ret)
-		goto error;
 
 	if (input)
 		func = "gpio_in";
 	else
 		func = "gpio_out";
 
-	desc = sunxi_pinctrl_desc_find_function_by_name(pctl,
-							pin_name,
-							func);
-	if (!desc) {
-		ret = -EINVAL;
-		goto error;
-	}
+	desc = sunxi_pinctrl_desc_find_function_by_pin(pctl, offset, func);
+	if (!desc)
+		return -EINVAL;
 
 	sunxi_pmx_set(pctldev, offset, desc->muxval);
 
-	ret = 0;
-
-error:
-	return ret;
+	return 0;
 }
 
 static const struct pinmux_ops sunxi_pmx_ops = {
-- 
1.8.3
