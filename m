From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 04 Dec 2014 09:02:22 +0530
Subject: [PATCH] soc: samsung: pmu: split up SoC specific PMU data
In-Reply-To: <547EA0DC.70800@samsung.com>
References: <1417364162-29981-1-git-send-email-pankaj.dubey@samsung.com>
 <547EA0DC.70800@samsung.com>
Message-ID: <547FD5C6.3030308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 11:04 AM, jonghwa3.lee at samsung.com wrote:
> On 2014? 12? 01? 01:16, Pankaj Dubey wrote:
>
>> This patch splits up exynos-pmu.c file, and moves PMU configuration data
>> and functions handing those data into SoC specific PMU files, keeping
>> driver structure and common functionality into exynos-pmu.c.
>>
>> At the same time it also separates compilation of these different SoC PMU files
>> based on CONFIG_ARM64 and CONFIG_ARM. This way we can reduce overhead of ARM64
>> SoC's PMU getting compiled when kernel is built for ARM and vice-versa.
>>
>> This patch also removes .owner field from exynos-pmu.c as it's redundant for
>> drivers calling platform_driver_register to register platform_driver.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>> This patch is prepared on top of kgene/for-next and following patch [1] from
>> Amit Daniel.
>>
>> [1]: http://www.spinics.net/lists/linux-samsung-soc/msg39797.html
>>
>> This patch tries to address some of concerns raised for using exynos-pmu.c for
>> ARM and ARM64 based SoC at these threads [2], [3].
>>
>> [2]: http://www.spinics.net/lists/linux-samsung-soc/msg39809.html
>> [3]: https://lkml.org/lkml/2014/11/24/322
>>
>> Since Exynos SoC's has similar PMU IP, and already existing bindings can be
>> used, it makes sense to keep single driver for both ARM and ARM64 based SoCs.
>> All common functionalties are in exynos-pmu.c whereas SoC specific data and
>> handling are moved into SoC specific exynosNNNN-pmu files.
>>
>> All changes are compiled tested only. Any improvements/suggestions are most
>> welcome.
>>
>>   drivers/soc/samsung/Makefile         |    9 +-
>>   drivers/soc/samsung/exynos-pmu.c     | 1293 +---------------------------------
>>   drivers/soc/samsung/exynos-pmu.h     |   63 ++
>>   drivers/soc/samsung/exynos3250-pmu.c |  176 +++++
>>   drivers/soc/samsung/exynos4-pmu.c    |  223 ++++++
>>   drivers/soc/samsung/exynos5250-pmu.c |  196 ++++++
>>   drivers/soc/samsung/exynos5420-pmu.c |  298 ++++++++
>>   drivers/soc/samsung/exynos7-pmu.c    |  441 ++++++++++++
>>   8 files changed, 1412 insertions(+), 1287 deletions(-)
>>   create mode 100644 drivers/soc/samsung/exynos-pmu.h
>>   create mode 100644 drivers/soc/samsung/exynos3250-pmu.c
>>   create mode 100644 drivers/soc/samsung/exynos4-pmu.c
>>   create mode 100644 drivers/soc/samsung/exynos5250-pmu.c
>>   create mode 100644 drivers/soc/samsung/exynos5420-pmu.c
>>   create mode 100644 drivers/soc/samsung/exynos7-pmu.c
>>
>
> ...
>
>> diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
>> new file mode 100644
>> index 0000000..4adc5a3
>> --- /dev/null
>> +++ b/drivers/soc/samsung/exynos-pmu.h
>> @@ -0,0 +1,63 @@
>> +/*
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + *		http://www.samsung.com
>> + *
>> + * Header for EXYNOS PMU Driver support
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef __EXYNOSPMU_H
>> +#define __EXYNOSPMU_H
>> +
>> +#include <linux/io.h>
>> +
>> +#define PMU_TABLE_END	(-1U)
>> +
>> +static void __iomem *pmu_base_addr;
>> +
>
> AFAIK, static variable in header file can't be used globally. It would be placed
> in exynos-pmu.c or elsewhere and then only extern declaration is allowed here.
> If I'm wrong, please let me know.
>

Thanks for review.
You are right. I will change this.
I am waiting for review from other concerned people so that if any 
suggestions or improvements I can do it in next version.

> Thanks.
> Jonghwa
>
