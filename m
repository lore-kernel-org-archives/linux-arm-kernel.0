From: rajanikanth.hv@stericsson.com (Rajanikanth H.V)
Date: Tue, 10 Jul 2012 18:53:59 +0530
Subject: =?UTF-8?q?=5BPATCH=5D=20mfd=3A=20Implement=20devicetree=20support=20for=20AB8500=20Btemp?=
Message-ID: <1341926639-9956-1-git-send-email-rajanikanth.hv@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>

    This patch adds device tree support for
    battery temperature monitor driver

Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
---
 .../bindings/power_supply/ab8500/btemp.txt         |   54 ++
 arch/arm/boot/dts/db8500.dtsi                      |   17 +
 arch/arm/mach-ux500/Makefile                       |    4 +-
 arch/arm/mach-ux500/board-mop500-bm.c              |  532 ++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/board-mop500-bm.h |   24 +
 drivers/mfd/ab8500-core.c                          |    1 +
 drivers/power/Kconfig                              |    8 +-
 drivers/power/ab8500_btemp.c                       |   79 ++-
 include/linux/mfd/ab8500/pwmleds.h                 |   20 +
 9 files changed, 722 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/ab8500/btemp.txt
 create mode 100644 arch/arm/mach-ux500/board-mop500-bm.c
 create mode 100644 arch/arm/mach-ux500/include/mach/board-mop500-bm.h
 create mode 100644 include/linux/mfd/ab8500/pwmleds.h

diff --git a/Documentation/devicetree/bindings/power_supply/ab8500/btemp.txt b/Documentation/devicetree/bindings/power_supply/ab8500/btemp.txt
new file mode 100644
index 0000000..8543ed1
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/ab8500/btemp.txt
@@ -0,0 +1,54 @@
+AB8500 Battery Termperature Monitor Driver
+
+AB8500 is a mixed signal multimedia and power management
+device comprising: power and energy management module,
+WalliCharger and USB charger interface, audio, general
+purpose ADC TVOut, clock management and SIM card Interface.
+
+Battery temperature monitoring support is part of 'energy
+management module', the other components of this module
+are: 'main and USB Combo charger' and fuel guage.
+
+The properties below describes the node for battery
+temperature monitor driver.
+
+Required Properties:
+- compatible = "stericsson,ab8500-btemp"
+
+interrupts:
+	Four battery temperature ranges are be defined
+	which results in interrupt events as:
+	- Btemp
+	- BtempLow
+	- BtempMedium
+	- BtempHigh
+
+
+Supplied-to:
+	This shall be power supply class dependency where in the runtime battery
+	properties will be shared across fuel guage and charging algorithm driver.
+
+Thermister-interface:
+	'btemp' and 'batctrl' are the pins interfaced for battery temperature
+	measurement, btemp is used when NTC(Negative Termperature coefficient)
+	resister is interfaced external to battery and batctrl is used when
+	NTC resister is internal to battery.
+
+example:
+ab8500-btemp {
+	compatible = "stericsson,ab8500-btemp";
+
+	interrupt-names =
+		"BAT_CTRL_INDB",	/* battery removal indicator */
+		"BTEMP_LOW", 		/* Btemp < BtempLow, if battery temperature is lower than -10?C */
+		"BTEMP_HIGH",		/* BtempLow < Btemp < BtempMedium,
+								if battery temperature is between -10 and 0?C */
+		"BTEMP_LOW_MEDIUM", /* BtempMedium < Btemp < BtempHigh,
+								if battery temperature is between 0?C and ?MaxTemp?.*/
+		"BTEMP_MEDIUM_HIGH";/* Btemp > BtempHigh,
+								if battery temperature is higher than ?MaxTemp?. */
+
+	supplied-to = "ab8500_chargalg", "ab8500_fg";
+
+	thermister-internal-to-battery = <1>;
+};
diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 7279165..527fdc3 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -330,6 +330,23 @@
 					vddadc-supply = <&ab8500_ldo_tvout_reg>;
 				};
 
+				ab8500-btemp {
+					compatible = "stericsson,ab8500-btemp";
+					interrupts = <20 0x04
+								80 0x04
+								81 0x04
+								82 0x04
+								83 0x04>;
+					interrupt-names = "BAT_CTRL_INDB",
+									"BTEMP_LOW",
+									"BTEMP_HIGH",
+									"BTEMP_LOW_MEDIUM",
+									"BTEMP_MEDIUM_HIGH";
+					supplied_to = "ab8500_chargalg", "ab8500_fg";
+					num_supplicants = <2>;
+					battery_term_on_batctrl = <1>;
+				};
+
 				ab8500-usb {
 					compatible = "stericsson,ab8500-usb";
 					interrupts = < 90 0x4
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 026086f..b474917 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -12,6 +12,8 @@ obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-uib.o board-mop500-stuib.o \
 				board-mop500-u8500uib.o \
 				board-mop500-pins.o \
-				board-mop500-msp.o
+				board-mop500-msp.o \
+				board-mop500-bm.o
+
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-ux500/board-mop500-bm.c b/arch/arm/mach-ux500/board-mop500-bm.c
new file mode 100644
index 0000000..3349ceb
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500-bm.c
@@ -0,0 +1,532 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2011
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ *
+ * U8500 board specific charger and battery initialization parameters.
+ *
+ * Author: Johan Palsson <johan.palsson@stericsson.com> for ST-Ericsson.
+ * Author: Johan Gardsmark <johan.gardsmark@stericsson.com> for ST-Ericsson.
+ *
+ */
+
+#include <linux/power_supply.h>
+#include <linux/mfd/abx500.h>
+#include <linux/mfd/abx500/ab8500-bm.h>
+#include <linux/mfd/ab8500/pwmleds.h>
+#include <mach/board-mop500-bm.h>
+
+/*
+ * These are the defined batteries that uses a NTC and ID resistor placed
+ * inside of the battery pack.
+ * Note that the res_to_temp table must be strictly sorted by falling resistance
+ * values to work.
+ */
+static struct abx500_res_to_temp temp_tbl_A_thermister[] = {
+	{-5, 53407},
+	{ 0, 48594},
+	{ 5, 43804},
+	{10, 39188},
+	{15, 34870},
+	{20, 30933},
+	{25, 27422},
+	{30, 24347},
+	{35, 21694},
+	{40, 19431},
+	{45, 17517},
+	{50, 15908},
+	{55, 14561},
+	{60, 13437},
+	{65, 12500},
+};
+static struct abx500_res_to_temp temp_tbl_B_thermister[] = {
+	{-5, 165418},
+	{ 0, 159024},
+	{ 5, 151921},
+	{10, 144300},
+	{15, 136424},
+	{20, 128565},
+	{25, 120978},
+	{30, 113875},
+	{35, 107397},
+	{40, 101629},
+	{45,  96592},
+	{50,  92253},
+	{55,  88569},
+	{60,  85461},
+	{65,  82869},
+};
+static struct abx500_v_to_cap cap_tbl_A_thermister[] = {
+	{4171,	100},
+	{4114,	 95},
+	{4009,	 83},
+	{3947,	 74},
+	{3907,	 67},
+	{3863,	 59},
+	{3830,	 56},
+	{3813,	 53},
+	{3791,	 46},
+	{3771,	 33},
+	{3754,	 25},
+	{3735,	 20},
+	{3717,	 17},
+	{3681,	 13},
+	{3664,	  8},
+	{3651,	  6},
+	{3635,	  5},
+	{3560,	  3},
+	{3408,    1},
+	{3247,	  0},
+};
+static struct abx500_v_to_cap cap_tbl_B_thermister[] = {
+	{4161,	100},
+	{4124,	 98},
+	{4044,	 90},
+	{4003,	 85},
+	{3966,	 80},
+	{3933,	 75},
+	{3888,	 67},
+	{3849,	 60},
+	{3813,	 55},
+	{3787,	 47},
+	{3772,	 30},
+	{3751,	 25},
+	{3718,	 20},
+	{3681,	 16},
+	{3660,	 14},
+	{3589,	 10},
+	{3546,	  7},
+	{3495,	  4},
+	{3404,	  2},
+	{3250,	  0},
+};
+
+static struct abx500_v_to_cap cap_tbl[] = {
+	{4186,	100},
+	{4163,	 99},
+	{4114,	 95},
+	{4068,	 90},
+	{3990,	 80},
+	{3926,	 70},
+	{3898,	 65},
+	{3866,	 60},
+	{3833,	 55},
+	{3812,	 50},
+	{3787,	 40},
+	{3768,	 30},
+	{3747,	 25},
+	{3730,	 20},
+	{3705,	 15},
+	{3699,	 14},
+	{3684,	 12},
+	{3672,	  9},
+	{3657,	  7},
+	{3638,	  6},
+	{3556,	  4},
+	{3424,	  2},
+	{3317,	  1},
+	{3094,	  0},
+};
+
+/*
+ * Note that the res_to_temp table must be strictly sorted by falling
+ * resistance values to work.
+ */
+static struct abx500_res_to_temp temp_tbl[] = {
+	{-5, 214834},
+	{ 0, 162943},
+	{ 5, 124820},
+	{10,  96520},
+	{15,  75306},
+	{20,  59254},
+	{25,  47000},
+	{30,  37566},
+	{35,  30245},
+	{40,  24520},
+	{45,  20010},
+	{50,  16432},
+	{55,  13576},
+	{60,  11280},
+	{65,   9425},
+};
+
+/*
+ * Note that the batres_vs_temp table must be strictly sorted by falling
+ * temperature values to work.
+ */
+static struct batres_vs_temp temp_to_batres_tbl_thermister[] = {
+	{ 40, 120},
+	{ 30, 135},
+	{ 20, 165},
+	{ 10, 230},
+	{ 00, 325},
+	{-10, 445},
+	{-20, 595},
+};
+
+/*
+ * Note that the batres_vs_temp table must be strictly sorted by falling
+ * temperature values to work.
+ */
+#ifdef CONFIG_AB8500_9100_LI_ION_BATTERY
+#define BATRES	180
+#else
+#define BATRES	300
+#endif
+static struct batres_vs_temp temp_to_batres_tbl[] = {
+	{ 60, BATRES},
+	{ 30, BATRES},
+	{ 20, BATRES},
+	{ 10, BATRES},
+	{ 00, BATRES},
+	{-10, BATRES},
+	{-20, BATRES},
+};
+
+static const struct abx500_battery_type bat_type_thermister[] = {
+[BATTERY_UNKNOWN] = {
+	/* First element always represent the UNKNOWN battery */
+	.name = POWER_SUPPLY_TECHNOLOGY_UNKNOWN,
+	.resis_high = 0,
+	.resis_low = 0,
+	.battery_resistance = 300,
+#ifdef CONFIG_AB8500_9100_LI_ION_BATTERY
+	.charge_full_design = 2600,
+#else
+	.charge_full_design = 612,
+#endif
+	.nominal_voltage = 3700,
+#ifdef CONFIG_AB8500_9100_LI_ION_BATTERY
+	.termination_vol = 4150,
+#else
+	.termination_vol = 4050,
+#endif
+	.termination_curr = 200,
+#ifdef CONFIG_AB8500_9100_LI_ION_BATTERY
+	.recharge_vol = 4130,
+	.normal_cur_lvl = 520,
+	.normal_vol_lvl = 4200,
+#else
+	.recharge_vol = 3990,
+	.normal_cur_lvl = 400,
+	.normal_vol_lvl = 4100,
+#endif
+	.maint_a_cur_lvl = 400,
+	.maint_a_vol_lvl = 4050,
+	.maint_a_chg_timer_h = 60,
+	.maint_b_cur_lvl = 400,
+	.maint_b_vol_lvl = 4000,
+	.maint_b_chg_timer_h = 200,
+	.low_high_cur_lvl = 300,
+	.low_high_vol_lvl = 4000,
+	.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl),
+	.r_to_t_tbl = temp_tbl,
+	.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl),
+	.v_to_cap_tbl = cap_tbl,
+	.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl),
+	.batres_tbl = temp_to_batres_tbl,
+},
+{
+	.name = POWER_SUPPLY_TECHNOLOGY_LIPO,
+	.resis_high = 53407,
+	.resis_low = 12500,
+	.battery_resistance = 300,
+	.charge_full_design = 900,
+	.nominal_voltage = 3600,
+	.termination_vol = 4150,
+	.termination_curr = 80,
+	.recharge_vol = 4130,
+	.normal_cur_lvl = 700,
+	.normal_vol_lvl = 4200,
+	.maint_a_cur_lvl = 600,
+	.maint_a_vol_lvl = 4150,
+	.maint_a_chg_timer_h = 60,
+	.maint_b_cur_lvl = 600,
+	.maint_b_vol_lvl = 4100,
+	.maint_b_chg_timer_h = 200,
+	.low_high_cur_lvl = 300,
+	.low_high_vol_lvl = 4000,
+	.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl_A_thermister),
+	.r_to_t_tbl = temp_tbl_A_thermister,
+	.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl_A_thermister),
+	.v_to_cap_tbl = cap_tbl_A_thermister,
+	.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl_thermister),
+	.batres_tbl = temp_to_batres_tbl_thermister,
+
+},
+{
+	.name = POWER_SUPPLY_TECHNOLOGY_LIPO,
+	.resis_high = 165418,
+	.resis_low = 82869,
+	.battery_resistance = 300,
+	.charge_full_design = 900,
+	.nominal_voltage = 3600,
+	.termination_vol = 4150,
+	.termination_curr = 80,
+	.recharge_vol = 4130,
+	.normal_cur_lvl = 700,
+	.normal_vol_lvl = 4200,
+	.maint_a_cur_lvl = 600,
+	.maint_a_vol_lvl = 4150,
+	.maint_a_chg_timer_h = 60,
+	.maint_b_cur_lvl = 600,
+	.maint_b_vol_lvl = 4100,
+	.maint_b_chg_timer_h = 200,
+	.low_high_cur_lvl = 300,
+	.low_high_vol_lvl = 4000,
+	.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl_B_thermister),
+	.r_to_t_tbl = temp_tbl_B_thermister,
+	.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl_B_thermister),
+	.v_to_cap_tbl = cap_tbl_B_thermister,
+	.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl_thermister),
+	.batres_tbl = temp_to_batres_tbl_thermister,
+},
+};
+
+struct abx500_battery_type bat_type_ext_thermister[] = {
+[BATTERY_UNKNOWN] = {
+	/* First element always represent the UNKNOWN battery */
+	.name = POWER_SUPPLY_TECHNOLOGY_UNKNOWN,
+	.resis_high = 0,
+	.resis_low = 0,
+	.battery_resistance = 300,
+#ifdef CONFIG_AB8500_9100_LI_ION_BATTERY
+	.charge_full_design = 2600,
+#else
+	.charge_full_design = 612,
+#endif
+	.nominal_voltage = 3700,
+#ifdef CONFIG_AB8500_9100_LI_ION_BATTERY
+	.termination_vol = 4150,
+#else
+	.termination_vol = 4050,
+#endif
+	.termination_curr = 200,
+#ifdef CONFIG_AB8500_9100_LI_ION_BATTERY
+	.recharge_vol = 4130,
+	.normal_cur_lvl = 520,
+	.normal_vol_lvl = 4200,
+#else
+	.recharge_vol = 3990,
+	.normal_cur_lvl = 400,
+	.normal_vol_lvl = 4100,
+#endif
+	.maint_a_cur_lvl = 400,
+	.maint_a_vol_lvl = 4050,
+	.maint_a_chg_timer_h = 60,
+	.maint_b_cur_lvl = 400,
+	.maint_b_vol_lvl = 4000,
+	.maint_b_chg_timer_h = 200,
+	.low_high_cur_lvl = 300,
+	.low_high_vol_lvl = 4000,
+	.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl),
+	.r_to_t_tbl = temp_tbl,
+	.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl),
+	.v_to_cap_tbl = cap_tbl,
+	.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl),
+	.batres_tbl = temp_to_batres_tbl,
+},
+/*
+ * These are the batteries that doesn't have an internal NTC resistor to measure
+ * its temperature. The temperature in this case is measure with a NTC placed
+ * near the battery but on the PCB.
+ */
+{
+	.name = POWER_SUPPLY_TECHNOLOGY_LIPO,
+	.resis_high = 76000,
+	.resis_low = 53000,
+	.battery_resistance = 300,
+	.charge_full_design = 900,
+	.nominal_voltage = 3700,
+	.termination_vol = 4150,
+	.termination_curr = 100,
+	.recharge_vol = 4130,
+	.normal_cur_lvl = 700,
+	.normal_vol_lvl = 4200,
+	.maint_a_cur_lvl = 600,
+	.maint_a_vol_lvl = 4150,
+	.maint_a_chg_timer_h = 60,
+	.maint_b_cur_lvl = 600,
+	.maint_b_vol_lvl = 4100,
+	.maint_b_chg_timer_h = 200,
+	.low_high_cur_lvl = 300,
+	.low_high_vol_lvl = 4000,
+	.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl),
+	.r_to_t_tbl = temp_tbl,
+	.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl),
+	.v_to_cap_tbl = cap_tbl,
+	.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl),
+	.batres_tbl = temp_to_batres_tbl,
+},
+{
+	.name = POWER_SUPPLY_TECHNOLOGY_LION,
+	.resis_high = 30000,
+	.resis_low = 10000,
+	.battery_resistance = 300,
+	.charge_full_design = 950,
+	.nominal_voltage = 3700,
+	.termination_vol = 4150,
+	.termination_curr = 100,
+	.recharge_vol = 4130,
+	.normal_cur_lvl = 700,
+	.normal_vol_lvl = 4200,
+	.maint_a_cur_lvl = 600,
+	.maint_a_vol_lvl = 4150,
+	.maint_a_chg_timer_h = 60,
+	.maint_b_cur_lvl = 600,
+	.maint_b_vol_lvl = 4100,
+	.maint_b_chg_timer_h = 200,
+	.low_high_cur_lvl = 300,
+	.low_high_vol_lvl = 4000,
+	.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl),
+	.r_to_t_tbl = temp_tbl,
+	.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl),
+	.v_to_cap_tbl = cap_tbl,
+	.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl),
+	.batres_tbl = temp_to_batres_tbl,
+},
+{
+	.name = POWER_SUPPLY_TECHNOLOGY_LION,
+	.resis_high = 95000,
+	.resis_low = 76001,
+	.battery_resistance = 300,
+	.charge_full_design = 950,
+	.nominal_voltage = 3700,
+	.termination_vol = 4150,
+	.termination_curr = 100,
+	.recharge_vol = 4130,
+	.normal_cur_lvl = 700,
+	.normal_vol_lvl = 4200,
+	.maint_a_cur_lvl = 600,
+	.maint_a_vol_lvl = 4150,
+	.maint_a_chg_timer_h = 60,
+	.maint_b_cur_lvl = 600,
+	.maint_b_vol_lvl = 4100,
+	.maint_b_chg_timer_h = 200,
+	.low_high_cur_lvl = 300,
+	.low_high_vol_lvl = 4000,
+	.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl),
+	.r_to_t_tbl = temp_tbl,
+	.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl),
+	.v_to_cap_tbl = cap_tbl,
+	.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl),
+	.batres_tbl = temp_to_batres_tbl,
+},
+};
+
+static char *ab8500_charger_supplied_to[] = {
+	"ab8500_chargalg",
+	"ab8500_fg",
+	"ab8500_btemp",
+};
+
+static char *ab8500_chargalg_supplied_to[] = {
+	"ab8500_fg",
+};
+
+struct abx500_charger_platform_data ab8500_charger_plat_data = {
+	.supplied_to = ab8500_charger_supplied_to,
+	.num_supplicants = ARRAY_SIZE(ab8500_charger_supplied_to),
+	.autopower_cfg		= false,
+};
+
+struct abx500_chargalg_platform_data ab8500_chargalg_plat_data = {
+	.supplied_to = ab8500_chargalg_supplied_to,
+	.num_supplicants = ARRAY_SIZE(ab8500_chargalg_supplied_to),
+};
+
+static struct ab8500_led_pwm leds_pwm_data[] = {
+	[0] = {
+		.pwm_id = 1,
+		.blink_en = 1,
+	},
+	[1] = {
+		.pwm_id = 2,
+		.blink_en = 0,
+	},
+	[2] = {
+		.pwm_id = 3,
+		.blink_en = 0,
+	},
+};
+
+struct ab8500_pwmled_platform_data ab8500_pwmled_plat_data = {
+	.num_pwm = 3,
+	.leds = leds_pwm_data,
+};
+
+static const struct abx500_bm_capacity_levels cap_levels = {
+	.critical	= 2,
+	.low		= 10,
+	.normal		= 70,
+	.high		= 95,
+	.full		= 100,
+};
+
+static const struct abx500_fg_parameters fg = {
+	.recovery_sleep_timer = 10,
+	.recovery_total_time = 100,
+	.init_timer = 1,
+	.init_discard_time = 5,
+	.init_total_time = 40,
+	.high_curr_time = 60,
+	.accu_charging = 30,
+	.accu_high_curr = 30,
+	.high_curr_threshold = 50,
+	.lowbat_threshold = 3100,
+	.battok_falling_th_sel0 = 2860,
+	.battok_raising_th_sel1 = 2860,
+	.user_cap_limit = 15,
+	.maint_thres = 97,
+};
+
+static const struct abx500_maxim_parameters maxi_params = {
+	.ena_maxi = true,
+	.chg_curr = 910,
+	.wait_cycles = 10,
+	.charger_curr_step = 100,
+};
+
+static const struct abx500_bm_charger_parameters chg = {
+	.usb_volt_max		= 5500,
+	.usb_curr_max		= 1500,
+	.ac_volt_max		= 7500,
+	.ac_curr_max		= 1500,
+};
+
+struct abx500_bm_data ab8500_bm_data = {
+	.temp_under		= 3,
+	.temp_low		= 8,
+	.temp_high		= 43,
+	.temp_over		= 48,
+	.main_safety_tmr_h	= 4,
+	.temp_interval_chg	= 20,
+	.temp_interval_nochg	= 120,
+	.usb_safety_tmr_h	= 4,
+	.bkup_bat_v		= BUP_VCH_SEL_2P6V,
+	.bkup_bat_i		= BUP_ICH_SEL_150UA,
+#ifdef CONFIG_AB8500_9100_LI_ION_BATTERY
+	.no_maintenance		= true,
+#else
+	.no_maintenance		= false,
+#endif
+	.adc_therm		= ABx500_ADC_THERM_BATCTRL,
+#ifdef CONFIG_AB8500_9100_LI_ION_BATTERY
+	.chg_unknown_bat	= true,
+#else
+	.chg_unknown_bat	= false,
+#endif
+	.enable_overshoot	= false,
+	.fg_res			= 100,
+	.cap_levels		= &cap_levels,
+	.bat_type		= bat_type_thermister,
+	.n_btypes		= 3,
+	.batt_id		= 0,
+	.interval_charging	= 5,
+	.interval_not_charging	= 120,
+	.temp_hysteresis	= 3,
+	.gnd_lift_resistance	= 34,
+	.maxi			= &maxi_params,
+	.chg_params		= &chg,
+	.fg_params		= &fg,
+};
diff --git a/arch/arm/mach-ux500/include/mach/board-mop500-bm.h b/arch/arm/mach-ux500/include/mach/board-mop500-bm.h
new file mode 100644
index 0000000..11c7384
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/board-mop500-bm.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2011
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ *
+ * U8500 board specific charger and battery initialization parameters.
+ *
+ * Author: Johan Palsson <johan.palsson@stericsson.com> for ST-Ericsson.
+ * Author: Johan Gardsmark <johan.gardsmark@stericsson.com> for ST-Ericsson.
+ *
+ */
+
+#ifndef __BOARD_MOP500_BM_H
+#define __BOARD_MOP500_BM_H
+
+#include <linux/mfd/abx500/ab8500-bm.h>
+
+extern struct abx500_charger_platform_data ab8500_charger_plat_data;
+extern struct abx500_chargalg_platform_data ab8500_chargalg_plat_data;
+extern struct abx500_bm_data ab8500_bm_data;
+extern struct abx500_battery_type bat_type_ext_thermister[];
+extern struct ab8500_pwmled_platform_data ab8500_pwmled_plat_data;
+
+#endif
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 738b9c5..402f630 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1046,6 +1046,7 @@ static struct mfd_cell __devinitdata ab8500_bm_devs[] = {
 	},
 	{
 		.name = "ab8500-btemp",
+		.of_compatible = "stericsson,ab8500-btemp",
 		.num_resources = ARRAY_SIZE(ab8500_btemp_resources),
 		.resources = ab8500_btemp_resources,
 	},
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index e3a3b49..00dec0f 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -303,10 +303,10 @@ config AB8500_BM
 	help
 	  Say Y to include support for AB5500 battery management.
 
-config AB8500_BATTERY_THERM_ON_BATCTRL
-	bool "Thermistor connected on BATCTRL ADC"
+config AB8500_9100_LI_ION_BATTERY
+	bool "Enable support of the 9100 Li-ion battery charging"
 	depends on AB8500_BM
 	help
-	  Say Y to enable battery temperature measurements using
-	  thermistor connected on BATCTRL ADC.
+		Say Y to enable support of the 9100 Li-ion battery charging.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index bba3cca..1272bba 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/completion.h>
@@ -25,6 +26,7 @@
 #include <linux/mfd/abx500/ab8500-bm.h>
 #include <linux/mfd/abx500/ab8500-gpadc.h>
 #include <linux/jiffies.h>
+#include <mach/board-mop500-bm.h>
 
 #define VTVOUT_V			1800
 
@@ -964,11 +966,13 @@ static int __devinit ab8500_btemp_probe(struct platform_device *pdev)
 {
 	int irq, i, ret = 0;
 	u8 val;
-	struct abx500_bm_plat_data *plat_data = pdev->dev.platform_data;
+	struct device_node *np = pdev->dev.of_node;
 	struct ab8500_btemp *di;
+	u32 pval;
+	const char *sup_val;
 
-	if (!plat_data) {
-		dev_err(&pdev->dev, "No platform data\n");
+	if (!np) {
+		dev_err(&pdev->dev, "No DT node for btemp found\n");
 		return -EINVAL;
 	}
 
@@ -981,21 +985,64 @@ static int __devinit ab8500_btemp_probe(struct platform_device *pdev)
 	di->parent = dev_get_drvdata(pdev->dev.parent);
 	di->gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
 
-	/* get btemp specific platform data */
-	di->pdata = plat_data->btemp;
-	if (!di->pdata) {
-		dev_err(di->dev, "no btemp platform data supplied\n");
+	di->pdata =
+		kzalloc(sizeof(struct abx500_btemp_platform_data), GFP_KERNEL);
+	if (di->pdata == NULL) {
+		ret = -ENOMEM;
+		goto free_device_info;
+	}
+	/* get battery specific platform data */
+	ret = of_property_read_u32(np, "num_supplicants", &pval);
+	if (ret) {
+		dev_err(di->dev, "missing property num_supplicants\n");
+		kfree(di->pdata);
+		ret = -EINVAL;
+		goto free_device_info;
+	}
+	di->pdata->num_supplicants = pval;
+	di->pdata->supplied_to =
+		kzalloc(di->pdata->num_supplicants *
+			sizeof(const char *), GFP_KERNEL);
+	if (di->pdata->supplied_to == NULL) {
+		kfree(di->pdata);
 		ret = -EINVAL;
 		goto free_device_info;
 	}
 
-	/* get battery specific platform data */
-	di->bat = plat_data->battery;
+	for (val = 0; val < di->pdata->num_supplicants; ++val)
+		if (of_property_read_string_index
+			(np, "supplied_to", val, &sup_val) == 0)
+			*(di->pdata->supplied_to + val) = (char *)sup_val;
+		else {
+			dev_err(di->dev, "insufficient number of supplied_to data found\n");
+			kfree(di->pdata);
+			kfree(di->pdata->supplied_to);
+			ret = -EINVAL;
+			goto free_device_info;
+		}
+
+	di->bat = kzalloc(sizeof(struct abx500_bm_data), GFP_KERNEL);
 	if (!di->bat) {
-		dev_err(di->dev, "no battery platform data supplied\n");
-		ret = -EINVAL;
+		kfree(di->pdata->supplied_to);
+		kfree(di->pdata);
+		ret = -ENOMEM;
 		goto free_device_info;
 	}
+	dev_dbg(di->dev, "getting battery information\n");
+	di->bat = &ab8500_bm_data;
+	ret = of_property_read_u32(np, "battery_term_on_batctrl", &pval);
+	if (ret) {
+		dev_err(di->dev, "missing property battery_term_on_batctrl\n");
+		kfree(di->pdata->supplied_to);
+		kfree(di->pdata);
+		kfree(di->bat);
+		ret = -ENOMEM;
+		goto free_device_info;
+	}
+	if (pval == 0) {
+		di->bat->bat_type = bat_type_ext_thermister;
+		di->bat->adc_therm = ABx500_ADC_THERM_BATTEMP;
+	}
 
 	/* BTEMP supply */
 	di->btemp_psy.name = "ab8500_btemp";
@@ -1008,7 +1055,6 @@ static int __devinit ab8500_btemp_probe(struct platform_device *pdev)
 	di->btemp_psy.external_power_changed =
 		ab8500_btemp_external_power_changed;
 
-
 	/* Create a work queue for the btemp */
 	di->btemp_wq =
 		create_singlethread_workqueue("ab8500_btemp_wq");
@@ -1090,14 +1136,22 @@ free_irq:
 		irq = platform_get_irq_byname(pdev, ab8500_btemp_irq[i].name);
 		free_irq(irq, di);
 	}
+
 free_btemp_wq:
 	destroy_workqueue(di->btemp_wq);
+
 free_device_info:
 	kfree(di);
 
 	return ret;
 }
 
+static const struct of_device_id ab8500_btemp_match[] = {
+	{.compatible = "stericsson,ab8500-btemp",},
+	{},
+};
+
+
 static struct platform_driver ab8500_btemp_driver = {
 	.probe = ab8500_btemp_probe,
 	.remove = __devexit_p(ab8500_btemp_remove),
@@ -1106,6 +1160,7 @@ static struct platform_driver ab8500_btemp_driver = {
 	.driver = {
 		.name = "ab8500-btemp",
 		.owner = THIS_MODULE,
+		.of_match_table = ab8500_btemp_match,
 	},
 };
 
diff --git a/include/linux/mfd/ab8500/pwmleds.h b/include/linux/mfd/ab8500/pwmleds.h
new file mode 100644
index 0000000..e316582
--- /dev/null
+++ b/include/linux/mfd/ab8500/pwmleds.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright ST-Ericsson 2012.
+ *
+ * Author: Naga Radhesh <naga.radheshy@stericsson.com>
+ * Licensed under GPLv2.
+ */
+#ifndef _AB8500_PWMLED_H
+#define _AB8500_PWMLED_H
+
+struct ab8500_led_pwm {
+	int	pwm_id;
+	int	blink_en;
+};
+
+struct ab8500_pwmled_platform_data {
+	int	num_pwm;
+	struct	ab8500_led_pwm *leds;
+};
+
+#endif
-- 
1.7.9.5
