From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 8 Mar 2010 11:28:43 -0500
Subject: [PATCH] input: enable onkey driver of max8925
Message-ID: <mailman.465.1274320017.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement onkey driver. While ONKEY is held for 3 seconds, KEY_POWER
event occurs.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/input/misc/Kconfig         |   10 +++
 drivers/input/misc/Makefile        |    1 +
 drivers/input/misc/max8925_onkey.c |  148 ++++++++++++++++++++++++++++++++=
++++
 3 files changed, 159 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/max8925_onkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 23140a3..5505b5c 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -50,6 +50,16 @@ config INPUT_M68K_BEEP
 	tristate "M68k Beeper support"
 	depends on M68K

+config INPUT_MAX8925_ONKEY
+	tristate "MAX8925 ONKEY support"
+	depends on MFD_MAX8925
+	help
+	  Support the ONKEY of MAX8925 PMICs as an input device
+	  reporting power button status.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called max8925_onkey.
+
 config INPUT_APANEL
 	tristate "Fujitsu Lifebook Application Panel buttons"
 	depends on X86 && I2C && LEDS_CLASS
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 7e95a5d..71e9111 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_HP_SDC_RTC)		+=3D hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+=3D ixp4xx-beeper.o
 obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+=3D keyspan_remote.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+=3D m68kspkr.o
+obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+=3D max8925_onkey.o
 obj-$(CONFIG_INPUT_PCAP)		+=3D pcap_keys.o
 obj-$(CONFIG_INPUT_PCF50633_PMU)	+=3D pcf50633-input.o
 obj-$(CONFIG_INPUT_PCSPKR)		+=3D pcspkr.o
diff --git a/drivers/input/misc/max8925_onkey.c
b/drivers/input/misc/max8925_onkey.c
new file mode 100644
index 0000000..0da2cff
--- /dev/null
+++ b/drivers/input/misc/max8925_onkey.c
@@ -0,0 +1,148 @@
+/**
+ * max8925_onkey.c - MAX8925 ONKEY driver
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ *      Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max8925.h>
+#include <linux/slab.h>
+
+#define HARDRESET_EN		(1 << 7)
+#define PWREN_EN		(1 << 7)
+
+struct max8925_onkey_info {
+	struct input_dev	*idev;
+	struct max8925_chip	*chip;
+	struct i2c_client	*i2c;
+	struct device		*dev;
+	int			irq;
+};
+
+/*
+ * MAX8925 gives us an interrupt when ONKEY is held for 3 seconds.
+ * max8925_set_bits() operates I2C bus and may sleep. So implement
+ * it in thread IRQ handler.
+ */
+static irqreturn_t max8925_onkey_handler(int irq, void *data)
+{
+	struct max8925_onkey_info *info =3D data;
+
+	input_report_key(info->idev, KEY_POWER, 1);
+	input_sync(info->idev);
+
+	/* Enable hardreset to halt if system isn't shutdown on time */
+	max8925_set_bits(info->i2c, MAX8925_SYSENSEL,
+			 HARDRESET_EN, HARDRESET_EN);
+	return IRQ_HANDLED;
+}
+
+static int __devinit max8925_onkey_probe(struct platform_device *pdev)
+{
+	struct max8925_chip *chip =3D dev_get_drvdata(pdev->dev.parent);
+	struct max8925_onkey_info *info;
+	int irq, ret;
+
+	info =3D kzalloc(sizeof(struct max8925_onkey_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->chip =3D chip;
+	info->i2c =3D chip->i2c;
+	info->dev =3D &pdev->dev;
+	irq =3D chip->irq_base + MAX8925_IRQ_GPM_SW_3SEC;
+
+	info->idev =3D input_allocate_device();
+	if (!info->idev) {
+		dev_err(chip->dev, "Failed to allocate input dev\n");
+		ret =3D -ENOMEM;
+		goto out_input;
+	}
+
+	ret =3D request_threaded_irq(irq, NULL, max8925_onkey_handler,
+				   IRQF_ONESHOT, "onkey", info);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			irq, ret);
+		goto out_irq;
+	}
+
+	info->idev->name =3D "max8925_on";
+	info->idev->phys =3D "max8925_on/input0";
+	info->idev->id.bustype =3D BUS_I2C;
+	info->idev->dev.parent =3D &pdev->dev;
+	info->irq =3D irq;
+	info->idev->evbit[0] =3D BIT_MASK(EV_KEY);
+	info->idev->keybit[BIT_WORD(KEY_POWER)] =3D BIT_MASK(KEY_POWER);
+
+	ret =3D input_register_device(info->idev);
+	if (ret) {
+		dev_err(chip->dev, "Can't register input device: %d\n", ret);
+		goto out;
+	}
+	platform_set_drvdata(pdev, info);
+
+	return 0;
+
+out:
+	free_irq(info->irq, info);
+out_irq:
+	input_free_device(info->idev);
+out_input:
+	kfree(info);
+	return ret;
+}
+
+static int __devexit max8925_onkey_remove(struct platform_device *pdev)
+{
+	struct max8925_onkey_info *info =3D platform_get_drvdata(pdev);
+
+	free_irq(info->irq, info);
+	input_unregister_device(info->idev);
+	kfree(info);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static struct platform_driver max8925_onkey_driver =3D {
+	.driver		=3D {
+		.name	=3D "max8925-onkey",
+		.owner	=3D THIS_MODULE,
+	},
+	.probe		=3D max8925_onkey_probe,
+	.remove		=3D __devexit_p(max8925_onkey_remove),
+};
+
+static int __init max8925_onkey_init(void)
+{
+	return platform_driver_register(&max8925_onkey_driver);
+}
+module_init(max8925_onkey_init);
+
+static void __exit max8925_onkey_exit(void)
+{
+	platform_driver_unregister(&max8925_onkey_driver);
+}
+module_exit(max8925_onkey_exit);
+
+MODULE_DESCRIPTION("Maxim MAX8925 ONKEY driver");
+MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
+MODULE_LICENSE("GPL");
--=20
1.5.6.5

--001636e0a70fa0bfc90486fcbf3f
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0003-input-enable-onkey-driver-of-max8925.patch"
Content-Disposition: attachment; 
	filename="0003-input-enable-onkey-driver-of-max8925.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9ex4p9j0

RnJvbSAxN2MzN2YzZmQxNjExODNhM2ZhMjBiZmVmZjU4YWJkYzI4OWQzZmUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IE1vbiwgOCBNYXIgMjAxMCAxMToyODo0MyAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIGlucHV0OiBlbmFibGUgb25rZXkgZHJpdmVyIG9mIG1heDg5MjUKCkltcGxlbWVudCBvbmtl
eSBkcml2ZXIuIFdoaWxlIE9OS0VZIGlzIGhlbGQgZm9yIDMgc2Vjb25kcywgS0VZX1BPV0VSCmV2
ZW50IG9jY3Vycy4KClNpZ25lZC1vZmYtYnk6IEhhb2ppYW4gWmh1YW5nIDxoYW9qaWFuLnpodWFu
Z0BtYXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL2lucHV0L21pc2MvS2NvbmZpZyAgICAgICAgIHwg
ICAxMCArKysKIGRyaXZlcnMvaW5wdXQvbWlzYy9NYWtlZmlsZSAgICAgICAgfCAgICAxICsKIGRy
aXZlcnMvaW5wdXQvbWlzYy9tYXg4OTI1X29ua2V5LmMgfCAgMTQ4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxNTkgaW5zZXJ0aW9ucygrKSwg
MCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lucHV0L21pc2MvbWF4
ODkyNV9vbmtleS5jCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1dC9taXNjL0tjb25maWcgYi9k
cml2ZXJzL2lucHV0L21pc2MvS2NvbmZpZwppbmRleCAyMzE0MGEzLi41NTA1YjVjIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2lucHV0L21pc2MvS2NvbmZpZworKysgYi9kcml2ZXJzL2lucHV0L21pc2Mv
S2NvbmZpZwpAQCAtNTAsNiArNTAsMTYgQEAgY29uZmlnIElOUFVUX002OEtfQkVFUAogCXRyaXN0
YXRlICJNNjhrIEJlZXBlciBzdXBwb3J0IgogCWRlcGVuZHMgb24gTTY4SwogCitjb25maWcgSU5Q
VVRfTUFYODkyNV9PTktFWQorCXRyaXN0YXRlICJNQVg4OTI1IE9OS0VZIHN1cHBvcnQiCisJZGVw
ZW5kcyBvbiBNRkRfTUFYODkyNQorCWhlbHAKKwkgIFN1cHBvcnQgdGhlIE9OS0VZIG9mIE1BWDg5
MjUgUE1JQ3MgYXMgYW4gaW5wdXQgZGV2aWNlCisJICByZXBvcnRpbmcgcG93ZXIgYnV0dG9uIHN0
YXR1cy4KKworCSAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0g
aGVyZTogdGhlIG1vZHVsZQorCSAgd2lsbCBiZSBjYWxsZWQgbWF4ODkyNV9vbmtleS4KKwogY29u
ZmlnIElOUFVUX0FQQU5FTAogCXRyaXN0YXRlICJGdWppdHN1IExpZmVib29rIEFwcGxpY2F0aW9u
IFBhbmVsIGJ1dHRvbnMiCiAJZGVwZW5kcyBvbiBYODYgJiYgSTJDICYmIExFRFNfQ0xBU1MKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvbWlzYy9NYWtlZmlsZSBiL2RyaXZlcnMvaW5wdXQvbWlz
Yy9NYWtlZmlsZQppbmRleCA3ZTk1YTVkLi43MWU5MTExIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lu
cHV0L21pc2MvTWFrZWZpbGUKKysrIGIvZHJpdmVycy9pbnB1dC9taXNjL01ha2VmaWxlCkBAIC0x
Nyw2ICsxNyw3IEBAIG9iai0kKENPTkZJR19IUF9TRENfUlRDKQkJKz0gaHBfc2RjX3J0Yy5vCiBv
YmotJChDT05GSUdfSU5QVVRfSVhQNFhYX0JFRVBFUikJKz0gaXhwNHh4LWJlZXBlci5vCiBvYmot
JChDT05GSUdfSU5QVVRfS0VZU1BBTl9SRU1PVEUpCSs9IGtleXNwYW5fcmVtb3RlLm8KIG9iai0k
KENPTkZJR19JTlBVVF9NNjhLX0JFRVApCQkrPSBtNjhrc3Brci5vCitvYmotJChDT05GSUdfSU5Q
VVRfTUFYODkyNV9PTktFWSkJKz0gbWF4ODkyNV9vbmtleS5vCiBvYmotJChDT05GSUdfSU5QVVRf
UENBUCkJCSs9IHBjYXBfa2V5cy5vCiBvYmotJChDT05GSUdfSU5QVVRfUENGNTA2MzNfUE1VKQkr
PSBwY2Y1MDYzMy1pbnB1dC5vCiBvYmotJChDT05GSUdfSU5QVVRfUENTUEtSKQkJKz0gcGNzcGty
Lm8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvbWlzYy9tYXg4OTI1X29ua2V5LmMgYi9kcml2
ZXJzL2lucHV0L21pc2MvbWF4ODkyNV9vbmtleS5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4
IDAwMDAwMDAuLjBkYTJjZmYKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL2lucHV0L21pc2Mv
bWF4ODkyNV9vbmtleS5jCkBAIC0wLDAgKzEsMTQ4IEBACisvKioKKyAqIG1heDg5MjVfb25rZXku
YyAtIE1BWDg5MjUgT05LRVkgZHJpdmVyCisgKgorICogQ29weXJpZ2h0IChDKSAyMDA5IE1hcnZl
bGwgSW50ZXJuYXRpb25hbCBMdGQuCisgKiAgICAgIEhhb2ppYW4gWmh1YW5nIDxoYW9qaWFuLnpo
dWFuZ0BtYXJ2ZWxsLmNvbT4KKyAqCisgKiBUaGlzIGZpbGUgaXMgc3ViamVjdCB0byB0aGUgdGVy
bXMgYW5kIGNvbmRpdGlvbnMgb2YgdGhlIEdOVSBHZW5lcmFsCisgKiBQdWJsaWMgTGljZW5zZS4g
U2VlIHRoZSBmaWxlICJDT1BZSU5HIiBpbiB0aGUgbWFpbiBkaXJlY3Rvcnkgb2YgdGhpcworICog
YXJjaGl2ZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmli
dXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorICogYnV0IFdJVEhPVVQg
QU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqIE1F
UkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0
aGUKKyAqIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgor
ICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UKKyAqIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRv
IHRoZSBGcmVlIFNvZnR3YXJlCisgKiBGb3VuZGF0aW9uLCBJbmMuLCA1OSBUZW1wbGUgUGxhY2Us
IFN1aXRlIDMzMCwgQm9zdG9uLCBNQSAgMDIxMTEtMTMwNyAgVVNBCisgKi8KKworI2luY2x1ZGUg
PGxpbnV4L2tlcm5lbC5oPgorI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgorI2luY2x1ZGUgPGxp
bnV4L3BsYXRmb3JtX2RldmljZS5oPgorI2luY2x1ZGUgPGxpbnV4L2kyYy5oPgorI2luY2x1ZGUg
PGxpbnV4L2lucHV0Lmg+CisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8
bGludXgvbWZkL21heDg5MjUuaD4KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CisKKyNkZWZpbmUg
SEFSRFJFU0VUX0VOCQkoMSA8PCA3KQorI2RlZmluZSBQV1JFTl9FTgkJKDEgPDwgNykKKworc3Ry
dWN0IG1heDg5MjVfb25rZXlfaW5mbyB7CisJc3RydWN0IGlucHV0X2RldgkqaWRldjsKKwlzdHJ1
Y3QgbWF4ODkyNV9jaGlwCSpjaGlwOworCXN0cnVjdCBpMmNfY2xpZW50CSppMmM7CisJc3RydWN0
IGRldmljZQkJKmRldjsKKwlpbnQJCQlpcnE7Cit9OworCisvKgorICogTUFYODkyNSBnaXZlcyB1
cyBhbiBpbnRlcnJ1cHQgd2hlbiBPTktFWSBpcyBoZWxkIGZvciAzIHNlY29uZHMuCisgKiBtYXg4
OTI1X3NldF9iaXRzKCkgb3BlcmF0ZXMgSTJDIGJ1cyBhbmQgbWF5IHNsZWVwLiBTbyBpbXBsZW1l
bnQKKyAqIGl0IGluIHRocmVhZCBJUlEgaGFuZGxlci4KKyAqLworc3RhdGljIGlycXJldHVybl90
IG1heDg5MjVfb25rZXlfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpkYXRhKQoreworCXN0cnVjdCBt
YXg4OTI1X29ua2V5X2luZm8gKmluZm8gPSBkYXRhOworCisJaW5wdXRfcmVwb3J0X2tleShpbmZv
LT5pZGV2LCBLRVlfUE9XRVIsIDEpOworCWlucHV0X3N5bmMoaW5mby0+aWRldik7CisKKwkvKiBF
bmFibGUgaGFyZHJlc2V0IHRvIGhhbHQgaWYgc3lzdGVtIGlzbid0IHNodXRkb3duIG9uIHRpbWUg
Ki8KKwltYXg4OTI1X3NldF9iaXRzKGluZm8tPmkyYywgTUFYODkyNV9TWVNFTlNFTCwKKwkJCSBI
QVJEUkVTRVRfRU4sIEhBUkRSRVNFVF9FTik7CisJcmV0dXJuIElSUV9IQU5ETEVEOworfQorCitz
dGF0aWMgaW50IF9fZGV2aW5pdCBtYXg4OTI1X29ua2V5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpCit7CisJc3RydWN0IG1heDg5MjVfY2hpcCAqY2hpcCA9IGRldl9nZXRfZHJ2
ZGF0YShwZGV2LT5kZXYucGFyZW50KTsKKwlzdHJ1Y3QgbWF4ODkyNV9vbmtleV9pbmZvICppbmZv
OworCWludCBpcnEsIHJldDsKKworCWluZm8gPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgbWF4ODky
NV9vbmtleV9pbmZvKSwgR0ZQX0tFUk5FTCk7CisJaWYgKCFpbmZvKQorCQlyZXR1cm4gLUVOT01F
TTsKKwlpbmZvLT5jaGlwID0gY2hpcDsKKwlpbmZvLT5pMmMgPSBjaGlwLT5pMmM7CisJaW5mby0+
ZGV2ID0gJnBkZXYtPmRldjsKKwlpcnEgPSBjaGlwLT5pcnFfYmFzZSArIE1BWDg5MjVfSVJRX0dQ
TV9TV18zU0VDOworCisJaW5mby0+aWRldiA9IGlucHV0X2FsbG9jYXRlX2RldmljZSgpOworCWlm
ICghaW5mby0+aWRldikgeworCQlkZXZfZXJyKGNoaXAtPmRldiwgIkZhaWxlZCB0byBhbGxvY2F0
ZSBpbnB1dCBkZXZcbiIpOworCQlyZXQgPSAtRU5PTUVNOworCQlnb3RvIG91dF9pbnB1dDsKKwl9
CisKKwlyZXQgPSByZXF1ZXN0X3RocmVhZGVkX2lycShpcnEsIE5VTEwsIG1heDg5MjVfb25rZXlf
aGFuZGxlciwKKwkJCQkgICBJUlFGX09ORVNIT1QsICJvbmtleSIsIGluZm8pOworCWlmIChyZXQg
PCAwKSB7CisJCWRldl9lcnIoY2hpcC0+ZGV2LCAiRmFpbGVkIHRvIHJlcXVlc3QgSVJROiAjJWQ6
ICVkXG4iLAorCQkJaXJxLCByZXQpOworCQlnb3RvIG91dF9pcnE7CisJfQorCisJaW5mby0+aWRl
di0+bmFtZSA9ICJtYXg4OTI1X29uIjsKKwlpbmZvLT5pZGV2LT5waHlzID0gIm1heDg5MjVfb24v
aW5wdXQwIjsKKwlpbmZvLT5pZGV2LT5pZC5idXN0eXBlID0gQlVTX0kyQzsKKwlpbmZvLT5pZGV2
LT5kZXYucGFyZW50ID0gJnBkZXYtPmRldjsKKwlpbmZvLT5pcnEgPSBpcnE7CisJaW5mby0+aWRl
di0+ZXZiaXRbMF0gPSBCSVRfTUFTSyhFVl9LRVkpOworCWluZm8tPmlkZXYtPmtleWJpdFtCSVRf
V09SRChLRVlfUE9XRVIpXSA9IEJJVF9NQVNLKEtFWV9QT1dFUik7CisKKwlyZXQgPSBpbnB1dF9y
ZWdpc3Rlcl9kZXZpY2UoaW5mby0+aWRldik7CisJaWYgKHJldCkgeworCQlkZXZfZXJyKGNoaXAt
PmRldiwgIkNhbid0IHJlZ2lzdGVyIGlucHV0IGRldmljZTogJWRcbiIsIHJldCk7CisJCWdvdG8g
b3V0OworCX0KKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBpbmZvKTsKKworCXJldHVybiAw
OworCitvdXQ6CisJZnJlZV9pcnEoaW5mby0+aXJxLCBpbmZvKTsKK291dF9pcnE6CisJaW5wdXRf
ZnJlZV9kZXZpY2UoaW5mby0+aWRldik7CitvdXRfaW5wdXQ6CisJa2ZyZWUoaW5mbyk7CisJcmV0
dXJuIHJldDsKK30KKworc3RhdGljIGludCBfX2RldmV4aXQgbWF4ODkyNV9vbmtleV9yZW1vdmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKK3sKKwlzdHJ1Y3QgbWF4ODkyNV9vbmtleV9p
bmZvICppbmZvID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7CisKKwlmcmVlX2lycShpbmZv
LT5pcnEsIGluZm8pOworCWlucHV0X3VucmVnaXN0ZXJfZGV2aWNlKGluZm8tPmlkZXYpOworCWtm
cmVlKGluZm8pOworCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIE5VTEwpOworCXJldHVybiAw
OworfQorCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtYXg4OTI1X29ua2V5X2RyaXZl
ciA9IHsKKwkuZHJpdmVyCQk9IHsKKwkJLm5hbWUJPSAibWF4ODkyNS1vbmtleSIsCisJCS5vd25l
cgk9IFRISVNfTU9EVUxFLAorCX0sCisJLnByb2JlCQk9IG1heDg5MjVfb25rZXlfcHJvYmUsCisJ
LnJlbW92ZQkJPSBfX2RldmV4aXRfcChtYXg4OTI1X29ua2V5X3JlbW92ZSksCit9OworCitzdGF0
aWMgaW50IF9faW5pdCBtYXg4OTI1X29ua2V5X2luaXQodm9pZCkKK3sKKwlyZXR1cm4gcGxhdGZv
cm1fZHJpdmVyX3JlZ2lzdGVyKCZtYXg4OTI1X29ua2V5X2RyaXZlcik7Cit9Cittb2R1bGVfaW5p
dChtYXg4OTI1X29ua2V5X2luaXQpOworCitzdGF0aWMgdm9pZCBfX2V4aXQgbWF4ODkyNV9vbmtl
eV9leGl0KHZvaWQpCit7CisJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJm1heDg5MjVfb25r
ZXlfZHJpdmVyKTsKK30KK21vZHVsZV9leGl0KG1heDg5MjVfb25rZXlfZXhpdCk7CisKK01PRFVM
RV9ERVNDUklQVElPTigiTWF4aW0gTUFYODkyNSBPTktFWSBkcml2ZXIiKTsKK01PRFVMRV9BVVRI
T1IoIkhhb2ppYW4gWmh1YW5nIDxoYW9qaWFuLnpodWFuZ0BtYXJ2ZWxsLmNvbT4iKTsKK01PRFVM
RV9MSUNFTlNFKCJHUEwiKTsKLS0gCjEuNS42LjUKCg==
--001636e0a70fa0bfc90486fcbf3f--
