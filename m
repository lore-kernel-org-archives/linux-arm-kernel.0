From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 29 Oct 2012 01:27:42 +0300
Subject: [PATCH v2 1/5] ARM: PXA: Add z2-usb-switch driver
In-Reply-To: <201210282257.48770.marex@denx.de>
References: <CA+E=qVc1MGPQoWZWQAcv-NEh8WpLoqeTYLQz4iFjiOyfc9CX5w@mail.gmail.com>
 <1351438946-5331-1-git-send-email-anarsoul@gmail.com>
 <201210282257.48770.marex@denx.de>
Message-ID: <CA+E=qVdEPcBobVDODcyjZkbhZD6KXmGR7Fo5T40GRSPWNhujsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 12:57 AM, Marek Vasut <marex@denx.de> wrote:
> Dear Vasily Khoruzhick,

Dear Marek Vasut,

>> This driver controls mode of USB port #2 pins - device or host.
>
> Please supply proper commit message. This short message describes nothing.

OK, "This driver allows user to choose USB port #2 mode between device
and host" - that would be OK?

> [...]
>
>> @@ -0,0 +1,100 @@
>> +/*
>> + * USB mode switcher for Z2
>> + *
>> + * Copyright (c) 2011 Vasily Khoruzhick
>
> 2012

Actually, it was implemented early in 2011, so 2011-2012

>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/delay.h>
>> +
>> +#include <mach/pxa27x.h>
>> +#include <mach/pxa27x-udc.h>
>> +
>> +#include <asm/io.h>
>> +
>> +#define MIN(a, b) ((a) < (b) ? (a) : (b))
>
> min() is already defined in kernel.h

OK

>> +static ssize_t usb_mode_show(struct device *dev, struct device_attribute
>> *attr, +      char *buf)
>> +{
>> +     if (UP2OCR & UP2OCR_HXS)
>> +             return sprintf(buf, "host\n");
>> +     else
>> +             return sprintf(buf, "device\n");
>> +}
>> +
>> +static ssize_t usb_mode_set(struct device *dev, struct device_attribute
>> *attr, +      const char *buf, size_t count)
>> +{
>> +     if (strncmp(buf, "host", MIN(count, 4)) == 0) {
>> +             UP2OCR = UP2OCR_HXS | UP2OCR_HXOE | UP2OCR_DPPDE | UP2OCR_DMPDE;
>> +             return count;
>> +     } else if (strncmp(buf, "device", MIN(count, 6)) == 0) {
>> +             UP2OCR = UP2OCR_HXOE | UP2OCR_DPPUE;
>> +             return count;
>> +     }
>> +     return -EINVAL;
>> +}
>> +
>> +static DEVICE_ATTR(usb_mode, 0644, usb_mode_show, usb_mode_set);
>
> I wonder if we have no better means to control enforcement of mode.

Why? sysfs fits nicely.

>> +static const struct attribute *attrs[] = {
>> +     &dev_attr_usb_mode.attr,
>> +     NULL,
>> +};
>> +
>> +static const struct attribute_group attr_group = {
>> +     .attrs  = (struct attribute **)attrs,
>> +};
>
> Isn't there some macro to do this assignment?

Will check

>> +static int z2_usb_switch_probe(struct platform_device *dev)
>
> Missing __devinit

OK

>> +{
>> +     int res;
>> +
>> +     res = sysfs_create_group(&dev->dev.kobj, &attr_group);
>> +     if (res)
>> +             return res;
>> +
>> +     UP2OCR = UP2OCR_HXOE | UP2OCR_DPPUE;
>> +
>> +     return 0;
>> +}
>> +
>> +static int __devexit z2_usb_switch_remove(struct platform_device *dev)
>> +{
>> +     UP2OCR = UP2OCR_HXOE;
>> +     sysfs_remove_group(&dev->dev.kobj, &attr_group);
>> +
>> +     return 0;
>> +}
>> +
>> +static struct platform_driver z2_usb_switch_driver = {
>> +     .probe = z2_usb_switch_probe,
>> +     .remove = __devexit_p(z2_usb_switch_remove),
>> +
>> +     .driver = {
>> +             .name = "z2-usb-switch",
>> +             .owner = THIS_MODULE,
>> +     },
>> +};
>> +
>> +
>> +static int __init z2_usb_switch_init(void)
>> +{
>> +     return platform_driver_register(&z2_usb_switch_driver);
>> +}
>> +
>> +static void __exit z2_usb_switch_exit(void)
>> +{
>> +     platform_driver_unregister(&z2_usb_switch_driver);
>> +}
>> +
>> +module_init(z2_usb_switch_init);
>> +module_exit(z2_usb_switch_exit);
>
> module_platform_driver()

OK

> Best regards,
> Marek Vasut

Thanks for review!

Regards
Vasily
