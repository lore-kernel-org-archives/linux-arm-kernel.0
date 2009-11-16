From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 16 Nov 2009 10:44:37 -0500
Subject: [PATCH] mfd: append subdev into 88pm860x driver
Message-ID: <mailman.38.1258439501.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append backlight, led & touch subdevs into 88pm860x driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/88pm860x-core.c  |  207 ++++++++++++++++++++++++++++++++++++++=
+---
 include/linux/mfd/88pm860x.h |  147 +++++++++++++++++++++++++++++-
 2 files changed, 339 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index cc86089..c34492b 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -17,6 +17,98 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/88pm860x.h>

+char pm860x_backlight_name[][MFD_NAME_SIZE] =3D {
+	"backlight-0",
+	"backlight-1",
+	"backlight-2",
+};
+
+char pm860x_led_name[][MFD_NAME_SIZE] =3D {
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
+	.name	=3D pm860x_backlight_name[_i],		\
+	.start	=3D PM8606_##_x,				\
+	.end	=3D PM8606_##_x,				\
+	.flags	=3D IORESOURCE_IO,			\
+}
+
+static struct resource backlight_resources[] =3D {
+	PM8606_BACKLIGHT_RESOURCE(PM8606_BACKLIGHT1, WLED1A),
+	PM8606_BACKLIGHT_RESOURCE(PM8606_BACKLIGHT2, WLED2A),
+	PM8606_BACKLIGHT_RESOURCE(PM8606_BACKLIGHT3, WLED3A),
+};
+
+#define PM8606_BACKLIGHT_DEVS(_i)			\
+{							\
+	.name		=3D "88pm860x-backlight",		\
+	.num_resources	=3D 1,				\
+	.resources	=3D &backlight_resources[_i],	\
+	.id		=3D _i,				\
+}
+
+static struct mfd_cell backlight_devs[] =3D {
+	PM8606_BACKLIGHT_DEVS(PM8606_BACKLIGHT1),
+	PM8606_BACKLIGHT_DEVS(PM8606_BACKLIGHT2),
+	PM8606_BACKLIGHT_DEVS(PM8606_BACKLIGHT3),
+};
+
+#define PM8606_LED_RESOURCE(_i, _x)			\
+{							\
+	.name	=3D pm860x_led_name[_i],			\
+	.start	=3D PM8606_##_x,				\
+	.end	=3D PM8606_##_x,				\
+	.flags	=3D IORESOURCE_IO,			\
+}
+
+static struct resource led_resources[] =3D {
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
+	.name		=3D "88pm860x-led",		\
+	.num_resources	=3D 1,				\
+	.resources	=3D &led_resources[_i],		\
+	.id		=3D _i,				\
+}
+
+static struct mfd_cell led_devs[] =3D {
+	PM8606_LED_DEVS(PM8606_LED1_RED),
+	PM8606_LED_DEVS(PM8606_LED1_GREEN),
+	PM8606_LED_DEVS(PM8606_LED1_BLUE),
+	PM8606_LED_DEVS(PM8606_LED2_RED),
+	PM8606_LED_DEVS(PM8606_LED2_GREEN),
+	PM8606_LED_DEVS(PM8606_LED2_BLUE),
+};
+
+static struct resource touch_resources[] =3D {
+	{
+		.start	=3D PM8607_IRQ_PEN,
+		.end	=3D PM8607_IRQ_PEN,
+		.flags	=3D IORESOURCE_IRQ,
+	},
+};
+
+static struct mfd_cell touch_devs[] =3D {
+	{
+		.name		=3D "88pm860x-touch",
+		.num_resources	=3D 1,
+		.resources	=3D &touch_resources[0],
+	},
+};

 #define PM8607_REG_RESOURCE(_start, _end)		\
 {							\
@@ -25,7 +117,7 @@
 	.flags	=3D IORESOURCE_IO,			\
 }

-static struct resource pm8607_regulator_resources[] =3D {
+static struct resource regulator_resources[] =3D {
 	PM8607_REG_RESOURCE(BUCK1, BUCK1),
 	PM8607_REG_RESOURCE(BUCK2, BUCK2),
 	PM8607_REG_RESOURCE(BUCK3, BUCK3),
@@ -47,10 +139,11 @@ static struct resource pm8607_regulator_resources[] =
=3D {
 {									\
 	.name		=3D "88pm8607-" #_name,				\
 	.num_resources	=3D 1,						\
-	.resources	=3D &pm8607_regulator_resources[PM8607_ID_##_id],	\
+	.resources	=3D &regulator_resources[PM8607_ID_##_id],	\
+	.id		=3D PM8607_ID_##_id,				\
 }

-static struct mfd_cell pm8607_devs[] =3D {
+static struct mfd_cell regulator_devs[] =3D {
 	PM8607_REG_DEVS(buck1, BUCK1),
 	PM8607_REG_DEVS(buck2, BUCK2),
 	PM8607_REG_DEVS(buck3, BUCK3),
@@ -275,6 +368,65 @@ static void __devexit __88pm860x_irq_exit(struct
pm860x_chip *chip)
 		free_irq(chip->chip_irq, chip);
 }

+static int __devinit __88pm8607_gpadc_init(struct pm860x_chip *chip,
+					   struct pm860x_plat_data *pdata)
+{
+	int use_gpadc =3D 0, data, ret;
+
+	/* initialize GPADC without turn on */
+
+	if (pdata && pdata->touch) {
+		/* set GPADC MISC1 register */
+		data =3D 0;
+		if (pdata->touch->gpadc_prebias)
+			data |=3D pdata->touch->gpadc_prebias << 1;
+		if (pdata->touch->slot_cycle)
+			data |=3D pdata->touch->slot_cycle << 3;
+		if (pdata->touch->off_scale)
+			data |=3D pdata->touch->off_scale << 5;
+		if (pdata->touch->sw_cal)
+			data |=3D pdata->touch->sw_cal << 7;
+		if (data) {
+			ret =3D pm860x_reg_write(chip->parent, DESC_8607,
+						PM8607_GPADC_MISC1, data);
+			if (ret < 0)
+				goto out;
+		}
+		/* set tsi prebias time */
+		if (pdata->touch->tsi_prebias) {
+			data =3D pdata->touch->tsi_prebias;
+			ret =3D pm860x_reg_write(chip->parent, DESC_8607,
+						PM8607_TSI_PREBIAS, data);
+			if (ret < 0)
+				goto out;
+		}
+		/* set prebias & prechg time of pen detect */
+		data =3D 0;
+		if (pdata->touch->pen_prebias)
+			data |=3D pdata->touch->pen_prebias;
+		if (pdata->touch->pen_prechg)
+			data |=3D pdata->touch->pen_prechg << 5;
+		if (data) {
+			ret =3D pm860x_reg_write(chip->parent, DESC_8607,
+						PM8607_PD_PREBIAS, data);
+			if (ret < 0)
+				goto out;
+		}
+	=09
+		use_gpadc =3D 1;
+	}
+
+	/* turn on GPADC */
+	if (use_gpadc) {
+		ret =3D pm860x_set_bits(chip->parent, DESC_8607,
+					PM8607_GPADC_MISC1,
+					PM8607_GPADC_EN,
+					PM8607_GPADC_EN);
+	}
+out:
+	return ret;
+}
+
 static int __devinit __88pm8606_init(struct pm860x_chip *chip, void *pdata=
)
 {
 	chip->parent =3D &mixed_chip;
@@ -337,6 +489,10 @@ static int __devinit __88pm8607_init(struct
pm860x_chip *chip,
 		}
 	}

+	ret =3D __88pm8607_gpadc_init(chip, pdata);
+	if (ret < 0)
+		goto out;
+
 	ret =3D __88pm8607_irq_init(chip, pdata);
 	if (ret < 0)
 		goto out;
@@ -344,9 +500,9 @@ out:
 	return ret;
 }

-int __devinit pm860x_device_init(struct pm860x_chip *chip, void *pdata)
+int __devinit pm860x_device_init(struct pm860x_chip *chip,
+				 struct pm860x_plat_data *pdata)
 {
-	int i, count;
 	int ret =3D -EINVAL;

 	/* Mixed chip isn't initialized yet. */
@@ -354,23 +510,46 @@ int __devinit pm860x_device_init(struct
pm860x_chip *chip, void *pdata)
 		mutex_init(&mixed_chip.io_lock);

 	if (!strcmp(chip->id.name, "88PM8607")) {
-		ret =3D __88pm8607_init(chip, (struct pm860x_plat_data *)pdata);
+		ret =3D __88pm8607_init(chip, pdata);
 		if (ret < 0)
 			goto out;

-		count =3D ARRAY_SIZE(pm8607_devs);
-		for (i =3D 0; i < count; i++) {
-			ret =3D mfd_add_devices(chip->dev, i, &pm8607_devs[i],
-					      1, NULL, 0);
-			if (ret !=3D 0) {
-				dev_err(chip->dev, "Failed to add subdevs\n");
-				goto out;
-			}
+		ret =3D mfd_add_devices(chip->dev, 0, &regulator_devs[0],
+				      ARRAY_SIZE(regulator_devs),
+				      &regulator_resources[0], 0);
+		if (ret < 0)
+			dev_err(chip->dev, "Failed to add regulator subdev\n");
+
+		if (pdata && pdata->touch) {
+			ret =3D mfd_add_devices(chip->dev, 0, &touch_devs[0],
+					ARRAY_SIZE(touch_devs),
+					&touch_resources[0], 0);
+			if (ret < 0)
+				dev_err(chip->dev, "Failed to add touch "
+					"subdev\n");
 		}
 	} else if (!strcmp(chip->id.name, "88PM8606")) {
 		ret =3D __88pm8606_init(chip, pdata);
 		if (ret < 0)
 			goto out;
+
+		if (pdata && pdata->backlight) {
+			ret =3D mfd_add_devices(chip->dev, 0, &backlight_devs[0],
+					ARRAY_SIZE(backlight_devs),
+					&backlight_resources[0], 0);
+			if (ret < 0)
+				dev_err(chip->dev, "Failed to add backlight "
+					"subdev\n");
+		}
+
+		if (pdata && pdata->led) {
+			ret =3D mfd_add_devices(chip->dev, 0, &led_devs[0],
+					ARRAY_SIZE(led_devs),
+					&led_resources[0], 0);
+			if (ret < 0)
+				dev_err(chip->dev, "Failed to add led "
+					"subdev\n");
+		}
 	}
 out:
 	return ret;
diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index 99a5a7e..b7f9aac 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -14,6 +14,8 @@

 #include <linux/interrupt.h>

+#define MFD_NAME_SIZE		(40)
+
 enum {
 	DESC_INVAL =3D 0,
 	DESC_8606,
@@ -22,6 +24,99 @@ enum {
 };

 enum {
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
+	PM8606_BACKLIGHT1 =3D 0,
+	PM8606_BACKLIGHT2,
+	PM8606_BACKLIGHT3,
+};
+
+enum {
+	PM8606_LED1_RED =3D 0,
+	PM8606_LED1_GREEN,
+	PM8606_LED1_BLUE,
+	PM8606_LED2_RED,
+	PM8606_LED2_GREEN,
+	PM8606_LED2_BLUE,
+	PM8607_LED_VIBRATOR,
+};
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
+enum {
 	PM8607_ID_BUCK1 =3D 0,
 	PM8607_ID_BUCK2,
 	PM8607_ID_BUCK3,
@@ -91,6 +186,21 @@ enum {
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
@@ -140,6 +250,9 @@ enum {
 #define PM8607_B0_MISC1_PI2C		(1 << 3)
 #define PM8607_B0_MISC1_RESET		(1 << 6)

+/* bits definitions of GPADC */
+#define PM8607_GPADC_EN			(1 << 0)
+
 /* Interrupt Number in 88PM8607 */
 enum {
 	PM8607_IRQ_ONKEY =3D 0,
@@ -213,12 +326,43 @@ enum {
 	PI2C_PORT,
 };

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
 struct pm860x_plat_data {
+	struct pm860x_backlight_pdata	*backlight;
+	struct pm860x_led_pdata		*led;
+	struct pm860x_touch_pdata	*touch;
+
 	int	i2c_port;	/* Controlled by GI2C or PI2C */
 	int	irq_mode;	/* Clear interrupt by read/write (1/0) */
 	struct regulator_init_data *regulator[PM8607_MAX_REGULATOR];
 };

+extern char pm860x_backlight_name[][MFD_NAME_SIZE];
+extern char pm860x_led_name[][MFD_NAME_SIZE];
+
 extern int pm860x_reg_read(struct mixed_88pm860x *, int, int);
 extern int pm860x_reg_write(struct mixed_88pm860x *, int, int, unsigned ch=
ar);
 extern int pm860x_bulk_read(struct mixed_88pm860x *, int, int, int,
@@ -234,7 +378,8 @@ extern int pm860x_request_irq(struct pm860x_chip *, int=
,
 			      irq_handler_t handler, void *);
 extern int pm860x_free_irq(struct pm860x_chip *, int);

-extern int pm860x_device_init(struct pm860x_chip *chip, void *pdata);
+extern int pm860x_device_init(struct pm860x_chip *chip,
+			      struct pm860x_plat_data *pdata);
 extern void pm860x_device_exit(struct pm860x_chip *chip);

 #endif /* __LINUX_MFD_88PM860X_H */
--=20
1.5.6.5

--0016363b79840d295204788b4783
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0006-mfd-append-subdev-into-88pm860x-driver.patch"
Content-Disposition: attachment; 
	filename="0006-mfd-append-subdev-into-88pm860x-driver.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g24r4kl40

RnJvbSA2MjU5NTZkMTJkNzk4MjlmZjdlZGQ0OTRmZTRmYWVlZDVlYWJjMmJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IE1vbiwgMTYgTm92IDIwMDkgMTA6NDQ6MzcgLTA1MDAKU3ViamVjdDogW1BB
VENIXSBtZmQ6IGFwcGVuZCBzdWJkZXYgaW50byA4OHBtODYweCBkcml2ZXIKCkFwcGVuZCBiYWNr
bGlnaHQsIGxlZCAmIHRvdWNoIHN1YmRldnMgaW50byA4OHBtODYweCBkcml2ZXIuCgpTaWduZWQt
b2ZmLWJ5OiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVsbC5jb20+Ci0tLQog
ZHJpdmVycy9tZmQvODhwbTg2MHgtY29yZS5jICB8ICAyMDcgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tCiBpbmNsdWRlL2xpbnV4L21mZC84OHBtODYweC5oIHwgIDE0
NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMzM5IGlu
c2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkLzg4
cG04NjB4LWNvcmUuYyBiL2RyaXZlcnMvbWZkLzg4cG04NjB4LWNvcmUuYwppbmRleCBjYzg2MDg5
Li5jMzQ0OTJiIDEwMDY0NAotLS0gYS9kcml2ZXJzL21mZC84OHBtODYweC1jb3JlLmMKKysrIGIv
ZHJpdmVycy9tZmQvODhwbTg2MHgtY29yZS5jCkBAIC0xNyw2ICsxNyw5OCBAQAogI2luY2x1ZGUg
PGxpbnV4L21mZC9jb3JlLmg+CiAjaW5jbHVkZSA8bGludXgvbWZkLzg4cG04NjB4Lmg+CiAKK2No
YXIgcG04NjB4X2JhY2tsaWdodF9uYW1lW11bTUZEX05BTUVfU0laRV0gPSB7CisJImJhY2tsaWdo
dC0wIiwKKwkiYmFja2xpZ2h0LTEiLAorCSJiYWNrbGlnaHQtMiIsCit9OworCitjaGFyIHBtODYw
eF9sZWRfbmFtZVtdW01GRF9OQU1FX1NJWkVdID0geworCSJsZWQwLXJlZCIsCisJImxlZDAtZ3Jl
ZW4iLAorCSJsZWQwLWJsdWUiLAorCSJsZWQxLXJlZCIsCisJImxlZDEtZ3JlZW4iLAorCSJsZWQx
LWJsdWUiLAorfTsKKworI2RlZmluZSBQTTg2MDZfQkFDS0xJR0hUX1JFU09VUkNFKF9pLCBfeCkJ
CVwKK3sJCQkJCQkJXAorCS5uYW1lCT0gcG04NjB4X2JhY2tsaWdodF9uYW1lW19pXSwJCVwKKwku
c3RhcnQJPSBQTTg2MDZfIyNfeCwJCQkJXAorCS5lbmQJPSBQTTg2MDZfIyNfeCwJCQkJXAorCS5m
bGFncwk9IElPUkVTT1VSQ0VfSU8sCQkJXAorfQorCitzdGF0aWMgc3RydWN0IHJlc291cmNlIGJh
Y2tsaWdodF9yZXNvdXJjZXNbXSA9IHsKKwlQTTg2MDZfQkFDS0xJR0hUX1JFU09VUkNFKFBNODYw
Nl9CQUNLTElHSFQxLCBXTEVEMUEpLAorCVBNODYwNl9CQUNLTElHSFRfUkVTT1VSQ0UoUE04NjA2
X0JBQ0tMSUdIVDIsIFdMRUQyQSksCisJUE04NjA2X0JBQ0tMSUdIVF9SRVNPVVJDRShQTTg2MDZf
QkFDS0xJR0hUMywgV0xFRDNBKSwKK307CisKKyNkZWZpbmUgUE04NjA2X0JBQ0tMSUdIVF9ERVZT
KF9pKQkJCVwKK3sJCQkJCQkJXAorCS5uYW1lCQk9ICI4OHBtODYweC1iYWNrbGlnaHQiLAkJXAor
CS5udW1fcmVzb3VyY2VzCT0gMSwJCQkJXAorCS5yZXNvdXJjZXMJPSAmYmFja2xpZ2h0X3Jlc291
cmNlc1tfaV0sCVwKKwkuaWQJCT0gX2ksCQkJCVwKK30KKworc3RhdGljIHN0cnVjdCBtZmRfY2Vs
bCBiYWNrbGlnaHRfZGV2c1tdID0geworCVBNODYwNl9CQUNLTElHSFRfREVWUyhQTTg2MDZfQkFD
S0xJR0hUMSksCisJUE04NjA2X0JBQ0tMSUdIVF9ERVZTKFBNODYwNl9CQUNLTElHSFQyKSwKKwlQ
TTg2MDZfQkFDS0xJR0hUX0RFVlMoUE04NjA2X0JBQ0tMSUdIVDMpLAorfTsKKworI2RlZmluZSBQ
TTg2MDZfTEVEX1JFU09VUkNFKF9pLCBfeCkJCQlcCit7CQkJCQkJCVwKKwkubmFtZQk9IHBtODYw
eF9sZWRfbmFtZVtfaV0sCQkJXAorCS5zdGFydAk9IFBNODYwNl8jI194LAkJCQlcCisJLmVuZAk9
IFBNODYwNl8jI194LAkJCQlcCisJLmZsYWdzCT0gSU9SRVNPVVJDRV9JTywJCQlcCit9CisKK3N0
YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgbGVkX3Jlc291cmNlc1tdID0geworCVBNODYwNl9MRURfUkVT
T1VSQ0UoUE04NjA2X0xFRDFfUkVELCBSR0IyQiksCisJUE04NjA2X0xFRF9SRVNPVVJDRShQTTg2
MDZfTEVEMV9HUkVFTiwgUkdCMkMpLAorCVBNODYwNl9MRURfUkVTT1VSQ0UoUE04NjA2X0xFRDFf
QkxVRSwgUkdCMkQpLAorCVBNODYwNl9MRURfUkVTT1VSQ0UoUE04NjA2X0xFRDJfUkVELCBSR0Ix
QiksCisJUE04NjA2X0xFRF9SRVNPVVJDRShQTTg2MDZfTEVEMl9HUkVFTiwgUkdCMUMpLAorCVBN
ODYwNl9MRURfUkVTT1VSQ0UoUE04NjA2X0xFRDJfQkxVRSwgUkdCMUQpLAorfTsKKworI2RlZmlu
ZSBQTTg2MDZfTEVEX0RFVlMoX2kpCQkJCVwKK3sJCQkJCQkJXAorCS5uYW1lCQk9ICI4OHBtODYw
eC1sZWQiLAkJXAorCS5udW1fcmVzb3VyY2VzCT0gMSwJCQkJXAorCS5yZXNvdXJjZXMJPSAmbGVk
X3Jlc291cmNlc1tfaV0sCQlcCisJLmlkCQk9IF9pLAkJCQlcCit9CisKK3N0YXRpYyBzdHJ1Y3Qg
bWZkX2NlbGwgbGVkX2RldnNbXSA9IHsKKwlQTTg2MDZfTEVEX0RFVlMoUE04NjA2X0xFRDFfUkVE
KSwKKwlQTTg2MDZfTEVEX0RFVlMoUE04NjA2X0xFRDFfR1JFRU4pLAorCVBNODYwNl9MRURfREVW
UyhQTTg2MDZfTEVEMV9CTFVFKSwKKwlQTTg2MDZfTEVEX0RFVlMoUE04NjA2X0xFRDJfUkVEKSwK
KwlQTTg2MDZfTEVEX0RFVlMoUE04NjA2X0xFRDJfR1JFRU4pLAorCVBNODYwNl9MRURfREVWUyhQ
TTg2MDZfTEVEMl9CTFVFKSwKK307CisKK3N0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgdG91Y2hfcmVz
b3VyY2VzW10gPSB7CisJeworCQkuc3RhcnQJPSBQTTg2MDdfSVJRX1BFTiwKKwkJLmVuZAk9IFBN
ODYwN19JUlFfUEVOLAorCQkuZmxhZ3MJPSBJT1JFU09VUkNFX0lSUSwKKwl9LAorfTsKKworc3Rh
dGljIHN0cnVjdCBtZmRfY2VsbCB0b3VjaF9kZXZzW10gPSB7CisJeworCQkubmFtZQkJPSAiODhw
bTg2MHgtdG91Y2giLAorCQkubnVtX3Jlc291cmNlcwk9IDEsCisJCS5yZXNvdXJjZXMJPSAmdG91
Y2hfcmVzb3VyY2VzWzBdLAorCX0sCit9OwogCiAjZGVmaW5lIFBNODYwN19SRUdfUkVTT1VSQ0Uo
X3N0YXJ0LCBfZW5kKQkJXAogewkJCQkJCQlcCkBAIC0yNSw3ICsxMTcsNyBAQAogCS5mbGFncwk9
IElPUkVTT1VSQ0VfSU8sCQkJXAogfQogCi1zdGF0aWMgc3RydWN0IHJlc291cmNlIHBtODYwN19y
ZWd1bGF0b3JfcmVzb3VyY2VzW10gPSB7CitzdGF0aWMgc3RydWN0IHJlc291cmNlIHJlZ3VsYXRv
cl9yZXNvdXJjZXNbXSA9IHsKIAlQTTg2MDdfUkVHX1JFU09VUkNFKEJVQ0sxLCBCVUNLMSksCiAJ
UE04NjA3X1JFR19SRVNPVVJDRShCVUNLMiwgQlVDSzIpLAogCVBNODYwN19SRUdfUkVTT1VSQ0Uo
QlVDSzMsIEJVQ0szKSwKQEAgLTQ3LDEwICsxMzksMTEgQEAgc3RhdGljIHN0cnVjdCByZXNvdXJj
ZSBwbTg2MDdfcmVndWxhdG9yX3Jlc291cmNlc1tdID0gewogewkJCQkJCQkJCVwKIAkubmFtZQkJ
PSAiODhwbTg2MDctIiAjX25hbWUsCQkJCVwKIAkubnVtX3Jlc291cmNlcwk9IDEsCQkJCQkJXAot
CS5yZXNvdXJjZXMJPSAmcG04NjA3X3JlZ3VsYXRvcl9yZXNvdXJjZXNbUE04NjA3X0lEXyMjX2lk
XSwJXAorCS5yZXNvdXJjZXMJPSAmcmVndWxhdG9yX3Jlc291cmNlc1tQTTg2MDdfSURfIyNfaWRd
LAlcCisJLmlkCQk9IFBNODYwN19JRF8jI19pZCwJCQkJXAogfQogCi1zdGF0aWMgc3RydWN0IG1m
ZF9jZWxsIHBtODYwN19kZXZzW10gPSB7CitzdGF0aWMgc3RydWN0IG1mZF9jZWxsIHJlZ3VsYXRv
cl9kZXZzW10gPSB7CiAJUE04NjA3X1JFR19ERVZTKGJ1Y2sxLCBCVUNLMSksCiAJUE04NjA3X1JF
R19ERVZTKGJ1Y2syLCBCVUNLMiksCiAJUE04NjA3X1JFR19ERVZTKGJ1Y2szLCBCVUNLMyksCkBA
IC0yNzUsNiArMzY4LDY1IEBAIHN0YXRpYyB2b2lkIF9fZGV2ZXhpdCBfXzg4cG04NjB4X2lycV9l
eGl0KHN0cnVjdCBwbTg2MHhfY2hpcCAqY2hpcCkKIAkJZnJlZV9pcnEoY2hpcC0+Y2hpcF9pcnEs
IGNoaXApOwogfQogCitzdGF0aWMgaW50IF9fZGV2aW5pdCBfXzg4cG04NjA3X2dwYWRjX2luaXQo
c3RydWN0IHBtODYweF9jaGlwICpjaGlwLAorCQkJCQkgICBzdHJ1Y3QgcG04NjB4X3BsYXRfZGF0
YSAqcGRhdGEpCit7CisJaW50IHVzZV9ncGFkYyA9IDAsIGRhdGEsIHJldDsKKworCS8qIGluaXRp
YWxpemUgR1BBREMgd2l0aG91dCB0dXJuIG9uICovCisKKwlpZiAocGRhdGEgJiYgcGRhdGEtPnRv
dWNoKSB7CisJCS8qIHNldCBHUEFEQyBNSVNDMSByZWdpc3RlciAqLworCQlkYXRhID0gMDsKKwkJ
aWYgKHBkYXRhLT50b3VjaC0+Z3BhZGNfcHJlYmlhcykKKwkJCWRhdGEgfD0gcGRhdGEtPnRvdWNo
LT5ncGFkY19wcmViaWFzIDw8IDE7CisJCWlmIChwZGF0YS0+dG91Y2gtPnNsb3RfY3ljbGUpCisJ
CQlkYXRhIHw9IHBkYXRhLT50b3VjaC0+c2xvdF9jeWNsZSA8PCAzOworCQlpZiAocGRhdGEtPnRv
dWNoLT5vZmZfc2NhbGUpCisJCQlkYXRhIHw9IHBkYXRhLT50b3VjaC0+b2ZmX3NjYWxlIDw8IDU7
CisJCWlmIChwZGF0YS0+dG91Y2gtPnN3X2NhbCkKKwkJCWRhdGEgfD0gcGRhdGEtPnRvdWNoLT5z
d19jYWwgPDwgNzsKKwkJaWYgKGRhdGEpIHsKKwkJCXJldCA9IHBtODYweF9yZWdfd3JpdGUoY2hp
cC0+cGFyZW50LCBERVNDXzg2MDcsCisJCQkJCQlQTTg2MDdfR1BBRENfTUlTQzEsIGRhdGEpOwor
CQkJaWYgKHJldCA8IDApCisJCQkJZ290byBvdXQ7CisJCX0KKwkJLyogc2V0IHRzaSBwcmViaWFz
IHRpbWUgKi8KKwkJaWYgKHBkYXRhLT50b3VjaC0+dHNpX3ByZWJpYXMpIHsKKwkJCWRhdGEgPSBw
ZGF0YS0+dG91Y2gtPnRzaV9wcmViaWFzOworCQkJcmV0ID0gcG04NjB4X3JlZ193cml0ZShjaGlw
LT5wYXJlbnQsIERFU0NfODYwNywKKwkJCQkJCVBNODYwN19UU0lfUFJFQklBUywgZGF0YSk7CisJ
CQlpZiAocmV0IDwgMCkKKwkJCQlnb3RvIG91dDsKKwkJfQorCQkvKiBzZXQgcHJlYmlhcyAmIHBy
ZWNoZyB0aW1lIG9mIHBlbiBkZXRlY3QgKi8KKwkJZGF0YSA9IDA7CisJCWlmIChwZGF0YS0+dG91
Y2gtPnBlbl9wcmViaWFzKQorCQkJZGF0YSB8PSBwZGF0YS0+dG91Y2gtPnBlbl9wcmViaWFzOwor
CQlpZiAocGRhdGEtPnRvdWNoLT5wZW5fcHJlY2hnKQorCQkJZGF0YSB8PSBwZGF0YS0+dG91Y2gt
PnBlbl9wcmVjaGcgPDwgNTsKKwkJaWYgKGRhdGEpIHsKKwkJCXJldCA9IHBtODYweF9yZWdfd3Jp
dGUoY2hpcC0+cGFyZW50LCBERVNDXzg2MDcsCisJCQkJCQlQTTg2MDdfUERfUFJFQklBUywgZGF0
YSk7CisJCQlpZiAocmV0IDwgMCkKKwkJCQlnb3RvIG91dDsKKwkJfQorCQkKKwkJdXNlX2dwYWRj
ID0gMTsKKwl9CisKKwkvKiB0dXJuIG9uIEdQQURDICovCisJaWYgKHVzZV9ncGFkYykgeworCQly
ZXQgPSBwbTg2MHhfc2V0X2JpdHMoY2hpcC0+cGFyZW50LCBERVNDXzg2MDcsCisJCQkJCVBNODYw
N19HUEFEQ19NSVNDMSwKKwkJCQkJUE04NjA3X0dQQURDX0VOLAorCQkJCQlQTTg2MDdfR1BBRENf
RU4pOworCX0KK291dDoKKwlyZXR1cm4gcmV0OworfQorCiBzdGF0aWMgaW50IF9fZGV2aW5pdCBf
Xzg4cG04NjA2X2luaXQoc3RydWN0IHBtODYweF9jaGlwICpjaGlwLCB2b2lkICpwZGF0YSkKIHsK
IAljaGlwLT5wYXJlbnQgPSAmbWl4ZWRfY2hpcDsKQEAgLTMzNyw2ICs0ODksMTAgQEAgc3RhdGlj
IGludCBfX2RldmluaXQgX184OHBtODYwN19pbml0KHN0cnVjdCBwbTg2MHhfY2hpcCAqY2hpcCwK
IAkJfQogCX0KIAorCXJldCA9IF9fODhwbTg2MDdfZ3BhZGNfaW5pdChjaGlwLCBwZGF0YSk7CisJ
aWYgKHJldCA8IDApCisJCWdvdG8gb3V0OworCiAJcmV0ID0gX184OHBtODYwN19pcnFfaW5pdChj
aGlwLCBwZGF0YSk7CiAJaWYgKHJldCA8IDApCiAJCWdvdG8gb3V0OwpAQCAtMzQ0LDkgKzUwMCw5
IEBAIG91dDoKIAlyZXR1cm4gcmV0OwogfQogCi1pbnQgX19kZXZpbml0IHBtODYweF9kZXZpY2Vf
aW5pdChzdHJ1Y3QgcG04NjB4X2NoaXAgKmNoaXAsIHZvaWQgKnBkYXRhKQoraW50IF9fZGV2aW5p
dCBwbTg2MHhfZGV2aWNlX2luaXQoc3RydWN0IHBtODYweF9jaGlwICpjaGlwLAorCQkJCSBzdHJ1
Y3QgcG04NjB4X3BsYXRfZGF0YSAqcGRhdGEpCiB7Ci0JaW50IGksIGNvdW50OwogCWludCByZXQg
PSAtRUlOVkFMOwogCiAJLyogTWl4ZWQgY2hpcCBpc24ndCBpbml0aWFsaXplZCB5ZXQuICovCkBA
IC0zNTQsMjMgKzUxMCw0NiBAQCBpbnQgX19kZXZpbml0IHBtODYweF9kZXZpY2VfaW5pdChzdHJ1
Y3QgcG04NjB4X2NoaXAgKmNoaXAsIHZvaWQgKnBkYXRhKQogCQltdXRleF9pbml0KCZtaXhlZF9j
aGlwLmlvX2xvY2spOwogCiAJaWYgKCFzdHJjbXAoY2hpcC0+aWQubmFtZSwgIjg4UE04NjA3Iikp
IHsKLQkJcmV0ID0gX184OHBtODYwN19pbml0KGNoaXAsIChzdHJ1Y3QgcG04NjB4X3BsYXRfZGF0
YSAqKXBkYXRhKTsKKwkJcmV0ID0gX184OHBtODYwN19pbml0KGNoaXAsIHBkYXRhKTsKIAkJaWYg
KHJldCA8IDApCiAJCQlnb3RvIG91dDsKIAotCQljb3VudCA9IEFSUkFZX1NJWkUocG04NjA3X2Rl
dnMpOwotCQlmb3IgKGkgPSAwOyBpIDwgY291bnQ7IGkrKykgewotCQkJcmV0ID0gbWZkX2FkZF9k
ZXZpY2VzKGNoaXAtPmRldiwgaSwgJnBtODYwN19kZXZzW2ldLAotCQkJCQkgICAgICAxLCBOVUxM
LCAwKTsKLQkJCWlmIChyZXQgIT0gMCkgewotCQkJCWRldl9lcnIoY2hpcC0+ZGV2LCAiRmFpbGVk
IHRvIGFkZCBzdWJkZXZzXG4iKTsKLQkJCQlnb3RvIG91dDsKLQkJCX0KKwkJcmV0ID0gbWZkX2Fk
ZF9kZXZpY2VzKGNoaXAtPmRldiwgMCwgJnJlZ3VsYXRvcl9kZXZzWzBdLAorCQkJCSAgICAgIEFS
UkFZX1NJWkUocmVndWxhdG9yX2RldnMpLAorCQkJCSAgICAgICZyZWd1bGF0b3JfcmVzb3VyY2Vz
WzBdLCAwKTsKKwkJaWYgKHJldCA8IDApCisJCQlkZXZfZXJyKGNoaXAtPmRldiwgIkZhaWxlZCB0
byBhZGQgcmVndWxhdG9yIHN1YmRldlxuIik7CisKKwkJaWYgKHBkYXRhICYmIHBkYXRhLT50b3Vj
aCkgeworCQkJcmV0ID0gbWZkX2FkZF9kZXZpY2VzKGNoaXAtPmRldiwgMCwgJnRvdWNoX2RldnNb
MF0sCisJCQkJCUFSUkFZX1NJWkUodG91Y2hfZGV2cyksCisJCQkJCSZ0b3VjaF9yZXNvdXJjZXNb
MF0sIDApOworCQkJaWYgKHJldCA8IDApCisJCQkJZGV2X2VycihjaGlwLT5kZXYsICJGYWlsZWQg
dG8gYWRkIHRvdWNoICIKKwkJCQkJInN1YmRldlxuIik7CiAJCX0KIAl9IGVsc2UgaWYgKCFzdHJj
bXAoY2hpcC0+aWQubmFtZSwgIjg4UE04NjA2IikpIHsKIAkJcmV0ID0gX184OHBtODYwNl9pbml0
KGNoaXAsIHBkYXRhKTsKIAkJaWYgKHJldCA8IDApCiAJCQlnb3RvIG91dDsKKworCQlpZiAocGRh
dGEgJiYgcGRhdGEtPmJhY2tsaWdodCkgeworCQkJcmV0ID0gbWZkX2FkZF9kZXZpY2VzKGNoaXAt
PmRldiwgMCwgJmJhY2tsaWdodF9kZXZzWzBdLAorCQkJCQlBUlJBWV9TSVpFKGJhY2tsaWdodF9k
ZXZzKSwgCisJCQkJCSZiYWNrbGlnaHRfcmVzb3VyY2VzWzBdLCAwKTsKKwkJCWlmIChyZXQgPCAw
KQorCQkJCWRldl9lcnIoY2hpcC0+ZGV2LCAiRmFpbGVkIHRvIGFkZCBiYWNrbGlnaHQgIgorCQkJ
CQkic3ViZGV2XG4iKTsKKwkJfQorCisJCWlmIChwZGF0YSAmJiBwZGF0YS0+bGVkKSB7CisJCQly
ZXQgPSBtZmRfYWRkX2RldmljZXMoY2hpcC0+ZGV2LCAwLCAmbGVkX2RldnNbMF0sCisJCQkJCUFS
UkFZX1NJWkUobGVkX2RldnMpLCAKKwkJCQkJJmxlZF9yZXNvdXJjZXNbMF0sIDApOworCQkJaWYg
KHJldCA8IDApCisJCQkJZGV2X2VycihjaGlwLT5kZXYsICJGYWlsZWQgdG8gYWRkIGxlZCAiCisJ
CQkJCSJzdWJkZXZcbiIpOworCQl9CiAJfQogb3V0OgogCXJldHVybiByZXQ7CmRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L21mZC84OHBtODYweC5oIGIvaW5jbHVkZS9saW51eC9tZmQvODhwbTg2
MHguaAppbmRleCA5OWE1YTdlLi5iN2Y5YWFjIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L21m
ZC84OHBtODYweC5oCisrKyBiL2luY2x1ZGUvbGludXgvbWZkLzg4cG04NjB4LmgKQEAgLTE0LDYg
KzE0LDggQEAKIAogI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgogCisjZGVmaW5lIE1GRF9O
QU1FX1NJWkUJCSg0MCkKKwogZW51bSB7CiAJREVTQ19JTlZBTCA9IDAsCiAJREVTQ184NjA2LApA
QCAtMjIsNiArMjQsOTkgQEAgZW51bSB7CiB9OwogCiBlbnVtIHsKKwlQTTg2MDZfSURfSU5WQUxJ
RCwKKwlQTTg2MDZfSURfQkFDS0xJR0hULAorCVBNODYwNl9JRF9MRUQsCisJUE04NjA2X0lEX1ZJ
QlJBVE9SLAorCVBNODYwNl9JRF9UT1VDSCwKKwlQTTg2MDZfSURfU09VTkQsCisJUE04NjA2X0lE
X0NIQVJHRVIsCisJUE04NjA2X0lEX01BWCwKK307CisKK2VudW0geworCVBNODYwNl9CQUNLTElH
SFQxID0gMCwKKwlQTTg2MDZfQkFDS0xJR0hUMiwKKwlQTTg2MDZfQkFDS0xJR0hUMywKK307CisK
K2VudW0geworCVBNODYwNl9MRUQxX1JFRCA9IDAsCisJUE04NjA2X0xFRDFfR1JFRU4sCisJUE04
NjA2X0xFRDFfQkxVRSwKKwlQTTg2MDZfTEVEMl9SRUQsCisJUE04NjA2X0xFRDJfR1JFRU4sCisJ
UE04NjA2X0xFRDJfQkxVRSwKKwlQTTg2MDdfTEVEX1ZJQlJBVE9SLAorfTsKKworCisvKiA4NjA2
IFJlZ2lzdGVycyAqLworI2RlZmluZSBQTTg2MDZfRENNX0JPT1NUCQkoMHgwMCkKKyNkZWZpbmUg
UE04NjA2X1BXTQkJCSgweDAxKQorCisvKiBCYWNrbGlnaHQgUmVnaXN0ZXJzICovCisjZGVmaW5l
IFBNODYwNl9XTEVEMUEJCQkoMHgwMikKKyNkZWZpbmUgUE04NjA2X1dMRUQxQgkJCSgweDAzKQor
I2RlZmluZSBQTTg2MDZfV0xFRDJBCQkJKDB4MDQpCisjZGVmaW5lIFBNODYwNl9XTEVEMkIJCQko
MHgwNSkKKyNkZWZpbmUgUE04NjA2X1dMRUQzQQkJCSgweDA2KQorI2RlZmluZSBQTTg2MDZfV0xF
RDNCCQkJKDB4MDcpCisKKy8qIExFRCBSZWdpc3RlcnMgKi8KKyNkZWZpbmUgUE04NjA2X1JHQjJB
CQkJKDB4MDgpCisjZGVmaW5lIFBNODYwNl9SR0IyQgkJCSgweDA5KQorI2RlZmluZSBQTTg2MDZf
UkdCMkMJCQkoMHgwQSkKKyNkZWZpbmUgUE04NjA2X1JHQjJECQkJKDB4MEIpCisjZGVmaW5lIFBN
ODYwNl9SR0IxQQkJCSgweDBDKQorI2RlZmluZSBQTTg2MDZfUkdCMUIJCQkoMHgwRCkKKyNkZWZp
bmUgUE04NjA2X1JHQjFDCQkJKDB4MEUpCisjZGVmaW5lIFBNODYwNl9SR0IxRAkJCSgweDBGKQor
CisjZGVmaW5lIFBNODYwNl9QUkVSRUdVTEFUT1JBCQkoMHgxMCkKKyNkZWZpbmUgUE04NjA2X1BS
RVJFR1VMQVRPUkIJCSgweDExKQorI2RlZmluZSBQTTg2MDZfVklCUkFUT1JBCQkoMHgxMikKKyNk
ZWZpbmUgUE04NjA2X1ZJQlJBVE9SQgkJKDB4MTMpCisjZGVmaW5lIFBNODYwNl9WQ0hHCQkJKDB4
MTQpCisjZGVmaW5lIFBNODYwNl9WU1lTCQkJKDB4MTUpCisjZGVmaW5lIFBNODYwNl9NSVNDCQkJ
KDB4MTYpCisjZGVmaW5lIFBNODYwNl9DSElQX0lECQkJKDB4MTcpCisjZGVmaW5lIFBNODYwNl9T
VEFUVVMJCQkoMHgxOCkKKyNkZWZpbmUgUE04NjA2X0ZMQUdTCQkJKDB4MTkpCisjZGVmaW5lIFBN
ODYwNl9QUk9URUNUQQkJCSgweDFBKQorI2RlZmluZSBQTTg2MDZfUFJPVEVDVEIJCQkoMHgxQikK
KyNkZWZpbmUgUE04NjA2X1BST1RFQ1RDCQkJKDB4MUMpCisKKy8qIEJpdCBkZWZpbml0aW9ucyBv
ZiBQTTg2MDYgcmVnaXN0ZXJzICovCisjZGVmaW5lIFBNODYwNl9EQ01fNTAwTUEJCSgweDApCS8q
IGN1cnJlbnQgbGltaXQgKi8KKyNkZWZpbmUgUE04NjA2X0RDTV83NTBNQQkJKDB4MSkKKyNkZWZp
bmUgUE04NjA2X0RDTV8xMDAwTUEJCSgweDIpCisjZGVmaW5lIFBNODYwNl9EQ01fMTI1ME1BCQko
MHgzKQorI2RlZmluZSBQTTg2MDZfRENNXzI1ME1WCQkoMHgwIDw8IDIpCisjZGVmaW5lIFBNODYw
Nl9EQ01fMzAwTVYJCSgweDEgPDwgMikKKyNkZWZpbmUgUE04NjA2X0RDTV8zNTBNVgkJKDB4MiA8
PCAyKQorI2RlZmluZSBQTTg2MDZfRENNXzQwME1WCQkoMHgzIDw8IDIpCisKKyNkZWZpbmUgUE04
NjA2X1BXTV8zMTIwMEhaCQkoMHgwKQorI2RlZmluZSBQTTg2MDZfUFdNXzE1NjAwSFoJCSgweDEp
CisjZGVmaW5lIFBNODYwNl9QV01fNzgwMEhaCQkoMHgyKQorI2RlZmluZSBQTTg2MDZfUFdNXzM5
MDBIWgkJKDB4MykKKyNkZWZpbmUgUE04NjA2X1BXTV8xOTUwSFoJCSgweDQpCisjZGVmaW5lIFBN
ODYwNl9QV01fOTc2SFoJCSgweDUpCisjZGVmaW5lIFBNODYwNl9QV01fNDg4SFoJCSgweDYpCisj
ZGVmaW5lIFBNODYwNl9QV01fMjQ0SFoJCSgweDcpCisjZGVmaW5lIFBNODYwNl9QV01fRlJFUV9N
QVNLCQkoMHg3KQorCisjZGVmaW5lIFBNODYwNl9XTEVEX09OCQkJKDEgPDwgMCkKKyNkZWZpbmUg
UE04NjA2X1dMRURfQ1VSUkVOVCh4KQkJKCh4ICYgMHgxRikgPDwgMSkKKworI2RlZmluZSBQTTg2
MDZfTEVEX0NVUlJFTlQoeCkJCSgoeCA+PiAyKSAmIDB4MDcpCisKKyNkZWZpbmUgUE04NjA2X1ZT
WVNfRU4JCQkoMSA8PCAxKQorCisjZGVmaW5lIFBNODYwNl9NSVNDX09TQ19FTgkJKDEgPDwgNCkK
KworZW51bSB7CiAJUE04NjA3X0lEX0JVQ0sxID0gMCwKIAlQTTg2MDdfSURfQlVDSzIsCiAJUE04
NjA3X0lEX0JVQ0szLApAQCAtOTEsNiArMTg2LDIxIEBAIGVudW0gewogI2RlZmluZSBQTTg2MDdf
U1VQUExJRVNfRU4yMQkJKDB4MzMpCiAjZGVmaW5lIFBNODYwN19TVVBQTElFU19FTjIyCQkoMHgz
NCkKIAorLyogVmlicmF0b3IgQ29udHJvbCBSZWdpc3RlcnMgKi8KKyNkZWZpbmUgUE04NjA3X1ZJ
QlJBVE9SX1NFVAkJKDB4MjgpCisjZGVmaW5lIFBNODYwN19WSUJSQVRPUl9QV00JCSgweDI5KQor
CisvKiBHUEFEQyBSZWdpc3RlcnMgKi8KKyNkZWZpbmUgUE04NjA3X0dQX0JJQVMxCQkJKDB4NEYp
CisjZGVmaW5lIFBNODYwN19NRUFTX0VOMQkJCSgweDUwKQorI2RlZmluZSBQTTg2MDdfTUVBU19F
TjIJCQkoMHg1MSkKKyNkZWZpbmUgUE04NjA3X01FQVNfRU4zCQkJKDB4NTIpCisjZGVmaW5lIFBN
ODYwN19NRUFTX09GRl9USU1FMQkJKDB4NTMpCisjZGVmaW5lIFBNODYwN19NRUFTX09GRl9USU1F
MgkJKDB4NTQpCisjZGVmaW5lIFBNODYwN19UU0lfUFJFQklBUwkJKDB4NTUpCS8qIHByZWJpYXMg
dGltZSAqLworI2RlZmluZSBQTTg2MDdfUERfUFJFQklBUwkJKDB4NTYpCS8qIHByZWJpYXMgdGlt
ZSAqLworI2RlZmluZSBQTTg2MDdfR1BBRENfTUlTQzEJCSgweDU3KQorCiAvKiBSVEMgQ29udHJv
bCBSZWdpc3RlcnMgKi8KICNkZWZpbmUgUE04NjA3X1JUQzEJCQkoMHhBMCkKICNkZWZpbmUgUE04
NjA3X1JUQ19DT1VOVEVSMQkJKDB4QTEpCkBAIC0xNDAsNiArMjUwLDkgQEAgZW51bSB7CiAjZGVm
aW5lIFBNODYwN19CMF9NSVNDMV9QSTJDCQkoMSA8PCAzKQogI2RlZmluZSBQTTg2MDdfQjBfTUlT
QzFfUkVTRVQJCSgxIDw8IDYpCiAKKy8qIGJpdHMgZGVmaW5pdGlvbnMgb2YgR1BBREMgKi8KKyNk
ZWZpbmUgUE04NjA3X0dQQURDX0VOCQkJKDEgPDwgMCkKKwogLyogSW50ZXJydXB0IE51bWJlciBp
biA4OFBNODYwNyAqLwogZW51bSB7CiAJUE04NjA3X0lSUV9PTktFWSA9IDAsCkBAIC0yMTMsMTIg
KzMyNiw0MyBAQCBlbnVtIHsKIAlQSTJDX1BPUlQsCiB9OwogCitzdHJ1Y3QgcG04NjB4X2JhY2ts
aWdodF9wZGF0YSB7CisJaW50CQlpZDsKKwlpbnQJCXB3bTsKKwlpbnQJCWlzZXQ7CisJdW5zaWdu
ZWQgbG9uZwlmbGFnczsKK307CisKK3N0cnVjdCBwbTg2MHhfbGVkX3BkYXRhIHsKKwlpbnQJCWlk
OworCWludAkJaXNldDsKKwl1bnNpZ25lZCBsb25nCWZsYWdzOworfTsKKworc3RydWN0IHBtODYw
eF90b3VjaF9wZGF0YSB7CisJaW50CQlncGFkY19wcmViaWFzOworCWludAkJc2xvdF9jeWNsZTsK
KwlpbnQJCW9mZl9zY2FsZTsKKwlpbnQJCXN3X2NhbDsKKwlpbnQJCXRzaV9wcmViaWFzOwkvKiB0
aW1lLCBzbG90ICovCisJaW50CQlwZW5fcHJlYmlhczsJLyogdGltZSwgc2xvdCAqLworCWludAkJ
cGVuX3ByZWNoZzsJLyogdGltZSwgc2xvdCAqLworCXVuc2lnbmVkIGxvbmcJZmxhZ3M7Cit9Owor
CiBzdHJ1Y3QgcG04NjB4X3BsYXRfZGF0YSB7CisJc3RydWN0IHBtODYweF9iYWNrbGlnaHRfcGRh
dGEJKmJhY2tsaWdodDsKKwlzdHJ1Y3QgcG04NjB4X2xlZF9wZGF0YQkJKmxlZDsKKwlzdHJ1Y3Qg
cG04NjB4X3RvdWNoX3BkYXRhCSp0b3VjaDsKKwogCWludAlpMmNfcG9ydDsJLyogQ29udHJvbGxl
ZCBieSBHSTJDIG9yIFBJMkMgKi8KIAlpbnQJaXJxX21vZGU7CS8qIENsZWFyIGludGVycnVwdCBi
eSByZWFkL3dyaXRlICgxLzApICovCiAJc3RydWN0IHJlZ3VsYXRvcl9pbml0X2RhdGEgKnJlZ3Vs
YXRvcltQTTg2MDdfTUFYX1JFR1VMQVRPUl07CiB9OwogCitleHRlcm4gY2hhciBwbTg2MHhfYmFj
a2xpZ2h0X25hbWVbXVtNRkRfTkFNRV9TSVpFXTsKK2V4dGVybiBjaGFyIHBtODYweF9sZWRfbmFt
ZVtdW01GRF9OQU1FX1NJWkVdOworCiBleHRlcm4gaW50IHBtODYweF9yZWdfcmVhZChzdHJ1Y3Qg
bWl4ZWRfODhwbTg2MHggKiwgaW50LCBpbnQpOwogZXh0ZXJuIGludCBwbTg2MHhfcmVnX3dyaXRl
KHN0cnVjdCBtaXhlZF84OHBtODYweCAqLCBpbnQsIGludCwgdW5zaWduZWQgY2hhcik7CiBleHRl
cm4gaW50IHBtODYweF9idWxrX3JlYWQoc3RydWN0IG1peGVkXzg4cG04NjB4ICosIGludCwgaW50
LCBpbnQsCkBAIC0yMzQsNyArMzc4LDggQEAgZXh0ZXJuIGludCBwbTg2MHhfcmVxdWVzdF9pcnEo
c3RydWN0IHBtODYweF9jaGlwICosIGludCwKIAkJCSAgICAgIGlycV9oYW5kbGVyX3QgaGFuZGxl
ciwgdm9pZCAqKTsKIGV4dGVybiBpbnQgcG04NjB4X2ZyZWVfaXJxKHN0cnVjdCBwbTg2MHhfY2hp
cCAqLCBpbnQpOwogCi1leHRlcm4gaW50IHBtODYweF9kZXZpY2VfaW5pdChzdHJ1Y3QgcG04NjB4
X2NoaXAgKmNoaXAsIHZvaWQgKnBkYXRhKTsKK2V4dGVybiBpbnQgcG04NjB4X2RldmljZV9pbml0
KHN0cnVjdCBwbTg2MHhfY2hpcCAqY2hpcCwKKwkJCSAgICAgIHN0cnVjdCBwbTg2MHhfcGxhdF9k
YXRhICpwZGF0YSk7CiBleHRlcm4gdm9pZCBwbTg2MHhfZGV2aWNlX2V4aXQoc3RydWN0IHBtODYw
eF9jaGlwICpjaGlwKTsKIAogI2VuZGlmIC8qIF9fTElOVVhfTUZEXzg4UE04NjBYX0ggKi8KLS0g
CjEuNS42LjUKCg==
--0016363b79840d295204788b4783--
