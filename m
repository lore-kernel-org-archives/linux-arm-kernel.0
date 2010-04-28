From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 28 Apr 2010 15:43:21 -0400
Subject: [PATCH] [ARM] mmp: append device support in jasper
Message-ID: <mailman.333.1272457409.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support regulator MAX8649, PMIC MAX8925 into the Jasper.
Backlight, regulator & rtc components of MAX8925 are enabled in Jasper.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/jasper.c |  154 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 154 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index cfd4d66..531bd6b 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -15,12 +15,16 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/max8649.h>
+#include <linux/mfd/max8925.h>

 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/addr-map.h>
 #include <mach/mfp-mmp2.h>
 #include <mach/mmp2.h>
+#include <mach/irqs.h>

 #include "common.h"

@@ -58,6 +62,153 @@ static unsigned long jasper_pin_config[] __initdata = {
 	GPIO149_ND_CLE,
 	GPIO112_ND_RDY0,
 	GPIO160_ND_RDY1,
+
+	/* PMIC */
+	PMIC_PMIC_INT | MFP_LPM_EDGE_FALL,
+};
+
+static struct regulator_consumer_supply max8649_supply[] = {
+	REGULATOR_SUPPLY("v_core", NULL),
+};
+
+static struct regulator_init_data max8649_init_data = {
+	.constraints	= {
+		.name		= "SD1",
+		.min_uV		= 750000,
+		.max_uV		= 1380000,
+		.always_on	= 1,
+		.boot_on	= 1,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &max8649_supply[0],
+};
+
+static struct max8649_platform_data jasper_max8649_info = {
+	.mode		= 2,	/* VID1 = 1, VID0 = 0 */
+	.extclk		= 0,
+	.ramp_timing	= MAX8649_RAMP_32MV,
+	.regulator	= &max8649_init_data,
+};
+
+static struct regulator_consumer_supply regulator_supply[] = {
+	[MAX8925_ID_SD1]	= REGULATOR_SUPPLY("v_sd1", NULL),
+	[MAX8925_ID_SD2]	= REGULATOR_SUPPLY("v_sd2", NULL),
+	[MAX8925_ID_SD3]	= REGULATOR_SUPPLY("v_sd3", NULL),
+	[MAX8925_ID_LDO1]	= REGULATOR_SUPPLY("v_ldo1", NULL),
+	[MAX8925_ID_LDO2]	= REGULATOR_SUPPLY("v_ldo2", NULL),
+	[MAX8925_ID_LDO3]	= REGULATOR_SUPPLY("v_ldo3", NULL),
+	[MAX8925_ID_LDO4]	= REGULATOR_SUPPLY("v_ldo4", NULL),
+	[MAX8925_ID_LDO5]	= REGULATOR_SUPPLY("v_ldo5", NULL),
+	[MAX8925_ID_LDO6]	= REGULATOR_SUPPLY("v_ldo6", NULL),
+	[MAX8925_ID_LDO7]	= REGULATOR_SUPPLY("v_ldo7", NULL),
+	[MAX8925_ID_LDO8]	= REGULATOR_SUPPLY("v_ldo8", NULL),
+	[MAX8925_ID_LDO9]	= REGULATOR_SUPPLY("v_ldo9", NULL),
+	[MAX8925_ID_LDO10]	= REGULATOR_SUPPLY("v_ldo10", NULL),
+	[MAX8925_ID_LDO11]	= REGULATOR_SUPPLY("v_ldo11", NULL),
+	[MAX8925_ID_LDO12]	= REGULATOR_SUPPLY("v_ldo12", NULL),
+	[MAX8925_ID_LDO13]	= REGULATOR_SUPPLY("v_ldo13", NULL),
+	[MAX8925_ID_LDO14]	= REGULATOR_SUPPLY("v_ldo14", NULL),
+	[MAX8925_ID_LDO15]	= REGULATOR_SUPPLY("v_ldo15", NULL),
+	[MAX8925_ID_LDO16]	= REGULATOR_SUPPLY("v_ldo16", NULL),
+	[MAX8925_ID_LDO17]	= REGULATOR_SUPPLY("v_ldo17", NULL),
+	[MAX8925_ID_LDO18]	= REGULATOR_SUPPLY("v_ldo18", NULL),
+	[MAX8925_ID_LDO19]	= REGULATOR_SUPPLY("v_ldo19", NULL),
+	[MAX8925_ID_LDO20]	= REGULATOR_SUPPLY("v_ldo20", NULL),
+};
+
+#define REG_INIT(_name, _min, _max, _always, _boot)		\
+{								\
+	.constraints = {					\
+		.name		= __stringify(_name),		\
+		.min_uV		= _min,				\
+		.max_uV		= _max,				\
+		.always_on	= _always,			\
+		.boot_on	= _boot,			\
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,	\
+	},							\
+	.num_consumer_supplies	= 1,				\
+	.consumer_supplies	= &regulator_supply[MAX8925_ID_##_name], \
+}
+
+static struct regulator_init_data regulator_data[] = {
+	[MAX8925_ID_SD1] = REG_INIT(SD1, 637500, 1425000, 0, 0),
+	[MAX8925_ID_SD2] = REG_INIT(SD2, 650000, 2225000, 1, 1),
+	[MAX8925_ID_SD3] = REG_INIT(SD3, 750000, 3900000, 1, 1),
+	[MAX8925_ID_LDO1] = REG_INIT(LDO1, 750000, 3900000, 1, 1),
+	[MAX8925_ID_LDO2] = REG_INIT(LDO2, 650000, 2250000, 1, 1),
+	[MAX8925_ID_LDO3] = REG_INIT(LDO3, 650000, 2250000, 0, 0),
+	[MAX8925_ID_LDO4] = REG_INIT(LDO4, 750000, 3900000, 1, 1),
+	[MAX8925_ID_LDO5] = REG_INIT(LDO5, 750000, 3900000, 0, 0),
+	[MAX8925_ID_LDO6] = REG_INIT(LDO6, 750000, 3900000, 0, 0),
+	[MAX8925_ID_LDO7] = REG_INIT(LDO7, 750000, 3900000, 0, 0),
+	[MAX8925_ID_LDO8] = REG_INIT(LDO8, 750000, 3900000, 0, 0),
+	[MAX8925_ID_LDO9] = REG_INIT(LDO9, 750000, 3900000, 1, 1),
+	[MAX8925_ID_LDO10] = REG_INIT(LDO10, 750000, 3900000, 0, 0),
+	[MAX8925_ID_LDO11] = REG_INIT(LDO11, 750000, 3900000, 0, 0),
+	[MAX8925_ID_LDO12] = REG_INIT(LDO12, 750000, 3900000, 0, 0),
+	[MAX8925_ID_LDO13] = REG_INIT(LDO13, 750000, 3900000, 0, 0),
+	[MAX8925_ID_LDO14] = REG_INIT(LDO14, 750000, 3900000, 0, 0),
+	[MAX8925_ID_LDO15] = REG_INIT(LDO15, 750000, 3900000, 0, 0),
+	[MAX8925_ID_LDO16] = REG_INIT(LDO16, 750000, 3900000, 0, 0),
+	[MAX8925_ID_LDO17] = REG_INIT(LDO17, 650000, 2250000, 0, 0),
+	[MAX8925_ID_LDO18] = REG_INIT(LDO18, 650000, 2250000, 1, 1),
+	[MAX8925_ID_LDO19] = REG_INIT(LDO19, 750000, 3900000, 0, 0),
+	[MAX8925_ID_LDO20] = REG_INIT(LDO20, 750000, 3900000, 1, 1),
+};
+
+static struct max8925_backlight_pdata jasper_backlight_data = {
+	.dual_string	= 0,
+};
+
+static struct max8925_power_pdata jasper_power_data = {
+	.batt_detect		= 0,	/* can't detect battery by ID pin */
+	.topoff_threshold	= MAX8925_TOPOFF_THR_10PER,
+	.fast_charge		= MAX8925_FCHG_1000MA,
+};
+
+static struct max8925_platform_data jasper_max8925_info = {
+	.backlight		= &jasper_backlight_data,
+	.power			= &jasper_power_data,
+	.irq_base		= IRQ_BOARD_START,
+
+	.regulator[MAX8925_ID_SD1] = &regulator_data[MAX8925_ID_SD1],
+	.regulator[MAX8925_ID_SD2] = &regulator_data[MAX8925_ID_SD2],
+	.regulator[MAX8925_ID_SD3] = &regulator_data[MAX8925_ID_SD3],
+	.regulator[MAX8925_ID_LDO1] = &regulator_data[MAX8925_ID_LDO1],
+	.regulator[MAX8925_ID_LDO2] = &regulator_data[MAX8925_ID_LDO2],
+	.regulator[MAX8925_ID_LDO3] = &regulator_data[MAX8925_ID_LDO3],
+	.regulator[MAX8925_ID_LDO4] = &regulator_data[MAX8925_ID_LDO4],
+	.regulator[MAX8925_ID_LDO5] = &regulator_data[MAX8925_ID_LDO5],
+	.regulator[MAX8925_ID_LDO6] = &regulator_data[MAX8925_ID_LDO6],
+	.regulator[MAX8925_ID_LDO7] = &regulator_data[MAX8925_ID_LDO7],
+	.regulator[MAX8925_ID_LDO8] = &regulator_data[MAX8925_ID_LDO8],
+	.regulator[MAX8925_ID_LDO9] = &regulator_data[MAX8925_ID_LDO9],
+	.regulator[MAX8925_ID_LDO10] = &regulator_data[MAX8925_ID_LDO10],
+	.regulator[MAX8925_ID_LDO11] = &regulator_data[MAX8925_ID_LDO11],
+	.regulator[MAX8925_ID_LDO12] = &regulator_data[MAX8925_ID_LDO12],
+	.regulator[MAX8925_ID_LDO13] = &regulator_data[MAX8925_ID_LDO13],
+	.regulator[MAX8925_ID_LDO14] = &regulator_data[MAX8925_ID_LDO14],
+	.regulator[MAX8925_ID_LDO15] = &regulator_data[MAX8925_ID_LDO15],
+	.regulator[MAX8925_ID_LDO16] = &regulator_data[MAX8925_ID_LDO16],
+	.regulator[MAX8925_ID_LDO17] = &regulator_data[MAX8925_ID_LDO17],
+	.regulator[MAX8925_ID_LDO18] = &regulator_data[MAX8925_ID_LDO18],
+	.regulator[MAX8925_ID_LDO19] = &regulator_data[MAX8925_ID_LDO19],
+	.regulator[MAX8925_ID_LDO20] = &regulator_data[MAX8925_ID_LDO20],
+};
+
+static struct i2c_board_info jasper_twsi1_info[] = {
+	[0] = {
+		.type		= "max8649",
+		.addr		= 0x60,
+		.platform_data	= &jasper_max8649_info,
+	},
+	[1] = {
+		.type		= "max8925",
+		.addr		= 0x3c,
+		.irq		= IRQ_MMP2_PMIC,
+		.platform_data	= &jasper_max8925_info,
+	},
 };

 static void __init jasper_init(void)
@@ -67,6 +218,9 @@ static void __init jasper_init(void)
 	/* on-chip devices */
 	mmp2_add_uart(1);
 	mmp2_add_uart(3);
+	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(jasper_twsi1_info));
+
+	regulator_has_full_constraints();
 }

 MACHINE_START(MARVELL_JASPER, "Jasper Development Platform")
-- 
1.5.6.5
