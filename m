From: zhouqiao@marvell.com (Qiao Zhou)
Date: Thu, 28 Jun 2012 11:13:34 +0800
Subject: [PATCH 3/3] input: add onkey support to 88PM80X PMIC
In-Reply-To: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
Message-ID: <1340853214-5429-4-git-send-email-zhouqiao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add onkey support to MARVELL 88PM80X PMIC.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 drivers/input/misc/88pm80x_onkey.c |  194 ++++++++++++++++++++++++++++++++++++
 drivers/input/misc/Kconfig         |   10 ++
 drivers/input/misc/Makefile        |    1 +
 3 files changed, 205 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/88pm80x_onkey.c

diff --git a/drivers/input/misc/88pm80x_onkey.c b/drivers/input/misc/88pm80x_onkey.c
new file mode 100644
index 0000000..091bcf9
--- /dev/null
+++ b/drivers/input/misc/88pm80x_onkey.c
@@ -0,0 +1,194 @@
+/*
+ * 88pm80x_onkey.c - Marvell 88PM80x ONKEY driver
+ *
+ * Copyright (C) 2012 Marvell International Ltd.
+ * Haojian Zhuang <haojian.zhuang@marvell.com>
+ * Qiao Zhou <zhouqiao@marvell.com>
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
+#include <linux/mfd/88pm80x.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define PM800_LONG_ONKEY_EN		(1 << 0)
+#define PM800_LONG_KEY_DELAY		(8)	/* 1 .. 16 seconds */
+#define PM800_LONKEY_PRESS_TIME		((PM800_LONG_KEY_DELAY-1) << 4)
+#define PM800_LONKEY_PRESS_TIME_MASK	(0xF0)
+#define PM800_SW_PDOWN			(1 << 5)
+
+struct pm80x_onkey_info {
+	struct input_dev *idev;
+	struct pm80x_chip *pm80x;
+	struct i2c_client *i2c;
+	struct regmap *map;
+	int irq;
+};
+
+/* 88PM80x gives us an interrupt when ONKEY is held */
+static irqreturn_t pm80x_onkey_handler(int irq, void *data)
+{
+	struct pm80x_onkey_info *info = data;
+	int ret = 0;
+
+	regmap_read(info->map, PM800_STATUS_1, &ret);
+	ret &= PM800_ONKEY_STS1;
+
+	input_report_key(info->idev, KEY_POWER, ret);
+	input_sync(info->idev);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_PM
+static int pm80x_onkey_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+
+	if (device_may_wakeup(dev))
+		chip->wu_flag |= (1 << PM800_IRQ_ONKEY);
+
+	return 0;
+}
+
+static int pm80x_onkey_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+
+	if (device_may_wakeup(dev))
+		chip->wu_flag &= ~(1 << PM800_IRQ_ONKEY);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_onkey_suspend,
+			 pm80x_onkey_resume);
+
+static int __devinit pm80x_onkey_probe(struct platform_device *pdev)
+{
+
+	void *chip = dev_get_drvdata(pdev->dev.parent);
+	struct pm80x_onkey_info *info;
+	int ret;
+
+	info =
+	    devm_kzalloc(&pdev->dev, sizeof(struct pm80x_onkey_info),
+			 GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->pm80x = (struct pm80x_chip *)chip;
+	info->i2c = info->pm80x->client;
+
+	info->irq = platform_get_irq(pdev, 0);
+	if (info->irq < 0) {
+		dev_err(&pdev->dev, "No IRQ resource!\n");
+		return -EINVAL;
+	}
+
+
+	info->map = dev_get_regmap(&info->i2c->dev, NULL);
+	if (!info->map) {
+		dev_err(&pdev->dev, "no regmap!\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	info->idev = input_allocate_device();
+	if (!info->idev) {
+		dev_err(&pdev->dev, "Failed to allocate input dev\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	info->idev->name = "88pm80x_on";
+	info->idev->phys = "88pm80x_on/input0";
+	info->idev->id.bustype = BUS_I2C;
+	info->idev->dev.parent = &pdev->dev;
+	info->idev->evbit[0] = BIT_MASK(EV_KEY);
+	info->idev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
+
+	ret = input_register_device(info->idev);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't register input device: %d\n", ret);
+		goto out_reg;
+	}
+
+	ret = request_threaded_irq(info->irq, NULL, pm80x_onkey_handler,
+				   IRQF_ONESHOT, "onkey", info);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to request IRQ: #%d: %d\n",
+			info->irq, ret);
+		goto out_irq;
+	}
+
+	platform_set_drvdata(pdev, info);
+
+	/* Enable long onkey detection */
+	regmap_update_bits(info->map, PM800_RTC_MISC4, PM800_LONG_ONKEY_EN,
+			   PM800_LONG_ONKEY_EN);
+	/* Set 8-second interval */
+	regmap_update_bits(info->map, PM800_RTC_MISC3,
+			   PM800_LONKEY_PRESS_TIME_MASK,
+			   PM800_LONKEY_PRESS_TIME);
+
+	device_init_wakeup(&pdev->dev, 1);
+	return 0;
+
+out_irq:
+	input_unregister_device(info->idev);
+out_reg:
+	input_free_device(info->idev);
+out:
+	devm_kfree(&pdev->dev, info);
+	return ret;
+}
+
+static int __devexit pm80x_onkey_remove(struct platform_device *pdev)
+{
+	struct pm80x_onkey_info *info = platform_get_drvdata(pdev);
+
+	free_irq(info->irq, info);
+	input_unregister_device(info->idev);
+	input_free_device(info->idev);
+	devm_kfree(&pdev->dev, info);
+	return 0;
+}
+
+static struct platform_driver pm80x_onkey_driver = {
+	.driver = {
+		   .name = "88pm80x-onkey",
+		   .owner = THIS_MODULE,
+		   .pm = &pm80x_onkey_pm_ops,
+		   },
+	.probe = pm80x_onkey_probe,
+	.remove = __devexit_p(pm80x_onkey_remove),
+};
+
+module_platform_driver(pm80x_onkey_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Marvell 88PM80x ONKEY driver");
+MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
+MODULE_ALIAS("platform:88pm80x-onkey");
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 7faf4a7..8205a66 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -22,6 +22,16 @@ config INPUT_88PM860X_ONKEY
 	  To compile this driver as a module, choose M here: the module
 	  will be called 88pm860x_onkey.
 
+config INPUT_88PM80X_ONKEY
+	tristate "88PM80x ONKEY support"
+	depends on MFD_88PM80X
+	help
+	  Support the ONKEY of Marvell 88PM80x PMICs as an input device
+	  reporting power button status.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called 88pm80x_onkey.
+
 config INPUT_AB8500_PONKEY
 	tristate "AB8500 Pon (PowerOn) Key"
 	depends on AB8500_CORE
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index f55cdf4..83fe6f5 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -5,6 +5,7 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_INPUT_88PM860X_ONKEY)	+= 88pm860x_onkey.o
+obj-$(CONFIG_INPUT_88PM80X_ONKEY)	+= 88pm80x_onkey.o
 obj-$(CONFIG_INPUT_AB8500_PONKEY)	+= ab8500-ponkey.o
 obj-$(CONFIG_INPUT_AD714X)		+= ad714x.o
 obj-$(CONFIG_INPUT_AD714X_I2C)		+= ad714x-i2c.o
-- 
1.7.0.4
