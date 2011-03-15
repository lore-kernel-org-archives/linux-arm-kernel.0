From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 15 Mar 2011 15:56:33 +0900
Subject: [PATCH] ARM: EXYNOS4 NURI: Add MAX8997 support (MFD+Regulator+RTC)
Message-ID: <1300172193-8307-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support of MAX8997 for NURI boards. MAX8997 is an MFD
including PMIC, RTC, HAPTIC, and others. In this patch, support for MFD,
Regulators, and RTC is included. However, the support for IRQ is not
included in this patch, as at this point, MAX8997 IRQ patch is not
applied and it is not separated by Kconfig.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/Makefile             |    1 +
 arch/arm/mach-exynos4/mach-nuri.c          |   13 +-
 arch/arm/mach-exynos4/setup-max8997-nuri.c |  693 ++++++++++++++++++++++++++++
 arch/arm/mach-exynos4/setup-max8997.h      |   26 +
 4 files changed, 732 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/setup-max8997-nuri.c
 create mode 100644 arch/arm/mach-exynos4/setup-max8997.h

diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 56e367b..7827e31 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_MACH_SMDKV310)		+= mach-smdkv310.o
 obj-$(CONFIG_MACH_ARMLEX4210)		+= mach-armlex4210.o
 obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
 obj-$(CONFIG_MACH_NURI)			+= mach-nuri.o
+obj-$(CONFIG_MFD_MAX8997)		+= setup-max8997-nuri.o
 
 # device support
 
diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index b79ad01..838cd5c 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -32,6 +32,7 @@
 #include <plat/sdhci.h>
 
 #include <mach/map.h>
+#include "setup-max8997.h"
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define NURI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -258,8 +259,16 @@ static struct i2c_board_info i2c1_devs[] __initdata = {
 };
 
 /* GPIO I2C 5 (PMIC) */
+#ifdef CONFIG_MFD_MAX8997
+enum {	I2C5_MAX8997,	};
+#endif
 static struct i2c_board_info i2c5_devs[] __initdata = {
-	/* max8997, To be updated */
+#ifdef CONFIG_MFD_MAX8997
+	[I2C5_MAX8997] = {
+		I2C_BOARD_INFO("max8997", 0xCC >> 1),
+		.platform_data = &nuri_max8997_pdata,
+	},
+#endif
 };
 
 static struct platform_device *nuri_devices[] __initdata = {
@@ -286,9 +295,11 @@ static void __init nuri_map_io(void)
 
 static void __init nuri_machine_init(void)
 {
+	nuri_pmic_max8997_init();
 	nuri_sdhci_init();
 
 	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
+	i2c5_devs[I2C5_MAX8997].irq = gpio_to_irq(EXYNOS4_GPX0(7));
 	i2c_register_board_info(5, i2c5_devs, ARRAY_SIZE(i2c5_devs));
 
 	/* Last */
diff --git a/arch/arm/mach-exynos4/setup-max8997-nuri.c b/arch/arm/mach-exynos4/setup-max8997-nuri.c
new file mode 100644
index 0000000..3b1bd71
--- /dev/null
+++ b/arch/arm/mach-exynos4/setup-max8997-nuri.c
@@ -0,0 +1,693 @@
+/*
+ * linux/arch/arm/mach-exynos4/setup-max8997-nuri.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ * MyungJoo Ham <myungjoo.ham@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This file is to support max8997 for Nuri.
+ */
+
+#include <linux/gpio.h>
+#include <linux/mfd/max8997.h>
+#include <linux/regulator/machine.h>
+
+#include <plat/gpio-cfg.h>
+
+void __init nuri_pmic_max8997_init(void)
+{
+	int gpio = EXYNOS4_GPX0(7);
+	gpio_request(gpio, "AP_PMIC_IRQ");
+	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
+	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+}
+
+#ifdef CONFIG_REGULATOR_MAX8997
+static struct regulator_consumer_supply nuri_max8997_ldo1_consumer[] = {
+	REGULATOR_SUPPLY("vadc", NULL),
+};
+static struct regulator_consumer_supply nuri_max8997_ldo3_consumer[] = {
+	REGULATOR_SUPPLY("vusb_a", NULL),
+	REGULATOR_SUPPLY("vmipi_1.1v", NULL),
+	REGULATOR_SUPPLY("vdd11", "mipi"),
+};
+static struct regulator_consumer_supply nuri_max8997_ldo4_consumer[] = {
+	REGULATOR_SUPPLY("vmipi_1.8V", NULL),
+	REGULATOR_SUPPLY("vdd18", "mipi"),
+	REGULATOR_SUPPLY("mipi_csi", "s5p-mipi-csis.0"),
+};
+static struct regulator_consumer_supply nuri_max8997_ldo5_consumer[] = {
+	REGULATOR_SUPPLY("vhsic", NULL),
+};
+static struct regulator_consumer_supply nuri_max8997_ldo7_consumer[] = {
+	REGULATOR_SUPPLY("dig_18", "0-001f"),
+};
+static struct regulator_consumer_supply nuri_max8997_ldo8_consumer[] = {
+	REGULATOR_SUPPLY("vusb_d", NULL),
+	REGULATOR_SUPPLY("vdac", NULL),
+};
+static struct regulator_consumer_supply nuri_max8997_ldo10_consumer[] = {
+	REGULATOR_SUPPLY("vpll", NULL),
+};
+static struct regulator_consumer_supply nuri_max8997_ldo11_consumer[] = {
+	REGULATOR_SUPPLY("lvds_3.3v", "platform-lcd"),
+};
+static struct regulator_consumer_supply nuri_max8997_ldo12_consumer[] = {
+	REGULATOR_SUPPLY("vddio", "6-003c"),
+};
+static struct regulator_consumer_supply nuri_max8997_ldo13_consumer[] = {
+	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.2"),
+};
+static struct regulator_consumer_supply nuri_max8997_ldo14_consumer[] = {
+	REGULATOR_SUPPLY("inmotor", "max8997-haptic"),
+};
+static struct regulator_consumer_supply nuri_max8997_ldo15_consumer[] = {
+	REGULATOR_SUPPLY("avdd", "3-004a"), /* Touch Screen's AVDD */
+};
+static struct regulator_consumer_supply nuri_max8997_ldo16_consumer[] = {
+	REGULATOR_SUPPLY("d_sensor", "0-001f"), /* Touch Screen's AVDD */
+};
+static struct regulator_consumer_supply nuri_max8997_ldo18_consumer[] = {
+	REGULATOR_SUPPLY("vdd", "3-004a"), /* Touch Screen's VDD and I2C */
+};
+
+static struct regulator_consumer_supply nuri_max8997_buck1_consumer[] = {
+	REGULATOR_SUPPLY("vdd_arm", NULL),
+};
+static struct regulator_consumer_supply nuri_max8997_buck2_consumer[] = {
+	REGULATOR_SUPPLY("vdd_int", NULL),
+};
+static struct regulator_consumer_supply nuri_max8997_buck3_consumer[] = {
+	REGULATOR_SUPPLY("vg3d", "mali_dev.0"),
+};
+static struct regulator_consumer_supply nuri_max8997_buck4_consumer[] = {
+	REGULATOR_SUPPLY("core", "0-001f"),
+};
+static struct regulator_consumer_supply nuri_max8997_buck6_consumer[] = {
+	REGULATOR_SUPPLY("dig_28", "0-001f"),
+};
+static struct regulator_consumer_supply nuri_max8997_buck7_consumer[] = {
+	REGULATOR_SUPPLY("vcc_sub_2.0v", "0-003c"),
+};
+
+static struct regulator_consumer_supply nuri_max8997_esafeout1_consumer[] = {
+	REGULATOR_SUPPLY("usb_vbus_ap_5v", NULL),
+};
+static struct regulator_consumer_supply nuri_max8997_esafeout2_consumer[] = {
+	REGULATOR_SUPPLY("usb_vbus_cp_5v", NULL),
+};
+
+static struct regulator_consumer_supply nuri_max8997_charger_consumer[] = {
+	REGULATOR_SUPPLY("vinchg", "charger-manager"),
+};
+static struct regulator_consumer_supply nuri_max8997_chg_topoff_consumer[] = {
+	REGULATOR_SUPPLY("vinchg_stop", NULL),
+};
+
+static struct regulator_consumer_supply nuri_max8997_32khz_ap_consumer[] = {
+	REGULATOR_SUPPLY("gps_clk", NULL),
+	REGULATOR_SUPPLY("bt_clk", NULL),
+	REGULATOR_SUPPLY("wifi_clk", NULL),
+};
+
+static struct regulator_init_data nuri_max8997_ldo1_data = {
+	.constraints	= {
+		.name		= "VADC_3.3V_C210",
+		.min_uV		= 3300000,
+		.max_uV		= 3300000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.enabled	= 0,
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo1_consumer),
+	.consumer_supplies	= nuri_max8997_ldo1_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_ldo2_data = {
+	.constraints	= {
+		.name		= "VALIVE_1.1V_C210",
+		.min_uV		= 1100000,
+		.max_uV		= 1100000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled	= 1,
+			.disabled	= 0,
+		},
+	},
+};
+
+static struct regulator_init_data nuri_max8997_ldo3_data = {
+	.constraints	= {
+		.name		= "VUSB_1.1V_C210",
+		.min_uV		= 1100000,
+		.max_uV		= 1100000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.enabled	= 0,
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo3_consumer),
+	.consumer_supplies	= nuri_max8997_ldo3_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_ldo4_data = {
+	.constraints	= {
+		.name		= "VMIPI_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.enabled	= 0,
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo4_consumer),
+	.consumer_supplies	= nuri_max8997_ldo4_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_ldo5_data = {
+	.constraints	= {
+		.name		= "VHSIC_1.2V_C210",
+		.min_uV		= 1200000,
+		.max_uV		= 1200000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.enabled	= 0,
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo5_consumer),
+	.consumer_supplies	= nuri_max8997_ldo5_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_ldo6_data = {
+	.constraints	= {
+		.name		= "VCC_1.8V_PDA",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled	= 1,
+			.disabled	= 0,
+		},
+	},
+};
+
+static struct regulator_init_data nuri_max8997_ldo7_data = {
+	.constraints	= {
+		.name		= "CAM_ISP_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.enabled	= 0,
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo7_consumer),
+	.consumer_supplies	= nuri_max8997_ldo7_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_ldo8_data = {
+	.constraints	= {
+		.name		= "VUSB/VDAC_3.3V_C210",
+		.min_uV		= 3300000,
+		.max_uV		= 3300000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.enabled = 0,
+			.disabled = 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo8_consumer),
+	.consumer_supplies	= nuri_max8997_ldo8_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_ldo9_data = {
+	.constraints	= {
+		.name		= "VCC_2.8V_PDA",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled	= 1,
+			.disabled	= 0,
+		},
+	},
+};
+
+static struct regulator_init_data nuri_max8997_ldo10_data = {
+	.constraints	= {
+		.name		= "VPLL_1.1V_C210",
+		.min_uV		= 1100000,
+		.max_uV		= 1100000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled	= 0,
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo10_consumer),
+	.consumer_supplies	= nuri_max8997_ldo10_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_ldo11_data = {
+	.constraints	= {
+		.name		= "LVDS_VDD3.3V",
+		.min_uV		= 3300000,
+		.max_uV		= 3300000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.boot_on	= 1,
+		.state_mem	= {
+			.enabled	= 0,
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo11_consumer),
+	.consumer_supplies	= nuri_max8997_ldo11_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_ldo12_data = {
+	.constraints	= {
+		.name		= "VT_CAM_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.enabled = 0,
+			.disabled = 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo12_consumer),
+	.consumer_supplies	= nuri_max8997_ldo12_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_ldo13_data = {
+	.constraints	= {
+		.name		= "VTF_2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.enabled = 0,
+			.disabled = 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo13_consumer),
+	.consumer_supplies	= nuri_max8997_ldo13_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_ldo14_data = {
+	.constraints	= {
+		.name		= "VCC_3.0V_MOTOR",
+		.min_uV		= 3000000,
+		.max_uV		= 3000000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.enabled	= 0,
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo14_consumer),
+	.consumer_supplies	= nuri_max8997_ldo14_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_ldo15_data = {
+	.constraints	= {
+		.name		= "VTOUCH_ADVV2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.apply_uV	= 1,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.state_mem	= {
+			.enabled	= 0,
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo15_consumer),
+	.consumer_supplies	= nuri_max8997_ldo15_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_ldo16_data = {
+	.constraints	= {
+		.name		= "CAM_SENSOR_IO_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.enabled	= 0,
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo16_consumer),
+	.consumer_supplies	= nuri_max8997_ldo16_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_ldo18_data = {
+	.constraints	= {
+		.name		= "VTOUCH_VDD2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.enabled	= 0,
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_ldo18_consumer),
+	.consumer_supplies	= nuri_max8997_ldo18_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_ldo21_data = {
+	.constraints	= {
+		.name		= "VDDQ_M1M2_1.2V",
+		.min_uV		= 1200000,
+		.max_uV		= 1200000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled	= 0,
+			.disabled	= 1,
+		},
+	},
+};
+
+static struct regulator_init_data nuri_max8997_buck1_data = {
+	.constraints	= {
+		.name		= "VARM_1.2V_C210",
+		.min_uV		= 900000,
+		.max_uV		= 1350000,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled = 0,
+			.disabled = 1,
+		},
+	},
+	.num_consumer_supplies = ARRAY_SIZE(nuri_max8997_buck1_consumer),
+	.consumer_supplies = nuri_max8997_buck1_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_buck2_data = {
+	.constraints	= {
+		.name		= "VINT_1.1V_C210",
+		.min_uV		= 900000,
+		.max_uV		= 1100000,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled = 0,
+			.disabled = 1,
+		},
+	},
+	.num_consumer_supplies = ARRAY_SIZE(nuri_max8997_buck2_consumer),
+	.consumer_supplies = nuri_max8997_buck2_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_buck3_data = {
+	.constraints	= {
+		.name		= "VG3D_1.1V_C210",
+		.min_uV		= 900000,
+		.max_uV		= 1100000,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE |
+			REGULATOR_CHANGE_STATUS,
+		.state_mem	= {
+			.enabled = 0,
+			.disabled = 1,
+		},
+	},
+	.num_consumer_supplies = ARRAY_SIZE(nuri_max8997_buck3_consumer),
+	.consumer_supplies = nuri_max8997_buck3_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_buck4_data = {
+	.constraints	= {
+		.name		= "CAM_ISP_CORE_1.2V",
+		.min_uV		= 1200000,
+		.max_uV		= 1200000,
+		.apply_uV	= 1,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.state_mem	= {
+			.enabled = 0,
+			.disabled = 1,
+		},
+	},
+	.num_consumer_supplies = ARRAY_SIZE(nuri_max8997_buck4_consumer),
+	.consumer_supplies = nuri_max8997_buck4_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_buck5_data = {
+	.constraints	= {
+		.name		= "VMEM_1.2V_C210",
+		.min_uV		= 1200000,
+		.max_uV		= 1200000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled = 1,
+			.disabled = 0,
+		},
+	},
+};
+
+static struct regulator_init_data nuri_max8997_buck6_data = {
+	.constraints	= {
+		.name		= "CAM_AF_2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.apply_uV	= 1,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.state_mem	= {
+			.enabled = 0,
+			.disabled = 1,
+		},
+	},
+	.num_consumer_supplies = ARRAY_SIZE(nuri_max8997_buck6_consumer),
+	.consumer_supplies = nuri_max8997_buck6_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_buck7_data = {
+	.constraints	= {
+		.name		= "VCC_SUB_2.0V",
+		.min_uV		= 2000000,
+		.max_uV		= 2000000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled = 1,
+			.disabled = 0,
+		},
+	},
+	/*
+	 * Although this is always on and voltage is fixed, the driver
+	 * wants to ensure that it has the regulator.
+	 */
+	.num_consumer_supplies = ARRAY_SIZE(nuri_max8997_buck7_consumer),
+	.consumer_supplies = nuri_max8997_buck7_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_32khz_ap_data = {
+	.constraints	= {
+		.name		= "32KHz AP",
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled = 1,
+			.disabled = 0,
+		},
+	},
+	/*
+	 * Although this is always on for RTC and voltage is fixed, the drivers
+	 * want to ensure that it has the regulator.
+	 */
+	.num_consumer_supplies = ARRAY_SIZE(nuri_max8997_32khz_ap_consumer),
+	.consumer_supplies = nuri_max8997_32khz_ap_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_32khz_cp_data = {
+	.constraints	= {
+		.name		= "32KHz CP",
+		.state_mem	= {
+			.enabled = 0,
+			.disabled = 1,
+		},
+	},
+};
+
+static struct regulator_init_data nuri_max8997_vichg_data = {
+	.constraints	= {
+		.name		= "VICHG",
+		.state_mem	= {
+			.enabled = 0,
+			.disabled = 1,
+		},
+	},
+};
+
+static struct regulator_init_data nuri_max8997_esafeout1_data = {
+	.constraints	= {
+		.name		= "SAFEOUT1",
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.state_mem	= {
+			.enabled = 0,
+			.disabled = 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_esafeout1_consumer),
+	.consumer_supplies	= nuri_max8997_esafeout1_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_esafeout2_data = {
+	.constraints	= {
+		.name		= "SAFEOUT2",
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.state_mem	= {
+			.enabled = 0,
+			.disabled = 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_esafeout2_consumer),
+	.consumer_supplies	= nuri_max8997_esafeout2_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_charger_cv_data = {
+	.constraints	= {
+		.name		= "CHARGER_CV",
+		.min_uV		= 4200000,
+		.max_uV		= 4200000,
+		.apply_uV	= 1,
+	},
+};
+
+static struct regulator_init_data nuri_max8997_charger_data = {
+	.constraints	= {
+		.name		= "CHARGER",
+		.min_uA		= 200000,
+		.max_uA		= 950000,
+		.always_on	= 1, /* Emergency force_disable only */
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS |
+				REGULATOR_CHANGE_CURRENT,
+				/* Allow "enable" after "force-disable" */
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_charger_consumer),
+	.consumer_supplies	= nuri_max8997_charger_consumer,
+};
+
+static struct regulator_init_data nuri_max8997_chg_topoff_data = {
+	.constraints	= {
+		.name		= "CHARGER TOPOFF",
+		.min_uA		= 50000,
+		.max_uA		= 200000,
+		.valid_ops_mask = REGULATOR_CHANGE_CURRENT,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(nuri_max8997_chg_topoff_consumer),
+	.consumer_supplies	= nuri_max8997_chg_topoff_consumer,
+};
+
+static struct max8997_regulator_data nuri_max8997_regulators[] = {
+	{ MAX8997_LDO1, &nuri_max8997_ldo1_data },
+	{ MAX8997_LDO2, &nuri_max8997_ldo2_data },
+	{ MAX8997_LDO3, &nuri_max8997_ldo3_data },
+	{ MAX8997_LDO4, &nuri_max8997_ldo4_data },
+	{ MAX8997_LDO5, &nuri_max8997_ldo5_data },
+	{ MAX8997_LDO6, &nuri_max8997_ldo6_data },
+	{ MAX8997_LDO7, &nuri_max8997_ldo7_data },
+	{ MAX8997_LDO8, &nuri_max8997_ldo8_data },
+	{ MAX8997_LDO9, &nuri_max8997_ldo9_data },
+	{ MAX8997_LDO10, &nuri_max8997_ldo10_data },
+	{ MAX8997_LDO11, &nuri_max8997_ldo11_data },
+	{ MAX8997_LDO12, &nuri_max8997_ldo12_data },
+	{ MAX8997_LDO13, &nuri_max8997_ldo13_data },
+	{ MAX8997_LDO14, &nuri_max8997_ldo14_data },
+	{ MAX8997_LDO15, &nuri_max8997_ldo15_data },
+	{ MAX8997_LDO16, &nuri_max8997_ldo16_data },
+
+	{ MAX8997_LDO18, &nuri_max8997_ldo18_data },
+	{ MAX8997_LDO21, &nuri_max8997_ldo21_data },
+
+	{ MAX8997_BUCK1, &nuri_max8997_buck1_data },
+	{ MAX8997_BUCK2, &nuri_max8997_buck2_data },
+	{ MAX8997_BUCK3, &nuri_max8997_buck3_data },
+	{ MAX8997_BUCK4, &nuri_max8997_buck4_data },
+	{ MAX8997_BUCK5, &nuri_max8997_buck5_data },
+	{ MAX8997_BUCK6, &nuri_max8997_buck6_data },
+	{ MAX8997_BUCK7, &nuri_max8997_buck7_data },
+
+	{ MAX8997_EN32KHZ_AP, &nuri_max8997_32khz_ap_data },
+	{ MAX8997_EN32KHZ_CP, &nuri_max8997_32khz_cp_data },
+
+	{ MAX8997_ENVICHG, &nuri_max8997_vichg_data },
+	{ MAX8997_ESAFEOUT1, &nuri_max8997_esafeout1_data },
+	{ MAX8997_ESAFEOUT2, &nuri_max8997_esafeout2_data },
+	{ MAX8997_CHARGER_CV, &nuri_max8997_charger_cv_data },
+	{ MAX8997_CHARGER, &nuri_max8997_charger_data },
+	{ MAX8997_CHARGER_TOPOFF, &nuri_max8997_chg_topoff_data },
+};
+#endif /* CONFIG_REGULATOR_MAX8997 */
+
+struct max8997_platform_data nuri_max8997_pdata = {
+	.wakeup			= 1,
+
+#ifdef CONFIG_REGULATOR_MAX8997
+	.num_regulators		= ARRAY_SIZE(nuri_max8997_regulators),
+	.regulators		= nuri_max8997_regulators,
+
+	.buck125_gpios = { EXYNOS4_GPX0(5), EXYNOS4_GPX0(6), EXYNOS4_GPL0(0) },
+	.buck125_default_idx = 0,
+	.buck1_gpiodvs = false,
+	.buck2_gpiodvs = true,
+	.buck5_gpiodvs = false,
+
+	.buck1_voltage[0] = 1350000, /* 1.35V */
+	.buck1_voltage[1] = 1300000, /* 1.3V */
+	.buck1_voltage[2] = 1250000, /* 1.25V */
+	.buck1_voltage[3] = 1200000, /* 1.2V */
+	.buck1_voltage[4] = 1150000, /* 1.15V */
+	.buck1_voltage[5] = 1100000, /* 1.1V */
+	.buck1_voltage[6] = 1000000, /* 1.0V */ /* No room for 1.05V */
+	.buck1_voltage[7] = 950000, /* 0.95V */
+
+	.buck2_voltage[0] = 1100000, /* 1.1V */
+	.buck2_voltage[1] = 1000000, /* 1.0V */
+	.buck2_voltage[2] = 950000, /* 0.95V */
+	.buck2_voltage[3] = 900000, /* 0.9V */
+	.buck2_voltage[4] = 1100000, /* 1.1V */
+	.buck2_voltage[5] = 1000000, /* 1.0V */
+	.buck2_voltage[6] = 950000, /* 0.95V */
+	.buck2_voltage[7] = 900000, /* 0.9V */
+
+	.buck5_voltage[0] = 1200000, /* 1.2V */
+	.buck5_voltage[1] = 1200000, /* 1.2V */
+	.buck5_voltage[2] = 1200000, /* 1.2V */
+	.buck5_voltage[3] = 1200000, /* 1.2V */
+	.buck5_voltage[4] = 1200000, /* 1.2V */
+	.buck5_voltage[5] = 1200000, /* 1.2V */
+	.buck5_voltage[6] = 1200000, /* 1.2V */
+	.buck5_voltage[7] = 1200000, /* 1.2V */
+#endif
+#ifdef CONFIG_RTC_DRV_MAX8997
+	/* RTC */
+	.delay		= true,
+#endif
+};
diff --git a/arch/arm/mach-exynos4/setup-max8997.h b/arch/arm/mach-exynos4/setup-max8997.h
new file mode 100644
index 0000000..d598b03
--- /dev/null
+++ b/arch/arm/mach-exynos4/setup-max8997.h
@@ -0,0 +1,26 @@
+/*
+ * linux/arch/arm/mach-exynos4/setup-max8997.h
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ * MyungJoo Ham <myungjoo.ham@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This header is to support board files with the max8997-related.
+ */
+#ifndef __SETUP_MAX8997_H
+#define __SETUP_MAX8997_H
+
+#ifdef CONFIG_MACH_NURI
+#ifdef CONFIG_MFD_MAX8997
+extern void __init nuri_pmic_max8997_init(void);
+extern struct max8997_platform_data nuri_max8997_pdata;
+#else
+static void nuri_pmic_max8997_init(void) { }
+static struct max8997_platform_data nuri_max8997_pdata;
+#endif /* CONFIG_MFD_MAX8997 */
+#endif /* CONFIG_MACH_NURI */
+
+#endif /* __SETUP_MAX8997_H */
-- 
1.7.1
