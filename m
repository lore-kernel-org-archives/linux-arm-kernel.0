From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 15 Oct 2013 12:49:02 +0200
Subject: [PATCH 5/6] pinctrl: rockchip: add rk3188 specifics
In-Reply-To: <201310151246.49402.heiko@sntech.de>
References: <201310151246.49402.heiko@sntech.de>
Message-ID: <201310151249.03197.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Besides the pull registers sitting in a separate place, the rk3188 also
has the peculiarity that the pull registers of the first bank are split
and the first half is sitting in the register space of the pmu.

Therefore this adds a special bank-type for the first bank, to handle
the two register sources.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/pinctrl/rockchip,pinctrl.txt          |   46 +++++++-
 drivers/pinctrl/pinctrl-rockchip.c                 |  117 ++++++++++++++++++--
 2 files changed, 155 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
index b0fb101..f378d34 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
@@ -21,10 +21,13 @@ defined as gpio sub-nodes of the pinmux controller.
 Required properties for iomux controller:
   - compatible: one of "rockchip,rk2928-pinctrl", "rockchip,rk3066a-pinctrl"
 		       "rockchip,rk3066b-pinctrl", "rockchip,rk3188-pinctrl"
+  - reg: first element is the general register space of the iomux controller
+	 second element is the separate pull register space of the rk3188
 
 Required properties for gpio sub nodes:
-  - compatible: "rockchip,gpio-bank"
+  - compatible: "rockchip,gpio-bank", "rockchip,rk3188-gpio-bank0"
   - reg: register of the gpio bank (different than the iomux registerset)
+         second element: separate pull register for rk3188 bank0
   - interrupts: base interrupt of the gpio bank in the interrupt controller
   - clocks: clock that drives this bank
   - gpio-controller: identifies the node as a gpio controller and pin bank.
@@ -95,3 +98,44 @@ uart2: serial at 20064000 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_xfer>;
 };
+
+Example for rk3188:
+
+	pinctrl at 20008000 {
+		compatible = "rockchip,rk3188-pinctrl";
+		reg = <0x20008000 0xa0>,
+		      <0x20008164 0x1a0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gpio0: gpio0 at 0x2000a000 {
+			compatible = "rockchip,rk3188-gpio-bank0";
+			reg = <0x2000a000 0x100>,
+			      <0x20004064 0x8>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_gates8 9>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio1: gpio1 at 0x2003c000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x2003c000 0x100>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_gates8 10>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		...
+
+	};
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index c5bbd24..4db286c 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -64,10 +64,12 @@ enum rockchip_pinctrl_type {
 
 enum rockchip_pin_bank_type {
 	COMMON_BANK,
+	RK3188_BANK0,
 };
 
 /**
  * @reg_base: register base of the gpio bank
+ * @reg_pull: optional separate register for additional pull settings
  * @clk: clock of the gpio bank
  * @irq: interrupt of the gpio bank
  * @pin_base: first pin number
@@ -84,6 +86,7 @@ enum rockchip_pin_bank_type {
  */
 struct rockchip_pin_bank {
 	void __iomem			*reg_base;
+	void __iomem			*reg_pull;
 	struct clk			*clk;
 	int				irq;
 	u32				pin_base;
@@ -157,6 +160,7 @@ struct rockchip_pmx_func {
 
 struct rockchip_pinctrl {
 	void __iomem			*reg_base;
+	void __iomem			*reg_pull;
 	struct device			*dev;
 	struct rockchip_pin_ctrl	*ctrl;
 	struct pinctrl_desc		pctl;
@@ -379,25 +383,71 @@ static void rk2928_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 	*bit = pin_num % RK2928_PULL_PINS_PER_REG;
 };
 
+#define RK3188_PULL_BITS_PER_PIN	2
+#define RK3188_PULL_PINS_PER_REG	8
+#define RK3188_PULL_BANK_STRIDE		16
+
+static void rk3188_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
+				    int pin_num, void __iomem **reg, u8 *bit)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+
+	/* The first 12 pins of the first bank are located elsewhere */
+	if (bank->bank_type == RK3188_BANK0 && pin_num < 12) {
+		*reg = bank->reg_pull +
+				((pin_num / RK3188_PULL_PINS_PER_REG) * 4);
+		*bit = pin_num % RK3188_PULL_PINS_PER_REG;
+		*bit *= RK3188_PULL_BITS_PER_PIN;
+	} else {
+		*reg = info->reg_pull - 4;
+		*reg += bank->bank_num * RK3188_PULL_BANK_STRIDE;
+		*reg += ((pin_num / RK3188_PULL_PINS_PER_REG) * 4);
+
+		/*
+		 * The bits in these registers have an inverse ordering
+		 * with the lowest pin being in bits 15:14 and the highest
+		 * pin in bits 1:0
+		 */
+		*bit = 7 - (pin_num % RK3188_PULL_PINS_PER_REG);
+		*bit *= RK3188_PULL_BITS_PER_PIN;
+	}
+}
+
 static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
 {
 	struct rockchip_pinctrl *info = bank->drvdata;
 	struct rockchip_pin_ctrl *ctrl = info->ctrl;
 	void __iomem *reg;
 	u8 bit;
+	u32 data;
 
 	/* rk3066b does support any pulls */
 	if (ctrl->type == RK3066B)
 		return PIN_CONFIG_BIAS_DISABLE;
 
+	ctrl->pull_calc_reg(bank, pin_num, &reg, &bit);
+
 	switch (ctrl->type) {
 	case RK2928:
-		ctrl->pull_calc_reg(bank, pin_num, &reg, &bit);
 		return !(readl_relaxed(reg) & BIT(bit))
 				? PIN_CONFIG_BIAS_PULL_PIN_DEFAULT
 				: PIN_CONFIG_BIAS_DISABLE;
 	case RK3188:
-		dev_err(info->dev, "pull support for rk31xx not implemented\n");
+		data = readl_relaxed(reg) >> bit;
+		data &= (1 << RK3188_PULL_BITS_PER_PIN) - 1;
+
+		switch (data) {
+		case 0:
+			return PIN_CONFIG_BIAS_DISABLE;
+		case 1:
+			return PIN_CONFIG_BIAS_PULL_UP;
+		case 2:
+			return PIN_CONFIG_BIAS_PULL_DOWN;
+		case 3:
+			return PIN_CONFIG_BIAS_BUS_HOLD;
+		}
+
+		dev_err(info->dev, "unknown pull setting\n");
 		return -EIO;
 	default:
 		dev_err(info->dev, "unsupported pinctrl type\n");
@@ -422,10 +471,10 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 	if (ctrl->type == RK3066B)
 		return pull ? -EINVAL : 0;
 
+	ctrl->pull_calc_reg(bank, pin_num, &reg, &bit);
+
 	switch (ctrl->type) {
 	case RK2928:
-		ctrl->pull_calc_reg(bank, pin_num, &reg, &bit);
-
 		spin_lock_irqsave(&bank->slock, flags);
 
 		data = BIT(bit + 16);
@@ -436,8 +485,33 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 		spin_unlock_irqrestore(&bank->slock, flags);
 		break;
 	case RK3188:
-		dev_err(info->dev, "pull support for rk31xx not implemented\n");
-		return -EIO;
+		spin_lock_irqsave(&bank->slock, flags);
+
+		/* enable the write to the equivalent lower bits */
+		data = ((1 << RK3188_PULL_BITS_PER_PIN) - 1) << (bit + 16);
+
+		switch (pull) {
+		case PIN_CONFIG_BIAS_DISABLE:
+			break;
+		case PIN_CONFIG_BIAS_PULL_UP:
+			data |= (1 << bit);
+			break;
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			data |= (2 << bit);
+			break;
+		case PIN_CONFIG_BIAS_BUS_HOLD:
+			data |= (3 << bit);
+			break;
+		default:
+			dev_err(info->dev, "unsupported pull setting %d\n",
+				pull);
+			return -EINVAL;
+		}
+
+		writel(data, reg);
+
+		spin_unlock_irqrestore(&bank->slock, flags);
+		break;
 	default:
 		dev_err(info->dev, "unsupported pinctrl type\n");
 		return -EINVAL;
@@ -608,6 +681,7 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		case PIN_CONFIG_BIAS_PULL_UP:
 		case PIN_CONFIG_BIAS_PULL_DOWN:
 		case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
+		case PIN_CONFIG_BIAS_BUS_HOLD:
 			if (!rockchip_pinconf_pull_valid(info->ctrl, param))
 				return -ENOTSUPP;
 
@@ -646,6 +720,7 @@ static int rockchip_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 	case PIN_CONFIG_BIAS_PULL_UP:
 	case PIN_CONFIG_BIAS_PULL_DOWN:
 	case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
+	case PIN_CONFIG_BIAS_BUS_HOLD:
 		if (!rockchip_pinconf_pull_valid(info->ctrl, param))
 			return -ENOTSUPP;
 
@@ -669,6 +744,7 @@ static const struct pinconf_ops rockchip_pinconf_ops = {
 
 static const char * const gpio_compat[] = {
 	"rockchip,gpio-bank",
+	"rockchip,rk3188-gpio-bank0",
 };
 
 static void rockchip_pinctrl_child_count(struct rockchip_pinctrl *info,
@@ -1220,7 +1296,25 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
 	if (IS_ERR(bank->reg_base))
 		return PTR_ERR(bank->reg_base);
 
-	bank->bank_type = COMMON_BANK;
+	/*
+	 * special case, where parts of the pull setting-registers are
+	 * part of the PMU register space
+	 */
+	if (of_device_is_compatible(bank->of_node,
+				    "rockchip,rk3188-gpio-bank0")) {
+		bank->bank_type = RK3188_BANK0;
+
+		if (of_address_to_resource(bank->of_node, 1, &res)) {
+			dev_err(dev, "cannot find IO resource for bank\n");
+			return -ENOENT;
+		}
+
+		bank->reg_pull = devm_ioremap_resource(dev, &res);
+		if (IS_ERR(bank->reg_pull))
+			return PTR_ERR(bank->reg_pull);
+	} else {
+		bank->bank_type = COMMON_BANK;
+	}
 
 	bank->irq = irq_of_parse_and_map(bank->of_node, 0);
 
@@ -1306,6 +1400,14 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(info->reg_base))
 		return PTR_ERR(info->reg_base);
 
+	/* The RK3188 has its pull registers in a separate place */
+	if (ctrl->type == RK3188) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		info->reg_pull = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(info->reg_base))
+			return PTR_ERR(info->reg_base);
+	}
+
 	ret = rockchip_gpiolib_register(pdev, info);
 	if (ret)
 		return ret;
@@ -1383,6 +1485,7 @@ static struct rockchip_pin_ctrl rk3188_pin_ctrl = {
 		.label			= "RK3188-GPIO",
 		.type			= RK3188,
 		.mux_offset		= 0x68,
+		.pull_calc_reg		= rk3188_calc_pull_reg_and_bit,
 };
 
 static const struct of_device_id rockchip_pinctrl_dt_match[] = {
-- 
1.7.10.4
