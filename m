From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue,  8 Dec 2009 16:39:12 +0100
Subject: [PATCH] Driver for the watchdog timer on all Freescale IMX processors.
Message-ID: <1260286752-8796-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
---

Changes since the last version from Darius:

* removed all #ifdef CONFIG_ARCH_* and handle the differences at runtime
* simplified house-keeping of the timeout value and fixed the conversion
  into the corresponding register value
* removed a superfluous static platform-device
* removed debug output and comments with (IMHO) little information
* cleaned up #includes
* fixed some typos & removed unnecessary tabs & added kernel coding style
* probably something else...

 drivers/watchdog/Kconfig   |   12 ++
 drivers/watchdog/Makefile  |    1 +
 drivers/watchdog/imx_wdt.c |  342 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 355 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/imx_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3711b88..964cfc4 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -73,6 +73,18 @@ config WM8350_WATCHDOG
 
 # ARM Architecture
 
+config IMX_WDT
+	tristate "IMX Watchdog"
+	depends on ARCH_MXC
+	help
+	  This is the driver for the hardware watchdog
+	  on the Freescale IMX processors.
+	  If you have one of these processors and wish to have
+	  watchdog support enabled, say Y, otherwise say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx_wdt.
+
 config AT91RM9200_WATCHDOG
 	tristate "AT91RM9200 watchdog"
 	depends on ARCH_AT91RM9200
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 699199b..b77df3f 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
 obj-$(CONFIG_STMP3XXX_WATCHDOG) += stmp3xxx_wdt.o
 obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
 obj-$(CONFIG_ADX_WATCHDOG) += adx_wdt.o
+obj-$(CONFIG_IMX_WDT) += imx_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/imx_wdt.c b/drivers/watchdog/imx_wdt.c
new file mode 100644
index 0000000..759680e
--- /dev/null
+++ b/drivers/watchdog/imx_wdt.c
@@ -0,0 +1,342 @@
+/*
+ * Watchdog driver for IMX processors
+ *
+ *  Copyright (C) 2008 Darius Augulis <augulis.darius@gmail.com>
+ *  Copyright (C) 2009 Wolfram Sang <w.sang@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * NOTE: MX1 has a slightly different Watchdog than MX2 and MX3. It is not
+ * possible to turn off the watchdog on MX2 or MX3 once it's enabled. Thus,
+ * timeout changing with IOCTL command is possible only on MX1. WD timer
+ * halting during suspend is implemented in all archs but in different ways.
+ *
+ * MX2 and MX3 have 16 bit watchdog registers compared to 32 bit on MX1.
+ * The layout is the same, so the offsets are corrected on the fly.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+#include <linux/clk.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+#include <mach/hardware.h>
+
+#define IMX_WDT_WCR		0x00		/* Control reg */
+#define IMX_WDT1_WCR_WDE		(1 << 0)
+#define IMX_WDT1_WCR_WDEC		(1 << 1)
+#define IMX_WDT1_WCR_WHALT		(1 << 15)
+#define IMX_WDT2_WCR_WDZST		(1 << 0)
+#define IMX_WDT2_WCR_WDE		(1 << 2)
+#define IMX_WDT_WSR		0x02		/* Service reg */
+
+#define IMX_WDT1_MAX_TIME	64
+#define IMX_WDT2_MAX_TIME	128
+#define IMX_WDT_DEFAULT_TIME	10		/* in seconds */
+#define IMX_WDT_SEQ1		0x5555
+#define IMX_WDT_SEQ2		0xAAAA
+
+struct imx_wdt_struct {
+	struct resource *res;
+	struct device *dev;
+	struct clk *clk;
+	void __iomem *base;
+	unsigned timeout;
+	unsigned long status;
+};
+
+static struct imx_wdt_struct imx_wdt;
+
+static unsigned timeout = IMX_WDT_DEFAULT_TIME;
+module_param(timeout, uint, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds");
+
+static struct watchdog_info imx1_wdt_info = {
+	.identity = "imx1 watchdog",
+	.firmware_version = 1,
+	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+};
+
+static struct watchdog_info imx2_wdt_info = {
+	.identity = "imx2+ watchdog",
+	.firmware_version = 2,
+	.options = WDIOF_KEEPALIVEPING,
+};
+
+static void imx_wdt_ping(struct imx_wdt_struct *imx_wdt)
+{
+	unsigned offset = IMX_WDT_WSR << (cpu_is_mx1() ? 1 : 0);
+	__raw_writew(IMX_WDT_SEQ1, imx_wdt->base + offset);
+	__raw_writew(IMX_WDT_SEQ2, imx_wdt->base + offset);
+}
+
+static void imx_wdt_stop(struct imx_wdt_struct *imx_wdt)
+{
+	if (cpu_is_mx1())
+		__raw_writew(0, imx_wdt->base + IMX_WDT_WCR);
+	else
+		dev_warn(imx_wdt->dev, "watchdog cannot be stopped!\n");
+}
+
+static void imx_wdt_start(struct imx_wdt_struct *imx_wdt)
+{
+	u16 val = __raw_readw(imx_wdt->base + IMX_WDT_WCR);
+
+	/* clears also IMX_WDT1_WCR_WHALT on IMX1 */
+	val = (val & 0x00ff) | ((imx_wdt->timeout * 2 - 1) << 8);
+	__raw_writew(val, imx_wdt->base + IMX_WDT_WCR);
+
+	if (cpu_is_mx1()) {
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+		val |= IMX_WDT1_WCR_WDEC;
+#endif
+		val |= IMX_WDT1_WCR_WDE;
+	} else {
+		val |= IMX_WDT2_WCR_WDE | IMX_WDT2_WCR_WDZST;
+	}
+
+	__raw_writew(val, imx_wdt->base + IMX_WDT_WCR);
+}
+
+static int imx_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(0, &imx_wdt.status))
+		return -EBUSY;
+
+	file->private_data = &imx_wdt;
+
+	imx_wdt_start(&imx_wdt);
+	return nonseekable_open(inode, file);
+}
+
+static int imx_wdt_close(struct inode *inode, struct file *file)
+{
+	struct imx_wdt_struct *imx_wdt = file->private_data;
+
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	/* Disable the watchdog if possible */
+	imx_wdt_stop(imx_wdt);
+#endif
+	clear_bit(0, &imx_wdt->status);
+	return 0;
+}
+
+static int imx_wdt_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	struct imx_wdt_struct *imx_wdt = file->private_data;
+	struct watchdog_info *info;
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	int new_value;
+
+	switch (cmd) {
+	case WDIOC_KEEPALIVE:
+		imx_wdt_ping(imx_wdt);
+		return 0;
+
+	case WDIOC_GETSUPPORT:
+		info = cpu_is_mx1() ? &imx1_wdt_info : &imx2_wdt_info;
+		return copy_to_user(argp, info,
+			sizeof(struct watchdog_info)) ? -EFAULT : 0;
+
+	case WDIOC_SETTIMEOUT:
+		if (!cpu_is_mx1())
+			return -ENOTTY;
+		if (get_user(new_value, p))
+			return -EFAULT;
+		if ((new_value < 1) || (new_value > IMX_WDT1_MAX_TIME))
+			return -EINVAL;
+
+		imx_wdt->timeout = new_value;
+		imx_wdt_start(imx_wdt);
+
+		/* Fallthrough to return current value */
+	case WDIOC_GETTIMEOUT:
+		return put_user(imx_wdt->timeout, p);
+
+	default:
+		return -ENOTTY;
+	}
+}
+
+static ssize_t imx_wdt_write(struct file *file, const char *data,
+						size_t len, loff_t *ppos)
+{
+	struct imx_wdt_struct *imx_wdt = file->private_data;
+
+	imx_wdt_ping(imx_wdt);
+	return len;
+}
+
+static const struct file_operations imx_wdt_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.ioctl = imx_wdt_ioctl,
+	.open = imx_wdt_open,
+	.release = imx_wdt_close,
+	.write = imx_wdt_write,
+};
+
+static struct miscdevice imx_wdt_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name = "watchdog",
+	.fops = &imx_wdt_fops,
+};
+
+static void imx_wdt_shutdown(struct platform_device *pdev)
+{
+	struct imx_wdt_struct *imx_wdt = platform_get_drvdata(pdev);
+
+	imx_wdt_stop(imx_wdt);
+}
+
+static int __init imx_wdt_probe(struct platform_device *pdev)
+{
+	int ret;
+	int res_size;
+	struct resource *res;
+	void __iomem *base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "can't get device resources\n");
+		return -ENODEV;
+	}
+
+	res_size = resource_size(res);
+	if (!request_mem_region(res->start, res_size, res->name)) {
+		dev_err(&pdev->dev, "can't allocate %d bytes at %d address\n",
+			res_size, res->start);
+		return -ENOMEM;
+	}
+
+	base = ioremap(res->start, res_size);
+	if (!base) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		ret = -EIO;
+		goto fail0;
+	}
+
+	imx_wdt.clk = clk_get(&pdev->dev, "wdog_clk");
+	if (IS_ERR(imx_wdt.clk)) {
+		dev_err(&pdev->dev, "can't get Watchdog clock\n");
+		ret = PTR_ERR(imx_wdt.clk);
+		goto fail2;
+	}
+	clk_enable(imx_wdt.clk);
+
+	imx_wdt.dev = &pdev->dev;
+	imx_wdt.base = base;
+	imx_wdt.res = res;
+	imx_wdt.timeout = clamp_t(unsigned, timeout, 1,
+		cpu_is_mx1() ? IMX_WDT1_MAX_TIME : IMX_WDT2_MAX_TIME);
+
+	platform_set_drvdata(pdev, &imx_wdt);
+
+	if (imx_wdt_miscdev.parent) {
+		ret = -EBUSY;
+		goto fail3;
+	}
+	imx_wdt_miscdev.parent = &pdev->dev;
+
+	ret = misc_register(&imx_wdt_miscdev);
+	if (ret)
+		goto fail3;
+
+	dev_info(&pdev->dev, "IMX Watchdog Timer enabled\n");
+	return 0;
+
+fail3:
+	clk_disable(imx_wdt.clk);
+	clk_put(imx_wdt.clk);
+fail2:
+	platform_set_drvdata(pdev, NULL);
+	iounmap(base);
+fail0:
+	release_mem_region(res->start, res_size);
+
+	return ret;
+}
+
+static int __exit imx_wdt_remove(struct platform_device *pdev)
+{
+	struct imx_wdt_struct *imx_wdt = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+	misc_deregister(&imx_wdt_miscdev);
+	iounmap(imx_wdt->base);
+	release_mem_region(imx_wdt->res->start,	resource_size(imx_wdt->res));
+	clk_disable(imx_wdt->clk);
+	clk_put(imx_wdt->clk);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+/* Those are only needed for IMX1, other variants do this in hardware */
+static int imx_wdt_suspend(struct platform_device *pdev, pm_message_t message)
+{
+	struct imx_wdt_struct *imx_wdt = platform_get_drvdata(pdev);
+
+	u32 temp = __raw_readw(imx_wdt->base + IMX_WDT_WCR);
+	__raw_writew(temp | IMX_WDT1_WCR_WHALT, imx_wdt->base + IMX_WDT_WCR);
+
+	return 0;
+}
+
+static int imx_wdt_resume(struct platform_device *pdev)
+{
+	struct imx_wdt_struct *imx_wdt = platform_get_drvdata(pdev);
+	u32 temp;
+
+	if (imx_wdt->status) {
+		temp = __raw_readw(imx_wdt->base + IMX_WDT_WCR);
+		__raw_writew(temp & ~IMX_WDT1_WCR_WHALT,
+				imx_wdt->base + IMX_WDT_WCR);
+	}
+
+	return 0;
+}
+#endif
+
+static struct platform_driver imx_wdt_driver = {
+	.probe		= imx_wdt_probe,
+	.remove		= __exit_p(imx_wdt_remove),
+	.shutdown	= imx_wdt_shutdown,
+	.driver		= {
+		.name	= "imx_wdt",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init imx_wdt_init(void)
+{
+#ifdef CONFIG_PM
+	if (cpu_is_mx1()) {
+		imx_wdt_driver.suspend = imx_wdt_suspend;
+		imx_wdt_driver.resume = imx_wdt_resume;
+	}
+#endif
+	return platform_driver_probe(&imx_wdt_driver, imx_wdt_probe);
+}
+module_init(imx_wdt_init);
+
+static void __exit imx_wdt_exit(void)
+{
+	platform_driver_unregister(&imx_wdt_driver);
+}
+module_exit(imx_wdt_exit);
+
+MODULE_AUTHOR("Darius Augulis, Wolfram Sang");
+MODULE_DESCRIPTION("Watchdog driver for IMX");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+MODULE_ALIAS("platform:imx_wdt");
-- 
1.6.3.3
