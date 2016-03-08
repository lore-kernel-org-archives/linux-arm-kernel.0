From: dave.long@linaro.org (David Long)
Date: Tue, 8 Mar 2016 00:42:51 -0500
Subject: [PATCH v10 7/9] arm64: Add trampoline code for kretprobes
In-Reply-To: <56D7592F.70002@redhat.com>
References: <1456801047-29014-1-git-send-email-dave.long@linaro.org>
 <1456801047-29014-8-git-send-email-dave.long@linaro.org>
 <56D5DD27.6040404@arm.com> <56D7592F.70002@redhat.com>
Message-ID: <56DE665B.8080209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2016 04:20 PM, William Cohen wrote:
> On 03/01/2016 01:19 PM, Marc Zyngier wrote:
>> On 01/03/16 02:57, David Long wrote:
>>> From: William Cohen <wcohen@redhat.com>
>>>
>>> The trampoline code is used by kretprobes to capture a return from a probed
>>> function.  This is done by saving the registers, calling the handler, and
>>> restoring the registers. The code then returns to the original saved caller
>>> return address. It is necessary to do this directly instead of using a
>>> software breakpoint because the code used in processing that breakpoint
>>> could itself be kprobe'd and cause a problematic reentry into the debug
>>> exception handler.
>>>
>>> Signed-off-by: William Cohen <wcohen@redhat.com>
>>> Signed-off-by: David A. Long <dave.long@linaro.org>
>>> ---
>>>   arch/arm64/include/asm/kprobes.h       |  2 +
>>>   arch/arm64/kernel/Makefile             |  1 +
>>>   arch/arm64/kernel/asm-offsets.c        | 22 +++++++++++
>>>   arch/arm64/kernel/kprobes.c            |  5 +++
>>>   arch/arm64/kernel/kprobes_trampoline.S | 67 ++++++++++++++++++++++++++++++++++
>>>   5 files changed, 97 insertions(+)
>>>   create mode 100644 arch/arm64/kernel/kprobes_trampoline.S
>>>
>>> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
>>> index 79c9511..61b4915 100644
>>> --- a/arch/arm64/include/asm/kprobes.h
>>> +++ b/arch/arm64/include/asm/kprobes.h
>>> @@ -56,5 +56,7 @@ int kprobe_exceptions_notify(struct notifier_block *self,
>>>   			     unsigned long val, void *data);
>>>   int kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr);
>>>   int kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr);
>>> +void kretprobe_trampoline(void);
>>> +void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
>>>
>>>   #endif /* _ARM_KPROBES_H */
>>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>>> index 08325e5..f192b7d 100644
>>> --- a/arch/arm64/kernel/Makefile
>>> +++ b/arch/arm64/kernel/Makefile
>>> @@ -37,6 +37,7 @@ arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
>>>   arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
>>>   arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
>>>   arm64-obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-arm64.o		\
>>> +					   kprobes_trampoline.o			\
>>>   					   probes-simulate-insn.o
>>>   arm64-obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o
>>>   arm64-obj-$(CONFIG_PCI)			+= pci.o
>>> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
>>> index fffa4ac6..460b54c 100644
>>> --- a/arch/arm64/kernel/asm-offsets.c
>>> +++ b/arch/arm64/kernel/asm-offsets.c
>>> @@ -50,6 +50,28 @@ int main(void)
>>>     DEFINE(S_X5,			offsetof(struct pt_regs, regs[5]));
>>>     DEFINE(S_X6,			offsetof(struct pt_regs, regs[6]));
>>>     DEFINE(S_X7,			offsetof(struct pt_regs, regs[7]));
>>> +  DEFINE(S_X8,			offsetof(struct pt_regs, regs[8]));
>>> +  DEFINE(S_X9,			offsetof(struct pt_regs, regs[9]));
>>> +  DEFINE(S_X10,			offsetof(struct pt_regs, regs[10]));
>>> +  DEFINE(S_X11,			offsetof(struct pt_regs, regs[11]));
>>> +  DEFINE(S_X12,			offsetof(struct pt_regs, regs[12]));
>>> +  DEFINE(S_X13,			offsetof(struct pt_regs, regs[13]));
>>> +  DEFINE(S_X14,			offsetof(struct pt_regs, regs[14]));
>>> +  DEFINE(S_X15,			offsetof(struct pt_regs, regs[15]));
>>> +  DEFINE(S_X16,			offsetof(struct pt_regs, regs[16]));
>>> +  DEFINE(S_X17,			offsetof(struct pt_regs, regs[17]));
>>> +  DEFINE(S_X18,			offsetof(struct pt_regs, regs[18]));
>>> +  DEFINE(S_X19,			offsetof(struct pt_regs, regs[19]));
>>> +  DEFINE(S_X20,			offsetof(struct pt_regs, regs[20]));
>>> +  DEFINE(S_X21,			offsetof(struct pt_regs, regs[21]));
>>> +  DEFINE(S_X22,			offsetof(struct pt_regs, regs[22]));
>>> +  DEFINE(S_X23,			offsetof(struct pt_regs, regs[23]));
>>> +  DEFINE(S_X24,			offsetof(struct pt_regs, regs[24]));
>>> +  DEFINE(S_X25,			offsetof(struct pt_regs, regs[25]));
>>> +  DEFINE(S_X26,			offsetof(struct pt_regs, regs[26]));
>>> +  DEFINE(S_X27,			offsetof(struct pt_regs, regs[27]));
>>> +  DEFINE(S_X28,			offsetof(struct pt_regs, regs[28]));
>>> +  DEFINE(S_X29,			offsetof(struct pt_regs, regs[29]));
>>
>> Do we need all of these? Specially considering that we're only using the
>> even ones? You may want to consider something like
>> arch/arm64/kvm/hyp/entry.S does.
>
> Following what arch/arm64/kvm/hyp/entry.S does would make the patch a bit smaller.
>

I have cut the defines in half and duplicated the entry.S style using 
macros.

>>
>>>     DEFINE(S_LR,			offsetof(struct pt_regs, regs[30]));
>>>     DEFINE(S_SP,			offsetof(struct pt_regs, sp));
>>>   #ifdef CONFIG_COMPAT
>>> diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
>>> index ffc5affd..98f4fe5 100644
>>> --- a/arch/arm64/kernel/kprobes.c
>>> +++ b/arch/arm64/kernel/kprobes.c
>>> @@ -532,6 +532,11 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>>>   	return 1;
>>>   }
>>>
>>> +void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
>>> +{
>>> +	return (void *) 0;
>>
>> Something wrong with NULL? ;-)
>
> Nothing wrong with using NULL.
>

Changed.

>>
>>> +}
>>> +
>>>   int __init arch_init_kprobes(void)
>>>   {
>>>   	return 0;
>>> diff --git a/arch/arm64/kernel/kprobes_trampoline.S b/arch/arm64/kernel/kprobes_trampoline.S
>>> new file mode 100644
>>> index 0000000..5a336cf
>>> --- /dev/null
>>> +++ b/arch/arm64/kernel/kprobes_trampoline.S
>>> @@ -0,0 +1,67 @@
>>> +/*
>>> + * trampoline entry and return code for kretprobes.
>>> + */
>>> +
>>> +#include <linux/linkage.h>
>>> +#include <generated/asm-offsets.h>
>>
>> #include <asm/asm-offsets.h>
>>

Fixed.

>>> +
>>> +	.text
>>> +
>>> +ENTRY(kretprobe_trampoline)
>>> +
>>> +	sub sp, sp, #S_FRAME_SIZE
>>> +
>>> +	stp x0, x1, [sp, #S_X0]
>>> +	stp x2, x3, [sp, #S_X2]
>>> +	stp x4, x5, [sp, #S_X4]
>>> +	stp x6, x7, [sp, #S_X6]
>>> +	stp x8, x9, [sp, #S_X8]
>>> +	stp x10, x11, [sp, #S_X10]
>>> +	stp x12, x13, [sp, #S_X12]
>>> +	stp x14, x15, [sp, #S_X14]
>>> +	stp x16, x17, [sp, #S_X16]
>>> +	stp x18, x19, [sp, #S_X18]
>>> +	stp x20, x21, [sp, #S_X20]
>>> +	stp x22, x23, [sp, #S_X22]
>>> +	stp x24, x25, [sp, #S_X24]
>>> +	stp x26, x27, [sp, #S_X26]
>>> +	stp x28, x29, [sp, #S_X28]
>>> +	str x30, [sp, #S_LR]
>>
>> Might as well call it LR?

Ah, that exposed the fact there's a missing include of asm/assembler.h. 
  All fixed.

>
> Given the code is going to overwrite lr with the value returned by trampoline_probe_handler might eliminate the store to #S_LR above.
>

It's not only about what's restored though, it's about what the 
trace/user code is told the register contents are.

>>
>>> +	add x0, sp, #S_FRAME_SIZE
>>> +	str x0, [sp, #S_SP]
>>> +	mrs x0, nzcv
>>> +	mrs x1, daif
>>> +	orr x0, x0, x1
>>> +	/* There seems no easy way to get the mode field so make one up */
>>> +	add x0, x0, #5
>>
>> Do you mean something like CurrentEL? You could also save SPSel whilst
>> you're at it.

OK, I've retrieved CurrentEL and SPSel and orr'd them into the saved PSTATE.

>
> Looking at the my patch again I am wondering if the patch could skip storing daif and the mode field.  The nzcv bit are the only thing restored.
>

Again, want to have realistic saved register contents.

>>
>>> +	str x0, [sp, #S_PSTATE]
>>> +
>>> +	mov x0, sp
>>> +	bl trampoline_probe_handler
>>> +	/* Replace trampoline address in lr with actual
>>> +	   orig_ret_addr return address. */
>>> +	str x0, [sp, #S_LR]
>>
>> Why do you need to store it on the stack? You could do a "mov lr, x0",
>> and drop the last load of the sequence below...
>
> Ah, yes, that would save a store/load pair.
>

Done.

>>> +
>>> +	ldr x0, [sp, #S_PSTATE]
>>> +	msr nzcv, x0
>>> +	ldp x0, x1, [sp, #S_X0]
>>> +	ldp x2, x3, [sp, #S_X2]
>>> +	ldp x4, x5, [sp, #S_X4]
>>> +	ldp x6, x7, [sp, #S_X6]
>>> +	ldp x8, x9, [sp, #S_X8]
>>> +	ldp x10, x11, [sp, #S_X10]
>>> +	ldp x12, x13, [sp, #S_X12]
>>> +	ldp x14, x15, [sp, #S_X14]
>>> +	ldp x16, x17, [sp, #S_X16]
>>> +	ldp x18, x19, [sp, #S_X18]
>>> +	ldp x20, x21, [sp, #S_X20]
>>> +	ldp x22, x23, [sp, #S_X22]
>>> +	ldp x24, x25, [sp, #S_X24]
>>> +	ldp x26, x27, [sp, #S_X26]
>>> +	ldp x28, x29, [sp, #S_X28]
>>> +	ldr x30, [sp, #S_LR]
>>> +
>>> +	add sp, sp, #S_FRAME_SIZE
>>> +	ret
>>> +
>>> +ENDPROC(kretprobe_trampoline)
>>>
>>
>> Thanks,
>>
>> 	M.
>>
>
> Thanks,
>
> -Will
>


-dl
