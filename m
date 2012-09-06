From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  6 Sep 2012 17:00:47 -0600
Subject: [PATCH V2] ARM: dt: tegra: harmony: add regulators
Message-ID: <1346972447-7096-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laxman Dewangan <ldewangan@nvidia.com>

Harmony uses a TPS6586x regulator. Instantiate this, and hook up a
couple of fixed GPIO-controlled regulators too.

Based on Ventana regulator patch by Stephen Warren <swarren@nvidia.com>
and converted to Harmony.

swarren made the following changes:
* Added ldo0 regulator configuration to device tree, and updated
  board-harmony-pcie.c for the new regulator name.
* Fixed vdd_1v05's voltage from 10.5V to 1.05V.
* Modified board-harmony-pcie.c to obtain the en_vdd_1v05 GPIO number at
  run-time from device tree instead of hard-coding it.
* Removed board-harmony{-power.c,.h} now that they're unused.
* Disabled vdd_1v05 regulator; the code in board-harmony-pcie.c hijacks
  this GPIO for now. This will be fixed when the PCIe driver is re-
  written as a driver. The code can't regulator_get("vdd_1v05") right
  now, because the vdd_1v05 regulator's probe gets deferred due to its
  supply being the PMIC, which gets probed after the regulator the first
  time around, and this dependency is only resolved by repeated probing,
  which happens when deferred_probe_initcall() is called, which happens
  in a late initcall, whose runtime order relative to harmony_pcie_init()
  is undefined, since that's also called from a late initcall.
* Removed unused harmony_pcie_initcall().

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Implemented or fixed most of the bullet points listed in the commit
description.
---
 arch/arm/boot/dts/tegra20-harmony.dts     |  218 +++++++++++++++++++++++++++++
 arch/arm/mach-tegra/Makefile              |    1 -
 arch/arm/mach-tegra/board-dt-tegra20.c    |    9 +-
 arch/arm/mach-tegra/board-harmony-pcie.c  |   49 ++++---
 arch/arm/mach-tegra/board-harmony-power.c |  152 --------------------
 arch/arm/mach-tegra/board-harmony.h       |   28 ----
 6 files changed, 249 insertions(+), 208 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/board-harmony-power.c
 delete mode 100644 arch/arm/mach-tegra/board-harmony.h

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index f146dbf..0eca40d 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -275,6 +275,158 @@
 	i2c at 7000d000 {
 		status = "okay";
 		clock-frequency = <400000>;
+
+		pmic: tps6586x at 34 {
+			compatible = "ti,tps6586x";
+			reg = <0x34>;
+			interrupts = <0 86 0x4>;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			sys-supply = <&vdd_5v0_reg>;
+			vin-sm0-supply = <&sys_reg>;
+			vin-sm1-supply = <&sys_reg>;
+			vin-sm2-supply = <&sys_reg>;
+			vinldo01-supply = <&sm2_reg>;
+			vinldo23-supply = <&sm2_reg>;
+			vinldo4-supply = <&sm2_reg>;
+			vinldo678-supply = <&sm2_reg>;
+			vinldo9-supply = <&sm2_reg>;
+
+			regulators {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				sys_reg: regulator at 0 {
+					reg = <0>;
+					regulator-compatible = "sys";
+					regulator-name = "vdd_sys";
+					regulator-always-on;
+				};
+
+				regulator at 1 {
+					reg = <1>;
+					regulator-compatible = "sm0";
+					regulator-name = "vdd_sm0,vdd_core";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+				};
+
+				regulator at 2 {
+					reg = <2>;
+					regulator-compatible = "sm1";
+					regulator-name = "vdd_sm1,vdd_cpu";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+				};
+
+				sm2_reg: regulator at 3 {
+					reg = <3>;
+					regulator-compatible = "sm2";
+					regulator-name = "vdd_sm2,vin_ldo*";
+					regulator-min-microvolt = <3700000>;
+					regulator-max-microvolt = <3700000>;
+					regulator-always-on;
+				};
+
+				regulator at 4 {
+					reg = <4>;
+					regulator-compatible = "ldo0";
+					regulator-name = "vdd_ldo0,vddio_pex_clk";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				regulator at 5 {
+					reg = <5>;
+					regulator-compatible = "ldo1";
+					regulator-name = "vdd_ldo1,avdd_pll*";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+					regulator-always-on;
+				};
+
+				regulator at 6 {
+					reg = <6>;
+					regulator-compatible = "ldo2";
+					regulator-name = "vdd_ldo2,vdd_rtc";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+
+				regulator at 7 {
+					reg = <7>;
+					regulator-compatible = "ldo3";
+					regulator-name = "vdd_ldo3,avdd_usb*";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+
+				regulator at 8 {
+					reg = <8>;
+					regulator-compatible = "ldo4";
+					regulator-name = "vdd_ldo4,avdd_osc,vddio_sys";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				regulator at 9 {
+					reg = <9>;
+					regulator-compatible = "ldo5";
+					regulator-name = "vdd_ldo5,vcore_mmc";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					regulator-always-on;
+				};
+
+				regulator at 10 {
+					reg = <10>;
+					regulator-compatible = "ldo6";
+					regulator-name = "vdd_ldo6,avdd_vdac";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				regulator at 11 {
+					reg = <11>;
+					regulator-compatible = "ldo7";
+					regulator-name = "vdd_ldo7,avdd_hdmi,vdd_fuse";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				regulator at 12 {
+					reg = <12>;
+					regulator-compatible = "ldo8";
+					regulator-name = "vdd_ldo8,avdd_hdmi_pll";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				regulator at 13 {
+					reg = <13>;
+					regulator-compatible = "ldo9";
+					regulator-name = "vdd_ldo9,avdd_2v85,vdd_ddr_rx";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					regulator-always-on;
+				};
+
+				regulator at 14 {
+					reg = <14>;
+					regulator-compatible = "ldo_rtc";
+					regulator-name = "vdd_rtc_out,vdd_cell";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+			};
+		};
 	};
 
 	pmc {
@@ -310,6 +462,72 @@
 		bus-width = <8>;
 	};
 
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdd_5v0_reg: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "vdd_5v0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+
+		regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "vdd_1v5";
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <1500000>;
+			gpio = <&pmic 0 0>;
+		};
+
+		regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "vdd_1v2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			gpio = <&pmic 1 0>;
+			enable-active-high;
+		};
+
+		regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "vdd_1v05";
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+			gpio = <&pmic 2 0>;
+			enable-active-high;
+			/* Hack until board-harmony-pcie.c is removed */
+			status = "disabled";
+		};
+
+		regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "vdd_pnl";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			gpio = <&gpio 22 0>; /* gpio PC6 */
+			enable-active-high;
+		};
+
+		regulator at 5 {
+			compatible = "regulator-fixed";
+			reg = <5>;
+			regulator-name = "vdd_bl";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			gpio = <&gpio 176 0>; /* gpio PW0 */
+			enable-active-high;
+		};
+	};
+
 	sound {
 		compatible = "nvidia,tegra-audio-wm8903-harmony",
 			     "nvidia,tegra-audio-wm8903";
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index b94858f..d8e6fe9 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -31,6 +31,5 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-dt-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-dt-tegra30.o
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-harmony-pcie.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-harmony-power.o
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-paz00.o
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index d9eeae6..5957ffb 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -42,7 +42,6 @@
 #include <mach/irqs.h>
 
 #include "board.h"
-#include "board-harmony.h"
 #include "clock.h"
 #include "devices.h"
 
@@ -109,15 +108,9 @@ static void __init trimslice_init(void)
 
 static void __init harmony_init(void)
 {
+#ifdef CONFIG_TEGRA_PCI
 	int ret;
 
-	ret = harmony_regulator_init();
-	if (ret) {
-		pr_err("harmony_regulator_init() failed: %d\n", ret);
-		return;
-	}
-
-#ifdef CONFIG_TEGRA_PCI
 	ret = harmony_pcie_init();
 	if (ret)
 		pr_err("harmony_pcie_init() failed: %d\n", ret);
diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
index e8c3fda..3cdc1bb 100644
--- a/arch/arm/mach-tegra/board-harmony-pcie.c
+++ b/arch/arm/mach-tegra/board-harmony-pcie.c
@@ -18,35 +18,57 @@
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <linux/err.h>
+#include <linux/of_gpio.h>
 #include <linux/regulator/consumer.h>
 
 #include <asm/mach-types.h>
 
 #include "board.h"
-#include "board-harmony.h"
 
 #ifdef CONFIG_TEGRA_PCI
 
 int __init harmony_pcie_init(void)
 {
+	struct device_node *np;
+	int en_vdd_1v05;
 	struct regulator *regulator = NULL;
 	int err;
 
-	err = gpio_request(TEGRA_GPIO_EN_VDD_1V05_GPIO, "EN_VDD_1V05");
-	if (err)
+	np = of_find_node_by_path("/regulators/regulator at 3");
+	if (!np) {
+		pr_err("%s: of_find_node_by_path failed\n", __func__);
+		return -ENODEV;
+	}
+
+	en_vdd_1v05 = of_get_named_gpio(np, "gpio", 0);
+	if (en_vdd_1v05 < 0) {
+		pr_err("%s: of_get_named_gpio failed: %d\n", __func__,
+		       en_vdd_1v05);
+		return en_vdd_1v05;
+	}
+
+	err = gpio_request(en_vdd_1v05, "EN_VDD_1V05");
+	if (err) {
+		pr_err("%s: gpio_request failed: %d\n", __func__, err);
 		return err;
+	}
 
-	gpio_direction_output(TEGRA_GPIO_EN_VDD_1V05_GPIO, 1);
+	gpio_direction_output(en_vdd_1v05, 1);
 
-	regulator = regulator_get(NULL, "pex_clk");
-	if (IS_ERR_OR_NULL(regulator))
+	regulator = regulator_get(NULL, "vdd_ldo0,vddio_pex_clk");
+	if (IS_ERR_OR_NULL(regulator)) {
+		pr_err("%s: regulator_get failed: %d\n", __func__,
+		       (int)PTR_ERR(regulator));
 		goto err_reg;
+	}
 
 	regulator_enable(regulator);
 
 	err = tegra_pcie_init(true, true);
-	if (err)
+	if (err) {
+		pr_err("%s: tegra_pcie_init failed: %d\n", __func__, err);
 		goto err_pcie;
+	}
 
 	return 0;
 
@@ -54,20 +76,9 @@ err_pcie:
 	regulator_disable(regulator);
 	regulator_put(regulator);
 err_reg:
-	gpio_free(TEGRA_GPIO_EN_VDD_1V05_GPIO);
+	gpio_free(en_vdd_1v05);
 
 	return err;
 }
 
-static int __init harmony_pcie_initcall(void)
-{
-	if (!machine_is_harmony())
-		return 0;
-
-	return harmony_pcie_init();
-}
-
-/* PCI should be initialized after I2C, mfd and regulators */
-subsys_initcall_sync(harmony_pcie_initcall);
-
 #endif
diff --git a/arch/arm/mach-tegra/board-harmony-power.c b/arch/arm/mach-tegra/board-harmony-power.c
deleted file mode 100644
index fddfb82..0000000
--- a/arch/arm/mach-tegra/board-harmony-power.c
+++ /dev/null
@@ -1,152 +0,0 @@
-/*
- * Copyright (C) 2010 NVIDIA, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
- * 02111-1307, USA
- */
-#include <linux/i2c.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/fixed.h>
-#include <linux/mfd/tps6586x.h>
-#include <linux/of.h>
-#include <linux/of_i2c.h>
-
-#include <asm/mach-types.h>
-
-#include <mach/irqs.h>
-
-#include "board-harmony.h"
-
-static struct regulator_consumer_supply tps658621_ldo0_supply[] = {
-	REGULATOR_SUPPLY("pex_clk", NULL),
-};
-
-static struct regulator_init_data ldo0_data = {
-	.supply_regulator = "vdd_sm2",
-	.constraints = {
-		.name = "vdd_ldo0",
-		.min_uV = 3300 * 1000,
-		.max_uV = 3300 * 1000,
-		.valid_modes_mask = (REGULATOR_MODE_NORMAL |
-				     REGULATOR_MODE_STANDBY),
-		.valid_ops_mask = (REGULATOR_CHANGE_MODE |
-				   REGULATOR_CHANGE_STATUS |
-				   REGULATOR_CHANGE_VOLTAGE),
-		.apply_uV = 1,
-	},
-	.num_consumer_supplies = ARRAY_SIZE(tps658621_ldo0_supply),
-	.consumer_supplies = tps658621_ldo0_supply,
-};
-
-#define HARMONY_REGULATOR_INIT(_id, _name, _supply, _minmv, _maxmv, _on)\
-	static struct regulator_init_data _id##_data = {		\
-		.supply_regulator = _supply,				\
-		.constraints = {					\
-			.name = _name,					\
-			.min_uV = (_minmv)*1000,			\
-			.max_uV = (_maxmv)*1000,			\
-			.valid_modes_mask = (REGULATOR_MODE_NORMAL |	\
-					     REGULATOR_MODE_STANDBY),	\
-			.valid_ops_mask = (REGULATOR_CHANGE_MODE |	\
-					   REGULATOR_CHANGE_STATUS |	\
-					   REGULATOR_CHANGE_VOLTAGE),	\
-			.always_on = _on,				\
-		},							\
-	}
-
-static struct regulator_init_data sys_data = {
-	.supply_regulator = "vdd_5v0",
-	.constraints = {
-		.name = "vdd_sys",
-	},
-};
-
-HARMONY_REGULATOR_INIT(sm0,  "vdd_sm0",  "vdd_sys", 725, 1500, 1);
-HARMONY_REGULATOR_INIT(sm1,  "vdd_sm1",  "vdd_sys", 725, 1500, 1);
-HARMONY_REGULATOR_INIT(sm2,  "vdd_sm2",  "vdd_sys", 3000, 4550, 1);
-HARMONY_REGULATOR_INIT(ldo1, "vdd_ldo1", "vdd_sm2", 725, 1500, 1);
-HARMONY_REGULATOR_INIT(ldo2, "vdd_ldo2", "vdd_sm2", 725, 1500, 0);
-HARMONY_REGULATOR_INIT(ldo3, "vdd_ldo3", "vdd_sm2", 1250, 3300, 1);
-HARMONY_REGULATOR_INIT(ldo4, "vdd_ldo4", "vdd_sm2", 1700, 2475, 1);
-HARMONY_REGULATOR_INIT(ldo5, "vdd_ldo5", "vdd_sys", 1250, 3300, 1);
-HARMONY_REGULATOR_INIT(ldo6, "vdd_ldo6", "vdd_sm2", 1250, 3300, 0);
-HARMONY_REGULATOR_INIT(ldo7, "vdd_ldo7", "vdd_sm2", 1250, 3300, 0);
-HARMONY_REGULATOR_INIT(ldo8, "vdd_ldo8", "vdd_sm2", 1250, 3300, 0);
-HARMONY_REGULATOR_INIT(ldo9, "vdd_ldo9", "vdd_sm2", 1250, 3300, 1);
-
-#define TPS_REG(_id, _data)			\
-	{					\
-		.id = TPS6586X_ID_##_id,	\
-		.name = "tps6586x-regulator",	\
-		.platform_data = _data,		\
-	}
-
-static struct tps6586x_subdev_info tps_devs[] = {
-	TPS_REG(SYS, &sys_data),
-	TPS_REG(SM_0, &sm0_data),
-	TPS_REG(SM_1, &sm1_data),
-	TPS_REG(SM_2, &sm2_data),
-	TPS_REG(LDO_0, &ldo0_data),
-	TPS_REG(LDO_1, &ldo1_data),
-	TPS_REG(LDO_2, &ldo2_data),
-	TPS_REG(LDO_3, &ldo3_data),
-	TPS_REG(LDO_4, &ldo4_data),
-	TPS_REG(LDO_5, &ldo5_data),
-	TPS_REG(LDO_6, &ldo6_data),
-	TPS_REG(LDO_7, &ldo7_data),
-	TPS_REG(LDO_8, &ldo8_data),
-	TPS_REG(LDO_9, &ldo9_data),
-};
-
-static struct tps6586x_platform_data tps_platform = {
-	.irq_base	= TEGRA_NR_IRQS,
-	.num_subdevs	= ARRAY_SIZE(tps_devs),
-	.subdevs	= tps_devs,
-	.gpio_base	= HARMONY_GPIO_TPS6586X(0),
-};
-
-static struct i2c_board_info __initdata harmony_regulators[] = {
-	{
-		I2C_BOARD_INFO("tps6586x", 0x34),
-		.irq		= INT_EXTERNAL_PMU,
-		.platform_data	= &tps_platform,
-	},
-};
-
-int __init harmony_regulator_init(void)
-{
-	struct device_node *np;
-	struct i2c_adapter *adapter;
-
-	regulator_register_always_on(0, "vdd_5v0",
-		NULL, 0, 5000000);
-
-	np = of_find_node_by_path("/i2c at 7000d000");
-	if (np == NULL) {
-		pr_err("Could not find device_node for DVC I2C\n");
-		return -ENODEV;
-	}
-
-	adapter = of_find_i2c_adapter_by_node(np);
-	if (!adapter) {
-		pr_err("Could not find i2c_adapter for DVC I2C\n");
-		return -ENODEV;
-	}
-
-	i2c_new_device(adapter, harmony_regulators);
-
-	return 0;
-}
diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
deleted file mode 100644
index 7ae8708..0000000
--- a/arch/arm/mach-tegra/board-harmony.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * arch/arm/mach-tegra/board-harmony.h
- *
- * Copyright (C) 2010 Google, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef _MACH_TEGRA_BOARD_HARMONY_H
-#define _MACH_TEGRA_BOARD_HARMONY_H
-
-#include <mach/gpio-tegra.h>
-
-#define HARMONY_GPIO_TPS6586X(_x_)	(TEGRA_NR_GPIOS + (_x_))
-
-#define TEGRA_GPIO_EN_VDD_1V05_GPIO	HARMONY_GPIO_TPS6586X(2)
-
-int harmony_regulator_init(void);
-
-#endif
-- 
1.7.0.4
