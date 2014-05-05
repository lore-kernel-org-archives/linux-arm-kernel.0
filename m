From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 05 May 2014 13:58 +0200
Subject: [PATCH v2 1/8] pinctrl: rockchip: do not require 2nd register area
In-Reply-To: <11862890.WUjscWaP3U@diego>
References: <11862890.WUjscWaP3U@diego>
Message-ID: <2232662.BNuMPTx7jK@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Deprecate secondary register area for rk3188 pulls. Instead use big enough
initial mapping of grf registers to catch all.

The now deprecated register is still supported though.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Max Schwarz <max.schwarz@online.de>
---
 .../devicetree/bindings/pinctrl/rockchip,pinctrl.txt      |  2 ++
 drivers/pinctrl/pinctrl-rockchip.c                        | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
index f378d34..78dafc9 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
@@ -22,6 +22,8 @@ Required properties for iomux controller:
   - compatible: one of "rockchip,rk2928-pinctrl", "rockchip,rk3066a-pinctrl"
 		       "rockchip,rk3066b-pinctrl", "rockchip,rk3188-pinctrl"
   - reg: first element is the general register space of the iomux controller
+	 It should be large enough to contain also separate pull registers.
+	 Deprecated:
 	 second element is the separate pull register space of the rk3188
 
 Required properties for gpio sub nodes:
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 2e198a4..ab71de8 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -160,6 +160,7 @@ struct rockchip_pmx_func {
 
 struct rockchip_pinctrl {
 	void __iomem			*reg_base;
+	int				reg_size;
 	void __iomem			*reg_pull;
 	struct device			*dev;
 	struct rockchip_pin_ctrl	*ctrl;
@@ -416,6 +417,7 @@ static void rk2928_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 	*bit = pin_num % RK2928_PULL_PINS_PER_REG;
 };
 
+#define RK3188_PULL_OFFSET		0x164
 #define RK3188_PULL_BITS_PER_PIN	2
 #define RK3188_PULL_PINS_PER_REG	8
 #define RK3188_PULL_BANK_STRIDE		16
@@ -432,7 +434,10 @@ static void rk3188_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 		*bit = pin_num % RK3188_PULL_PINS_PER_REG;
 		*bit *= RK3188_PULL_BITS_PER_PIN;
 	} else {
-		*reg = info->reg_pull - 4;
+		*reg = info->reg_pull ? info->reg_pull
+				      : info->reg_base + RK3188_PULL_OFFSET;
+		/* correct the offset, as it is the 2nd pull register */
+		*reg -= 4;
 		*reg += bank->bank_num * RK3188_PULL_BANK_STRIDE;
 		*reg += ((pin_num / RK3188_PULL_PINS_PER_REG) * 4);
 
@@ -1427,6 +1432,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
 	 */
 	if (of_device_is_compatible(bank->of_node,
 				    "rockchip,rk3188-gpio-bank0")) {
+
 		bank->bank_type = RK3188_BANK0;
 
 		if (of_address_to_resource(bank->of_node, 1, &res)) {
@@ -1525,8 +1531,11 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(info->reg_base))
 		return PTR_ERR(info->reg_base);
 
-	/* The RK3188 has its pull registers in a separate place */
-	if (ctrl->type == RK3188) {
+	/* to check for the old dt-bindings */
+	info->reg_size = resource_size(res);
+
+	/* Honor the old binding, with pull registers as 2nd resource */
+	if (ctrl->type == RK3188 &&  info->reg_size < 0x200) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 		info->reg_pull = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(info->reg_pull))
-- 
1.9.0
