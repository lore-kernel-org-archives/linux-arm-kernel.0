From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 20 Jul 2014 01:50:11 +0200
Subject: [PATCH 3/3] pinctrl: rockchip: add drive-strength control for rk3288
In-Reply-To: <3086962.49c4Dnm508@diego>
References: <3086962.49c4Dnm508@diego>
Message-ID: <29291825.rqOIHNJZsg@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3288 is the first Rockchip soc handling the drive strength on a per-pin
basis, while the older ones can set the drive-strength only for specific
pin-groups. Therefore limit setting the drive-strength to this soc for now.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-rockchip.c | 112 +++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 58c4647..c15f7f9 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -573,6 +573,98 @@ static void rk3288_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
 	}
 }
 
+#define RK3288_DRV_PMU_OFFSET		0x70
+#define RK3288_DRV_GRF_OFFSET		0x1c0
+#define RK3288_DRV_BITS_PER_PIN		2
+#define RK3288_DRV_PINS_PER_REG		8
+#define RK3288_DRV_BANK_STRIDE		16
+static int rk3288_drv_list[] = { 2, 4, 8, 12 };
+
+static void rk3288_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
+				    int pin_num, struct regmap **regmap,
+				    int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+
+	/* The first 24 pins of the first bank are located in PMU */
+	if (bank->bank_num == 0) {
+		*regmap = info->regmap_pmu;
+		*reg = RK3288_DRV_PMU_OFFSET;
+
+		*reg += ((pin_num / RK3288_DRV_PINS_PER_REG) * 4);
+		*bit = pin_num % RK3288_DRV_PINS_PER_REG;
+		*bit *= RK3288_DRV_BITS_PER_PIN;
+	} else {
+		*regmap = info->regmap_base;
+		*reg = RK3288_DRV_GRF_OFFSET;
+
+		/* correct the offset, as we're starting with the 2nd bank */
+		*reg -= 0x10;
+		*reg += bank->bank_num * RK3288_DRV_BANK_STRIDE;
+		*reg += ((pin_num / RK3288_DRV_PINS_PER_REG) * 4);
+
+		*bit = (pin_num % RK3288_DRV_PINS_PER_REG);
+		*bit *= RK3288_DRV_BITS_PER_PIN;
+	}
+}
+
+static int rk3288_get_drive(struct rockchip_pin_bank *bank, int pin_num)
+{
+	struct regmap *regmap;
+	int reg, ret;
+	u32 data;
+	u8 bit;
+
+	rk3288_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+
+	ret = regmap_read(regmap, reg, &data);
+	if (ret)
+		return ret;
+
+	data >>= bit;
+	data &= (1 << RK3288_DRV_BITS_PER_PIN) - 1;
+
+	return rk3288_drv_list[data];
+}
+
+static int rk3288_set_drive(struct rockchip_pin_bank *bank, int pin_num,
+			    int strength)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+	struct regmap *regmap;
+	unsigned long flags;
+	int reg, ret, i;
+	u32 data;
+	u8 bit;
+
+	rk3288_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
+
+	ret = -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(rk3288_drv_list); i++) {
+		if (rk3288_drv_list[i] == strength) {
+			ret = i;
+			break;
+		}
+	}
+
+	if (ret < 0) {
+		dev_err(info->dev, "unsupported driver strength %d\n",
+			strength);
+		return ret;
+	}
+
+	spin_lock_irqsave(&bank->slock, flags);
+
+	/* enable the write to the equivalent lower bits */
+	data = ((1 << RK3288_DRV_BITS_PER_PIN) - 1) << (bit + 16);
+	data |= (ret << bit);
+
+	ret = regmap_write(regmap, reg, data);
+	spin_unlock_irqrestore(&bank->slock, flags);
+
+	return ret;
+}
+
 static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
 {
 	struct rockchip_pinctrl *info = bank->drvdata;
@@ -888,6 +980,15 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			if (rc)
 				return rc;
 			break;
+		case PIN_CONFIG_DRIVE_STRENGTH:
+			/* rk3288 is the first with per-pin drive-strength */
+			if (info->ctrl->type != RK3288)
+				return -ENOTSUPP;
+
+			rc = rk3288_set_drive(bank, pin - bank->pin_base, arg);
+			if (rc < 0)
+				return rc;
+			break;
 		default:
 			return -ENOTSUPP;
 			break;
@@ -937,6 +1038,17 @@ static int rockchip_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		arg = rc ? 1 : 0;
 		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		/* rk3288 is the first with per-pin drive-strength */
+		if (info->ctrl->type != RK3288)
+			return -ENOTSUPP;
+
+		rc = rk3288_get_drive(bank, pin - bank->pin_base);
+		if (rc < 0)
+			return rc;
+
+		arg = rc;
+		break;
 	default:
 		return -ENOTSUPP;
 		break;
-- 
1.9.0
