From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 10 Nov 2009 17:26:22 -0500
Subject: [PATCH] led: enable led in 88pm860x
Message-ID: <mailman.36.1258439366.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable led sub device in Marvell 88PM860x. Two LED arrays can be supported.
Each LED array can be used for R,G,B leds.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/leds/Kconfig         |    7 +
 drivers/leds/Makefile        |    1 +
 drivers/leds/leds-88pm860x.c |  334 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 342 insertions(+), 0 deletions(-)
 create mode 100644 drivers/leds/leds-88pm860x.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index e4f599f..6dbb85a 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -236,6 +236,13 @@ config LEDS_BD2802
 	  This option enables support for BD2802GU RGB LED driver chips
 	  accessed via the I2C bus.

+config LEDS_88PM860X
+	bool "LED Support for Marvell 88PM860x PMIC"
+	depends on LEDS_CLASS && MFD_88PM860X
+	help
+	  This option enables support for on-chip LED drivers found on Marvell
+	  Semiconductor 88PM8606 PMIC.
+
 comment "LED Triggers"

 config LEDS_TRIGGERS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 46d7270..361ae38 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_LEDS_DA903X)		+=3D leds-da903x.o
 obj-$(CONFIG_LEDS_WM831X_STATUS)	+=3D leds-wm831x-status.o
 obj-$(CONFIG_LEDS_WM8350)		+=3D leds-wm8350.o
 obj-$(CONFIG_LEDS_PWM)			+=3D leds-pwm.o
+obj-$(CONFIG_LEDS_88PM860X)		+=3D leds-88pm860x.o

 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+=3D leds-dac124s085.o
diff --git a/drivers/leds/leds-88pm860x.c b/drivers/leds/leds-88pm860x.c
new file mode 100644
index 0000000..cdd77f5
--- /dev/null
+++ b/drivers/leds/leds-88pm860x.c
@@ -0,0 +1,334 @@
+/*
+ * LED driver for Marvell 88PM860x
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ *	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/mfd/88pm860x.h>
+
+#define LED_PWM_SHIFT		(3)
+#define LED_PWM_MASK		(0x1F)
+#define LED_CURRENT_MASK	(0x07 << 5)
+
+#define LED_BLINK_ON_MASK	(0x07)
+#define LED_BLINK_PERIOD_MASK	(0x0F << 3)
+#define LED_BLINK_MASK		(0x7F)
+
+#define LED_BLINK_ON(x)		((x & 0x7) * 66 + 66)
+#define LED_BLINK_PERIOD(x)	((x & 0xF) * 530 + 930)
+#define LED_BLINK_ON_MIN	LED_BLINK_ON(0)
+#define LED_BLINK_ON_MAX	LED_BLINK_ON(0x7)
+#define LED_BLINK_PERIOD_MIN	LED_BLINK_PERIOD(0)
+#define LED_BLINK_PERIOD_MAX	LED_BLINK_PERIOD(0xE)
+#define LED_TO_ON(x)		((x - 66) / 66)
+#define LED_TO_PERIOD(x)	((x - 930) / 530)
+
+#define LED1_BLINK_EN		(1 << 1)
+#define LED2_BLINK_EN		(1 << 2)
+
+struct pm860x_led {
+	struct led_classdev cdev;
+	struct pm860x_chip *chip;
+	struct mutex lock;
+	char name[MFD_NAME_SIZE];
+	int port;
+	int iset;
+
+	int blink;
+	int blink_time;
+	int blink_on;
+	int blink_off;
+	int current_brightness;
+};
+
+/* return offset of color register */
+static inline int __led_off(int port)
+{
+	int ret =3D -EINVAL;
+
+	switch (port) {
+	case PM8606_LED1_RED:
+	case PM8606_LED1_GREEN:
+	case PM8606_LED1_BLUE:
+		ret =3D port - PM8606_LED1_RED + PM8606_RGB1B;
+		break;
+	case PM8606_LED2_RED:
+	case PM8606_LED2_GREEN:
+	case PM8606_LED2_BLUE:
+		ret =3D port - PM8606_LED2_RED + PM8606_RGB2B;
+		break;
+	}
+	return ret;
+}
+
+/* return offset of blink register */
+static inline int __blink_off(int port)
+{
+	int ret =3D -EINVAL;
+
+	switch (port) {
+	case PM8606_LED1_RED:
+	case PM8606_LED1_GREEN:
+	case PM8606_LED1_BLUE:
+		ret =3D PM8606_RGB1A;
+	case PM8606_LED2_RED:
+	case PM8606_LED2_GREEN:
+	case PM8606_LED2_BLUE:
+		ret =3D PM8606_RGB2A;
+	}
+	return ret;
+}
+
+static inline int __blink_ctl_mask(int port)
+{
+	int ret =3D -EINVAL;
+
+	switch (port) {
+	case PM8606_LED1_RED:
+	case PM8606_LED1_GREEN:
+	case PM8606_LED1_BLUE:
+		ret =3D LED1_BLINK_EN;
+		break;
+	case PM8606_LED2_RED:
+	case PM8606_LED2_GREEN:
+	case PM8606_LED2_BLUE:
+		ret =3D LED2_BLINK_EN;
+		break;
+	}
+	return ret;
+}
+
+static void pm860x_led_set(struct led_classdev *cdev,
+			   enum led_brightness value)
+{
+	struct pm860x_led *data =3D container_of(cdev, struct pm860x_led, cdev);
+	struct pm860x_chip *chip =3D data->chip;
+	unsigned char brightness;
+	int offset;
+	int ret =3D -EINVAL;
+
+	offset =3D __led_off(data->port);
+
+	mutex_lock(&data->lock);
+	brightness =3D value >> 3;
+
+	if ((data->current_brightness =3D=3D 0) && brightness) {
+		if (data->iset) {
+			ret =3D pm860x_set_bits(chip->parent, DESC_8606, offset,
+					      LED_CURRENT_MASK, data->iset);
+			if (ret < 0)
+				goto out;
+		}
+	}
+
+	ret =3D pm860x_set_bits(chip->parent, DESC_8606, offset,
+			      LED_PWM_MASK, brightness);
+	if (ret < 0)
+		goto out;
+	mutex_unlock(&data->lock);
+
+	data->current_brightness =3D brightness;
+	dev_dbg(chip->dev, "Update LED. (reg:%d, brightness:%d)\n",
+		offset, brightness);
+	return;
+out:
+	mutex_unlock(&data->lock);
+	dev_err(chip->dev, "Fail on update LED. (reg:%d, brightness:%d)\n",
+		offset, brightness);
+	return;
+}
+
+static enum led_brightness pm860x_led_get(struct led_classdev *cdev)
+{
+	struct pm860x_led *data =3D container_of(cdev, struct pm860x_led, cdev);
+	struct pm860x_chip *chip =3D data->chip;
+	enum led_brightness brightness =3D LED_OFF;
+	int offset =3D 0, ret =3D -EINVAL;
+
+	offset =3D __led_off(data->port);
+
+	mutex_lock(&data->lock);
+	ret =3D pm860x_reg_read(chip->parent, DESC_8606, offset);
+	if (ret < 0)
+		goto out;
+	ret &=3D LED_PWM_MASK;
+	if (ret >=3D (LED_FULL >> LED_PWM_SHIFT))
+		brightness =3D LED_FULL;
+	else if (ret < (LED_HALF >> LED_PWM_SHIFT))
+		brightness =3D LED_OFF;
+	else
+		brightness =3D LED_HALF;
+out:
+	mutex_unlock(&data->lock);
+	dev_dbg(chip->dev, "Read LED. (reg:%d, brightness:%d, ret:%d)\n",
+		offset, brightness, ret);
+	return brightness;
+}
+
+static int pm860x_led_blink(struct led_classdev *cdev,
+			    unsigned long *delay_on,
+			    unsigned long *delay_off)
+{
+	struct pm860x_led *data =3D container_of(cdev, struct pm860x_led, cdev);
+	struct pm860x_chip *chip =3D data->chip;
+	int period, on, offset, sum;
+	int ret =3D -EINVAL;
+
+	offset =3D __blink_off(data->port);
+
+	on =3D *delay_on;
+	if (on < LED_BLINK_ON_MIN)
+		on =3D LED_BLINK_ON_MIN;
+	if (on > LED_BLINK_ON_MAX)
+		on =3D LED_BLINK_ON_MAX;
+
+	on =3D LED_TO_ON(on);
+	on =3D LED_BLINK_ON(on);
+
+	period =3D on + *delay_off;
+	if (period < LED_BLINK_PERIOD_MIN)
+		period =3D LED_BLINK_PERIOD_MIN;
+	if (period > LED_BLINK_PERIOD_MAX)
+		period =3D LED_BLINK_PERIOD_MAX;
+	period =3D LED_TO_PERIOD(period);
+	period =3D LED_BLINK_PERIOD(period);
+
+	mutex_lock(&data->lock);
+	data->blink_on =3D on;
+	data->blink_off =3D period - data->blink_on;
+	sum =3D (period << 3) | data->blink_on;
+
+	ret =3D pm860x_set_bits(chip->parent, DESC_8606, offset,
+			      LED_BLINK_MASK, sum);
+	if (ret < 0)
+		goto out;
+
+	offset =3D __blink_ctl_mask(data->port);
+	ret =3D pm860x_set_bits(chip->parent, DESC_8606, PM8606_WLED3B,
+			      offset, offset);
+	if (ret < 0)
+		goto out;
+	mutex_unlock(&data->lock);
+
+	dev_dbg(chip->dev, "LED blink delay on:%dms, delay off:%dms\n",
+		data->blink_on, data->blink_off);
+	return 0;
+out:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int __check_device(struct pm860x_led_pdata *pdata, char *name)
+{
+	struct pm860x_led_pdata *p =3D pdata;
+	int ret =3D -EINVAL;
+
+	while (p && p->id) {
+		if ((p->id !=3D PM8606_ID_LED) || (p->flags < 0))
+			break;
+
+		if (!strncmp(name, pm860x_led_name[p->flags],
+			MFD_NAME_SIZE)) {
+			ret =3D (int)p->flags;
+			break;
+		}
+		p++;
+	}
+	return ret;
+}
+
+static int pm860x_led_probe(struct platform_device *pdev)
+{
+	struct pm860x_chip *chip =3D dev_get_drvdata(pdev->dev.parent);
+	struct pm860x_plat_data *pm860x_pdata;
+	struct pm860x_led_pdata *pdata;
+	struct pm860x_led *data;
+	struct resource *res;
+	int ret;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (res =3D=3D NULL) {
+		dev_err(&pdev->dev, "No I/O resource!\n");
+		return -EINVAL;
+	}
+
+	if (pdev->dev.parent->platform_data) {
+		pm860x_pdata =3D pdev->dev.parent->platform_data;
+		pdata =3D pm860x_pdata->led;
+	} else
+		pdata =3D NULL;
+
+	data =3D kzalloc(sizeof(struct pm860x_led), GFP_KERNEL);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+	strncpy(data->name, res->name, MFD_NAME_SIZE);
+	dev_set_drvdata(&pdev->dev, data);
+	data->chip =3D chip;
+	data->iset =3D pdata->iset;
+	data->port =3D __check_device(pdata, data->name);
+	if (data->port < 0)
+		return -EINVAL;
+
+	data->current_brightness =3D 0;
+	data->cdev.name =3D data->name;
+	data->cdev.brightness_set =3D pm860x_led_set;
+	data->cdev.brightness_get =3D pm860x_led_get;
+	data->cdev.blink_set =3D pm860x_led_blink;
+	mutex_init(&data->lock);
+
+	ret =3D led_classdev_register(chip->dev, &data->cdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register LED: %d\n", ret);
+		goto out;
+	}
+	return 0;
+out:
+	kfree(data);
+	return ret;
+}
+
+static int pm860x_led_remove(struct platform_device *pdev)
+{
+	struct pm860x_led *data =3D platform_get_drvdata(pdev);
+
+	led_classdev_unregister(&data->cdev);
+	kfree(data);
+
+	return 0;
+}
+
+static struct platform_driver pm860x_led_driver =3D {
+	.driver	=3D {
+		.name	=3D "88pm860x-led",
+		.owner	=3D THIS_MODULE,
+	},
+	.probe	=3D pm860x_led_probe,
+	.remove	=3D pm860x_led_remove,
+};
+
+static int __devinit pm860x_led_init(void)
+{
+	return platform_driver_register(&pm860x_led_driver);
+}
+module_init(pm860x_led_init);
+
+static void __devexit pm860x_led_exit(void)
+{
+	platform_driver_unregister(&pm860x_led_driver);
+}
+module_exit(pm860x_led_exit);
+
+MODULE_DESCRIPTION("LED driver for Marvell PM860x");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:88pm860x-led");
--=20
1.5.6.5

--000325574fb2f14a2f04788b3e2a
Content-Type: text/x-patch; charset=US-ASCII; name="0008-led-enable-led-in-88pm860x.patch"
Content-Disposition: attachment; 
	filename="0008-led-enable-led-in-88pm860x.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g24r1l730

RnJvbSAzZWRmY2M1MjczYWRhMmJiYTYwMGM2N2QwMmI3OWRiMTE0ZTMxZjgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IFR1ZSwgMTAgTm92IDIwMDkgMTc6MjY6MjIgLTA1MDAKU3ViamVjdDogW1BB
VENIXSBsZWQ6IGVuYWJsZSBsZWQgaW4gODhwbTg2MHgKCkVuYWJsZSBsZWQgc3ViIGRldmljZSBp
biBNYXJ2ZWxsIDg4UE04NjB4LiBUd28gTEVEIGFycmF5cyBjYW4gYmUgc3VwcG9ydGVkLgpFYWNo
IExFRCBhcnJheSBjYW4gYmUgdXNlZCBmb3IgUixHLEIgbGVkcy4KClNpZ25lZC1vZmYtYnk6IEhh
b2ppYW4gWmh1YW5nIDxoYW9qaWFuLnpodWFuZ0BtYXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL2xl
ZHMvS2NvbmZpZyAgICAgICAgIHwgICAgNyArCiBkcml2ZXJzL2xlZHMvTWFrZWZpbGUgICAgICAg
IHwgICAgMSArCiBkcml2ZXJzL2xlZHMvbGVkcy04OHBtODYweC5jIHwgIDMzNCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMzQyIGlu
c2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9s
ZWRzL2xlZHMtODhwbTg2MHguYwoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbGVkcy9LY29uZmlnIGIv
ZHJpdmVycy9sZWRzL0tjb25maWcKaW5kZXggZTRmNTk5Zi4uNmRiYjg1YSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9sZWRzL0tjb25maWcKKysrIGIvZHJpdmVycy9sZWRzL0tjb25maWcKQEAgLTIzNiw2
ICsyMzYsMTMgQEAgY29uZmlnIExFRFNfQkQyODAyCiAJICBUaGlzIG9wdGlvbiBlbmFibGVzIHN1
cHBvcnQgZm9yIEJEMjgwMkdVIFJHQiBMRUQgZHJpdmVyIGNoaXBzCiAJICBhY2Nlc3NlZCB2aWEg
dGhlIEkyQyBidXMuCiAKK2NvbmZpZyBMRURTXzg4UE04NjBYCisJYm9vbCAiTEVEIFN1cHBvcnQg
Zm9yIE1hcnZlbGwgODhQTTg2MHggUE1JQyIKKwlkZXBlbmRzIG9uIExFRFNfQ0xBU1MgJiYgTUZE
Xzg4UE04NjBYCisJaGVscAorCSAgVGhpcyBvcHRpb24gZW5hYmxlcyBzdXBwb3J0IGZvciBvbi1j
aGlwIExFRCBkcml2ZXJzIGZvdW5kIG9uIE1hcnZlbGwKKwkgIFNlbWljb25kdWN0b3IgODhQTTg2
MDYgUE1JQy4KKwogY29tbWVudCAiTEVEIFRyaWdnZXJzIgogCiBjb25maWcgTEVEU19UUklHR0VS
UwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9sZWRzL01ha2VmaWxlIGIvZHJpdmVycy9sZWRzL01ha2Vm
aWxlCmluZGV4IDQ2ZDcyNzAuLjM2MWFlMzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbGVkcy9NYWtl
ZmlsZQorKysgYi9kcml2ZXJzL2xlZHMvTWFrZWZpbGUKQEAgLTI5LDYgKzI5LDcgQEAgb2JqLSQo
Q09ORklHX0xFRFNfREE5MDNYKQkJKz0gbGVkcy1kYTkwM3gubwogb2JqLSQoQ09ORklHX0xFRFNf
V004MzFYX1NUQVRVUykJKz0gbGVkcy13bTgzMXgtc3RhdHVzLm8KIG9iai0kKENPTkZJR19MRURT
X1dNODM1MCkJCSs9IGxlZHMtd204MzUwLm8KIG9iai0kKENPTkZJR19MRURTX1BXTSkJCQkrPSBs
ZWRzLXB3bS5vCitvYmotJChDT05GSUdfTEVEU184OFBNODYwWCkJCSs9IGxlZHMtODhwbTg2MHgu
bwogCiAjIExFRCBTUEkgRHJpdmVycwogb2JqLSQoQ09ORklHX0xFRFNfREFDMTI0UzA4NSkJCSs9
IGxlZHMtZGFjMTI0czA4NS5vCmRpZmYgLS1naXQgYS9kcml2ZXJzL2xlZHMvbGVkcy04OHBtODYw
eC5jIGIvZHJpdmVycy9sZWRzL2xlZHMtODhwbTg2MHguYwpuZXcgZmlsZSBtb2RlIDEwMDY0NApp
bmRleCAwMDAwMDAwLi5jZGQ3N2Y1Ci0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9sZWRzL2xl
ZHMtODhwbTg2MHguYwpAQCAtMCwwICsxLDMzNCBAQAorLyoKKyAqIExFRCBkcml2ZXIgZm9yIE1h
cnZlbGwgODhQTTg2MHgKKyAqCisgKiBDb3B5cmlnaHQgKEMpIDIwMDkgTWFydmVsbCBJbnRlcm5h
dGlvbmFsIEx0ZC4KKyAqCUhhb2ppYW4gWmh1YW5nIDxoYW9qaWFuLnpodWFuZ0BtYXJ2ZWxsLmNv
bT4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3Ry
aWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUg
RnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICoKKyAqLworCisjaW5jbHVkZSA8bGludXgva2Vy
bmVsLmg+CisjaW5jbHVkZSA8bGludXgvaW5pdC5oPgorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3Jt
X2RldmljZS5oPgorI2luY2x1ZGUgPGxpbnV4L2xlZHMuaD4KKyNpbmNsdWRlIDxsaW51eC9tZmQv
ODhwbTg2MHguaD4KKworI2RlZmluZSBMRURfUFdNX1NISUZUCQkoMykKKyNkZWZpbmUgTEVEX1BX
TV9NQVNLCQkoMHgxRikKKyNkZWZpbmUgTEVEX0NVUlJFTlRfTUFTSwkoMHgwNyA8PCA1KQorCisj
ZGVmaW5lIExFRF9CTElOS19PTl9NQVNLCSgweDA3KQorI2RlZmluZSBMRURfQkxJTktfUEVSSU9E
X01BU0sJKDB4MEYgPDwgMykKKyNkZWZpbmUgTEVEX0JMSU5LX01BU0sJCSgweDdGKQorCisjZGVm
aW5lIExFRF9CTElOS19PTih4KQkJKCh4ICYgMHg3KSAqIDY2ICsgNjYpCisjZGVmaW5lIExFRF9C
TElOS19QRVJJT0QoeCkJKCh4ICYgMHhGKSAqIDUzMCArIDkzMCkKKyNkZWZpbmUgTEVEX0JMSU5L
X09OX01JTglMRURfQkxJTktfT04oMCkKKyNkZWZpbmUgTEVEX0JMSU5LX09OX01BWAlMRURfQkxJ
TktfT04oMHg3KQorI2RlZmluZSBMRURfQkxJTktfUEVSSU9EX01JTglMRURfQkxJTktfUEVSSU9E
KDApCisjZGVmaW5lIExFRF9CTElOS19QRVJJT0RfTUFYCUxFRF9CTElOS19QRVJJT0QoMHhFKQor
I2RlZmluZSBMRURfVE9fT04oeCkJCSgoeCAtIDY2KSAvIDY2KQorI2RlZmluZSBMRURfVE9fUEVS
SU9EKHgpCSgoeCAtIDkzMCkgLyA1MzApCisKKyNkZWZpbmUgTEVEMV9CTElOS19FTgkJKDEgPDwg
MSkKKyNkZWZpbmUgTEVEMl9CTElOS19FTgkJKDEgPDwgMikKKworc3RydWN0IHBtODYweF9sZWQg
eworCXN0cnVjdCBsZWRfY2xhc3NkZXYgY2RldjsKKwlzdHJ1Y3QgcG04NjB4X2NoaXAgKmNoaXA7
CisJc3RydWN0IG11dGV4IGxvY2s7CisJY2hhciBuYW1lW01GRF9OQU1FX1NJWkVdOworCWludCBw
b3J0OworCWludCBpc2V0OworCisJaW50IGJsaW5rOworCWludCBibGlua190aW1lOworCWludCBi
bGlua19vbjsKKwlpbnQgYmxpbmtfb2ZmOworCWludCBjdXJyZW50X2JyaWdodG5lc3M7Cit9Owor
CisvKiByZXR1cm4gb2Zmc2V0IG9mIGNvbG9yIHJlZ2lzdGVyICovCitzdGF0aWMgaW5saW5lIGlu
dCBfX2xlZF9vZmYoaW50IHBvcnQpCit7CisJaW50IHJldCA9IC1FSU5WQUw7CisKKwlzd2l0Y2gg
KHBvcnQpIHsKKwljYXNlIFBNODYwNl9MRUQxX1JFRDoKKwljYXNlIFBNODYwNl9MRUQxX0dSRUVO
OgorCWNhc2UgUE04NjA2X0xFRDFfQkxVRToKKwkJcmV0ID0gcG9ydCAtIFBNODYwNl9MRUQxX1JF
RCArIFBNODYwNl9SR0IxQjsKKwkJYnJlYWs7CisJY2FzZSBQTTg2MDZfTEVEMl9SRUQ6CisJY2Fz
ZSBQTTg2MDZfTEVEMl9HUkVFTjoKKwljYXNlIFBNODYwNl9MRUQyX0JMVUU6CisJCXJldCA9IHBv
cnQgLSBQTTg2MDZfTEVEMl9SRUQgKyBQTTg2MDZfUkdCMkI7CisJCWJyZWFrOworCX0KKwlyZXR1
cm4gcmV0OworfQorCisvKiByZXR1cm4gb2Zmc2V0IG9mIGJsaW5rIHJlZ2lzdGVyICovCitzdGF0
aWMgaW5saW5lIGludCBfX2JsaW5rX29mZihpbnQgcG9ydCkKK3sKKwlpbnQgcmV0ID0gLUVJTlZB
TDsKKworCXN3aXRjaCAocG9ydCkgeworCWNhc2UgUE04NjA2X0xFRDFfUkVEOgorCWNhc2UgUE04
NjA2X0xFRDFfR1JFRU46CisJY2FzZSBQTTg2MDZfTEVEMV9CTFVFOgorCQlyZXQgPSBQTTg2MDZf
UkdCMUE7CisJY2FzZSBQTTg2MDZfTEVEMl9SRUQ6CisJY2FzZSBQTTg2MDZfTEVEMl9HUkVFTjoK
KwljYXNlIFBNODYwNl9MRUQyX0JMVUU6CisJCXJldCA9IFBNODYwNl9SR0IyQTsKKwl9CisJcmV0
dXJuIHJldDsKK30KKworc3RhdGljIGlubGluZSBpbnQgX19ibGlua19jdGxfbWFzayhpbnQgcG9y
dCkKK3sKKwlpbnQgcmV0ID0gLUVJTlZBTDsKKworCXN3aXRjaCAocG9ydCkgeworCWNhc2UgUE04
NjA2X0xFRDFfUkVEOgorCWNhc2UgUE04NjA2X0xFRDFfR1JFRU46CisJY2FzZSBQTTg2MDZfTEVE
MV9CTFVFOgorCQlyZXQgPSBMRUQxX0JMSU5LX0VOOworCQlicmVhazsKKwljYXNlIFBNODYwNl9M
RUQyX1JFRDoKKwljYXNlIFBNODYwNl9MRUQyX0dSRUVOOgorCWNhc2UgUE04NjA2X0xFRDJfQkxV
RToKKwkJcmV0ID0gTEVEMl9CTElOS19FTjsKKwkJYnJlYWs7CisJfQorCXJldHVybiByZXQ7Cit9
CisKK3N0YXRpYyB2b2lkIHBtODYweF9sZWRfc2V0KHN0cnVjdCBsZWRfY2xhc3NkZXYgKmNkZXYs
CisJCQkgICBlbnVtIGxlZF9icmlnaHRuZXNzIHZhbHVlKQoreworCXN0cnVjdCBwbTg2MHhfbGVk
ICpkYXRhID0gY29udGFpbmVyX29mKGNkZXYsIHN0cnVjdCBwbTg2MHhfbGVkLCBjZGV2KTsKKwlz
dHJ1Y3QgcG04NjB4X2NoaXAgKmNoaXAgPSBkYXRhLT5jaGlwOworCXVuc2lnbmVkIGNoYXIgYnJp
Z2h0bmVzczsKKwlpbnQgb2Zmc2V0OworCWludCByZXQgPSAtRUlOVkFMOworCisJb2Zmc2V0ID0g
X19sZWRfb2ZmKGRhdGEtPnBvcnQpOworCisJbXV0ZXhfbG9jaygmZGF0YS0+bG9jayk7CisJYnJp
Z2h0bmVzcyA9IHZhbHVlID4+IDM7CisKKwlpZiAoKGRhdGEtPmN1cnJlbnRfYnJpZ2h0bmVzcyA9
PSAwKSAmJiBicmlnaHRuZXNzKSB7CisJCWlmIChkYXRhLT5pc2V0KSB7CisJCQlyZXQgPSBwbTg2
MHhfc2V0X2JpdHMoY2hpcC0+cGFyZW50LCBERVNDXzg2MDYsIG9mZnNldCwKKwkJCQkJICAgICAg
TEVEX0NVUlJFTlRfTUFTSywgZGF0YS0+aXNldCk7CisJCQlpZiAocmV0IDwgMCkKKwkJCQlnb3Rv
IG91dDsKKwkJfQorCX0KKworCXJldCA9IHBtODYweF9zZXRfYml0cyhjaGlwLT5wYXJlbnQsIERF
U0NfODYwNiwgb2Zmc2V0LAorCQkJICAgICAgTEVEX1BXTV9NQVNLLCBicmlnaHRuZXNzKTsKKwlp
ZiAocmV0IDwgMCkKKwkJZ290byBvdXQ7CisJbXV0ZXhfdW5sb2NrKCZkYXRhLT5sb2NrKTsKKwor
CWRhdGEtPmN1cnJlbnRfYnJpZ2h0bmVzcyA9IGJyaWdodG5lc3M7CisJZGV2X2RiZyhjaGlwLT5k
ZXYsICJVcGRhdGUgTEVELiAocmVnOiVkLCBicmlnaHRuZXNzOiVkKVxuIiwKKwkJb2Zmc2V0LCBi
cmlnaHRuZXNzKTsKKwlyZXR1cm47CitvdXQ6CisJbXV0ZXhfdW5sb2NrKCZkYXRhLT5sb2NrKTsK
KwlkZXZfZXJyKGNoaXAtPmRldiwgIkZhaWwgb24gdXBkYXRlIExFRC4gKHJlZzolZCwgYnJpZ2h0
bmVzczolZClcbiIsCisJCW9mZnNldCwgYnJpZ2h0bmVzcyk7CisJcmV0dXJuOworfQorCitzdGF0
aWMgZW51bSBsZWRfYnJpZ2h0bmVzcyBwbTg2MHhfbGVkX2dldChzdHJ1Y3QgbGVkX2NsYXNzZGV2
ICpjZGV2KQoreworCXN0cnVjdCBwbTg2MHhfbGVkICpkYXRhID0gY29udGFpbmVyX29mKGNkZXYs
IHN0cnVjdCBwbTg2MHhfbGVkLCBjZGV2KTsKKwlzdHJ1Y3QgcG04NjB4X2NoaXAgKmNoaXAgPSBk
YXRhLT5jaGlwOworCWVudW0gbGVkX2JyaWdodG5lc3MgYnJpZ2h0bmVzcyA9IExFRF9PRkY7CisJ
aW50IG9mZnNldCA9IDAsIHJldCA9IC1FSU5WQUw7CisKKwlvZmZzZXQgPSBfX2xlZF9vZmYoZGF0
YS0+cG9ydCk7CisKKwltdXRleF9sb2NrKCZkYXRhLT5sb2NrKTsKKwlyZXQgPSBwbTg2MHhfcmVn
X3JlYWQoY2hpcC0+cGFyZW50LCBERVNDXzg2MDYsIG9mZnNldCk7CisJaWYgKHJldCA8IDApCisJ
CWdvdG8gb3V0OworCXJldCAmPSBMRURfUFdNX01BU0s7CisJaWYgKHJldCA+PSAoTEVEX0ZVTEwg
Pj4gTEVEX1BXTV9TSElGVCkpCisJCWJyaWdodG5lc3MgPSBMRURfRlVMTDsKKwllbHNlIGlmIChy
ZXQgPCAoTEVEX0hBTEYgPj4gTEVEX1BXTV9TSElGVCkpCisJCWJyaWdodG5lc3MgPSBMRURfT0ZG
OworCWVsc2UKKwkJYnJpZ2h0bmVzcyA9IExFRF9IQUxGOworb3V0OgorCW11dGV4X3VubG9jaygm
ZGF0YS0+bG9jayk7CisJZGV2X2RiZyhjaGlwLT5kZXYsICJSZWFkIExFRC4gKHJlZzolZCwgYnJp
Z2h0bmVzczolZCwgcmV0OiVkKVxuIiwKKwkJb2Zmc2V0LCBicmlnaHRuZXNzLCByZXQpOworCXJl
dHVybiBicmlnaHRuZXNzOworfQorCitzdGF0aWMgaW50IHBtODYweF9sZWRfYmxpbmsoc3RydWN0
IGxlZF9jbGFzc2RldiAqY2RldiwKKwkJCSAgICB1bnNpZ25lZCBsb25nICpkZWxheV9vbiwKKwkJ
CSAgICB1bnNpZ25lZCBsb25nICpkZWxheV9vZmYpCit7CisJc3RydWN0IHBtODYweF9sZWQgKmRh
dGEgPSBjb250YWluZXJfb2YoY2Rldiwgc3RydWN0IHBtODYweF9sZWQsIGNkZXYpOworCXN0cnVj
dCBwbTg2MHhfY2hpcCAqY2hpcCA9IGRhdGEtPmNoaXA7CisJaW50IHBlcmlvZCwgb24sIG9mZnNl
dCwgc3VtOworCWludCByZXQgPSAtRUlOVkFMOworCisJb2Zmc2V0ID0gX19ibGlua19vZmYoZGF0
YS0+cG9ydCk7CisKKwlvbiA9ICpkZWxheV9vbjsKKwlpZiAob24gPCBMRURfQkxJTktfT05fTUlO
KQorCQlvbiA9IExFRF9CTElOS19PTl9NSU47CisJaWYgKG9uID4gTEVEX0JMSU5LX09OX01BWCkK
KwkJb24gPSBMRURfQkxJTktfT05fTUFYOworCisJb24gPSBMRURfVE9fT04ob24pOworCW9uID0g
TEVEX0JMSU5LX09OKG9uKTsKKworCXBlcmlvZCA9IG9uICsgKmRlbGF5X29mZjsKKwlpZiAocGVy
aW9kIDwgTEVEX0JMSU5LX1BFUklPRF9NSU4pCisJCXBlcmlvZCA9IExFRF9CTElOS19QRVJJT0Rf
TUlOOworCWlmIChwZXJpb2QgPiBMRURfQkxJTktfUEVSSU9EX01BWCkKKwkJcGVyaW9kID0gTEVE
X0JMSU5LX1BFUklPRF9NQVg7CisJcGVyaW9kID0gTEVEX1RPX1BFUklPRChwZXJpb2QpOworCXBl
cmlvZCA9IExFRF9CTElOS19QRVJJT0QocGVyaW9kKTsKKworCW11dGV4X2xvY2soJmRhdGEtPmxv
Y2spOworCWRhdGEtPmJsaW5rX29uID0gb247CisJZGF0YS0+Ymxpbmtfb2ZmID0gcGVyaW9kIC0g
ZGF0YS0+Ymxpbmtfb247CisJc3VtID0gKHBlcmlvZCA8PCAzKSB8IGRhdGEtPmJsaW5rX29uOwor
CisJcmV0ID0gcG04NjB4X3NldF9iaXRzKGNoaXAtPnBhcmVudCwgREVTQ184NjA2LCBvZmZzZXQs
CisJCQkgICAgICBMRURfQkxJTktfTUFTSywgc3VtKTsKKwlpZiAocmV0IDwgMCkKKwkJZ290byBv
dXQ7CisKKwlvZmZzZXQgPSBfX2JsaW5rX2N0bF9tYXNrKGRhdGEtPnBvcnQpOworCXJldCA9IHBt
ODYweF9zZXRfYml0cyhjaGlwLT5wYXJlbnQsIERFU0NfODYwNiwgUE04NjA2X1dMRUQzQiwKKwkJ
CSAgICAgIG9mZnNldCwgb2Zmc2V0KTsKKwlpZiAocmV0IDwgMCkKKwkJZ290byBvdXQ7CisJbXV0
ZXhfdW5sb2NrKCZkYXRhLT5sb2NrKTsKKworCWRldl9kYmcoY2hpcC0+ZGV2LCAiTEVEIGJsaW5r
IGRlbGF5IG9uOiVkbXMsIGRlbGF5IG9mZjolZG1zXG4iLAorCQlkYXRhLT5ibGlua19vbiwgZGF0
YS0+Ymxpbmtfb2ZmKTsKKwlyZXR1cm4gMDsKK291dDoKKwltdXRleF91bmxvY2soJmRhdGEtPmxv
Y2spOworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQgX19jaGVja19kZXZpY2Uoc3RydWN0
IHBtODYweF9sZWRfcGRhdGEgKnBkYXRhLCBjaGFyICpuYW1lKQoreworCXN0cnVjdCBwbTg2MHhf
bGVkX3BkYXRhICpwID0gcGRhdGE7CisJaW50IHJldCA9IC1FSU5WQUw7CisKKwl3aGlsZSAocCAm
JiBwLT5pZCkgeworCQlpZiAoKHAtPmlkICE9IFBNODYwNl9JRF9MRUQpIHx8IChwLT5mbGFncyA8
IDApKQorCQkJYnJlYWs7CisKKwkJaWYgKCFzdHJuY21wKG5hbWUsIHBtODYweF9sZWRfbmFtZVtw
LT5mbGFnc10sCisJCQlNRkRfTkFNRV9TSVpFKSkgeworCQkJcmV0ID0gKGludClwLT5mbGFnczsK
KwkJCWJyZWFrOworCQl9CisJCXArKzsKKwl9CisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGlu
dCBwbTg2MHhfbGVkX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJc3Ry
dWN0IHBtODYweF9jaGlwICpjaGlwID0gZGV2X2dldF9kcnZkYXRhKHBkZXYtPmRldi5wYXJlbnQp
OworCXN0cnVjdCBwbTg2MHhfcGxhdF9kYXRhICpwbTg2MHhfcGRhdGE7CisJc3RydWN0IHBtODYw
eF9sZWRfcGRhdGEgKnBkYXRhOworCXN0cnVjdCBwbTg2MHhfbGVkICpkYXRhOworCXN0cnVjdCBy
ZXNvdXJjZSAqcmVzOworCWludCByZXQ7CisKKwlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2Uo
cGRldiwgSU9SRVNPVVJDRV9JTywgMCk7CisJaWYgKHJlcyA9PSBOVUxMKSB7CisJCWRldl9lcnIo
JnBkZXYtPmRldiwgIk5vIEkvTyByZXNvdXJjZSFcbiIpOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9
CisKKwlpZiAocGRldi0+ZGV2LnBhcmVudC0+cGxhdGZvcm1fZGF0YSkgeworCQlwbTg2MHhfcGRh
dGEgPSBwZGV2LT5kZXYucGFyZW50LT5wbGF0Zm9ybV9kYXRhOworCQlwZGF0YSA9IHBtODYweF9w
ZGF0YS0+bGVkOworCX0gZWxzZQorCQlwZGF0YSA9IE5VTEw7CisKKwlkYXRhID0ga3phbGxvYyhz
aXplb2Yoc3RydWN0IHBtODYweF9sZWQpLCBHRlBfS0VSTkVMKTsKKwlpZiAoZGF0YSA9PSBOVUxM
KQorCQlyZXR1cm4gLUVOT01FTTsKKwlzdHJuY3B5KGRhdGEtPm5hbWUsIHJlcy0+bmFtZSwgTUZE
X05BTUVfU0laRSk7CisJZGV2X3NldF9kcnZkYXRhKCZwZGV2LT5kZXYsIGRhdGEpOworCWRhdGEt
PmNoaXAgPSBjaGlwOworCWRhdGEtPmlzZXQgPSBwZGF0YS0+aXNldDsKKwlkYXRhLT5wb3J0ID0g
X19jaGVja19kZXZpY2UocGRhdGEsIGRhdGEtPm5hbWUpOworCWlmIChkYXRhLT5wb3J0IDwgMCkK
KwkJcmV0dXJuIC1FSU5WQUw7CisKKwlkYXRhLT5jdXJyZW50X2JyaWdodG5lc3MgPSAwOworCWRh
dGEtPmNkZXYubmFtZSA9IGRhdGEtPm5hbWU7CisJZGF0YS0+Y2Rldi5icmlnaHRuZXNzX3NldCA9
IHBtODYweF9sZWRfc2V0OworCWRhdGEtPmNkZXYuYnJpZ2h0bmVzc19nZXQgPSBwbTg2MHhfbGVk
X2dldDsKKwlkYXRhLT5jZGV2LmJsaW5rX3NldCA9IHBtODYweF9sZWRfYmxpbms7CisJbXV0ZXhf
aW5pdCgmZGF0YS0+bG9jayk7CisKKwlyZXQgPSBsZWRfY2xhc3NkZXZfcmVnaXN0ZXIoY2hpcC0+
ZGV2LCAmZGF0YS0+Y2Rldik7CisJaWYgKHJldCA8IDApIHsKKwkJZGV2X2VycigmcGRldi0+ZGV2
LCAiRmFpbGVkIHRvIHJlZ2lzdGVyIExFRDogJWRcbiIsIHJldCk7CisJCWdvdG8gb3V0OworCX0K
KwlyZXR1cm4gMDsKK291dDoKKwlrZnJlZShkYXRhKTsKKwlyZXR1cm4gcmV0OworfQorCitzdGF0
aWMgaW50IHBtODYweF9sZWRfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7
CisJc3RydWN0IHBtODYweF9sZWQgKmRhdGEgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsK
KworCWxlZF9jbGFzc2Rldl91bnJlZ2lzdGVyKCZkYXRhLT5jZGV2KTsKKwlrZnJlZShkYXRhKTsK
KworCXJldHVybiAwOworfQorCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBwbTg2MHhf
bGVkX2RyaXZlciA9IHsKKwkuZHJpdmVyCT0geworCQkubmFtZQk9ICI4OHBtODYweC1sZWQiLAor
CQkub3duZXIJPSBUSElTX01PRFVMRSwKKwl9LAorCS5wcm9iZQk9IHBtODYweF9sZWRfcHJvYmUs
CisJLnJlbW92ZQk9IHBtODYweF9sZWRfcmVtb3ZlLAorfTsKKworc3RhdGljIGludCBfX2Rldmlu
aXQgcG04NjB4X2xlZF9pbml0KHZvaWQpCit7CisJcmV0dXJuIHBsYXRmb3JtX2RyaXZlcl9yZWdp
c3RlcigmcG04NjB4X2xlZF9kcml2ZXIpOworfQorbW9kdWxlX2luaXQocG04NjB4X2xlZF9pbml0
KTsKKworc3RhdGljIHZvaWQgX19kZXZleGl0IHBtODYweF9sZWRfZXhpdCh2b2lkKQoreworCXBs
YXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVyKCZwbTg2MHhfbGVkX2RyaXZlcik7Cit9Cittb2R1bGVf
ZXhpdChwbTg2MHhfbGVkX2V4aXQpOworCitNT0RVTEVfREVTQ1JJUFRJT04oIkxFRCBkcml2ZXIg
Zm9yIE1hcnZlbGwgUE04NjB4Iik7CitNT0RVTEVfQVVUSE9SKCJIYW9qaWFuIFpodWFuZyA8aGFv
amlhbi56aHVhbmdAbWFydmVsbC5jb20+Iik7CitNT0RVTEVfTElDRU5TRSgiR1BMIik7CitNT0RV
TEVfQUxJQVMoInBsYXRmb3JtOjg4cG04NjB4LWxlZCIpOwotLSAKMS41LjYuNQoK
--000325574fb2f14a2f04788b3e2a--
