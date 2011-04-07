From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 7 Apr 2011 11:02:18 +0100
Subject: [RFC PATCH] ARM: fiq: Refactor {get,set}_fiq_regs() for Thumb-2
In-Reply-To: <alpine.DEB.2.00.1104061208310.15572@localhost6.localdomain6>
References: <mailman.19600.1302086322.1534.linux-arm-kernel@lists.infradead.org>
	<alpine.DEB.2.00.1104061208310.15572@localhost6.localdomain6>
Message-ID: <BANLkTi=q=A=RBh-mQgZ_4S6NkUJ0O7ERig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 6, 2011 at 12:36 PM, Frank Hofmann <frank.hofmann@tomtom.com> wrote:
>
>> Date: Wed, ?6 Apr 2011 11:29:47 +0100
>> From: Dave Martin <dave.martin@linaro.org>
>> To: linux-arm-kernel at lists.infradead.org
>> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, ? Russell King - ARM Linux
>> ? ? ? ?<linux@arm.linux.org.uk>, patches at linaro.org
>> Subject: [RFC PATCH] ARM: fiq: Refactor {get,set}_fiq_regs() for
>> ? ? ? ?Thumb-2
>> Message-ID: <1302085787-15069-1-git-send-email-dave.martin@linaro.org>
>>
>> * To remove the risk of inconvenient register allocation decisions
>> ?by the compiler, these functions are separated out as pure
>> ?assembler.
>>
>> * The apcs frame manipulation code is not applicable for Thumb-2
>> ?(and also not easily compatible). ?Since it's not essential to
>> ?have a full frame on these leaf assembler functions, the frame
>> ?manipulation is removed, in the interests of simplicity.
>>
>> * Split up ldm/stm instructions to be compatible with Thumb-2,
>> ?as well as avoiding instruction forms deprecated on >= ARMv7.
>
> Hi Dave,
>
> I wonder why the C wrapper set_fiq_regs() is necessary; should be just as
> simple to just have the assembly function called that ?

The main reason for that is to code the ->ARM_r8 in C (as in the
existing code).  I feel safer doing that than hard-coding an offset in
the assembler, though possibly that is overkill since if the layout of
struct pt_regs changes we are probably in trouble for all kinds of
other reasons anyway...

>
> Thing is, the "inline" doesn't force what you're hoping for - it'll still
> create the symbol, because the definition is not known at compile time for
> code using it.

Well, I'm not hoping for the assembly to be inlined, *just* the C
wrapper.  Since the C wrapper is trivial, I prefer to avoid emitting a
function body for this.

>
> Or else leave it inline assembly, how about:
>
> void __naked set_fiq_regs(struct pt_regs *regs)
> {
> asm volatile(
> ? ? ? ?"mov ? ?r2, #(PSR_I_BIT | PSR_F_BIT | FIQ_MODE)\n"
> ? ? ? ?"mrs ? ?r1, cpsr\n"
> ? ? ? ?"msr ? ?cpsr_c, r2\n" ? ? ? ? ? /* select FIQ mode */
> ? ? ? ?"mov ? ?r0, r0\n" ? ? ? ? ? ? ? /* avoid hazard prior to ARMv4 */
> ? ? ? ?"ldmia ?%0!, {r8 - r12}\n"
> ? ? ? ?"ldr ? ?sp, [%0], #4\n"
> ? ? ? ?"ldr ? ?lr, [%0]\n"
> ? ? ? ?"msr ? ?cpsr_c, r1\n" ? ? ? ? ? /* return to SVC mode */
> ? ? ? ?"mov ? ?r0, r0\n" ? ? ? ? ? ? ? /* avoid hazard prior to ARMv4 */
> ? ? ? ?"mov ? ?pc, lr\n"
> ? ? ? ?: : "r" (&regs->ARM_r8) : "r1", "r2");
> }

The main reason for making it pure assembler is there's nothing to
stop the compiler register allocator from using, say, r12 -- that
would break the code because once we switch info FIQ mode the CPU sees
a different r12 from the one the compiler initialised.

I could have used register variables with explicit register
assignments.  Alternatively, I could have added r8-r14 to the clobber
list -- but then the compiler would generate unnecessary save and
restore sequences for all those registers.

However, really all these hacks are attempts to suppress the
compiler's compiler behaviour.  Since we're doing this for complete
functions which we don't need to inline, it seems simplest to achieve
that by taking the compiler out of the situation altogether.

Also, note that PSR_I_BIT | PSR_F_BIT | FIQ_MODE probably has to be an
argument with an "r" constraint -- I don't think the macros will get
expanded if it's embedded in the strings as above.

Does that answer your concerns?

It could be argued that moving these functions is unnecessary churn
for not too much benefit -- if people feel strongly about that, the
functions could still be implemented in inline asm as per your
suggestion.

Cheers
---Dave

>
> FrankH.
>
>>
>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>> ---
>>
>> -/*
>> - * Taking an interrupt in FIQ mode is death, so both these functions
>> - * disable irqs for the duration. ?Note - these functions are almost
>> - * entirely coded in assembly.
>> - */
>> -void __naked set_fiq_regs(struct pt_regs *regs)
>> -{
>> - ? ? ? register unsigned long tmp;
>> - ? ? ? asm volatile (
>> - ? ? ? "mov ? ?ip, sp\n\
>> - ? ? ? stmfd ? sp!, {fp, ip, lr, pc}\n\
>> - ? ? ? sub ? ? fp, ip, #4\n\
>> - ? ? ? mrs ? ? %0, cpsr\n\
>> - ? ? ? msr ? ? cpsr_c, %2 ? ? ?@ select FIQ mode\n\
>> - ? ? ? mov ? ? r0, r0\n\
>> - ? ? ? ldmia ? %1, {r8 - r14}\n\
>> - ? ? ? msr ? ? cpsr_c, %0 ? ? ?@ return to SVC mode\n\
>> - ? ? ? mov ? ? r0, r0\n\
>> - ? ? ? ldmfd ? sp, {fp, sp, pc}"
>> - ? ? ? : "=&r" (tmp)
>> - ? ? ? : "r" (&regs->ARM_r8), "I" (PSR_I_BIT | PSR_F_BIT | FIQ_MODE));
>> -}
>> -
>> -void __naked get_fiq_regs(struct pt_regs *regs)
>> -{
>> - ? ? ? register unsigned long tmp;
>> - ? ? ? asm volatile (
>> - ? ? ? "mov ? ?ip, sp\n\
>> - ? ? ? stmfd ? sp!, {fp, ip, lr, pc}\n\
>> - ? ? ? sub ? ? fp, ip, #4\n\
>> - ? ? ? mrs ? ? %0, cpsr\n\
>> - ? ? ? msr ? ? cpsr_c, %2 ? ? ?@ select FIQ mode\n\
>> - ? ? ? mov ? ? r0, r0\n\
>> - ? ? ? stmia ? %1, {r8 - r14}\n\
>> - ? ? ? msr ? ? cpsr_c, %0 ? ? ?@ return to SVC mode\n\
>> - ? ? ? mov ? ? r0, r0\n\
>> - ? ? ? ldmfd ? sp, {fp, sp, pc}"
>> - ? ? ? : "=&r" (tmp)
>> - ? ? ? : "r" (&regs->ARM_r8), "I" (PSR_I_BIT | PSR_F_BIT | FIQ_MODE));
>> -}
>> -
>> int claim_fiq(struct fiq_handler *f)
>> {
>> ? ? ? ?int ret = 0;
>> @@ -174,8 +133,8 @@ void disable_fiq(int fiq)
>> }
>>
>> EXPORT_SYMBOL(set_fiq_handler);
>> -EXPORT_SYMBOL(set_fiq_regs);
>> -EXPORT_SYMBOL(get_fiq_regs);
>> +EXPORT_SYMBOL(__set_fiq_regs); /* defined in fiqasm.S */
>> +EXPORT_SYMBOL(__get_fiq_regs); /* defined in fiqasm.S */
>> EXPORT_SYMBOL(claim_fiq);
>> EXPORT_SYMBOL(release_fiq);
>> EXPORT_SYMBOL(enable_fiq);
>> diff --git a/arch/arm/kernel/fiqasm.S b/arch/arm/kernel/fiqasm.S
>> new file mode 100644
>> index 0000000..0504bb8
>> --- /dev/null
>> +++ b/arch/arm/kernel/fiqasm.S
>> @@ -0,0 +1,49 @@
>> +/*
>> + * ?linux/arch/arm/kernel/fiqasm.S
>> + *
>> + * ?Derived from code originally in linux/arch/arm/kernel/fiq.c:
>> + *
>> + * ?Copyright (C) 1998 Russell King
>> + * ?Copyright (C) 1998, 1999 Phil Blundell
>> + * ?Copyright (C) 2011, Linaro Limited
>> + *
>> + * ?FIQ support written by Philip Blundell <philb@gnu.org>, 1998.
>> + *
>> + * ?FIQ support re-written by Russell King to be more generic
>> + *
>> + * ?v7/Thumb-2 compatibility modifications by Linaro Limited, 2011.
>> + */
>> +
>> +#include <arm/assembler.h>
>> +
>> +/*
>> + * Taking an interrupt in FIQ mode is death, so both these functions
>> + * disable irqs for the duration. ?Note - these functions are almost
>> + * entirely coded in assembly.
>> + */
>> +
>> +ENTRY(__set_fiq_regs)
>> + ? ? ? mov ? ? r2, #PSR_I_BIT | PSR_F_BIT | FIQ_MODE
>> + ? ? ? mrs ? ? r1, cpsr
>> + ? ? ? msr ? ? cpsr_c, r2 ? ? ?@ select FIQ mode
>> + ? ? ? mov ? ? r0, r0 ? ? ? ? ?@ avoid hazard prior to ARMv4
>> + ? ? ? ldmia ? r0!, {r8 - r12}
>> + ? ? ? ldr ? ? sp, [r0], #4
>> + ? ? ? ldr ? ? lr, [r0]
>> + ? ? ? msr ? ? cpsr_c, r1 ? ? ?@ return to SVC mode
>> + ? ? ? mov ? ? r0, r0 ? ? ? ? ?@ avoid hazard prior to ARMv4
>> + ? ? ? mov ? ? pc, lr
>> +ENDPROC(__set_fiq_regs)
>> +
>> +ENTRY(__get_fiq_regs)
>> + ? ? ? mov ? ? r2, #PSR_I_BIT | PSR_F_BIT | FIQ_MODE
>> + ? ? ? mrs ? ? r1, cpsr
>> + ? ? ? msr ? ? cpsr_c, r2 ? ? ?@ select FIQ mode
>> + ? ? ? mov ? ? r0, r0 ? ? ? ? ?@ avoid hazard prior to ARMv4
>> + ? ? ? stmia ? r0!, {r8 - r12}
>> + ? ? ? str ? ? sp, [r0], #4
>> + ? ? ? str ? ? lr, [r0]
>> + ? ? ? msr ? ? cpsr_c, r1 ? ? ?@ return to SVC mode
>> + ? ? ? mov ? ? r0, r0 ? ? ? ? ?@ avoid hazard prior to ARMv4
>> + ? ? ? mov ? ? pc, lr
>> +ENDPROC(__get_fiq_regs)
>> --
>> 1.7.1
>>
>>
>>
>>
>> ------------------------------
>
