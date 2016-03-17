From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 17 Mar 2016 21:14:22 +0100
Subject: [PATCH v5 2/2] power: reset: at91-shdwc: add new shutdown
 controller driver
In-Reply-To: <1458134390-23847-3-git-send-email-nicolas.ferre@atmel.com>
References: <1458134390-23847-1-git-send-email-nicolas.ferre@atmel.com>
 <1458134390-23847-3-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20160317201421.GH2831@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/2016 at 14:19:50 +0100, Nicolas Ferre wrote :
> Sama5d2 SoC has a completely new shutdown controller with new features and
> register layout. It thus makes sense to add a new driver for this new
> peripheral.
> 
> This driver is Device Tree only and handles events from the wake-up pin and
> the RTC.
> As the register layout may change in the future, so some values are encoded
> in a configuration structure.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
> 
> Changes in v5:
> - Instead of the "alternate shdwc" we choose a more specific
>   "sama5d2-compatible shdwc" wording. Change file name, in Kconfig, and the
>   MAINTAINERS file:
>   at91-shdwc.c -> at91-sama5d2_shdwc.c
>   "ATMEL AT91 Alternative Shutdown Controller" -> "ATMEL AT91 SAMA5D2-Compatible
>   Shutdown Controller"
> - fix one indentation mismatch
> 
> Changes in v4:
> - fix warning found by 0-day robot: large integer implicitly truncated to
>   unsigned type [-Woverflow]
> - move to the property debounce-delay-us
> - move to atmel,wakeup-active-high boolean
> - add entry in MAINTAINERS file
> 
> Changes in v3:
> - add the slow clock handle as the IP uses it
> - remove useless protection at the beginning of pm_power_off handler
> - allow to compile it as a module
> - add COMPILE_TEST directive in Kconfig
> - update description in file header
> 
> Changes in v2:
> - add MODULE_DEVICE_TABLE as advised by Sebastian Reichel
> - review indentation and braces to correct errors pointed out by checkpatch
> 
>  MAINTAINERS                              |   5 +
>  drivers/power/reset/Kconfig              |   8 +
>  drivers/power/reset/Makefile             |   1 +
>  drivers/power/reset/at91-sama5d2_shdwc.c | 282 +++++++++++++++++++++++++++++++
>  4 files changed, 296 insertions(+)
>  create mode 100644 drivers/power/reset/at91-sama5d2_shdwc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5744af3d79ab..a05b14d8d4d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1999,6 +1999,11 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
>  S:	Supported
>  F:	drivers/tty/serial/atmel_serial.c
>  
> +ATMEL AT91 SAMA5D2-Compatible Shutdown Controller
> +M:	Nicolas Ferre <nicolas.ferre@atmel.com>
> +S:	Supported
> +F:	drivers/power/reset/at91-sama5d2_shdwc.c
> +
>  ATMEL SAMA5D2 ADC DRIVER
>  M:	Ludovic Desroches <ludovic.desroches@atmel.com>
>  L:	linux-iio at vger.kernel.org
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 0a6408a39c66..9bb2622c23bf 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -30,6 +30,14 @@ config POWER_RESET_AT91_RESET
>  	  This driver supports restart for Atmel AT91SAM9 and SAMA5
>  	  SoCs
>  
> +config POWER_RESET_AT91_SAMA5D2_SHDWC
> +	tristate "Atmel AT91 SAMA5D2-Compatible shutdown controller driver"
> +	depends on ARCH_AT91 || COMPILE_TEST
> +	default SOC_SAMA5
> +	help
> +	  This driver supports the alternate shutdown controller for some Atmel
> +	  SAMA5 SoCs. It is present for example on SAMA5D2 SoC.
> +
>  config POWER_RESET_AXXIA
>  	bool "LSI Axxia reset driver"
>  	depends on ARCH_AXXIA
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 096fa67047f6..ab7aa8614d1f 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -1,6 +1,7 @@
>  obj-$(CONFIG_POWER_RESET_AS3722) += as3722-poweroff.o
>  obj-$(CONFIG_POWER_RESET_AT91_POWEROFF) += at91-poweroff.o
>  obj-$(CONFIG_POWER_RESET_AT91_RESET) += at91-reset.o
> +obj-$(CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC) += at91-sama5d2_shdwc.o
>  obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
>  obj-$(CONFIG_POWER_RESET_BRCMSTB) += brcmstb-reboot.o
>  obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> new file mode 100644
> index 000000000000..8a5ac9706c9c
> --- /dev/null
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -0,0 +1,282 @@
> +/*
> + * Atmel SAMA5D2-Compatible Shutdown Controller (SHDWC) driver.
> + * Found on some SoCs as the sama5d2 (obviously).
> + *
> + * Copyright (C) 2015 Atmel Corporation,
> + *                    Nicolas Ferre <nicolas.ferre@atmel.com>
> + *
> + * Evolved from driver at91-poweroff.c.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * TODO:
> + * - addition to status of other wake-up inputs [1 - 15]
> + * - Analog Comparator wake-up alarm
> + * - Serial RX wake-up alarm
> + * - low power debouncer
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +
> +#define SLOW_CLOCK_FREQ	32768
> +
> +#define AT91_SHDW_CR	0x00		/* Shut Down Control Register */
> +#define AT91_SHDW_SHDW		BIT(0)			/* Shut Down command */
> +#define AT91_SHDW_KEY		(0xa5UL << 24)		/* KEY Password */
> +
> +#define AT91_SHDW_MR	0x04		/* Shut Down Mode Register */
> +#define AT91_SHDW_WKUPDBC_SHIFT	24
> +#define AT91_SHDW_WKUPDBC_MASK	GENMASK(31, 16)
> +#define AT91_SHDW_WKUPDBC(x)	(((x) << AT91_SHDW_WKUPDBC_SHIFT) \
> +						& AT91_SHDW_WKUPDBC_MASK)
> +
> +#define AT91_SHDW_SR	0x08		/* Shut Down Status Register */
> +#define AT91_SHDW_WKUPIS_SHIFT	16
> +#define AT91_SHDW_WKUPIS_MASK	GENMASK(31, 16)
> +#define AT91_SHDW_WKUPIS(x)	((1 << (x)) << AT91_SHDW_WKUPIS_SHIFT \
> +						& AT91_SHDW_WKUPIS_MASK)
> +
> +#define AT91_SHDW_WUIR	0x0c		/* Shutdown Wake-up Inputs Register */
> +#define AT91_SHDW_WKUPEN_MASK	GENMASK(15, 0)
> +#define AT91_SHDW_WKUPEN(x)	((1 << (x)) & AT91_SHDW_WKUPEN_MASK)
> +#define AT91_SHDW_WKUPT_SHIFT	16
> +#define AT91_SHDW_WKUPT_MASK	GENMASK(31, 16)
> +#define AT91_SHDW_WKUPT(x)	((1 << (x)) << AT91_SHDW_WKUPT_SHIFT \
> +						& AT91_SHDW_WKUPT_MASK)
> +
> +#define SHDW_WK_PIN(reg, cfg)	((reg) & AT91_SHDW_WKUPIS((cfg)->wkup_pin_input))
> +#define SHDW_RTCWK(reg, cfg)	(((reg) >> ((cfg)->sr_rtcwk_shift)) & 0x1)
> +#define SHDW_RTCWKEN(cfg)	(1 << ((cfg)->mr_rtcwk_shift))
> +
> +#define DBC_PERIOD_US(x)	DIV_ROUND_UP_ULL((1000000 * (x)), \
> +							SLOW_CLOCK_FREQ)
> +
> +struct shdwc_config {
> +	u8 wkup_pin_input;
> +	u8 mr_rtcwk_shift;
> +	u8 sr_rtcwk_shift;
> +};
> +
> +struct shdwc {
> +	struct shdwc_config *cfg;
> +	void __iomem *at91_shdwc_base;
> +};
> +
> +/*
> + * Hold configuration here, cannot be more than one instance of the driver
> + * since pm_power_off itself is global.
> + */
> +static struct shdwc *at91_shdwc;
> +static struct clk *sclk;
> +
> +static const unsigned long long sdwc_dbc_period[] = {
> +	0, 3, 32, 512, 4096, 32768,
> +};
> +
> +static void __init at91_wakeup_status(struct platform_device *pdev)
> +{
> +	struct shdwc *shdw = platform_get_drvdata(pdev);
> +	u32 reg;
> +	char *reason = "unknown";
> +
> +	reg = readl(shdw->at91_shdwc_base + AT91_SHDW_SR);
> +
> +	dev_dbg(&pdev->dev, "%s: status = %#x\n", __func__, reg);
> +
> +	/* Simple power-on, just bail out */
> +	if (!reg)
> +		return;
> +
> +	if (SHDW_WK_PIN(reg, shdw->cfg))
> +		reason = "WKUP pin";
> +	else if (SHDW_RTCWK(reg, shdw->cfg))
> +		reason = "RTC";
> +
> +	pr_info("AT91: Wake-Up source: %s\n", reason);
> +}
> +
> +static void at91_poweroff(void)
> +{
> +	writel(AT91_SHDW_KEY | AT91_SHDW_SHDW,
> +	       at91_shdwc->at91_shdwc_base + AT91_SHDW_CR);
> +}
> +
> +static u32 at91_shdwc_debouncer_value(struct platform_device *pdev,
> +				      u32 in_period_us)
> +{
> +	int i;
> +	int max_idx = ARRAY_SIZE(sdwc_dbc_period) - 1;
> +	unsigned long long period_us;
> +	unsigned long long max_period_us = DBC_PERIOD_US(sdwc_dbc_period[max_idx]);
> +
> +	if (in_period_us > max_period_us) {
> +		dev_warn(&pdev->dev,
> +			 "debouncer period %u too big, reduced to %llu us\n",
> +			 in_period_us, max_period_us);
> +		return max_idx;
> +	}
> +
> +	for (i = max_idx - 1; i > 0; i--) {
> +		period_us = DBC_PERIOD_US(sdwc_dbc_period[i]);
> +		dev_dbg(&pdev->dev, "%s: ref[%d] = %llu\n",
> +						__func__, i, period_us);
> +		if (in_period_us > period_us)
> +			break;
> +	}
> +
> +	return i + 1;
> +}
> +
> +static u32 at91_shdwc_get_wakeup_input(struct platform_device *pdev,
> +				       struct device_node *np)
> +{
> +	struct device_node *cnp;
> +	u32 wk_input_mask;
> +	u32 wuir = 0;
> +	u32 wk_input;
> +
> +	for_each_child_of_node(np, cnp) {
> +		if (of_property_read_u32(cnp, "reg", &wk_input)) {
> +			dev_warn(&pdev->dev, "reg property is missing for %s\n",
> +				 cnp->full_name);
> +			continue;
> +		}
> +
> +		wk_input_mask = 1 << wk_input;
> +		if (!(wk_input_mask & AT91_SHDW_WKUPEN_MASK)) {
> +			dev_warn(&pdev->dev,
> +				 "wake-up input %d out of bounds ignore\n",
> +				 wk_input);
> +			continue;
> +		}
> +		wuir |= wk_input_mask;
> +
> +		if (of_property_read_bool(cnp, "atmel,wakeup-active-high"))
> +			wuir |= AT91_SHDW_WKUPT(wk_input);
> +
> +		dev_dbg(&pdev->dev, "%s: (child %d) wuir = %#x\n",
> +						__func__, wk_input, wuir);
> +	}
> +
> +	return wuir;
> +}
> +
> +static void at91_shdwc_dt_configure(struct platform_device *pdev)
> +{
> +	struct shdwc *shdw = platform_get_drvdata(pdev);
> +	struct device_node *np = pdev->dev.of_node;
> +	u32 mode = 0, tmp, input;
> +
> +	if (!np) {
> +		dev_err(&pdev->dev, "device node not found\n");
> +		return;
> +	}
> +
> +	if (!of_property_read_u32(np, "debounce-delay-us", &tmp))
> +		mode |= AT91_SHDW_WKUPDBC(at91_shdwc_debouncer_value(pdev, tmp));
> +
> +	if (of_property_read_bool(np, "atmel,wakeup-rtc-timer"))
> +		mode |= SHDW_RTCWKEN(shdw->cfg);
> +
> +	dev_dbg(&pdev->dev, "%s: mode = %#x\n", __func__, mode);
> +	writel(mode, shdw->at91_shdwc_base + AT91_SHDW_MR);
> +
> +	input = at91_shdwc_get_wakeup_input(pdev, np);
> +	writel(input, shdw->at91_shdwc_base + AT91_SHDW_WUIR);
> +}
> +
> +static const struct shdwc_config sama5d2_shdwc_config = {
> +	.wkup_pin_input = 0,
> +	.mr_rtcwk_shift = 17,
> +	.sr_rtcwk_shift = 5,
> +};
> +
> +static const struct of_device_id at91_shdwc_of_match[] = {
> +	{
> +		.compatible = "atmel,sama5d2-shdwc",
> +		.data = &sama5d2_shdwc_config,
> +	}, {
> +		/*sentinel*/
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, at91_shdwc_of_match);
> +
> +static int __init at91_shdwc_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	const struct of_device_id *match;
> +	int ret;
> +
> +	if (!pdev->dev.of_node)
> +		return -ENODEV;
> +
> +	at91_shdwc = devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL);
> +	if (!at91_shdwc)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, at91_shdwc);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	at91_shdwc->at91_shdwc_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(at91_shdwc->at91_shdwc_base)) {
> +		dev_err(&pdev->dev, "Could not map reset controller address\n");
> +		return PTR_ERR(at91_shdwc->at91_shdwc_base);
> +	}
> +
> +	match = of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
> +	at91_shdwc->cfg = (struct shdwc_config *)(match->data);
> +
> +	sclk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(sclk))
> +		return PTR_ERR(sclk);
> +
> +	ret = clk_prepare_enable(sclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not enable slow clock\n");
> +		return ret;
> +	}
> +
> +	at91_wakeup_status(pdev);
> +
> +	at91_shdwc_dt_configure(pdev);
> +
> +	pm_power_off = at91_poweroff;
> +
> +	return 0;
> +}
> +
> +static int __exit at91_shdwc_remove(struct platform_device *pdev)
> +{
> +	struct shdwc *shdw = platform_get_drvdata(pdev);
> +
> +	if (pm_power_off == at91_poweroff)
> +		pm_power_off = NULL;
> +
> +	/* Reset values to disable wake-up features  */
> +	writel(0, shdw->at91_shdwc_base + AT91_SHDW_MR);
> +	writel(0, shdw->at91_shdwc_base + AT91_SHDW_WUIR);
> +
> +	clk_disable_unprepare(sclk);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver at91_shdwc_driver = {
> +	.remove = __exit_p(at91_shdwc_remove),
> +	.driver = {
> +		.name = "at91-shdwc",
> +		.of_match_table = at91_shdwc_of_match,
> +	},
> +};
> +module_platform_driver_probe(at91_shdwc_driver, at91_shdwc_probe);
> +
> +MODULE_AUTHOR("Nicolas Ferre <nicolas.ferre@atmel.com>");
> +MODULE_DESCRIPTION("Atmel shutdown controller driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.1.3
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
