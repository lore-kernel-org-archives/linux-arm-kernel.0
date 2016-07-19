From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 19 Jul 2016 14:04:06 +0200
Subject: [PATCH v2 3/4] mfd: add support for Allwinner SoCs ADC
In-Reply-To: <20160718130218.GG4199@lukather>
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-4-git-send-email-quentin.schulz@free-electrons.com>
 <20160718130218.GG4199@lukather>
Message-ID: <578E1736.20209@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/2016 15:02, Maxime Ripard wrote:
> On Fri, Jul 15, 2016 at 11:59:13AM +0200, Quentin Schulz wrote:
>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>> controller and a thermal sensor. For now, only the ADC and the thermal
>> sensor drivers are probed by the MFD, the touchscreen controller support
>> will be added later.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
[...]
>> +config MFD_SUNXI_ADC
>> +	tristate "ADC MFD core driver for sunxi platforms"
>> +	select MFD_CORE
>> +	select REGMAP_MMIO
> 
> It should also depends on the architectures supported (and probably COMPILE_TEST)
> 

ACK.

[...]
>> +
>> +	sunxi_gpadc_mfd_dev->regmap =
>> +		devm_regmap_init_mmio(sunxi_gpadc_mfd_dev->dev,
>> +				      sunxi_gpadc_mfd_dev->regs,
>> +				      &sunxi_gpadc_mfd_regmap_config);
> 
> This is usually on a single line (even if it exceeds 80 chars). Or
> maybe you can use a shorter variable name (like dev, or mfd).
> 

I'll go with a shorter name.

>> +	if (IS_ERR(sunxi_gpadc_mfd_dev->regmap)) {
>> +		ret = PTR_ERR(sunxi_gpadc_mfd_dev->regmap);
>> +		dev_err(&pdev->dev, "failed to init regmap: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	ret = regmap_add_irq_chip(sunxi_gpadc_mfd_dev->regmap, irq,
>> +				  IRQF_ONESHOT, 0,
>> +				  &sunxi_gpadc_mfd_regmap_irq_chip,
>> +				  &sunxi_gpadc_mfd_dev->regmap_irqc);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to add irq chip: %d\n", ret);
>> +		return ret;
>> +	}
> 
> You should probably make sure that you clear all the interrupts before
> enabling them.
> 

ACK. Thanks, didn't think of that.

>> +	if (of_device_is_compatible(pdev->dev.of_node,
>> +				    "allwinner,sun4i-a10-ts"))
>> +		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> +				      sun4i_gpadc_mfd_cells,
>> +				      ARRAY_SIZE(sun4i_gpadc_mfd_cells), NULL,
>> +				      0, NULL);
>> +	else if (of_device_is_compatible(pdev->dev.of_node,
>> +					 "allwinner,sun5i-a13-ts"))
>> +		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> +				      sun5i_gpadc_mfd_cells,
>> +				      ARRAY_SIZE(sun5i_gpadc_mfd_cells), NULL,
>> +				      0, NULL);
>> +	else if (of_device_is_compatible(pdev->dev.of_node,
>> +					 "allwinner,sun6i-a31-ts"))
>> +		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
>> +				      sun6i_gpadc_mfd_cells,
>> +				      ARRAY_SIZE(sun6i_gpadc_mfd_cells), NULL,
>> +				      0, NULL);
> 
> This huge if / else can be removed by putting those structures in the
> data pointer of of_device_id.
> 

Indeed. It is what I am using for the ADC driver, don't know why I
didn't think of this for the MFD as well.

[...]
>> diff --git a/include/linux/mfd/sunxi-gpadc-mfd.h b/include/linux/mfd/sunxi-gpadc-mfd.h
>> new file mode 100644
>> index 0000000..7155845
>> --- /dev/null
>> +++ b/include/linux/mfd/sunxi-gpadc-mfd.h
>> @@ -0,0 +1,23 @@
>> +/* Header of ADC MFD core driver for sunxi platforms
>> + *
>> + * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + */
>> +
>> +#ifndef __SUNXI_GPADC_MFD__H__
>> +#define __SUNXI_GPADC_MFD__H__
>> +
>> +#define SUNXI_GPADC_TP_INT_FIFOC            0x10
>> +#define SUNXI_GPADC_TP_INT_FIFOS            0x14
> 
> Why do you declare only these two registers there?
> 

Because these are used by the MFD while the others not. Maybe it's
better to put all register and bit defines in sunxi-gpadc-mfd.h? Anyway,
just found out it would be clearer to use the defines for the interrupts
rather than directly "BIT(x)". So that makes two more defines here.
Should we put everything in sunxi-gpadc-mfd.h since the MFD is needed
for the ADC, (future) touchscreen and iio_hwmon drivers?


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160719/e8f07835/attachment.sig>
