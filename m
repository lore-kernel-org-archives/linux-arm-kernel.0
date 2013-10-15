From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 15 Oct 2013 12:47:26 +0200
Subject: [PATCH 1/6] pinctrl: rockchip: separate different sub-types more
In-Reply-To: <201310151246.49402.heiko@sntech.de>
References: <201310151246.49402.heiko@sntech.de>
Message-ID: <201310151247.26535.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Further investigation of the different Rockchip SoCs showed that
the differences especially in the pull settings are quite deep.
As further patches will show, the register layout for the pulls of
the rk3188 is quite strange. Also it is to assume, that later
Rockchip SoCs may introduce even more quirks in this regard, making
it hard to support all of those using the current generic pull_*
variables.

Therefore move the driver to hold the type of controller in an enum
and do the handling according to it in the necessary places. Also
instead of calculating the register in the get and set pull functions
move it to a type-specific callback.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c |  105 +++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 48 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index e0718b7..df155f9 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -56,6 +56,12 @@
 #define GPIO_EXT_PORT		0x50
 #define GPIO_LS_SYNC		0x60
 
+enum rockchip_pinctrl_type {
+	RK2928,
+	RK3066B,
+	RK3188,
+};
+
 /**
  * @reg_base: register base of the gpio bank
  * @clk: clock of the gpio bank
@@ -98,18 +104,16 @@ struct rockchip_pin_bank {
 	}
 
 /**
- * @pull_auto: some SoCs don't allow pulls to be specified as up or down, but
- *	       instead decide this automatically based on the pad-type.
  */
 struct rockchip_pin_ctrl {
 	struct rockchip_pin_bank	*pin_banks;
 	u32				nr_banks;
 	u32				nr_pins;
 	char				*label;
+	enum rockchip_pinctrl_type	type;
 	int				mux_offset;
-	int				pull_offset;
-	bool				pull_auto;
-	int				pull_bank_stride;
+	void	(*pull_calc_reg)(struct rockchip_pin_bank *bank, int pin_num,
+				 void __iomem **reg, u8 *bit);
 };
 
 struct rockchip_pin_config {
@@ -354,6 +358,22 @@ static void rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 	spin_unlock_irqrestore(&bank->slock, flags);
 }
 
+#define RK2928_PULL_OFFSET		0x118
+#define RK2928_PULL_PINS_PER_REG	16
+#define RK2928_PULL_BANK_STRIDE		8
+
+static void rk2928_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
+				    int pin_num, void __iomem **reg, u8 *bit)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+
+	*reg = info->reg_base + RK2928_PULL_OFFSET;
+	*reg += bank->bank_num * RK2928_PULL_BANK_STRIDE;
+	*reg += (pin_num / RK2928_PULL_PINS_PER_REG) * 4;
+
+	*bit = pin_num % RK2928_PULL_PINS_PER_REG;
+};
+
 static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
 {
 	struct rockchip_pinctrl *info = bank->drvdata;
@@ -362,23 +382,22 @@ static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
 	u8 bit;
 
 	/* rk3066b does support any pulls */
-	if (!ctrl->pull_offset)
+	if (ctrl->type == RK3066B)
 		return PIN_CONFIG_BIAS_DISABLE;
 
-	reg = info->reg_base + ctrl->pull_offset;
-
-	if (ctrl->pull_auto) {
-		reg += bank->bank_num * ctrl->pull_bank_stride;
-		reg += (pin_num / 16) * 4;
-		bit = pin_num % 16;
-
+	switch (ctrl->type) {
+	case RK2928:
+		ctrl->pull_calc_reg(bank, pin_num, &reg, &bit);
 		return !(readl_relaxed(reg) & BIT(bit))
 				? PIN_CONFIG_BIAS_PULL_PIN_DEFAULT
 				: PIN_CONFIG_BIAS_DISABLE;
-	} else {
+	case RK3188:
 		dev_err(info->dev, "pull support for rk31xx not implemented\n");
 		return -EIO;
-	}
+	default:
+		dev_err(info->dev, "unsupported pinctrl type\n");
+		return -EINVAL;
+	};
 }
 
 static int rockchip_set_pull(struct rockchip_pin_bank *bank,
@@ -395,21 +414,18 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 		 bank->bank_num, pin_num, pull);
 
 	/* rk3066b does support any pulls */
-	if (!ctrl->pull_offset)
+	if (ctrl->type == RK3066B)
 		return pull ? -EINVAL : 0;
 
-	reg = info->reg_base + ctrl->pull_offset;
-
-	if (ctrl->pull_auto) {
+	switch (ctrl->type) {
+	case RK2928:
 		if (pull != PIN_CONFIG_BIAS_PULL_PIN_DEFAULT &&
 					pull != PIN_CONFIG_BIAS_DISABLE) {
 			dev_err(info->dev, "only PIN_DEFAULT and DISABLE allowed\n");
 			return -EINVAL;
 		}
 
-		reg += bank->bank_num * ctrl->pull_bank_stride;
-		reg += (pin_num / 16) * 4;
-		bit = pin_num % 16;
+		ctrl->pull_calc_reg(bank, pin_num, &reg, &bit);
 
 		spin_lock_irqsave(&bank->slock, flags);
 
@@ -419,14 +435,13 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 		writel(data, reg);
 
 		spin_unlock_irqrestore(&bank->slock, flags);
-	} else {
-		if (pull == PIN_CONFIG_BIAS_PULL_PIN_DEFAULT) {
-			dev_err(info->dev, "pull direction (up/down) needs to be specified\n");
-			return -EINVAL;
-		}
-
+		break;
+	case RK3188:
 		dev_err(info->dev, "pull support for rk31xx not implemented\n");
 		return -EIO;
+	default:
+		dev_err(info->dev, "unsupported pinctrl type\n");
+		return -EINVAL;
 	}
 
 	return 0;
@@ -556,20 +571,17 @@ static const struct pinmux_ops rockchip_pmx_ops = {
 static bool rockchip_pinconf_pull_valid(struct rockchip_pin_ctrl *ctrl,
 					enum pin_config_param pull)
 {
-	/* rk3066b does support any pulls */
-	if (!ctrl->pull_offset)
+	switch (ctrl->type) {
+	case RK2928:
+		return (pull == PIN_CONFIG_BIAS_PULL_PIN_DEFAULT ||
+					pull == PIN_CONFIG_BIAS_DISABLE);
+	case RK3066B:
 		return pull ? false : true;
-
-	if (ctrl->pull_auto) {
-		if (pull != PIN_CONFIG_BIAS_PULL_PIN_DEFAULT &&
-					pull != PIN_CONFIG_BIAS_DISABLE)
-			return false;
-	} else {
-		if (pull == PIN_CONFIG_BIAS_PULL_PIN_DEFAULT)
-			return false;
+	case RK3188:
+		return (pull != PIN_CONFIG_BIAS_PULL_PIN_DEFAULT);
 	}
 
-	return true;
+	return false;
 }
 
 /* set the pin config settings for a specified pin */
@@ -1315,10 +1327,9 @@ static struct rockchip_pin_ctrl rk2928_pin_ctrl = {
 		.pin_banks		= rk2928_pin_banks,
 		.nr_banks		= ARRAY_SIZE(rk2928_pin_banks),
 		.label			= "RK2928-GPIO",
+		.type			= RK2928,
 		.mux_offset		= 0xa8,
-		.pull_offset		= 0x118,
-		.pull_auto		= 1,
-		.pull_bank_stride	= 8,
+		.pull_calc_reg		= rk2928_calc_pull_reg_and_bit,
 };
 
 static struct rockchip_pin_bank rk3066a_pin_banks[] = {
@@ -1334,10 +1345,9 @@ static struct rockchip_pin_ctrl rk3066a_pin_ctrl = {
 		.pin_banks		= rk3066a_pin_banks,
 		.nr_banks		= ARRAY_SIZE(rk3066a_pin_banks),
 		.label			= "RK3066a-GPIO",
+		.type			= RK2928,
 		.mux_offset		= 0xa8,
-		.pull_offset		= 0x118,
-		.pull_auto		= 1,
-		.pull_bank_stride	= 8,
+		.pull_calc_reg		= rk2928_calc_pull_reg_and_bit,
 };
 
 static struct rockchip_pin_bank rk3066b_pin_banks[] = {
@@ -1351,8 +1361,8 @@ static struct rockchip_pin_ctrl rk3066b_pin_ctrl = {
 		.pin_banks	= rk3066b_pin_banks,
 		.nr_banks	= ARRAY_SIZE(rk3066b_pin_banks),
 		.label		= "RK3066b-GPIO",
+		.type		= RK3066B,
 		.mux_offset	= 0x60,
-		.pull_offset	= -EINVAL,
 };
 
 static struct rockchip_pin_bank rk3188_pin_banks[] = {
@@ -1366,9 +1376,8 @@ static struct rockchip_pin_ctrl rk3188_pin_ctrl = {
 		.pin_banks		= rk3188_pin_banks,
 		.nr_banks		= ARRAY_SIZE(rk3188_pin_banks),
 		.label			= "RK3188-GPIO",
+		.type			= RK3188,
 		.mux_offset		= 0x68,
-		.pull_offset		= 0x164,
-		.pull_bank_stride	= 16,
 };
 
 static const struct of_device_id rockchip_pinctrl_dt_match[] = {
-- 
1.7.10.4
