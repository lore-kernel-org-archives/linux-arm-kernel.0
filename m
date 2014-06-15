From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 16 Jun 2014 01:37:23 +0200
Subject: [PATCH 4/6] pinctrl: rockchip: enable iomuxes from pmu space
In-Reply-To: <1887108.ECBDVhibgn@diego>
References: <1887108.ECBDVhibgn@diego>
Message-ID: <4917062.AxPWdhMMKf@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The upcoming rk3288 moves some iomux settings to the pmu register space.
Therefore add a flag for this and adapt the mux functions accordingly.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c | 42 +++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 1da6ef9..115c75d 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -69,6 +69,7 @@ enum rockchip_pinctrl_type {
  */
 #define IOMUX_GPIO_ONLY		BIT(0)
 #define IOMUX_WIDTH_4BIT	BIT(1)
+#define IOMUX_SOURCE_PMU	BIT(2)
 
 /**
  * @type: iomux variant using IOMUX_* constants
@@ -153,7 +154,8 @@ struct rockchip_pin_ctrl {
 	u32				nr_pins;
 	char				*label;
 	enum rockchip_pinctrl_type	type;
-	int				mux_offset;
+	int				grf_mux_offset;
+	int				pmu_mux_offset;
 	void	(*pull_calc_reg)(struct rockchip_pin_bank *bank,
 				    int pin_num, struct regmap **regmap,
 				    int *reg, u8 *bit);
@@ -376,6 +378,7 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 {
 	struct rockchip_pinctrl *info = bank->drvdata;
 	int iomux_num = (pin / 8);
+	struct regmap *regmap;
 	unsigned int val;
 	int reg, ret, mask;
 	u8 bit;
@@ -386,6 +389,9 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 	if (bank->iomux[iomux_num].type & IOMUX_GPIO_ONLY)
 		return RK_FUNC_GPIO;
 
+	regmap = (bank->iomux[iomux_num].type & IOMUX_SOURCE_PMU)
+				? info->regmap_pmu : info->regmap_base;
+
 	/* get basic quadrupel of mux registers and the correct reg inside */
 	mask = (bank->iomux[iomux_num].type & IOMUX_WIDTH_4BIT) ? 0xf : 0x3;
 	reg = bank->iomux[iomux_num].offset;
@@ -397,7 +403,7 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 		bit = (pin % 8) * 2;
 	}
 
-	ret = regmap_read(info->regmap_base, reg, &val);
+	ret = regmap_read(regmap, reg, &val);
 	if (ret)
 		return ret;
 
@@ -421,6 +427,7 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 {
 	struct rockchip_pinctrl *info = bank->drvdata;
 	int iomux_num = (pin / 8);
+	struct regmap *regmap;
 	int reg, ret, mask;
 	unsigned long flags;
 	u8 bit;
@@ -442,6 +449,9 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 	dev_dbg(info->dev, "setting mux of GPIO%d-%d to %d\n",
 						bank->bank_num, pin, mux);
 
+	regmap = (bank->iomux[iomux_num].type & IOMUX_SOURCE_PMU)
+				? info->regmap_pmu : info->regmap_base;
+
 	/* get basic quadrupel of mux registers and the correct reg inside */
 	mask = (bank->iomux[iomux_num].type & IOMUX_WIDTH_4BIT) ? 0xf : 0x3;
 	reg = bank->iomux[iomux_num].offset;
@@ -457,7 +467,7 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 
 	data = (mask << (bit + 16));
 	data |= (mux & mask) << bit;
-	ret = regmap_write(info->regmap_base, reg, data);
+	ret = regmap_write(regmap, reg, data);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
 
@@ -1553,7 +1563,7 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
 	struct device_node *np;
 	struct rockchip_pin_ctrl *ctrl;
 	struct rockchip_pin_bank *bank;
-	int grf_offs, i, j;
+	int grf_offs, pmu_offs, i, j;
 
 	match = of_match_node(rockchip_pinctrl_dt_match, node);
 	ctrl = (struct rockchip_pin_ctrl *)match->data;
@@ -1575,7 +1585,8 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
 		}
 	}
 
-	grf_offs = ctrl->mux_offset;
+	grf_offs = ctrl->grf_mux_offset;
+	pmu_offs = ctrl->pmu_mux_offset;
 	bank = ctrl->pin_banks;
 	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
 		int bank_pins = 0;
@@ -1595,9 +1606,13 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
 
 			/* preset offset value, set new start value */
 			if (iom->offset >= 0) {
-				grf_offs = iom->offset;
+				if (iom->type & IOMUX_SOURCE_PMU)
+					pmu_offs = iom->offset;
+				else
+					grf_offs = iom->offset;
 			} else { /* set current offset */
-				iom->offset = grf_offs;
+				iom->offset = (iom->type & IOMUX_SOURCE_PMU) ?
+							pmu_offs : grf_offs;
 			}
 
 			dev_dbg(d->dev, "bank %d, iomux %d has offset 0x%x\n",
@@ -1608,7 +1623,10 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
 			 * 4bit iomux'es are spread over two registers.
 			 */
 			inc = (iom->type & IOMUX_WIDTH_4BIT) ? 8 : 4;
-			grf_offs += inc;
+			if (iom->type & IOMUX_SOURCE_PMU)
+				pmu_offs += inc;
+			else
+				grf_offs += inc;
 
 			bank_pins += 8;
 		}
@@ -1715,7 +1733,7 @@ static struct rockchip_pin_ctrl rk2928_pin_ctrl = {
 		.nr_banks		= ARRAY_SIZE(rk2928_pin_banks),
 		.label			= "RK2928-GPIO",
 		.type			= RK2928,
-		.mux_offset		= 0xa8,
+		.grf_mux_offset		= 0xa8,
 		.pull_calc_reg		= rk2928_calc_pull_reg_and_bit,
 };
 
@@ -1733,7 +1751,7 @@ static struct rockchip_pin_ctrl rk3066a_pin_ctrl = {
 		.nr_banks		= ARRAY_SIZE(rk3066a_pin_banks),
 		.label			= "RK3066a-GPIO",
 		.type			= RK2928,
-		.mux_offset		= 0xa8,
+		.grf_mux_offset		= 0xa8,
 		.pull_calc_reg		= rk2928_calc_pull_reg_and_bit,
 };
 
@@ -1749,7 +1767,7 @@ static struct rockchip_pin_ctrl rk3066b_pin_ctrl = {
 		.nr_banks	= ARRAY_SIZE(rk3066b_pin_banks),
 		.label		= "RK3066b-GPIO",
 		.type		= RK3066B,
-		.mux_offset	= 0x60,
+		.grf_mux_offset	= 0x60,
 };
 
 static struct rockchip_pin_bank rk3188_pin_banks[] = {
@@ -1764,7 +1782,7 @@ static struct rockchip_pin_ctrl rk3188_pin_ctrl = {
 		.nr_banks		= ARRAY_SIZE(rk3188_pin_banks),
 		.label			= "RK3188-GPIO",
 		.type			= RK3188,
-		.mux_offset		= 0x60,
+		.grf_mux_offset		= 0x60,
 		.pull_calc_reg		= rk3188_calc_pull_reg_and_bit,
 };
 
-- 
1.9.0
