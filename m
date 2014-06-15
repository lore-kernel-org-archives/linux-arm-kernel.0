From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 16 Jun 2014 01:36:33 +0200
Subject: [PATCH 2/6] pinctrl: rockchip: precalculate iomux offsets
In-Reply-To: <1887108.ECBDVhibgn@diego>
References: <1887108.ECBDVhibgn@diego>
Message-ID: <1594704.Rz42T08l8V@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An upcoming SoC introduces an interesting quirk to iomux handling making the
calculation of the iomux register-offset harder. To keep the complexity down
when getting/setting the mux, precalculate the actual register offset at
probe-time.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c | 56 ++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 2296765..2765bb2 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -71,9 +71,13 @@ enum rockchip_pinctrl_type {
 
 /**
  * @type: iomux variant using IOMUX_* constants
+ * @offset: if initialized to -1 it will be autocalculated, by specifying
+ *	    an initial offset value the relevant source offset can be reset
+ *	    to a new value for autocalculating the following iomux registers.
  */
 struct rockchip_iomux {
 	int				type;
+	int				offset;
 };
 
 /**
@@ -119,6 +123,12 @@ struct rockchip_pin_bank {
 		.bank_num	= id,			\
 		.nr_pins	= pins,			\
 		.name		= label,		\
+		.iomux		= {			\
+			{ .offset = -1 },		\
+			{ .offset = -1 },		\
+			{ .offset = -1 },		\
+			{ .offset = -1 },		\
+		},					\
 	}
 
 #define PIN_BANK_IOMUX_FLAGS(id, pins, label, iom0, iom1, iom2, iom3)	\
@@ -127,10 +137,10 @@ struct rockchip_pin_bank {
 		.nr_pins	= pins,					\
 		.name		= label,				\
 		.iomux		= {					\
-			{ .type = iom0, },				\
-			{ .type = iom1, },				\
-			{ .type = iom2, },				\
-			{ .type = iom3, },				\
+			{ .type = iom0, .offset = -1 },			\
+			{ .type = iom1, .offset = -1 },			\
+			{ .type = iom2, .offset = -1 },			\
+			{ .type = iom3, .offset = -1 },			\
 		},							\
 	}
 
@@ -376,9 +386,7 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 		return RK_FUNC_GPIO;
 
 	/* get basic quadrupel of mux registers and the correct reg inside */
-	reg = info->ctrl->mux_offset;
-	reg += bank->bank_num * 0x10;
-	reg += iomux_num * 4;
+	reg = bank->iomux[iomux_num].offset;
 	bit = (pin % 8) * 2;
 
 	ret = regmap_read(info->regmap_base, reg, &val);
@@ -427,9 +435,7 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 						bank->bank_num, pin, mux);
 
 	/* get basic quadrupel of mux registers and the correct reg inside */
-	reg = info->ctrl->mux_offset;
-	reg += bank->bank_num * 0x10;
-	reg += iomux_num * 4;
+	reg = bank->iomux[iomux_num].offset;
 	bit = (pin % 8) * 2;
 
 	spin_lock_irqsave(&bank->slock, flags);
@@ -1532,7 +1538,7 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
 	struct device_node *np;
 	struct rockchip_pin_ctrl *ctrl;
 	struct rockchip_pin_bank *bank;
-	int i;
+	int grf_offs, i, j;
 
 	match = of_match_node(rockchip_pinctrl_dt_match, node);
 	ctrl = (struct rockchip_pin_ctrl *)match->data;
@@ -1554,12 +1560,40 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(
 		}
 	}
 
+	grf_offs = ctrl->mux_offset;
 	bank = ctrl->pin_banks;
 	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
+		int bank_pins = 0;
+
 		spin_lock_init(&bank->slock);
 		bank->drvdata = d;
 		bank->pin_base = ctrl->nr_pins;
 		ctrl->nr_pins += bank->nr_pins;
+
+		/* calculate iomux offsets */
+		for (j = 0; j < 4; j++) {
+			struct rockchip_iomux *iom = &bank->iomux[j];
+
+			if (bank_pins >= bank->nr_pins)
+				break;
+
+			/* preset offset value, set new start value */
+			if (iom->offset >= 0) {
+				grf_offs = iom->offset;
+			} else { /* set current offset */
+				iom->offset = grf_offs;
+			}
+
+			dev_dbg(d->dev, "bank %d, iomux %d has offset 0x%x\n",
+				 i, j, iom->offset);
+
+			/*
+			 * Increase offset according to iomux width.
+			 */
+			grf_offs += 4;
+
+			bank_pins += 8;
+		}
 	}
 
 	return ctrl;
-- 
1.9.0
