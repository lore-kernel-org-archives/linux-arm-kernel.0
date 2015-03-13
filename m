From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 13 Mar 2015 15:19:36 +0100
Subject: [PATCH] arm64: Get rid of struct cpu_table
In-Reply-To: <5502EE4C.2050703@arm.com>
References: <1426248133-20032-1-git-send-email-marc.zyngier@arm.com>
 <CAKv+Gu-H=q7HsFx-BAUPOOxsA9O7VT=zz4B8rJ5P2_CmF4oLNw@mail.gmail.com>
 <5502EE4C.2050703@arm.com>
Message-ID: <CAKv+Gu8MTq2D0om9PYoQ5sM6OYW0LhKAmO49RROEg7od-ZO4Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2015 at 15:03, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hey Ard,
>
> On 13/03/15 13:33, Ard Biesheuvel wrote:
>> On 13 March 2015 at 13:02, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> struct cpu_table is an artifact left from the (very) early days of
>>> the arm64 port, and its only real use is to allow the most beautiful
>>> "AArch64 Processor" string to be displayed at boot time.
>>>
>>
>> Heh, I looked at that code and assumed it was there for a reason.
>> Apparently not :-)
>
> So did I, until I actually realised what it did... ;-)
>
>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Thanks.
>
>> Some comments below.
>>
>>> Really? Yes, really.
>>>
>>> Let's get rid of it. In order to avoid another BogoMips-gate, the
>>> aforementioned string is preserved.
>>>
>>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  arch/arm64/include/asm/cputable.h | 30 -------------------
>>>  arch/arm64/kernel/Makefile        |  2 +-
>>>  arch/arm64/kernel/asm-offsets.c   |  4 ---
>>>  arch/arm64/kernel/cputable.c      | 33 ---------------------
>>>  arch/arm64/kernel/head.S          | 61 ++++-----------------------------------
>>>  arch/arm64/kernel/setup.c         | 16 ++--------
>>>  6 files changed, 9 insertions(+), 137 deletions(-)
>>>  delete mode 100644 arch/arm64/include/asm/cputable.h
>>>  delete mode 100644 arch/arm64/kernel/cputable.c
>>>
>>> diff --git a/arch/arm64/include/asm/cputable.h b/arch/arm64/include/asm/cputable.h
>>> deleted file mode 100644
>>> index e3bd983..0000000
>>> --- a/arch/arm64/include/asm/cputable.h
>>> +++ /dev/null
>>> @@ -1,30 +0,0 @@
>>> -/*
>>> - * arch/arm64/include/asm/cputable.h
>>> - *
>>> - * Copyright (C) 2012 ARM Ltd.
>>> - *
>>> - * This program is free software: you can redistribute it and/or modify
>>> - * it under the terms of the GNU General Public License version 2 as
>>> - * published by the Free Software Foundation.
>>> - *
>>> - * This program is distributed in the hope that it will be useful,
>>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> - * GNU General Public License for more details.
>>> - *
>>> - * You should have received a copy of the GNU General Public License
>>> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>> - */
>>> -#ifndef __ASM_CPUTABLE_H
>>> -#define __ASM_CPUTABLE_H
>>> -
>>> -struct cpu_info {
>>> -       unsigned int    cpu_id_val;
>>> -       unsigned int    cpu_id_mask;
>>> -       const char      *cpu_name;
>>> -       unsigned long   (*cpu_setup)(void);
>>> -};
>>> -
>>> -extern struct cpu_info *lookup_processor_type(unsigned int);
>>> -
>>> -#endif
>>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>>> index 5ee07ee..d5e7074 100644
>>> --- a/arch/arm64/kernel/Makefile
>>> +++ b/arch/arm64/kernel/Makefile
>>> @@ -12,7 +12,7 @@ CFLAGS_REMOVE_insn.o = -pg
>>>  CFLAGS_REMOVE_return_address.o = -pg
>>>
>>>  # Object file lists.
>>> -arm64-obj-y            := cputable.o debug-monitors.o entry.o irq.o fpsimd.o   \
>>> +arm64-obj-y            := debug-monitors.o entry.o irq.o fpsimd.o              \
>>>                            entry-fpsimd.o process.o ptrace.o setup.o signal.o   \
>>>                            sys.o stacktrace.o time.o traps.o io.o vdso.o        \
>>>                            hyp-stub.o psci.o psci-call.o cpu_ops.o insn.o       \
>>> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
>>> index f7fa65d..14dd3d1 100644
>>> --- a/arch/arm64/kernel/asm-offsets.c
>>> +++ b/arch/arm64/kernel/asm-offsets.c
>>> @@ -24,7 +24,6 @@
>>>  #include <linux/kvm_host.h>
>>>  #include <asm/thread_info.h>
>>>  #include <asm/memory.h>
>>> -#include <asm/cputable.h>
>>>  #include <asm/smp_plat.h>
>>>  #include <asm/suspend.h>
>>>  #include <asm/vdso_datapage.h>
>>> @@ -71,9 +70,6 @@ int main(void)
>>>    BLANK();
>>>    DEFINE(PAGE_SZ,              PAGE_SIZE);
>>>    BLANK();
>>> -  DEFINE(CPU_INFO_SZ,          sizeof(struct cpu_info));
>>> -  DEFINE(CPU_INFO_SETUP,       offsetof(struct cpu_info, cpu_setup));
>>> -  BLANK();
>>>    DEFINE(DMA_BIDIRECTIONAL,    DMA_BIDIRECTIONAL);
>>>    DEFINE(DMA_TO_DEVICE,                DMA_TO_DEVICE);
>>>    DEFINE(DMA_FROM_DEVICE,      DMA_FROM_DEVICE);
>>> diff --git a/arch/arm64/kernel/cputable.c b/arch/arm64/kernel/cputable.c
>>> deleted file mode 100644
>>> index fd3993c..0000000
>>> --- a/arch/arm64/kernel/cputable.c
>>> +++ /dev/null
>>> @@ -1,33 +0,0 @@
>>> -/*
>>> - * arch/arm64/kernel/cputable.c
>>> - *
>>> - * Copyright (C) 2012 ARM Ltd.
>>> - *
>>> - * This program is free software: you can redistribute it and/or modify
>>> - * it under the terms of the GNU General Public License version 2 as
>>> - * published by the Free Software Foundation.
>>> - *
>>> - * This program is distributed in the hope that it will be useful,
>>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> - * GNU General Public License for more details.
>>> - *
>>> - * You should have received a copy of the GNU General Public License
>>> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>> - */
>>> -
>>> -#include <linux/init.h>
>>> -
>>> -#include <asm/cputable.h>
>>> -
>>> -extern unsigned long __cpu_setup(void);
>>> -
>>> -struct cpu_info cpu_table[] = {
>>> -       {
>>> -               .cpu_id_val     = 0x000f0000,
>>> -               .cpu_id_mask    = 0x000f0000,
>>> -               .cpu_name       = "AArch64 Processor",
>>> -               .cpu_setup      = __cpu_setup,
>>> -       },
>>> -       { /* Empty */ },
>>> -};
>>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>>> index 8ce88e0..3ef9cbc 100644
>>> --- a/arch/arm64/kernel/head.S
>>> +++ b/arch/arm64/kernel/head.S
>>> @@ -245,22 +245,12 @@ ENTRY(stext)
>>>         bl      __calc_phys_offset              // x24=PHYS_OFFSET, x28=PHYS_OFFSET-PAGE_OFFSET
>>>         bl      set_cpu_boot_mode_flag
>>>         mrs     x22, midr_el1                   // x22=cpuid
>>> -       mov     x0, x22
>>> -       bl      lookup_processor_type
>>> -       mov     x23, x0                         // x23=current cpu_table
>>> -       /*
>>> -        * __error_p may end up out of range for cbz if text areas are
>>> -        * aligned up to section sizes.
>>> -        */
>>> -       cbnz    x23, 1f                         // invalid processor (x23=0)?
>>> -       b       __error_p

As I mentioned oob, __error_p etc can be removed in its entirety as well.

>>> -1:
>>> +
>>>         bl      __vet_fdt
>>>         bl      __create_page_tables            // x25=TTBR0, x26=TTBR1
>>>         /*
>>>          * The following calls CPU specific code in a position independent
>>> -        * manner. See arch/arm64/mm/proc.S for details. x23 = base of
>>> -        * cpu_info structure selected by lookup_processor_type above.
>>> +        * manner. See arch/arm64/mm/proc.S for details.
>>>          * On return, the CPU will be ready for the MMU to be turned on and
>>>          * the TCR will have been set.
>>>          */
>>> @@ -268,8 +258,8 @@ ENTRY(stext)
>>>                                                 // MMU has been enabled
>>>         adrp    lr, __enable_mmu                // return (PIC) address
>>>         add     lr, lr, #:lo12:__enable_mmu
>>> -       ldr     x12, [x23, #CPU_INFO_SETUP]
>>> -       add     x12, x12, x28                   // __virt_to_phys
>>> +       adrp    x12, __cpu_setup
>>> +       add     x12, x12, #:lo12:__cpu_setup
>>>         br      x12                             // initialise processor
>>
>> b __cpu_setup ?
>
> Yeah, it is unlikely that the kernel will soon grow to be bigger than
> 128MB...
>
>>>  ENDPROC(stext)
>>>
>>> @@ -634,14 +624,10 @@ ENTRY(secondary_startup)
>>>          * Common entry point for secondary CPUs.
>>>          */
>>>         mrs     x22, midr_el1                   // x22=cpuid
>>> -       mov     x0, x22
>>> -       bl      lookup_processor_type
>>> -       mov     x23, x0                         // x23=current cpu_table
>>> -       cbz     x23, __error_p                  // invalid processor (x23=0)?
>>>
>>>         pgtbl   x25, x26, x28                   // x25=TTBR0, x26=TTBR1
>>> -       ldr     x12, [x23, #CPU_INFO_SETUP]
>>> -       add     x12, x12, x28                   // __virt_to_phys
>>> +       adrp    x12, __cpu_setup
>>> +       add     x12, x12, #:lo12:__cpu_setup
>>>         blr     x12                             // initialise processor
>>>
>>
>> bl __cpu_setup ?
>
> Yup, same. I'll fix that.
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
