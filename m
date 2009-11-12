From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 12 Nov 2009 12:15:51 -0500
Subject: [PATCH] input: enable touch on 88pm860x
Message-ID: <mailman.35.1258439271.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/input/touchscreen/88pm860x-ts.c |  239 +++++++++++++++++++++++++++=
++++
 drivers/input/touchscreen/Kconfig       |    7 +
 drivers/input/touchscreen/Makefile      |    1 +
 include/linux/mfd/88pm860x.h            |    1 +
 4 files changed, 248 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/88pm860x-ts.c

diff --git a/drivers/input/touchscreen/88pm860x-ts.c
b/drivers/input/touchscreen/88pm860x-ts.c
new file mode 100644
index 0000000..8a6a27a
--- /dev/null
+++ b/drivers/input/touchscreen/88pm860x-ts.c
@@ -0,0 +1,239 @@
+/*
+ * Touchscreen driver for Marvell 88PM860x
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ * 	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+#include <linux/mfd/88pm860x.h>
+
+#define MEAS_LEN		(8)
+#define ACCURATE_BIT		(12)
+
+/* touch register */
+#define MEAS_EN3		(0x52)
+
+#define MEAS_TSIX_1		(0x8D)
+#define MEAS_TSIX_2		(0x8E)
+#define MEAS_TSIY_1		(0x8F)
+#define MEAS_TSIY_2		(0x90)
+#define MEAS_TSIZ1_1		(0x91)
+#define MEAS_TSIZ1_2		(0x92)
+#define MEAS_TSIZ2_1		(0x93)
+#define MEAS_TSIZ2_2		(0x94)
+
+/* bit definitions of touch */
+#define MEAS_PD_EN		(1 << 3)
+#define MEAS_TSIX_EN		(1 << 4)
+#define MEAS_TSIY_EN		(1 << 5)
+#define MEAS_TSIZ1_EN		(1 << 6)
+#define MEAS_TSIZ2_EN		(1 << 7)
+
+struct pm860x_touch {
+	struct input_dev *idev;
+	struct pm860x_chip *chip;
+	int irq;
+	int res_x;		/* resistor of Xplate */
+};
+
+static irqreturn_t pm860x_touch_handler(int irq, void *data)
+{
+	struct pm860x_touch *touch =3D data;
+	struct pm860x_chip *chip =3D touch->chip;
+	unsigned char buf[MEAS_LEN];
+	int x, y, pen_down;
+	int z1, z2, rt =3D 0;
+	int ret;
+
+	pm860x_mask_irq(chip, irq);
+	ret =3D pm860x_bulk_read(chip->parent, DESC_8607, MEAS_TSIX_1,
+				MEAS_LEN, buf);
+	if (ret < 0)
+		goto out;
+
+	pen_down =3D buf[1] & (1 << 6);
+	x =3D ((buf[0] & 0xFF) << 4) | (buf[1] & 0x0F);
+	y =3D ((buf[2] & 0xFF) << 4) | (buf[3] & 0x0F);
+	z1 =3D ((buf[4] & 0xFF) << 4) | (buf[5] & 0x0F);
+	z2 =3D ((buf[6] & 0xFF) << 4) | (buf[7] & 0x0F);
+
+	if (pen_down) {
+		if ((x !=3D 0) && (z1 !=3D 0) && (touch->res_x !=3D 0)) {
+			rt =3D z2 / z1 - 1;
+			rt =3D (rt * touch->res_x * x) >> ACCURATE_BIT;
+			dev_dbg(chip->dev, "z1:%d, z2:%d, rt:%d\n",
+				z1, z2, rt);
+		}
+		input_report_abs(touch->idev, ABS_X, x);
+		input_report_abs(touch->idev, ABS_Y, y);
+		input_report_abs(touch->idev, ABS_PRESSURE, rt);
+		input_report_key(touch->idev, BTN_TOUCH, 1);
+	} else {
+		input_report_abs(touch->idev, ABS_PRESSURE, 0);
+		input_report_key(touch->idev, BTN_TOUCH, 0);
+	}
+	input_sync(touch->idev);
+	pm860x_unmask_irq(chip, irq);
+
+	if (pen_down)
+		dev_dbg(chip->dev, "pen down at [%d, %d].\n", x, y);
+	else
+		dev_dbg(chip->dev, "pen release\n");
+out:
+	return IRQ_HANDLED;
+}
+
+static int pm860x_touch_open(struct input_dev *dev)
+{
+	struct pm860x_touch *touch =3D input_get_drvdata(dev);
+	struct pm860x_chip *chip =3D touch->chip;
+	int data, ret;
+
+	data =3D MEAS_PD_EN | MEAS_TSIX_EN | MEAS_TSIY_EN
+		| MEAS_TSIZ1_EN | MEAS_TSIZ2_EN;
+	ret =3D pm860x_set_bits(chip->parent, DESC_8607, MEAS_EN3,
+				data, data);
+	if (ret < 0)
+		goto out;
+	pm860x_unmask_irq(chip, touch->irq);
+	return 0;
+out:
+	return ret;
+}
+
+static void pm860x_touch_close(struct input_dev *dev)
+{
+	struct pm860x_touch *touch =3D input_get_drvdata(dev);
+	struct pm860x_chip *chip =3D touch->chip;
+	int data;
+
+	data =3D MEAS_PD_EN | MEAS_TSIX_EN | MEAS_TSIY_EN
+		| MEAS_TSIZ1_EN | MEAS_TSIZ2_EN;
+	pm860x_set_bits(chip->parent, DESC_8607, MEAS_EN3,
+			data, 0);
+	pm860x_mask_irq(chip, touch->irq);
+}
+
+static int __devinit pm860x_touch_probe(struct platform_device *pdev)
+{
+	struct pm860x_chip *chip =3D dev_get_drvdata(pdev->dev.parent);
+	struct pm860x_plat_data *pm860x_pdata;
+	struct pm860x_touch_pdata *pdata;
+	struct pm860x_touch *touch;
+	int irq, ret;
+
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "No IRQ resource!\n");
+		return -EINVAL;
+	}
+
+	if (pdev->dev.parent->platform_data) {
+		pm860x_pdata =3D pdev->dev.parent->platform_data;
+		pdata =3D pm860x_pdata->touch;
+	} else
+		pdata =3D NULL;
+
+	if (pdata =3D=3D NULL) {
+		dev_err(&pdev->dev, "platform data isn't assigned to "
+			"touch\n");
+		return -EINVAL;
+	}
+
+	touch =3D kzalloc(sizeof(struct pm860x_touch), GFP_KERNEL);
+	if (touch =3D=3D NULL)
+		return -ENOMEM;
+	dev_set_drvdata(&pdev->dev, touch);
+
+	touch->idev =3D input_allocate_device();
+	if (touch->idev =3D=3D NULL) {
+		dev_err(&pdev->dev, "Failed to allocate input device!\n");
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	touch->idev->name =3D "88pm860x-touch";
+	touch->idev->phys =3D "88pm860x/input0";
+	touch->idev->id.bustype =3D BUS_I2C;
+	touch->idev->dev.parent =3D &pdev->dev;
+	touch->idev->open =3D pm860x_touch_open;
+	touch->idev->close =3D pm860x_touch_close;
+	touch->chip =3D chip;
+	touch->irq =3D irq;
+	touch->res_x =3D pdata->res_x;
+	input_set_drvdata(touch->idev, touch);
+
+	ret =3D pm860x_request_irq(chip, irq, pm860x_touch_handler, touch);
+	if (ret < 0)
+		goto out_irq;
+
+	__set_bit(EV_ABS, touch->idev->evbit);
+	__set_bit(ABS_X, touch->idev->absbit);
+	__set_bit(ABS_Y, touch->idev->absbit);
+	__set_bit(ABS_PRESSURE, touch->idev->absbit);
+	__set_bit(EV_SYN, touch->idev->evbit);
+	__set_bit(EV_KEY, touch->idev->evbit);
+	__set_bit(BTN_TOUCH, touch->idev->keybit);
+
+	input_set_abs_params(touch->idev, ABS_X, 0, 1 << ACCURATE_BIT, 0, 0);
+	input_set_abs_params(touch->idev, ABS_Y, 0, 1 << ACCURATE_BIT, 0, 0);
+	input_set_abs_params(touch->idev, ABS_PRESSURE, 0, 1 << ACCURATE_BIT,
+				0, 0);
+
+	ret =3D input_register_device(touch->idev);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to register touch!\n");
+		goto out_rg;
+	}
+
+	platform_set_drvdata(pdev, touch);
+	return 0;
+out_rg:
+	pm860x_free_irq(chip, irq);
+out_irq:
+	input_free_device(touch->idev);
+out:
+	kfree(touch);
+	return ret;
+}
+
+static int __devexit pm860x_touch_remove(struct platform_device *pdev)
+{
+	struct pm860x_touch *touch =3D platform_get_drvdata(pdev);
+
+	input_unregister_device(touch->idev);
+	return 0;
+}
+
+static struct platform_driver pm860x_touch_driver =3D {
+	.driver	=3D {
+		.name	=3D "88pm860x-touch",
+		.owner	=3D THIS_MODULE,
+	},
+	.probe	=3D pm860x_touch_probe,
+	.remove	=3D __devexit_p(pm860x_touch_remove),
+};
+
+static int __init pm860x_touch_init(void)
+{
+	return platform_driver_register(&pm860x_touch_driver);
+}
+module_init(pm860x_touch_init);
+
+static void __exit pm860x_touch_exit(void)
+{
+	platform_driver_unregister(&pm860x_touch_driver);
+}
+module_exit(pm860x_touch_exit);
+
+MODULE_DESCRIPTION("Touchscreen driver for Marvell Semiconductor 88PM860x"=
);
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:88pm860x-touch");
diff --git a/drivers/input/touchscreen/Kconfig
b/drivers/input/touchscreen/Kconfig
index 8cc453c..0b06a53 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -530,4 +530,11 @@ config TOUCHSCREEN_PCAP

 	  To compile this driver as a module, choose M here: the
 	  module will be called pcap_ts.
+
+config TOUCHSCREEN_88PM860X
+	bool "Marvell 88PM860x touchscreen"
+	depends on MFD_88PM860X
+	help
+	  Say Y here if you have a 88PM860x PMIC and want to enable
+	  support for the built-in touchscreen.
 endif
diff --git a/drivers/input/touchscreen/Makefile
b/drivers/input/touchscreen/Makefile
index 15fa62c..b278a1f 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -6,6 +6,7 @@

 wm97xx-ts-y :=3D wm97xx-core.o

+obj-$(CONFIG_TOUCHSCREEN_88PM860X)	+=3D 88pm860x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_AD7877)	+=3D ad7877.o
 obj-$(CONFIG_TOUCHSCREEN_AD7879)	+=3D ad7879.o
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+=3D ads7846.o
diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index b7f9aac..fc31bad 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -347,6 +347,7 @@ struct pm860x_touch_pdata {
 	int		tsi_prebias;	/* time, slot */
 	int		pen_prebias;	/* time, slot */
 	int		pen_prechg;	/* time, slot */
+	int		res_x;		/* resistor of Xplate */
 	unsigned long	flags;
 };

--=20
1.5.6.5

--00151773da303ba12204788b39cc
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0009-input-enable-touch-on-88pm860x.patch"
Content-Disposition: attachment; 
	filename="0009-input-enable-touch-on-88pm860x.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g24qtw8p0

RnJvbSA4ZTY2NjMwYjBkNmExNmZjOWFmN2MzODQ3MmVkYTE2NjIyNTg4NGUzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IFRodSwgMTIgTm92IDIwMDkgMTI6MTU6NTEgLTA1MDAKU3ViamVjdDogW1BB
VENIXSBpbnB1dDogZW5hYmxlIHRvdWNoIG9uIDg4cG04NjB4CgpTaWduZWQtb2ZmLWJ5OiBIYW9q
aWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVsbC5jb20+Ci0tLQogZHJpdmVycy9pbnB1
dC90b3VjaHNjcmVlbi84OHBtODYweC10cy5jIHwgIDIzOSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCiBkcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL0tjb25maWcgICAgICAgfCAgICA3
ICsKIGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vTWFrZWZpbGUgICAgICB8ICAgIDEgKwogaW5j
bHVkZS9saW51eC9tZmQvODhwbTg2MHguaCAgICAgICAgICAgIHwgICAgMSArCiA0IGZpbGVzIGNo
YW5nZWQsIDI0OCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vODhwbTg2MHgtdHMuYwoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vODhwbTg2MHgtdHMuYyBiL2RyaXZlcnMvaW5wdXQv
dG91Y2hzY3JlZW4vODhwbTg2MHgtdHMuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAw
MDAwLi44YTZhMjdhCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVl
bi84OHBtODYweC10cy5jCkBAIC0wLDAgKzEsMjM5IEBACisvKgorICogVG91Y2hzY3JlZW4gZHJp
dmVyIGZvciBNYXJ2ZWxsIDg4UE04NjB4CisgKgorICogQ29weXJpZ2h0IChDKSAyMDA5IE1hcnZl
bGwgSW50ZXJuYXRpb25hbCBMdGQuCisgKiAJSGFvamlhbiBaaHVhbmcgPGhhb2ppYW4uemh1YW5n
QG1hcnZlbGwuY29tPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3Ug
Y2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRlciB0aGUgdGVybXMg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcworICogcHVibGlz
aGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisgKi8KKyNpbmNsdWRlIDxsaW51
eC9rZXJuZWwuaD4KKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9w
bGF0Zm9ybV9kZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9pbnB1dC5oPgorI2luY2x1ZGUgPGxp
bnV4L21mZC84OHBtODYweC5oPgorCisjZGVmaW5lIE1FQVNfTEVOCQkoOCkKKyNkZWZpbmUgQUND
VVJBVEVfQklUCQkoMTIpCisKKy8qIHRvdWNoIHJlZ2lzdGVyICovCisjZGVmaW5lIE1FQVNfRU4z
CQkoMHg1MikKKworI2RlZmluZSBNRUFTX1RTSVhfMQkJKDB4OEQpCisjZGVmaW5lIE1FQVNfVFNJ
WF8yCQkoMHg4RSkKKyNkZWZpbmUgTUVBU19UU0lZXzEJCSgweDhGKQorI2RlZmluZSBNRUFTX1RT
SVlfMgkJKDB4OTApCisjZGVmaW5lIE1FQVNfVFNJWjFfMQkJKDB4OTEpCisjZGVmaW5lIE1FQVNf
VFNJWjFfMgkJKDB4OTIpCisjZGVmaW5lIE1FQVNfVFNJWjJfMQkJKDB4OTMpCisjZGVmaW5lIE1F
QVNfVFNJWjJfMgkJKDB4OTQpCisKKy8qIGJpdCBkZWZpbml0aW9ucyBvZiB0b3VjaCAqLworI2Rl
ZmluZSBNRUFTX1BEX0VOCQkoMSA8PCAzKQorI2RlZmluZSBNRUFTX1RTSVhfRU4JCSgxIDw8IDQp
CisjZGVmaW5lIE1FQVNfVFNJWV9FTgkJKDEgPDwgNSkKKyNkZWZpbmUgTUVBU19UU0laMV9FTgkJ
KDEgPDwgNikKKyNkZWZpbmUgTUVBU19UU0laMl9FTgkJKDEgPDwgNykKKworc3RydWN0IHBtODYw
eF90b3VjaCB7CisJc3RydWN0IGlucHV0X2RldiAqaWRldjsKKwlzdHJ1Y3QgcG04NjB4X2NoaXAg
KmNoaXA7CisJaW50IGlycTsKKwlpbnQgcmVzX3g7CQkvKiByZXNpc3RvciBvZiBYcGxhdGUgKi8K
K307CisKK3N0YXRpYyBpcnFyZXR1cm5fdCBwbTg2MHhfdG91Y2hfaGFuZGxlcihpbnQgaXJxLCB2
b2lkICpkYXRhKQoreworCXN0cnVjdCBwbTg2MHhfdG91Y2ggKnRvdWNoID0gZGF0YTsKKwlzdHJ1
Y3QgcG04NjB4X2NoaXAgKmNoaXAgPSB0b3VjaC0+Y2hpcDsKKwl1bnNpZ25lZCBjaGFyIGJ1ZltN
RUFTX0xFTl07CisJaW50IHgsIHksIHBlbl9kb3duOworCWludCB6MSwgejIsIHJ0ID0gMDsKKwlp
bnQgcmV0OworCisJcG04NjB4X21hc2tfaXJxKGNoaXAsIGlycSk7CisJcmV0ID0gcG04NjB4X2J1
bGtfcmVhZChjaGlwLT5wYXJlbnQsIERFU0NfODYwNywgTUVBU19UU0lYXzEsCisJCQkJTUVBU19M
RU4sIGJ1Zik7CisJaWYgKHJldCA8IDApCisJCWdvdG8gb3V0OworCisJcGVuX2Rvd24gPSBidWZb
MV0gJiAoMSA8PCA2KTsKKwl4ID0gKChidWZbMF0gJiAweEZGKSA8PCA0KSB8IChidWZbMV0gJiAw
eDBGKTsKKwl5ID0gKChidWZbMl0gJiAweEZGKSA8PCA0KSB8IChidWZbM10gJiAweDBGKTsKKwl6
MSA9ICgoYnVmWzRdICYgMHhGRikgPDwgNCkgfCAoYnVmWzVdICYgMHgwRik7CisJejIgPSAoKGJ1
Zls2XSAmIDB4RkYpIDw8IDQpIHwgKGJ1Zls3XSAmIDB4MEYpOworCisJaWYgKHBlbl9kb3duKSB7
CisJCWlmICgoeCAhPSAwKSAmJiAoejEgIT0gMCkgJiYgKHRvdWNoLT5yZXNfeCAhPSAwKSkgewor
CQkJcnQgPSB6MiAvIHoxIC0gMTsKKwkJCXJ0ID0gKHJ0ICogdG91Y2gtPnJlc194ICogeCkgPj4g
QUNDVVJBVEVfQklUOworCQkJZGV2X2RiZyhjaGlwLT5kZXYsICJ6MTolZCwgejI6JWQsIHJ0OiVk
XG4iLAorCQkJCXoxLCB6MiwgcnQpOworCQl9CisJCWlucHV0X3JlcG9ydF9hYnModG91Y2gtPmlk
ZXYsIEFCU19YLCB4KTsKKwkJaW5wdXRfcmVwb3J0X2Ficyh0b3VjaC0+aWRldiwgQUJTX1ksIHkp
OworCQlpbnB1dF9yZXBvcnRfYWJzKHRvdWNoLT5pZGV2LCBBQlNfUFJFU1NVUkUsIHJ0KTsKKwkJ
aW5wdXRfcmVwb3J0X2tleSh0b3VjaC0+aWRldiwgQlROX1RPVUNILCAxKTsKKwl9IGVsc2Ugewor
CQlpbnB1dF9yZXBvcnRfYWJzKHRvdWNoLT5pZGV2LCBBQlNfUFJFU1NVUkUsIDApOworCQlpbnB1
dF9yZXBvcnRfa2V5KHRvdWNoLT5pZGV2LCBCVE5fVE9VQ0gsIDApOworCX0KKwlpbnB1dF9zeW5j
KHRvdWNoLT5pZGV2KTsKKwlwbTg2MHhfdW5tYXNrX2lycShjaGlwLCBpcnEpOworCisJaWYgKHBl
bl9kb3duKQorCQlkZXZfZGJnKGNoaXAtPmRldiwgInBlbiBkb3duIGF0IFslZCwgJWRdLlxuIiwg
eCwgeSk7CisJZWxzZQorCQlkZXZfZGJnKGNoaXAtPmRldiwgInBlbiByZWxlYXNlXG4iKTsKK291
dDoKKwlyZXR1cm4gSVJRX0hBTkRMRUQ7Cit9CisKK3N0YXRpYyBpbnQgcG04NjB4X3RvdWNoX29w
ZW4oc3RydWN0IGlucHV0X2RldiAqZGV2KQoreworCXN0cnVjdCBwbTg2MHhfdG91Y2ggKnRvdWNo
ID0gaW5wdXRfZ2V0X2RydmRhdGEoZGV2KTsKKwlzdHJ1Y3QgcG04NjB4X2NoaXAgKmNoaXAgPSB0
b3VjaC0+Y2hpcDsKKwlpbnQgZGF0YSwgcmV0OworCisJZGF0YSA9IE1FQVNfUERfRU4gfCBNRUFT
X1RTSVhfRU4gfCBNRUFTX1RTSVlfRU4KKwkJfCBNRUFTX1RTSVoxX0VOIHwgTUVBU19UU0laMl9F
TjsKKwlyZXQgPSBwbTg2MHhfc2V0X2JpdHMoY2hpcC0+cGFyZW50LCBERVNDXzg2MDcsIE1FQVNf
RU4zLAorCQkJCWRhdGEsIGRhdGEpOworCWlmIChyZXQgPCAwKQorCQlnb3RvIG91dDsKKwlwbTg2
MHhfdW5tYXNrX2lycShjaGlwLCB0b3VjaC0+aXJxKTsKKwlyZXR1cm4gMDsKK291dDoKKwlyZXR1
cm4gcmV0OworfQorCitzdGF0aWMgdm9pZCBwbTg2MHhfdG91Y2hfY2xvc2Uoc3RydWN0IGlucHV0
X2RldiAqZGV2KQoreworCXN0cnVjdCBwbTg2MHhfdG91Y2ggKnRvdWNoID0gaW5wdXRfZ2V0X2Ry
dmRhdGEoZGV2KTsKKwlzdHJ1Y3QgcG04NjB4X2NoaXAgKmNoaXAgPSB0b3VjaC0+Y2hpcDsKKwlp
bnQgZGF0YTsKKworCWRhdGEgPSBNRUFTX1BEX0VOIHwgTUVBU19UU0lYX0VOIHwgTUVBU19UU0lZ
X0VOCisJCXwgTUVBU19UU0laMV9FTiB8IE1FQVNfVFNJWjJfRU47CisJcG04NjB4X3NldF9iaXRz
KGNoaXAtPnBhcmVudCwgREVTQ184NjA3LCBNRUFTX0VOMywKKwkJCWRhdGEsIDApOworCXBtODYw
eF9tYXNrX2lycShjaGlwLCB0b3VjaC0+aXJxKTsKK30KKworc3RhdGljIGludCBfX2RldmluaXQg
cG04NjB4X3RvdWNoX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJc3Ry
dWN0IHBtODYweF9jaGlwICpjaGlwID0gZGV2X2dldF9kcnZkYXRhKHBkZXYtPmRldi5wYXJlbnQp
OworCXN0cnVjdCBwbTg2MHhfcGxhdF9kYXRhICpwbTg2MHhfcGRhdGE7CisJc3RydWN0IHBtODYw
eF90b3VjaF9wZGF0YSAqcGRhdGE7CisJc3RydWN0IHBtODYweF90b3VjaCAqdG91Y2g7CisJaW50
IGlycSwgcmV0OworCisJaXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsKKwlpZiAoaXJx
IDwgMCkgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJObyBJUlEgcmVzb3VyY2UhXG4iKTsKKwkJ
cmV0dXJuIC1FSU5WQUw7CisJfQorCisJaWYgKHBkZXYtPmRldi5wYXJlbnQtPnBsYXRmb3JtX2Rh
dGEpIHsKKwkJcG04NjB4X3BkYXRhID0gcGRldi0+ZGV2LnBhcmVudC0+cGxhdGZvcm1fZGF0YTsK
KwkJcGRhdGEgPSBwbTg2MHhfcGRhdGEtPnRvdWNoOworCX0gZWxzZQorCQlwZGF0YSA9IE5VTEw7
CisKKwlpZiAocGRhdGEgPT0gTlVMTCkgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJwbGF0Zm9y
bSBkYXRhIGlzbid0IGFzc2lnbmVkIHRvICIKKwkJCSJ0b3VjaFxuIik7CisJCXJldHVybiAtRUlO
VkFMOworCX0KKworCXRvdWNoID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IHBtODYweF90b3VjaCks
IEdGUF9LRVJORUwpOworCWlmICh0b3VjaCA9PSBOVUxMKQorCQlyZXR1cm4gLUVOT01FTTsKKwlk
ZXZfc2V0X2RydmRhdGEoJnBkZXYtPmRldiwgdG91Y2gpOworCisJdG91Y2gtPmlkZXYgPSBpbnB1
dF9hbGxvY2F0ZV9kZXZpY2UoKTsKKwlpZiAodG91Y2gtPmlkZXYgPT0gTlVMTCkgeworCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gYWxsb2NhdGUgaW5wdXQgZGV2aWNlIVxuIik7CisJ
CXJldCA9IC1FTk9NRU07CisJCWdvdG8gb3V0OworCX0KKworCXRvdWNoLT5pZGV2LT5uYW1lID0g
Ijg4cG04NjB4LXRvdWNoIjsKKwl0b3VjaC0+aWRldi0+cGh5cyA9ICI4OHBtODYweC9pbnB1dDAi
OworCXRvdWNoLT5pZGV2LT5pZC5idXN0eXBlID0gQlVTX0kyQzsKKwl0b3VjaC0+aWRldi0+ZGV2
LnBhcmVudCA9ICZwZGV2LT5kZXY7CisJdG91Y2gtPmlkZXYtPm9wZW4gPSBwbTg2MHhfdG91Y2hf
b3BlbjsKKwl0b3VjaC0+aWRldi0+Y2xvc2UgPSBwbTg2MHhfdG91Y2hfY2xvc2U7CisJdG91Y2gt
PmNoaXAgPSBjaGlwOworCXRvdWNoLT5pcnEgPSBpcnE7CisJdG91Y2gtPnJlc194ID0gcGRhdGEt
PnJlc194OworCWlucHV0X3NldF9kcnZkYXRhKHRvdWNoLT5pZGV2LCB0b3VjaCk7CisKKwlyZXQg
PSBwbTg2MHhfcmVxdWVzdF9pcnEoY2hpcCwgaXJxLCBwbTg2MHhfdG91Y2hfaGFuZGxlciwgdG91
Y2gpOworCWlmIChyZXQgPCAwKQorCQlnb3RvIG91dF9pcnE7CisKKwlfX3NldF9iaXQoRVZfQUJT
LCB0b3VjaC0+aWRldi0+ZXZiaXQpOworCV9fc2V0X2JpdChBQlNfWCwgdG91Y2gtPmlkZXYtPmFi
c2JpdCk7CisJX19zZXRfYml0KEFCU19ZLCB0b3VjaC0+aWRldi0+YWJzYml0KTsKKwlfX3NldF9i
aXQoQUJTX1BSRVNTVVJFLCB0b3VjaC0+aWRldi0+YWJzYml0KTsKKwlfX3NldF9iaXQoRVZfU1lO
LCB0b3VjaC0+aWRldi0+ZXZiaXQpOworCV9fc2V0X2JpdChFVl9LRVksIHRvdWNoLT5pZGV2LT5l
dmJpdCk7CisJX19zZXRfYml0KEJUTl9UT1VDSCwgdG91Y2gtPmlkZXYtPmtleWJpdCk7CisKKwlp
bnB1dF9zZXRfYWJzX3BhcmFtcyh0b3VjaC0+aWRldiwgQUJTX1gsIDAsIDEgPDwgQUNDVVJBVEVf
QklULCAwLCAwKTsKKwlpbnB1dF9zZXRfYWJzX3BhcmFtcyh0b3VjaC0+aWRldiwgQUJTX1ksIDAs
IDEgPDwgQUNDVVJBVEVfQklULCAwLCAwKTsKKwlpbnB1dF9zZXRfYWJzX3BhcmFtcyh0b3VjaC0+
aWRldiwgQUJTX1BSRVNTVVJFLCAwLCAxIDw8IEFDQ1VSQVRFX0JJVCwKKwkJCQkwLCAwKTsKKwor
CXJldCA9IGlucHV0X3JlZ2lzdGVyX2RldmljZSh0b3VjaC0+aWRldik7CisJaWYgKHJldCA8IDAp
IHsKKwkJZGV2X2VycihjaGlwLT5kZXYsICJGYWlsZWQgdG8gcmVnaXN0ZXIgdG91Y2ghXG4iKTsK
KwkJZ290byBvdXRfcmc7CisJfQorCisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgdG91Y2gp
OworCXJldHVybiAwOworb3V0X3JnOgorCXBtODYweF9mcmVlX2lycShjaGlwLCBpcnEpOworb3V0
X2lycToKKwlpbnB1dF9mcmVlX2RldmljZSh0b3VjaC0+aWRldik7CitvdXQ6CisJa2ZyZWUodG91
Y2gpOworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQgX19kZXZleGl0IHBtODYweF90b3Vj
aF9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKK3sKKwlzdHJ1Y3QgcG04NjB4
X3RvdWNoICp0b3VjaCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOworCisJaW5wdXRfdW5y
ZWdpc3Rlcl9kZXZpY2UodG91Y2gtPmlkZXYpOworCXJldHVybiAwOworfQorCitzdGF0aWMgc3Ry
dWN0IHBsYXRmb3JtX2RyaXZlciBwbTg2MHhfdG91Y2hfZHJpdmVyID0geworCS5kcml2ZXIJPSB7
CisJCS5uYW1lCT0gIjg4cG04NjB4LXRvdWNoIiwKKwkJLm93bmVyCT0gVEhJU19NT0RVTEUsCisJ
fSwKKwkucHJvYmUJPSBwbTg2MHhfdG91Y2hfcHJvYmUsCisJLnJlbW92ZQk9IF9fZGV2ZXhpdF9w
KHBtODYweF90b3VjaF9yZW1vdmUpLAorfTsKKworc3RhdGljIGludCBfX2luaXQgcG04NjB4X3Rv
dWNoX2luaXQodm9pZCkKK3sKKwlyZXR1cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZwbTg2
MHhfdG91Y2hfZHJpdmVyKTsKK30KK21vZHVsZV9pbml0KHBtODYweF90b3VjaF9pbml0KTsKKwor
c3RhdGljIHZvaWQgX19leGl0IHBtODYweF90b3VjaF9leGl0KHZvaWQpCit7CisJcGxhdGZvcm1f
ZHJpdmVyX3VucmVnaXN0ZXIoJnBtODYweF90b3VjaF9kcml2ZXIpOworfQorbW9kdWxlX2V4aXQo
cG04NjB4X3RvdWNoX2V4aXQpOworCitNT0RVTEVfREVTQ1JJUFRJT04oIlRvdWNoc2NyZWVuIGRy
aXZlciBmb3IgTWFydmVsbCBTZW1pY29uZHVjdG9yIDg4UE04NjB4Iik7CitNT0RVTEVfQVVUSE9S
KCJIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVsbC5jb20+Iik7CitNT0RVTEVf
TElDRU5TRSgiR1BMIik7CitNT0RVTEVfQUxJQVMoInBsYXRmb3JtOjg4cG04NjB4LXRvdWNoIik7
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL0tjb25maWcgYi9kcml2ZXJz
L2lucHV0L3RvdWNoc2NyZWVuL0tjb25maWcKaW5kZXggOGNjNDUzYy4uMGIwNmE1MyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9LY29uZmlnCisrKyBiL2RyaXZlcnMvaW5w
dXQvdG91Y2hzY3JlZW4vS2NvbmZpZwpAQCAtNTMwLDQgKzUzMCwxMSBAQCBjb25maWcgVE9VQ0hT
Q1JFRU5fUENBUAogCiAJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9v
c2UgTSBoZXJlOiB0aGUKIAkgIG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBwY2FwX3RzLgorCitjb25m
aWcgVE9VQ0hTQ1JFRU5fODhQTTg2MFgKKwlib29sICJNYXJ2ZWxsIDg4UE04NjB4IHRvdWNoc2Ny
ZWVuIgorCWRlcGVuZHMgb24gTUZEXzg4UE04NjBYCisJaGVscAorCSAgU2F5IFkgaGVyZSBpZiB5
b3UgaGF2ZSBhIDg4UE04NjB4IFBNSUMgYW5kIHdhbnQgdG8gZW5hYmxlCisJICBzdXBwb3J0IGZv
ciB0aGUgYnVpbHQtaW4gdG91Y2hzY3JlZW4uCiBlbmRpZgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
bnB1dC90b3VjaHNjcmVlbi9NYWtlZmlsZSBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vTWFr
ZWZpbGUKaW5kZXggMTVmYTYyYy4uYjI3OGExZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1dC90
b3VjaHNjcmVlbi9NYWtlZmlsZQorKysgYi9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL01ha2Vm
aWxlCkBAIC02LDYgKzYsNyBAQAogCiB3bTk3eHgtdHMteSA6PSB3bTk3eHgtY29yZS5vCiAKK29i
ai0kKENPTkZJR19UT1VDSFNDUkVFTl84OFBNODYwWCkJKz0gODhwbTg2MHgtdHMubwogb2JqLSQo
Q09ORklHX1RPVUNIU0NSRUVOX0FENzg3NykJKz0gYWQ3ODc3Lm8KIG9iai0kKENPTkZJR19UT1VD
SFNDUkVFTl9BRDc4NzkpCSs9IGFkNzg3OS5vCiBvYmotJChDT05GSUdfVE9VQ0hTQ1JFRU5fQURT
Nzg0NikJKz0gYWRzNzg0Ni5vCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21mZC84OHBtODYw
eC5oIGIvaW5jbHVkZS9saW51eC9tZmQvODhwbTg2MHguaAppbmRleCBiN2Y5YWFjLi5mYzMxYmFk
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L21mZC84OHBtODYweC5oCisrKyBiL2luY2x1ZGUv
bGludXgvbWZkLzg4cG04NjB4LmgKQEAgLTM0Nyw2ICszNDcsNyBAQCBzdHJ1Y3QgcG04NjB4X3Rv
dWNoX3BkYXRhIHsKIAlpbnQJCXRzaV9wcmViaWFzOwkvKiB0aW1lLCBzbG90ICovCiAJaW50CQlw
ZW5fcHJlYmlhczsJLyogdGltZSwgc2xvdCAqLwogCWludAkJcGVuX3ByZWNoZzsJLyogdGltZSwg
c2xvdCAqLworCWludAkJcmVzX3g7CQkvKiByZXNpc3RvciBvZiBYcGxhdGUgKi8KIAl1bnNpZ25l
ZCBsb25nCWZsYWdzOwogfTsKIAotLSAKMS41LjYuNQoK
--00151773da303ba12204788b39cc--
