From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 8 Mar 2010 11:28:43 -0500
Subject: [PATCH] input: enable onkey driver of max8925
Message-ID: <mailman.460.1274252292.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/input/misc/Kconfig         |   10 +++
 drivers/input/misc/Makefile        |    1 +
 drivers/input/misc/max8925_onkey.c |  145 ++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 0 deletions(-)
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
@@ -17,6 +17,7 @@ obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
 obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
+obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
 obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o
 obj-$(CONFIG_INPUT_PCF50633_PMU)	+= pcf50633-input.o
 obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
diff --git a/drivers/input/misc/max8925_onkey.c
b/drivers/input/misc/max8925_onkey.c
new file mode 100644
index 0000000..b81d6ac
--- /dev/null
+++ b/drivers/input/misc/max8925_onkey.c
@@ -0,0 +1,145 @@
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
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
+/* MAX8925 gives us an interrupt when ONKEY is held for 3 seconds. */
+static irqreturn_t max8925_onkey_handler(int irq, void *data)
+{
+	struct max8925_onkey_info *info = data;
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
+	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct max8925_onkey_info *info;
+	int irq, ret;
+
+	info = kzalloc(sizeof(struct max8925_onkey_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->chip = chip;
+	info->i2c = chip->i2c;
+	info->dev = &pdev->dev;
+	irq = chip->irq_base + MAX8925_IRQ_GPM_SW_3SEC;
+
+	ret = request_threaded_irq(irq, NULL, max8925_onkey_handler,
+				   IRQF_ONESHOT, "onkey", info);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			irq, ret);
+		goto out;
+	}
+
+	info->idev = input_allocate_device();
+	if (!info->idev) {
+		dev_err(chip->dev, "Failed to allocate input dev\n");
+		ret = -ENOMEM;
+		goto out_input;
+	}
+
+	info->idev->name = "max8925_on";
+	info->idev->phys = "max8925_on/input0";
+	info->idev->id.bustype = BUS_I2C;
+	info->idev->dev.parent = &pdev->dev;
+	info->irq = irq;
+	info->idev->evbit[0] = BIT_MASK(EV_KEY);
+	info->idev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
+
+	ret = input_register_device(info->idev);
+	if (ret) {
+		dev_err(chip->dev, "Can't register input device: %d\n", ret);
+		goto out_reg;
+	}
+	platform_set_drvdata(pdev, info);
+
+	return 0;
+
+out_reg:
+	input_free_device(info->idev);
+out_input:
+	free_irq(info->irq, info);
+out:
+	kfree(info);
+	return ret;
+}
+
+static int __devexit max8925_onkey_remove(struct platform_device *pdev)
+{
+	struct max8925_onkey_info *info = platform_get_drvdata(pdev);
+
+	if (info) {
+		free_irq(info->irq, info);
+		input_unregister_device(info->idev);
+		kfree(info);
+	}
+	return 0;
+}
+
+static struct platform_driver max8925_onkey_driver = {
+	.driver		= {
+		.name	= "max8925-onkey",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= max8925_onkey_probe,
+	.remove		= __devexit_p(max8925_onkey_remove),
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
-- 
1.5.6.5
