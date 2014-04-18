From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Apr 2014 13:43:40 +0200
Subject: [PATCH 2/8] usb: host: xhci-plat: Add support for the Armada
 38x glue code
In-Reply-To: <535108E3.2010208@gmail.com>
References: <1397816563-9000-1-git-send-email-gregory.clement@free-electrons.com>
 <1397816563-9000-3-git-send-email-gregory.clement@free-electrons.com>
 <535108E3.2010208@gmail.com>
Message-ID: <53510FEC.7030803@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

[...]

>> @@ -0,0 +1,21 @@
>> +/*
>> + * Copyright (C) 2014 Marvell
>> + *
>> + * Gregory Clement <gregory.clement@free-electrons.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#ifndef __LINUX_XHCI_MVEBU_H
>> +#define __LINUX_XHCI_MVEBU_H
>> +
>> +#ifdef CONFIG_USB_XHCI_MVEBU
>> +int xhci_mvebu_probe(struct platform_device *pdev);
>> +int xhci_mvebu_remove(struct platform_device *pdev);
>> +#else
>> +#define xhci_mvebu_probe NULL
>> +#define xhci_mvebu_remove NULL
>> +#endif
>> +#endif /* __LINUX_XHCI_MVEBU_H */
>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>> index 8029cc82edc4..f1261d3848a9 100644
>> --- a/drivers/usb/host/xhci-plat.c
>> +++ b/drivers/usb/host/xhci-plat.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/of_device.h>
>>  
>>  #include "xhci.h"
>> +#include "xhci-mvebu.h"
>>  
>>  static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
>>  {
>> @@ -250,6 +251,11 @@ static const struct dev_pm_ops xhci_plat_pm_ops = {
>>  #endif /* CONFIG_PM */
>>  
>>  #ifdef CONFIG_OF
> 
> Gregory,
> 
> either you should #ifndef CONFIG_USB_XHCI_MVEBU this and the one below -
> or even better:

With the current code we don't need to add this, see xhci-mvebu.h: xhci_mvebu_*
are set to NULL if CONFIG_USB_XHCI_MVEBU is not define. Then the driver
is more multiplatform friendly.

> 
> Can you put driver stub with its of_match_table right into xhci-mvebu?
> That way platform specific probe wouldn't pollute the generic driver.

This sound more interesting. However the only "pollution" is to extend
the compatible list, the platform specific code is in is own file. Moreover
it could make sens to have all the compatible strings at the same place.

I wait for the opinion of the USB maintainers for this point.

Thanks,

Gregory

> 
> Greg will have a better opinion about it, but I remember some cleanup
> in ehci, that basically removed platform specific references from the
> generic code.
> 
>> +struct xhci_plat_ops xhci_plat_mvebu = {
>> +	.probe =  xhci_mvebu_probe,
>> +	.remove =  xhci_mvebu_remove,
>> +};
>> +
>>  static const struct of_device_id usb_xhci_of_match[] = {
>>  	{
>>  		.compatible = "generic-xhci",
>> @@ -259,6 +265,10 @@ static const struct of_device_id usb_xhci_of_match[] = {
>>  		.compatible = "xhci-platform",
>>  		.data = (void *) &xhci_plat_default,
>>  	},
>> +	{
>> +		.compatible = "marvell,xhci-armada-380",
> 
> nit: the ususal order we use on mvebu is "marvell,<soc>-<ip>", so this
> should be "marvell,armada-380-xhci".
> 
> Sebastian
> 
>> +		.data = (void *) &xhci_plat_mvebu,
>> +	},
>>  	{ },
>>  };
>>  MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
>>
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
