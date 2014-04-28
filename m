From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 28 Apr 2014 17:32:43 +0800
Subject: [PATCH v3 part1 04/11] ARM64 / ACPI: Introduce arm-core.c and
 its related head file
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88025586F4@SHSMSX101.ccr.corp.intel.com>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <1398432017-8506-5-git-send-email-hanjun.guo@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E88025586F4@SHSMSX101.ccr.corp.intel.com>
Message-ID: <535E203B.70006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lv,

On 2014-4-28 12:54, Zheng, Lv wrote:
> Hi,
> 
>> From: linux-acpi-owner at vger.kernel.org [mailto:linux-acpi-owner at vger.kernel.org] On Behalf Of Hanjun Guo
>> Sent: Friday, April 25, 2014 9:20 PM
>>
>> ACPI core need lots extern variables and functions which should
>> be provided by arch dependent code to make itself compilable. so
>> introduce arm_core.c and its related header file here.
>>
>> acpi_boot_table_init() will be called in setup_arch() before
>> paging_init(), so we should use eary_ioremap() mechanism here
>> to get the RSDP and all the table pointers, with this patch,
>> we can get ACPI boot-time tables from firmware on ARM64.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> ---
>>  arch/arm64/include/asm/acpi.h |   53 +++++++++++++++++++
>>  arch/arm64/kernel/setup.c     |    4 ++
>>  drivers/acpi/Makefile         |    2 +
>>  drivers/acpi/plat/Makefile    |    1 +
>>  drivers/acpi/plat/arm-core.c  |  113 +++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 173 insertions(+)
>>  create mode 100644 drivers/acpi/plat/Makefile
>>  create mode 100644 drivers/acpi/plat/arm-core.c
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index e3e990e..3ac9dfb 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -19,6 +19,43 @@
>>  #ifndef _ASM_ACPI_H
>>  #define _ASM_ACPI_H
>>
>> +#include <asm/cacheflush.h>
>> +
>> +#include <linux/init.h>
>> +
>> +#define COMPILER_DEPENDENT_INT64	s64
>> +#define COMPILER_DEPENDENT_UINT64	u64
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
> 
> Just a reminder.
> I'm going to sort such default definitions out.
> The story can be found here:
> https://lkml.org/lkml/2014/4/8/57
> The patch to achieve this can be found here:
> https://lkml.org/lkml/2014/4/23/71
> 
> If your series is merged after the above series, you don't need the above lines.
> 
>> +
>> +/* Asm macros */
>> +#define ACPI_FLUSH_CPU_CACHE() flush_cache_all()
>> +
> 
> Another reminder.
> I'm going to split this into <asm/acenv.h> in the same story.
> The patch to achieve this can be found here:
> https://lkml.org/lkml/2014/4/23/75
> If your series is merged after the above series, you need to put this line into arch/arm/include/asm/acenv.h.

It is ok to me, once your patches are accepted by Rafael and merged
into linux-next, I will rebase my patch set.

Thanks a lot the reminding :)

Best regards
Hanjun
