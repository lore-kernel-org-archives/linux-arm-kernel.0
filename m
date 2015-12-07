From: fu.wei@linaro.org (Fu Wei)
Date: Mon, 7 Dec 2015 21:06:29 +0800
Subject: [PATCH v3] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <56655307.2010305@linaro.org>
References: <1449162903-11203-1-git-send-email-fu.wei@linaro.org>
 <56655307.2010305@linaro.org>
Message-ID: <CADyBb7uN3yftHdwWDZ34L6aArjNZ6Ai6bmbx-BoFn9xQdcqXvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

On 7 December 2015 at 17:36, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> Hi Fu Wei,
>
> On 12/04/2015 01:15 AM, fu.wei at linaro.org wrote:
>>
>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>
>> This commit provides APEI arch-specific bits for aarch64
>>
>> The reason for wrapping "acpi_disable_cmcff" by
>> "#if defined(__i386__) || defined(__x86_64__)" in hest.c is:
>> according to ACPI spec CMC(Corrected Machine Check) is only for IA-32
>> Architecture.
>>
>> Changelog:
>> v3: Remove "acpi_disable_cmcff" from arm64 code,
>>      and wrap it in hest.c by "#if defined(__i386__) ||
>> defined(__x86_64__)"
>>
>> v2: https://lkml.org/lkml/2015/12/2/432
>>      Rebase to latest kernel version(4.4-rc3).
>>      Move arch_apei_flush_tlb_one() to arch/arm64/kernel/acpi.c
>>
>> v1: https://lkml.org/lkml/2015/8/14/199
>>      Move arch_apei_flush_tlb_one() to arch/arm64/include/asm/apci.h.
>>      Delete arch/arm64/kernel/apei.c.
>>      Add "#ifdef CONFIG_ACPI_APEI" for "acpi_disable_cmcff".
>
>
> The version updates is not belong here, if you need to add
> it, please place it under "---" below.
>
>>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>
>
> ...just here.

OK , thanks

>
>
>>   arch/arm64/Kconfig            | 1 +
>>   arch/arm64/include/asm/acpi.h | 1 +
>>   arch/arm64/kernel/acpi.c      | 6 ++++++
>>   drivers/acpi/apei/hest.c      | 2 ++
>>   4 files changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 871f217..58c8992 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -3,6 +3,7 @@ config ARM64
>>         select ACPI_CCA_REQUIRED if ACPI
>>         select ACPI_GENERIC_GSI if ACPI
>>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>> +       select HAVE_ACPI_APEI if ACPI
>>         select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>>         select ARCH_HAS_ELF_RANDOMIZE
>>         select ARCH_HAS_GCOV_PROFILE_ALL
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index caafd63..7207f8e 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -94,6 +94,7 @@ static inline const char *acpi_get_enable_method(int
>> cpu)
>>
>>   #ifdef        CONFIG_ACPI_APEI
>>   pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
>> +void arch_apei_flush_tlb_one(unsigned long addr);
>>   #endif
>>
>>   #endif /*_ASM_ACPI_H*/
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index d1ce8e2..7a742e7 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -32,6 +32,7 @@
>>   #ifdef CONFIG_ACPI_APEI
>>   # include <linux/efi.h>
>>   # include <asm/pgtable.h>
>> +# include <asm/tlbflush.h>
>>   #endif
>>
>>   int acpi_noirq = 1;           /* skip ACPI IRQ initialization */
>> @@ -233,4 +234,9 @@ pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
>>                 return __pgprot(PROT_NORMAL_NC);
>>         return __pgprot(PROT_DEVICE_nGnRnE);
>>   }
>> +
>> +void arch_apei_flush_tlb_one(unsigned long addr)
>> +{
>> +       flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> +}
>
>
> Maybe just a static inline function in arch/arm64/include/asm/acpi.h
> will be good?

yes, this suggestion makes sense, it is just one line.
And I also understood the reason why the original author make this
code like that:
coordinating with x86 code.

let's improve it this time.

>
>>   #endif
>> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>> index 20b3fcf..4ead747 100644
>> --- a/drivers/acpi/apei/hest.c
>> +++ b/drivers/acpi/apei/hest.c
>> @@ -232,8 +232,10 @@ void __init acpi_hest_init(void)
>>                 goto err;
>>         }
>>
>> +#if defined(__i386__) || defined(__x86_64__)
>>         if (!acpi_disable_cmcff)
>>                 apei_hest_parse(hest_parse_cmc, NULL);
>> +#endif

OK, that makes sense, will do

>
>
> How about put it together into a function, and
> introduce a stub function when no __i386__ and
> __x86_64__ case?
>
> Thanks
> Hanjun



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
