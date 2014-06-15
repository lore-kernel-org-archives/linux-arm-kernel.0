From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 16 Jun 2014 01:38:14 +0200
Subject: [PATCH 6/6] pinctrl: rockchip: add support for rk3288 pin-controller
In-Reply-To: <1887108.ECBDVhibgn@diego>
References: <1887108.ECBDVhibgn@diego>
Message-ID: <2310093.bbNZSdsZOe@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pin-controller of the new RK3288 contains all the quirks just added in
the previous patches.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/pinctrl/rockchip,pinctrl.txt          |  1 +
 drivers/pinctrl/pinctrl-rockchip.c                 | 73 ++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
index eb0544f..4658b69 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
@@ -21,6 +21,7 @@ defined as gpio sub-nodes of the pinmux controller.
 Required properties for iomux controller:
   - compatible: one of "rockchip,rk2928-pinctrl", "rockchip,rk3066a-pinctrl"
 		       "rockchip,rk3066b-pinctrl", "rockchip,rk3188-pinctrl"
+		       "rockchip,rk3288-pinctrl"
   - rockchip,grf: phandle referencing a syscon providing the
 	 "general register files"
 
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index c8920f5..cc5c63e 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -543,6 +543,35 @@ static void rk3188_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 	}
 }
 
+#define RK3288_PULL_OFFSET		0x140
+static void rk3288_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
+				    int pin_num, struct regmap **regmap,
+				    int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+
+	/* The first 24 pins of the first bank are located in PMU */
+	if (bank->bank_num == 0) {
+		*regmap = info->regmap_pmu;
+		*reg = RK3188_PULL_PMU_OFFSET;
+
+		*reg += ((pin_num / RK3188_PULL_PINS_PER_REG) * 4);
+		*bit = pin_num % RK3188_PULL_PINS_PER_REG;
+		*bit *= RK3188_PULL_BITS_PER_PIN;
+	} else {
+		*regmap = info->regmap_base;
+		*reg = RK3288_PULL_OFFSET;
+
+		/* correct the offset, as we're starting with the 2nd bank */
+		*reg -= 0x10;
+		*reg += bank->bank_num * RK3188_PULL_BANK_STRIDE;
+		*reg += ((pin_num / RK3188_PULL_PINS_PER_REG) * 4);
+
+		*bit = (pin_num % RK3188_PULL_PINS_PER_REG);
+		*bit *= RK3188_PULL_BITS_PER_PIN;
+	}
+}
+
 static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
 {
 	struct rockchip_pinctrl *info = bank->drvdata;
@@ -1797,6 +1826,48 @@ static struct rockchip_pin_ctrl rk3188_pin_ctrl = {
 		.pull_calc_reg		= rk3188_calc_pull_reg_and_bit,
 };
 
+static struct rockchip_pin_bank rk3288_pin_banks[] = {
+	PIN_BANK_IOMUX_FLAGS(0, 24, "gpio0", IOMUX_SOURCE_PMU,
+					     IOMUX_SOURCE_PMU,
+					     IOMUX_SOURCE_PMU,
+					     IOMUX_UNROUTED
+			    ),
+	PIN_BANK_IOMUX_FLAGS(1, 32, "gpio1", IOMUX_UNROUTED,
+					     IOMUX_UNROUTED,
+					     IOMUX_UNROUTED,
+					     0
+			    ),
+	PIN_BANK_IOMUX_FLAGS(2, 32, "gpio2", 0, 0, 0, IOMUX_UNROUTED),
+	PIN_BANK_IOMUX_FLAGS(3, 32, "gpio3", 0, 0, 0, IOMUX_WIDTH_4BIT),
+	PIN_BANK_IOMUX_FLAGS(4, 32, "gpio4", IOMUX_WIDTH_4BIT,
+					     IOMUX_WIDTH_4BIT,
+					     0,
+					     0
+			    ),
+	PIN_BANK_IOMUX_FLAGS(5, 32, "gpio5", IOMUX_UNROUTED,
+					     0,
+					     0,
+					     IOMUX_UNROUTED
+			    ),
+	PIN_BANK_IOMUX_FLAGS(6, 32, "gpio6", 0, 0, 0, IOMUX_UNROUTED),
+	PIN_BANK_IOMUX_FLAGS(7, 32, "gpio7", 0,
+					     0,
+					     IOMUX_WIDTH_4BIT,
+					     IOMUX_UNROUTED
+			    ),
+	PIN_BANK(8, 16, "gpio8"),
+};
+
+static struct rockchip_pin_ctrl rk3288_pin_ctrl = {
+		.pin_banks		= rk3288_pin_banks,
+		.nr_banks		= ARRAY_SIZE(rk3288_pin_banks),
+		.label			= "RK3288-GPIO",
+		.type			= RK3188,
+		.grf_mux_offset		= 0x0,
+		.pmu_mux_offset		= 0x84,
+		.pull_calc_reg		= rk3288_calc_pull_reg_and_bit,
+};
+
 static const struct of_device_id rockchip_pinctrl_dt_match[] = {
 	{ .compatible = "rockchip,rk2928-pinctrl",
 		.data = (void *)&rk2928_pin_ctrl },
@@ -1806,6 +1877,8 @@ static const struct of_device_id rockchip_pinctrl_dt_match[] = {
 		.data = (void *)&rk3066b_pin_ctrl },
 	{ .compatible = "rockchip,rk3188-pinctrl",
 		.data = (void *)&rk3188_pin_ctrl },
+	{ .compatible = "rockchip,rk3288-pinctrl",
+		.data = (void *)&rk3288_pin_ctrl },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rockchip_pinctrl_dt_match);
-- 
1.9.0
