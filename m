From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed,  2 Aug 2017 16:40:17 +0800
Subject: [PATCH v2 10/23] pinctrl: rockchip: add schmitt input mode support
 for rv1108
In-Reply-To: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1501663217-12255-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some pins like i2c SCL/SDA need the schmitt input function
to avoid crosstalk problems.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

Changes in v2: None

 drivers/pinctrl/pinctrl-rockchip.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index e831647..868cb9c 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -1084,6 +1084,36 @@ static void rv1108_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 	*bit *= RV1108_DRV_BITS_PER_PIN;
 }
 
+#define RV1108_SCHMITT_PMU_OFFSET		0x30
+#define RV1108_SCHMITT_GRF_OFFSET		0x388
+#define RV1108_SCHMITT_BANK_STRIDE		8
+#define RV1108_SCHMITT_PINS_PER_GRF_REG		16
+#define RV1108_SCHMITT_PINS_PER_PMU_REG		8
+
+static int rv1108_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
+					   int pin_num,
+					   struct regmap **regmap,
+					   int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+	int pins_per_reg;
+
+	if (bank->bank_num == 0) {
+		*regmap = info->regmap_pmu;
+		*reg = RV1108_SCHMITT_PMU_OFFSET;
+		pins_per_reg = RV1108_SCHMITT_PINS_PER_PMU_REG;
+	} else {
+		*regmap = info->regmap_base;
+		*reg = RV1108_SCHMITT_GRF_OFFSET;
+		pins_per_reg = RV1108_SCHMITT_PINS_PER_GRF_REG;
+		*reg += (bank->bank_num  - 1) * RV1108_SCHMITT_BANK_STRIDE;
+	}
+	*reg += ((pin_num / pins_per_reg) * 4);
+	*bit = pin_num % pins_per_reg;
+
+	return 0;
+}
+
 #define RK2928_PULL_OFFSET		0x118
 #define RK2928_PULL_PINS_PER_REG	16
 #define RK2928_PULL_BANK_STRIDE		8
@@ -3017,6 +3047,7 @@ static struct rockchip_pin_ctrl rv1108_pin_ctrl = {
 	.pmu_mux_offset		= 0x0,
 	.pull_calc_reg		= rv1108_calc_pull_reg_and_bit,
 	.drv_calc_reg		= rv1108_calc_drv_reg_and_bit,
+	.schmitt_calc_reg	= rv1108_calc_schmitt_reg_and_bit,
 };
 
 static struct rockchip_pin_bank rk2928_pin_banks[] = {
-- 
2.7.4
