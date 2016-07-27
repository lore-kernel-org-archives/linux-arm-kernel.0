From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 27 Jul 2016 16:40:26 -0400
Subject: [RFC PATCH v1 2/2] drivers: soc: Add support for Hisilicon Djtag
 driver
In-Reply-To: <57957161.1050504@huawei.com>
References: <1469177332-72156-1-git-send-email-tanxiaojun@huawei.com>
 <1469177332-72156-3-git-send-email-tanxiaojun@huawei.com>
 <CAP=VYLpfsMqPZL4J0K2+NMkxG+RHKchDBA+ZGhza9ZfWAa4VnQ@mail.gmail.com>
 <57957161.1050504@huawei.com>
Message-ID: <CAP=VYLqvD=nj9HHTrYUsezyw9Rd_Qi+aZ4vSRP3gUBn5HwR=+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 24, 2016 at 9:54 PM, Tan Xiaojun <tanxiaojun@huawei.com> wrote:
> On 2016/7/23 4:37, Paul Gortmaker wrote:
>> On Fri, Jul 22, 2016 at 4:48 AM, Tan Xiaojun <tanxiaojun@huawei.com> wrote:
>>> The Hisilicon Djtag is an independent module which connects with some modules
>>> in the SoC by Debug Bus. This module can be configured to access the registers
>>> of connecting modules (like L3 cache) during real time debugging.
>>>
>>> This patch add the driver of Hisilicon Djtag.
>>>
>>> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
>>> ---
>>>  drivers/soc/Kconfig                 |    1 +
>>>  drivers/soc/Makefile                |    1 +
>>>  drivers/soc/hisilicon/Kconfig       |   12 ++
>>>  drivers/soc/hisilicon/Makefile      |    1 +
>>>  drivers/soc/hisilicon/djtag.c       |  373 +++++++++++++++++++++++++++++++++++
>>>  include/linux/soc/hisilicon/djtag.h |   18 ++
>>>  6 files changed, 406 insertions(+)
>>>  create mode 100644 drivers/soc/hisilicon/Kconfig
>>>  create mode 100644 drivers/soc/hisilicon/Makefile
>>>  create mode 100644 drivers/soc/hisilicon/djtag.c
>>>  create mode 100644 include/linux/soc/hisilicon/djtag.h
>>>
>>> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
>>> index cb58ef0..f5982ec 100644
>>> --- a/drivers/soc/Kconfig
>>> +++ b/drivers/soc/Kconfig
>>> @@ -3,6 +3,7 @@ menu "SOC (System On Chip) specific Drivers"
>>>  source "drivers/soc/bcm/Kconfig"
>>>  source "drivers/soc/brcmstb/Kconfig"
>>>  source "drivers/soc/fsl/qe/Kconfig"
>>> +source "drivers/soc/hisilicon/Kconfig"
>>>  source "drivers/soc/mediatek/Kconfig"
>>>  source "drivers/soc/qcom/Kconfig"
>>>  source "drivers/soc/rockchip/Kconfig"
>>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
>>> index 380230f..373449d 100644
>>> --- a/drivers/soc/Makefile
>>> +++ b/drivers/soc/Makefile
>>> @@ -7,6 +7,7 @@ obj-$(CONFIG_SOC_BRCMSTB)       += brcmstb/
>>>  obj-$(CONFIG_ARCH_DOVE)                += dove/
>>>  obj-$(CONFIG_MACH_DOVE)                += dove/
>>>  obj-y                          += fsl/
>>> +obj-$(CONFIG_ARCH_HISI)                += hisilicon/
>>>  obj-$(CONFIG_ARCH_MEDIATEK)    += mediatek/
>>>  obj-$(CONFIG_ARCH_QCOM)                += qcom/
>>>  obj-$(CONFIG_ARCH_RENESAS)     += renesas/
>>> diff --git a/drivers/soc/hisilicon/Kconfig b/drivers/soc/hisilicon/Kconfig
>>> new file mode 100644
>>> index 0000000..3644aab
>>> --- /dev/null
>>> +++ b/drivers/soc/hisilicon/Kconfig
>>> @@ -0,0 +1,12 @@
>>> +#
>>> +# Hisilicon SoC drivers
>>> +#
>>> +config HISI_DJTAG
>>> +       bool "Hisilicon Djtag Support"
>>> +       depends on ARCH_HISI || COMPILE_TEST
>>> +       help
>>> +         Say y here to enable the Hisilicon Djtag support. It is an
>>> +         independent module which connects with some modules in the
>>> +         SoC by Debug Bus. This module can be configured to access
>>> +         the registers of connecting modules during real time
>>> +         debugging.
>>
>> Choice of word "module" here is probably confusing since it normally
>> means a ".ko" when used in Kconfig help.   Maybe instead, use:
>>
>> ...independent component...
>>
>> ...connects with some other components....
>>
>> This driver can be configured to ....
>>
>> --hopefully  the above will clarify against such confusion.   Also....
>>
>
> Yes, your suggestion is nice.
>
>>> diff --git a/drivers/soc/hisilicon/Makefile b/drivers/soc/hisilicon/Makefile
>>> new file mode 100644
>>> index 0000000..35a7b4b
>>> --- /dev/null
>>> +++ b/drivers/soc/hisilicon/Makefile
>>> @@ -0,0 +1 @@
>>> +obj-$(CONFIG_HISI_DJTAG)       += djtag.o
>>> diff --git a/drivers/soc/hisilicon/djtag.c b/drivers/soc/hisilicon/djtag.c
>>> new file mode 100644
>>> index 0000000..41e11ed
>>> --- /dev/null
>>> +++ b/drivers/soc/hisilicon/djtag.c
>>> @@ -0,0 +1,373 @@
>>> +/*
>>> + * Driver for Hisilicon Djtag r/w via System Controller.
>>> + *
>>> + * Copyright (C) 2016 Hisilicon Ltd.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/bitops.h>
>>> +#include <linux/init.h>
>>> +#include <linux/list.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/module.h>
>>
>> ...since you add the driver as a bool Kconfig item, you should
>> avoid using module.h and any MODULE_<xyz> tags.  Use the
>> builtin registration functions instead.
>>
>> Alternatively, if there is a genuine use case for this to really be
>> a dynamically loadable .ko module, then convert it to tristate.
>>
>> Thanks,
>> Paul.
>> --
>
> It is depended by hisilicon L3 cache or other components. And some
> functions of these components may be called by kernel functions. So
> it need to be set "bool". It looks like "mbigen" driver.
>
> Could you give me some examples for the builtin registration functions
> what you said? Maybe it is better for me.

You can do "git log --author=Gortmaker" to see lots of examples.  Do a
"git show" on any of the commit IDs that look relevant to this driver.

Generally, you delete the MODULE_<xyz>  and module.h and replace it
with init.h if you use __init.   Also add export.h if you use EXPORT_SYMBOL.

module_init becomes device_initcall, module_platform_driver becomes
builtin_platform_driver and so on.

Paul.
--

>
> Thanks.
> Xiaojun.
>
>>> +#include <linux/of.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/spinlock.h>
>>> +
>>> +#include <asm-generic/delay.h>
>>> +#include <linux/soc/hisilicon/djtag.h>
>>
>> .
>>
>
>
