From: jtzhou@marvell.com (Jett.Zhou)
Date: Thu, 21 Jun 2012 14:19:32 +0800
Subject: [V2 2/3] power_supply: Enable battery-charger for 88pm860x
Message-ID: <1340259572-24278-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are charger and battery measurement feature for 88pm860x PMIC.

For charger, it can support pre-charge with small current when battery is
nearly exausted and then changed into fast-charge with CC&CV mode.

For battery monitor, it can support battery measurement such as
vbat,vsys,vchg and ibat etc,it can aslo accumulating the Coulomb value
charged or discharged from battery based on Conlomb Counter, we use it
to estimate battery capacity.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/mfd/88pm860x-core.c      |   22 +-
 drivers/power/88pm860x_battery.c | 1026 ++++++++++++++++++++++++++++++++++++++
 drivers/power/88pm860x_charger.c |  833 +++++++++++++++++++++++++++++++
 drivers/power/Kconfig            |   12 +
 drivers/power/Makefile           |    2 +
 include/linux/mfd/88pm860x.h     |   84 +++-
 6 files changed, 1977 insertions(+), 2 deletions(-)
 create mode 100644 drivers/power/88pm860x_battery.c
 create mode 100644 drivers/power/88pm860x_charger.c

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 508aca5..5850141 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -18,6 +18,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/88pm860x.h>
 #include <linux/regulator/machine.h>
+#include <linux/power/charger-manager.h>
 
 #define INT_STATUS_NUM			3
 
@@ -84,7 +85,8 @@ static struct resource battery_resources[] __devinitdata = {
 static struct resource charger_resources[] __devinitdata = {
 	{PM8607_IRQ_CHG,  PM8607_IRQ_CHG,  "charger detect",  IORESOURCE_IRQ,},
 	{PM8607_IRQ_CHG_DONE,  PM8607_IRQ_CHG_DONE,  "charging done",       IORESOURCE_IRQ,},
-	{PM8607_IRQ_CHG_FAULT, PM8607_IRQ_CHG_FAULT, "charging timeout",    IORESOURCE_IRQ,},
+	{PM8607_IRQ_CHG_FAIL,  PM8607_IRQ_CHG_FAIL,  "charging timeout",    IORESOURCE_IRQ,},
+	{PM8607_IRQ_CHG_FAULT, PM8607_IRQ_CHG_FAULT, "charging fault",	    IORESOURCE_IRQ,},
 	{PM8607_IRQ_GPADC1,    PM8607_IRQ_GPADC1,    "battery temperature", IORESOURCE_IRQ,},
 	{PM8607_IRQ_VBAT, PM8607_IRQ_VBAT, "battery voltage", IORESOURCE_IRQ,},
 	{PM8607_IRQ_VCHG, PM8607_IRQ_VCHG, "vchg voltage",    IORESOURCE_IRQ,},
@@ -155,10 +157,15 @@ static struct regulator_init_data preg_init_data = {
 	.consumer_supplies	= &preg_supply[0],
 };
 
+static struct regulator_bulk_data chg_desc_regulator_data[] = {
+	{ .supply = "preg", },
+};
+
 static struct mfd_cell power_devs[] = {
 	{"88pm860x-battery", -1,},
 	{"88pm860x-charger", -1,},
 	{"88pm860x-preg",    -1,},
+	{"charger-manager", -1,},
 };
 
 static struct mfd_cell rtc_devs[] = {
@@ -791,6 +798,19 @@ static void __devinit device_power_init(struct pm860x_chip *chip,
 			      &preg_resources[0], chip->irq_base);
 	if (ret < 0)
 		dev_err(chip->dev, "Failed to add preg subdev\n");
+
+	if (pdata->chg_desc) {
+		pdata->chg_desc->charger_regulators =
+			&chg_desc_regulator_data[0];
+		pdata->chg_desc->num_charger_regulators	=
+			ARRAY_SIZE(chg_desc_regulator_data),
+		power_devs[3].platform_data = pdata->chg_desc;
+		power_devs[3].pdata_size = sizeof(struct charger_desc);
+		ret = mfd_add_devices(chip->dev, 0, &power_devs[3], 1,
+				      NULL, chip->irq_base);
+		if (ret < 0)
+			dev_err(chip->dev, "Failed to add chg-manager subdev\n");
+	}
 }
 
 static void __devinit device_onkey_init(struct pm860x_chip *chip,
diff --git a/drivers/power/88pm860x_battery.c b/drivers/power/88pm860x_battery.c
new file mode 100644
index 0000000..132e2ee
--- /dev/null
+++ b/drivers/power/88pm860x_battery.c
@@ -0,0 +1,1026 @@
+/*
+ * Battery driver for Marvell 88PM860x PMIC
+ *
+ * Copyright (c) 2012 Marvell International Ltd.
+ * Author:	Jett Zhou <jtzhou@marvell.com>
+ *		Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/power_supply.h>
+#include <linux/mfd/88pm860x.h>
+#include <linux/delay.h>
+
+/* bit definitions of Status Query Interface 2 */
+#define STATUS2_CHG			(1 << 2)
+#define STATUS2_BAT			(1 << 3)
+#define STATUS2_VBUS			(1 << 4)
+
+/* bit definitions of Measurement Enable 1 Register */
+#define MEAS1_TINT			(1 << 3)
+#define MEAS1_GP1			(1 << 5)
+
+/* bit definitions of Measurement Enable 3 Register */
+#define MEAS3_IBAT			(1 << 0)
+#define MEAS3_BAT_DET			(1 << 1)
+#define MEAS3_CC			(1 << 2)
+
+/* bit definitions of Measurement Off Time Register */
+#define MEAS_OFF_SLEEP_EN		(1 << 1)
+
+/* bit definitions of GPADC Bias Current 2 Register */
+#define GPBIAS2_GPADC1_SET		(2 << 4)
+/* GPADC1 Bias Current value in uA unit */
+#define GPBIAS2_GPADC1_UA		((GPBIAS2_GPADC1_SET >> 4) * 5 + 1)
+
+/* bit definitions of GPADC Misc 1 Register */
+#define GPMISC1_GPADC_EN		(1 << 0)
+
+/* bit definitions of Charger Control 6 Register */
+#define CC6_BAT_DET_GPADC1		1
+
+/* bit definitions of Coulomb Counter Reading Register */
+#define CCNT_AVG_SEL			(4 << 3)
+
+/* bit definitions of RTC miscellaneous Register1 */
+#define RTC_SOC_5LSB		(0x1F << 3)
+
+/* bit definitions of RTC Register1 */
+#define RTC_SOC_3MSB		(0x7)
+
+/* bit definitions of Power up Log register */
+#define BAT_WU_LOG			(1<<6)
+
+/* coulomb counter index */
+#define CCNT_POS1			0
+#define CCNT_POS2			1
+#define CCNT_NEG1			2
+#define CCNT_NEG2			3
+#define CCNT_SPOS			4
+#define CCNT_SNEG			5
+
+/* OCV -- Open Circuit Voltage */
+#define OCV_MODE_ACTIVE			0
+#define OCV_MODE_SLEEP			1
+
+/* Vbat range of CC for measuring Rbat */
+#define LOW_BAT_THRESHOLD		3600
+#define VBATT_RESISTOR_MIN		3800
+#define VBATT_RESISTOR_MAX		4100
+
+/* TBAT for batt, TINT for chip itself */
+#define PM860X_TEMP_TINT		(0)
+#define PM860X_TEMP_TBAT		(1)
+
+/*
+ * Battery temperature based on NTC resistor, defined
+ * corresponding resistor value  -- Ohm / C degeree.
+ */
+#define TBAT_NEG_25D		127773	/* -25 */
+#define TBAT_NEG_10D		54564	/* -10 */
+#define TBAT_0D			32330	/* 0 */
+#define TBAT_10D		19785	/* 10 */
+#define TBAT_20D		12468	/* 20 */
+#define TBAT_30D		8072	/* 30 */
+#define TBAT_40D		5356	/* 40 */
+
+struct pm860x_battery_info {
+	struct pm860x_chip *chip;
+	struct i2c_client *i2c;
+	struct device *dev;
+
+	struct power_supply battery;
+	struct mutex lock;
+	int status;
+	int irq_cc;
+	int irq_batt;
+	int max_capacity;
+	int resistor;		/* Battery Internal Resistor */
+	int last_capacity;
+	int start_soc;
+	unsigned present:1;
+	unsigned temp_type:1;	/* TINT or TBAT */
+};
+
+struct ccnt {
+	unsigned long long int pos;
+	unsigned long long int neg;
+	unsigned int spos;
+	unsigned int sneg;
+
+	int total_chg;		/* mAh(3.6C) */
+	int total_dischg;	/* mAh(3.6C) */
+};
+
+/*
+ * State of Charge.
+ * The first number is mAh(=3.6C), and the second number is percent point.
+ */
+int array_soc[][2] = { {4170, 100},
+{4154, 99}, {4136, 98}, {4122, 97}, {4107, 96},
+{4102, 95}, {4088, 94}, {4081, 93}, {4070, 92},
+{4060, 91}, {4053, 90}, {4044, 89}, {4035, 88},
+{4028, 87}, {4019, 86}, {4013, 85}, {4006, 84},
+{3995, 83}, {3987, 82}, {3982, 81}, {3976, 80},
+{3968, 79}, {3962, 78}, {3954, 77}, {3946, 76},
+{3941, 75}, {3934, 74}, {3929, 73}, {3922, 72},
+{3916, 71}, {3910, 70}, {3904, 69}, {3898, 68},
+{3892, 67}, {3887, 66}, {3880, 65}, {3874, 64},
+{3868, 63}, {3862, 62}, {3854, 61}, {3849, 60},
+{3843, 59}, {3840, 58}, {3833, 57}, {3829, 56},
+{3824, 55}, {3818, 54}, {3815, 53}, {3810, 52},
+{3808, 51}, {3804, 50}, {3801, 49}, {3798, 48},
+{3796, 47}, {3792, 46}, {3789, 45}, {3785, 44},
+{3784, 43}, {3782, 42}, {3780, 41}, {3777, 40},
+{3776, 39}, {3774, 38}, {3772, 37}, {3771, 36},
+{3769, 35}, {3768, 34}, {3764, 33}, {3763, 32},
+{3760, 31}, {3760, 30}, {3754, 29}, {3750, 28},
+{3749, 27}, {3744, 26}, {3740, 25}, {3734, 24},
+{3732, 23}, {3728, 22}, {3726, 21}, {3720, 20},
+{3716, 19}, {3709, 18}, {3703, 17}, {3698, 16},
+{3692, 15}, {3683, 14}, {3675, 13}, {3670, 12},
+{3665, 11}, {3661, 10}, {3657, 9}, {3649, 8},
+{3637, 7}, {3622, 6}, {3609, 5}, {3580, 4},
+{3558, 3}, {3540, 2}, {3510, 1}, {3429, 0}
+};
+
+static struct ccnt ccnt_data;
+
+static int calc_ccnt(struct pm860x_battery_info *info, struct ccnt *ccnt);
+static int calc_soc(struct pm860x_battery_info *info, int state, int *soc);
+static int clear_ccnt(struct pm860x_battery_info *info, struct ccnt *ccnt);
+static int measure_current(struct pm860x_battery_info *info, int *data);
+
+static irqreturn_t pm860x_coulomb_handler(int irq, void *data)
+{
+	struct pm860x_battery_info *info = data;
+
+	calc_ccnt(info, &ccnt_data);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t pm860x_batt_handler(int irq, void *data)
+{
+	struct pm860x_battery_info *info = data;
+	int ret;
+
+	mutex_lock(&info->lock);
+	ret = pm860x_reg_read(info->i2c, PM8607_STATUS_2);
+	if (ret & STATUS2_BAT) {
+		info->present = 1;
+		info->temp_type = PM860X_TEMP_TBAT;
+	} else {
+		info->present = 0;
+		info->temp_type = PM860X_TEMP_TINT;
+	}
+	mutex_unlock(&info->lock);
+	/* clear ccnt since battery is attached or dettached */
+	clear_ccnt(info, &ccnt_data);
+	return IRQ_HANDLED;
+}
+
+static void pm860x_init_battery(struct pm860x_battery_info *info)
+{
+	unsigned char buf[2];
+	int ret, data;
+	int bat_remove, soc;
+
+	/* measure enable on GPADC1 */
+	data = MEAS1_GP1;
+	if (info->temp_type == PM860X_TEMP_TINT)
+		data |= MEAS1_TINT;
+	ret = pm860x_set_bits(info->i2c, PM8607_MEAS_EN1, data, data);
+	if (ret)
+		goto out;
+
+	/* measure enable on IBAT, BAT_DET, CC. IBAT is depend on CC. */
+	data = MEAS3_IBAT | MEAS3_BAT_DET | MEAS3_CC;
+	ret = pm860x_set_bits(info->i2c, PM8607_MEAS_EN3, data, data);
+	if (ret)
+		goto out;
+
+	/* measure disable CC in sleep time  */
+	ret = pm860x_reg_write(info->i2c, PM8607_MEAS_OFF_TIME1, 0x82);
+	if (ret)
+		goto out;
+	ret = pm860x_reg_write(info->i2c, PM8607_MEAS_OFF_TIME2, 0x6c);
+	if (ret)
+		goto out;
+
+	/* enable GPADC */
+	ret = pm860x_set_bits(info->i2c, PM8607_GPADC_MISC1,
+			    GPMISC1_GPADC_EN, GPMISC1_GPADC_EN);
+	if (ret < 0)
+		goto out;
+
+	/* detect battery via GPADC1 */
+	ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL6,
+			    CC6_BAT_DET_GPADC1, CC6_BAT_DET_GPADC1);
+	if (ret < 0)
+		goto out;
+
+	ret = pm860x_set_bits(info->i2c, PM8607_CCNT, 7 << 3,
+			      CCNT_AVG_SEL);
+	if (ret < 0)
+		goto out;
+
+	/* set GPADC1 bias */
+	ret = pm860x_set_bits(info->i2c, PM8607_GP_BIAS2, 0xF << 4,
+			      GPBIAS2_GPADC1_SET);
+	if (ret < 0)
+		goto out;
+
+	/* check whether battery present) */
+	mutex_lock(&info->lock);
+	ret = pm860x_reg_read(info->i2c, PM8607_STATUS_2);
+	if (ret < 0) {
+		mutex_unlock(&info->lock);
+		goto out;
+	}
+	if (ret & STATUS2_BAT) {
+		info->present = 1;
+		info->temp_type = PM860X_TEMP_TBAT;
+	} else {
+		info->present = 0;
+		info->temp_type = PM860X_TEMP_TINT;
+	}
+	mutex_unlock(&info->lock);
+
+	calc_soc(info, OCV_MODE_ACTIVE, &soc);
+
+	data = pm860x_reg_read(info->i2c, PM8607_POWER_UP_LOG);
+	bat_remove = data & BAT_WU_LOG;
+
+	dev_dbg(info->dev, "battery wake up? %s\n",
+		bat_remove != 0 ? "yes" : "no");
+
+	/* restore SOC from RTC domain register */
+	if (bat_remove == 0) {
+		buf[0] = pm860x_reg_read(info->i2c, PM8607_RTC_MISC2);
+		buf[1] = pm860x_reg_read(info->i2c, PM8607_RTC1);
+		data = ((buf[1] & 0x3) << 5) | ((buf[0] >> 3) & 0x1F);
+		if (data > soc + 15)
+			info->start_soc = soc;
+		else if (data < soc - 15)
+			info->start_soc = soc;
+		else
+			info->start_soc = data;
+		dev_dbg(info->dev, "soc_rtc %d, soc_ocv :%d\n", data, soc);
+	} else {
+		pm860x_set_bits(info->i2c, PM8607_POWER_UP_LOG,
+				BAT_WU_LOG, BAT_WU_LOG);
+		info->start_soc = soc;
+	}
+	info->last_capacity = info->start_soc;
+	dev_dbg(info->dev, "init soc : %d\n", info->last_capacity);
+out:
+	return;
+}
+
+/*
+ * register 1 bit[7:0] -- bit[11:4] of measured value of voltage
+ * register 0 bit[3:0] -- bit[3:0] of measured value of voltage
+ */
+static int measure_12bit_voltage(struct pm860x_battery_info *info,
+				 int offset, int *data)
+{
+	unsigned char buf[2];
+	int ret;
+
+	if (!data)
+		return -EINVAL;
+
+	ret = pm860x_bulk_read(info->i2c, offset, 2, buf);
+	if (ret < 0)
+		return ret;
+
+	*data = ((buf[0] & 0xff) << 4) | (buf[1] & 0x0f);
+	/* V_MEAS(mV) = data * 1.8 * 1000 / (2^12) */
+	*data = ((*data & 0xfff) * 9 * 25) >> 9;
+	return 0;
+}
+
+static int measure_vbatt(struct pm860x_battery_info *info, int state,
+			 int *data)
+{
+	unsigned char buf[5];
+	int ret = 0;
+
+	switch (state) {
+	case OCV_MODE_ACTIVE:
+		ret = measure_12bit_voltage(info, PM8607_VBAT_MEAS1, data);
+		if (ret)
+			return ret;
+		/* V_BATT_MEAS(mV) = value * 3 * 1.8 * 1000 / (2^12) */
+		*data *= 3;
+		break;
+	case OCV_MODE_SLEEP:
+		/*
+		 * voltage value of VBATT in sleep mode is saved in different
+		 * registers.
+		 * bit[11:10] -- bit[7:6] of LDO9(0x18)
+		 * bit[9:8] -- bit[7:6] of LDO8(0x17)
+		 * bit[7:6] -- bit[7:6] of LDO7(0x16)
+		 * bit[5:4] -- bit[7:6] of LDO6(0x15)
+		 * bit[3:0] -- bit[7:4] of LDO5(0x14)
+		 */
+		ret = pm860x_bulk_read(info->i2c, PM8607_LDO5, 5, buf);
+		if (ret < 0)
+			return ret;
+		ret = ((buf[4] >> 6) << 10) | ((buf[3] >> 6) << 8)
+		    | ((buf[2] >> 6) << 6) | ((buf[1] >> 6) << 4)
+		    | (buf[0] >> 4);
+		/* V_BATT_MEAS(mV) = data * 3 * 1.8 * 1000 / (2^12) */
+		*data = ((*data & 0xff) * 27 * 25) >> 9;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void set_temp_threshold(struct pm860x_battery_info *info,
+			       int min, int max)
+{
+	int data;
+
+	/* (tmp << 8) / 1800 */
+	if (min <= 0)
+		data = 0;
+	else
+		data = (min << 8) / 1800;
+	pm860x_reg_write(info->i2c, PM8607_GPADC1_HIGHTH, data);
+	dev_dbg(info->dev, "TEMP_HIGHTH : min: %d, 0x%x\n", min, data);
+
+	if (max <= 0)
+		data = 0xff;
+	else
+		data = (max << 8) / 1800;
+	pm860x_reg_write(info->i2c, PM8607_GPADC1_LOWTH, data);
+	dev_dbg(info->dev, "TEMP_LOWTH:max : %d, 0x%x\n", max, data);
+}
+
+static int measure_temp(struct pm860x_battery_info *info, int *data)
+{
+	int ret, temp;
+	int min, max;
+
+	if (!data)
+		return -EINVAL;
+	if (info->temp_type == PM860X_TEMP_TINT) {
+		ret = measure_12bit_voltage(info, PM8607_TINT_MEAS1, data);
+		if (ret)
+			return ret;
+		*data = (*data - 884) * 1000 / 3611;
+	} else {
+		ret = measure_12bit_voltage(info, PM8607_GPADC1_MEAS1, data);
+		if (ret)
+			return ret;
+		/* meausered Vtbat(mV) / Ibias_current(11uA)*/
+		*data = (*data * 1000) / GPBIAS2_GPADC1_UA;
+
+		if (*data > TBAT_NEG_25D) {
+			temp = -30;	/* over cold , suppose -30 roughly */
+			max = TBAT_NEG_10D * GPBIAS2_GPADC1_UA / 1000;
+			set_temp_threshold(info, 0, max);
+		} else if (*data > TBAT_NEG_10D) {
+			temp = -15;	/* -15 degree, code */
+			max = TBAT_NEG_10D * GPBIAS2_GPADC1_UA / 1000;
+			set_temp_threshold(info, 0, max);
+		} else if (*data > TBAT_0D) {
+			temp = -5;	/* -5 degree */
+			min = TBAT_NEG_10D * GPBIAS2_GPADC1_UA / 1000;
+			max = TBAT_40D * GPBIAS2_GPADC1_UA / 1000;
+			set_temp_threshold(info, min, max);
+		} else if (*data > TBAT_10D) {
+			temp = 5;	/* in range of (0, 10) */
+			min = TBAT_NEG_10D * GPBIAS2_GPADC1_UA / 1000;
+			max = TBAT_40D * GPBIAS2_GPADC1_UA / 1000;
+			set_temp_threshold(info, min, max);
+		} else if (*data > TBAT_20D) {
+			temp = 15;	/* in range of (10, 20) */
+			min = TBAT_NEG_10D * GPBIAS2_GPADC1_UA / 1000;
+			max = TBAT_40D * GPBIAS2_GPADC1_UA / 1000;
+			set_temp_threshold(info, min, max);
+		} else if (*data > TBAT_30D) {
+			temp = 25;	/* in range of (20, 30) */
+			min = TBAT_NEG_10D * GPBIAS2_GPADC1_UA / 1000;
+			max = TBAT_40D * GPBIAS2_GPADC1_UA / 1000;
+			set_temp_threshold(info, min, max);
+		} else if (*data > TBAT_40D) {
+			temp = 35;	/* in range of (30, 40) */
+			min = TBAT_NEG_10D * GPBIAS2_GPADC1_UA / 1000;
+			max = TBAT_40D * GPBIAS2_GPADC1_UA / 1000;
+			set_temp_threshold(info, min, max);
+		} else {
+			min = TBAT_40D * GPBIAS2_GPADC1_UA / 1000;
+			set_temp_threshold(info, min, 0);
+			temp = 45;	/* over heat ,suppose 45 roughly */
+		}
+
+		dev_dbg(info->dev, "temp_C:%d C,temp_mv:%d mv\n", temp, *data);
+		*data = temp;
+	}
+	return 0;
+}
+
+/*
+ * Return value is signed data.
+ * Negative value means discharging, and positive value means charging.
+ */
+static int measure_current(struct pm860x_battery_info *info, int *data)
+{
+	unsigned char buf[2];
+	short s;
+	int ret;
+
+	if (!data)
+		return -EINVAL;
+
+	ret = pm860x_bulk_read(info->i2c, PM8607_IBAT_MEAS1, 2, buf);
+	if (ret < 0)
+		return ret;
+
+	s = ((buf[0] & 0xff) << 8) | (buf[1] & 0xff);
+	/* current(mA) = value * 0.125 */
+	*data = s >> 3;
+	return 0;
+}
+
+static int set_charger_current(struct pm860x_battery_info *info, int data,
+			       int *old)
+{
+	int ret;
+
+	if (data < 50 || data > 1600 || !old)
+		return -EINVAL;
+
+	data = ((data - 50) / 50) & 0x1f;
+	*old = pm860x_reg_read(info->i2c, PM8607_CHG_CTRL2);
+	*old = (*old & 0x1f) * 50 + 50;
+	ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL2, 0x1f, data);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int calc_resistor(struct pm860x_battery_info *info)
+{
+	int ret, i, data;
+	int vbatt_sum1, vbatt_sum2, chg_current;
+	int ibatt_sum1, ibatt_sum2;
+
+	ret = measure_current(info, &data);
+	/* make sure that charging is launched by data > 0 */
+	if (ret || data < 0)
+		goto out;
+
+	ret = measure_vbatt(info, OCV_MODE_ACTIVE, &data);
+	if (ret)
+		goto out;
+	/* calculate resistor only in CC charge mode */
+	if (data < VBATT_RESISTOR_MIN || data > VBATT_RESISTOR_MAX)
+		goto out;
+
+	/* current is saved */
+	if (set_charger_current(info, 500, &chg_current))
+		goto out;
+
+	msleep(500);
+
+	for (i = 0, vbatt_sum1 = 0, ibatt_sum1 = 0; i < 10; i++) {
+		ret = measure_vbatt(info, OCV_MODE_ACTIVE, &data);
+		if (ret)
+			goto out_meas;
+		vbatt_sum1 += data;
+		ret = measure_current(info, &data);
+		if (ret)
+			goto out_meas;
+
+		if (data < 0)
+			ibatt_sum1 = ibatt_sum1 - data;	/* discharging */
+		else
+			ibatt_sum1 = ibatt_sum1 + data;	/* charging */
+	}
+
+	if (set_charger_current(info, 100, &ret))
+		goto out_meas;
+
+	msleep(500);
+
+	for (i = 0, vbatt_sum2 = 0, ibatt_sum2 = 0; i < 10; i++) {
+		ret = measure_vbatt(info, OCV_MODE_ACTIVE, &data);
+		if (ret)
+			goto out_meas;
+		vbatt_sum2 += data;
+		ret = measure_current(info, &data);
+		if (ret)
+			goto out_meas;
+
+		if (data < 0)
+			ibatt_sum2 = ibatt_sum2 - data;	/* discharging */
+		else
+			ibatt_sum2 = ibatt_sum2 + data;	/* charging */
+	}
+
+	/* restore current setting */
+	if (set_charger_current(info, chg_current, &ret))
+		goto out_meas;
+
+	if ((vbatt_sum1 > vbatt_sum2) && (ibatt_sum1 > ibatt_sum2)
+	    && (ibatt_sum2 > 0)) {
+		/* calculate resistor in discharging case */
+		data = 1000 * (vbatt_sum1 - vbatt_sum2)
+		    / (ibatt_sum1 - ibatt_sum2);
+		if ((data - info->resistor > 0)
+		    && (data - info->resistor < info->resistor))
+			info->resistor = data;
+		if ((info->resistor - data > 0)
+		    && (info->resistor - data < data))
+			info->resistor = data;
+	}
+	return 0;
+
+out_meas:
+	set_charger_current(info, chg_current, &ret);
+out:
+	return -EINVAL;
+}
+
+static int read_ccnt(struct pm860x_battery_info *info, int offset,
+		     int *ccnt)
+{
+	unsigned char buf[2];
+	int ret;
+
+	if (!ccnt)
+		return -EINVAL;
+
+	ret = pm860x_set_bits(info->i2c, PM8607_CCNT, 7, offset & 7);
+	if (ret < 0)
+		goto out;
+	ret = pm860x_bulk_read(info->i2c, PM8607_CCNT_MEAS1, 2, buf);
+	if (ret < 0)
+		goto out;
+	*ccnt = ((buf[0] & 0xff) << 8) | (buf[1] & 0xff);
+	return 0;
+out:
+	return ret;
+}
+
+static int calc_ccnt(struct pm860x_battery_info *info, struct ccnt *ccnt)
+{
+	unsigned int sum;
+	int ret, data;
+
+	ret = read_ccnt(info, CCNT_POS1, &data);
+	if (ret)
+		goto out;
+	sum = data & 0xffff;
+	ret = read_ccnt(info, CCNT_POS2, &data);
+	if (ret)
+		goto out;
+	sum |= (data & 0xffff) << 16;
+	ccnt->pos += sum;
+
+	ret = read_ccnt(info, CCNT_NEG1, &data);
+	if (ret)
+		goto out;
+	sum = data & 0xffff;
+	ret = read_ccnt(info, CCNT_NEG2, &data);
+	if (ret)
+		goto out;
+	sum |= (data & 0xffff) << 16;
+	sum = ~sum + 1;		/* since it's negative */
+	ccnt->neg += sum;
+
+	ret = read_ccnt(info, CCNT_SPOS, &data);
+	if (ret)
+		goto out;
+	ccnt->spos += data;
+	ret = read_ccnt(info, CCNT_SNEG, &data);
+	if (ret)
+		goto out;
+
+	/*
+	 * charge(mAh)  = count * 1.6984 * 1e(-8)
+	 *              = count * 16984 * 1.024 * 1.024 * 1.024 / (2 ^ 40)
+	 *              = count * 18236 / (2 ^ 40)
+	 */
+	ccnt->total_chg = (int) ((ccnt->pos * 18236) >> 40);
+	ccnt->total_dischg = (int) ((ccnt->neg * 18236) >> 40);
+	return 0;
+out:
+	return ret;
+}
+
+static int clear_ccnt(struct pm860x_battery_info *info, struct ccnt *ccnt)
+{
+	int data;
+
+	memset(ccnt, 0, sizeof(struct ccnt));
+	/* read to clear ccnt */
+	read_ccnt(info, CCNT_POS1, &data);
+	read_ccnt(info, CCNT_POS2, &data);
+	read_ccnt(info, CCNT_NEG1, &data);
+	read_ccnt(info, CCNT_NEG2, &data);
+	read_ccnt(info, CCNT_SPOS, &data);
+	read_ccnt(info, CCNT_SNEG, &data);
+	return 0;
+}
+
+/* Calculate Open Circuit Voltage */
+static int calc_ocv(struct pm860x_battery_info *info, int *ocv)
+{
+	int ret, i, data;
+	int vbatt_avg, vbatt_sum, ibatt_avg, ibatt_sum;
+
+	if (!ocv)
+		return -EINVAL;
+
+	for (i = 0, ibatt_sum = 0, vbatt_sum = 0; i < 10; i++) {
+		ret = measure_vbatt(info, OCV_MODE_ACTIVE, &data);
+		if (ret)
+			goto out;
+		vbatt_sum += data;
+		ret = measure_current(info, &data);
+		if (ret)
+			goto out;
+		ibatt_sum += data;
+	}
+	vbatt_avg = vbatt_sum / 10;
+	ibatt_avg = ibatt_sum / 10;
+
+	mutex_lock(&info->lock);
+	if (info->present)
+		*ocv = vbatt_avg - ibatt_avg * info->resistor / 1000;
+	else
+		*ocv = vbatt_avg;
+	mutex_unlock(&info->lock);
+	dev_dbg(info->dev, "VBAT average:%d, OCV:%d\n", vbatt_avg, *ocv);
+	return 0;
+out:
+	return ret;
+}
+
+/* Calculate State of Charge (percent points) */
+static int calc_soc(struct pm860x_battery_info *info, int state, int *soc)
+{
+	int i, ocv, count, ret = -EINVAL;
+
+	if (!soc)
+		return -EINVAL;
+
+	switch (state) {
+	case OCV_MODE_ACTIVE:
+		ret = calc_ocv(info, &ocv);
+		break;
+	case OCV_MODE_SLEEP:
+		ret = measure_vbatt(info, OCV_MODE_SLEEP, &ocv);
+		break;
+	}
+	if (ret)
+		goto out;
+
+	count = ARRAY_SIZE(array_soc);
+	if (ocv < array_soc[count - 1][0]) {
+		*soc = 0;
+		return 0;
+	}
+
+	for (i = 0; i < count; i++) {
+		if (ocv >= array_soc[i][0]) {
+			*soc = array_soc[i][1];
+			break;
+		}
+	}
+	return 0;
+out:
+	return ret;
+}
+
+static int calc_capacity(struct pm860x_battery_info *info, int *cap)
+{
+	int ret, data, ibat;
+	int cap_ocv = 0, cap_cc = 0;
+
+	ret = calc_ccnt(info, &ccnt_data);
+	if (ret)
+		goto out;
+soc:
+	data = info->max_capacity * info->start_soc / 100;
+	if (ccnt_data.total_dischg - ccnt_data.total_chg <= data) {
+		cap_cc =
+		    data + ccnt_data.total_chg - ccnt_data.total_dischg;
+	} else {
+		clear_ccnt(info, &ccnt_data);
+		calc_soc(info, OCV_MODE_ACTIVE, &info->start_soc);
+		dev_dbg(info->dev, "restart soc = %d !\n",
+			info->start_soc);
+		goto soc;
+	}
+
+	cap_cc = cap_cc * 100 / info->max_capacity;
+	if (cap_cc < 0)
+		cap_cc = 0;
+	else if (cap_cc > 100)
+		cap_cc = 100;
+
+	dev_dbg(info->dev, "%s, last cap : %d", __func__,
+		info->last_capacity);
+
+	ret = measure_current(info, &ibat);
+	if (ret)
+		goto out;
+	/* Calculate the capacity when discharging(ibat < 0) */
+	if (ibat < 0) {
+		ret = calc_soc(info, OCV_MODE_ACTIVE, &cap_ocv);
+		if (ret)
+			cap_ocv = info->last_capacity;
+		ret = measure_vbatt(info, OCV_MODE_ACTIVE, &data);
+		if (ret)
+			goto out;
+		if (data <= LOW_BAT_THRESHOLD) {
+			/* choose the lower capacity value to report
+			 * between vbat and CC when vbat < 3.6v;
+			 * than 3.6v;
+			 */
+			*cap = min(cap_ocv, cap_cc);
+		} else {
+			/* when detect vbat > 3.6v, but cap_cc < 15,and
+			 * cap_ocv is 10% larger than cap_cc, we can think
+			 * CC have some accumulation error, switch to OCV
+			 * to estimate capacity;
+			 * */
+			if (cap_cc < 15 && cap_ocv - cap_cc > 10)
+				*cap = cap_ocv;
+			else
+				*cap = cap_cc;
+		}
+		/* when discharging, make sure current capacity
+		 * is lower than last*/
+		if (*cap > info->last_capacity)
+			*cap = info->last_capacity;
+	} else {
+		*cap = cap_cc;
+	}
+	info->last_capacity = *cap;
+
+	dev_dbg(info->dev, "%s, cap_ocv:%d cap_cc:%d, cap:%d\n",
+		(ibat < 0) ? "discharging" : "charging",
+		 cap_ocv, cap_cc, *cap);
+	/*
+	 * store the current capacity to RTC domain register,
+	 * after next power up , it will be restored.
+	 */
+	pm860x_set_bits(info->i2c, PM8607_RTC_MISC2, RTC_SOC_5LSB,
+			(*cap & 0x1F) << 3);
+	pm860x_set_bits(info->i2c, PM8607_RTC1, RTC_SOC_3MSB,
+			((*cap >> 5) & 0x3));
+	return 0;
+out:
+	return ret;
+}
+
+static void pm860x_external_power_changed(struct power_supply *psy)
+{
+	struct pm860x_battery_info *info;
+
+	info = container_of(psy, struct pm860x_battery_info, battery);
+	calc_resistor(info);
+	return;
+}
+
+static int pm860x_batt_get_prop(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct pm860x_battery_info *info =
+	    dev_get_drvdata(psy->dev->parent);
+	int data, ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = info->present;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = calc_capacity(info, &data);
+		if (ret)
+			goto out;
+		if (data < 0)
+			data = 0;
+		else if (data > 100)
+			data = 100;
+		/* return 100 if battery is not attached */
+		if (!info->present)
+			data = 100;
+		val->intval = data;
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		/* return real vbatt Voltage */
+		ret = measure_vbatt(info, OCV_MODE_ACTIVE, &data);
+		if (ret)
+			goto out;
+		val->intval = data * 1000;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		/* return Open Circuit Voltage (not measured voltage) */
+		ret = calc_ocv(info, &data);
+		if (ret)
+			goto out;
+		val->intval = data * 1000;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = measure_current(info, &data);
+		if (ret)
+			goto out;
+		val->intval = data;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		if (info->present) {
+			ret = measure_temp(info, &data);
+			if (ret)
+				goto out;
+			data *= 10;
+		} else {
+			/* Fake Temp 25C Without Battery */
+			data = 250;
+		}
+		val->intval = data;
+		break;
+	default:
+		return -ENODEV;
+	}
+	return 0;
+out:
+	return ret;
+}
+
+static int pm860x_batt_set_prop(struct power_supply *psy,
+				       enum power_supply_property psp,
+				       const union power_supply_propval *val)
+{
+	struct pm860x_battery_info *info =
+	    dev_get_drvdata(psy->dev->parent);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		clear_ccnt(info, &ccnt_data);
+		info->start_soc = 100;
+		dev_dbg(info->dev, "chg done, update soc = %d\n",
+			info->start_soc);
+		break;
+	default:
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+
+static enum power_supply_property pm860x_batt_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+};
+
+static __devinit int pm860x_battery_probe(struct platform_device *pdev)
+{
+	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct pm860x_battery_info *info;
+	struct pm860x_power_pdata *pdata;
+	int ret;
+
+	info = kzalloc(sizeof(struct pm860x_battery_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->irq_cc = platform_get_irq(pdev, 0);
+	if (info->irq_cc < 0) {
+		dev_err(&pdev->dev, "No IRQ resource!\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	info->irq_batt = platform_get_irq(pdev, 1);
+	if (info->irq_batt < 0) {
+		dev_err(&pdev->dev, "No IRQ resource!\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	info->chip = chip;
+	info->i2c =
+	    (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
+	info->dev = &pdev->dev;
+	info->status = POWER_SUPPLY_STATUS_UNKNOWN;
+	pdata = pdev->dev.platform_data;
+
+	ret = request_threaded_irq(info->irq_cc, NULL,
+				pm860x_coulomb_handler, IRQF_ONESHOT,
+				"coulomb", info);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			info->irq_cc, ret);
+		goto out;
+	}
+	ret = request_threaded_irq(info->irq_batt, NULL, pm860x_batt_handler,
+				IRQF_ONESHOT, "battery", info);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			info->irq_batt, ret);
+		goto out_coulomb;
+	}
+
+	mutex_init(&info->lock);
+	platform_set_drvdata(pdev, info);
+
+	pm860x_init_battery(info);
+
+	info->battery.name = "battery-monitor";
+	info->battery.type = POWER_SUPPLY_TYPE_BATTERY;
+	info->battery.properties = pm860x_batt_props;
+	info->battery.num_properties = ARRAY_SIZE(pm860x_batt_props);
+	info->battery.get_property = pm860x_batt_get_prop;
+	info->battery.set_property = pm860x_batt_set_prop;
+	info->battery.external_power_changed = pm860x_external_power_changed;
+
+	if (pdata && pdata->max_capacity)
+		info->max_capacity = pdata->max_capacity;
+	else
+		info->max_capacity = 1500;	/* set default capacity */
+	if (pdata && pdata->resistor)
+		info->resistor = pdata->resistor;
+	else
+		info->resistor = 300;	/* set default internal resistor */
+
+	ret = power_supply_register(&pdev->dev, &info->battery);
+	if (ret)
+		goto out_reg;
+	info->battery.dev->parent = &pdev->dev;
+
+	return 0;
+
+out_reg:
+	free_irq(info->irq_batt, info);
+out_coulomb:
+	free_irq(info->irq_cc, info);
+out:
+	kfree(info);
+	return ret;
+}
+
+static int __devexit pm860x_battery_remove(struct platform_device *pdev)
+{
+	struct pm860x_battery_info *info = platform_get_drvdata(pdev);
+
+	power_supply_unregister(&info->battery);
+	free_irq(info->irq_batt, info);
+	free_irq(info->irq_cc, info);
+	kfree(info);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int pm860x_battery_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int pm860x_battery_resume(struct device *dev)
+{
+	return 0;
+}
+#endif
+static SIMPLE_DEV_PM_OPS(pm860x_battery_pm_ops, pm860x_battery_suspend,
+			 pm860x_battery_resume);
+
+static struct platform_driver pm860x_battery_driver = {
+	.driver = {
+		   .name = "88pm860x-battery",
+		   .owner = THIS_MODULE,
+		   .pm = &pm860x_battery_pm_ops,
+		   },
+	.probe = pm860x_battery_probe,
+	.remove = __devexit_p(pm860x_battery_remove),
+};
+
+module_platform_driver(pm860x_battery_driver);
+
+MODULE_DESCRIPTION("Marvell 88PM860x Battery driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/power/88pm860x_charger.c b/drivers/power/88pm860x_charger.c
new file mode 100644
index 0000000..0089ad4
--- /dev/null
+++ b/drivers/power/88pm860x_charger.c
@@ -0,0 +1,833 @@
+/*
+ * Battery driver for Marvell 88PM860x PMIC
+ *
+ * Copyright (c) 2012 Marvell International Ltd.
+ * Author:	Jett Zhou <jtzhou@marvell.com>
+ *		Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/power_supply.h>
+#include <linux/mfd/88pm860x.h>
+#include <linux/delay.h>
+#include <linux/uaccess.h>
+#include <asm/div64.h>
+
+
+/* bit definitions of Status Query Interface 2 */
+#define STATUS2_CHG		(1 << 2)
+
+/* bit definitions of Reset Out Register */
+#define RESET_SW_PD		(1 << 7)
+
+/* bit definitions of PreReg 1 */
+#define PREREG1_90MA		(0x0)
+#define PREREG1_180MA		(0x1)
+#define PREREG1_450MA		(0x4)
+#define PREREG1_540MA		(0x5)
+#define PREREG1_1350MA		(0xE)
+#define PREREG1_VSYS_4_5V	(3 << 4)
+
+/* bit definitions of Charger Control 1 Register */
+#define CC1_MODE_OFF		(0)
+#define CC1_MODE_PRECHARGE	(1)
+#define CC1_MODE_FASTCHARGE	(2)
+#define CC1_MODE_PULSECHARGE	(3)
+#define CC1_ITERM_20MA		(0 << 2)
+#define CC1_ITERM_60MA		(2 << 2)
+#define CC1_VFCHG_4_2V		(9 << 4)
+
+/* bit definitions of Charger Control 2 Register */
+#define CC2_ICHG_100MA		(0x1)
+#define CC2_ICHG_500MA		(0x9)
+#define CC2_ICHG_1000MA		(0x13)
+
+/* bit definitions of Charger Control 3 Register */
+#define CC3_180MIN_TIMEOUT	(0x6 << 4)
+#define CC3_270MIN_TIMEOUT	(0x7 << 4)
+#define CC3_360MIN_TIMEOUT	(0xA << 4)
+#define CC3_DISABLE_TIMEOUT	(0xF << 4)
+
+/* bit definitions of Charger Control 4 Register */
+#define CC4_IPRE_40MA		(7)
+#define CC4_VPCHG_3_2V		(3 << 4)
+#define CC4_IFCHG_MON_EN	(1 << 6)
+#define CC4_BTEMP_MON_EN	(1 << 7)
+
+/* bit definitions of Charger Control 6 Register */
+#define CC6_BAT_OV_EN		(1 << 2)
+#define CC6_BAT_UV_EN		(1 << 3)
+#define CC6_UV_VBAT_SET		(0x3 << 6)	/* 2.8v */
+
+/* bit definitions of Charger Control 7 Register */
+#define CC7_BAT_REM_EN		(1 << 3)
+#define CC7_IFSM_EN		(1 << 7)
+
+/* bit definitions of Measurement Enable 1 Register */
+#define MEAS1_VBAT		(1 << 0)
+
+/* bit definitions of Measurement Enable 3 Register */
+#define MEAS3_IBAT_EN		(1 << 0)
+#define MEAS3_CC_EN		(1 << 2)
+
+#define FSM_INIT		0
+#define FSM_DISCHARGE		1
+#define FSM_PRECHARGE		2
+#define FSM_FASTCHARGE		3
+
+#define PRECHARGE_THRESHOLD	3100
+#define POWEROFF_THRESHOLD	3400
+#define CHARGE_THRESHOLD	4000
+#define DISCHARGE_THRESHOLD	4180
+
+/* over-temperature on PM8606 setting */
+#define OVER_TEMP_FLAG		(1 << 6)
+#define OVTEMP_AUTORECOVER	(1 << 3)
+
+/* over-voltage protect on vchg setting mv */
+#define VCHG_NORMAL_LOW		4200
+#define VCHG_NORMAL_CHECK	5800
+#define VCHG_NORMAL_HIGH	6000
+#define VCHG_OVP_LOW		5500
+
+struct pm860x_charger_info {
+	struct pm860x_chip *chip;
+	struct i2c_client *i2c;
+	struct i2c_client *i2c_8606;
+	struct device *dev;
+
+	struct power_supply usb;
+	struct mutex lock;
+	int irq_nums;
+	int irq[7];
+	unsigned state:3;	/* fsm state */
+	unsigned online:1;	/* usb charger */
+	unsigned present:1;	/* battery present */
+	unsigned allowed:1;
+};
+
+static char *pm860x_supplied_to[] = {
+	"battery-monitor",
+};
+
+static int stop_charge(struct pm860x_charger_info *info, int vbatt);
+static int set_charging_fsm(struct pm860x_charger_info *info);
+static void set_vbatt_threshold(struct pm860x_charger_info *info,
+				int min, int max);
+static void set_vchg_threshold(struct pm860x_charger_info *info,
+			       int min, int max);
+static int measure_vchg(struct pm860x_charger_info *info, int *data);
+
+static irqreturn_t pm860x_charger_handler(int irq, void *data)
+{
+	struct pm860x_charger_info *info = data;
+	int ret;
+
+	mutex_lock(&info->lock);
+	ret = pm860x_reg_read(info->i2c, PM8607_STATUS_2);
+	if (ret < 0) {
+		mutex_unlock(&info->lock);
+		goto out;
+	}
+	if (ret & STATUS2_CHG) {
+		info->online = 1;
+		info->allowed = 1;
+	} else {
+		info->online = 0;
+		info->allowed = 0;
+	}
+	mutex_unlock(&info->lock);
+	dev_dbg(info->dev, "%s, Charger:%s, Allowed:%d\n", __func__,
+		(info->online) ? "online" : "N/A", info->allowed);
+
+	set_charging_fsm(info);
+
+	power_supply_changed(&info->usb);
+out:
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t pm860x_temp_handler(int irq, void *data)
+{
+	struct power_supply *psy;
+	struct pm860x_charger_info *info = data;
+	union power_supply_propval temp;
+	int value, ret = -EINVAL;
+
+	psy = power_supply_get_by_name(pm860x_supplied_to[0]);
+	if (!psy)
+		goto out;
+	ret = psy->get_property(psy, POWER_SUPPLY_PROP_TEMP, &temp);
+	if (ret)
+		goto out;
+	value = temp.intval / 10;
+
+	mutex_lock(&info->lock);
+	/* Temperature < -10 C or >40 C, Will not allow charge */
+	if (value < -10 || value > 40)
+		info->allowed = 0;
+	else
+		info->allowed = 1;
+	dev_dbg(info->dev, "%s, Allowed: %d\n", __func__, info->allowed);
+	mutex_unlock(&info->lock);
+
+	set_charging_fsm(info);
+out:
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t pm860x_exception_handler(int irq, void *data)
+{
+	struct pm860x_charger_info *info = data;
+
+	mutex_lock(&info->lock);
+	info->allowed = 0;
+	mutex_unlock(&info->lock);
+	dev_dbg(info->dev, "%s, irq: %d\n", __func__, irq);
+
+	set_charging_fsm(info);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t pm860x_done_handler(int irq, void *data)
+{
+	struct pm860x_charger_info *info = data;
+	struct power_supply *psy;
+	union power_supply_propval val;
+	int ret, vbatt;
+
+	mutex_lock(&info->lock);
+	/* pre-charge done, will transimit to fast-charge stage */
+	if (info->state == FSM_PRECHARGE) {
+		info->allowed = 1;
+		goto out;
+	}
+	/*
+	 * Fast charge done, delay to read
+	 * the correct status of CHG_DET.
+	 */
+	mdelay(5);
+	info->allowed = 0;
+	psy = power_supply_get_by_name(pm860x_supplied_to[0]);
+	if (!psy)
+		goto out;
+	ret = psy->get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW, &val);
+	if (ret)
+		goto out;
+	vbatt = val.intval / 1000;
+	/*
+	 * CHG_DONE interrupt is faster than CHG_DET interrupt when
+	 * plug in/out usb, So we can not rely on info->online, we
+	 * need check pm8607 status register to check usb is online
+	 * or not, then we can decide it is real charge done
+	 * automatically or it is triggered by usb plug out;
+	 */
+	ret = pm860x_reg_read(info->i2c, PM8607_STATUS_2);
+	if (ret < 0)
+		goto out;
+	if (vbatt > CHARGE_THRESHOLD && ret & STATUS2_CHG)
+		psy->set_property(psy, POWER_SUPPLY_PROP_CHARGE_FULL, &val);
+
+out:
+	mutex_unlock(&info->lock);
+	dev_dbg(info->dev, "%s, Allowed: %d\n", __func__, info->allowed);
+	set_charging_fsm(info);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t pm860x_vbattery_handler(int irq, void *data)
+{
+	struct pm860x_charger_info *info = data;
+
+	mutex_lock(&info->lock);
+
+	set_vbatt_threshold(info, 0, 0);
+
+	if (info->present && info->online)
+		info->allowed = 1;
+	else
+		info->allowed = 0;
+	mutex_unlock(&info->lock);
+	dev_dbg(info->dev, "%s, Allowed: %d\n", __func__, info->allowed);
+
+	set_charging_fsm(info);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t pm860x_vchg_handler(int irq, void *data)
+{
+	struct pm860x_charger_info *info = data;
+	int vchg = 0, status = 0;
+
+	if (info->present)
+		goto out;
+
+	measure_vchg(info, &vchg);
+
+	mutex_lock(&info->lock);
+	if (!info->online) {
+		/* check if over-temp on pm8606 or not */
+		status = pm860x_reg_read(info->i2c_8606, PM8606_FLAGS);
+		if (status & OVER_TEMP_FLAG) {
+			/* clear over temp flag and set auto recover */
+			pm860x_set_bits(info->i2c_8606, PM8606_FLAGS,
+					OVER_TEMP_FLAG, OVER_TEMP_FLAG);
+			pm860x_set_bits(info->i2c_8606,
+					PM8606_VSYS,
+					OVTEMP_AUTORECOVER,
+					OVTEMP_AUTORECOVER);
+			dev_dbg(info->dev,
+				"%s, pm8606 over-temp occure\n", __func__);
+		}
+	}
+
+	if (vchg > VCHG_NORMAL_CHECK) {
+		set_vchg_threshold(info, VCHG_OVP_LOW, 0);
+		info->allowed = 0;
+		dev_dbg(info->dev,
+			"%s,pm8607 over-vchg occure,vchg = %dmv\n",
+			__func__, vchg);
+	} else if (vchg < VCHG_OVP_LOW) {
+		set_vchg_threshold(info, VCHG_NORMAL_LOW,
+				   VCHG_NORMAL_HIGH);
+		info->allowed = 1;
+		dev_dbg(info->dev,
+			"%s,pm8607 over-vchg recover,vchg = %dmv\n",
+			__func__, vchg);
+	}
+	mutex_unlock(&info->lock);
+
+	dev_dbg(info->dev, "%s, Allowed: %d\n", __func__, info->allowed);
+	set_charging_fsm(info);
+out:
+	return IRQ_HANDLED;
+}
+
+static ssize_t stop_charging(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct pm860x_charger_info *info = dev_get_drvdata(dev);
+	int disable;
+
+	sscanf(buf, "%d", &disable);
+	if (disable && info) {
+		dev_dbg(info->dev, "stop charging by manual\n");
+
+		mutex_lock(&info->lock);
+		info->allowed = 0;
+		mutex_unlock(&info->lock);
+		set_charging_fsm(info);
+	}
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static DEVICE_ATTR(stop, S_IWUSR, NULL, stop_charging);
+
+static int pm860x_usb_get_prop(struct power_supply *psy,
+			       enum power_supply_property psp,
+			       union power_supply_propval *val)
+{
+	struct pm860x_charger_info *info =
+	    dev_get_drvdata(psy->dev->parent);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = (info->state == FSM_FASTCHARGE ||
+				info->state == FSM_PRECHARGE);
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = info->online;
+		break;
+	default:
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static enum power_supply_property pm860x_usb_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static int measure_vchg(struct pm860x_charger_info *info, int *data)
+{
+	unsigned char buf[2];
+	int ret = 0;
+
+	ret = pm860x_bulk_read(info->i2c, PM8607_VCHG_MEAS1, 2, buf);
+	if (ret < 0)
+		return ret;
+
+	*data = ((buf[0] & 0xff) << 4) | (buf[1] & 0x0f);
+	/* V_BATT_MEAS(mV) = value * 5 * 1.8 * 1000 / (2^12) */
+	*data = ((*data & 0xfff) * 9 * 125) >> 9;
+
+	dev_dbg(info->dev, "%s, vchg: %d mv\n", __func__, *data);
+
+	return ret;
+}
+
+static void set_vchg_threshold(struct pm860x_charger_info *info,
+			       int min, int max)
+{
+	int data;
+
+	/* (tmp << 8) * / 5 / 1800 */
+	if (min <= 0)
+		data = 0;
+	else
+		data = (min << 5) / 1125;
+	pm860x_reg_write(info->i2c, PM8607_VCHG_LOWTH, data);
+	dev_dbg(info->dev, "VCHG_LOWTH:%dmv, 0x%x\n", min, data);
+
+	if (max <= 0)
+		data = 0xff;
+	else
+		data = (max << 5) / 1125;
+	pm860x_reg_write(info->i2c, PM8607_VCHG_HIGHTH, data);
+	dev_dbg(info->dev, "VCHG_HIGHTH:%dmv, 0x%x\n", max, data);
+
+}
+
+static void set_vbatt_threshold(struct pm860x_charger_info *info,
+				int min, int max)
+{
+	int data;
+
+	/* (tmp << 8) * 3 / 1800 */
+	if (min <= 0)
+		data = 0;
+	else
+		data = (min << 5) / 675;
+	pm860x_reg_write(info->i2c, PM8607_VBAT_LOWTH, data);
+	dev_dbg(info->dev, "VBAT Min:%dmv, LOWTH:0x%x\n", min, data);
+
+	if (max <= 0)
+		data = 0xff;
+	else
+		data = (max << 5) / 675;
+	pm860x_reg_write(info->i2c, PM8607_VBAT_HIGHTH, data);
+	dev_dbg(info->dev, "VBAT Max:%dmv, HIGHTH:0x%x\n", max, data);
+
+	return;
+}
+
+static int start_precharge(struct pm860x_charger_info *info)
+{
+	int ret;
+
+	dev_dbg(info->dev, "Start Pre-charging!\n");
+	set_vbatt_threshold(info, 0, 0);
+
+	ret = pm860x_reg_write(info->i2c_8606, PM8606_PREREGULATORA,
+			       PREREG1_1350MA | PREREG1_VSYS_4_5V);
+	if (ret < 0)
+		goto out;
+	/* stop charging */
+	ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL1, 3,
+			      CC1_MODE_OFF);
+	if (ret < 0)
+		goto out;
+	/* set 270 minutes timeout */
+	ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL3, (0xf << 4),
+			      CC3_270MIN_TIMEOUT);
+	if (ret < 0)
+		goto out;
+	/* set precharge current, termination voltage, IBAT & TBAT monitor */
+	ret = pm860x_reg_write(info->i2c, PM8607_CHG_CTRL4,
+			       CC4_IPRE_40MA | CC4_VPCHG_3_2V |
+			       CC4_IFCHG_MON_EN | CC4_BTEMP_MON_EN);
+	if (ret < 0)
+		goto out;
+	ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL7,
+			      CC7_BAT_REM_EN | CC7_IFSM_EN,
+			      CC7_BAT_REM_EN | CC7_IFSM_EN);
+	if (ret < 0)
+		goto out;
+	/* trigger precharge */
+	ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL1, 3,
+			      CC1_MODE_PRECHARGE);
+out:
+	return ret;
+}
+
+static int start_fastcharge(struct pm860x_charger_info *info)
+{
+	int ret;
+
+	dev_dbg(info->dev, "Start Fast-charging!\n");
+
+	/* set fastcharge termination current & voltage, disable charging */
+	ret = pm860x_reg_write(info->i2c, PM8607_CHG_CTRL1,
+			       CC1_MODE_OFF | CC1_ITERM_60MA |
+			       CC1_VFCHG_4_2V);
+	if (ret < 0)
+		goto out;
+	ret = pm860x_reg_write(info->i2c_8606, PM8606_PREREGULATORA,
+			       PREREG1_540MA | PREREG1_VSYS_4_5V);
+	if (ret < 0)
+		goto out;
+	ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL2, 0x1f,
+			      CC2_ICHG_500MA);
+	if (ret < 0)
+		goto out;
+	/* set 270 minutes timeout */
+	ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL3, (0xf << 4),
+			      CC3_270MIN_TIMEOUT);
+	if (ret < 0)
+		goto out;
+	/* set IBAT & TBAT monitor */
+	ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL4,
+			      CC4_IFCHG_MON_EN | CC4_BTEMP_MON_EN,
+			      CC4_IFCHG_MON_EN | CC4_BTEMP_MON_EN);
+	if (ret < 0)
+		goto out;
+	ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL6,
+			      CC6_BAT_OV_EN | CC6_BAT_UV_EN |
+			      CC6_UV_VBAT_SET,
+			      CC6_BAT_OV_EN | CC6_BAT_UV_EN |
+			      CC6_UV_VBAT_SET);
+	if (ret < 0)
+		goto out;
+	ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL7,
+			      CC7_BAT_REM_EN | CC7_IFSM_EN,
+			      CC7_BAT_REM_EN | CC7_IFSM_EN);
+	if (ret < 0)
+		goto out;
+	/* launch fast-charge */
+	ret = pm860x_set_bits(info->i2c, PM8607_CHG_CTRL1, 3,
+			      CC1_MODE_FASTCHARGE);
+	/* vchg threshold setting */
+	set_vchg_threshold(info, VCHG_NORMAL_LOW, VCHG_NORMAL_HIGH);
+out:
+	return ret;
+}
+
+static int stop_charge(struct pm860x_charger_info *info, int vbatt)
+{
+	dev_dbg(info->dev, "Stop charging!\n");
+	pm860x_set_bits(info->i2c, PM8607_CHG_CTRL1, 3, CC1_MODE_OFF);
+	if (vbatt > CHARGE_THRESHOLD && info->online)
+		set_vbatt_threshold(info, CHARGE_THRESHOLD, 0);
+	return 0;
+}
+
+static int power_off_notification(struct pm860x_charger_info *info)
+{
+	dev_dbg(info->dev, "Power-off notification!\n");
+	return 0;
+}
+
+static int set_charging_fsm(struct pm860x_charger_info *info)
+{
+	struct power_supply *psy;
+	union power_supply_propval data;
+	unsigned char fsm_state[][16] = { "init", "discharge", "precharge",
+		"fastcharge",
+	};
+	int ret = -EINVAL;
+	int vbatt;
+
+	psy = power_supply_get_by_name(pm860x_supplied_to[0]);
+	if (!psy)
+		goto out;
+	ret = psy->get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW, &data);
+	if (ret)
+		goto out;
+	vbatt = data.intval / 1000;
+
+	ret = psy->get_property(psy, POWER_SUPPLY_PROP_PRESENT, &data);
+	if (ret)
+		goto out;
+
+	mutex_lock(&info->lock);
+	info->present = data.intval;
+
+	dev_dbg(info->dev, "Entering FSM:%s, Charger:%s, Battery:%s, "
+		"Allowed:%d\n",
+		&fsm_state[info->state][0],
+		(info->online) ? "online" : "N/A",
+		(info->present) ? "present" : "N/A", info->allowed);
+	dev_dbg(info->dev, "set_charging_fsm:vbatt:%d(mV)\n", vbatt);
+
+	switch (info->state) {
+	case FSM_INIT:
+		if (info->online && info->present && info->allowed) {
+			if (vbatt < PRECHARGE_THRESHOLD) {
+				info->state = FSM_PRECHARGE;
+				start_precharge(info);
+			} else if (vbatt > DISCHARGE_THRESHOLD) {
+				info->state = FSM_DISCHARGE;
+				stop_charge(info, vbatt);
+			} else if (vbatt < DISCHARGE_THRESHOLD) {
+				info->state = FSM_FASTCHARGE;
+				start_fastcharge(info);
+			}
+		} else {
+			if (vbatt < POWEROFF_THRESHOLD) {
+				power_off_notification(info);
+			} else {
+				info->state = FSM_DISCHARGE;
+				stop_charge(info, vbatt);
+			}
+		}
+		break;
+	case FSM_PRECHARGE:
+		if (info->online && info->present && info->allowed) {
+			if (vbatt > PRECHARGE_THRESHOLD) {
+				info->state = FSM_FASTCHARGE;
+				start_fastcharge(info);
+			}
+		} else {
+			info->state = FSM_DISCHARGE;
+			stop_charge(info, vbatt);
+		}
+		break;
+	case FSM_FASTCHARGE:
+		if (info->online && info->present && info->allowed) {
+			if (vbatt < PRECHARGE_THRESHOLD) {
+				info->state = FSM_PRECHARGE;
+				start_precharge(info);
+			}
+		} else {
+			info->state = FSM_DISCHARGE;
+			stop_charge(info, vbatt);
+		}
+		break;
+	case FSM_DISCHARGE:
+		if (info->online && info->present && info->allowed) {
+			if (vbatt < PRECHARGE_THRESHOLD) {
+				info->state = FSM_PRECHARGE;
+				start_precharge(info);
+			} else if (vbatt < DISCHARGE_THRESHOLD) {
+				info->state = FSM_FASTCHARGE;
+				start_fastcharge(info);
+			}
+		} else {
+			if (vbatt < POWEROFF_THRESHOLD) {
+				power_off_notification(info);
+			} else if (vbatt > CHARGE_THRESHOLD
+				   && info->online)
+				set_vbatt_threshold(info, CHARGE_THRESHOLD,
+						    0);
+		}
+		break;
+	default:
+		dev_warn(info->dev, "FSM meets wrong state:%d\n",
+			 info->state);
+		break;
+	}
+	dev_dbg(info->dev,
+		"Out FSM:%s, Charger:%s, Battery:%s, Allowed:%d\n",
+		&fsm_state[info->state][0],
+		(info->online) ? "online" : "N/A",
+		(info->present) ? "present" : "N/A", info->allowed);
+	mutex_unlock(&info->lock);
+
+	return 0;
+out:
+	return ret;
+}
+
+static int pm860x_init_charger(struct pm860x_charger_info *info)
+{
+	int ret;
+
+	mutex_lock(&info->lock);
+	info->state = FSM_INIT;
+	ret = pm860x_reg_read(info->i2c, PM8607_STATUS_2);
+	if (ret < 0)
+		goto out;
+	if (ret & STATUS2_CHG) {
+		info->online = 1;
+		info->allowed = 1;
+	} else {
+		info->online = 0;
+		info->allowed = 0;
+	}
+	mutex_unlock(&info->lock);
+
+	set_charging_fsm(info);
+	return 0;
+out:
+	return ret;
+}
+
+static __devinit int pm860x_charger_probe(struct platform_device *pdev)
+{
+	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct pm860x_charger_info *info;
+	int ret, i, j, count;
+
+	info = kzalloc(sizeof(struct pm860x_charger_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	ret = device_create_file(&pdev->dev, &dev_attr_stop);
+	if (ret < 0)
+		goto out;
+
+	count = pdev->num_resources;
+	for (i = 0, j = 0; i < count; i++) {
+		info->irq[j] = platform_get_irq(pdev, i);
+		if (info->irq[j] < 0)
+			continue;
+		j++;
+	}
+	info->irq_nums = j;
+
+	info->chip = chip;
+	info->i2c =
+	    (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
+	info->i2c_8606 =
+	    (chip->id == CHIP_PM8607) ? chip->companion : chip->client;
+	if (!info->i2c_8606) {
+		dev_err(&pdev->dev, "Missed I2C address of 88PM8606!\n");
+		ret = -EINVAL;
+		goto out_dev;
+	}
+	info->dev = &pdev->dev;
+
+	/* set init value for the case we are not using battery */
+	set_vchg_threshold(info, VCHG_NORMAL_LOW, VCHG_OVP_LOW);
+
+	ret = request_threaded_irq(info->irq[0], NULL,
+				   pm860x_charger_handler,
+				   IRQF_ONESHOT, "usb supply detect",
+				   info);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			info->irq[0], ret);
+		goto out_dev;
+	}
+
+	ret = request_threaded_irq(info->irq[1], NULL,
+				   pm860x_done_handler,
+				   IRQF_ONESHOT, "charge done", info);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			info->irq[1], ret);
+		goto out_irq1;
+	}
+	ret = request_threaded_irq(info->irq[2], NULL,
+				   pm860x_exception_handler,
+				   IRQF_ONESHOT, "charge timeout", info);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			info->irq[2], ret);
+		goto out_irq2;
+	}
+	ret = request_threaded_irq(info->irq[3], NULL,
+				   pm860x_exception_handler,
+				   IRQF_ONESHOT, "charge fault", info);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			info->irq[3], ret);
+		goto out_irq3;
+	}
+	ret = request_threaded_irq(info->irq[4], NULL,
+				   pm860x_temp_handler,
+				   IRQF_ONESHOT, "temperature", info);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			info->irq[4], ret);
+		goto out_irq4;
+	}
+	ret = request_threaded_irq(info->irq[5], NULL,
+				   pm860x_vbattery_handler,
+				   IRQF_ONESHOT, "vbatt", info);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			info->irq[5], ret);
+		goto out_irq5;
+	}
+	ret = request_threaded_irq(info->irq[6], NULL,
+				   pm860x_vchg_handler,
+				   IRQF_ONESHOT, "vchg", info);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			info->irq[6], ret);
+		goto out_irq6;
+	}
+	if (info->irq_nums <= 6) {
+		dev_err(chip->dev, "IRQ numbers aren't matched\n");
+		goto out_nums;
+	}
+
+	mutex_init(&info->lock);
+	platform_set_drvdata(pdev, info);
+
+	info->usb.name = "usb";
+	info->usb.type = POWER_SUPPLY_TYPE_USB;
+	info->usb.supplied_to = pm860x_supplied_to;
+	info->usb.num_supplicants = ARRAY_SIZE(pm860x_supplied_to);
+	info->usb.properties = pm860x_usb_props;
+	info->usb.num_properties = ARRAY_SIZE(pm860x_usb_props);
+	info->usb.get_property = pm860x_usb_get_prop;
+	ret = power_supply_register(&pdev->dev, &info->usb);
+	if (ret)
+		goto out_nums;
+
+	pm860x_init_charger(info);
+
+	return 0;
+
+out_nums:
+	free_irq(info->irq[6], info);
+out_irq6:
+	free_irq(info->irq[5], info);
+out_irq5:
+	free_irq(info->irq[4], info);
+out_irq4:
+	free_irq(info->irq[3], info);
+out_irq3:
+	free_irq(info->irq[2], info);
+out_irq2:
+	free_irq(info->irq[1], info);
+out_irq1:
+	free_irq(info->irq[0], info);
+out_dev:
+	device_remove_file(&pdev->dev, &dev_attr_stop);
+out:
+	kfree(info);
+	return ret;
+}
+
+static int __devexit pm860x_charger_remove(struct platform_device *pdev)
+{
+	struct pm860x_charger_info *info = platform_get_drvdata(pdev);
+	int i;
+
+	platform_set_drvdata(pdev, NULL);
+	power_supply_unregister(&info->usb);
+	free_irq(info->irq[0], info);
+	for (i = 1; i < info->irq_nums; i++)
+		free_irq(info->irq[i], info);
+	device_remove_file(info->dev, &dev_attr_stop);
+	kfree(info);
+	return 0;
+}
+
+static struct platform_driver pm860x_charger_driver = {
+	.driver = {
+		   .name = "88pm860x-charger",
+		   .owner = THIS_MODULE,
+		   },
+	.probe = pm860x_charger_probe,
+	.remove = __devexit_p(pm860x_charger_remove),
+};
+
+module_platform_driver(pm860x_charger_driver);
+
+MODULE_DESCRIPTION("Marvell 88PM860x Charger driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index e3a3b49..be9ffc7 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -62,6 +62,12 @@ config TEST_POWER
 	help
 	  This driver is used for testing. It's safe to say M here.
 
+config BATTERY_88PM860X
+	tristate "Marvell 88PM860x battery driver"
+	depends on MFD_88PM860X
+	help
+	  Say Y here to enable battery monitor for Marvell 88PM860x chip.
+
 config BATTERY_DS2760
 	tristate "DS2760 battery driver (HP iPAQ & others)"
 	depends on W1 && W1_SLAVE_DS2760
@@ -203,6 +209,12 @@ config BATTERY_S3C_ADC
 	help
 	  Say Y here to enable support for iPAQ h1930/h1940/rx1950 battery
 
+config CHARGER_88PM860X
+	tristate "Marvell 88PM860x Charger driver"
+	depends on MFD_88PM860X && BATTERY_88PM860X
+	help
+	  Say Y here to enable charger for Marvell 88PM860x chip.
+
 config CHARGER_PCF50633
 	tristate "NXP PCF50633 MBC"
 	depends on MFD_PCF50633
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index b6b2434..a73c75e 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_WM831X_POWER)	+= wm831x_power.o
 obj-$(CONFIG_WM8350_POWER)	+= wm8350_power.o
 obj-$(CONFIG_TEST_POWER)	+= test_power.o
 
+obj-$(CONFIG_BATTERY_88PM860X)	+= 88pm860x_battery.o
 obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
 obj-$(CONFIG_BATTERY_DS2780)	+= ds2780_battery.o
 obj-$(CONFIG_BATTERY_DS2781)	+= ds2781_battery.o
@@ -31,6 +32,7 @@ obj-$(CONFIG_BATTERY_MAX17040)	+= max17040_battery.o
 obj-$(CONFIG_BATTERY_MAX17042)	+= max17042_battery.o
 obj-$(CONFIG_BATTERY_Z2)	+= z2_battery.o
 obj-$(CONFIG_BATTERY_S3C_ADC)	+= s3c_adc_battery.o
+obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
 obj-$(CONFIG_CHARGER_PCF50633)	+= pcf50633-charger.o
 obj-$(CONFIG_BATTERY_JZ4740)	+= jz4740-battery.o
 obj-$(CONFIG_BATTERY_INTEL_MID)	+= intel_mid_battery.o
diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index 7b24943..b7c5a3c 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -55,6 +55,21 @@ enum {
 #define PM8606_DCM_BOOST		(0x00)
 #define PM8606_PWM			(0x01)
 
+#define PM8607_MISC2			(0x42)
+
+/* Power Up Log Register */
+#define PM8607_POWER_UP_LOG		(0x3F)
+
+/* Charger Control Registers */
+#define PM8607_CCNT			(0x47)
+#define PM8607_CHG_CTRL1		(0x48)
+#define PM8607_CHG_CTRL2		(0x49)
+#define PM8607_CHG_CTRL3		(0x4A)
+#define PM8607_CHG_CTRL4		(0x4B)
+#define PM8607_CHG_CTRL5		(0x4C)
+#define PM8607_CHG_CTRL6		(0x4D)
+#define PM8607_CHG_CTRL7		(0x4E)
+
 /* Backlight Registers */
 #define PM8606_WLED1A			(0x02)
 #define PM8606_WLED1B			(0x03)
@@ -205,6 +220,71 @@ enum {
 #define PM8607_PD_PREBIAS		(0x56)	/* prebias time */
 #define PM8607_GPADC_MISC1		(0x57)
 
+/* bit definitions of  MEAS_EN1*/
+#define PM8607_MEAS_EN1_VBAT		(1 << 0)
+#define PM8607_MEAS_EN1_VCHG		(1 << 1)
+#define PM8607_MEAS_EN1_VSYS		(1 << 2)
+#define PM8607_MEAS_EN1_TINT		(1 << 3)
+#define PM8607_MEAS_EN1_RFTMP		(1 << 4)
+#define PM8607_MEAS_EN1_TBAT		(1 << 5)
+#define PM8607_MEAS_EN1_GPADC2		(1 << 6)
+#define PM8607_MEAS_EN1_GPADC3		(1 << 7)
+
+/* Battery Monitor Registers */
+#define PM8607_GP_BIAS2			(0x5A)
+#define PM8607_VBAT_LOWTH		(0x5B)
+#define PM8607_VCHG_LOWTH		(0x5C)
+#define PM8607_VSYS_LOWTH		(0x5D)
+#define PM8607_TINT_LOWTH		(0x5E)
+#define PM8607_GPADC0_LOWTH		(0x5F)
+#define PM8607_GPADC1_LOWTH		(0x60)
+#define PM8607_GPADC2_LOWTH		(0x61)
+#define PM8607_GPADC3_LOWTH		(0x62)
+#define PM8607_VBAT_HIGHTH		(0x63)
+#define PM8607_VCHG_HIGHTH		(0x64)
+#define PM8607_VSYS_HIGHTH		(0x65)
+#define PM8607_TINT_HIGHTH		(0x66)
+#define PM8607_GPADC0_HIGHTH		(0x67)
+#define PM8607_GPADC1_HIGHTH		(0x68)
+#define PM8607_GPADC2_HIGHTH		(0x69)
+#define PM8607_GPADC3_HIGHTH		(0x6A)
+#define PM8607_IBAT_MEAS1		(0x6B)
+#define PM8607_IBAT_MEAS2		(0x6C)
+#define PM8607_VBAT_MEAS1		(0x6D)
+#define PM8607_VBAT_MEAS2		(0x6E)
+#define PM8607_VCHG_MEAS1		(0x6F)
+#define PM8607_VCHG_MEAS2		(0x70)
+#define PM8607_VSYS_MEAS1		(0x71)
+#define PM8607_VSYS_MEAS2		(0x72)
+#define PM8607_TINT_MEAS1		(0x73)
+#define PM8607_TINT_MEAS2		(0x74)
+#define PM8607_GPADC0_MEAS1		(0x75)
+#define PM8607_GPADC0_MEAS2		(0x76)
+#define PM8607_GPADC1_MEAS1		(0x77)
+#define PM8607_GPADC1_MEAS2		(0x78)
+#define PM8607_GPADC2_MEAS1		(0x79)
+#define PM8607_GPADC2_MEAS2		(0x7A)
+#define PM8607_GPADC3_MEAS1		(0x7B)
+#define PM8607_GPADC3_MEAS2		(0x7C)
+#define PM8607_CCNT_MEAS1		(0x95)
+#define PM8607_CCNT_MEAS2		(0x96)
+#define PM8607_VBAT_AVG			(0x97)
+#define PM8607_VCHG_AVG			(0x98)
+#define PM8607_VSYS_AVG			(0x99)
+#define PM8607_VBAT_MIN			(0x9A)
+#define PM8607_VCHG_MIN			(0x9B)
+#define PM8607_VSYS_MIN			(0x9C)
+#define PM8607_VBAT_MAX			(0x9D)
+#define PM8607_VCHG_MAX			(0x9E)
+#define PM8607_VSYS_MAX			(0x9F)
+
+#define PM8607_GPADC_MISC2		(0x59)
+#define PM8607_GPADC0_GP_BIAS_A0	(1 << 0)
+#define PM8607_GPADC1_GP_BIAS_A1	(1 << 1)
+#define PM8607_GPADC2_GP_BIAS_A2	(1 << 2)
+#define PM8607_GPADC3_GP_BIAS_A3	(1 << 3)
+#define PM8607_GPADC2_GP_BIAS_OUT2	(1 << 6)
+
 /* RTC Control Registers */
 #define PM8607_RTC1			(0xA0)
 #define PM8607_RTC_COUNTER1		(0xA1)
@@ -370,7 +450,8 @@ struct pm860x_touch_pdata {
 };
 
 struct pm860x_power_pdata {
-	unsigned	fast_charge;	/* charge current */
+	int		max_capacity;
+	int		resistor;
 };
 
 struct pm860x_platform_data {
@@ -379,6 +460,7 @@ struct pm860x_platform_data {
 	struct pm860x_rtc_pdata		*rtc;
 	struct pm860x_touch_pdata	*touch;
 	struct pm860x_power_pdata	*power;
+	struct charger_desc		*chg_desc;
 	struct regulator_init_data	*regulator;
 
 	unsigned short	companion_addr;	/* I2C address of companion chip */
-- 
1.7.0.4
