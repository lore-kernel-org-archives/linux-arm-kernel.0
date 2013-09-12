From: romain.izard.pro@gmail.com (Romain Izard)
Date: Thu, 12 Sep 2013 08:44:04 +0000 (UTC)
Subject: [PATCH v2] watchdog: sirf: add watchdog driver of CSR
 SiRFprimaII and SiRFatlasVI
References: <1378953828-374-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <l0rusk$789$1@ger.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-09-12, Barry Song <21cnbao@gmail.com> wrote:
> From: Xianglong Du <Xianglong.Du@csr.com>
>
> On CSR SiRFprimaII and SiRFatlasVI, the 6th timer can act as a watchdog
> timer when the Watchdog mode is enabled.
>
> watchdog occur when TIMER watchdog counter matches the value software
> pre-set, when this event occurs, the effect is the same as the system
> software reset.
>
> Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  -v2: select WATCHDOG_CORE;
>  module parameter name is timeout;
>  fix coding style;
>  define a local variable first that get's the value of watchdog_get_drvdata(wdd);
>  drop redundant watchdog_timeout_invalid check;
>  MODULE_ALIAS_MISCDEV is removed as we have the platform alias.
>
>  arch/arm/boot/dts/atlas6.dtsi     |   2 +-
>  arch/arm/boot/dts/prima2.dtsi     |   2 +-
>  arch/arm/configs/prima2_defconfig |   6 +-
>  drivers/watchdog/Kconfig          |   9 ++
>  drivers/watchdog/Makefile         |   1 +
>  drivers/watchdog/sirfsoc_wdt.c    | 251 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 266 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/watchdog/sirfsoc_wdt.c
>
> diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
> index 8678e0c..afee4a1 100644
> --- a/arch/arm/boot/dts/atlas6.dtsi
> +++ b/arch/arm/boot/dts/atlas6.dtsi
> @@ -155,7 +155,7 @@
>  			       <0x56000000 0x56000000 0x1b00000>;
>  
>  			timer at b0020000 {
> -				compatible = "sirf,prima2-tick";
> +				compatible = "sirf,prima2-tick", "sirf,prima2-wdt";

Does this really mean that both drivers will be loaded?  From what I
understand of device tree, this means to use the "sirf,prima2-tick"
driver, and then if not available, the "sirf-prima2-wdt" driver.
It would be necessary to either add the watchdog support in the
clocksource driver, or create a separate node in the device tree
(with the same address?) to respect the compatible rules.


>  				reg = <0xb0020000 0x1000>;
>  				interrupts = <0>;
>  			};
> diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
> index bbeb623..d41ab98e 100644
> --- a/arch/arm/boot/dts/prima2.dtsi
> +++ b/arch/arm/boot/dts/prima2.dtsi
> @@ -174,7 +174,7 @@
>  			ranges = <0xb0000000 0xb0000000 0x180000>;
>  
>  			timer at b0020000 {
> -				compatible = "sirf,prima2-tick";
> +				compatible = "sirf,prima2-tick", "sirf,prima2-wdt";

See previous comment.

>  				reg = <0xb0020000 0x1000>;
>  				interrupts = <0>;
>  			};
> diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
> index 002a1ce..eec56e8 100644
> --- a/arch/arm/configs/prima2_defconfig
> +++ b/arch/arm/configs/prima2_defconfig
> @@ -1,4 +1,3 @@
> -CONFIG_EXPERIMENTAL=y

CONFIG_EXPERIMENTAL is not related to this change.

>  CONFIG_NO_HZ=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_RELAY=y
> @@ -39,6 +38,7 @@ CONFIG_SPI=y
>  CONFIG_SPI_SIRF=y
>  CONFIG_SPI_SPIDEV=y
>  # CONFIG_HWMON is not set
> +CONFIG_WATCHDOG=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_MASS_STORAGE=m
>  CONFIG_MMC=y
> @@ -59,12 +59,12 @@ CONFIG_ROMFS_FS=y
>  CONFIG_NLS_CODEPAGE_437=y
>  CONFIG_NLS_ASCII=y
>  CONFIG_NLS_ISO8859_1=y
> -CONFIG_MAGIC_SYSRQ=y
> +CONFIG_DEBUG_INFO=y
>  CONFIG_DEBUG_SECTION_MISMATCH=y
> +CONFIG_MAGIC_SYSRQ=y

Both CONFIG_MAGIC_SYSRQ & CONFIG_DEBUG_INFO are not related to this change.

>  CONFIG_DEBUG_KERNEL=y
>  # CONFIG_DEBUG_PREEMPT is not set
>  CONFIG_DEBUG_RT_MUTEXES=y
>  CONFIG_DEBUG_SPINLOCK=y
>  CONFIG_DEBUG_MUTEXES=y
> -CONFIG_DEBUG_INFO=y

CONFIG_DEBUG_INFO is not related to this change.

>  CONFIG_CRC_CCITT=y
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 362085d..c76cb61 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -382,6 +382,15 @@ config RETU_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called retu_wdt.
>  
> +config SIRFSOC_WATCHDOG
> +	tristate "SiRFSOC watchdog"
> +	depends on ARCH_SIRF
> +	select WATCHDOG_CORE
> +	default y
> +	help
> +	  Support for CSR SiRFprimaII and SiRFatlasVI watchdog. When
> +	  the watchdog triggers the system will be reset.
> +
>  # AVR32 Architecture
>  
>  config AT32AP700X_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 2f26a0b..b917ae6 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
>  obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
>  obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
>  obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o
> +obj-$(CONFIG_SIRFSOC_WATCHDOG) += sirfsoc_wdt.o
>  
>  # AVR32 Architecture
>  obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
> diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
> new file mode 100644
> index 0000000..0542a4d
> --- /dev/null
> +++ b/drivers/watchdog/sirfsoc_wdt.c
> @@ -0,0 +1,251 @@
> +/*
> + * Watchdog driver for CSR SiRFprimaII and SiRFatlasVI
> + *
> + * Copyright (c) 2013 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/miscdevice.h>
> +#include <linux/watchdog.h>
> +#include <linux/platform_device.h>
> +#include <linux/moduleparam.h>
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <linux/uaccess.h>
> +
> +#define SIRFSOC_TIMER_COUNTER_LO	0x0000
> +#define SIRFSOC_TIMER_MATCH_0		0x0008
> +#define SIRFSOC_TIMER_INT_EN		0x0024
> +#define SIRFSOC_TIMER_WATCHDOG_EN	0x0028
> +#define SIRFSOC_TIMER_LATCH		0x0030
> +#define SIRFSOC_TIMER_LATCHED_LO	0x0034
> +
> +#define SIRFSOC_TIMER_WDT_INDEX		5
> +
> +#define SIRFSOC_WDT_MIN_TIMEOUT		30		/* 30 secs */
> +#define SIRFSOC_WDT_MAX_TIMEOUT		(10 * 60)	/* 10 mins */
> +#define SIRFSOC_WDT_DEFAULT_TIMEOUT	30		/* 30 secs */
> +
> +
> +static unsigned int timeout = SIRFSOC_WDT_DEFAULT_TIMEOUT;
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +
> +module_param(timeout, uint, 0);
> +module_param(nowayout, bool, 0);
> +
> +MODULE_PARM_DESC(timeout, "Default watchdog timeout (in seconds)");
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static unsigned int sirfsoc_wdt_gettimeleft(struct watchdog_device *wdd)
> +{
> +	u32 counter, match;
> +	void __iomem *wdt_base;
> +	int time_left;
> +
> +	wdt_base = watchdog_get_drvdata(wdd);
> +	counter = readl(wdt_base + SIRFSOC_TIMER_COUNTER_LO);
> +	match = readl(wdt_base +
> +		SIRFSOC_TIMER_MATCH_0 + (SIRFSOC_TIMER_WDT_INDEX << 2));
> +
> +	if (match >= counter)
> +		time_left = match-counter;
> +	else
> +		/* rollover */
> +		time_left = (0xffffffffUL - counter) + match;

As u32 is a modulo 2^32 type, those values are almost the same (off by one).
time_left = match - counter; will be valid in all cases.

> +
> +	return time_left / CLOCK_TICK_RATE;
> +}
> +
> +static int sirfsoc_wdt_updatetimeout(struct watchdog_device *wdd)
> +{
> +	u32 counter, timeout_ticks;
> +	void __iomem *wdt_base;
> +
> +	timeout_ticks = wdd->timeout * CLOCK_TICK_RATE;
> +	wdt_base = watchdog_get_drvdata(wdd);
> +
> +	/* Enable the latch before reading the LATCH_LO register */
> +	writel(1, wdt_base + SIRFSOC_TIMER_LATCH);
> +
> +	/* Set the TO value */
> +	counter = readl(wdt_base + SIRFSOC_TIMER_LATCHED_LO);
> +
> +	if ((0xffffffffUL - counter) >= timeout_ticks)
> +		counter += timeout_ticks;
> +	else
> +		/* Rollover */
> +		counter = timeout_ticks - (0xffffffffUL - counter);

modulo 2^32 arithmetic, no need for two cases.

> +
> +	writel(counter, wdt_base +
> +		SIRFSOC_TIMER_MATCH_0 + (SIRFSOC_TIMER_WDT_INDEX << 2));
> +
> +	return 0;
> +}
> +
> +static int sirfsoc_wdt_enable(struct watchdog_device *wdd)
> +{
> +	void __iomem *wdt_base = watchdog_get_drvdata(wdd);
> +	sirfsoc_wdt_updatetimeout(wdd);
> +
> +	/*
> +	 * NOTE: If interrupt is not enabled
> +	 * then WD-Reset doesn't get generated at all.
> +	 */
> +	writel(readl(wdt_base + SIRFSOC_TIMER_INT_EN)
> +		| (1 << SIRFSOC_TIMER_WDT_INDEX),
> +		wdt_base + SIRFSOC_TIMER_INT_EN);
> +	writel(1, wdt_base + SIRFSOC_TIMER_WATCHDOG_EN);
> +
> +	return 0;
> +}
> +
> +static int sirfsoc_wdt_disable(struct watchdog_device *wdd)
> +{
> +	void __iomem *wdt_base = watchdog_get_drvdata(wdd);
> +
> +	writel(0, wdt_base + SIRFSOC_TIMER_WATCHDOG_EN);
> +	writel(readl(wdt_base + SIRFSOC_TIMER_INT_EN)
> +		& (~(1 << SIRFSOC_TIMER_WDT_INDEX)),
> +		wdt_base + SIRFSOC_TIMER_INT_EN);
> +
> +	return 0;
> +}
> +
> +static int sirfsoc_wdt_settimeout(struct watchdog_device *wdd, unsigned int to)
> +{
> +	wdd->timeout = to;
> +	sirfsoc_wdt_updatetimeout(wdd);
> +
> +	return 0;
> +}
> +
> +#define OPTIONS (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
> +
> +static const struct watchdog_info sirfsoc_wdt_ident = {
> +	.options          =     OPTIONS,
> +	.firmware_version =	0,
> +	.identity         =	"SiRFSOC Watchdog",
> +};
> +
> +static struct watchdog_ops sirfsoc_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = sirfsoc_wdt_enable,
> +	.stop = sirfsoc_wdt_disable,
> +	.get_timeleft = sirfsoc_wdt_gettimeleft,
> +	.ping = sirfsoc_wdt_updatetimeout,
> +	.set_timeout = sirfsoc_wdt_settimeout,
> +};
> +
> +static struct watchdog_device sirfsoc_wdd = {
> +	.info = &sirfsoc_wdt_ident,
> +	.ops = &sirfsoc_wdt_ops,
> +	.timeout = SIRFSOC_WDT_DEFAULT_TIMEOUT,
> +	.min_timeout = SIRFSOC_WDT_MIN_TIMEOUT,
> +	.max_timeout = SIRFSOC_WDT_MAX_TIMEOUT,
> +};
> +
> +static int sirfsoc_wdt_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int ret;
> +	void __iomem *base;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (!base) {
> +		dev_err(&pdev->dev, "sirfsoc wdt: could not remap the mem\n");
> +		ret = -EADDRNOTAVAIL;
> +		goto out;
> +	}
> +	watchdog_set_drvdata(&sirfsoc_wdd, base);
> +
> +	watchdog_init_timeout(&sirfsoc_wdd, timeout, &pdev->dev);
> +	watchdog_set_nowayout(&sirfsoc_wdd, nowayout);
> +
> +	ret = watchdog_register_device(&sirfsoc_wdd);
> +	if (!!ret)
> +		goto out;
> +
> +	platform_set_drvdata(pdev, &sirfsoc_wdd);
> +
> +	return 0;
> +
> +out:
> +	return ret;
> +}
> +
> +static int sirfsoc_wdt_remove(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
> +
> +	sirfsoc_wdt_disable(wdd);
> +
> +	return 0;
> +}
> +
> +static void sirfsoc_wdt_shutdown(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
> +
> +	sirfsoc_wdt_disable(wdd);
> +}
> +
> +#ifdef	CONFIG_PM
> +
> +static int sirfsoc_wdt_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int sirfsoc_wdt_resume(struct device *dev)
> +{
> +	struct watchdog_device *wdd = dev_get_drvdata(dev);
> +
> +	/*
> +	 * NOTE: Since timer controller registers settings are saved
> +	 * and restored back by the timer-prima2.c, so we need not
> +	 * update WD settings except refreshing timeout.
> +	 */
> +	sirfsoc_wdt_updatetimeout(wdd);
> +
> +	return 0;
> +}
> +
> +#else
> +#define	sirfsoc_wdt_suspend		NULL
> +#define	sirfsoc_wdt_resume		NULL
> +#endif
> +
> +static const struct dev_pm_ops sirfsoc_wdt_pm_ops = {
> +	.suspend = sirfsoc_wdt_suspend,
> +	.resume = sirfsoc_wdt_resume,
> +};
> +
> +static const struct of_device_id sirfsoc_wdt_of_match[] = {
> +	{ .compatible = "sirf,prima2-wdt"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sirfsoc_wdt_of_match);
> +
> +static struct platform_driver sirfsoc_wdt_driver = {
> +	.driver = {
> +		.name = "sirfsoc-wdt",
> +		.owner = THIS_MODULE,
> +#ifdef CONFIG_PM
> +		.pm = &sirfsoc_wdt_pm_ops,
> +#endif
> +		.of_match_table	= of_match_ptr(sirfsoc_wdt_of_match),
> +	},
> +	.probe = sirfsoc_wdt_probe,
> +	.remove = sirfsoc_wdt_remove,
> +	.shutdown = sirfsoc_wdt_shutdown,
> +};
> +module_platform_driver(sirfsoc_wdt_driver);
> +
> +MODULE_DESCRIPTION("SiRF SoC watchdog driver");
> +MODULE_AUTHOR("Xianglong Du <Xianglong.Du@csr.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:sirfsoc-wdt");


-- 
Romain Izard
