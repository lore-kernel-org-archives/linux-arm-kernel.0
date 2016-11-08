From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Tue, 08 Nov 2016 08:56:26 +0530
Subject: [PATCH v7 1/2] soc: samsung: add exynos chipid driver support
In-Reply-To: <cafc255a-3bdb-7eb2-1092-545866752858@samsung.com>
References: <1478347427-28409-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161105120051epcas5p2edc77b9b0d2729725b626f88d555a4a0@epcas5p2.samsung.com>
 <1478347427-28409-2-git-send-email-pankaj.dubey@samsung.com>
 <cafc255a-3bdb-7eb2-1092-545866752858@samsung.com>
Message-ID: <582145E2.7010802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Monday 07 November 2016 01:05 PM, Marek Szyprowski wrote:
> Hi Pankaj,
> 
> 
> On 2016-11-05 13:03, Pankaj Dubey wrote:
>> Exynos SoCs have Chipid, for identification of product IDs
>> and SoC revisions. This patch intends to provide initialization
>> code for all these functionalities, at the same time it provides some
>> sysfs entries for accessing these information to user-space.
>>
>> This driver uses existing binding for exynos-chipid.
>>
>> CC: Grant Likely <grant.likely@linaro.org>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   drivers/soc/samsung/Kconfig         |   5 ++
>>   drivers/soc/samsung/Makefile        |   1 +
>>   drivers/soc/samsung/exynos-chipid.c | 148
>> ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 154 insertions(+)
>>   create mode 100644 drivers/soc/samsung/exynos-chipid.c
>>
>> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
>> index 2455339..f9ab858 100644
>> --- a/drivers/soc/samsung/Kconfig
>> +++ b/drivers/soc/samsung/Kconfig
>> @@ -14,4 +14,9 @@ config EXYNOS_PM_DOMAINS
>>       bool "Exynos PM domains" if COMPILE_TEST
>>       depends on PM_GENERIC_DOMAINS || COMPILE_TEST
>>   +config EXYNOS_CHIPID
>> +    bool "Exynos Chipid controller driver" if COMPILE_TEST
>> +    depends on (ARM && ARCH_EXYNOS) || ((ARM || ARM64) && COMPILE_TEST)
>> +    select SOC_BUS
>> +
>>   endif
>> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
>> index 3619f2e..2a8a85e 100644
>> --- a/drivers/soc/samsung/Makefile
>> +++ b/drivers/soc/samsung/Makefile
>> @@ -1,3 +1,4 @@
>>   obj-$(CONFIG_EXYNOS_PMU)    += exynos-pmu.o exynos3250-pmu.o
>> exynos4-pmu.o \
>>                       exynos5250-pmu.o exynos5420-pmu.o
>>   obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
>> +obj-$(CONFIG_EXYNOS_CHIPID)    += exynos-chipid.o
>> diff --git a/drivers/soc/samsung/exynos-chipid.c
>> b/drivers/soc/samsung/exynos-chipid.c
>> new file mode 100644
>> index 0000000..9761e54
>> --- /dev/null
>> +++ b/drivers/soc/samsung/exynos-chipid.c
>> @@ -0,0 +1,148 @@
>> +/*
>> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
>> + *          http://www.samsung.com/
>> + *
>> + * EXYNOS - CHIP ID support
>> + * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/sys_soc.h>
>> +
>> +#define EXYNOS3250_SOC_ID    0xE3472000
>> +#define EXYNOS4210_SOC_ID    0x43210000
>> +#define EXYNOS4212_SOC_ID    0x43220000
>> +#define EXYNOS4412_SOC_ID    0xE4412000
>> +#define EXYNOS4415_SOC_ID    0xE4415000
>> +#define EXYNOS5250_SOC_ID    0x43520000
>> +#define EXYNOS5260_SOC_ID    0xE5260000
>> +#define EXYNOS5410_SOC_ID    0xE5410000
>> +#define EXYNOS5420_SOC_ID    0xE5420000
>> +#define EXYNOS5440_SOC_ID    0xE5440000
>> +#define EXYNOS5800_SOC_ID    0xE5422000
>> +
>> +#define EXYNOS_SOC_MASK        0xFFFFF000
>> +
>> +#define EXYNOS4210_REV_0    0x0
>> +#define EXYNOS4210_REV_1_0    0x10
>> +#define EXYNOS4210_REV_1_1    0x11
> 
> EXYNOS4210_REV* defines are not used at all in this driver.
> 
>> +
>> +#define EXYNOS_SUBREV_MASK    (0xF << 4)
>> +#define EXYNOS_MAINREV_MASK    (0xF << 0)
>> +#define EXYNOS_REV_MASK        (EXYNOS_SUBREV_MASK |
>> EXYNOS_MAINREV_MASK)
>> +
>> +
>> +static const char * __init product_id_to_soc_id(unsigned int product_id)
>> +{
>> +    const char *soc_name;
>> +    unsigned int soc_id = product_id & EXYNOS_SOC_MASK;
>> +
>> +    switch (soc_id) {
>> +    case EXYNOS3250_SOC_ID:
>> +        soc_name = "EXYNOS3250";
>> +        break;
>> +    case EXYNOS4210_SOC_ID:
>> +        soc_name = "EXYNOS4210";
>> +        break;
>> +    case EXYNOS4212_SOC_ID:
>> +        soc_name = "EXYNOS4212";
>> +        break;
>> +    case EXYNOS4412_SOC_ID:
>> +        soc_name = "EXYNOS4412";
>> +        break;
>> +    case EXYNOS4415_SOC_ID:
>> +        soc_name = "EXYNOS4415";
>> +        break;
>> +    case EXYNOS5250_SOC_ID:
>> +        soc_name = "EXYNOS5250";
>> +        break;
>> +    case EXYNOS5260_SOC_ID:
>> +        soc_name = "EXYNOS5260";
>> +        break;
>> +    case EXYNOS5420_SOC_ID:
>> +        soc_name = "EXYNOS5420";
>> +        break;
>> +    case EXYNOS5440_SOC_ID:
>> +        soc_name = "EXYNOS5440";
>> +        break;
>> +    case EXYNOS5800_SOC_ID:
>> +        soc_name = "EXYNOS5800";
>> +        break;
>> +    default:
>> +        soc_name = "UNKNOWN";
>> +    }
>> +    return soc_name;
>> +}
> 
> This approach is a bit error prone. You have already missed Exynos5410
> and early Exynos 4210 are not detected because of the incorrect SOC MASK.

Yes I missed to update Exynos4210 SoC Mask, thanks for pointing out.

> IMHO you should replace above code and defines with a simple array,
> where each ID is present only once, so it will be much easier to add
> future SoCs:
> 

Well, this looks good to me as well. I will incorporate these changes in
v2 as suggested by you and reuse your code, along with your
Signed-off-by for this part :)

> static const struct exynos_soc_id {
>         const char *name;
>         unsigned int id;
>         unsigned int mask;
> } soc_ids[] = {
>         { "EXYNOS3250", 0xE3472000, 0xFFFFF000 },
>         { "EXYNOS4210", 0x43200000, 0xFFFE0000 },
>         { "EXYNOS4212", 0x43220000, 0xFFFE0000 },
>         { "EXYNOS4412", 0xE4412000, 0xFFFE0000 },
>         { "EXYNOS4415", 0xE4415000, 0xFFFE0000 },
>         { "EXYNOS5250", 0x43520000, 0xFFFFF000 },
>         { "EXYNOS5260", 0xE5260000, 0xFFFFF000 },
>         { "EXYNOS5410", 0xE5410000, 0xFFFFF000 },
>         { "EXYNOS5420", 0xE5420000, 0xFFFFF000 },
>         { "EXYNOS5440", 0xE5440000, 0xFFFFF000 },
>         { "EXYNOS5800", 0xE5422000, 0xFFFFF000 },
> };
> 
> static const char * __init product_id_to_soc_id(unsigned int product_id)
> {
>         int i;
> 
>         for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
>                 if ((product_id & soc_ids[i].mask) == soc_ids[i].id)
>                         return soc_ids[i].name;
>         return "UNKNOWN";
> }
> 
> I'm also not sure about Exynos 4415, which has been scheduled for removal.
> 

As suggested by Arnd, I will keep entry for Exynos 4415 in the driver.


Thanks,
Pankaj Dubey
