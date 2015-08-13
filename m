From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 13 Aug 2015 15:45:07 +0100
Subject: [PATCH 12/14] arm64: Check for selected granule support
In-Reply-To: <CAPvkgC3=S1BxdzZM4uUOmyXLjii48SMpCof6i6HdNeTG_fydfg@mail.gmail.com>
References: <1439465645-22584-1-git-send-email-suzuki.poulose@arm.com>	<1439465645-22584-13-git-send-email-suzuki.poulose@arm.com>
 <CAPvkgC3=S1BxdzZM4uUOmyXLjii48SMpCof6i6HdNeTG_fydfg@mail.gmail.com>
Message-ID: <55CCAD73.7080702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/08/15 13:28, Steve Capper wrote:
> On 13 August 2015 at 12:34, Suzuki K. Poulose <suzuki.poulose@arm.com> wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>
>> Ensure that the selected page size is supported by the
>> CPU(s).
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/sysreg.h |    6 ++++++
>>   arch/arm64/kernel/head.S        |   24 +++++++++++++++++++++++-
>>   2 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index a7f3d4b..e01d323 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -87,4 +87,10 @@ static inline void config_sctlr_el1(u32 clear, u32 set)
>>   }
>>   #endif
>>
>> +#define ID_AA64MMFR0_TGran4_SHIFT      28
>> +#define ID_AA64MMFR0_TGran64_SHIFT     24
>> +
>> +#define ID_AA64MMFR0_TGran4_ENABLED    0x0
>> +#define ID_AA64MMFR0_TGran64_ENABLED   0x0
>> +
>>   #endif /* __ASM_SYSREG_H */
>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index 01b8e58..0cb04db 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -31,10 +31,11 @@
>>   #include <asm/cputype.h>
>>   #include <asm/kernel-pgtable.h>
>>   #include <asm/memory.h>
>> -#include <asm/thread_info.h>
>>   #include <asm/pgtable-hwdef.h>
>>   #include <asm/pgtable.h>
>>   #include <asm/page.h>
>> +#include <asm/sysreg.h>
>> +#include <asm/thread_info.h>
>>   #include <asm/virt.h>
>>
>>   #define __PHYS_OFFSET  (KERNEL_START - TEXT_OFFSET)
>> @@ -606,9 +607,25 @@ ENDPROC(__secondary_switched)
>>    *  x27 = *virtual* address to jump to upon completion
>>    *
>>    * other registers depend on the function called upon completion
>> + * Checks if the selected granule size is supported by the CPU.
>>    */
>> +#if    defined(CONFIG_ARM64_64K_PAGES)
>> +
>> +#define ID_AA64MMFR0_TGran_SHIFT       ID_AA64MMFR0_TGran64_SHIFT
>> +#define ID_AA64MMFR0_TGran_ENABLED     ID_AA64MMFR0_TGran64_ENABLED
>> +
>> +#else
>> +
>> +#define ID_AA64MMFR0_TGran_SHIFT       ID_AA64MMFR0_TGran4_SHIFT
>> +#define ID_AA64MMFR0_TGran_ENABLED     ID_AA64MMFR0_TGran4_ENABLED
>> +
>> +#endif
>>          .section        ".idmap.text", "ax"
>>   __enable_mmu:
>> +       mrs     x1, ID_AA64MMFR0_EL1
>> +       ubfx    x2, x1, #ID_AA64MMFR0_TGran_SHIFT, 4
>> +       cmp     x2, #ID_AA64MMFR0_TGran_ENABLED
>> +       b.ne    __no_granule_support
>>          ldr     x5, =vectors
>>          msr     vbar_el1, x5
>>          msr     ttbr0_el1, x25                  // load TTBR0
>> @@ -626,3 +643,8 @@ __enable_mmu:
>>          isb
>>          br      x27
>>   ENDPROC(__enable_mmu)
>> +
>> +__no_granule_support:
>> +       wfe
>> +       b __no_granule_support
>> +ENDPROC(__no_granule_support)
>> --
>> 1.7.9.5
>>
>
> Hi Suzuki,
> Is is possible to tell the user that the kernel has failed to boot due
> to the kernel granule being unsupported?

We don't have anything up at this time. The "looping address" is actually a clue
to the (expert) user. Not sure we can do something, until we get something like DEBUG_LL(?)
Or we should let it continue and end in a panic(?). The current situation can boot a
multi-cluster system with boot cluster having the Tgran support(which doesn't make a
strong use case though). I will try out some options and get back to you.


Thanks
Suzuki

>
> Cheers,
> --
> Steve
>
