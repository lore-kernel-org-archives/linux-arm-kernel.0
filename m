From: rjui@broadcom.com (Ray Jui)
Date: Tue, 3 Feb 2015 11:29:36 -0800
Subject: [PATCH v3 3/4] pinctrl: cygnus: add initial IOMUX driver support
In-Reply-To: <20150203174042.GA15969@dtor-ws>
References: <rjui@broadcom.com>
 <1422928894-20716-1-git-send-email-rjui@broadcom.com>
 <1422928894-20716-4-git-send-email-rjui@broadcom.com>
 <20150203174042.GA15969@dtor-ws>
Message-ID: <54D121A0.6070602@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2/3/2015 9:40 AM, Dmitry Torokhov wrote:
> Hi Ray,
> 
> On Mon, Feb 02, 2015 at 06:01:33PM -0800, Ray Jui wrote:
>> This adds the initial driver support for the Broadcom Cygnus IOMUX
>> controller. The Cygnus IOMUX controller supports group based mux
>> configuration but allows certain pins to be muxed to GPIO individually
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> 
> Just a few random nits/comments...
> 
>> ---
>>  drivers/pinctrl/bcm/Kconfig              |   13 +
>>  drivers/pinctrl/bcm/Makefile             |    5 +-
>>  drivers/pinctrl/bcm/pinctrl-cygnus-mux.c | 1087 ++++++++++++++++++++++++++++++
>>  3 files changed, 1103 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
>>
>> diff --git a/drivers/pinctrl/bcm/Kconfig b/drivers/pinctrl/bcm/Kconfig
>> index bc6d048..eb13201 100644
>> --- a/drivers/pinctrl/bcm/Kconfig
>> +++ b/drivers/pinctrl/bcm/Kconfig
>> @@ -19,3 +19,16 @@ config PINCTRL_BCM2835
>>  	bool
>>  	select PINMUX
>>  	select PINCONF
>> +
>> +config PINCTRL_CYGNUS_MUX
>> +	bool "Broadcom Cygnus IOMUX driver"
>> +	depends on (ARCH_BCM_CYGNUS || COMPILE_TEST)
>> +	select PINMUX
>> +	select GENERIC_PINCONF
>> +	default ARCH_BCM_CYGNUS
>> +	help
>> +	  Say yes here to enable the Broadcom Cygnus IOMUX driver.
>> +
>> +	  The Broadcom Cygnus IOMUX driver supports group based IOMUX
>> +	  configuration, with the exception that certain individual pins
>> +	  can be overrided to GPIO function
>> diff --git a/drivers/pinctrl/bcm/Makefile b/drivers/pinctrl/bcm/Makefile
>> index 7ba80a3..bb6beb6 100644
>> --- a/drivers/pinctrl/bcm/Makefile
>> +++ b/drivers/pinctrl/bcm/Makefile
>> @@ -1,4 +1,5 @@
>>  # Broadcom pinctrl support
>>  
>> -obj-$(CONFIG_PINCTRL_BCM281XX)	+= pinctrl-bcm281xx.o
>> -obj-$(CONFIG_PINCTRL_BCM2835)	+= pinctrl-bcm2835.o
>> +obj-$(CONFIG_PINCTRL_BCM281XX)		+= pinctrl-bcm281xx.o
>> +obj-$(CONFIG_PINCTRL_BCM2835)		+= pinctrl-bcm2835.o
>> +obj-$(CONFIG_PINCTRL_CYGNUS_MUX)	+= pinctrl-cygnus-mux.o
>> diff --git a/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c b/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
>> new file mode 100644
>> index 0000000..33565b4
>> --- /dev/null
>> +++ b/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
>> @@ -0,0 +1,1087 @@
>> +/* Copyright (C) 2014-2015 Broadcom Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * This file contains the Cygnus IOMUX driver that supports group based PINMUX
>> + * configuration. Although PINMUX configuration is mainly group based, the
>> + * Cygnus IOMUX controller allows certain pins to be individually muxed to GPIO
>> + * function, and therefore be controlled by the Cygnus ASIU GPIO controller
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pinctrl/pinctrl.h>
>> +#include <linux/pinctrl/pinmux.h>
>> +#include <linux/pinctrl/pinconf.h>
>> +#include <linux/pinctrl/pinconf-generic.h>
>> +#include "../core.h"
>> +#include "../pinctrl-utils.h"
>> +
>> +#define CYGNUS_NUM_IOMUX_REGS     8
>> +#define CYGNUS_NUM_MUX_PER_REG    8
>> +#define CYGNUS_NUM_IOMUX          (CYGNUS_NUM_IOMUX_REGS * \
>> +				   CYGNUS_NUM_MUX_PER_REG)
>> +
>> +/*
>> + * Cygnus IOMUX register description
>> + *
>> + * @offset: register offset for mux configuration of a group
>> + * @shift: bit shift for mux configuration of a group
>> + * @alt: alternate function to set to
>> + */
>> +struct cygnus_mux {
>> +	unsigned int offset;
>> +	unsigned int shift;
>> +	unsigned int alt;
>> +};
>> +
>> +/*
>> + * Keep track of Cygnus IOMUX configuration and prevent double configuration
>> + *
>> + * @cygnus_mux: Cygnus IOMUX register description
>> + * @is_configured: flag to indicate whether a mux setting has already been
>> + * configured
>> + */
>> +struct cygnus_mux_log {
>> +	struct cygnus_mux mux;
>> +	bool is_configured;
>> +};
>> +
>> +/*
>> + * Group based IOMUX configuration
>> + *
>> + * @name: name of the group
>> + * @pins: array of pins used by this group
>> + * @num_pins: total number of pins used by this group
>> + * @mux: Cygnus group based IOMUX configuration
>> + */
>> +struct cygnus_pin_group {
>> +	const char *name;
>> +	const unsigned *pins;
>> +	const unsigned num_pins;
>> +	const struct cygnus_mux mux;
> 
> Not: the last 2 consts are quite weird - if you want to make an instance
> of cygnus_pin_group immutable you declare it as a const (and I see you
> are already doing that below). With the structure as it laid out
> currently you can only do static initializers.
> 
Right. I'll remove the last two const.

>> +};
>> +
>> +/*
>> + * Cygnus mux function and supported pin groups
>> + *
>> + * @name: name of the function
>> + * @groups: array of groups that can be supported by this function
>> + * @num_groups: total number of groups that can be supported by this function
>> + */
>> +struct cygnus_pin_function {
>> +	const char *name;
>> +	const char * const *groups;
>> +	const unsigned num_groups;
> 
> Here as well.
> 
> ...
> 
Yes. Will remove the last const.

>> +
>> +/*
>> + * List of pins in Cygnus
>> + */
>> +static struct cygnus_pin cygnus_pins[] = {
> 
> const?
> 
I cannot make it const here, since the address of "gpio_mux" is later
passed to pinctrl_pin_desc's private data:

pins[i].drv_data = &cygnus_pins[i].gpio_mux;

>> +	CYGNUS_PIN_DESC(0, "ext_device_reset_n", 0, 0, 0),
>> +	CYGNUS_PIN_DESC(1, "chip_mode0", 0, 0, 0),
> 
> ...
> 
>> +#define CYGNUS_PIN_GROUP(group_name, off, sh, al)	\
>> +{							\
>> +	.name = #group_name"""_grp",			\
> 
> Why do we need extra pair of quotes? BTW we can also do
> 
> 	.name = __stringify(group_name) "_grp",
> 
Okay. I will change to use __stringify. Thanks.

>> +	.pins = group_name ## _pins,			\
>> +	.num_pins = ARRAY_SIZE(group_name ## _pins),	\
>> +	.mux = {					\
>> +		.offset = off,				\
>> +		.shift = sh,				\
>> +		.alt = al,				\
>> +	}						\
>> +}
> 
> ...
> 
>> +
>> +static struct pinctrl_ops cygnus_pinctrl_ops = {
> 
> const?
> 
Yes.

>> +	.get_groups_count = cygnus_get_groups_count,
>> +	.get_group_name = cygnus_get_group_name,
>> +	.get_group_pins = cygnus_get_group_pins,
>> +	.pin_dbg_show = cygnus_pin_dbg_show,
>> +	.dt_node_to_map = cygnus_dt_node_to_map,
>> +	.dt_free_map = pinctrl_utils_dt_free_map,
>> +};
>> +
>> +static int cygnus_get_functions_count(struct pinctrl_dev *pctrl_dev)
>> +{
>> +	struct cygnus_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctrl_dev);
>> +
>> +	return pinctrl->num_functions;
>> +}
>> +
>> +static const char *cygnus_get_function_name(struct pinctrl_dev *pctrl_dev,
>> +					    unsigned selector)
>> +{
>> +	struct cygnus_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctrl_dev);
>> +
>> +	return pinctrl->functions[selector].name;
>> +}
>> +
>> +static int cygnus_get_function_groups(struct pinctrl_dev *pctrl_dev,
>> +				      unsigned selector,
>> +				      const char * const **groups,
>> +				      unsigned * const num_groups)
>> +{
>> +	struct cygnus_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctrl_dev);
>> +
>> +	*groups = pinctrl->functions[selector].groups;
>> +	*num_groups = pinctrl->functions[selector].num_groups;
>> +
>> +	return 0;
>> +}
>> +
>> +static int cygnus_pinmux_set(struct cygnus_pinctrl *pinctrl,
>> +			     const struct cygnus_pin_function *func,
>> +			     const struct cygnus_pin_group *grp,
>> +			     struct cygnus_mux_log *mux_log)
>> +{
>> +	const struct cygnus_mux *mux = &grp->mux;
>> +	int i;
>> +	u32 val, mask = 0x7;
>> +	unsigned long flags;
>> +
>> +	for (i = 0; i < CYGNUS_NUM_IOMUX; i++) {
>> +		if (mux->offset != mux_log[i].mux.offset ||
>> +		    mux->shift != mux_log[i].mux.shift)
>> +			continue;
>> +
>> +		/* match found if we reach here */
>> +
>> +		/* if this is a new configuration, just do it! */
>> +		if (!mux_log[i].is_configured)
>> +			break;
>> +
>> +		/*
>> +		 * IOMUX has been configured previously and one is trying to
>> +		 * configure it to a different function
>> +		 */
>> +		if (mux_log[i].mux.alt != mux->alt) {
>> +			dev_err(pinctrl->dev,
>> +				"double configuration error detected!\n");
>> +			dev_err(pinctrl->dev, "func:%s grp:%s\n",
>> +				func->name, grp->name);
>> +			return -EINVAL;
>> +		} else {
>> +			/*
>> +			 * One tries to configure it to the same function.
>> +			 * Just quit and don't bother
>> +			 */
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	mux_log[i].mux.alt = mux->alt;
>> +	mux_log[i].is_configured = true;
>> +
>> +	spin_lock_irqsave(&pinctrl->lock, flags);
>> +
>> +	val = readl(pinctrl->base0 + grp->mux.offset);
>> +	val &= ~(mask << grp->mux.shift);
>> +	val |= grp->mux.alt << grp->mux.shift;
>> +	writel(val, pinctrl->base0 + grp->mux.offset);
>> +
>> +	spin_unlock_irqrestore(&pinctrl->lock, flags);
>> +
>> +	return 0;
>> +}
>> +
>> +static int cygnus_pinmux_set_mux(struct pinctrl_dev *pctrl_dev,
>> +				 unsigned func_select, unsigned grp_select)
>> +{
>> +	struct cygnus_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctrl_dev);
>> +	const struct cygnus_pin_function *func =
>> +		&pinctrl->functions[func_select];
>> +	const struct cygnus_pin_group *grp = &pinctrl->groups[grp_select];
>> +
>> +	dev_dbg(pctrl_dev->dev, "func:%u name:%s grp:%u name:%s\n",
>> +		func_select, func->name, grp_select, grp->name);
>> +
>> +	dev_dbg(pctrl_dev->dev, "offset:0x%08x shift:%u alt:%u\n",
>> +		grp->mux.offset, grp->mux.shift, grp->mux.alt);
>> +
>> +	return cygnus_pinmux_set(pinctrl, func, grp, pinctrl->mux_log);
>> +}
>> +
>> +static int cygnus_gpio_request_enable(struct pinctrl_dev *pctrl_dev,
>> +				      struct pinctrl_gpio_range *range,
>> +				      unsigned pin)
>> +{
>> +	struct cygnus_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctrl_dev);
>> +	struct cygnus_gpio_mux *mux = pctrl_dev->desc->pins[pin].drv_data;
> 
> const?
> 
Yes.

>> +	u32 val;
>> +	unsigned long flags;
>> +
>> +	/* not all pins support GPIO pinmux override */
>> +	if (!mux->is_supported)
>> +		return -ENOTSUPP;
>> +
>> +	spin_lock_irqsave(&pinctrl->lock, flags);
>> +
>> +	val = readl(pinctrl->base1 + mux->offset);
>> +	val |= 0x3 << mux->shift;
>> +	writel(val, pinctrl->base1 + mux->offset);
>> +
>> +	spin_unlock_irqrestore(&pinctrl->lock, flags);
>> +
>> +	dev_dbg(pctrl_dev->dev,
>> +		"gpio request enable pin=%u offset=0x%x shift=%u\n",
>> +		pin, mux->offset, mux->shift);
>> +
>> +	return 0;
>> +}
>> +
>> +static void cygnus_gpio_disable_free(struct pinctrl_dev *pctrl_dev,
>> +				     struct pinctrl_gpio_range *range,
>> +				     unsigned pin)
>> +{
>> +	struct cygnus_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctrl_dev);
>> +	struct cygnus_gpio_mux *mux = pctrl_dev->desc->pins[pin].drv_data;
>> +	u32 val;
>> +	unsigned long flags;
>> +
>> +	if (!mux->is_supported)
>> +		return;
>> +
>> +	spin_lock_irqsave(&pinctrl->lock, flags);
>> +
>> +	val = readl(pinctrl->base1 + mux->offset);
>> +	val &= ~(0x3 << mux->shift);
>> +	writel(val, pinctrl->base1 + mux->offset);
>> +
>> +	spin_unlock_irqrestore(&pinctrl->lock, flags);
>> +
>> +	dev_err(pctrl_dev->dev,
>> +		"gpio disable free pin=%u offset=0x%x shift=%u\n",
>> +		pin, mux->offset, mux->shift);
>> +}
>> +
>> +static struct pinmux_ops cygnus_pinmux_ops = {
> 
> const?
> 
Yes.

>> +	.get_functions_count = cygnus_get_functions_count,
>> +	.get_function_name = cygnus_get_function_name,
>> +	.get_function_groups = cygnus_get_function_groups,
>> +	.set_mux = cygnus_pinmux_set_mux,
>> +	.gpio_request_enable = cygnus_gpio_request_enable,
>> +	.gpio_disable_free = cygnus_gpio_disable_free,
>> +};
>> +
>> +static struct pinctrl_desc cygnus_pinctrl_desc = {
>> +	.name = "cygnus-pinmux",
>> +	.pctlops = &cygnus_pinctrl_ops,
>> +	.pmxops = &cygnus_pinmux_ops,
>> +};
>> +
>> +static int cygnus_mux_log_init(struct cygnus_pinctrl *pinctrl)
>> +{
>> +	struct cygnus_mux_log *log;
>> +	unsigned int i, j;
>> +
>> +	pinctrl->mux_log = devm_kcalloc(pinctrl->dev, CYGNUS_NUM_IOMUX,
>> +					sizeof(struct cygnus_mux_log),
>> +					GFP_KERNEL);
>> +	if (!pinctrl->mux_log)
>> +		return -ENOMEM;
>> +
>> +	log = pinctrl->mux_log;
>> +	for (i = 0; i < CYGNUS_NUM_IOMUX_REGS; i++) {
>> +		for (j = 0; j < CYGNUS_NUM_MUX_PER_REG; j++) {
>> +			log = &pinctrl->mux_log[i * CYGNUS_NUM_MUX_PER_REG
>> +				+ j];
>> +			log->mux.offset = i * 4;
>> +			log->mux.shift = j * 4;
>> +			log->mux.alt = 0;
>> +			log->is_configured = false;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int cygnus_pinmux_probe(struct platform_device *pdev)
>> +{
>> +	struct cygnus_pinctrl *pinctrl;
>> +	struct resource *res;
>> +	int i, ret;
>> +	struct pinctrl_pin_desc *pins;
>> +	unsigned num_pins = ARRAY_SIZE(cygnus_pins);
>> +
>> +	pinctrl = devm_kzalloc(&pdev->dev, sizeof(*pinctrl), GFP_KERNEL);
>> +	if (!pinctrl)
>> +		return -ENOMEM;
>> +
>> +	pinctrl->dev = &pdev->dev;
>> +	platform_set_drvdata(pdev, pinctrl);
>> +	spin_lock_init(&pinctrl->lock);
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	pinctrl->base0 = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(pinctrl->base0)) {
>> +		dev_err(&pdev->dev, "unable to map I/O space\n");
>> +		return PTR_ERR(pinctrl->base0);
>> +	}
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	pinctrl->base1 = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(pinctrl->base1)) {
>> +		dev_err(&pdev->dev, "unable to map I/O space\n");
>> +		return PTR_ERR(pinctrl->base1);
>> +	}
>> +
>> +	ret = cygnus_mux_log_init(pinctrl);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "unable to initialize IOMUX log\n");
>> +		return ret;
>> +	}
>> +
>> +	pins = devm_kcalloc(&pdev->dev, num_pins, sizeof(*pins), GFP_KERNEL);
>> +	if (!pins)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < num_pins; i++) {
>> +		pins[i].number = cygnus_pins[i].pin;
>> +		pins[i].name = cygnus_pins[i].name;
>> +		pins[i].drv_data = &cygnus_pins[i].gpio_mux;
>> +	}
>> +
>> +	pinctrl->groups = cygnus_pin_groups;
>> +	pinctrl->num_groups = ARRAY_SIZE(cygnus_pin_groups);
>> +	pinctrl->functions = cygnus_pin_functions;
>> +	pinctrl->num_functions = ARRAY_SIZE(cygnus_pin_functions);
>> +	cygnus_pinctrl_desc.pins = pins;
>> +	cygnus_pinctrl_desc.npins = num_pins;
>> +
>> +	pinctrl->pctl = pinctrl_register(&cygnus_pinctrl_desc, &pdev->dev,
>> +			pinctrl);
>> +	if (!pinctrl->pctl) {
>> +		dev_err(&pdev->dev, "unable to register Cygnus IOMUX pinctrl\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct of_device_id cygnus_pinmux_of_match[] = {
>> +	{ .compatible = "brcm,cygnus-pinmux" },
>> +	{ }
>> +};
>> +
>> +static struct platform_driver cygnus_pinmux_driver = {
>> +	.driver = {
>> +		.name = "cygnus-pinmux",
>> +		.of_match_table = cygnus_pinmux_of_match,
>> +	},
>> +	.probe = cygnus_pinmux_probe,
> 
> You also need to either provide remove() method or disallow unbinding
> via sysfs by setting suppress_bind_attrs in platform driver.
> 
I do not expect this driver to ever be compiled as module and
uninstalled at runtime. I'll add .suppress_bind_attrs = true, thanks!
>> +};
>> +
>> +static int __init cygnus_pinmux_init(void)
>> +{
>> +	return platform_driver_register(&cygnus_pinmux_driver);
>> +}
>> +arch_initcall(cygnus_pinmux_init);
>> +
>> +MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
>> +MODULE_DESCRIPTION("Broadcom Cygnus IOMUX driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 1.7.9.5
>>
> 
> Thanks.
> 
Thanks for the review!

Ray
