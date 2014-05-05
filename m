From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 05 May 2014 13:58:46 +0200
Subject: [PATCH v2 3/8] pinctrl: rockchip: rockchip_pinctrl in
 rockchip_get_bank_data
In-Reply-To: <11862890.WUjscWaP3U@diego>
References: <11862890.WUjscWaP3U@diego>
Message-ID: <1862780.XdYo0OxnPz@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert rockchip_get_bank_data to use the struct rockchip_pinctrl because
later on we need to check a value from it when registering the gpio banks.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Max Schwarz <max.schwarz@online.de>
---
 drivers/pinctrl/pinctrl-rockchip.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 71d9c99..b67771d 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1440,17 +1440,17 @@ static int rockchip_gpiolib_unregister(struct platform_device *pdev,
 }
 
 static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
-				  struct device *dev)
+				  struct rockchip_pinctrl *info)
 {
 	struct resource res;
 	void __iomem *base;
 
 	if (of_address_to_resource(bank->of_node, 0, &res)) {
-		dev_err(dev, "cannot find IO resource for bank\n");
+		dev_err(info->dev, "cannot find IO resource for bank\n");
 		return -ENOENT;
 	}
 
-	bank->reg_base = devm_ioremap_resource(dev, &res);
+	bank->reg_base = devm_ioremap_resource(info->dev, &res);
 	if (IS_ERR(bank->reg_base))
 		return PTR_ERR(bank->reg_base);
 
@@ -1464,16 +1464,16 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
 		bank->bank_type = RK3188_BANK0;
 
 		if (of_address_to_resource(bank->of_node, 1, &res)) {
-			dev_err(dev, "cannot find IO resource for bank\n");
+			dev_err(info->dev, "cannot find IO resource for bank\n");
 			return -ENOENT;
 		}
 
-		base = devm_ioremap_resource(dev, &res);
+		base = devm_ioremap_resource(info->dev, &res);
 		if (IS_ERR(base))
 			return PTR_ERR(base);
 		rockchip_regmap_config.max_register = resource_size(&res) - 4;
 		rockchip_regmap_config.name = "rockchip,rk3188-gpio-bank0-pull";
-		bank->regmap_pull = devm_regmap_init_mmio(dev, base,
+		bank->regmap_pull = devm_regmap_init_mmio(info->dev, base,
 						  &rockchip_regmap_config);
 
 	} else {
@@ -1515,7 +1515,7 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
 			if (!strcmp(bank->name, np->name)) {
 				bank->of_node = np;
 
-				if (!rockchip_get_bank_data(bank, &pdev->dev))
+				if (!rockchip_get_bank_data(bank, d))
 					bank->valid = true;
 
 				break;
@@ -1552,13 +1552,14 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
+	info->dev = dev;
+
 	ctrl = rockchip_pinctrl_get_soc_data(info, pdev);
 	if (!ctrl) {
 		dev_err(dev, "driver data not available\n");
 		return -EINVAL;
 	}
 	info->ctrl = ctrl;
-	info->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
-- 
1.9.0
