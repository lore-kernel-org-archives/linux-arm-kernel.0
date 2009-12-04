From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 4 Dec 2009 12:13:35 -0500
Subject: [PATCH 1/2] ep93xx: implemented watchdog timer driver for TS-72xx
	SBCs
In-Reply-To: <3518ebf38d7a0038262cd20beb5283198e99e22e.1259866661.git.mika.westerberg@iki.fi>
References: <cover.1259866661.git.mika.westerberg@iki.fi>
	<3518ebf38d7a0038262cd20beb5283198e99e22e.1259866661.git.mika.westerberg@iki.fi>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901FB06C5@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 03, 2009 12:35 PM, Mika Westerberg wrote:
> Technologic Systems TS-72xx SBCs have external glue logic
> CPLD which includes watchdog timer. This driver implements
> kernel support for that.

Hello Mika,

A couple comments in addition to the ones Ryan already mentioned.

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> ---
>  drivers/watchdog/Kconfig      |   11 +
>  drivers/watchdog/Makefile     |    1 +
>  drivers/watchdog/ts72xx_wdt.c |  458 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 470 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/watchdog/ts72xx_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 3711b88..5204612 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -289,6 +289,17 @@ config ADX_WATCHDOG
>  	  Say Y here if you want support for the watchdog timer on Avionic
>  	  Design Xanthos boards.
>  
> +config TS72XX_WATCHDOG
> +	tristate "TS-72XX SBC Watchdog"
> +	depends on MACH_TS72XX
> +	help
> +	  Technologic Systems TS-7200, TS-7250 and TS-7260 boards have
> +	  watchdog timer implemented in a external CPLD chip. Say Y here
> +	  if you want to support for the watchdog timer on TS-72XX boards.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ts72xx_wdt.
> +
>  # AVR32 Architecture
>  
>  config AT32AP700X_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 699199b..8e8a9b4 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
>  obj-$(CONFIG_STMP3XXX_WATCHDOG) += stmp3xxx_wdt.o
>  obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
>  obj-$(CONFIG_ADX_WATCHDOG) += adx_wdt.o
> +obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
>  
>  # AVR32 Architecture
>  obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
> new file mode 100644
> index 0000000..88b75b9
> --- /dev/null
> +++ b/drivers/watchdog/ts72xx_wdt.c
> @@ -0,0 +1,458 @@
> +/*
> + * Watchdog driver for Technologic Systems TS-72xx based SBCs
> + * (TS-7200, TS-7250 and TS-7260). These boards have external
> + * glue logic CPLD chip, which includes programmable watchdog
> + * timer.
> + *
> + * Copyright (c) 2009 Mika Westerberg <mika.westerberg@iki.fi>
> + *
> + * This driver is based on ep93xx_wdt and wm831x_wdt drivers.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <linux/fs.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <linux/uaccess.h>
> +
> +#define TS72XX_WDT_FEED_VAL		0x05
> +#define TS72XX_WDT_DEFAULT_TIMEOUT	8
> +
> +static int timeout = TS72XX_WDT_DEFAULT_TIMEOUT;
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. "
> +			  "(1 <= timeout <= 8, default="
> +			  __MODULE_STRING(TS72XX_WDT_DEFAULT_TIMEOUT)
> +			  ")");
> +
> +static int nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, int, 0);
> +MODULE_PARM_DESC(nowayout, "Disable watchdog shutdown on close");
> +
> +/**
> + * struct ts72xx_wdt - watchdog control structure
> + * @lock: lock that protects this structure
> + * @flags: flags controlling watchdog device state
> + * @control_reg: watchdog control register
> + * @feed_reg: watchdog feed register
> + * @pdev: back pointer to platform dev
> + */
> +struct ts72xx_wdt {
> +	struct mutex	lock;
> +	int		timeout;
> +
> +#define TS72XX_WDT_BUSY_FLAG		1
> +#define TS72XX_WDT_EXPECT_CLOSE_FLAG	2
> +	int		flags;
> +
> +	void __iomem	*control_reg;
> +	void __iomem	*feed_reg;
> +
> +	struct platform_device *pdev;
> +};
> +
> +struct platform_device *ts72xx_wdt_pdev;
> +
> +/*
> + * TS-72xx Watchdog supports following timeouts (value written
> + * to control register):
> + *	value	description
> + *	-------------------------
> + * 	0x00	watchdog disabled
> + *	0x01	250ms
> + *	0x02	500ms
> + *	0x03	1s
> + *	0x04	reserved
> + *	0x05	2s
> + *	0x06	4s
> + *	0x07	8s
> + *
> + * Timeouts below 1s are not very usable so we don't
> + * allow them at all.
> + */
> +static const struct {
> +	int	timeout;
> +	u8	ctrval;
> +} ts72xx_wdt_map[] = {
> +	{ 1, 3 },
> +	{ 2, 5 },
> +	{ 4, 6 },
> +	{ 8, 7 },
> +};
> +
> +/**
> + * normalize_timeout() - normalizes given timeout
> + * @new_timeout: timeout in seconds to be normalized
> + *
> + * This function normalizes given timeout value (in seconds)
> + * to value that is valid to TS-72xx watchdog timer. Valid
> + * values are 1, 2, 4 and 8 seconds. Timeout is rounded up
> + * to nearest valid timeout so for example value 3 yields
> + * 4 etc.
> + */
> +static int normalize_timeout(int new_timeout)
> +{
> +	int i;
> +
> +	/* first limit it to 1 - 8 seconds */
> +	if (new_timeout < 1)
> +		new_timeout = 1;
> +	else if (new_timeout > 8)
> +		new_timeout = 8;
> +
> +	for (i = 0; i < ARRAY_SIZE(ts72xx_wdt_map); i++) {
> +		if (ts72xx_wdt_map[i].timeout >= new_timeout)
> +			return ts72xx_wdt_map[i].timeout;
> +	}
> +
> +	BUG();
> +	/*NOTREACHED*/
> +}
> +
> +/**
> + * timeout_to_ctrval() - converts given timeout to control register value
> + * @new_timeout: timeout in seconds to be converted (1, 2, 4 or 8)
> + *
> + * This function converts timeout in seconds to valid control register
> + * value. Note that @new_timeout must be normalized first with call to
> + * normalize_timeout().
> + */
> +static u8 timeout_to_ctrval(int new_timeout)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ts72xx_wdt_map); i++) {
> +		if (ts72xx_wdt_map[i].timeout == new_timeout)
> +			return ts72xx_wdt_map[i].ctrval;
> +	}
> +
> +	BUG();
> +	/*NOTREACHED*/
> +}
> +
> +/**
> + * ts72xx_wdt_kick() - kick the watchdog
> + * @wdt: watchdog to be kicked
> + *
> + * Called with @wdt->lock held.
> + */
> +static void ts72xx_wdt_kick(struct ts72xx_wdt *wdt)
> +{
> +	__raw_writeb(TS72XX_WDT_FEED_VAL, wdt->feed_reg);
> +}
> +
> +/**
> + * ts72xx_wdt_start() - starts the watchdog timer
> + * @wdt: watchdog to be started
> + *
> + * This function programs timeout to watchdog timer
> + * and starts it.
> + *
> + * Called with @wdt->lock held.
> + */
> +static void ts72xx_wdt_start(struct ts72xx_wdt *wdt)
> +{
> +	/*
> +	 * To program the wdt, it first must be "fed" and
> +	 * only after that (within 30 usecs) the configuration
> +	 * can be changed.
> +	 */
> +	ts72xx_wdt_kick(wdt);
> +	__raw_writeb(timeout_to_ctrval(wdt->timeout), wdt->control_reg);
> +}
> +
> +/**
> + * ts72xx_wdt_stop() - stops the watchdog timer
> + * @wdt: watchdog to be stopped
> + *
> + * Called with @wdt->lock held.
> + */
> +static void ts72xx_wdt_stop(struct ts72xx_wdt *wdt)
> +{
> +	ts72xx_wdt_kick(wdt);
> +	__raw_writeb(0, wdt->control_reg);
> +}
> +
> +static int ts72xx_wdt_open(struct inode *inode, struct file *file)
> +{
> +	struct ts72xx_wdt *wdt = platform_get_drvdata(ts72xx_wdt_pdev);
> +
> +	if (mutex_lock_interruptible(&wdt->lock))
> +		return -ERESTARTSYS;
> +
> +	if ((wdt->flags & TS72XX_WDT_BUSY_FLAG) != 0) {
> +		mutex_unlock(&wdt->lock);
> +		return -EBUSY;
> +	}
> +
> +	wdt->flags = TS72XX_WDT_BUSY_FLAG;
> +	wdt->timeout = normalize_timeout(timeout);
> +	file->private_data = wdt;
> +
> +	ts72xx_wdt_start(wdt);
> +
> +	mutex_unlock(&wdt->lock);
> +	return nonseekable_open(inode, file);
> +}
> +
> +static int ts72xx_wdt_release(struct inode *inode, struct file *file)
> +{
> +	struct ts72xx_wdt *wdt = (struct ts72xx_wdt *)file->private_data;

The cast is not needed, file->private_data is a void *.

> +
> +	if (mutex_lock_interruptible(&wdt->lock))
> +		return -ERESTARTSYS;
> +
> +	if ((wdt->flags & TS72XX_WDT_EXPECT_CLOSE_FLAG) != 0) {
> +		ts72xx_wdt_stop(wdt);
> +	} else {
> +		dev_warn(&wdt->pdev->dev,
> +			 "TS-72XX WDT device closed unexpectly. "
> +			 "Watchdog timer will not stop!\n");
> +		/*
> +		 * Kick it one more time, to give userland some time
> +		 * to recover (for example, respawning the kicker
> +		 * daemon).
> +		 */
> +		ts72xx_wdt_kick(wdt);
> +	}
> +
> +	wdt->flags = 0;
> +
> +	mutex_unlock(&wdt->lock);
> +	return 0;
> +}
> +
> +static ssize_t ts72xx_wdt_write(struct file *file,
> +				const char __user *data,
> +				size_t len,
> +				loff_t *ppos)
> +{
> +	struct ts72xx_wdt *wdt = (struct ts72xx_wdt *)file->private_data;

Same here.

> +
> +	if (!len)
> +		return 0;
> +
> +	if (mutex_lock_interruptible(&wdt->lock))
> +		return -ERESTARTSYS;
> +
> +	ts72xx_wdt_kick(wdt);
> +
> +	/*
> +	 * Support for magic character closing. User process
> +	 * writes 'V' into the device, just before it is closed.
> +	 * This means that we know that the wdt timer can be
> +	 * stopped after user closes the device.
> +	 */
> +	if (!nowayout) {
> +		int i;
> +
> +		for (i = 0; i < len; i++) {
> +			char c;
> +
> +			/* In case it was set long ago */
> +			wdt->flags &= ~TS72XX_WDT_EXPECT_CLOSE_FLAG;
> +
> +			if (get_user(c, data + i)) {
> +				mutex_unlock(&wdt->lock);
> +				return -EFAULT;
> +			}
> +			if (c == 'V') {
> +				wdt->flags |= TS72XX_WDT_EXPECT_CLOSE_FLAG;
> +				break;
> +			}
> +		}
> +	}
> +
> +	mutex_unlock(&wdt->lock);
> +	return len;
> +}
> +
> +static const struct watchdog_info winfo = {
> +	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
> +	.firmware_version = 1,
> +	.identity = "TS-72XX WDT",
> +};
> +
> +static long ts72xx_wdt_ioctl(struct file *file, unsigned int cmd,
> +			     unsigned long arg)
> +{
> +	struct ts72xx_wdt *wdt = (struct ts72xx_wdt *)file->private_data;

And here.

> +	void __user *argp = (void __user *)arg;
> +	int __user *p = (int __user *)argp;
> +	int error = 0;
> +
> +	if (mutex_lock_interruptible(&wdt->lock))
> +		return -ERESTARTSYS;
> +
> +	switch (cmd) {
> +	case WDIOC_GETSUPPORT:
> +		error = copy_to_user(argp, &winfo, sizeof(winfo));
> +		break;
> +
> +	case WDIOC_KEEPALIVE:
> +		ts72xx_wdt_kick(wdt);
> +		break;
> +
> +	case WDIOC_SETOPTIONS: {
> +		int options;
> +
> +		if (get_user(options, p)) {
> +			error = -EFAULT;
> +			break;
> +		}
> +
> +		error = -EINVAL;
> +
> +		if ((options & WDIOS_DISABLECARD) != 0) {
> +			ts72xx_wdt_stop(wdt);
> +			error = 0;
> +		}
> +		if ((options & WDIOS_ENABLECARD) != 0) {
> +			ts72xx_wdt_start(wdt);
> +			error = 0;
> +		}
> +
> +		break;
> +	}
> +
> +	case WDIOC_SETTIMEOUT: {
> +		int new_timeout;
> +
> +		if (get_user(new_timeout, p)) {
> +			error = -EFAULT;
> +		} else {
> +			ts72xx_wdt_stop(wdt);
> +			wdt->timeout = normalize_timeout(new_timeout);
> +			ts72xx_wdt_start(wdt);
> +		}
> +		/*FALLTHROUGH*/
> +	}
> +
> +	case WDIOC_GETTIMEOUT:
> +		if (put_user(wdt->timeout, p))
> +			error = -EFAULT;
> +		break;
> +
> +	default:
> +		error = -ENOTTY;
> +		break;
> +	}
> +
> +	mutex_unlock(&wdt->lock);
> +	return error;
> +}
> +
> +static const struct file_operations ts72xx_wdt_fops = {
> +	.owner		= THIS_MODULE,
> +	.llseek		= no_llseek,
> +	.open		= ts72xx_wdt_open,
> +	.release	= ts72xx_wdt_release,
> +	.write		= ts72xx_wdt_write,
> +	.unlocked_ioctl	= ts72xx_wdt_ioctl,
> +};
> +
> +static struct miscdevice ts72xx_wdt_miscdev = {
> +	.minor		= WATCHDOG_MINOR,
> +	.name		= "watchdog",
> +	.fops		= &ts72xx_wdt_fops,
> +};
> +
> +static __devinit int ts72xx_wdt_probe(struct platform_device *pdev)
> +{
> +	struct ts72xx_wdt *wdt;
> +	struct resource *res;
> +	int error = -EIO;
> +
> +	wdt = kzalloc(sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	mutex_init(&wdt->lock);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		goto fail;
> +
> +	wdt->control_reg = ioremap(res->start, resource_size(res));
> +	if (!wdt->control_reg)
> +		goto fail;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res)
> +		goto fail;
> +
> +	wdt->feed_reg = ioremap(res->start, resource_size(res));
> +	if (!wdt->feed_reg)
> +		goto fail;
> +

Please add a request_mem_region() before doing the ioremap()'s.

> +	error = misc_register(&ts72xx_wdt_miscdev);
> +	if (error)
> +		goto fail;
> +
> +	platform_set_drvdata(pdev, wdt);
> +	ts72xx_wdt_pdev = pdev;
> +	wdt->pdev = pdev;
> +
> +	dev_info(&pdev->dev, "TS-72xx Watchdog driver\n");
> +
> +	return 0;
> +
> +fail:
> +	platform_set_drvdata(pdev, NULL);
> +
> +	if (wdt->control_reg)
> +		iounmap(wdt->control_reg);
> +	if (wdt->feed_reg)
> +		iounmap(wdt->feed_reg);

Also, add a release_mem_region() after each iounmap().

> +
> +	kfree(wdt);
> +	return error;
> +}
> +
> +static __devexit int ts72xx_wdt_remove(struct platform_device *pdev)
> +{
> +	struct ts72xx_wdt *wdt =
> +		(struct ts72xx_wdt *)platform_get_drvdata(pdev);

Unnecessary cast.

> +
> +	if (wdt->control_reg)
> +		iounmap(wdt->control_reg);
> +	if (wdt->feed_reg)
> +		iounmap(wdt->feed_reg);

release_mem_region() here also.

> +
> +	kfree(wdt);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	return misc_deregister(&ts72xx_wdt_miscdev);

The misc_deregister() needs to happen before the kfree() to prevent
any race conditions.

> +}
> +
> +static struct platform_driver ts72xx_wdt_driver = {
> +	.probe = ts72xx_wdt_probe,
> +	.remove = __devexit_p(ts72xx_wdt_remove),
> +	.driver = {
> +		.name = "ts72xx-wdt",
> +	},
> +};

Nitpick: Tab align please.

> +
> +static __init int ts72xx_wdt_init(void)
> +{
> +	return platform_driver_register(&ts72xx_wdt_driver);
> +}
> +module_init(ts72xx_wdt_init);
> +
> +static __exit void ts72xx_wdt_exit(void)
> +{
> +	platform_driver_unregister(&ts72xx_wdt_driver);
> +}
> +module_exit(ts72xx_wdt_exit);
> +
> +MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
> +MODULE_DESCRIPTION("TS-72xx SBC Watchdog");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:ts72xx-wdt");
