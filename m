From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 16 Oct 2013 01:07:49 +0200
Subject: [PATCH v2 2/5] pinctrl: rockchip: add support for multiple bank types
In-Reply-To: <201310160106.42329.heiko@sntech.de>
References: <201310160106.42329.heiko@sntech.de>
Message-ID: <201310160107.50032.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are Rockchip SoCs, namely the rk3188, that combine a set of
regular banks with banks that need special handling for some settings.

Therefore add the possibility for the driver to handle more than one
bank type.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index df155f9..efca116 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -62,6 +62,10 @@ enum rockchip_pinctrl_type {
 	RK3188,
 };
 
+enum rockchip_pin_bank_type {
+	COMMON_BANK,
+};
+
 /**
  * @reg_base: register base of the gpio bank
  * @clk: clock of the gpio bank
@@ -86,6 +90,7 @@ struct rockchip_pin_bank {
 	u8				nr_pins;
 	char				*name;
 	u8				bank_num;
+	enum rockchip_pin_bank_type	bank_type;
 	bool				valid;
 	struct device_node		*of_node;
 	struct rockchip_pinctrl		*drvdata;
@@ -668,7 +673,10 @@ static const struct pinconf_ops rockchip_pinconf_ops = {
 	.pin_config_set			= rockchip_pinconf_set,
 };
 
-static const char *gpio_compat = "rockchip,gpio-bank";
+static const struct of_device_id rockchip_bank_match[] = {
+	{ .compatible = "rockchip,gpio-bank" },
+	{},
+};
 
 static void rockchip_pinctrl_child_count(struct rockchip_pinctrl *info,
 						struct device_node *np)
@@ -676,7 +684,7 @@ static void rockchip_pinctrl_child_count(struct rockchip_pinctrl *info,
 	struct device_node *child;
 
 	for_each_child_of_node(np, child) {
-		if (of_device_is_compatible(child, gpio_compat))
+		if (of_match_node(rockchip_bank_match, child))
 			continue;
 
 		info->nfunctions++;
@@ -819,8 +827,9 @@ static int rockchip_pinctrl_parse_dt(struct platform_device *pdev,
 	i = 0;
 
 	for_each_child_of_node(np, child) {
-		if (of_device_is_compatible(child, gpio_compat))
+		if (of_match_node(rockchip_bank_match, child))
 			continue;
+
 		ret = rockchip_pinctrl_parse_functions(child, info, i++);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to parse function\n");
@@ -1217,6 +1226,8 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
 	if (IS_ERR(bank->reg_base))
 		return PTR_ERR(bank->reg_base);
 
+	bank->bank_type = COMMON_BANK;
+
 	bank->irq = irq_of_parse_and_map(bank->of_node, 0);
 
 	bank->clk = of_clk_get(bank->of_node, 0);
-- 
1.7.10.4
