From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Mon, 30 Sep 2013 12:53:11 +0530
Subject: [RFC PATCH 1/2] Aarch64: KGDB: Add Basic KGDB support
In-Reply-To: <20130924132823.GB18167@mudshark.cambridge.arm.com>
References: <1379321750-907-1-git-send-email-vijay.kilari@gmail.com>
 <1379321750-907-2-git-send-email-vijay.kilari@gmail.com>
 <20130916112943.GG21320@mudshark.cambridge.arm.com>
 <CALicx6v1eGHRwWPrjzihzBZxCu8t1vpMoq-YfutSm4mRmP6gEQ@mail.gmail.com>
 <20130924132823.GB18167@mudshark.cambridge.arm.com>
Message-ID: <CALicx6th1KLVEkQbZPM-2UrMHDWJ6obH30d3-_1YLXV2xYr0cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 6:58 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Sep 23, 2013 at 08:04:48AM +0100, Vijay Kilari wrote:
>> On Mon, Sep 16, 2013 at 4:59 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Mon, Sep 16, 2013 at 09:55:49AM +0100, vijay.kilari at gmail.com wrote:
>> >> diff --git a/arch/arm64/include/asm/kgdb.h b/arch/arm64/include/asm/kgdb.h
>> >> new file mode 100644
>> >> index 0000000..5b5f59e
>> >> --- /dev/null
>> >> +++ b/arch/arm64/include/asm/kgdb.h
>> >> @@ -0,0 +1,61 @@
>> >> +/*
>> >> + * Aarch64 KGDB support
>> >> + *
>> >> + * Author: Vijaya Kumar <vijaya.kumar@caviumnetworks.com>
>> >> + *
>> >> + * contents are extracted from arch/arm/include/kgdb.h
>> >> + *
>> >> + */
>> >> +
>> >> +#ifndef __ARM_KGDB_H__
>> >> +#define __ARM_KGDB_H__
>> >> +
>> >> +#include <linux/ptrace.h>
>> >> +
>> >> +/*
>> >> + * Break Instruction encoding
>> >> + */
>> >> +
>> >> +#define BREAK_INSTR_SIZE               4
>> >> +#define KGDB_BREAKINST_ESR_VAL         0xf2000000
>> >> +#define KGDB_COMPILED_BREAK_ESR_VAL    0xf2000001
>> >
>> > These ESR values are tied directly to your immediate choices for the BRK
>> > instruction, so I'd rather they were constructed that way (then we can
>> > #define all of the immediates in a common header, like debug-monitors.h).
>> >
>>
>> Yes, these values are constructed. However to distinguish between
>> normal break point and compile time break point, I have chosen value
>> 0x1 as immediate
>> value.
>
> I can see that. What I dislike is the way you've structured the code. Please
> can you define the immediates (i.e. 0, 1) in debug-monitors.h?
>
Yes, I will move this code to debug-monitors.h

>> >> +#define CACHE_FLUSH_IS_SAFE            1
>> >> +
>> >> +#ifndef        __ASSEMBLY__
>> >> +
>> >> +static inline void arch_kgdb_breakpoint(void)
>> >> +{
>> >> +#ifndef __ARMEB__
>> >> +     asm(".word 0xd4200020");
>> >> +#else
>> >> +     asm(".word 0x200020d4");
>> >> +#endif
>> >
>> > Huh? Instructions are always little endian. Why can't you just do:
>> >
>> >   asm ("brk %0" :: "I" (ARM64_KGDB_BRK_IMM));
>> >
>> > or something like that?
>> >
>> OK. I will check with this
>
> Yes, then you don't need to build the instruction encoding from scratch.
> Instead, you just take the relevant definition for the immediate operand.
>
OK. I will include in next version

>> >> +#define NUMREGBYTES          (DBG_MAX_REG_NUM << 2)
>> >
>> > << 2? Are you sure?
>> >
>>  These values are used for defining size of buffer to be used.
>> This value is legacy and should be enough as there is no major
>> changes in GDB host side in terms of buffer requirement.
>
> There's no legacy here. If you're referring to arch/arm/, then the register
> file is significantly different, as well as the registers being half the
> size, so your NUMREGBYTES definition is certainly incorrect.
>
I have reworked this, the right value is.

#define NUMREGBYTES     (((_GP_REGS * 8) - 4) + (_FP_REGS * 16) + \
                        (_EXTRA_REGS * 4))


_GP_REGS is 8 bytes, _FP_REGS is 16 bytes and _EXTRA_REGS is 4 bytes each
 and pstate reg is 4 bytes. So subtract 4 from size contributed
 by _GP_REGS.
 GDB fails to connect for size beyond this with error
 "'g' packet reply is too long"

>> >> +     case 'c':
>> >> +             /*
>> >> +              * Try to read optional parameter, pc unchanged if no parm.
>> >> +              * If this was a compiled breakpoint, we need to move
>> >> +              * to the next instruction or we will just breakpoint
>> >> +              * over and over again.
>> >> +              */
>> >> +             ptr = &remcom_in_buffer[1];
>> >> +             if (kgdb_hex2long(&ptr, &addr))
>> >> +                     linux_regs->pc = addr;
>> >> +             else if (compiled_break == 1)
>> >> +                     linux_regs->pc += 4;
>> >> +
>> >> +             compiled_break = 0;
>> >
>> > I'm not familiar with how kdgb works, but why does this not cause problems
>> > with SMP? Does KGDB just park the secondaries and only deal with exceptions
>> > on the primary CPU?
>> >
>> Yes, KGDB parks other CPU's and only once CPU (primary / Secondary) will
>> be responding to GDB requests
>
> Ok. Is it guaranteed to be the same CPU responding to the requests each
> time?
>
Yes, the same CPU will be responding to the requests.
it is taken care in kernel/debug/debug_core.c

>> >> +struct kgdb_arch arch_kgdb_ops = {
>> >> +#ifndef __ARMEB__
>> >> +     .gdb_bpt_instr          = {0x00, 0x00, 0x20, 0xd4}
>> >> +#else /* ! __ARMEB__ */
>> >> +     .gdb_bpt_instr          = {0xd4, 0x20, 0x00, 0x00}
>> >> +#endif
>> >
>> > __ARMEB__????
>>  ARMEB is for Big endian encoding.
>
> (1) We don't currently support big-endian in mainline Linux
>
> (2) __ARMEB__ isn't be emitted by the AArch64 toolchain
>
> Have you tested this code?
>
This is redundant, Only LE encoding is enough as ARM instructions are
always in LE mode as below
struct kgdb_arch arch_kgdb_ops = {
      .gdb_bpt_instr          = {0x00, 0x00, 0x20, 0xd4}
}

> Will
