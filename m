From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Sun, 28 Oct 2012 18:03:30 +0100
Subject: [PATCH v2 1/5] ARM: PXA: Add z2-usb-switch driver
In-Reply-To: <1351438946-5331-1-git-send-email-anarsoul@gmail.com>
References: <CA+E=qVc1MGPQoWZWQAcv-NEh8WpLoqeTYLQz4iFjiOyfc9CX5w@mail.gmail.com>
 <1351438946-5331-1-git-send-email-anarsoul@gmail.com>
Message-ID: <CAHod+GfMLV400L4p7=5j1TOGW=66jkBF1_VWx_gRYEF8=T11kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2012 at 4:42 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> This driver controls mode of USB port #2 pins - device or host.
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-pxa/Kconfig         |   7 +++
>  arch/arm/mach-pxa/Makefile        |   1 +
>  arch/arm/mach-pxa/z2-usb-switch.c | 100 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 arch/arm/mach-pxa/z2-usb-switch.c
>
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 11aa739..5fffc4b 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -630,6 +630,13 @@ config MACH_ZIPIT2
>         bool "Zipit Z2 Handheld"
>         select HAVE_PWM
>         select PXA27x
> +
> +config Z2_USB_SWITCH
> +       tristate "Control the state of USB port on Zipit Z2"
> +       depends on MACH_ZIPIT2
> +       help
> +         This is a simple driver that is able to control
> +         usb mode of Zipit Z2
>  endif
>  endmenu
>
> diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
> index ee88d6e..86a032f 100644
> --- a/arch/arm/mach-pxa/Makefile
> +++ b/arch/arm/mach-pxa/Makefile
> @@ -99,3 +99,4 @@ obj-$(CONFIG_MACH_RAUMFELD_SPEAKER)   += raumfeld.o
>  obj-$(CONFIG_MACH_ZIPIT2)      += z2.o
>
>  obj-$(CONFIG_TOSA_BT)          += tosa-bt.o
> +obj-$(CONFIG_Z2_USB_SWITCH)    += z2-usb-switch.o
> diff --git a/arch/arm/mach-pxa/z2-usb-switch.c b/arch/arm/mach-pxa/z2-usb-switch.c
> new file mode 100644
> index 0000000..9583092
> --- /dev/null
> +++ b/arch/arm/mach-pxa/z2-usb-switch.c
> @@ -0,0 +1,100 @@
> +/*
> + * USB mode switcher for Z2
> + *
> + * Copyright (c) 2011 Vasily Khoruzhick
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +
> +#include <mach/pxa27x.h>
> +#include <mach/pxa27x-udc.h>
> +
> +#include <asm/io.h>
> +
> +#define MIN(a, b) ((a) < (b) ? (a) : (b))
> +
> +static ssize_t usb_mode_show(struct device *dev, struct device_attribute *attr,
> +       char *buf)
> +{
> +       if (UP2OCR & UP2OCR_HXS)
> +               return sprintf(buf, "host\n");
> +       else
> +               return sprintf(buf, "device\n");
> +}
> +
> +static ssize_t usb_mode_set(struct device *dev, struct device_attribute *attr,
> +       const char *buf, size_t count)
> +{
> +       if (strncmp(buf, "host", MIN(count, 4)) == 0) {
> +               UP2OCR = UP2OCR_HXS | UP2OCR_HXOE | UP2OCR_DPPDE | UP2OCR_DMPDE;
> +               return count;
> +       } else if (strncmp(buf, "device", MIN(count, 6)) == 0) {
> +               UP2OCR = UP2OCR_HXOE | UP2OCR_DPPUE;
> +               return count;
> +       }
> +       return -EINVAL;
> +}
> +
> +static DEVICE_ATTR(usb_mode, 0644, usb_mode_show, usb_mode_set);
> +
> +static const struct attribute *attrs[] = {
> +       &dev_attr_usb_mode.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group attr_group = {
> +       .attrs  = (struct attribute **)attrs,
> +};
> +
> +static int z2_usb_switch_probe(struct platform_device *dev)
> +{
> +       int res;
> +
> +       res = sysfs_create_group(&dev->dev.kobj, &attr_group);
> +       if (res)
> +               return res;
> +
> +       UP2OCR = UP2OCR_HXOE | UP2OCR_DPPUE;
> +
> +       return 0;
> +}
> +
> +static int __devexit z2_usb_switch_remove(struct platform_device *dev)
> +{
> +       UP2OCR = UP2OCR_HXOE;
> +       sysfs_remove_group(&dev->dev.kobj, &attr_group);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver z2_usb_switch_driver = {
> +       .probe = z2_usb_switch_probe,
> +       .remove = __devexit_p(z2_usb_switch_remove),
> +
> +       .driver = {
> +               .name = "z2-usb-switch",
> +               .owner = THIS_MODULE,
> +       },
> +};
> +
> +
> +static int __init z2_usb_switch_init(void)
> +{
> +       return platform_driver_register(&z2_usb_switch_driver);
> +}
> +
> +static void __exit z2_usb_switch_exit(void)
> +{
> +       platform_driver_unregister(&z2_usb_switch_driver);
> +}
> +
> +module_init(z2_usb_switch_init);
> +module_exit(z2_usb_switch_exit);
> --
> 1.7.12.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


A more fitting name might be something like "pxa270-usb-switch", since
this isn't really z2 specific. Other pxa270 based devices could use it
aswell.
