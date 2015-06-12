From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 12 Jun 2015 23:50:11 +0200
Subject: [PATCH 1/2] pinctrl: rockchip: generalize perpin driver-strength
 setting
Message-ID: <2322857.kblfsanYOB@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The upcoming support for the RK3368 ARM64 SoC also supports perpin
drive strength settings (at different register positions), so generalize
the register and offset calculation to easily support this one too.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index dee7d5f..70423ae 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -163,6 +163,9 @@ struct rockchip_pin_ctrl {
 	void	(*pull_calc_reg)(struct rockchip_pin_bank *bank,
 				    int pin_num, struct regmap **regmap,
 				    int *reg, u8 *bit);
+	void	(*drv_calc_reg)(struct rockchip_pin_bank *bank,
+				    int pin_num, struct regmap **regmap,
+				    int *reg, u8 *bit);
 };
 
 struct rockchip_pin_config {
@@ -581,7 +584,6 @@ static void rk3288_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 #define RK3288_DRV_BITS_PER_PIN		2
 #define RK3288_DRV_PINS_PER_REG		8
 #define RK3288_DRV_BANK_STRIDE		16
-static int rk3288_drv_list[] = { 2, 4, 8, 12 };
 
 static void rk3288_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 				    int pin_num, struct regmap **regmap,
@@ -611,14 +613,19 @@ static void rk3288_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 	}
 }
 
-static int rk3288_get_drive(struct rockchip_pin_bank *bank, int pin_num)
+static int rockchip_perpin_drv_list[] = { 2, 4, 8, 12 };
+
+static int rockchip_get_drive_perpin(struct rockchip_pin_bank *bank,
+				     int pin_num)
 {
+	struct rockchip_pinctrl *info = bank->drvdata;
+	struct rockchip_pin_ctrl *ctrl = info->ctrl;
 	struct regmap *regmap;
 	int reg, ret;
 	u32 data;
 	u8 bit;
 
-	rk3288_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+	ctrl->drv_calc_reg(bank, pin_num, &regmap, &reg, &bit);
 
 	ret = regmap_read(regmap, reg, &data);
 	if (ret)
@@ -627,24 +634,25 @@ static int rk3288_get_drive(struct rockchip_pin_bank *bank, int pin_num)
 	data >>= bit;
 	data &= (1 << RK3288_DRV_BITS_PER_PIN) - 1;
 
-	return rk3288_drv_list[data];
+	return rockchip_perpin_drv_list[data];
 }
 
-static int rk3288_set_drive(struct rockchip_pin_bank *bank, int pin_num,
-			    int strength)
+static int rockchip_set_drive_perpin(struct rockchip_pin_bank *bank,
+				     int pin_num, int strength)
 {
 	struct rockchip_pinctrl *info = bank->drvdata;
+	struct rockchip_pin_ctrl *ctrl = info->ctrl;
 	struct regmap *regmap;
 	unsigned long flags;
 	int reg, ret, i;
 	u32 data, rmask;
 	u8 bit;
 
-	rk3288_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+	ctrl->drv_calc_reg(bank, pin_num, &regmap, &reg, &bit);
 
 	ret = -EINVAL;
-	for (i = 0; i < ARRAY_SIZE(rk3288_drv_list); i++) {
-		if (rk3288_drv_list[i] == strength) {
+	for (i = 0; i < ARRAY_SIZE(rockchip_perpin_drv_list); i++) {
+		if (rockchip_perpin_drv_list[i] == strength) {
 			ret = i;
 			break;
 		}
@@ -983,10 +991,11 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 		case PIN_CONFIG_DRIVE_STRENGTH:
 			/* rk3288 is the first with per-pin drive-strength */
-			if (info->ctrl->type != RK3288)
+			if (!info->ctrl->drv_calc_reg)
 				return -ENOTSUPP;
 
-			rc = rk3288_set_drive(bank, pin - bank->pin_base, arg);
+			rc = rockchip_set_drive_perpin(bank,
+						pin - bank->pin_base, arg);
 			if (rc < 0)
 				return rc;
 			break;
@@ -1041,10 +1050,10 @@ static int rockchip_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		/* rk3288 is the first with per-pin drive-strength */
-		if (info->ctrl->type != RK3288)
+		if (!info->ctrl->drv_calc_reg)
 			return -ENOTSUPP;
 
-		rc = rk3288_get_drive(bank, pin - bank->pin_base);
+		rc = rockchip_get_drive_perpin(bank, pin - bank->pin_base);
 		if (rc < 0)
 			return rc;
 
@@ -2056,6 +2065,7 @@ static struct rockchip_pin_ctrl rk3288_pin_ctrl = {
 		.grf_mux_offset		= 0x0,
 		.pmu_mux_offset		= 0x84,
 		.pull_calc_reg		= rk3288_calc_pull_reg_and_bit,
+		.drv_calc_reg		= rk3288_calc_drv_reg_and_bit,
 };
 
 static const struct of_device_id rockchip_pinctrl_dt_match[] = {
-- 
2.1.4
