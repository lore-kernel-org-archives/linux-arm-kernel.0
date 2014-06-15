From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 16 Jun 2014 01:36:05 +0200
Subject: [PATCH 1/6] pinctrl: rockchip: generalize bank-quirks
In-Reply-To: <1887108.ECBDVhibgn@diego>
References: <1887108.ECBDVhibgn@diego>
Message-ID: <4968696.mtf50E1720@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Upcoming Rockchip SoCs have additional quirks to handle. Currently they would
be handled by giving the bank a special compatible property. But the nature
of the new quirks would require a lot of them. Also as we want to move to the
separate dw_gpio driver in the future, these bank-definitions should be
extended at all.

Describing the bank quirks this way also enables us to deprecate the special
bank compatible string for bank0 on rk3188 and simplify the handling code.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/pinctrl/rockchip,pinctrl.txt          |  3 +-
 drivers/pinctrl/pinctrl-rockchip.c                 | 59 ++++++++++++++--------
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
index cefef74..eb0544f 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
@@ -36,7 +36,7 @@ Deprecated properties for iomux controller:
 	 Use rockchip,grf and rockchip,pmu described above instead.
 
 Required properties for gpio sub nodes:
-  - compatible: "rockchip,gpio-bank", "rockchip,rk3188-gpio-bank0"
+  - compatible: "rockchip,gpio-bank"
   - reg: register of the gpio bank (different than the iomux registerset)
   - interrupts: base interrupt of the gpio bank in the interrupt controller
   - clocks: clock that drives this bank
@@ -50,6 +50,7 @@ Required properties for gpio sub nodes:
     bindings/interrupt-controller/interrupts.txt
 
 Deprecated properties for gpio sub nodes:
+  - compatible: "rockchip,rk3188-gpio-bank0"
   - reg: second element: separate pull register for rk3188 bank0, use
 	 rockchip,pmu described above instead
 
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index bb805d5..2296765 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -64,9 +64,16 @@ enum rockchip_pinctrl_type {
 	RK3188,
 };
 
-enum rockchip_pin_bank_type {
-	COMMON_BANK,
-	RK3188_BANK0,
+/**
+ * Encode variants of iomux registers into a type variable
+ */
+#define IOMUX_GPIO_ONLY		BIT(0)
+
+/**
+ * @type: iomux variant using IOMUX_* constants
+ */
+struct rockchip_iomux {
+	int				type;
 };
 
 /**
@@ -78,6 +85,7 @@ enum rockchip_pin_bank_type {
  * @nr_pins: number of pins in this bank
  * @name: name of the bank
  * @bank_num: number of the bank, to account for holes
+ * @iomux: array describing the 4 iomux sources of the bank
  * @valid: are all necessary informations present
  * @of_node: dt node of this bank
  * @drvdata: common pinctrl basedata
@@ -95,7 +103,7 @@ struct rockchip_pin_bank {
 	u8				nr_pins;
 	char				*name;
 	u8				bank_num;
-	enum rockchip_pin_bank_type	bank_type;
+	struct rockchip_iomux		iomux[4];
 	bool				valid;
 	struct device_node		*of_node;
 	struct rockchip_pinctrl		*drvdata;
@@ -113,6 +121,19 @@ struct rockchip_pin_bank {
 		.name		= label,		\
 	}
 
+#define PIN_BANK_IOMUX_FLAGS(id, pins, label, iom0, iom1, iom2, iom3)	\
+	{								\
+		.bank_num	= id,					\
+		.nr_pins	= pins,					\
+		.name		= label,				\
+		.iomux		= {					\
+			{ .type = iom0, },				\
+			{ .type = iom1, },				\
+			{ .type = iom2, },				\
+			{ .type = iom3, },				\
+		},							\
+	}
+
 /**
  */
 struct rockchip_pin_ctrl {
@@ -343,17 +364,21 @@ static const struct pinctrl_ops rockchip_pctrl_ops = {
 static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 {
 	struct rockchip_pinctrl *info = bank->drvdata;
+	int iomux_num = (pin / 8);
 	unsigned int val;
 	int reg, ret;
 	u8 bit;
 
-	if (bank->bank_type == RK3188_BANK0 && pin < 16)
+	if (iomux_num > 3)
+		return -EINVAL;
+
+	if (bank->iomux[iomux_num].type & IOMUX_GPIO_ONLY)
 		return RK_FUNC_GPIO;
 
 	/* get basic quadrupel of mux registers and the correct reg inside */
 	reg = info->ctrl->mux_offset;
 	reg += bank->bank_num * 0x10;
-	reg += (pin / 8) * 4;
+	reg += iomux_num * 4;
 	bit = (pin % 8) * 2;
 
 	ret = regmap_read(info->regmap_base, reg, &val);
@@ -379,16 +404,16 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 {
 	struct rockchip_pinctrl *info = bank->drvdata;
+	int iomux_num = (pin / 8);
 	int reg, ret;
 	unsigned long flags;
 	u8 bit;
 	u32 data;
 
-	/*
-	 * The first 16 pins of rk3188_bank0 are always gpios and do not have
-	 * a mux register at all.
-	 */
-	if (bank->bank_type == RK3188_BANK0 && pin < 16) {
+	if (iomux_num > 3)
+		return -EINVAL;
+
+	if (bank->iomux[iomux_num].type & IOMUX_GPIO_ONLY) {
 		if (mux != RK_FUNC_GPIO) {
 			dev_err(info->dev,
 				"pin %d only supports a gpio mux\n", pin);
@@ -404,7 +429,7 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 	/* get basic quadrupel of mux registers and the correct reg inside */
 	reg = info->ctrl->mux_offset;
 	reg += bank->bank_num * 0x10;
-	reg += (pin / 8) * 4;
+	reg += iomux_num * 4;
 	bit = (pin % 8) * 2;
 
 	spin_lock_irqsave(&bank->slock, flags);
@@ -449,7 +474,7 @@ static void rk3188_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 	struct rockchip_pinctrl *info = bank->drvdata;
 
 	/* The first 12 pins of the first bank are located elsewhere */
-	if (bank->bank_type == RK3188_BANK0 && pin_num < 12) {
+	if (bank->bank_num == 0 && pin_num < 12) {
 		*regmap = info->regmap_pmu ? info->regmap_pmu
 					   : bank->regmap_pull;
 		*reg = info->regmap_pmu ? RK3188_PULL_PMU_OFFSET : 0;
@@ -1466,8 +1490,6 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
 				    "rockchip,rk3188-gpio-bank0")) {
 		struct device_node *node;
 
-		bank->bank_type = RK3188_BANK0;
-
 		node = of_parse_phandle(bank->of_node->parent,
 					"rockchip,pmu", 0);
 		if (!node) {
@@ -1487,9 +1509,6 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
 						    base,
 						    &rockchip_regmap_config);
 		}
-
-	} else {
-		bank->bank_type = COMMON_BANK;
 	}
 
 	bank->irq = irq_of_parse_and_map(bank->of_node, 0);
@@ -1682,7 +1701,7 @@ static struct rockchip_pin_ctrl rk3066b_pin_ctrl = {
 };
 
 static struct rockchip_pin_bank rk3188_pin_banks[] = {
-	PIN_BANK(0, 32, "gpio0"),
+	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", IOMUX_GPIO_ONLY, 0, 0, 0),
 	PIN_BANK(1, 32, "gpio1"),
 	PIN_BANK(2, 32, "gpio2"),
 	PIN_BANK(3, 32, "gpio3"),
-- 
1.9.0
