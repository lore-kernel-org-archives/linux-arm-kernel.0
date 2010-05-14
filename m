From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 14 May 2010 04:49:15 +0200
Subject: [PATCH 1/6] Driver for the watchdog timer on Freescale IMX2
	(and later) processors.
In-Reply-To: <1272528202-24159-2-git-send-email-w.sang@pengutronix.de>
References: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
	<1272528202-24159-2-git-send-email-w.sang@pengutronix.de>
Message-ID: <20100514024915.GE30794@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 10:03:17AM +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Ping. Wim, did you notice this one? Shall the driver go via your tree or via
the imx-tree along with the resource updates (with your ack)?

> ---
>  drivers/watchdog/Kconfig    |   12 ++
>  drivers/watchdog/Makefile   |    1 +
>  drivers/watchdog/imx2_wdt.c |  279 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 292 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/watchdog/imx2_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0e8468f..b24baec 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -306,6 +306,18 @@ config MAX63XX_WATCHDOG
>  	help
>  	  Support for memory mapped max63{69,70,71,72,73,74} watchdog timer.
>  
> +config IMX2_WDT
> +	tristate "IMX2+ Watchdog"
> +	depends on ARCH_MX2 || ARCH_MX25 || ARCH_MX3 || ARCH_MX5
> +	help
> +	  This is the driver for the hardware watchdog
> +	  on the Freescale IMX2 and later processors.
> +	  If you have one of these processors and wish to have
> +	  watchdog support enabled, say Y, otherwise say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called imx2_wdt.
> +
>  # AVR32 Architecture
>  
>  config AT32AP700X_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 5e3cb95..72f3e20 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_STMP3XXX_WATCHDOG) += stmp3xxx_wdt.o
>  obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
>  obj-$(CONFIG_ADX_WATCHDOG) += adx_wdt.o
>  obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
> +obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
>  
>  # AVR32 Architecture
>  obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> new file mode 100644
> index 0000000..980aa2e
> --- /dev/null
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -0,0 +1,279 @@
> +/*
> + * Watchdog driver for IMX2 and later processors
> + *
> + *  Copyright (C) 2010 Wolfram Sang, Pengutronix e.K. <w.sang@pengutronix.de>
> + *
> + * some parts adapted by similar drivers from Darius Augulis and Vladimir
> + * Zapolskiy.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * NOTE: MX1 has a slightly different Watchdog than MX2 and later:
> + *
> + *			MX1:		MX2+:
> + *			----		-----
> + * Registers:		32-bit		16-bit
> + * Stopable timer:	Yes		No
> + * Need to enable clk:	No		Yes
> + * Halt on suspend:	Manual		Can be automatic
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <linux/clk.h>
> +#include <linux/fs.h>
> +#include <linux/io.h>
> +#include <linux/uaccess.h>
> +#include <linux/timer.h>
> +#include <linux/jiffies.h>
> +#include <mach/hardware.h>
> +
> +#define DRIVER_NAME "imx2-wdt"
> +
> +#define IMX2_WDT_WCR		0x00		/* Control reg */
> +#define IMX2_WDT_WCR_WDZST	(1 << 0)
> +#define IMX2_WDT_WCR_WDE	(1 << 2)
> +#define IMX2_WDT_WSR		0x02		/* Service reg */
> +
> +#define IMX2_WDT_MAX_TIME	128
> +#define IMX2_WDT_DEFAULT_TIME	60		/* in seconds */
> +#define IMX2_WDT_SEQ1		0x5555
> +#define IMX2_WDT_SEQ2		0xAAAA
> +
> +#define IMX2_WDT_STATUS_OPEN	0
> +#define IMX2_WDT_STATUS_STARTED	1
> +
> +static struct {
> +	struct clk *clk;
> +	void __iomem *base;
> +	unsigned timeout;
> +	unsigned long status;
> +	struct timer_list timer;	/* Pings the watchdog when closed */
> +} imx2_wdt;
> +
> +static struct miscdevice imx2_wdt_miscdev;
> +
> +static int nowayout = WATCHDOG_NOWAYOUT;
> +
> +static unsigned timeout = IMX2_WDT_DEFAULT_TIME;
> +module_param(timeout, uint, 0);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds");
> +
> +static const struct watchdog_info imx2_wdt_info = {
> +	.identity = "imx2+ watchdog",
> +	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
> +};
> +
> +static void imx2_wdt_ping(void)
> +{
> +	__raw_writew(IMX2_WDT_SEQ1, imx2_wdt.base + IMX2_WDT_WSR);
> +	__raw_writew(IMX2_WDT_SEQ2, imx2_wdt.base + IMX2_WDT_WSR);
> +}
> +
> +static void imx2_wdt_timer_ping(unsigned long arg)
> +{
> +	imx2_wdt_ping();
> +	mod_timer(&imx2_wdt.timer, jiffies + imx2_wdt.timeout * HZ / 2);
> +}
> +
> +static void imx2_wdt_setup(void)
> +{
> +	u16 val = __raw_readw(imx2_wdt.base + IMX2_WDT_WCR);
> +
> +	val = (val & 0x00ff) | ((imx2_wdt.timeout * 2 - 1) << 8);
> +	val |= IMX2_WDT_WCR_WDE;
> +	__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
> +	imx2_wdt_ping();
> +}
> +
> +static int imx2_wdt_open(struct inode *inode, struct file *file)
> +{
> +	if (test_and_set_bit(IMX2_WDT_STATUS_OPEN, &imx2_wdt.status))
> +		return -EBUSY;
> +
> +	clk_enable(imx2_wdt.clk);
> +	imx2_wdt_setup();
> +	del_timer_sync(&imx2_wdt.timer);
> +	set_bit(IMX2_WDT_STATUS_STARTED, &imx2_wdt.status);
> +	return nonseekable_open(inode, file);
> +}
> +
> +static int imx2_wdt_close(struct inode *inode, struct file *file)
> +{
> +	/* no clk_disable. it cannot be disabled once started */
> +	clear_bit(IMX2_WDT_STATUS_OPEN, &imx2_wdt.status);
> +	if (nowayout)
> +		dev_crit(imx2_wdt_miscdev.parent,
> +			"Device closed: Expect reboot!\n");
> +	else
> +		imx2_wdt_timer_ping(0);
> +
> +	return 0;
> +}
> +
> +static int imx2_wdt_ioctl(struct inode *inode, struct file *file,
> +		unsigned int cmd, unsigned long arg)
> +{
> +	void __user *argp = (void __user *)arg;
> +	int __user *p = argp;
> +	int new_value;
> +
> +	switch (cmd) {
> +	case WDIOC_KEEPALIVE:
> +		imx2_wdt_ping();
> +		return 0;
> +
> +	case WDIOC_GETSUPPORT:
> +		return copy_to_user(argp, &imx2_wdt_info,
> +			sizeof(struct watchdog_info)) ? -EFAULT : 0;
> +
> +	case WDIOC_SETTIMEOUT:
> +		if (get_user(new_value, p))
> +			return -EFAULT;
> +		if ((new_value < 1) || (new_value > IMX2_WDT_MAX_TIME))
> +			return -EINVAL;
> +
> +		imx2_wdt.timeout = new_value;
> +		imx2_wdt_setup();
> +
> +		/* Fallthrough to return current value */
> +	case WDIOC_GETTIMEOUT:
> +		return put_user(imx2_wdt.timeout, p);
> +
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
> +static ssize_t imx2_wdt_write(struct file *file, const char *data,
> +						size_t len, loff_t *ppos)
> +{
> +	if (len)
> +		imx2_wdt_ping();
> +	return len;
> +}
> +
> +static const struct file_operations imx2_wdt_fops = {
> +	.owner = THIS_MODULE,
> +	.llseek = no_llseek,
> +	.ioctl = imx2_wdt_ioctl,
> +	.open = imx2_wdt_open,
> +	.release = imx2_wdt_close,
> +	.write = imx2_wdt_write,
> +};
> +
> +static struct miscdevice imx2_wdt_miscdev = {
> +	.minor = WATCHDOG_MINOR,
> +	.name = "watchdog",
> +	.fops = &imx2_wdt_fops,
> +};
> +
> +static void imx2_wdt_shutdown(struct platform_device *pdev)
> +{
> +	del_timer_sync(&imx2_wdt.timer);
> +	if (test_bit(IMX2_WDT_STATUS_STARTED, &imx2_wdt.status))
> +		dev_crit(imx2_wdt_miscdev.parent,
> +			"Device shutdown: Expect reboot!\n");
> +}
> +
> +static int __devinit imx2_wdt_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	int res_size;
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "can't get device resources\n");
> +		return -ENODEV;
> +	}
> +
> +	res_size = resource_size(res);
> +	if (!devm_request_mem_region(&pdev->dev, res->start, res_size,
> +		res->name)) {
> +		dev_err(&pdev->dev, "can't allocate %d bytes at %d address\n",
> +			res_size, res->start);
> +		return -ENOMEM;
> +	}
> +
> +	imx2_wdt.base = devm_ioremap_nocache(&pdev->dev, res->start, res_size);
> +	if (!imx2_wdt.base) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	imx2_wdt.clk = clk_get_sys("imx-wdt.0", NULL);
> +	if (IS_ERR(imx2_wdt.clk)) {
> +		dev_err(&pdev->dev, "can't get Watchdog clock\n");
> +		return PTR_ERR(imx2_wdt.clk);
> +	}
> +
> +	imx2_wdt.timeout = clamp_t(unsigned, timeout, 1, IMX2_WDT_MAX_TIME);
> +	if (imx2_wdt.timeout != timeout)
> +		dev_warn(&pdev->dev, "Initial timeout out of range! "
> +			"Clamped from %u to %u\n", timeout, imx2_wdt.timeout);
> +
> +	imx2_wdt_miscdev.parent = &pdev->dev;
> +	ret = misc_register(&imx2_wdt_miscdev);
> +	if (ret)
> +		goto fail;
> +
> +	setup_timer(&imx2_wdt.timer, imx2_wdt_timer_ping, 0);
> +	dev_info(&pdev->dev, "IMX2+ Watchdog Timer enabled\n");
> +	return 0;
> +
> +fail:
> +	imx2_wdt_miscdev.parent = NULL;
> +	clk_put(imx2_wdt.clk);
> +	return ret;
> +}
> +
> +static int __devexit imx2_wdt_remove(struct platform_device *pdev)
> +{
> +	del_timer_sync(&imx2_wdt.timer);
> +	misc_deregister(&imx2_wdt_miscdev);
> +	imx2_wdt_miscdev.parent = NULL;
> +
> +	if (test_bit(IMX2_WDT_STATUS_STARTED, &imx2_wdt.status))
> +		dev_crit(imx2_wdt_miscdev.parent,
> +			"Device removed: Expect reboot!\n");
> +	else
> +		clk_put(imx2_wdt.clk);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver imx2_wdt_driver = {
> +	.probe		= imx2_wdt_probe,
> +	.remove		= __devexit_p(imx2_wdt_remove),
> +	.shutdown	= imx2_wdt_shutdown,
> +	.driver		= {
> +		.name	= DRIVER_NAME,
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init imx2_wdt_init(void)
> +{
> +	return platform_driver_probe(&imx2_wdt_driver, imx2_wdt_probe);
> +}
> +module_init(imx2_wdt_init);
> +
> +static void __exit imx2_wdt_exit(void)
> +{
> +	platform_driver_unregister(&imx2_wdt_driver);
> +}
> +module_exit(imx2_wdt_exit);
> +
> +MODULE_AUTHOR("Wolfram Sang");
> +MODULE_DESCRIPTION("Watchdog driver for IMX2 and later");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> -- 
> 1.7.0
> 

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100514/ebd6a81e/attachment.sig>
