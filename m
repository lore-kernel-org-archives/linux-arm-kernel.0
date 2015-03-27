From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 27 Mar 2015 12:12:00 +0100
Subject: [PATCH] ARM: kvm: round HYP section to page size instead of log2
 upper bound
In-Reply-To: <20150327110919.GC1562@arm.com>
References: <1427451481-16053-1-git-send-email-ard.biesheuvel@linaro.org>
 <1427451481-16053-2-git-send-email-ard.biesheuvel@linaro.org>
 <20150327110919.GC1562@arm.com>
Message-ID: <CAKv+Gu9wAY5sx0=zvGpZwEjjO0oBbUpAHawMmRZ6nQUasj+Q1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 March 2015 at 12:09, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Mar 27, 2015 at 10:18:01AM +0000, Ard Biesheuvel wrote:
>> Older binutils do not support expressions involving the values of
>> external symbols so just round up the HYP region to the page size.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Thanks Ard. I managed to reproduce the failures in -next, and this solves
> the problem for me (the only toolchain that chokes seems to be the one on
> kernel.org, unfortunately).
>
> I'll push an updated branch after a bit more testing. Let's not touch this
> file ever again :)
>

Fingers crossed ...

>> ---
>>  arch/arm/kernel/vmlinux.lds.S | 31 +------------------------------
>>  arch/arm/kvm/init.S           |  3 ---
>>  2 files changed, 1 insertion(+), 33 deletions(-)
>>
>> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
>> index 808398ec024e..f2db429ea75d 100644
>> --- a/arch/arm/kernel/vmlinux.lds.S
>> +++ b/arch/arm/kernel/vmlinux.lds.S
>> @@ -12,26 +12,6 @@
>>  #include <asm/pgtable.h>
>>  #endif
>>
>> -/*
>> - * Poor man's version of LOG2CEIL(), which is
>> - * not available in binutils before v2.24.
>> - */
>> -#define LOG2_ROUNDUP(size) (         \
>> -     __LOG2_ROUNDUP(size,  2)        \
>> -     __LOG2_ROUNDUP(size,  3)        \
>> -     __LOG2_ROUNDUP(size,  4)        \
>> -     __LOG2_ROUNDUP(size,  5)        \
>> -     __LOG2_ROUNDUP(size,  6)        \
>> -     __LOG2_ROUNDUP(size,  7)        \
>> -     __LOG2_ROUNDUP(size,  8)        \
>> -     __LOG2_ROUNDUP(size,  9)        \
>> -     __LOG2_ROUNDUP(size, 10)        \
>> -     __LOG2_ROUNDUP(size, 11)        \
>> -     12)
>> -
>> -#define __LOG2_ROUNDUP(size, order)  \
>> -     (size) <= (1 << order) ? order :
>> -
>>  #define PROC_INFO                                                    \
>>       . = ALIGN(4);                                                   \
>>       VMLINUX_SYMBOL(__proc_info_begin) = .;                          \
>> @@ -43,20 +23,11 @@
>>       VMLINUX_SYMBOL(__idmap_text_start) = .;                         \
>>       *(.idmap.text)                                                  \
>>       VMLINUX_SYMBOL(__idmap_text_end) = .;                           \
>> -     . = ALIGN(1 << LOG2_ROUNDUP(__hyp_idmap_size));                 \
>> +     . = ALIGN(PAGE_SIZE);                                           \
>>       VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;                     \
>>       *(.hyp.idmap.text)                                              \
>>       VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
>>
>> -/*
>> - * If the HYP idmap .text section is populated, it needs to be positioned
>> - * such that it will not cross a page boundary in the final output image.
>> - * So align it to the section size rounded up to the next power of 2.
>> - * If __hyp_idmap_size is undefined, the section will be empty so define
>> - * it as 0 in that case.
>> - */
>> -PROVIDE(__hyp_idmap_size = 0);
>> -
>>  #ifdef CONFIG_HOTPLUG_CPU
>>  #define ARM_CPU_DISCARD(x)
>>  #define ARM_CPU_KEEP(x)              x
>> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
>> index 11fb1d56f449..3988e72d16ff 100644
>> --- a/arch/arm/kvm/init.S
>> +++ b/arch/arm/kvm/init.S
>> @@ -157,6 +157,3 @@ target:   @ We're now in the trampoline code, switch page tables
>>  __kvm_hyp_init_end:
>>
>>       .popsection
>> -
>> -     .global __hyp_idmap_size
>> -     .set    __hyp_idmap_size, __kvm_hyp_init_end - __kvm_hyp_init
>> --
>> 1.8.3.2
>>
