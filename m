From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 29 Jul 2014 21:00:51 +0800
Subject: [PATCH 03/19] ARM64 / ACPI: Introduce lowlevel suspend function
In-Reply-To: <53D69665.5090709@arm.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-4-git-send-email-hanjun.guo@linaro.org>
 <53D69665.5090709@arm.com>
Message-ID: <53D79B03.5020104@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-7-29 2:28, Sudeep Holla wrote:
> 
> 
> On 24/07/14 14:00, Hanjun Guo wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> acpi_wakeup_address is used on x86 as the address bios jumps into
>> when machine wakes up from suspend. As arm64 does not have such a
>> bios this mechanism will be provided by other means. But the define
>> is still required inside the acpi core.
>>
>> Introduce a null stub for acpi_suspend_lowlevel as this is also
>> required by core. This will be filled in when standards are
>> defined for arm64 ACPI global power states.
>>
>> Reviewed-by: Grant Likely <grant.likely@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/include/asm/acpi.h |   12 ++++++++++++
>>   arch/arm64/kernel/acpi.c      |    7 +++++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index e8581ea..44b617f 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -36,6 +36,18 @@ static inline bool acpi_has_cpu_in_madt(void)
>>       return 1;
>>   }
>>
>> +/* Low-level suspend routine.
>> + *
>> + * ACPI S-states for ARM64 have to be defined
>> + * and approved before doing anything else, maybe
>> + * we need update the ACPI spec, here we
>> + * just introduce function and macro needed by
>> + * ACPI core as IA64 did, and revisit them when
>> + * the spec is ready.
>> + */
>> +extern int (*acpi_suspend_lowlevel)(void);
>> +#define acpi_wakeup_address 0
>> +
> 
> While I understand that this is temporary solution, but will this be
> sufficient to make sure we don't enter acpi_suspend_enter ?
> 
> A brief look at acpi_suspend_enter showed access to write to
> ACPI_BITREG_SCI_ENABLE which might just explode. But if you are sure that
> it will not be executed, then it should be fine for now.

I think it will not be executed, since ARM64 do not support S1 and S3 in ACPI
for now, and that state will not defined, then acpi_suspend_enter will not be
called.

Thanks
Hanjun
