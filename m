From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 19 Jul 2016 11:04:23 +0200
Subject: [PATCH v2 2/4] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <20160718125753.GF4199@lukather>
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-3-git-send-email-quentin.schulz@free-electrons.com>
 <20160718125753.GF4199@lukather>
Message-ID: <578DED17.7040309@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/2016 14:57, Maxime Ripard wrote:
> On Fri, Jul 15, 2016 at 11:59:12AM +0200, Quentin Schulz wrote:
>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>> controller and a thermal sensor. This patch adds the ADC driver which is
>> based on the MFD for the same SoCs ADC.
>>
>> This also registers the thermal adc channel in the iio map array so
>> iio_hwmon could use it without modifying the Device Tree.
>>
>> This driver probes on three different platform_device_id to take into
>> account slight differences between Allwinner SoCs ADCs.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>
>> v2:
>>  - add SUNXI_GPADC_ prefixes for defines,
>>  - correct typo in Kconfig,
>>  - reorder alphabetically includes, makefile,
>>  - add license header,
>>  - fix architecture variations not being handled in interrupt handlers or
>>    read raw functions,
>>  - fix unability to return negative values from thermal sensor,
>>  - add gotos to reduce code repetition,
>>  - fix irq variable being unsigned int instead of int,
>>  - remove useless dev_err and dev_info,
>>  - deactivate all interrupts if probe fails,
>>  - fix iio_device_register on NULL variable,
>>  - deactivate ADC in the IP when probe fails or when removing driver,
>>
>>  drivers/iio/adc/Kconfig           |  12 ++
>>  drivers/iio/adc/Makefile          |   1 +
>>  drivers/iio/adc/sunxi-gpadc-iio.c | 417 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 430 insertions(+)
>>  create mode 100644 drivers/iio/adc/sunxi-gpadc-iio.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 25378c5..184856f 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -338,6 +338,18 @@ config NAU7802
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called nau7802.
>>  
>> +config SUNXI_ADC
> 
> We try to avoid the SUNXI prefix usually, otherwise this driver will
> have a generic name (or at least is implicitly saying that it supports
> all the sunxi SoCs), while it supports only a subset of those SoCs.
> 

ACK. Will be replaced by SUN4I_GPADC.

>> +	tristate "ADC driver for sunxi platforms"
> 
> And you should also mention which ADC is supported, since we usually
> have several of them.
> 
> Something like "Support for the Allwinner SoCs GPADC"
> 

ACK.

>> +	depends on IIO
>> +	depends on MFD_SUNXI_ADC
> 
> The order of your patches is quite weird. You depend on an option that
> is not present yet?
> 

ACK. Will modify the order of patches to reflect the real order.

>> +	help
>> +	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
>> +	  ADC. This ADC provides 4 channels which can be used as an ADC or as a
>> +	  touchscreen input and one channel for thermal sensor.
>> +
>> +          To compile this driver as a module, choose M here: the module will be
> 
> Your indentation is weird here, and the wrapping is likely to be wrong
> too.
> 

ACK.

[...]
>> @@ -0,0 +1,417 @@
>> +/* ADC driver for sunxi platforms
>> + *
>> + * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
> 
> Your wrapping is wrong.
> 

ACK.

>> + */
>> +
>> +#include <linux/completion.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/driver.h>
>> +#include <linux/iio/machine.h>
>> +#include <linux/mfd/sunxi-gpadc-mfd.h>
>> +
>> +#define SUNXI_GPADC_TP_CTRL0			0x00
>> +#define SUNXI_GPADC_TP_CTRL1			0x04
>> +#define SUNXI_GPADC_TP_CTRL2			0x08
>> +#define SUNXI_GPADC_TP_CTRL3			0x0c
>> +#define SUNXI_GPADC_TP_TPR			0x18
>> +#define SUNXI_GPADC_TP_CDAT			0x1c
>> +#define SUNXI_GPADC_TEMP_DATA			0x20
>> +#define SUNXI_GPADC_TP_DATA			0x24
>> +
>> +/* TP_CTRL0 bits */
>> +#define SUNXI_GPADC_ADC_FIRST_DLY(x)		((x) << 24) /* 8 bits */
>> +#define SUNXI_GPADC_ADC_FIRST_DLY_MODE		BIT(23)
>> +#define SUNXI_GPADC_ADC_CLK_SELECT		BIT(22)
>> +#define SUNXI_GPADC_ADC_CLK_DIVIDER(x)		((x) << 20) /* 2 bits */
>> +#define SUNXI_GPADC_FS_DIV(x)			((x) << 16) /* 4 bits */
>> +#define SUNXI_GPADC_T_ACQ(x)			((x) << 0)  /* 16 bits */
> 
> We usually prefer to have the bits defined directly after the
> registers, and prefixed with the name of the register they belong to.
> 
> Something like SUNXI_GPADC_TP_CTRL_T_ACQ in this case
> 

This modification induces the name of the bits to be really long:
SUNXI_GPADC_TP_CTRL1_SUN6I_TOUCH_PAN_CALI_EN for example. ACK anyway.

>> +
>> +/* TP_CTRL1 bits */
>> +#define SUNXI_GPADC_STYLUS_UP_DEBOUNCE(x)	((x) << 12) /* 8 bits */
>> +#define SUNXI_GPADC_STYLUS_UP_DEBOUNCE_EN	BIT(9)
>> +#define SUNXI_GPADC_TOUCH_PAN_CALI_EN		BIT(6)
>> +#define SUNXI_GPADC_TP_DUAL_EN			BIT(5)
>> +#define SUNXI_GPADC_TP_MODE_EN			BIT(4)
>> +#define SUNXI_GPADC_TP_ADC_SELECT		BIT(3)
>> +#define SUNXI_GPADC_ADC_CHAN_SELECT(x)		((x) << 0)  /* 3 bits */
> 
> Usually the comments are on the line above. However, if you really
> want to enforce something, you should rather mask the
> value. Otherwise, that comment is pretty useless.
> 

Do you mean something like that:
#define SUNXI_GPADC_ADC_CHAN_SELECT(x)		(GENMASK(2,0) & x) ?

>> +
>> +/* TP_CTRL1 bits for sun6i SOCs */
>> +#define SUNXI_GPADC_SUN6I_TOUCH_PAN_CALI_EN	BIT(7)
>> +#define SUNXI_GPADC_SUN6I_TP_DUAL_EN		BIT(6)
>> +#define SUNXI_GPADC_SUN6I_TP_MODE_EN		BIT(5)
>> +#define SUNXI_GPADC_SUN6I_TP_ADC_SELECT		BIT(4)
> 
> Shouldn't that go in either a common define or the touchscreen driver?
> 

Then shouldn't I put all defines in a common header? (sunxi-gpadc-mfd.h)

[...]
>> +/* TP_TPR bits */
>> +#define SUNXI_GPADC_TEMP_ENABLE(x)		((x) << 16)
>> +/* t = x * 256 * 16 / clkin */
> 
> That comment would be better next to the code that does that
> computation.
> 

ACK.

[...]
>> +	reinit_completion(&info->completion);
>> +	if (info->flags & SUNXI_GPADC_ARCH_SUN6I)
>> +		regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
>> +			     SUNXI_GPADC_SUN6I_TP_MODE_EN |
>> +			     SUNXI_GPADC_SUN6I_TP_ADC_SELECT |
>> +			     SUNXI_GPADC_SUN6I_ADC_CHAN_SELECT(channel));
>> +	else
>> +		regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
>> +			     SUNXI_GPADC_TP_MODE_EN |
>> +			     SUNXI_GPADC_TP_ADC_SELECT |
>> +			     SUNXI_GPADC_ADC_CHAN_SELECT(channel));
> 
> Using a function pointer that would compute this, or some fields in a
> structure to store this would be better.
> 

ACK.

[...]
>> +	if (info->flags & SUNXI_GPADC_ARCH_SUN4I)
>> +		*val = info->temp_data * 133 - 257000;
>> +	else if (info->flags & SUNXI_GPADC_ARCH_SUN5I)
>> +		*val = info->temp_data * 100 - 144700;
>> +	else if (info->flags & SUNXI_GPADC_ARCH_SUN6I)
>> +		*val = info->temp_data * 167 - 271000;
> 
> Ditto, having functions to comptue this and just store the function
> pointer would be better.
> 

As Jonathan suggests, we should better go with separate read_raws
(IIO_CHAN_RAW returns info->temp_data, INFO_CHAN_SCALE and
INFO_CHAN_OFFSET return a different value depending on the
architecture). So this would split the above code in separate functions
as you wanted.

[...]
>> +	irq = platform_get_irq_byname(pdev, "TEMP_DATA_PENDING");
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev,
>> +			"no TEMP_DATA_PENDING interrupt registered\n");
>> +		ret = irq;
>> +		goto err;
>> +	}
>> +
>> +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
>> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
>> +					   sunxi_gpadc_temp_data_irq_handler, 0,
>> +					   "temp_data", info);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev,
>> +			"could not request TEMP_DATA_PENDING interrupt: %d\n",
>> +			ret);
>> +		goto err;
>> +	}
>> +
>> +	info->temp_data_irq = irq;
>> +	disable_irq(irq);
>> +
>> +	irq = platform_get_irq_byname(pdev, "FIFO_DATA_PENDING");
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev,
>> +			"no FIFO_DATA_PENDING interrupt registered\n");
>> +		ret = irq;
>> +		goto err;
>> +	}
>> +
>> +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
>> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
>> +					   sunxi_gpadc_fifo_data_irq_handler,
>> +					   0, "fifo_data", info);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev,
>> +			"could not request FIFO_DATA_PENDING interrupt: %d\n",
>> +			ret);
>> +		goto err;
>> +	}
>> +
>> +	info->fifo_data_irq = irq;
>> +	disable_irq(irq);
> 
> request_irq starts with irq enabled, which means that you can have an
> interrupt showing up between your call to request_irq and the
> disable_irq. 
> 
> How would that work?
> 

Same as what I answered in Jonathan's mail:

"Once the interrupt is activated, the IP performs continuous conversions
(temp_data_irq only periodically). I want these interrupts to be enabled
only when I read the sysfs file or we get useless interrupts.
In the current state of this driver's irq handlers, I only set values in
structures and all the needed structures are already initialized before
requesting irqs. So it does not look like a race. I can prevent races in
future versions by adding an atomic flag if wanted."

>> +
>> +	ret = iio_map_array_register(indio_dev, sunxi_gpadc_hwmon_maps);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "failed to register iio map array\n");
>> +		goto err;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, indio_dev);
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "could not register the device\n");
>> +		iio_map_array_unregister(indio_dev);
> 
> That should go in a separate label.
> 

ACK.

>> +		goto err;
>> +	}
>> +
>> +	return 0;
>> +
>> +err:
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1, 0);
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_TPR, 0);
> 
> Why is that needed?
> 

This disables ADC and Temperature on the hardware side of the IP.
(mainly a shortcut to SUNXI_GPADC_TP_MODE_EN (or its architecture
variant) and SUNXI_GPADC_TEMP_ENABLE set to 0.

>> +	return ret;
>> +}
>> +
>> +static int sunxi_gpadc_remove(struct platform_device *pdev)
>> +{
>> +	struct sunxi_gpadc_dev *info;
>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +
>> +	info = iio_priv(indio_dev);
>> +	iio_device_unregister(indio_dev);
>> +	iio_map_array_unregister(indio_dev);
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC, 0);
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1, 0);
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_TPR, 0);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct platform_device_id sunxi_gpadc_id[] = {
>> +	{ "sun4i-a10-gpadc-iio", SUNXI_GPADC_ARCH_SUN4I },
>> +	{ "sun5i-a13-gpadc-iio", SUNXI_GPADC_ARCH_SUN5I },
>> +	{ "sun6i-a31-gpadc-iio", SUNXI_GPADC_ARCH_SUN6I },
>> +	{ /* sentinel */ },
>> +};
>> +
>> +static struct platform_driver sunxi_gpadc_driver = {
>> +	.driver = {
>> +		.name = "sunxi-gpadc-iio",
>> +	},
>> +	.id_table = sunxi_gpadc_id,
>> +	.probe = sunxi_gpadc_probe,
>> +	.remove = sunxi_gpadc_remove,
>> +};
> 
> Having some runtime_pm support for this would be great too.
> 

Basically disabling the ADC and interrupts (as in the remove) in
_suspend and _idle and reenabling everything in "before _suspend"-state
in _resume I guess?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160719/c5f00a2e/attachment-0001.sig>
