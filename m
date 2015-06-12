From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 12 Jun 2015 23:51:01 +0200
Subject: [PATCH 2/2] pinctrl: rockchip: add support for the rk3368
In-Reply-To: <2322857.kblfsanYOB@diego>
References: <2322857.kblfsanYOB@diego>
Message-ID: <6672678.KPGUcFJOAs@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3368 is the first ARM64 soc from Rockchip, but seems to share most
peripherals with the ARM32 soc, including the pinctrl functionality.
The only notable difference is - as with every Rockchip soc - that the
offsets in the General Register Files moved around and a split of the pmu
section of the rk3288 into pmu and pmugrf (pmu general register files)
sections. The pinctrl driver of course only needs the pmugrf registers
for controlling the pin settings.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/pinctrl/rockchip,pinctrl.txt          |  5 +-
 drivers/pinctrl/pinctrl-rockchip.c                 | 91 ++++++++++++++++++++++
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
index 388b213..391ef4b 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
@@ -21,14 +21,15 @@ defined as gpio sub-nodes of the pinmux controller.
 Required properties for iomux controller:
   - compatible: one of "rockchip,rk2928-pinctrl", "rockchip,rk3066a-pinctrl"
 		       "rockchip,rk3066b-pinctrl", "rockchip,rk3188-pinctrl"
-		       "rockchip,rk3288-pinctrl"
+		       "rockchip,rk3288-pinctrl", "rockchip,rk3368-pinctrl"
   - rockchip,grf: phandle referencing a syscon providing the
 	 "general register files"
 
 Optional properties for iomux controller:
   - rockchip,pmu: phandle referencing a syscon providing the pmu registers
 	 as some SoCs carry parts of the iomux controller registers there.
-	 Required for at least rk3188 and rk3288.
+	 Required for at least rk3188 and rk3288. On the rk3368 this should
+	 point to the PMUGRF syscon.
 
 Deprecated properties for iomux controller:
   - reg: first element is the general register space of the iomux controller
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 70423ae..7234125 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -63,6 +63,7 @@ enum rockchip_pinctrl_type {
 	RK3066B,
 	RK3188,
 	RK3288,
+	RK3368,
 };
 
 /**
@@ -613,6 +614,68 @@ static void rk3288_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 	}
 }
 
+#define RK3368_PULL_GRF_OFFSET		0x100
+#define RK3368_PULL_PMU_OFFSET		0x10
+
+static void rk3368_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
+				    int pin_num, struct regmap **regmap,
+				    int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+
+	/* The first 32 pins of the first bank are located in PMU */
+	if (bank->bank_num == 0) {
+		*regmap = info->regmap_pmu;
+		*reg = RK3368_PULL_PMU_OFFSET;
+
+		*reg += ((pin_num / RK3188_PULL_PINS_PER_REG) * 4);
+		*bit = pin_num % RK3188_PULL_PINS_PER_REG;
+		*bit *= RK3188_PULL_BITS_PER_PIN;
+	} else {
+		*regmap = info->regmap_base;
+		*reg = RK3368_PULL_GRF_OFFSET;
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
+#define RK3368_DRV_PMU_OFFSET		0x20
+#define RK3368_DRV_GRF_OFFSET		0x200
+
+static void rk3368_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
+				    int pin_num, struct regmap **regmap,
+				    int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+
+	/* The first 32 pins of the first bank are located in PMU */
+	if (bank->bank_num == 0) {
+		*regmap = info->regmap_pmu;
+		*reg = RK3368_DRV_PMU_OFFSET;
+
+		*reg += ((pin_num / RK3288_DRV_PINS_PER_REG) * 4);
+		*bit = pin_num % RK3288_DRV_PINS_PER_REG;
+		*bit *= RK3288_DRV_BITS_PER_PIN;
+	} else {
+		*regmap = info->regmap_base;
+		*reg = RK3368_DRV_GRF_OFFSET;
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
 static int rockchip_perpin_drv_list[] = { 2, 4, 8, 12 };
 
 static int rockchip_get_drive_perpin(struct rockchip_pin_bank *bank,
@@ -703,6 +766,7 @@ static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
 				: PIN_CONFIG_BIAS_DISABLE;
 	case RK3188:
 	case RK3288:
+	case RK3368:
 		data >>= bit;
 		data &= (1 << RK3188_PULL_BITS_PER_PIN) - 1;
 
@@ -758,6 +822,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 		break;
 	case RK3188:
 	case RK3288:
+	case RK3368:
 		spin_lock_irqsave(&bank->slock, flags);
 
 		/* enable the write to the equivalent lower bits */
@@ -935,6 +1000,7 @@ static bool rockchip_pinconf_pull_valid(struct rockchip_pin_ctrl *ctrl,
 		return pull ? false : true;
 	case RK3188:
 	case RK3288:
+	case RK3368:
 		return (pull != PIN_CONFIG_BIAS_PULL_PIN_DEFAULT);
 	}
 
@@ -2068,6 +2134,29 @@ static struct rockchip_pin_ctrl rk3288_pin_ctrl = {
 		.drv_calc_reg		= rk3288_calc_drv_reg_and_bit,
 };
 
+static struct rockchip_pin_bank rk3368_pin_banks[] = {
+	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", IOMUX_SOURCE_PMU,
+					     IOMUX_SOURCE_PMU,
+					     IOMUX_SOURCE_PMU,
+					     IOMUX_SOURCE_PMU
+			    ),
+	PIN_BANK(1, 32, "gpio1"),
+	PIN_BANK(2, 32, "gpio2"),
+	PIN_BANK(3, 32, "gpio3"),
+};
+
+static struct rockchip_pin_ctrl rk3368_pin_ctrl = {
+		.pin_banks		= rk3368_pin_banks,
+		.nr_banks		= ARRAY_SIZE(rk3368_pin_banks),
+		.label			= "RK3368-GPIO",
+		.type			= RK3368,
+		.grf_mux_offset		= 0x0,
+		.pmu_mux_offset		= 0x0,
+		.pull_calc_reg		= rk3368_calc_pull_reg_and_bit,
+		.drv_calc_reg		= rk3368_calc_drv_reg_and_bit,
+};
+
+
 static const struct of_device_id rockchip_pinctrl_dt_match[] = {
 	{ .compatible = "rockchip,rk2928-pinctrl",
 		.data = (void *)&rk2928_pin_ctrl },
@@ -2079,6 +2168,8 @@ static const struct of_device_id rockchip_pinctrl_dt_match[] = {
 		.data = (void *)&rk3188_pin_ctrl },
 	{ .compatible = "rockchip,rk3288-pinctrl",
 		.data = (void *)&rk3288_pin_ctrl },
+	{ .compatible = "rockchip,rk3368-pinctrl",
+		.data = (void *)&rk3368_pin_ctrl },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rockchip_pinctrl_dt_match);
-- 
2.1.4
