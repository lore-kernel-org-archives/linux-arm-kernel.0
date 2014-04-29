From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 30 Apr 2014 00:10 +0200
Subject: [PATCH 6/8] pinctrl: rockchip: base regmap supplied by a syscon
In-Reply-To: <1414506.B4e2jZujVm@diego>
References: <1414506.B4e2jZujVm@diego>
Message-ID: <13326411.cf8qxmfeZW@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows the basic registers of the general register files to be supplied
by a syscon instead of being mapped locally.

The GRF registers contain a lot more than pinctrl functions like dma, usb-phy
and general soc control and status registers, intermixed with the iomux, pull
and drive-strength registers.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c | 47 +++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index d6e2401..bb805d5 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1574,30 +1574,39 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	}
 	info->ctrl = ctrl;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	rockchip_regmap_config.max_register = resource_size(res) - 4;
-	rockchip_regmap_config.name = "rockchip,pinctrl";
-	info->regmap_base = devm_regmap_init_mmio(&pdev->dev, base,
-						  &rockchip_regmap_config);
-
-	/* to check for the old dt-bindings */
-	info->reg_size = resource_size(res);
-
-	/* Honor the old binding, with pull registers as 2nd resource */
-	if (ctrl->type == RK3188 && info->reg_size < 0x200) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	node = of_parse_phandle(np, "rockchip,grf", 0);
+	if (node) {
+		info->regmap_base = syscon_node_to_regmap(node);
+		if (IS_ERR(info->regmap_base))
+			return PTR_ERR(info->regmap_base);
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		base = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(base))
 			return PTR_ERR(base);
 
 		rockchip_regmap_config.max_register = resource_size(res) - 4;
-		rockchip_regmap_config.name = "rockchip,pinctrl-pull";
-		info->regmap_pull = devm_regmap_init_mmio(&pdev->dev, base,
-						  &rockchip_regmap_config);
+		rockchip_regmap_config.name = "rockchip,pinctrl";
+		info->regmap_base = devm_regmap_init_mmio(&pdev->dev, base,
+						    &rockchip_regmap_config);
+
+		/* to check for the old dt-bindings */
+		info->reg_size = resource_size(res);
+
+		/* Honor the old binding, with pull registers as 2nd resource */
+		if (ctrl->type == RK3188 && info->reg_size < 0x200) {
+			res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+			base = devm_ioremap_resource(&pdev->dev, res);
+			if (IS_ERR(base))
+				return PTR_ERR(base);
+
+			rockchip_regmap_config.max_register =
+							resource_size(res) - 4;
+			rockchip_regmap_config.name = "rockchip,pinctrl-pull";
+			info->regmap_pull = devm_regmap_init_mmio(&pdev->dev,
+						    base,
+						    &rockchip_regmap_config);
+		}
 	}
 
 	/* try to find the optional reference to the pmu syscon */
-- 
1.9.0
