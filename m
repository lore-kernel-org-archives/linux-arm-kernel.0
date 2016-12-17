From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 17 Dec 2016 09:36:59 +0530
Subject: [PATCH v8 1/8] soc: samsung: add exynos chipid driver support
In-Reply-To: <20161216173703.GA3746@kozik-lap>
References: <1481375323-29724-1-git-send-email-pankaj.dubey@samsung.com>
 <1481375323-29724-2-git-send-email-pankaj.dubey@samsung.com>
 <20161216173703.GA3746@kozik-lap>
Message-ID: <CAGcde9FBGcNpYbei0PsyHjt3_HVmm=x8oYkS-F7t0Rca6fpDAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 16 December 2016 at 23:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Sat, Dec 10, 2016 at 06:38:36PM +0530, Pankaj Dubey wrote:
>> Exynos SoCs have Chipid, for identification of product IDs and SoC revisions.
>> This patch intends to provide initialization code for all these functionalities,
>> at the same time it provides some sysfs entries for accessing these information
>> to user-space.
>>
>> This driver uses existing binding for exynos-chipid.
>>
>> CC: Grant Likely <grant.likely@linaro.org>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> [m.szyprowski: for suggestion and code snippet of product_id_to_soc_id]
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/soc/samsung/Kconfig         |   5 ++
>>  drivers/soc/samsung/Makefile        |   1 +
>>  drivers/soc/samsung/exynos-chipid.c | 116 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 122 insertions(+)
>>  create mode 100644 drivers/soc/samsung/exynos-chipid.c
>>
>> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
>> index 2455339..f9ab858 100644
>> --- a/drivers/soc/samsung/Kconfig
>> +++ b/drivers/soc/samsung/Kconfig
>> @@ -14,4 +14,9 @@ config EXYNOS_PM_DOMAINS
>>       bool "Exynos PM domains" if COMPILE_TEST
>>       depends on PM_GENERIC_DOMAINS || COMPILE_TEST
>>
>> +config EXYNOS_CHIPID
>> +     bool "Exynos Chipid controller driver" if COMPILE_TEST
>> +     depends on (ARM && ARCH_EXYNOS) || ((ARM || ARM64) && COMPILE_TEST)
>
> 1. Why this can be compile tested only on ARM architectures?

Well I just used dependency same as EXYNOS_PMU, but I can see it will
be enabled for compile test on ARM64 isn't it?

> 2. Don't you need also SOC_BUS?

CHIPID needs SoC_BUS and for the same reason it is selecting SOC_BUS
in the next line.
If we mark it as a dependency (under depends on), even then we need to
select this either
under same EXYNOS_CHIPID config or ARCH_EXYNOS config.

>
>> +     select SOC_BUS
>> +
>>  endif
>> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
>> index 3619f2e..2a8a85e 100644
>> --- a/drivers/soc/samsung/Makefile
>> +++ b/drivers/soc/samsung/Makefile
>> @@ -1,3 +1,4 @@
>>  obj-$(CONFIG_EXYNOS_PMU)     += exynos-pmu.o exynos3250-pmu.o exynos4-pmu.o \
>>                                       exynos5250-pmu.o exynos5420-pmu.o
>>  obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
>> +obj-$(CONFIG_EXYNOS_CHIPID)  += exynos-chipid.o
>
> Please put it before EXYNOS_PMU, keeping this sorted alphabetical helps
> avoiding conflicts of continuous edits.
>
>> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
>> new file mode 100644
>> index 0000000..cf0128b
>> --- /dev/null
>> +++ b/drivers/soc/samsung/exynos-chipid.c
>> @@ -0,0 +1,116 @@
>> +/*
>> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
>> + *         http://www.samsung.com/
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
>> +#define EXYNOS_SUBREV_MASK   (0xF << 4)
>> +#define EXYNOS_MAINREV_MASK  (0xF << 0)
>> +#define EXYNOS_REV_MASK              (EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
>> +
>> +static const struct exynos_soc_id {
>> +     const char *name;
>> +     unsigned int id;
>> +     unsigned int mask;
>> +} soc_ids[] = {
>> +     { "EXYNOS3250", 0xE3472000, 0xFFFFF000 },
>> +     { "EXYNOS4210", 0x43200000, 0xFFFE0000 },
>> +     { "EXYNOS4212", 0x43220000, 0xFFFE0000 },
>> +     { "EXYNOS4412", 0xE4412000, 0xFFFE0000 },
>> +     { "EXYNOS5250", 0x43520000, 0xFFFFF000 },
>> +     { "EXYNOS5260", 0xE5260000, 0xFFFFF000 },
>> +     { "EXYNOS5410", 0xE5410000, 0xFFFFF000 },
>> +     { "EXYNOS5420", 0xE5420000, 0xFFFFF000 },
>> +     { "EXYNOS5440", 0xE5440000, 0xFFFFF000 },
>> +     { "EXYNOS5800", 0xE5422000, 0xFFFFF000 },
>> +     { "EXYNOS7420", 0xE7420000, 0xFFFFF000 },
>> +     { "EXYNOS5433", 0xE5433000, 0xFFFFF000 },
>> +};
>> +
>> +static const char * __init product_id_to_soc_id(unsigned int product_id)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
>> +             if ((product_id & soc_ids[i].mask) == soc_ids[i].id)
>> +                     return soc_ids[i].name;
>> +     return "UNKNOWN";
>> +}
>> +
>> +static const struct of_device_id of_exynos_chipid_ids[] = {
>> +     {
>> +             .compatible     = "samsung,exynos4210-chipid",
>> +     },
>> +     {},
>> +};
>> +
>> +/**
>> + *  exynos_chipid_early_init: Early chipid initialization
>> + */
>
> This comment is meaningless, it duplicates the name of function.

Ok, will remove this in v9.

>
>> +int __init exynos_chipid_early_init(void)
>> +{
>> +     struct soc_device_attribute *soc_dev_attr;
>> +     struct soc_device *soc_dev;
>> +     struct device_node *root;
>> +     struct device_node *np;
>> +     void __iomem *exynos_chipid_base;
>> +     const struct of_device_id *match;
>> +     u32 product_id;
>> +     u32 revision;
>> +
>> +     np = of_find_matching_node_and_match(NULL,
>> +                     of_exynos_chipid_ids, &match);
>
> You don't use the match here, so how about either
> of_find_matching_node() or of_find_compatible_node()? The latter looks
> better (less calls inside) and actually you want just check one
> compatible field?
>

Ok, will adopt this in v9.

>> +     if (!np)
>> +             return -ENODEV;
>> +
>> +     exynos_chipid_base = of_iomap(np, 0);
>> +
>> +     if (!exynos_chipid_base)
>> +             return PTR_ERR(exynos_chipid_base);
>> +
>> +     product_id  = readl_relaxed(exynos_chipid_base);
>
> Duplicated space before '='.

Ok, will fix this.

>
>> +     revision = product_id & EXYNOS_REV_MASK;
>> +     iounmap(exynos_chipid_base);
>> +
>> +     soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>> +     if (!soc_dev_attr)
>> +             return -ENODEV;
>> +
>> +     soc_dev_attr->family = "Samsung Exynos";
>> +
>> +     root = of_find_node_by_path("/");
>> +     of_property_read_string(root, "model", &soc_dev_attr->machine);
>> +     of_node_put(root);
>> +
>> +     soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x", revision);
>> +     soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
>> +
>> +
>> +     pr_info("Exynos: CPU[%s] CPU_REV[0x%x] Detected\n",
>> +                     product_id_to_soc_id(product_id), revision);
>> +
>> +     soc_dev = soc_device_register(soc_dev_attr);
>> +     if (IS_ERR(soc_dev)) {
>> +             kfree(soc_dev_attr->revision);
>> +             kfree_const(soc_dev_attr->soc_id);
>
> It wasn't allocated with *_const, so no need to free it.

Yes, will fix this.

>
> Best regards,
> Krzysztof

Thanks for review.

Pankaj Dubey
