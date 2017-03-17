From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 17 Mar 2017 18:18:36 +0100
Subject: [PATCH v2 2/6] pinctrl: rockchip: rename RK1108 to RV1108
In-Reply-To: <20170317171840.4683-1-heiko@sntech.de>
References: <20170317171840.4683-1-heiko@sntech.de>
Message-ID: <20170317171840.4683-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Yan <andy.yan@rock-chips.com>

Rockchip finally named the SOC as RV1108, so change it.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

[adapted rk1108 dtsi to keep bisectability]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk1108.dtsi      |  2 +-
 drivers/pinctrl/pinctrl-rockchip.c | 76 +++++++++++++++++++-------------------
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/rk1108.dtsi b/arch/arm/boot/dts/rk1108.dtsi
index d6194bff7afe..6c8fc19d0ecd 100644
--- a/arch/arm/boot/dts/rk1108.dtsi
+++ b/arch/arm/boot/dts/rk1108.dtsi
@@ -222,7 +222,7 @@
 	};
 
 	pinctrl: pinctrl {
-		compatible = "rockchip,rk1108-pinctrl";
+		compatible = "rockchip,rv1108-pinctrl";
 		rockchip,grf = <&grf>;
 		rockchip,pmu = <&pmugrf>;
 		#address-cells = <1>;
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 1e276dfe1763..9000a986caab 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -59,7 +59,7 @@
 #define GPIO_LS_SYNC		0x60
 
 enum rockchip_pinctrl_type {
-	RK1108,
+	RV1108,
 	RK2928,
 	RK3066B,
 	RK3188,
@@ -713,13 +713,13 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 	return ret;
 }
 
-#define RK1108_PULL_PMU_OFFSET		0x10
-#define RK1108_PULL_OFFSET		0x110
-#define RK1108_PULL_PINS_PER_REG	8
-#define RK1108_PULL_BITS_PER_PIN	2
-#define RK1108_PULL_BANK_STRIDE		16
+#define RV1108_PULL_PMU_OFFSET		0x10
+#define RV1108_PULL_OFFSET		0x110
+#define RV1108_PULL_PINS_PER_REG	8
+#define RV1108_PULL_BITS_PER_PIN	2
+#define RV1108_PULL_BANK_STRIDE		16
 
-static void rk1108_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
+static void rv1108_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 					 int pin_num, struct regmap **regmap,
 					 int *reg, u8 *bit)
 {
@@ -728,27 +728,27 @@ static void rk1108_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 	/* The first 24 pins of the first bank are located in PMU */
 	if (bank->bank_num == 0) {
 		*regmap = info->regmap_pmu;
-		*reg = RK1108_PULL_PMU_OFFSET;
+		*reg = RV1108_PULL_PMU_OFFSET;
 	} else {
-		*reg = RK1108_PULL_OFFSET;
+		*reg = RV1108_PULL_OFFSET;
 		*regmap = info->regmap_base;
 		/* correct the offset, as we're starting with the 2nd bank */
 		*reg -= 0x10;
-		*reg += bank->bank_num * RK1108_PULL_BANK_STRIDE;
+		*reg += bank->bank_num * RV1108_PULL_BANK_STRIDE;
 	}
 
-	*reg += ((pin_num / RK1108_PULL_PINS_PER_REG) * 4);
-	*bit = (pin_num % RK1108_PULL_PINS_PER_REG);
-	*bit *= RK1108_PULL_BITS_PER_PIN;
+	*reg += ((pin_num / RV1108_PULL_PINS_PER_REG) * 4);
+	*bit = (pin_num % RV1108_PULL_PINS_PER_REG);
+	*bit *= RV1108_PULL_BITS_PER_PIN;
 }
 
-#define RK1108_DRV_PMU_OFFSET		0x20
-#define RK1108_DRV_GRF_OFFSET		0x210
-#define RK1108_DRV_BITS_PER_PIN		2
-#define RK1108_DRV_PINS_PER_REG		8
-#define RK1108_DRV_BANK_STRIDE		16
+#define RV1108_DRV_PMU_OFFSET		0x20
+#define RV1108_DRV_GRF_OFFSET		0x210
+#define RV1108_DRV_BITS_PER_PIN		2
+#define RV1108_DRV_PINS_PER_REG		8
+#define RV1108_DRV_BANK_STRIDE		16
 
-static void rk1108_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
+static void rv1108_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 					int pin_num, struct regmap **regmap,
 					int *reg, u8 *bit)
 {
@@ -757,19 +757,19 @@ static void rk1108_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 	/* The first 24 pins of the first bank are located in PMU */
 	if (bank->bank_num == 0) {
 		*regmap = info->regmap_pmu;
-		*reg = RK1108_DRV_PMU_OFFSET;
+		*reg = RV1108_DRV_PMU_OFFSET;
 	} else {
 		*regmap = info->regmap_base;
-		*reg = RK1108_DRV_GRF_OFFSET;
+		*reg = RV1108_DRV_GRF_OFFSET;
 
 		/* correct the offset, as we're starting with the 2nd bank */
 		*reg -= 0x10;
-		*reg += bank->bank_num * RK1108_DRV_BANK_STRIDE;
+		*reg += bank->bank_num * RV1108_DRV_BANK_STRIDE;
 	}
 
-	*reg += ((pin_num / RK1108_DRV_PINS_PER_REG) * 4);
-	*bit = pin_num % RK1108_DRV_PINS_PER_REG;
-	*bit *= RK1108_DRV_BITS_PER_PIN;
+	*reg += ((pin_num / RV1108_DRV_PINS_PER_REG) * 4);
+	*bit = pin_num % RV1108_DRV_PINS_PER_REG;
+	*bit *= RV1108_DRV_BITS_PER_PIN;
 }
 
 #define RK2928_PULL_OFFSET		0x118
@@ -1271,7 +1271,7 @@ static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
 		return !(data & BIT(bit))
 				? PIN_CONFIG_BIAS_PULL_PIN_DEFAULT
 				: PIN_CONFIG_BIAS_DISABLE;
-	case RK1108:
+	case RV1108:
 	case RK3188:
 	case RK3288:
 	case RK3368:
@@ -1318,7 +1318,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 
 		spin_unlock_irqrestore(&bank->slock, flags);
 		break;
-	case RK1108:
+	case RV1108:
 	case RK3188:
 	case RK3288:
 	case RK3368:
@@ -1581,7 +1581,7 @@ static bool rockchip_pinconf_pull_valid(struct rockchip_pin_ctrl *ctrl,
 					pull == PIN_CONFIG_BIAS_DISABLE);
 	case RK3066B:
 		return pull ? false : true;
-	case RK1108:
+	case RV1108:
 	case RK3188:
 	case RK3288:
 	case RK3368:
@@ -2699,7 +2699,7 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct rockchip_pin_bank rk1108_pin_banks[] = {
+static struct rockchip_pin_bank rv1108_pin_banks[] = {
 	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", IOMUX_SOURCE_PMU,
 					     IOMUX_SOURCE_PMU,
 					     IOMUX_SOURCE_PMU,
@@ -2709,15 +2709,15 @@ static struct rockchip_pin_bank rk1108_pin_banks[] = {
 	PIN_BANK_IOMUX_FLAGS(3, 32, "gpio3", 0, 0, 0, 0),
 };
 
-static struct rockchip_pin_ctrl rk1108_pin_ctrl = {
-	.pin_banks		= rk1108_pin_banks,
-	.nr_banks		= ARRAY_SIZE(rk1108_pin_banks),
-	.label			= "RK1108-GPIO",
-	.type			= RK1108,
+static struct rockchip_pin_ctrl rv1108_pin_ctrl = {
+	.pin_banks		= rv1108_pin_banks,
+	.nr_banks		= ARRAY_SIZE(rv1108_pin_banks),
+	.label			= "RV1108-GPIO",
+	.type			= RV1108,
 	.grf_mux_offset		= 0x10,
 	.pmu_mux_offset		= 0x0,
-	.pull_calc_reg		= rk1108_calc_pull_reg_and_bit,
-	.drv_calc_reg		= rk1108_calc_drv_reg_and_bit,
+	.pull_calc_reg		= rv1108_calc_pull_reg_and_bit,
+	.drv_calc_reg		= rv1108_calc_drv_reg_and_bit,
 };
 
 static struct rockchip_pin_bank rk2928_pin_banks[] = {
@@ -2975,8 +2975,8 @@ static struct rockchip_pin_ctrl rk3399_pin_ctrl = {
 };
 
 static const struct of_device_id rockchip_pinctrl_dt_match[] = {
-	{ .compatible = "rockchip,rk1108-pinctrl",
-		.data = (void *)&rk1108_pin_ctrl },
+	{ .compatible = "rockchip,rv1108-pinctrl",
+		.data = (void *)&rv1108_pin_ctrl },
 	{ .compatible = "rockchip,rk2928-pinctrl",
 		.data = (void *)&rk2928_pin_ctrl },
 	{ .compatible = "rockchip,rk3036-pinctrl",
-- 
2.11.0
