From: andy.yan@rock-chips.com (Andy Yan)
Date: Tue, 2 Feb 2016 15:31:17 +0800
Subject: [PATCH v2 2/4] power: reset: add reboot mode driver
In-Reply-To: <CAAtXAHd-m5GAUnvx9At9_UOoi1M4g25P0M-vwoC+Xc-PXtdwqw@mail.gmail.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
 <1452598319-8324-1-git-send-email-andy.yan@rock-chips.com>
 <CAAtXAHd-m5GAUnvx9At9_UOoi1M4g25P0M-vwoC+Xc-PXtdwqw@mail.gmail.com>
Message-ID: <56B05B45.7040207@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Moritz:

On 2016?01?27? 18:53, Moritz Fischer wrote:
> Hi Andy,
>
> On Tue, Jan 12, 2016 at 12:31 PM, Andy Yan <andy.yan@rock-chips.com> wrote:
>> This driver parse the reboot commands like "reboot loader"
>> and "reboot recovery" to get a boot mode described in the
>> device tree , then call the write interfae to store the boot
>> mode in some persistent storage  like special register or ram,
>> which can be read by the bootloader after system reboot, then
>> the bootloader can take different action according to the mode
>> stored.
>>
>> This is commonly used on Android based devices, which in order
>> to reboot the device into fastboot or recovery mode.
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>
>> ---
>>
>> Changes in v2:
>> - move to dir drivers/power/reset/
>> - make syscon-reboot-mode a generic driver
>>
>> Changes in v1:
>> - fix the embarrassed compile warning
>> - correct the maskrom magic number
>> - check for the normal reboot
>>
>>   drivers/power/reset/Kconfig              |  16 +++++
>>   drivers/power/reset/Makefile             |   2 +
>>   drivers/power/reset/reboot-mode.c        | 100 +++++++++++++++++++++++++++++++
>>   drivers/power/reset/reboot-mode.h        |   6 ++
>>   drivers/power/reset/syscon-reboot-mode.c |  62 +++++++++++++++++++
>>   5 files changed, 186 insertions(+)
>>   create mode 100644 drivers/power/reset/reboot-mode.c
>>   create mode 100644 drivers/power/reset/reboot-mode.h
>>   create mode 100644 drivers/power/reset/syscon-reboot-mode.c
>>
>> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
>> index 1131cf7..2e6d873 100644
>> --- a/drivers/power/reset/Kconfig
>> +++ b/drivers/power/reset/Kconfig
>> @@ -173,5 +173,21 @@ config POWER_RESET_ZX
>>          help
>>            Reboot support for ZTE SoCs.
>>
>> +config REBOOT_MODE
>> +       tristate
>> +       depends on OF
>> +       help
>> +        This driver will help to pass the system reboot mode
>> +        to bootloader
>> +
>> +config SYSCON_REBOOT_MODE
>> +       bool "Generic SYSCON regmap reboot mode driver"
>> +       select REBOOT_MODE
>> +       help
>> +        Say y here will enable reboot mode driver. This will
>> +        get reboot mode arguments and store it in SYSCON mapped
>> +        register, then the bootloader can read it to take different
>> +        action according to the mode.
>> +
>>   endif
>>
>> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
>> index 096fa67..a63865b 100644
>> --- a/drivers/power/reset/Makefile
>> +++ b/drivers/power/reset/Makefile
>> @@ -20,3 +20,5 @@ obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
>>   obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
>>   obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
>>   obj-$(CONFIG_POWER_RESET_ZX) += zx-reboot.o
>> +obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
>> +obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
>> new file mode 100644
>> index 0000000..92b7b4d
>> --- /dev/null
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -0,0 +1,100 @@
>> +/*
>> + * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +#include <linux/device.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/reboot.h>
>> +#include "reboot-mode.h"
>> +
>> +struct mode_info {
>> +       const char *mode;
>> +       int magic;
>> +       struct list_head list;
>> +};
>> +
>> +struct reboot_mode_driver {
>> +       struct list_head head;
>> +       int (*write)(int magic);
>> +       struct notifier_block reboot_notifier;
>> +};
>> +
>> +static int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>> +                                const char *cmd)
>> +{
>> +       const char *normal = "normal";
>> +       int magic = 0;
>> +       struct mode_info *info;
>> +
>> +       if (!cmd)
>> +               cmd = normal;
>> +
>> +       list_for_each_entry(info, &reboot->head, list) {
>> +               if (!strcmp(info->mode, cmd)) {
>> +                       magic = info->magic;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       return magic;
>> +}
>> +
>> +static int reboot_mode_notify(struct notifier_block *this,
>> +                             unsigned long mode, void *cmd)
>> +{
>> +       struct reboot_mode_driver *reboot;
>> +       int magic;
>> +
>> +       reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
>> +       magic = get_reboot_mode_magic(reboot, cmd);
>> +       if (magic)
>> +               reboot->write(magic);
>> +
>> +       return NOTIFY_DONE;
>> +}
>> +
>> +int reboot_mode_register(struct device *dev, int (*write)(int))
>> +{
>> +       struct reboot_mode_driver *reboot;
>> +       struct mode_info *info;
>> +       struct device_node *child;
>> +       int ret;
>> +
>> +       reboot = devm_kzalloc(dev, sizeof(*reboot), GFP_KERNEL);
>> +       if (!reboot)
>> +               return -ENOMEM;
>> +
>> +       reboot->write = write;
>> +       INIT_LIST_HEAD(&reboot->head);
>> +       for_each_child_of_node(dev->of_node, child) {
>> +               info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>> +               if (!info)
>> +                       return -ENOMEM;
>> +               info->mode = of_get_property(child, "linux,mode", NULL);
>> +               if (of_property_read_u32(child, "loader,magic", &info->magic)) {
>> +                       dev_err(dev, "reboot mode %s without magic number\n",
>> +                               info->mode);
>> +                       devm_kfree(dev, info);
>> +                       continue;
>> +               }
>> +               list_add_tail(&info->list, &reboot->head);
>> +       }
>> +       reboot->reboot_notifier.notifier_call = reboot_mode_notify;
>> +       ret = register_reboot_notifier(&reboot->reboot_notifier);
>> +       if (ret)
>> +               dev_err(dev, "can't register reboot notifier\n");
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(reboot_mode_register);
>> +
>> +MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
>> +MODULE_DESCRIPTION("System reboot mode driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/power/reset/reboot-mode.h b/drivers/power/reset/reboot-mode.h
>> new file mode 100644
>> index 0000000..76646e7
>> --- /dev/null
>> +++ b/drivers/power/reset/reboot-mode.h
>> @@ -0,0 +1,6 @@
>> +#ifndef __REBOOT_MODE_H__
>> +#define __REBOOT_MODE_H__
>> +
>> +extern int reboot_mode_register(struct device *dev, int (*write)(int));
>> +
>> +#endif
>> diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
>> new file mode 100644
>> index 0000000..b9370f3
>> --- /dev/null
>> +++ b/drivers/power/reset/syscon-reboot-mode.c
>> @@ -0,0 +1,62 @@
>> +/*
>> + * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reboot.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>> +#include "reboot-mode.h"
>> +
>> +static struct regmap *map;
>> +static u32 offset;
>> +
>> +static int syscon_reboot_mode_write(int magic)
>> +{
>> +       regmap_write(map, offset, magic);
> See suggestion below. I think using regmap_update_bits() would be even
> more useful for cases where you have other stuff in that register, too.
>
>> +
>> +       return 0;
>> +}
>> +
>> +static int syscon_reboot_mode_probe(struct platform_device *pdev)
>> +{
>> +       int ret;
>> +
>> +       map = syscon_node_to_regmap(pdev->dev.parent->of_node);
>> +       if (IS_ERR(map))
>> +               return PTR_ERR(map);
>> +       if (of_property_read_u32(pdev->dev.of_node, "offset", &offset))
>> +               return -EINVAL;
> I think it would be worthwhile to have a mask value here, that you can use
> with regmap_update_bits()

     That sounds reasonable,  I already fond some drivers like tegra[0]
     only use some bits to store the mode value. So I will add it in V3.

    [0] drivers/soc/tegra/pmc.c
>
> +           if (of_property_read_u32(pdev->dev.of_node, "mask", &mask))
> +                   return -EINVAL;
>
>
> Cheers,
>
> Moritz
>
>
>
