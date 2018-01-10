From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 10 Jan 2018 10:46:32 +0900
Subject: [PATCH 3/9] soc: samsung: pmu: Add the PMU data of exynos5433
 to support low-power state
In-Reply-To: <b639da18-a069-aeb7-ceca-30c79b1c25c8@arm.com>
References: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
 <CGME20180109075905epcas1p321b8898a0d45287d63364e1aa768fdab@epcas1p3.samsung.com>
 <1515484746-10656-4-git-send-email-cw00.choi@samsung.com>
 <b639da18-a069-aeb7-ceca-30c79b1c25c8@arm.com>
Message-ID: <5A557078.50101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018? 01? 09? 23:11, Sudeep Holla wrote:
> 
> 
> On 09/01/18 07:59, Chanwoo Choi wrote:
>> This patch adds the PMU (Power Management Unit) data of exynos5433 SoC
>> in order to support the various power modes. Each power mode has
>> the different value for reducing the power-consumption.
>>
>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/mach-exynos/common.h               |   2 -
>>  drivers/soc/samsung/Makefile                |   3 +-
>>  drivers/soc/samsung/exynos-pmu.c            |   1 +
>>  drivers/soc/samsung/exynos-pmu.h            |   2 +
>>  drivers/soc/samsung/exynos5433-pmu.c        | 286 ++++++++++++++++++++++++++++
>>  include/linux/soc/samsung/exynos-regs-pmu.h | 148 ++++++++++++++
>>  6 files changed, 439 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/soc/samsung/exynos5433-pmu.c
>>
> 
>> diff --git a/drivers/soc/samsung/exynos5433-pmu.c b/drivers/soc/samsung/exynos5433-pmu.c
>> new file mode 100644
>> index 000000000000..2571e61522f0
>> --- /dev/null
>> +++ b/drivers/soc/samsung/exynos5433-pmu.c
>> @@ -0,0 +1,286 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// Copyright (c) 2018 Samsung Electronics Co., Ltd.
>> +// Copyright (c) Jonghwa Lee <jonghwa3.lee@samsung.com>
>> +// Copyright (c) Chanwoo Choi <cw00.choi@samsung.com>
>> +//
>> +// EXYNOS5433 - CPU PMU (Power Management Unit) support
>> +
>> +#include <linux/soc/samsung/exynos-regs-pmu.h>
>> +#include <linux/soc/samsung/exynos-pmu.h>
>> +
>> +#include "exynos-pmu.h"
>> +
>> +static struct exynos_pmu_conf exynos5433_pmu_config[] = {
>> +	/* { .offset = address,	.val = { AFTR, LPA, SLEEP } } */
>> +	{ EXYNOS5433_ATLAS_CPU0_SYS_PWR_REG,			{ 0x0, 0x0, 0x8 } },
>> +	{ EXYNOS5433_DIS_IRQ_ATLAS_CPU0_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
>> +	{ EXYNOS5433_ATLAS_CPU1_SYS_PWR_REG,			{ 0x0, 0x0, 0x8 } },
>> +	{ EXYNOS5433_DIS_IRQ_ATLAS_CPU1_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
>> +	{ EXYNOS5433_ATLAS_CPU2_SYS_PWR_REG,			{ 0x0, 0x0, 0x8 } },
>> +	{ EXYNOS5433_DIS_IRQ_ATLAS_CPU2_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
>> +	{ EXYNOS5433_ATLAS_CPU3_SYS_PWR_REG,			{ 0x0, 0x0, 0x8 } },
>> +	{ EXYNOS5433_DIS_IRQ_ATLAS_CPU3_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
>> +	{ EXYNOS5433_APOLLO_CPU0_SYS_PWR_REG,			{ 0x0, 0x0, 0x8 } },
>> +	{ EXYNOS5433_DIS_IRQ_APOLLO_CPU0_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
>> +	{ EXYNOS5433_APOLLO_CPU1_SYS_PWR_REG,			{ 0x0, 0x0, 0x8 } },
>> +	{ EXYNOS5433_DIS_IRQ_APOLLO_CPU1_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
>> +	{ EXYNOS5433_APOLLO_CPU2_SYS_PWR_REG,			{ 0x0, 0x0, 0x8 } },
>> +	{ EXYNOS5433_DIS_IRQ_APOLLO_CPU2_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
>> +	{ EXYNOS5433_APOLLO_CPU3_SYS_PWR_REG,			{ 0x0, 0x0, 0x8 } },
>> +	{ EXYNOS5433_DIS_IRQ_APOLLO_CPU3_CENTRAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0 } },
>> +	{ EXYNOS5433_ATLAS_NONCPU_SYS_PWR_REG,			{ 0x0, 0x0, 0x8 } },
>> +	{ EXYNOS5433_APOLLO_NONCPU_SYS_PWR_REG,			{ 0x0, 0x0, 0x8 } },
> 
> 
> 1. First of all why do you need any of these CPU related PMU config
>    registers in kernel ? From the information I gathered this is ARM64
>    SoC using PSCI. These are needed just in PSCI implementation and not
>    in kernel. So can you elaborate on why there are present here ?

The 32bit Exynos used the 'smc' call to enter the suspend mode
and need to handle the PMU registers.

Even if PSCI replaces the 'smc' call on the Exynos5433,
the Exynos5433's document requires the handling of PMU config
related to CPU for the suspend mode.

IMHO, If the secure OS implemented the all something related to CPU,
it might be unnecessary to handle the PMU registers. I think that
it depend on how to design the SoC by H/W Architect. This is just my opinion.

> 
> 2. Are there any public documents that these names map to ?

There is no public document. It is confidential.

>    If there is none, please replace these codenames(ATLAS, APOLLO) with
>    appropriately.

In the Exynos5433, 'apollo' indicates the LITTLE cores (cpu0-3, cortex-a53)
and 'atlas' indicates the big cores (cpu4-7, cortex-a57)

Exynos5433 already used the 'apollo' and 'atlas' on clk-exynos5433.c driver
and thermal device-tree node. It is better to use the original register name
in the document in order to reduce the confusion of the change of register name
even if document is not public.

Also, exynos7 used the 'atlas' word for big cores.

> 
> Sorry if these are already answered, just point me to those threads.
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
