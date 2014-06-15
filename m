From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 16 Jun 2014 01:36:57 +0200
Subject: [PATCH 3/6] pinctrl: rockchip: add support for 4bit wide iomux
 settings
In-Reply-To: <1887108.ECBDVhibgn@diego>
References: <1887108.ECBDVhibgn@diego>
Message-ID: <3202921.c9uvMZExMc@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the upcoming rk3288 SoC some iomux settings are 4bit wide instead of
the regular 2bit. Therefore add a flag to mark iomuxes as such and adapt
the mux-access as well as the offset calculation accordingly.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 2765bb2..1da6ef9 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -68,6 +68,7 @@ enum rockchip_pinctrl_type {
  * Encode variants of iomux registers into a type variable
  */
 #define IOMUX_GPIO_ONLY		BIT(0)
+#define IOMUX_WIDTH_4BIT	BIT(1)
 
 /**
  * @type: iomux variant using IOMUX_* constants
@@ -376,7 +377,7 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 	struct rockchip_pinctrl *info = bank->drvdata;
 	int iomux_num = (pin / 8);
 	unsigned int val;
-	int reg, ret;
+	int reg, ret, mask;
 	u8 bit;
 
 	if (iomux_num > 3)
@@ -386,14 +387,21 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 		return RK_FUNC_GPIO;
 
 	/* get basic quadrupel of mux registers and the correct reg inside */
+	mask = (bank->iomux[iomux_num].type & IOMUX_WIDTH_4BIT) ? 0xf : 0x3;
 	reg = bank->iomux[iomux_num].offset;
-	bit = (pin % 8) * 2;
+	if (bank->iomux[iomux_num].type & IOMUX_WIDTH_4BIT) {
+		if ((pin % 8) >= 4)
+			reg += 0x4;
+		bit = (pin % 4) * 4;
+	} else {
+		bit = (pin % 8) * 2;
+	}
 
 	ret = regmap_read(info->regmap_base, reg, &val);
 	if (ret)
 		return ret;
 
-	return ((val >> bit) & 3);
+	return ((val >> bit) & mask);
 }
 
 /*
@@ -413,7 +421,7 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 {
 	struct rockchip_pinctrl *info = bank->drvdata;
 	int iomux_num = (pin / 8);
-	int reg, ret;
+	int reg, ret, mask;
 	unsigned long flags;
 	u8 bit;
 	u32 data;
@@ -435,13 +443,20 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 						bank->bank_num, pin, mux);
 
 	/* get basic quadrupel of mux registers and the correct reg inside */
+	mask = (bank->iomux[iomux_num].type & IOMUX_WIDTH_4BIT) ? 0xf : 0x3;
 	reg = bank->iomux[iomux_num].offset;
-	bit = (pin % 8) * 2;
+	if (bank->iomux[iomux_num].type & IOMUX_WIDTH_4BIT) {
+		if ((pin % 8) >= 4)
+			reg += 0x4;
+		bit = (pin % 4) * 4;
+	} else {
+		bit = (pin % 8) * 2;
+	}
 
 	spin_lock_irqsave(&bank->slock, flags);
 
-	data = (3 << (bit + 16));
-	data |= (mux & 3) << bit;
+	data = (mask << (bit + 16));
+	data |= (mux & mask) << bit;
 	ret = regmap_write(info->regmap_base, reg, data);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
@@ -1573,6 +1588,7 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
 		/* calculate iomux offsets */
 		for (j = 0; j < 4; j++) {
 			struct rockchip_iomux *iom = &bank->iomux[j];
+			int inc;
 
 			if (bank_pins >= bank->nr_pins)
 				break;
@@ -1589,8 +1605,10 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
 
 			/*
 			 * Increase offset according to iomux width.
+			 * 4bit iomux'es are spread over two registers.
 			 */
-			grf_offs += 4;
+			inc = (iom->type & IOMUX_WIDTH_4BIT) ? 8 : 4;
+			grf_offs += inc;
 
 			bank_pins += 8;
 		}
-- 
1.9.0
