From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 05 May 2014 13:59:09 +0200
Subject: [PATCH v2 4/8] pinctrl: rockchip: let pmu registers be supplied by a
 syscon
In-Reply-To: <11862890.WUjscWaP3U@diego>
References: <11862890.WUjscWaP3U@diego>
Message-ID: <4931573.BTfMJeskVK@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the pmu registers containing pin pull settings on the rk3188 are mapped
locally when bank0 is instantiated. Add an alternative that can resolve the pmu
from a syscon phandle.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Max Schwarz <max.schwarz@online.de>
---
 drivers/pinctrl/pinctrl-rockchip.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index b67771d..11ad643 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -38,6 +38,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 
 #include "core.h"
@@ -164,6 +165,7 @@ struct rockchip_pinctrl {
 	struct regmap			*regmap_base;
 	int				reg_size;
 	struct regmap			*regmap_pull;
+	struct regmap			*regmap_pmu;
 	struct device			*dev;
 	struct rockchip_pin_ctrl	*ctrl;
 	struct pinctrl_desc		pctl;
@@ -438,6 +440,7 @@ static void rk2928_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 #define RK3188_PULL_BITS_PER_PIN	2
 #define RK3188_PULL_PINS_PER_REG	8
 #define RK3188_PULL_BANK_STRIDE		16
+#define RK3188_PULL_PMU_OFFSET		0x64
 
 static void rk3188_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 				    int pin_num, struct regmap **regmap,
@@ -447,8 +450,9 @@ static void rk3188_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 
 	/* The first 12 pins of the first bank are located elsewhere */
 	if (bank->bank_type == RK3188_BANK0 && pin_num < 12) {
-		*regmap = bank->regmap_pull;
-		*reg = 0;
+		*regmap = info->regmap_pmu ? info->regmap_pmu
+					   : bank->regmap_pull;
+		*reg = info->regmap_pmu ? RK3188_PULL_PMU_OFFSET : 0;
 		*reg += ((pin_num / RK3188_PULL_PINS_PER_REG) * 4);
 		*bit = pin_num % RK3188_PULL_PINS_PER_REG;
 		*bit *= RK3188_PULL_BITS_PER_PIN;
@@ -1539,6 +1543,7 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	struct rockchip_pinctrl *info;
 	struct device *dev = &pdev->dev;
 	struct rockchip_pin_ctrl *ctrl;
+	struct device_node *np = pdev->dev.of_node, *node;
 	struct resource *res;
 	void __iomem *base;
 	int ret;
@@ -1587,6 +1592,14 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 						  &rockchip_regmap_config);
 	}
 
+	/* try to find the optional reference to the pmu syscon */
+	node = of_parse_phandle(np, "rockchip,pmu", 0);
+	if (node) {
+		info->regmap_pmu = syscon_node_to_regmap(node);
+		if (IS_ERR(info->regmap_pmu))
+			return PTR_ERR(info->regmap_pmu);
+	}
+
 	ret = rockchip_gpiolib_register(pdev, info);
 	if (ret)
 		return ret;
-- 
1.9.0
