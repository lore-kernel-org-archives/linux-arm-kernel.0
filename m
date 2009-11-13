From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 13 Nov 2009 10:50:27 -0500
Subject: [PATCH] mfd: append subdevs in 88pm860x
Message-ID: <mailman.23.1258102852.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append backlight, led & touch sub devices into 88PM860x driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/88pm860x-core.c  |  200 ++++++++++++++++++++++++++++++++++++++----
 include/linux/mfd/88pm860x.h |  149 +++++++++++++++++++++++++++++++-
 2 files changed, 331 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 7055c80..7c1b392 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -17,6 +17,98 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/88pm860x.h>

+char pm860x_backlight_name[][MFD_NAME_SIZE] = {
+	"backlight-0",
+	"backlight-1",
+	"backlight-2",
+};
+
+char pm860x_led_name[][MFD_NAME_SIZE] = {
+	"led0-red",
+	"led0-green",
+	"led0-blue",
+	"led1-red",
+	"led1-green",
+	"led1-blue",
+};
+
+#define PM8606_BACKLIGHT_RESOURCE(_i, _x)		\
+{							\
+	.name	= pm860x_backlight_name[_i],		\
+	.start	= PM8606_##_x,				\
+	.end	= PM8606_##_x,				\
+	.flags	= IORESOURCE_IO,			\
+}
+
+static struct resource backlight_resources[] = {
+	PM8606_BACKLIGHT_RESOURCE(PM8606_BACKLIGHT1, WLED1A),
+	PM8606_BACKLIGHT_RESOURCE(PM8606_BACKLIGHT2, WLED2A),
+	PM8606_BACKLIGHT_RESOURCE(PM8606_BACKLIGHT3, WLED3A),
+};
+
+#define PM8606_BACKLIGHT_DEVS(_i)			\
+{							\
+	.name		= "88pm860x-backlight",		\
+	.num_resources	= 1,				\
+	.resources	= &backlight_resources[_i],	\
+	.id		= _i,				\
+}
+
+static struct mfd_cell backlight_devs[] = {
+	PM8606_BACKLIGHT_DEVS(PM8606_BACKLIGHT1),
+	PM8606_BACKLIGHT_DEVS(PM8606_BACKLIGHT2),
+	PM8606_BACKLIGHT_DEVS(PM8606_BACKLIGHT3),
+};
+
+#define PM8606_LED_RESOURCE(_i, _x)			\
+{							\
+	.name	= pm860x_led_name[_i],			\
+	.start	= PM8606_##_x,				\
+	.end	= PM8606_##_x,				\
+	.flags	= IORESOURCE_IO,			\
+}
+
+static struct resource led_resources[] = {
+	PM8606_LED_RESOURCE(PM8606_LED1_RED, RGB2B),
+	PM8606_LED_RESOURCE(PM8606_LED1_GREEN, RGB2C),
+	PM8606_LED_RESOURCE(PM8606_LED1_BLUE, RGB2D),
+	PM8606_LED_RESOURCE(PM8606_LED2_RED, RGB1B),
+	PM8606_LED_RESOURCE(PM8606_LED2_GREEN, RGB1C),
+	PM8606_LED_RESOURCE(PM8606_LED2_BLUE, RGB1D),
+};
+
+#define PM8606_LED_DEVS(_i)				\
+{							\
+	.name		= "88pm860x-led",		\
+	.num_resources	= 1,				\
+	.resources	= &led_resources[_i],		\
+	.id		= _i,				\
+}
+
+static struct mfd_cell led_devs[] = {
+	PM8606_LED_DEVS(PM8606_LED1_RED),
+	PM8606_LED_DEVS(PM8606_LED1_GREEN),
+	PM8606_LED_DEVS(PM8606_LED1_BLUE),
+	PM8606_LED_DEVS(PM8606_LED2_RED),
+	PM8606_LED_DEVS(PM8606_LED2_GREEN),
+	PM8606_LED_DEVS(PM8606_LED2_BLUE),
+};
+
+static struct resource touch_resources[] = {
+	{
+		.start	= PM8607_IRQ_PEN,
+		.end	= PM8607_IRQ_PEN,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mfd_cell touch_devs[] = {
+	{
+		.name		= "88pm860x-touch",
+		.num_resources	= 1,
+		.resources	= &touch_resources[0],
+	},
+};

 #define PM8607_REG_RESOURCE(_start, _end)		\
 {							\
@@ -25,7 +117,7 @@
 	.flags	= IORESOURCE_IO,			\
 }

-static struct resource pm8607_regulator_resources[] = {
+static struct resource regulator_resources[] = {
 	PM8607_REG_RESOURCE(BUCK1, BUCK1),
 	PM8607_REG_RESOURCE(BUCK2, BUCK2),
 	PM8607_REG_RESOURCE(BUCK3, BUCK3),
@@ -47,10 +139,11 @@ static struct resource pm8607_regulator_resources[] = {
 {									\
 	.name		= "88pm8607-" #_name,				\
 	.num_resources	= 1,						\
-	.resources	= &pm8607_regulator_resources[PM8607_ID_##_id],	\
+	.resources	= &regulator_resources[PM8607_ID_##_id],	\
+	.id		= PM8607_ID_##_id,				\
 }

-static struct mfd_cell pm8607_devs[] = {
+static struct mfd_cell regulator_devs[] = {
 	PM8607_REG_DEVS(buck1, BUCK1),
 	PM8607_REG_DEVS(buck2, BUCK2),
 	PM8607_REG_DEVS(buck3, BUCK3),
@@ -192,7 +285,7 @@ int pm860x_free_irq(struct pm860x_chip *chip, int irq)
 EXPORT_SYMBOL(pm860x_free_irq);

 static int __devinit __88pm8607_irq_init(struct pm860x_chip *chip,
-					 struct pm8607_plat_data *pdata)
+					 struct pm860x_plat_data *pdata)
 {
 	unsigned char status_buf[INT_STATUS_NUM];
 	int irq, data, mask, ret = -EINVAL;
@@ -290,6 +383,65 @@ static void __devexit __88pm860x_irq_exit(struct
pm860x_chip *chip)
 		free_irq(chip->chip_irq, chip);
 }

+static int __devinit __88pm8607_gpadc_init(struct pm860x_chip *chip,
+					   struct pm860x_plat_data *pdata)
+{
+	int use_gpadc = 0, data, ret;
+
+	/* initialize GPADC without turn on */
+
+	if (pdata && pdata->touch) {
+		/* set GPADC MISC1 register */
+		data = 0;
+		if (pdata->touch->gpadc_prebias)
+			data |= pdata->touch->gpadc_prebias << 1;
+		if (pdata->touch->slot_cycle)
+			data |= pdata->touch->slot_cycle << 3;
+		if (pdata->touch->off_scale)
+			data |= pdata->touch->off_scale << 5;
+		if (pdata->touch->sw_cal)
+			data |= pdata->touch->sw_cal << 7;
+		if (data) {
+			ret = pm860x_reg_write(chip->parent, DESC_8607,
+						PM8607_GPADC_MISC1, data);
+			if (ret < 0)
+				goto out;
+		}
+		/* set tsi prebias time */
+		if (pdata->touch->tsi_prebias) {
+			data = pdata->touch->tsi_prebias;
+			ret = pm860x_reg_write(chip->parent, DESC_8607,
+						PM8607_TSI_PREBIAS, data);
+			if (ret < 0)
+				goto out;
+		}
+		/* set prebias & prechg time of pen detect */
+		data = 0;
+		if (pdata->touch->pen_prebias)
+			data |= pdata->touch->pen_prebias;
+		if (pdata->touch->pen_prechg)
+			data |= pdata->touch->pen_prechg << 5;
+		if (data) {
+			ret = pm860x_reg_write(chip->parent, DESC_8607,
+						PM8607_PD_PREBIAS, data);
+			if (ret < 0)
+				goto out;
+		}
+		
+		use_gpadc = 1;
+	}
+
+	/* turn on GPADC */
+	if (use_gpadc) {
+		ret = pm860x_set_bits(chip->parent, DESC_8607,
+					PM8607_GPADC_MISC1,
+					PM8607_GPADC_EN,
+					PM8607_GPADC_EN);
+	}
+out:
+	return ret;
+}
+
 static int __devinit __88pm8606_init(struct pm860x_chip *chip, void *pdata)
 {
 	chip->parent = &mixed_chip;
@@ -300,7 +452,7 @@ static int __devinit __88pm8606_init(struct
pm860x_chip *chip, void *pdata)
 }

 static int __devinit __88pm8607_init(struct pm860x_chip *chip,
-				     struct pm8607_plat_data *pdata)
+				     struct pm860x_plat_data *pdata)
 {
 	int data = 0, ret = 0;

@@ -352,6 +504,10 @@ static int __devinit __88pm8607_init(struct
pm860x_chip *chip,
 		}
 	}

+	ret = __88pm8607_gpadc_init(chip, pdata);
+	if (ret < 0)
+		goto out;
+
 	ret = __88pm8607_irq_init(chip, pdata);
 	if (ret < 0)
 		goto out;
@@ -359,9 +515,9 @@ out:
 	return ret;
 }

-int __devinit pm860x_device_init(struct pm860x_chip *chip, void *pdata)
+int __devinit pm860x_device_init(struct pm860x_chip *chip,
+				 struct pm860x_plat_data *pdata)
 {
-	int i, count;
 	int ret = -EINVAL;

 	/* Mixed chip isn't initialized yet. */
@@ -369,23 +525,35 @@ int __devinit pm860x_device_init(struct
pm860x_chip *chip, void *pdata)
 		mutex_init(&mixed_chip.io_lock);

 	if (!strcmp(chip->id.name, "88PM8607")) {
-		ret = __88pm8607_init(chip, (struct pm8607_plat_data *)pdata);
+		ret = __88pm8607_init(chip, pdata);
 		if (ret < 0)
 			goto out;

-		count = ARRAY_SIZE(pm8607_devs);
-		for (i = 0; i < count; i++) {
-			ret = mfd_add_devices(chip->dev, i, &pm8607_devs[i],
-					      1, NULL, 0);
-			if (ret != 0) {
-				dev_err(chip->dev, "Failed to add subdevs\n");
-				goto out;
-			}
+		mfd_add_devices(chip->dev, 0, &regulator_devs[0],
+				      ARRAY_SIZE(regulator_devs),
+				      &regulator_resources[0], 0);
+
+		if (pdata && pdata->touch) {
+			mfd_add_devices(chip->dev, 0, &touch_devs[0],
+					ARRAY_SIZE(touch_devs),
+					&touch_resources[0], 0);
 		}
 	} else if (!strcmp(chip->id.name, "88PM8606")) {
 		ret = __88pm8606_init(chip, pdata);
 		if (ret < 0)
 			goto out;
+
+		if (pdata && pdata->backlight) {
+			mfd_add_devices(chip->dev, 0, &backlight_devs[0],
+					ARRAY_SIZE(backlight_devs),
+					&backlight_resources[0], 0);
+		}
+
+		if (pdata && pdata->led) {
+			mfd_add_devices(chip->dev, 0, &led_devs[0],
+					ARRAY_SIZE(led_devs),
+					&led_resources[0], 0);
+		}
 	}
 out:
 	return ret;
diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index 92566df..b9f7fd2 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -19,6 +19,104 @@ enum {
 	DESC_MAX,
 };

+#define MFD_NAME_SIZE		(40)
+
+enum {
+	PM8606_ID_INVALID,
+	PM8606_ID_BACKLIGHT,
+	PM8606_ID_LED,
+	PM8606_ID_VIBRATOR,
+	PM8606_ID_TOUCH,
+	PM8606_ID_SOUND,
+	PM8606_ID_CHARGER,
+	PM8606_ID_MAX,
+};
+
+enum {
+	PM8606_BACKLIGHT1 = 0,
+	PM8606_BACKLIGHT2,
+	PM8606_BACKLIGHT3,
+};
+
+enum {
+	PM8606_LED1_RED = 0,
+	PM8606_LED1_GREEN,
+	PM8606_LED1_BLUE,
+	PM8606_LED2_RED,
+	PM8606_LED2_GREEN,
+	PM8606_LED2_BLUE,
+	PM8607_LED_VIBRATOR,
+};
+
+extern char pm860x_backlight_name[][MFD_NAME_SIZE];
+extern char pm860x_led_name[][MFD_NAME_SIZE];
+
+
+/* 8606 Registers */
+#define PM8606_DCM_BOOST		(0x00)
+#define PM8606_PWM			(0x01)
+
+/* Backlight Registers */
+#define PM8606_WLED1A			(0x02)
+#define PM8606_WLED1B			(0x03)
+#define PM8606_WLED2A			(0x04)
+#define PM8606_WLED2B			(0x05)
+#define PM8606_WLED3A			(0x06)
+#define PM8606_WLED3B			(0x07)
+
+/* LED Registers */
+#define PM8606_RGB2A			(0x08)
+#define PM8606_RGB2B			(0x09)
+#define PM8606_RGB2C			(0x0A)
+#define PM8606_RGB2D			(0x0B)
+#define PM8606_RGB1A			(0x0C)
+#define PM8606_RGB1B			(0x0D)
+#define PM8606_RGB1C			(0x0E)
+#define PM8606_RGB1D			(0x0F)
+
+#define PM8606_PREREGULATORA		(0x10)
+#define PM8606_PREREGULATORB		(0x11)
+#define PM8606_VIBRATORA		(0x12)
+#define PM8606_VIBRATORB		(0x13)
+#define PM8606_VCHG			(0x14)
+#define PM8606_VSYS			(0x15)
+#define PM8606_MISC			(0x16)
+#define PM8606_CHIP_ID			(0x17)
+#define PM8606_STATUS			(0x18)
+#define PM8606_FLAGS			(0x19)
+#define PM8606_PROTECTA			(0x1A)
+#define PM8606_PROTECTB			(0x1B)
+#define PM8606_PROTECTC			(0x1C)
+
+/* Bit definitions of PM8606 registers */
+#define PM8606_DCM_500MA		(0x0)	/* current limit */
+#define PM8606_DCM_750MA		(0x1)
+#define PM8606_DCM_1000MA		(0x2)
+#define PM8606_DCM_1250MA		(0x3)
+#define PM8606_DCM_250MV		(0x0 << 2)
+#define PM8606_DCM_300MV		(0x1 << 2)
+#define PM8606_DCM_350MV		(0x2 << 2)
+#define PM8606_DCM_400MV		(0x3 << 2)
+
+#define PM8606_PWM_31200HZ		(0x0)
+#define PM8606_PWM_15600HZ		(0x1)
+#define PM8606_PWM_7800HZ		(0x2)
+#define PM8606_PWM_3900HZ		(0x3)
+#define PM8606_PWM_1950HZ		(0x4)
+#define PM8606_PWM_976HZ		(0x5)
+#define PM8606_PWM_488HZ		(0x6)
+#define PM8606_PWM_244HZ		(0x7)
+#define PM8606_PWM_FREQ_MASK		(0x7)
+
+#define PM8606_WLED_ON			(1 << 0)
+#define PM8606_WLED_CURRENT(x)		((x & 0x1F) << 1)
+
+#define PM8606_LED_CURRENT(x)		((x >> 2) & 0x07)
+
+#define PM8606_VSYS_EN			(1 << 1)
+
+#define PM8606_MISC_OSC_EN		(1 << 4)
+
 enum {
 	PM8607_ID_BUCK1 = 0,
 	PM8607_ID_BUCK2,
@@ -89,6 +187,21 @@ enum {
 #define PM8607_SUPPLIES_EN21		(0x33)
 #define PM8607_SUPPLIES_EN22		(0x34)

+/* Vibrator Control Registers */
+#define PM8607_VIBRATOR_SET		(0x28)
+#define PM8607_VIBRATOR_PWM		(0x29)
+
+/* GPADC Registers */
+#define PM8607_GP_BIAS1			(0x4F)
+#define PM8607_MEAS_EN1			(0x50)
+#define PM8607_MEAS_EN2			(0x51)
+#define PM8607_MEAS_EN3			(0x52)
+#define PM8607_MEAS_OFF_TIME1		(0x53)
+#define PM8607_MEAS_OFF_TIME2		(0x54)
+#define PM8607_TSI_PREBIAS		(0x55)	/* prebias time */
+#define PM8607_PD_PREBIAS		(0x56)	/* prebias time */
+#define PM8607_GPADC_MISC1		(0x57)
+
 /* RTC Control Registers */
 #define PM8607_RTC1			(0xA0)
 #define PM8607_RTC_COUNTER1		(0xA1)
@@ -138,6 +251,9 @@ enum {
 #define PM8607_B0_MISC1_PI2C		(1 << 3)
 #define PM8607_B0_MISC1_RESET		(1 << 6)

+/* bits definitions of GPADC */
+#define PM8607_GPADC_EN			(1 << 0)
+
 /* Interrupt Number in 88PM8607 */
 enum {
 	PM8607_IRQ_ONKEY = 0,
@@ -211,7 +327,35 @@ enum {
 	PI2C_PORT,
 };

-struct pm8607_plat_data {
+struct pm860x_backlight_pdata {
+	int		id;
+	int		pwm;
+	int		iset;
+	unsigned long	flags;
+};
+
+struct pm860x_led_pdata {
+	int		id;
+	int		iset;
+	unsigned long	flags;
+};
+
+struct pm860x_touch_pdata {
+	int		gpadc_prebias;
+	int		slot_cycle;
+	int		off_scale;
+	int		sw_cal;
+	int		tsi_prebias;	/* time, slot */
+	int		pen_prebias;	/* time, slot */
+	int		pen_prechg;	/* time, slot */
+	unsigned long	flags;
+};
+
+struct pm860x_plat_data {
+	struct pm860x_backlight_pdata	*backlight;
+	struct pm860x_led_pdata		*led;
+	struct pm860x_touch_pdata	*touch;
+
 	int	i2c_port;	/* Controlled by GI2C or PI2C */
 	int	irq_mode;	/* Clear interrupt by read/write (1/0) */
 	struct regulator_init_data *regulator[PM8607_MAX_REGULATOR];
@@ -233,7 +377,8 @@ extern int pm860x_request_irq(struct pm860x_chip *, int,
 			void *);
 extern int pm860x_free_irq(struct pm860x_chip *, int);

-extern int pm860x_device_init(struct pm860x_chip *chip, void *pdata);
+extern int pm860x_device_init(struct pm860x_chip *chip,
+			      struct pm860x_plat_data *pdata);
 extern void pm860x_device_exit(struct pm860x_chip *chip);

 #endif /* __LINUX_MFD_88PM860X_H */
-- 
1.5.6.5
