From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 04 Dec 2013 23:48:36 +0800
Subject: [RFC part1 PATCH 5/7] ARM64 / ACPI: Introduce arm_core.c and
 its related head file
In-Reply-To: <20131203180300.GD16025@e106331-lin.cambridge.arm.com>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-6-git-send-email-hanjun.guo@linaro.org>
 <20131203180300.GD16025@e106331-lin.cambridge.arm.com>
Message-ID: <529F4ED4.20500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+CC Lv Zheng

On 2013?12?04? 02:03, Mark Rutland wrote:
> On Tue, Dec 03, 2013 at 04:36:49PM +0000, Hanjun Guo wrote:
>> introduce arm_core.c and its related head file, after this patch,
>> we can get ACPI tables from BIOS on ARM64 now.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/include/asm/acpi.h |   57 +++++++++++
>>   arch/arm64/kernel/setup.c     |    8 ++
>>   drivers/acpi/Makefile         |    2 +
>>   drivers/acpi/plat/Makefile    |    1 +
>>   drivers/acpi/plat/arm-core.c  |  219 +++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 287 insertions(+)
>>   create mode 100644 drivers/acpi/plat/Makefile
>>   create mode 100644 drivers/acpi/plat/arm-core.c
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index c186f5b..e9444e4 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -19,6 +19,43 @@
>>   #ifndef _ASM_ARM_ACPI_H
>>   #define _ASM_ARM_ACPI_H
>>   
>> +#include <asm/cacheflush.h>
>> +
>> +#include <linux/init.h>
>> +
>> +#define COMPILER_DEPENDENT_INT64	long long
>> +#define COMPILER_DEPENDENT_UINT64	unsigned long long
> Given we've already pulled in linux/init.h, which has pulled in
> linux/types.h, is there any reason we can't use s64 and u64 here?
>
> If we can, then why don't we unify this further up so each arch doesn't
> have to define this redundantly?

It make sense to me, I didn't notice that before, Lv, any comments about it?

>> +
>> +/*
>> + * Calling conventions:
>> + *
>> + * ACPI_SYSTEM_XFACE        - Interfaces to host OS (handlers, threads)
>> + * ACPI_EXTERNAL_XFACE      - External ACPI interfaces
>> + * ACPI_INTERNAL_XFACE      - Internal ACPI interfaces
>> + * ACPI_INTERNAL_VAR_XFACE  - Internal variable-parameter list interfaces
>> + */
>> +#define ACPI_SYSTEM_XFACE
>> +#define ACPI_EXTERNAL_XFACE
>> +#define ACPI_INTERNAL_XFACE
>> +#define ACPI_INTERNAL_VAR_XFACE
>> +
>> +/* Asm macros */
>> +#define ACPI_FLUSH_CPU_CACHE() flush_cache_all()
> Can you elaborate on when ACPI needs to use this?

Mainly used in two cases:

1) system sleep, there are sleep states defined
in ACPI, such as S0, S1, S2, S3 and etc.
when system enter sleep states, flush cache is needed.

2) When CPU enter idle states deeper than C3.

Thanks
hanjun
