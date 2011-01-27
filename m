From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 27 Jan 2011 18:29:43 +0100
Subject: [PATCH] ARM: i.MX23/28: Add pwm driver
In-Reply-To: <20110127114828.GW9041@pengutronix.de>
References: <20110127114828.GW9041@pengutronix.de>
Message-ID: <20110127172943.GE26986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

just a few minor questions...

On Thu, Jan 27, 2011 at 12:48:28PM +0100, Sascha Hauer wrote:
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mxs/Kconfig                       |    2 +
>  arch/arm/mach-mxs/Makefile                      |    2 +
>  arch/arm/mach-mxs/clock-mx23.c                  |    6 +-
>  arch/arm/mach-mxs/clock-mx28.c                  |    9 +-
>  arch/arm/mach-mxs/devices-mx23.h                |    3 +
>  arch/arm/mach-mxs/devices-mx28.h                |    3 +
>  arch/arm/mach-mxs/devices/Kconfig               |    4 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-pwm.c        |   25 ++
>  arch/arm/mach-mxs/include/mach/devices-common.h |    5 +
>  arch/arm/mach-mxs/pwm.c                         |  318 +++++++++++++++++++++++
>  11 files changed, 376 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-pwm.c
>  create mode 100644 arch/arm/mach-mxs/pwm.c
> 
> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index cd2fbdf..99813e0 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -8,10 +8,12 @@ config MXS_OCOTP
>  config SOC_IMX23
>  	bool
>  	select CPU_ARM926T
> +	select HAVE_PWM
>  
>  config SOC_IMX28
>  	bool
>  	select CPU_ARM926T
> +	select HAVE_PWM
>  
>  comment "MXS platforms:"
>  
> diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
> index 6b26f02..5c7ce1f 100644
> --- a/arch/arm/mach-mxs/Makefile
> +++ b/arch/arm/mach-mxs/Makefile
> @@ -7,6 +7,8 @@ obj-$(CONFIG_PM) += pm.o
>  obj-$(CONFIG_SOC_IMX23) += clock-mx23.o mm-mx23.o
>  obj-$(CONFIG_SOC_IMX28) += clock-mx28.o mm-mx28.o
>  
> +obj-$(CONFIG_MXS_HAVE_PLATFORM_PWM) += pwm.o
> +
>  obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
>  obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
>  
> diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
> index b1a362e..017d4a3 100644
> --- a/arch/arm/mach-mxs/clock-mx23.c
> +++ b/arch/arm/mach-mxs/clock-mx23.c
> @@ -446,7 +446,11 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
>  	_REGISTER_CLOCK(NULL, "usb", usb_clk)
>  	_REGISTER_CLOCK(NULL, "audio", audio_clk)
> -	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
> +	_REGISTER_CLOCK("mxs-pwm.0", NULL, pwm_clk)
> +	_REGISTER_CLOCK("mxs-pwm.1", NULL, pwm_clk)
> +	_REGISTER_CLOCK("mxs-pwm.2", NULL, pwm_clk)
> +	_REGISTER_CLOCK("mxs-pwm.3", NULL, pwm_clk)
> +	_REGISTER_CLOCK("mxs-pwm.4", NULL, pwm_clk)
>  };
>  
>  static int clk_misc_init(void)
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 2f1a990..4b48b0a 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -623,7 +623,14 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK(NULL, "can1", can1_clk)
>  	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
>  	_REGISTER_CLOCK(NULL, "usb1", usb1_clk)
> -	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
> +	_REGISTER_CLOCK("mxs-pwm.0", NULL, pwm_clk)
> +	_REGISTER_CLOCK("mxs-pwm.1", NULL, pwm_clk)
> +	_REGISTER_CLOCK("mxs-pwm.2", NULL, pwm_clk)
> +	_REGISTER_CLOCK("mxs-pwm.3", NULL, pwm_clk)
> +	_REGISTER_CLOCK("mxs-pwm.4", NULL, pwm_clk)
> +	_REGISTER_CLOCK("mxs-pwm.5", NULL, pwm_clk)
> +	_REGISTER_CLOCK("mxs-pwm.6", NULL, pwm_clk)
> +	_REGISTER_CLOCK("mxs-pwm.7", NULL, pwm_clk)
>  	_REGISTER_CLOCK(NULL, "lradc", lradc_clk)
>  	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
>  };
> diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
> index 1256788..fb9def8 100644
> --- a/arch/arm/mach-mxs/devices-mx23.h
> +++ b/arch/arm/mach-mxs/devices-mx23.h
> @@ -14,3 +14,6 @@
>  extern const struct amba_device mx23_duart_device __initconst;
>  #define mx23_add_duart() \
>  	mxs_add_duart(&mx23_duart_device)
> +
> +#define mx23_add_pwm(id)		mxs_add_pwm(MX23_PWM_BASE_ADDR, pdata)
> +
> diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
> index 1ab7bf0..6927250 100644
> --- a/arch/arm/mach-mxs/devices-mx28.h
> +++ b/arch/arm/mach-mxs/devices-mx28.h
> @@ -26,3 +26,6 @@ extern const struct mxs_auart_data mx28_auart_data[] __initconst;
>  extern const struct mxs_fec_data mx28_fec_data[] __initconst;
>  #define mx28_add_fec(id, pdata) \
>  	mxs_add_fec(&mx28_fec_data[id], pdata)
> +
> +#define mx28_add_pwm(id)		mxs_add_pwm(MX28_PWM_BASE_ADDR, id)
> +
> diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
> index 3001b75..f8599e5 100644
> --- a/arch/arm/mach-mxs/devices/Kconfig
> +++ b/arch/arm/mach-mxs/devices/Kconfig
> @@ -7,3 +7,7 @@ config MXS_HAVE_PLATFORM_AUART
>  
>  config MXS_HAVE_PLATFORM_FEC
>  	bool
> +
> +config MXS_HAVE_PLATFORM_PWM
> +	bool
> +
> diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
> index c814d05..cdb026e 100644
> --- a/arch/arm/mach-mxs/devices/Makefile
> +++ b/arch/arm/mach-mxs/devices/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_MXS_HAVE_AMBA_DUART) += amba-duart.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
> +obj-$(CONFIG_MXS_HAVE_PLATFORM_PWM) += platform-pwm.o
> diff --git a/arch/arm/mach-mxs/devices/platform-pwm.c b/arch/arm/mach-mxs/devices/platform-pwm.c
> new file mode 100644
> index 0000000..2f1f549
> --- /dev/null
> +++ b/arch/arm/mach-mxs/devices/platform-pwm.c
> @@ -0,0 +1,25 @@
> +/*
> + * Copyright (C) 2010 Pengutronix

2011?

> + * Sascha Hauer <s.hauer@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +#include <asm/sizes.h>
> +#include <mach/mx23.h>
> +#include <mach/mx28.h>
> +#include <mach/devices-common.h>
> +
> +struct platform_device *__init mxs_add_pwm(resource_size_t iobase, int id)
> +{
> +	struct resource res = {
> +		.flags = IORESOURCE_MEM,
> +	};
> +
> +	res.start = iobase + 0x10 + 0x20 * id;
> +	res.end = res.start + 0x1f;
> +
> +	return mxs_add_platform_device("mxs-pwm", id, &res, 1, NULL, 0);
> +}
> +
> diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
> index bed4002..82d5311 100644
> --- a/arch/arm/mach-mxs/include/mach/devices-common.h
> +++ b/arch/arm/mach-mxs/include/mach/devices-common.h
> @@ -51,3 +51,8 @@ struct mxs_fec_data {
>  struct platform_device *__init mxs_add_fec(
>  		const struct mxs_fec_data *data,
>  		const struct fec_platform_data *pdata);
> +
> +/* pwm */
> +struct platform_device *__init mxs_add_pwm(
> +		resource_size_t iobase, int id);
> +
> diff --git a/arch/arm/mach-mxs/pwm.c b/arch/arm/mach-mxs/pwm.c
> new file mode 100644
> index 0000000..f2c83a6
> --- /dev/null
> +++ b/arch/arm/mach-mxs/pwm.c
> @@ -0,0 +1,318 @@
> +/*
> + * Copyright (C) 2010 Pengutronix

2011?

> + * Sascha Hauer <s.hauer@pengutronix.de>
> + *
> + * simple driver for PWM (Pulse Width Modulator) controller
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Derived from pxa PWM driver by eric miao <eric.miao@marvell.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/pwm.h>
> +#include <mach/hardware.h>
> +#include <mach/mxs.h>
> +#include <mach/mx23.h>
> +#include <mach/mx28.h>
> +#include <asm/div64.h>
> +
> +struct pwm_device {
> +	struct list_head	node;
> +	struct device		*dev;
> +
> +	const char	*label;
> +	struct clk	*clk;
> +
> +	int		enabled;
> +	void __iomem	*mmio_base;
> +
> +	unsigned int	use_count;
> +	unsigned int	pwm_id;
> +
> +	u32		val_active;
> +	u32		val_period;
> +	int		period_us;
> +};
> +
> +/* common register space */
> +static void __iomem *pwm_base_common;
> +#define REG_PWM_CTRL	0x0
> +#define PWM_SFTRST	(1 << 31)
> +#define PWM_CLKGATE	(1 << 30)
> +#define PWM_ENABLE(p)	(1 << (p))
> +
> +/* per pwm register space */
> +#define REG_ACTIVE	0x0
> +#define REG_PERIOD	0x10
> +
> +#define PERIOD_PERIOD(p)	((p) & 0xffff)
> +#define PERIOD_ACTIVE_HIGH	(3 << 16)
> +#define PERIOD_INACTIVE_LOW	(2 << 18)
> +#define PERIOD_CDIV(div)	(((div) & 0x7) << 20)
> +
> +static void pwm_update(struct pwm_device *pwm)
> +{
> +	writel(pwm->val_active, pwm->mmio_base + REG_ACTIVE);
> +	writel(pwm->val_period, pwm->mmio_base + REG_PERIOD);
> +}
> +
> +int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
> +{
> +	int div = 0;
> +	unsigned long rate;
> +	unsigned long long c;
> +	unsigned long period_cycles, duty_cycles;
> +
> +	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
> +		return -EINVAL;
> +
> +	rate = clk_get_rate(pwm->clk);
> +
> +	dev_dbg(pwm->dev, "config: duty_ns: %d, period_ns: %d (clkrate %ld)\n",
> +			duty_ns, period_ns, rate);
> +
> +	while (1) {
> +		c = rate / (1 << div);
> +		c = c * period_ns;
> +		do_div(c, 1000000000);
> +		if (c < 0x10000)
> +			break;
> +		div++;
> +
> +		if (div > 8)
> +			return -EINVAL;
> +	}
> +
> +	period_cycles = c;
> +	duty_cycles = period_cycles * duty_ns / period_ns;
> +
> +	dev_dbg(pwm->dev, "config period_cycles: %ld duty_cycles: %ld\n",
> +			period_cycles, duty_cycles);
> +
> +	pwm->val_active = period_cycles << 16 | duty_cycles;
> +	pwm->val_period = PERIOD_PERIOD(period_cycles) | PERIOD_ACTIVE_HIGH |
> +			PERIOD_INACTIVE_LOW | PERIOD_CDIV(div);
> +	pwm->period_us = period_ns / 1000;
> +
> +	pwm_update(pwm);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(pwm_config);
> +
> +static void __pwm_enable(struct pwm_device *pwm, int enable)
> +{
> +	if (enable)
> +		__mxs_setl(PWM_ENABLE(pwm->pwm_id), pwm_base_common + REG_PWM_CTRL);
> +	else
> +		__mxs_clrl(PWM_ENABLE(pwm->pwm_id), pwm_base_common + REG_PWM_CTRL);
> +}
> +
> +int pwm_enable(struct pwm_device *pwm)
> +{
> +	int rc = 0;
> +
> +	dev_dbg(pwm->dev, "enable\n");
> +
> +	if (!pwm->enabled) {
> +		rc = clk_enable(pwm->clk);
> +		if (!rc) {
> +			pwm->enabled = 1;
> +			__pwm_enable(pwm, 1);
> +			pwm_update(pwm);
> +		}
> +	}
> +	return rc;
> +}
> +EXPORT_SYMBOL(pwm_enable);
> +
> +void pwm_disable(struct pwm_device *pwm)
> +{
> +	dev_dbg(pwm->dev, "disable\n");
> +
> +	if (pwm->enabled) {
> +		/*
> +		 * We need a little delay here, it takes one period for
> +		 * the last pwm_config call to take effect. If we disable
> +		 * the pwm too early it just freezes the current output
> +		 * state.
> +		 */
> +		usleep_range(pwm->period_us, pwm->period_us * 2);
> +		__pwm_enable(pwm, 0);
> +		clk_disable(pwm->clk);
> +		pwm->enabled = 0;
> +	}
> +}
> +EXPORT_SYMBOL(pwm_disable);
> +
> +static DEFINE_MUTEX(pwm_lock);
> +static LIST_HEAD(pwm_list);
> +
> +struct pwm_device *pwm_request(int pwm_id, const char *label)
> +{
> +	struct pwm_device *pwm;
> +	int found = 0;
> +
> +	mutex_lock(&pwm_lock);
> +
> +	list_for_each_entry(pwm, &pwm_list, node) {
> +		if (pwm->pwm_id == pwm_id) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	if (found) {
> +		if (pwm->use_count == 0) {
> +			pwm->use_count++;
> +			pwm->label = label;
> +		} else
> +			pwm = ERR_PTR(-EBUSY);
> +	} else
> +		pwm = ERR_PTR(-ENOENT);

else branches should have braces because if-block has, too

> +
> +	mutex_unlock(&pwm_lock);
> +
> +	return pwm;
> +}
> +EXPORT_SYMBOL(pwm_request);
> +
> +void pwm_free(struct pwm_device *pwm)
> +{
> +	mutex_lock(&pwm_lock);
> +
> +	if (pwm->use_count) {
> +		pwm->use_count--;
> +		pwm->label = NULL;
> +	} else
> +		pr_warning("PWM device already freed\n");

dev_warning?

> +
> +	mutex_unlock(&pwm_lock);
> +}
> +EXPORT_SYMBOL(pwm_free);
> +
> +static int __devinit mxs_pwm_probe(struct platform_device *pdev)
> +{
> +	struct pwm_device *pwm;
> +	struct resource *r;
> +	int ret = 0;
> +
> +	pwm = kzalloc(sizeof(struct pwm_device), GFP_KERNEL);
> +	if (pwm == NULL) {
> +		dev_err(&pdev->dev, "failed to allocate memory\n");
> +		return -ENOMEM;
> +	}

Turn into a managed device(devm_*)?

> +
> +	pwm->clk = clk_get(&pdev->dev, NULL);
> +
> +	if (IS_ERR(pwm->clk)) {
> +		ret = PTR_ERR(pwm->clk);
> +		goto err_free;
> +	}
> +
> +	pwm->enabled = 0;
> +
> +	pwm->use_count = 0;
> +	pwm->pwm_id = pdev->id;
> +	pwm->dev = &pdev->dev;
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (r == NULL) {
> +		dev_err(&pdev->dev, "no memory resource defined\n");
> +		ret = -ENODEV;
> +		goto err_free_clk;
> +	}
> +
> +	r = request_mem_region(r->start, resource_size(r), pdev->name);
> +	if (r == NULL) {
> +		dev_err(&pdev->dev, "failed to request memory resource\n");
> +		ret = -EBUSY;
> +		goto err_free_clk;
> +	}
> +
> +	pwm->mmio_base = ioremap(r->start, resource_size(r));
> +	if (pwm->mmio_base == NULL) {
> +		dev_err(&pdev->dev, "failed to ioremap() registers\n");
> +		ret = -ENODEV;
> +		goto err_free_mem;
> +	}
> +
> +	mutex_lock(&pwm_lock);
> +	list_add_tail(&pwm->node, &pwm_list);
> +	mutex_unlock(&pwm_lock);
> +
> +	platform_set_drvdata(pdev, pwm);
> +	return 0;
> +
> +err_free_mem:
> +	release_mem_region(r->start, resource_size(r));
> +err_free_clk:
> +	clk_put(pwm->clk);
> +err_free:
> +	kfree(pwm);
> +	return ret;
> +}
> +
> +static int __devexit mxs_pwm_remove(struct platform_device *pdev)
> +{
> +	struct pwm_device *pwm;
> +	struct resource *r;
> +
> +	pwm = platform_get_drvdata(pdev);
> +	if (pwm == NULL)
> +		return -ENODEV;
> +
> +	mutex_lock(&pwm_lock);
> +	list_del(&pwm->node);
> +	mutex_unlock(&pwm_lock);
> +
> +	iounmap(pwm->mmio_base);
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	release_mem_region(r->start, resource_size(r));
> +
> +	clk_put(pwm->clk);
> +
> +	kfree(pwm);
> +	return 0;
> +}
> +
> +static struct platform_driver mxs_pwm_driver = {
> +	.driver		= {
> +		.name	= "mxs-pwm",
> +	},
> +	.probe		= mxs_pwm_probe,
> +	.remove		= __devexit_p(mxs_pwm_remove),
> +};
> +
> +static int __init mxs_pwm_init(void)
> +{
> +	if (cpu_is_mx28())
> +		pwm_base_common = MX28_IO_ADDRESS(MX28_PWM_BASE_ADDR);
> +	else
> +		pwm_base_common = MX23_IO_ADDRESS(MX23_PWM_BASE_ADDR);
> +
> +	__mxs_clrl(PWM_SFTRST | PWM_CLKGATE, pwm_base_common + REG_PWM_CTRL);
> +
> +	return platform_driver_register(&mxs_pwm_driver);
> +}
> +arch_initcall(mxs_pwm_init);
> +
> +static void __exit mxs_pwm_exit(void)
> +{
> +	platform_driver_unregister(&mxs_pwm_driver);
> +}
> +module_exit(mxs_pwm_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
> -- 
> 1.7.2.3
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110127/86353250/attachment.sig>
