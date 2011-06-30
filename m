From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 17:15:25 +0900
Subject: [PATCH v3 2/6] Exynos4 NURI: configure regulators and PMIC (MAX8997)
In-Reply-To: <1309421729-11172-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309421729-11172-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1309421729-11172-3-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

--
Changes from v3
- Updated init function name to include other power related devices.
Changes from v2
- Add more __initdata entries
- Moved and renamed pmic init function
- Rearranged init point of PMIC
Changes from v1
- Removed unnecessary initialization data
- Add __initdata where necessary
- Corrected a regulator name for ADC
---
 arch/arm/mach-exynos4/mach-nuri.c |  625 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 624 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index 642702b..ec51f5c 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -17,6 +17,7 @@
 #include <linux/gpio.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
+#include <linux/mfd/max8997.h>
 #include <linux/mmc/host.h>
 #include <linux/fb.h>
 #include <linux/pwm_backlight.h>
@@ -344,11 +345,629 @@ static void __init nuri_tsp_init(void)
 	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
 }
 
+static struct regulator_consumer_supply __initdata max8997_ldo1_[] = {
+	REGULATOR_SUPPLY("vdd", "s5p-adc"), /* Used by CPU's ADC drv */
+};
+static struct regulator_consumer_supply __initdata max8997_ldo3_[] = {
+	REGULATOR_SUPPLY("vdd11", "s5p-mipi-csis.0"), /* MIPI */
+};
+static struct regulator_consumer_supply __initdata max8997_ldo4_[] = {
+	REGULATOR_SUPPLY("vdd18", "s5p-mipi-csis.0"), /* MIPI */
+};
+static struct regulator_consumer_supply __initdata max8997_ldo5_[] = {
+	REGULATOR_SUPPLY("vhsic", "modemctl"), /* MODEM */
+};
+static struct regulator_consumer_supply __initdata max8997_ldo7_[] = {
+	REGULATOR_SUPPLY("dig_18", "0-001f"), /* HCD803 */
+};
+static struct regulator_consumer_supply __initdata max8997_ldo8_[] = {
+	REGULATOR_SUPPLY("vusb_d", NULL), /* Used by CPU */
+	REGULATOR_SUPPLY("vdac", NULL), /* Used by CPU */
+};
+static struct regulator_consumer_supply __initdata max8997_ldo11_[] = {
+	REGULATOR_SUPPLY("vcc", "platform-lcd"), /* U804 LVDS */
+};
+static struct regulator_consumer_supply __initdata max8997_ldo12_[] = {
+	REGULATOR_SUPPLY("vddio", "6-003c"), /* HDC802 */
+};
+static struct regulator_consumer_supply __initdata max8997_ldo13_[] = {
+	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.2"), /* TFLASH */
+};
+static struct regulator_consumer_supply __initdata max8997_ldo14_[] = {
+	REGULATOR_SUPPLY("inmotor", "max8997-haptic"),
+};
+static struct regulator_consumer_supply __initdata max8997_ldo15_[] = {
+	REGULATOR_SUPPLY("avdd", "3-004a"), /* Touch Screen */
+};
+static struct regulator_consumer_supply __initdata max8997_ldo16_[] = {
+	REGULATOR_SUPPLY("d_sensor", "0-001f"), /* HDC803 */
+};
+static struct regulator_consumer_supply __initdata max8997_ldo18_[] = {
+	REGULATOR_SUPPLY("vdd", "3-004a"), /* Touch Screen */
+};
+static struct regulator_consumer_supply __initdata max8997_buck1_[] = {
+	REGULATOR_SUPPLY("vdd_arm", NULL), /* CPUFREQ */
+};
+static struct regulator_consumer_supply __initdata max8997_buck2_[] = {
+	REGULATOR_SUPPLY("vdd_int", NULL), /* CPUFREQ */
+};
+static struct regulator_consumer_supply __initdata max8997_buck3_[] = {
+	REGULATOR_SUPPLY("vdd", "mali_dev.0"), /* G3D of Exynos 4 */
+};
+static struct regulator_consumer_supply __initdata max8997_buck4_[] = {
+	REGULATOR_SUPPLY("core", "0-001f"), /* HDC803 */
+};
+static struct regulator_consumer_supply __initdata max8997_buck6_[] = {
+	REGULATOR_SUPPLY("dig_28", "0-001f"), /* pin "7" of HDC803 */
+};
+static struct regulator_consumer_supply __initdata max8997_esafeout1_[] = {
+	REGULATOR_SUPPLY("usb_vbus", NULL), /* CPU's USB OTG */
+};
+static struct regulator_consumer_supply __initdata max8997_esafeout2_[] = {
+	REGULATOR_SUPPLY("usb_vbus", "modemctl"), /* VBUS of Modem */
+};
+
+static struct regulator_consumer_supply __initdata max8997_charger_[] = {
+	REGULATOR_SUPPLY("vinchg1", "charger-manager.0"),
+};
+static struct regulator_consumer_supply __initdata max8997_chg_toff_[] = {
+	REGULATOR_SUPPLY("vinchg_stop", NULL), /* for jack interrupt handlers */
+};
+
+static struct regulator_consumer_supply __initdata max8997_32khz_ap_[] = {
+	REGULATOR_SUPPLY("gps_clk", "bcm4751"),
+	REGULATOR_SUPPLY("bt_clk", "bcm4330-b1"),
+	REGULATOR_SUPPLY("wifi_clk", "bcm433-b1"),
+};
+
+static struct regulator_init_data __initdata max8997_ldo1_data = {
+	.constraints	= {
+		.name		= "VADC_3.3V_C210",
+		.min_uV		= 3300000,
+		.max_uV		= 3300000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_ldo1_),
+	.consumer_supplies	= max8997_ldo1_,
+};
+
+static struct regulator_init_data __initdata max8997_ldo2_data = {
+	.constraints	= {
+		.name		= "VALIVE_1.1V_C210",
+		.min_uV		= 1100000,
+		.max_uV		= 1100000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled	= 1,
+		},
+	},
+};
+
+static struct regulator_init_data __initdata max8997_ldo3_data = {
+	.constraints	= {
+		.name		= "VUSB_1.1V_C210",
+		.min_uV		= 1100000,
+		.max_uV		= 1100000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_ldo3_),
+	.consumer_supplies	= max8997_ldo3_,
+};
+
+static struct regulator_init_data __initdata max8997_ldo4_data = {
+	.constraints	= {
+		.name		= "VMIPI_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_ldo4_),
+	.consumer_supplies	= max8997_ldo4_,
+};
+
+static struct regulator_init_data __initdata max8997_ldo5_data = {
+	.constraints	= {
+		.name		= "VHSIC_1.2V_C210",
+		.min_uV		= 1200000,
+		.max_uV		= 1200000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_ldo5_),
+	.consumer_supplies	= max8997_ldo5_,
+};
+
+static struct regulator_init_data __initdata max8997_ldo6_data = {
+	.constraints	= {
+		.name		= "VCC_1.8V_PDA",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled	= 1,
+		},
+	},
+};
+
+static struct regulator_init_data __initdata max8997_ldo7_data = {
+	.constraints	= {
+		.name		= "CAM_ISP_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_ldo7_),
+	.consumer_supplies	= max8997_ldo7_,
+};
+
+static struct regulator_init_data __initdata max8997_ldo8_data = {
+	.constraints	= {
+		.name		= "VUSB/VDAC_3.3V_C210",
+		.min_uV		= 3300000,
+		.max_uV		= 3300000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_ldo8_),
+	.consumer_supplies	= max8997_ldo8_,
+};
+
+static struct regulator_init_data __initdata max8997_ldo9_data = {
+	.constraints	= {
+		.name		= "VCC_2.8V_PDA",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled	= 1,
+		},
+	},
+};
+
+static struct regulator_init_data __initdata max8997_ldo10_data = {
+	.constraints	= {
+		.name		= "VPLL_1.1V_C210",
+		.min_uV		= 1100000,
+		.max_uV		= 1100000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+};
+
+static struct regulator_init_data __initdata max8997_ldo11_data = {
+	.constraints	= {
+		.name		= "LVDS_VDD3.3V",
+		.min_uV		= 3300000,
+		.max_uV		= 3300000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.boot_on	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_ldo11_),
+	.consumer_supplies	= max8997_ldo11_,
+};
+
+static struct regulator_init_data __initdata max8997_ldo12_data = {
+	.constraints	= {
+		.name		= "VT_CAM_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_ldo12_),
+	.consumer_supplies	= max8997_ldo12_,
+};
+
+static struct regulator_init_data __initdata max8997_ldo13_data = {
+	.constraints	= {
+		.name		= "VTF_2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_ldo13_),
+	.consumer_supplies	= max8997_ldo13_,
+};
+
+static struct regulator_init_data __initdata max8997_ldo14_data = {
+	.constraints	= {
+		.name		= "VCC_3.0V_MOTOR",
+		.min_uV		= 3000000,
+		.max_uV		= 3000000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_ldo14_),
+	.consumer_supplies	= max8997_ldo14_,
+};
+
+static struct regulator_init_data __initdata max8997_ldo15_data = {
+	.constraints	= {
+		.name		= "VTOUCH_ADVV2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.apply_uV	= 1,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_ldo15_),
+	.consumer_supplies	= max8997_ldo15_,
+};
+
+static struct regulator_init_data __initdata max8997_ldo16_data = {
+	.constraints	= {
+		.name		= "CAM_SENSOR_IO_1.8V",
+		.min_uV		= 1800000,
+		.max_uV		= 1800000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_ldo16_),
+	.consumer_supplies	= max8997_ldo16_,
+};
+
+static struct regulator_init_data __initdata max8997_ldo18_data = {
+	.constraints	= {
+		.name		= "VTOUCH_VDD2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.apply_uV	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_ldo18_),
+	.consumer_supplies	= max8997_ldo18_,
+};
+
+static struct regulator_init_data __initdata max8997_ldo21_data = {
+	.constraints	= {
+		.name		= "VDDQ_M1M2_1.2V",
+		.min_uV		= 1200000,
+		.max_uV		= 1200000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+};
+
+static struct regulator_init_data __initdata max8997_buck1_data = {
+	.constraints	= {
+		.name		= "VARM_1.2V_C210",
+		.min_uV		= 900000,
+		.max_uV		= 1350000,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
+		.always_on	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies = ARRAY_SIZE(max8997_buck1_),
+	.consumer_supplies = max8997_buck1_,
+};
+
+static struct regulator_init_data __initdata max8997_buck2_data = {
+	.constraints	= {
+		.name		= "VINT_1.1V_C210",
+		.min_uV		= 900000,
+		.max_uV		= 1100000,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
+		.always_on	= 1,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies = ARRAY_SIZE(max8997_buck2_),
+	.consumer_supplies = max8997_buck2_,
+};
+
+static struct regulator_init_data __initdata max8997_buck3_data = {
+	.constraints	= {
+		.name		= "VG3D_1.1V_C210",
+		.min_uV		= 900000,
+		.max_uV		= 1100000,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE |
+				  REGULATOR_CHANGE_STATUS,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies = ARRAY_SIZE(max8997_buck3_),
+	.consumer_supplies = max8997_buck3_,
+};
+
+static struct regulator_init_data __initdata max8997_buck4_data = {
+	.constraints	= {
+		.name		= "CAM_ISP_CORE_1.2V",
+		.min_uV		= 1200000,
+		.max_uV		= 1200000,
+		.apply_uV	= 1,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies = ARRAY_SIZE(max8997_buck4_),
+	.consumer_supplies = max8997_buck4_,
+};
+
+static struct regulator_init_data __initdata max8997_buck5_data = {
+	.constraints	= {
+		.name		= "VMEM_1.2V_C210",
+		.min_uV		= 1200000,
+		.max_uV		= 1200000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled	= 1,
+		},
+	},
+};
+
+static struct regulator_init_data __initdata max8997_buck6_data = {
+	.constraints	= {
+		.name		= "CAM_AF_2.8V",
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies = ARRAY_SIZE(max8997_buck6_),
+	.consumer_supplies = max8997_buck6_,
+};
+
+static struct regulator_init_data __initdata max8997_buck7_data = {
+	.constraints	= {
+		.name		= "VCC_SUB_2.0V",
+		.min_uV		= 2000000,
+		.max_uV		= 2000000,
+		.apply_uV	= 1,
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled	= 1,
+		},
+	},
+};
+
+static struct regulator_init_data __initdata max8997_32khz_ap_data = {
+	.constraints	= {
+		.name		= "32KHz AP",
+		.always_on	= 1,
+		.state_mem	= {
+			.enabled	= 1,
+		},
+	},
+	.num_consumer_supplies = ARRAY_SIZE(max8997_32khz_ap_),
+	.consumer_supplies = max8997_32khz_ap_,
+};
+
+static struct regulator_init_data __initdata max8997_32khz_cp_data = {
+	.constraints	= {
+		.name		= "32KHz CP",
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+};
+
+static struct regulator_init_data __initdata max8997_vichg_data = {
+	.constraints	= {
+		.name		= "VICHG",
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+};
+
+static struct regulator_init_data __initdata max8997_esafeout1_data = {
+	.constraints	= {
+		.name		= "SAFEOUT1",
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_esafeout1_),
+	.consumer_supplies	= max8997_esafeout1_,
+};
+
+static struct regulator_init_data __initdata max8997_esafeout2_data = {
+	.constraints	= {
+		.name		= "SAFEOUT2",
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		.state_mem	= {
+			.disabled	= 1,
+		},
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_esafeout2_),
+	.consumer_supplies	= max8997_esafeout2_,
+};
+
+static struct regulator_init_data __initdata max8997_charger_cv_data = {
+	.constraints	= {
+		.name		= "CHARGER_CV",
+		.min_uV		= 4200000,
+		.max_uV		= 4200000,
+		.apply_uV	= 1,
+	},
+};
+
+static struct regulator_init_data __initdata max8997_charger_data = {
+	.constraints	= {
+		.name		= "CHARGER",
+		.min_uA		= 200000,
+		.max_uA		= 950000,
+		.boot_on	= 1,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS |
+				REGULATOR_CHANGE_CURRENT,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_charger_),
+	.consumer_supplies	= max8997_charger_,
+};
+
+static struct regulator_init_data __initdata max8997_charger_topoff_data = {
+	.constraints	= {
+		.name		= "CHARGER TOPOFF",
+		.min_uA		= 50000,
+		.max_uA		= 200000,
+		.valid_ops_mask = REGULATOR_CHANGE_CURRENT,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(max8997_chg_toff_),
+	.consumer_supplies	= max8997_chg_toff_,
+};
+
+static struct max8997_regulator_data __initdata nuri_max8997_regulators[] = {
+	{ MAX8997_LDO1, &max8997_ldo1_data },
+	{ MAX8997_LDO2, &max8997_ldo2_data },
+	{ MAX8997_LDO3, &max8997_ldo3_data },
+	{ MAX8997_LDO4, &max8997_ldo4_data },
+	{ MAX8997_LDO5, &max8997_ldo5_data },
+	{ MAX8997_LDO6, &max8997_ldo6_data },
+	{ MAX8997_LDO7, &max8997_ldo7_data },
+	{ MAX8997_LDO8, &max8997_ldo8_data },
+	{ MAX8997_LDO9, &max8997_ldo9_data },
+	{ MAX8997_LDO10, &max8997_ldo10_data },
+	{ MAX8997_LDO11, &max8997_ldo11_data },
+	{ MAX8997_LDO12, &max8997_ldo12_data },
+	{ MAX8997_LDO13, &max8997_ldo13_data },
+	{ MAX8997_LDO14, &max8997_ldo14_data },
+	{ MAX8997_LDO15, &max8997_ldo15_data },
+	{ MAX8997_LDO16, &max8997_ldo16_data },
+
+	{ MAX8997_LDO18, &max8997_ldo18_data },
+	{ MAX8997_LDO21, &max8997_ldo21_data },
+
+	{ MAX8997_BUCK1, &max8997_buck1_data },
+	{ MAX8997_BUCK2, &max8997_buck2_data },
+	{ MAX8997_BUCK3, &max8997_buck3_data },
+	{ MAX8997_BUCK4, &max8997_buck4_data },
+	{ MAX8997_BUCK5, &max8997_buck5_data },
+	{ MAX8997_BUCK6, &max8997_buck6_data },
+	{ MAX8997_BUCK7, &max8997_buck7_data },
+
+	{ MAX8997_EN32KHZ_AP, &max8997_32khz_ap_data },
+	{ MAX8997_EN32KHZ_CP, &max8997_32khz_cp_data },
+
+	{ MAX8997_ENVICHG, &max8997_vichg_data },
+	{ MAX8997_ESAFEOUT1, &max8997_esafeout1_data },
+	{ MAX8997_ESAFEOUT2, &max8997_esafeout2_data },
+	{ MAX8997_CHARGER_CV, &max8997_charger_cv_data },
+	{ MAX8997_CHARGER, &max8997_charger_data },
+	{ MAX8997_CHARGER_TOPOFF, &max8997_charger_topoff_data },
+};
+
+static struct max8997_platform_data __initdata nuri_max8997_pdata = {
+	.wakeup			= 1,
+
+	.num_regulators		= ARRAY_SIZE(nuri_max8997_regulators),
+	.regulators		= nuri_max8997_regulators,
+
+	.buck125_gpios = { EXYNOS4_GPX0(5), EXYNOS4_GPX0(6), EXYNOS4_GPL0(0) },
+	.buck2_gpiodvs = true,
+
+	.buck1_voltage[0] = 1350000, /* 1.35V */
+	.buck1_voltage[1] = 1300000, /* 1.3V */
+	.buck1_voltage[2] = 1250000, /* 1.25V */
+	.buck1_voltage[3] = 1200000, /* 1.2V */
+	.buck1_voltage[4] = 1150000, /* 1.15V */
+	.buck1_voltage[5] = 1100000, /* 1.1V */
+	.buck1_voltage[6] = 1000000, /* 1.0V */
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
+};
+
 /* GPIO I2C 5 (PMIC) */
+enum { I2C5_MAX8997 };
 static struct i2c_board_info i2c5_devs[] __initdata = {
-	/* max8997, To be updated */
+	[I2C5_MAX8997] = {
+		I2C_BOARD_INFO("max8997", 0xCC >> 1),
+		.platform_data	= &nuri_max8997_pdata,
+	},
 };
 
+static void __init nuri_power_init(void)
+{
+	int gpio;
+	int irq_base = IRQ_GPIO_END + 1;
+
+	nuri_max8997_pdata.irq_base = irq_base;
+	irq_base += MAX8997_IRQ_NR;
+
+	gpio = EXYNOS4_GPX0(7);
+	gpio_request(gpio, "AP_PMIC_IRQ");
+	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
+	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+}
+
 /* USB EHCI */
 static struct s5p_ehci_platdata nuri_ehci_pdata;
 
@@ -361,6 +980,7 @@ static void __init nuri_ehci_init(void)
 
 static struct platform_device *nuri_devices[] __initdata = {
 	/* Samsung Platform Devices */
+	&s3c_device_i2c5, /* PMIC should initialize first */
 	&emmc_fixed_voltage,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc2,
@@ -387,10 +1007,13 @@ static void __init nuri_machine_init(void)
 {
 	nuri_sdhci_init();
 	nuri_tsp_init();
+	nuri_power_init();
 
 	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
 	s3c_i2c3_set_platdata(&i2c3_data);
 	i2c_register_board_info(3, i2c3_devs, ARRAY_SIZE(i2c3_devs));
+	s3c_i2c5_set_platdata(NULL);
+	i2c5_devs[I2C5_MAX8997].irq = gpio_to_irq(EXYNOS4_GPX0(7));
 	i2c_register_board_info(5, i2c5_devs, ARRAY_SIZE(i2c5_devs));
 
 	nuri_ehci_init();
-- 
1.7.4.1
