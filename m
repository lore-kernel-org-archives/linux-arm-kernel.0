From: fu.wei@linaro.org (Fu Wei)
Date: Wed, 9 Dec 2015 11:00:09 +0800
Subject: [PATCH v4] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <5666FCE3.4070300@arm.com>
References: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
 <5666FCE3.4070300@arm.com>
Message-ID: <CADyBb7sg5A5_4vNUi7v13+qVp9P7xEQJVQYf_-1POJ3_3wyYSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 8 December 2015 at 23:53, Suzuki K. Poulose <Suzuki.Poulose@arm.com> wrote:
> On 08/12/15 07:03, fu.wei at linaro.org wrote:
>>
>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>
>> This commit provides APEI arch-specific bits for aarch64
>>
>> Meanwhile, add a new subfunction "hest_ia_init" for
>> "acpi_disable_cmcff" which is used by IA-32 Architecture
>> Corrected Machine Check (CMC).
>>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>> Changelog:
>> v4: Rebase to latest kernel version(4.4-rc4).
>>      Move arch_apei_flush_tlb_one into header file as a inline function
>>      Add a new subfunction "hest_ia_init" for "acpi_disable_cmcff".
>>
>> v3: https://lkml.org/lkml/2015/12/3/521
>>      Remove "acpi_disable_cmcff" from arm64 code,
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
>>
>>   arch/arm64/Kconfig            |  1 +
>>   arch/arm64/include/asm/acpi.h |  5 +++++
>>   drivers/acpi/apei/hest.c      | 19 ++++++++++++++++---
>>   3 files changed, 22 insertions(+), 3 deletions(-)
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
>> index caafd63..31d3d9a 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -17,6 +17,7 @@
>>
>>   #include <asm/cputype.h>
>>   #include <asm/smp_plat.h>
>> +#include <asm/tlbflush.h>
>>
>>   /* Macros for consistency checks of the GICC subtable of MADT */
>>   #define ACPI_MADT_GICC_LENGTH \
>> @@ -94,6 +95,10 @@ static inline const char *acpi_get_enable_method(int
>> cpu)
>>
>>   #ifdef        CONFIG_ACPI_APEI
>>   pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
>> +static inline void arch_apei_flush_tlb_one(unsigned long addr)
>> +{
>> +       flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> +}
>>   #endif
>>
>>   #endif /*_ASM_ACPI_H*/
>> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>> index 20b3fcf..715c58b 100644
>> --- a/drivers/acpi/apei/hest.c
>> +++ b/drivers/acpi/apei/hest.c
>> @@ -117,15 +117,27 @@ int apei_hest_parse(apei_hest_func_t func, void
>> *data)
>>   }
>>   EXPORT_SYMBOL_GPL(apei_hest_parse);
>>
>> +#if defined(__i386__) || defined(__x86_64__)
>
>
> Would it be better if define a symbol like :
>
> HAVE_ARCH_APEI_CMCFF for x86 and wrap it around that ?

I think that is a brilliant idea!
By this way , we can avoid to use  "defined(__i386__) ||
defined(__x86_64__)" which is not recommended in Linux kernel.

Thanks for your suggestion.

I thinks maybe we can name this as HAVE_ACPI_APEI_HEST_IA32 for or x86
and wrap all hest_ia_init relevant code.

>
>>   /*
>>    * Check if firmware advertises firmware first mode. We need FF bit to
>> be set
>>    * along with a set of MC banks which work in FF mode.
>>    */
>>   static int __init hest_parse_cmc(struct acpi_hest_header *hest_hdr, void
>> *data)
>>   {
>> -       return arch_apei_enable_cmcff(hest_hdr, data);
>> +       if (!acpi_disable_cmcff)
>> +               return !arch_apei_enable_cmcff(hest_hdr, data);
>> +
>> +       return 0;
>>   }
>>
>> +static inline int __init hest_ia_init(void)
>> +{
>> +       return apei_hest_parse(hest_parse_cmc, NULL);
>> +}
>> +#else
>> +static inline int __init hest_ia_init(void) { return 0; }
>> +#endif
>
>
> Cheers
> Suzuki
>



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
