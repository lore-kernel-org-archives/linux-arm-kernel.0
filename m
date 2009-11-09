From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 9 Nov 2009 12:41:07 -0500
Subject: [PATCH] backlight: enable backlight in 88pm860x
Message-ID: <mailman.37.1258439427.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At most, three backlight device can be supported in 88pm860x driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/video/backlight/88pm860x_bl.c |  311 +++++++++++++++++++++++++++++=
++++
 drivers/video/backlight/Kconfig       |    6 +
 drivers/video/backlight/Makefile      |    1 +
 3 files changed, 318 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/backlight/88pm860x_bl.c

diff --git a/drivers/video/backlight/88pm860x_bl.c
b/drivers/video/backlight/88pm860x_bl.c
new file mode 100644
index 0000000..d6a4e97
--- /dev/null
+++ b/drivers/video/backlight/88pm860x_bl.c
@@ -0,0 +1,311 @@
+/*
+ * Backlight driver for Marvell Semiconductor 88PM8606
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ *	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/fb.h>
+#include <linux/backlight.h>
+#include <linux/mfd/88pm860x.h>
+
+#define MAX_BRIGHTNESS		(0xFF)
+#define MIN_BRIGHTNESS		(0)
+
+#define CURRENT_MASK		(0x1F << 1)
+
+struct pm860x_backlight_data {
+	struct pm860x_chip *chip;
+	int	current_brightness;
+	int	port;
+	int	pwm;
+	int	iset;
+};
+
+static inline int wled_a(int port)
+{
+	int ret;
+
+	ret =3D ((port - PM8606_BACKLIGHT1) << 1) + 2;
+	return ret;
+}
+
+static inline int wled_b(int port)
+{
+	int ret;
+
+	ret =3D ((port - PM8606_BACKLIGHT1) << 1) + 3;
+	return ret;
+}
+
+/* WLED2 & WLED3 share the same IDC */
+static inline int wled_idc(int port)
+{
+	int ret;
+
+	switch (port) {
+	case PM8606_BACKLIGHT1:
+	case PM8606_BACKLIGHT2:
+		ret =3D ((port - PM8606_BACKLIGHT1) << 1) + 3;
+		break;
+	case PM8606_BACKLIGHT3:
+	default:
+		ret =3D ((port - PM8606_BACKLIGHT2) << 1) + 3;
+		break;
+	}
+	return ret;
+}
+
+static int pm860x_backlight_set(struct backlight_device *bl, int brightnes=
s)
+{
+	struct pm860x_backlight_data *data =3D bl_get_data(bl);
+	struct pm860x_chip *chip =3D data->chip;
+	unsigned char value;
+	int ret;
+
+	if (brightness > MAX_BRIGHTNESS)
+		value =3D MAX_BRIGHTNESS;
+	else
+		value =3D brightness;
+
+	ret =3D pm860x_reg_write(chip->parent, DESC_8606,
+			       wled_a(data->port), value);
+	if (ret < 0)
+		goto out;
+
+	if ((data->current_brightness =3D=3D 0) && brightness) {
+		if (data->iset) {
+			ret =3D pm860x_set_bits(chip->parent, DESC_8606,
+					      wled_idc(data->port),
+					      CURRENT_MASK, data->iset);
+			if (ret < 0)
+				goto out;
+		}
+		if (data->pwm) {
+			ret =3D pm860x_set_bits(chip->parent, DESC_8606,
+					      PM8606_PWM, PM8606_PWM_FREQ_MASK,
+					      data->pwm);
+			if (ret < 0)
+				goto out;
+		}
+		if (brightness =3D=3D MAX_BRIGHTNESS) {
+			/* set WLED_ON bit as 100% */
+			ret =3D pm860x_set_bits(chip->parent, DESC_8606,
+					      wled_b(data->port),
+					      PM8606_WLED_ON, PM8606_WLED_ON);
+		}
+	} else {
+		if (brightness =3D=3D MAX_BRIGHTNESS) {
+			/* set WLED_ON bit as 100% */
+			ret =3D pm860x_set_bits(chip->parent, DESC_8606,
+					      wled_b(data->port),
+					      PM8606_WLED_ON, PM8606_WLED_ON);
+		} else {
+			/* clear WLED_ON bit since it's not 100% */
+			ret =3D pm860x_set_bits(chip->parent, DESC_8606,
+					      wled_b(data->port),
+					      PM8606_WLED_ON, 0);
+		}
+	}
+	if (ret < 0)
+		goto out;
+
+	dev_dbg(chip->dev, "set brightness %d\n", value);
+	data->current_brightness =3D value;
+	return 0;
+out:
+	dev_dbg(chip->dev, "set brightness %d failure with return "
+		"value:%d\n", value, ret);
+	return ret;
+}
+
+static int pm860x_backlight_update_status(struct backlight_device *bl)
+{
+	int brightness =3D bl->props.brightness;
+
+	if (bl->props.power !=3D FB_BLANK_UNBLANK)
+		brightness =3D 0;
+
+	if (bl->props.fb_blank !=3D FB_BLANK_UNBLANK)
+		brightness =3D 0;
+
+	if (bl->props.state & BL_CORE_SUSPENDED)
+		brightness =3D 0;
+
+	return pm860x_backlight_set(bl, brightness);
+}
+
+static int pm860x_backlight_get_brightness(struct backlight_device *bl)
+{
+	struct pm860x_backlight_data *data =3D bl_get_data(bl);
+	struct pm860x_chip *chip =3D data->chip;
+	int ret;
+
+	ret =3D pm860x_reg_read(chip->parent, DESC_8606,
+			      wled_a(data->port));
+	if (ret < 0)
+		goto out;
+	data->current_brightness =3D ret;
+	dev_dbg(chip->dev, "get brightness %d\n", data->current_brightness);
+	return data->current_brightness;
+out:
+	return -EINVAL;
+}
+
+static struct backlight_ops pm860x_backlight_ops =3D {
+	.options	=3D BL_CORE_SUSPENDRESUME,
+	.update_status	=3D pm860x_backlight_update_status,
+	.get_brightness	=3D pm860x_backlight_get_brightness,
+};
+
+static int __check_device(struct pm860x_backlight_pdata *pdata, char *name=
)
+{
+	struct pm860x_backlight_pdata *p =3D pdata;
+	int ret =3D -EINVAL;
+
+	while (p && p->id) {
+		if ((p->id !=3D PM8606_ID_BACKLIGHT) || (p->flags < 0))
+			break;
+
+		if (!strncmp(name, pm860x_backlight_name[p->flags],
+			MFD_NAME_SIZE)) {
+			ret =3D (int)p->flags;
+			break;
+		}
+		p++;
+	}
+	return ret;
+}
+
+static int pm860x_backlight_probe(struct platform_device *pdev)
+{
+	struct pm860x_chip *chip =3D dev_get_drvdata(pdev->dev.parent);
+	struct pm860x_plat_data *pm860x_pdata;
+	struct pm860x_backlight_pdata *pdata;
+	struct pm860x_backlight_data *data;
+	struct backlight_device *bl;
+	struct resource *res;
+	unsigned char value;
+	char name[MFD_NAME_SIZE];
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
+		pdata =3D pm860x_pdata->backlight;
+	} else
+		pdata =3D NULL;
+
+	if (pdata =3D=3D NULL) {
+		dev_err(&pdev->dev, "platform data isn't assigned to "
+			"backlight\n");
+		return -EINVAL;
+	}
+
+	data =3D kzalloc(sizeof(struct pm860x_backlight_data), GFP_KERNEL);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+	strncpy(name, res->name, MFD_NAME_SIZE);
+	data->chip =3D chip;
+	data->current_brightness =3D MAX_BRIGHTNESS;
+	data->pwm =3D pdata->pwm;
+	data->iset =3D pdata->iset;
+	data->port =3D __check_device(pdata, name);
+	if (data->port < 0) {
+		dev_err(&pdev->dev, "wrong platform data is assigned");
+		return -EINVAL;
+	}
+
+	bl =3D backlight_device_register(name, &pdev->dev, data,
+					&pm860x_backlight_ops);
+	if (IS_ERR(bl)) {
+		dev_err(&pdev->dev, "failed to register backlight\n");
+		kfree(data);
+		return PTR_ERR(bl);
+	}
+	bl->props.max_brightness =3D MAX_BRIGHTNESS;
+	bl->props.brightness =3D MAX_BRIGHTNESS;
+
+	platform_set_drvdata(pdev, bl);
+
+	/* Enable reference VSYS */
+	ret =3D pm860x_reg_read(chip->parent, DESC_8606, PM8606_VSYS);
+	if (ret < 0)
+		goto out;
+	if ((ret & PM8606_VSYS_EN) =3D=3D 0) {
+		value =3D ret | PM8606_VSYS_EN;
+		ret =3D pm860x_reg_write(chip->parent, DESC_8606, PM8606_VSYS,
+				       value);
+		if (ret < 0)
+			goto out;
+	}
+	/* Enable reference OSC */
+	ret =3D pm860x_reg_read(chip->parent, DESC_8606, PM8606_MISC);
+	if (ret < 0)
+		goto out;
+	if ((ret & PM8606_MISC_OSC_EN) =3D=3D 0) {
+		value =3D ret | PM8606_MISC_OSC_EN;
+		ret =3D pm860x_reg_write(chip->parent, DESC_8606, PM8606_MISC,
+				       value);
+		if (ret < 0)
+			goto out;
+	}
+	/* read current backlight */
+	ret =3D pm860x_backlight_get_brightness(bl);
+	if (ret < 0)
+		goto out;
+
+	backlight_update_status(bl);
+	return 0;
+out:
+	kfree(data);
+	return ret;
+}
+
+static int pm860x_backlight_remove(struct platform_device *pdev)
+{
+	struct backlight_device *bl =3D platform_get_drvdata(pdev);
+	struct pm860x_backlight_data *data =3D bl_get_data(bl);
+
+	backlight_device_unregister(bl);
+	kfree(data);
+	return 0;
+}
+
+static struct platform_driver pm860x_backlight_driver =3D {
+	.driver		=3D {
+		.name	=3D "88pm860x-backlight",
+		.owner	=3D THIS_MODULE,
+	},
+	.probe		=3D pm860x_backlight_probe,
+	.remove		=3D pm860x_backlight_remove,
+};
+
+static int __init pm860x_backlight_init(void)
+{
+	return platform_driver_register(&pm860x_backlight_driver);
+}
+module_init(pm860x_backlight_init);
+
+static void __exit pm860x_backlight_exit(void)
+{
+	platform_driver_unregister(&pm860x_backlight_driver);
+}
+module_exit(pm860x_backlight_exit);
+
+MODULE_DESCRIPTION("Backlight Driver for Marvell Semiconductor 88PM8606");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:88pm860x-backlight");
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kcon=
fig
index 09bfa96..bb760a6 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -262,3 +262,9 @@ config BACKLIGHT_ADP5520
 	  To compile this driver as a module, choose M here: the module will
 	  be called adp5520_bl.

+config BACKLIGHT_88PM860X
+	bool "Backlight Driver for 88PM8606 using WLED"
+	depends on BACKLIGHT_CLASS_DEVICE && MFD_88PM860X
+	help
+	  Say Y to enable the backlight driver for Marvell 88PM8606.
+
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Mak=
efile
index 9a40554..802d467 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -28,4 +28,5 @@ obj-$(CONFIG_BACKLIGHT_SAHARA)	+=3D kb3886_bl.o
 obj-$(CONFIG_BACKLIGHT_WM831X)	+=3D wm831x_bl.o
 obj-$(CONFIG_BACKLIGHT_ADX)    +=3D adx_bl.o
 obj-$(CONFIG_BACKLIGHT_ADP5520)	+=3D adp5520_bl.o
+obj-$(CONFIG_BACKLIGHT_88PM860X) +=3D 88pm860x_bl.o

--=20
1.5.6.5

--0016e64ea9289d6d3c04788b422b
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0007-backlight-enable-backlight-in-88pm860x.patch"
Content-Disposition: attachment; 
	filename="0007-backlight-enable-backlight-in-88pm860x.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g24r308n0

RnJvbSAyYzJjMjk2YzA4Njk4YzBiYzAwZWY2MWNlODdiZmI0NzA1MGMxNjYyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IE1vbiwgOSBOb3YgMjAwOSAxMjo0MTowNyAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIGJhY2tsaWdodDogZW5hYmxlIGJhY2tsaWdodCBpbiA4OHBtODYweAoKQXQgbW9zdCwgdGhy
ZWUgYmFja2xpZ2h0IGRldmljZSBjYW4gYmUgc3VwcG9ydGVkIGluIDg4cG04NjB4IGRyaXZlci4K
ClNpZ25lZC1vZmYtYnk6IEhhb2ppYW4gWmh1YW5nIDxoYW9qaWFuLnpodWFuZ0BtYXJ2ZWxsLmNv
bT4KLS0tCiBkcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC84OHBtODYweF9ibC5jIHwgIDMxMSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L0tj
b25maWcgICAgICAgfCAgICA2ICsKIGRyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L01ha2VmaWxlICAg
ICAgfCAgICAxICsKIDMgZmlsZXMgY2hhbmdlZCwgMzE4IGluc2VydGlvbnMoKyksIDAgZGVsZXRp
b25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy92aWRlby9iYWNrbGlnaHQvODhwbTg2
MHhfYmwuYwoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0Lzg4cG04NjB4X2Js
LmMgYi9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC84OHBtODYweF9ibC5jCm5ldyBmaWxlIG1vZGUg
MTAwNjQ0CmluZGV4IDAwMDAwMDAuLmQ2YTRlOTcKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJz
L3ZpZGVvL2JhY2tsaWdodC84OHBtODYweF9ibC5jCkBAIC0wLDAgKzEsMzExIEBACisvKgorICog
QmFja2xpZ2h0IGRyaXZlciBmb3IgTWFydmVsbCBTZW1pY29uZHVjdG9yIDg4UE04NjA2CisgKgor
ICogQ29weXJpZ2h0IChDKSAyMDA5IE1hcnZlbGwgSW50ZXJuYXRpb25hbCBMdGQuCisgKglIYW9q
aWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVsbC5jb20+CisgKgorICogVGhpcyBwcm9n
cmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2Rp
ZnkKKyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgdmVyc2lvbiAyIGFzCisgKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRh
dGlvbi4KKyAqLworCisjaW5jbHVkZSA8bGludXgvaW5pdC5oPgorI2luY2x1ZGUgPGxpbnV4L2tl
cm5lbC5oPgorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgorI2luY2x1ZGUgPGxp
bnV4L2ZiLmg+CisjaW5jbHVkZSA8bGludXgvYmFja2xpZ2h0Lmg+CisjaW5jbHVkZSA8bGludXgv
bWZkLzg4cG04NjB4Lmg+CisKKyNkZWZpbmUgTUFYX0JSSUdIVE5FU1MJCSgweEZGKQorI2RlZmlu
ZSBNSU5fQlJJR0hUTkVTUwkJKDApCisKKyNkZWZpbmUgQ1VSUkVOVF9NQVNLCQkoMHgxRiA8PCAx
KQorCitzdHJ1Y3QgcG04NjB4X2JhY2tsaWdodF9kYXRhIHsKKwlzdHJ1Y3QgcG04NjB4X2NoaXAg
KmNoaXA7CisJaW50CWN1cnJlbnRfYnJpZ2h0bmVzczsKKwlpbnQJcG9ydDsKKwlpbnQJcHdtOwor
CWludAlpc2V0OworfTsKKworc3RhdGljIGlubGluZSBpbnQgd2xlZF9hKGludCBwb3J0KQorewor
CWludCByZXQ7CisKKwlyZXQgPSAoKHBvcnQgLSBQTTg2MDZfQkFDS0xJR0hUMSkgPDwgMSkgKyAy
OworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbmxpbmUgaW50IHdsZWRfYihpbnQgcG9ydCkK
K3sKKwlpbnQgcmV0OworCisJcmV0ID0gKChwb3J0IC0gUE04NjA2X0JBQ0tMSUdIVDEpIDw8IDEp
ICsgMzsKKwlyZXR1cm4gcmV0OworfQorCisvKiBXTEVEMiAmIFdMRUQzIHNoYXJlIHRoZSBzYW1l
IElEQyAqLworc3RhdGljIGlubGluZSBpbnQgd2xlZF9pZGMoaW50IHBvcnQpCit7CisJaW50IHJl
dDsKKworCXN3aXRjaCAocG9ydCkgeworCWNhc2UgUE04NjA2X0JBQ0tMSUdIVDE6CisJY2FzZSBQ
TTg2MDZfQkFDS0xJR0hUMjoKKwkJcmV0ID0gKChwb3J0IC0gUE04NjA2X0JBQ0tMSUdIVDEpIDw8
IDEpICsgMzsKKwkJYnJlYWs7CisJY2FzZSBQTTg2MDZfQkFDS0xJR0hUMzoKKwlkZWZhdWx0Ogor
CQlyZXQgPSAoKHBvcnQgLSBQTTg2MDZfQkFDS0xJR0hUMikgPDwgMSkgKyAzOworCQlicmVhazsK
Kwl9CisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGludCBwbTg2MHhfYmFja2xpZ2h0X3NldChz
dHJ1Y3QgYmFja2xpZ2h0X2RldmljZSAqYmwsIGludCBicmlnaHRuZXNzKQoreworCXN0cnVjdCBw
bTg2MHhfYmFja2xpZ2h0X2RhdGEgKmRhdGEgPSBibF9nZXRfZGF0YShibCk7CisJc3RydWN0IHBt
ODYweF9jaGlwICpjaGlwID0gZGF0YS0+Y2hpcDsKKwl1bnNpZ25lZCBjaGFyIHZhbHVlOworCWlu
dCByZXQ7CisKKwlpZiAoYnJpZ2h0bmVzcyA+IE1BWF9CUklHSFRORVNTKQorCQl2YWx1ZSA9IE1B
WF9CUklHSFRORVNTOworCWVsc2UKKwkJdmFsdWUgPSBicmlnaHRuZXNzOworCisJcmV0ID0gcG04
NjB4X3JlZ193cml0ZShjaGlwLT5wYXJlbnQsIERFU0NfODYwNiwKKwkJCSAgICAgICB3bGVkX2Eo
ZGF0YS0+cG9ydCksIHZhbHVlKTsKKwlpZiAocmV0IDwgMCkKKwkJZ290byBvdXQ7CisKKwlpZiAo
KGRhdGEtPmN1cnJlbnRfYnJpZ2h0bmVzcyA9PSAwKSAmJiBicmlnaHRuZXNzKSB7CisJCWlmIChk
YXRhLT5pc2V0KSB7CisJCQlyZXQgPSBwbTg2MHhfc2V0X2JpdHMoY2hpcC0+cGFyZW50LCBERVND
Xzg2MDYsCisJCQkJCSAgICAgIHdsZWRfaWRjKGRhdGEtPnBvcnQpLAorCQkJCQkgICAgICBDVVJS
RU5UX01BU0ssIGRhdGEtPmlzZXQpOworCQkJaWYgKHJldCA8IDApCisJCQkJZ290byBvdXQ7CisJ
CX0KKwkJaWYgKGRhdGEtPnB3bSkgeworCQkJcmV0ID0gcG04NjB4X3NldF9iaXRzKGNoaXAtPnBh
cmVudCwgREVTQ184NjA2LAorCQkJCQkgICAgICBQTTg2MDZfUFdNLCBQTTg2MDZfUFdNX0ZSRVFf
TUFTSywKKwkJCQkJICAgICAgZGF0YS0+cHdtKTsKKwkJCWlmIChyZXQgPCAwKQorCQkJCWdvdG8g
b3V0OworCQl9CisJCWlmIChicmlnaHRuZXNzID09IE1BWF9CUklHSFRORVNTKSB7CisJCQkvKiBz
ZXQgV0xFRF9PTiBiaXQgYXMgMTAwJSAqLworCQkJcmV0ID0gcG04NjB4X3NldF9iaXRzKGNoaXAt
PnBhcmVudCwgREVTQ184NjA2LAorCQkJCQkgICAgICB3bGVkX2IoZGF0YS0+cG9ydCksCisJCQkJ
CSAgICAgIFBNODYwNl9XTEVEX09OLCBQTTg2MDZfV0xFRF9PTik7CisJCX0KKwl9IGVsc2Ugewor
CQlpZiAoYnJpZ2h0bmVzcyA9PSBNQVhfQlJJR0hUTkVTUykgeworCQkJLyogc2V0IFdMRURfT04g
Yml0IGFzIDEwMCUgKi8KKwkJCXJldCA9IHBtODYweF9zZXRfYml0cyhjaGlwLT5wYXJlbnQsIERF
U0NfODYwNiwKKwkJCQkJICAgICAgd2xlZF9iKGRhdGEtPnBvcnQpLAorCQkJCQkgICAgICBQTTg2
MDZfV0xFRF9PTiwgUE04NjA2X1dMRURfT04pOworCQl9IGVsc2UgeworCQkJLyogY2xlYXIgV0xF
RF9PTiBiaXQgc2luY2UgaXQncyBub3QgMTAwJSAqLworCQkJcmV0ID0gcG04NjB4X3NldF9iaXRz
KGNoaXAtPnBhcmVudCwgREVTQ184NjA2LAorCQkJCQkgICAgICB3bGVkX2IoZGF0YS0+cG9ydCks
CisJCQkJCSAgICAgIFBNODYwNl9XTEVEX09OLCAwKTsKKwkJfQorCX0KKwlpZiAocmV0IDwgMCkK
KwkJZ290byBvdXQ7CisKKwlkZXZfZGJnKGNoaXAtPmRldiwgInNldCBicmlnaHRuZXNzICVkXG4i
LCB2YWx1ZSk7CisJZGF0YS0+Y3VycmVudF9icmlnaHRuZXNzID0gdmFsdWU7CisJcmV0dXJuIDA7
CitvdXQ6CisJZGV2X2RiZyhjaGlwLT5kZXYsICJzZXQgYnJpZ2h0bmVzcyAlZCBmYWlsdXJlIHdp
dGggcmV0dXJuICIKKwkJInZhbHVlOiVkXG4iLCB2YWx1ZSwgcmV0KTsKKwlyZXR1cm4gcmV0Owor
fQorCitzdGF0aWMgaW50IHBtODYweF9iYWNrbGlnaHRfdXBkYXRlX3N0YXR1cyhzdHJ1Y3QgYmFj
a2xpZ2h0X2RldmljZSAqYmwpCit7CisJaW50IGJyaWdodG5lc3MgPSBibC0+cHJvcHMuYnJpZ2h0
bmVzczsKKworCWlmIChibC0+cHJvcHMucG93ZXIgIT0gRkJfQkxBTktfVU5CTEFOSykKKwkJYnJp
Z2h0bmVzcyA9IDA7CisKKwlpZiAoYmwtPnByb3BzLmZiX2JsYW5rICE9IEZCX0JMQU5LX1VOQkxB
TkspCisJCWJyaWdodG5lc3MgPSAwOworCisJaWYgKGJsLT5wcm9wcy5zdGF0ZSAmIEJMX0NPUkVf
U1VTUEVOREVEKQorCQlicmlnaHRuZXNzID0gMDsKKworCXJldHVybiBwbTg2MHhfYmFja2xpZ2h0
X3NldChibCwgYnJpZ2h0bmVzcyk7Cit9CisKK3N0YXRpYyBpbnQgcG04NjB4X2JhY2tsaWdodF9n
ZXRfYnJpZ2h0bmVzcyhzdHJ1Y3QgYmFja2xpZ2h0X2RldmljZSAqYmwpCit7CisJc3RydWN0IHBt
ODYweF9iYWNrbGlnaHRfZGF0YSAqZGF0YSA9IGJsX2dldF9kYXRhKGJsKTsKKwlzdHJ1Y3QgcG04
NjB4X2NoaXAgKmNoaXAgPSBkYXRhLT5jaGlwOworCWludCByZXQ7CisKKwlyZXQgPSBwbTg2MHhf
cmVnX3JlYWQoY2hpcC0+cGFyZW50LCBERVNDXzg2MDYsCisJCQkgICAgICB3bGVkX2EoZGF0YS0+
cG9ydCkpOworCWlmIChyZXQgPCAwKQorCQlnb3RvIG91dDsKKwlkYXRhLT5jdXJyZW50X2JyaWdo
dG5lc3MgPSByZXQ7CisJZGV2X2RiZyhjaGlwLT5kZXYsICJnZXQgYnJpZ2h0bmVzcyAlZFxuIiwg
ZGF0YS0+Y3VycmVudF9icmlnaHRuZXNzKTsKKwlyZXR1cm4gZGF0YS0+Y3VycmVudF9icmlnaHRu
ZXNzOworb3V0OgorCXJldHVybiAtRUlOVkFMOworfQorCitzdGF0aWMgc3RydWN0IGJhY2tsaWdo
dF9vcHMgcG04NjB4X2JhY2tsaWdodF9vcHMgPSB7CisJLm9wdGlvbnMJPSBCTF9DT1JFX1NVU1BF
TkRSRVNVTUUsCisJLnVwZGF0ZV9zdGF0dXMJPSBwbTg2MHhfYmFja2xpZ2h0X3VwZGF0ZV9zdGF0
dXMsCisJLmdldF9icmlnaHRuZXNzCT0gcG04NjB4X2JhY2tsaWdodF9nZXRfYnJpZ2h0bmVzcywK
K307CisKK3N0YXRpYyBpbnQgX19jaGVja19kZXZpY2Uoc3RydWN0IHBtODYweF9iYWNrbGlnaHRf
cGRhdGEgKnBkYXRhLCBjaGFyICpuYW1lKQoreworCXN0cnVjdCBwbTg2MHhfYmFja2xpZ2h0X3Bk
YXRhICpwID0gcGRhdGE7CisJaW50IHJldCA9IC1FSU5WQUw7CisKKwl3aGlsZSAocCAmJiBwLT5p
ZCkgeworCQlpZiAoKHAtPmlkICE9IFBNODYwNl9JRF9CQUNLTElHSFQpIHx8IChwLT5mbGFncyA8
IDApKQorCQkJYnJlYWs7CisKKwkJaWYgKCFzdHJuY21wKG5hbWUsIHBtODYweF9iYWNrbGlnaHRf
bmFtZVtwLT5mbGFnc10sCisJCQlNRkRfTkFNRV9TSVpFKSkgeworCQkJcmV0ID0gKGludClwLT5m
bGFnczsKKwkJCWJyZWFrOworCQl9CisJCXArKzsKKwl9CisJcmV0dXJuIHJldDsKK30KKworc3Rh
dGljIGludCBwbTg2MHhfYmFja2xpZ2h0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpCit7CisJc3RydWN0IHBtODYweF9jaGlwICpjaGlwID0gZGV2X2dldF9kcnZkYXRhKHBkZXYt
PmRldi5wYXJlbnQpOworCXN0cnVjdCBwbTg2MHhfcGxhdF9kYXRhICpwbTg2MHhfcGRhdGE7CisJ
c3RydWN0IHBtODYweF9iYWNrbGlnaHRfcGRhdGEgKnBkYXRhOworCXN0cnVjdCBwbTg2MHhfYmFj
a2xpZ2h0X2RhdGEgKmRhdGE7CisJc3RydWN0IGJhY2tsaWdodF9kZXZpY2UgKmJsOworCXN0cnVj
dCByZXNvdXJjZSAqcmVzOworCXVuc2lnbmVkIGNoYXIgdmFsdWU7CisJY2hhciBuYW1lW01GRF9O
QU1FX1NJWkVdOworCWludCByZXQ7CisKKwlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRl
diwgSU9SRVNPVVJDRV9JTywgMCk7CisJaWYgKHJlcyA9PSBOVUxMKSB7CisJCWRldl9lcnIoJnBk
ZXYtPmRldiwgIk5vIEkvTyByZXNvdXJjZSFcbiIpOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisK
KwlpZiAocGRldi0+ZGV2LnBhcmVudC0+cGxhdGZvcm1fZGF0YSkgeworCQlwbTg2MHhfcGRhdGEg
PSBwZGV2LT5kZXYucGFyZW50LT5wbGF0Zm9ybV9kYXRhOworCQlwZGF0YSA9IHBtODYweF9wZGF0
YS0+YmFja2xpZ2h0OworCX0gZWxzZQorCQlwZGF0YSA9IE5VTEw7CisKKwlpZiAocGRhdGEgPT0g
TlVMTCkgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJwbGF0Zm9ybSBkYXRhIGlzbid0IGFzc2ln
bmVkIHRvICIKKwkJCSJiYWNrbGlnaHRcbiIpOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisKKwlk
YXRhID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IHBtODYweF9iYWNrbGlnaHRfZGF0YSksIEdGUF9L
RVJORUwpOworCWlmIChkYXRhID09IE5VTEwpCisJCXJldHVybiAtRU5PTUVNOworCXN0cm5jcHko
bmFtZSwgcmVzLT5uYW1lLCBNRkRfTkFNRV9TSVpFKTsKKwlkYXRhLT5jaGlwID0gY2hpcDsKKwlk
YXRhLT5jdXJyZW50X2JyaWdodG5lc3MgPSBNQVhfQlJJR0hUTkVTUzsKKwlkYXRhLT5wd20gPSBw
ZGF0YS0+cHdtOworCWRhdGEtPmlzZXQgPSBwZGF0YS0+aXNldDsKKwlkYXRhLT5wb3J0ID0gX19j
aGVja19kZXZpY2UocGRhdGEsIG5hbWUpOworCWlmIChkYXRhLT5wb3J0IDwgMCkgeworCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsICJ3cm9uZyBwbGF0Zm9ybSBkYXRhIGlzIGFzc2lnbmVkIik7CisJCXJl
dHVybiAtRUlOVkFMOworCX0KKworCWJsID0gYmFja2xpZ2h0X2RldmljZV9yZWdpc3RlcihuYW1l
LCAmcGRldi0+ZGV2LCBkYXRhLAorCQkJCQkmcG04NjB4X2JhY2tsaWdodF9vcHMpOworCWlmIChJ
U19FUlIoYmwpKSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byByZWdpc3RlciBi
YWNrbGlnaHRcbiIpOworCQlrZnJlZShkYXRhKTsKKwkJcmV0dXJuIFBUUl9FUlIoYmwpOworCX0K
KwlibC0+cHJvcHMubWF4X2JyaWdodG5lc3MgPSBNQVhfQlJJR0hUTkVTUzsKKwlibC0+cHJvcHMu
YnJpZ2h0bmVzcyA9IE1BWF9CUklHSFRORVNTOworCisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRl
diwgYmwpOworCisJLyogRW5hYmxlIHJlZmVyZW5jZSBWU1lTICovCisJcmV0ID0gcG04NjB4X3Jl
Z19yZWFkKGNoaXAtPnBhcmVudCwgREVTQ184NjA2LCBQTTg2MDZfVlNZUyk7CisJaWYgKHJldCA8
IDApCisJCWdvdG8gb3V0OworCWlmICgocmV0ICYgUE04NjA2X1ZTWVNfRU4pID09IDApIHsKKwkJ
dmFsdWUgPSByZXQgfCBQTTg2MDZfVlNZU19FTjsKKwkJcmV0ID0gcG04NjB4X3JlZ193cml0ZShj
aGlwLT5wYXJlbnQsIERFU0NfODYwNiwgUE04NjA2X1ZTWVMsCisJCQkJICAgICAgIHZhbHVlKTsK
KwkJaWYgKHJldCA8IDApCisJCQlnb3RvIG91dDsKKwl9CisJLyogRW5hYmxlIHJlZmVyZW5jZSBP
U0MgKi8KKwlyZXQgPSBwbTg2MHhfcmVnX3JlYWQoY2hpcC0+cGFyZW50LCBERVNDXzg2MDYsIFBN
ODYwNl9NSVNDKTsKKwlpZiAocmV0IDwgMCkKKwkJZ290byBvdXQ7CisJaWYgKChyZXQgJiBQTTg2
MDZfTUlTQ19PU0NfRU4pID09IDApIHsKKwkJdmFsdWUgPSByZXQgfCBQTTg2MDZfTUlTQ19PU0Nf
RU47CisJCXJldCA9IHBtODYweF9yZWdfd3JpdGUoY2hpcC0+cGFyZW50LCBERVNDXzg2MDYsIFBN
ODYwNl9NSVNDLAorCQkJCSAgICAgICB2YWx1ZSk7CisJCWlmIChyZXQgPCAwKQorCQkJZ290byBv
dXQ7CisJfQorCS8qIHJlYWQgY3VycmVudCBiYWNrbGlnaHQgKi8KKwlyZXQgPSBwbTg2MHhfYmFj
a2xpZ2h0X2dldF9icmlnaHRuZXNzKGJsKTsKKwlpZiAocmV0IDwgMCkKKwkJZ290byBvdXQ7CisK
KwliYWNrbGlnaHRfdXBkYXRlX3N0YXR1cyhibCk7CisJcmV0dXJuIDA7CitvdXQ6CisJa2ZyZWUo
ZGF0YSk7CisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGludCBwbTg2MHhfYmFja2xpZ2h0X3Jl
bW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQoreworCXN0cnVjdCBiYWNrbGlnaHRf
ZGV2aWNlICpibCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOworCXN0cnVjdCBwbTg2MHhf
YmFja2xpZ2h0X2RhdGEgKmRhdGEgPSBibF9nZXRfZGF0YShibCk7CisKKwliYWNrbGlnaHRfZGV2
aWNlX3VucmVnaXN0ZXIoYmwpOworCWtmcmVlKGRhdGEpOworCXJldHVybiAwOworfQorCitzdGF0
aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBwbTg2MHhfYmFja2xpZ2h0X2RyaXZlciA9IHsKKwku
ZHJpdmVyCQk9IHsKKwkJLm5hbWUJPSAiODhwbTg2MHgtYmFja2xpZ2h0IiwKKwkJLm93bmVyCT0g
VEhJU19NT0RVTEUsCisJfSwKKwkucHJvYmUJCT0gcG04NjB4X2JhY2tsaWdodF9wcm9iZSwKKwku
cmVtb3ZlCQk9IHBtODYweF9iYWNrbGlnaHRfcmVtb3ZlLAorfTsKKworc3RhdGljIGludCBfX2lu
aXQgcG04NjB4X2JhY2tsaWdodF9pbml0KHZvaWQpCit7CisJcmV0dXJuIHBsYXRmb3JtX2RyaXZl
cl9yZWdpc3RlcigmcG04NjB4X2JhY2tsaWdodF9kcml2ZXIpOworfQorbW9kdWxlX2luaXQocG04
NjB4X2JhY2tsaWdodF9pbml0KTsKKworc3RhdGljIHZvaWQgX19leGl0IHBtODYweF9iYWNrbGln
aHRfZXhpdCh2b2lkKQoreworCXBsYXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVyKCZwbTg2MHhfYmFj
a2xpZ2h0X2RyaXZlcik7Cit9Cittb2R1bGVfZXhpdChwbTg2MHhfYmFja2xpZ2h0X2V4aXQpOwor
CitNT0RVTEVfREVTQ1JJUFRJT04oIkJhY2tsaWdodCBEcml2ZXIgZm9yIE1hcnZlbGwgU2VtaWNv
bmR1Y3RvciA4OFBNODYwNiIpOworTU9EVUxFX0FVVEhPUigiSGFvamlhbiBaaHVhbmcgPGhhb2pp
YW4uemh1YW5nQG1hcnZlbGwuY29tPiIpOworTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOworTU9EVUxF
X0FMSUFTKCJwbGF0Zm9ybTo4OHBtODYweC1iYWNrbGlnaHQiKTsKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlkZW8vYmFja2xpZ2h0L0tjb25maWcgYi9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9LY29u
ZmlnCmluZGV4IDA5YmZhOTYuLmJiNzYwYTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vYmFj
a2xpZ2h0L0tjb25maWcKKysrIGIvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvS2NvbmZpZwpAQCAt
MjYyLDMgKzI2Miw5IEBAIGNvbmZpZyBCQUNLTElHSFRfQURQNTUyMAogCSAgVG8gY29tcGlsZSB0
aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlIG1vZHVsZSB3aWxsCiAJ
ICBiZSBjYWxsZWQgYWRwNTUyMF9ibC4KIAorY29uZmlnIEJBQ0tMSUdIVF84OFBNODYwWAorCWJv
b2wgIkJhY2tsaWdodCBEcml2ZXIgZm9yIDg4UE04NjA2IHVzaW5nIFdMRUQiCisJZGVwZW5kcyBv
biBCQUNLTElHSFRfQ0xBU1NfREVWSUNFICYmIE1GRF84OFBNODYwWAorCWhlbHAKKwkgIFNheSBZ
IHRvIGVuYWJsZSB0aGUgYmFja2xpZ2h0IGRyaXZlciBmb3IgTWFydmVsbCA4OFBNODYwNi4KKwpk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvTWFrZWZpbGUgYi9kcml2ZXJzL3Zp
ZGVvL2JhY2tsaWdodC9NYWtlZmlsZQppbmRleCA5YTQwNTU0Li44MDJkNDY3IDEwMDY0NAotLS0g
YS9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9NYWtlZmlsZQorKysgYi9kcml2ZXJzL3ZpZGVvL2Jh
Y2tsaWdodC9NYWtlZmlsZQpAQCAtMjgsNCArMjgsNSBAQCBvYmotJChDT05GSUdfQkFDS0xJR0hU
X1NBSEFSQSkJKz0ga2IzODg2X2JsLm8KIG9iai0kKENPTkZJR19CQUNLTElHSFRfV004MzFYKQkr
PSB3bTgzMXhfYmwubwogb2JqLSQoQ09ORklHX0JBQ0tMSUdIVF9BRFgpICAgICs9IGFkeF9ibC5v
CiBvYmotJChDT05GSUdfQkFDS0xJR0hUX0FEUDU1MjApCSs9IGFkcDU1MjBfYmwubworb2JqLSQo
Q09ORklHX0JBQ0tMSUdIVF84OFBNODYwWCkgKz0gODhwbTg2MHhfYmwubwogCi0tIAoxLjUuNi41
Cgo=
--0016e64ea9289d6d3c04788b422b--
