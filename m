From: dave.long@linaro.org (David Long)
Date: Mon, 21 Mar 2016 09:30:43 -0400
Subject: [PATCH v11 7/9] arm64: Add trampoline code for kretprobes
In-Reply-To: <20160313135210.20921b47@arm.com>
References: <1457501543-24197-1-git-send-email-dave.long@linaro.org>
 <1457501543-24197-8-git-send-email-dave.long@linaro.org>
 <20160313135210.20921b47@arm.com>
Message-ID: <56EFF783.3060600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2016 09:52 AM, Marc Zyngier wrote:
> On Wed,  9 Mar 2016 00:32:21 -0500
> David Long <dave.long@linaro.org> wrote:
>
> David,
>
> I remember looking at that code over your shoulder whilst at Connect
> last week, but I clearly wasn't running on all cylinders, because there
> is a few gotchas here - see below.
>
>> From: William Cohen <wcohen@redhat.com>
>>
>> The trampoline code is used by kretprobes to capture a return from a probed
>> function.  This is done by saving the registers, calling the handler, and
>> restoring the registers. The code then returns to the original saved caller
>> return address. It is necessary to do this directly instead of using a
>> software breakpoint because the code used in processing that breakpoint
>> could itself be kprobe'd and cause a problematic reentry into the debug
>> exception handler.
>>
>> Signed-off-by: William Cohen <wcohen@redhat.com>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>>   arch/arm64/include/asm/kprobes.h       |  2 +
>>   arch/arm64/kernel/Makefile             |  1 +
>>   arch/arm64/kernel/asm-offsets.c        | 11 +++++
>>   arch/arm64/kernel/kprobes.c            |  5 ++
>>   arch/arm64/kernel/kprobes_trampoline.S | 88 ++++++++++++++++++++++++++++++++++
>>   5 files changed, 107 insertions(+)
>>   create mode 100644 arch/arm64/kernel/kprobes_trampoline.S
>>
>> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
>> index 79c9511..61b4915 100644
>> --- a/arch/arm64/include/asm/kprobes.h
>> +++ b/arch/arm64/include/asm/kprobes.h
>> @@ -56,5 +56,7 @@ int kprobe_exceptions_notify(struct notifier_block *self,
>>   			     unsigned long val, void *data);
>>   int kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr);
>>   int kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr);
>> +void kretprobe_trampoline(void);
>> +void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
>>
>>   #endif /* _ARM_KPROBES_H */
>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> index 08325e5..f192b7d 100644
>> --- a/arch/arm64/kernel/Makefile
>> +++ b/arch/arm64/kernel/Makefile
>> @@ -37,6 +37,7 @@ arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
>>   arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
>>   arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
>>   arm64-obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-arm64.o		\
>> +					   kprobes_trampoline.o			\
>>   					   probes-simulate-insn.o
>>   arm64-obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o
>>   arm64-obj-$(CONFIG_PCI)			+= pci.o
>> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
>> index fffa4ac6..f7cc8ce 100644
>> --- a/arch/arm64/kernel/asm-offsets.c
>> +++ b/arch/arm64/kernel/asm-offsets.c
>> @@ -50,6 +50,17 @@ int main(void)
>>     DEFINE(S_X5,			offsetof(struct pt_regs, regs[5]));
>>     DEFINE(S_X6,			offsetof(struct pt_regs, regs[6]));
>>     DEFINE(S_X7,			offsetof(struct pt_regs, regs[7]));
>> +  DEFINE(S_X8,			offsetof(struct pt_regs, regs[8]));
>> +  DEFINE(S_X10,			offsetof(struct pt_regs, regs[10]));
>> +  DEFINE(S_X12,			offsetof(struct pt_regs, regs[12]));
>> +  DEFINE(S_X14,			offsetof(struct pt_regs, regs[14]));
>> +  DEFINE(S_X16,			offsetof(struct pt_regs, regs[16]));
>> +  DEFINE(S_X18,			offsetof(struct pt_regs, regs[18]));
>> +  DEFINE(S_X20,			offsetof(struct pt_regs, regs[20]));
>> +  DEFINE(S_X22,			offsetof(struct pt_regs, regs[22]));
>> +  DEFINE(S_X24,			offsetof(struct pt_regs, regs[24]));
>> +  DEFINE(S_X26,			offsetof(struct pt_regs, regs[26]));
>> +  DEFINE(S_X28,			offsetof(struct pt_regs, regs[28]));
>>     DEFINE(S_LR,			offsetof(struct pt_regs, regs[30]));
>>     DEFINE(S_SP,			offsetof(struct pt_regs, sp));
>>   #ifdef CONFIG_COMPAT
>> diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
>> index ffc5affd..bd3f233 100644
>> --- a/arch/arm64/kernel/kprobes.c
>> +++ b/arch/arm64/kernel/kprobes.c
>> @@ -532,6 +532,11 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>>   	return 1;
>>   }
>>
>> +void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
>> +{
>> +	return NULL;
>> +}
>> +
>>   int __init arch_init_kprobes(void)
>>   {
>>   	return 0;
>> diff --git a/arch/arm64/kernel/kprobes_trampoline.S b/arch/arm64/kernel/kprobes_trampoline.S
>> new file mode 100644
>> index 0000000..072b4e5
>> --- /dev/null
>> +++ b/arch/arm64/kernel/kprobes_trampoline.S
>> @@ -0,0 +1,88 @@
>> +/*
>> + * trampoline entry and return code for kretprobes.
>> + */
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/asm-offsets.h>
>> +#include <asm/assembler.h>
>> +
>> +	.text
>> +
>> +.macro save_all_base_regs ctxt
>> +	stp x0, x1, [\ctxt, #S_X0]
>> +	stp x2, x3, [\ctxt, #S_X2]
>> +	stp x4, x5, [\ctxt, #S_X4]
>> +	stp x6, x7, [\ctxt, #S_X6]
>> +	stp x8, x9, [\ctxt, #S_X8]
>> +	stp x10, x11, [\ctxt, #S_X10]
>> +	stp x12, x13, [\ctxt, #S_X12]
>> +	stp x14, x15, [\ctxt, #S_X14]
>> +	stp x16, x17, [\ctxt, #S_X16]
>> +	stp x18, x19, [\ctxt, #S_X18]
>> +	stp x20, x21, [\ctxt, #S_X20]
>> +	stp x22, x23, [\ctxt, #S_X22]
>> +	stp x24, x25, [\ctxt, #S_X24]
>> +	stp x26, x27, [\ctxt, #S_X26]
>> +	stp x28, x29, [\ctxt, #S_X28]
>> +	str lr, [\ctxt, #S_LR]
>> +	add x0, \ctxt, #S_FRAME_SIZE
>> +	str x0, [\ctxt, #S_SP]
>
> Nit: this could also be rewritten as:
>
> 	add	x0, \ctxt, #S_FRAME_SIZE
> 	stp	lr, xo, [\ctxt, #S_LR]
>
> Another thing worth noting is that since your macro saves all the
> GP registers, only SP can be used for the ctxt parameter. This means
> you're better off hardcoding SP in this macro, and not give the
> illusion of being generic.
>

OK.

>> +/*
>> + * Construct a useful saved PSTATE
>> + */
>> +	mrs x0, nzcv
>> +	and x0, x0, #0xf0000000
>
> It'd be worth spelling this as (PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT |
> PSR_V_BIT)...
>

OK.

>> +	mrs x1, daif
>> +	and x1, x1, #0x3c0
>
> ... and this as (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT).
>

OK.

>> +	orr x0, x0, x1
>> +	mrs x1, CurrentEL
>> +	and x1, x1, #12
>
> I'd like this '12' to be a bit more explicit. How about (3 << 2)? I
> tend to parse this kind of things much more easily...
>

OK.

>> +	lsl x1, x1, #21
>
> What's that shift for? The various bits should be at the right place
> already.
>

At the time it made sense, but rereading the ARM ARM it's not making so 
much sense.

>> +	orr x0, x1, x0
>> +	mrs x1, SPSel
>> +	and x1, x1, #1
>> +	lsl x1, x1, #21
>
> Same here (you're in single-step territory, which is probably not what
> you want...).
>

See previous comment.

>> +	orr x0, x1, x0
>> +	str x0, [\ctxt, #S_PSTATE]
>> +.endm
>> +
>> +.macro restore_all_base_regs ctxt
>
> Same remark about the pseudo-generic parameter.
>

OK.

>> +	ldr x0, [\ctxt, #S_PSTATE]
>> +	and x0, x0, #0xf0000000
>
> Same remark about using the PSR_* macros.
>

OK.

>> +	msr nzcv, x0
>> +	ldp x0, x1, [\ctxt, #S_X0]
>> +	ldp x2, x3, [\ctxt, #S_X2]
>> +	ldp x4, x5, [\ctxt, #S_X4]
>> +	ldp x6, x7, [\ctxt, #S_X6]
>> +	ldp x8, x9, [\ctxt, #S_X8]
>> +	ldp x10, x11, [\ctxt, #S_X10]
>> +	ldp x12, x13, [\ctxt, #S_X12]
>> +	ldp x14, x15, [\ctxt, #S_X14]
>> +	ldp x16, x17, [\ctxt, #S_X16]
>> +	ldp x18, x19, [\ctxt, #S_X18]
>> +	ldp x20, x21, [\ctxt, #S_X20]
>> +	ldp x22, x23, [\ctxt, #S_X22]
>> +	ldp x24, x25, [\ctxt, #S_X24]
>> +	ldp x26, x27, [\ctxt, #S_X26]
>> +	ldp x28, x29, [\ctxt, #S_X28]
>> +.endm
>> +
>> +ENTRY(kretprobe_trampoline)
>> +
>> +	sub sp, sp, #S_FRAME_SIZE
>> +
>> +	save_all_base_regs sp
>> +
>> +	mov x0, sp
>> +	bl trampoline_probe_handler
>> +	/* Replace trampoline address in lr with actual
>> +	   orig_ret_addr return address. */
>> +	mov lr, x0
>> +
>> +	restore_all_base_regs sp
>> +
>> +	add sp, sp, #S_FRAME_SIZE
>> +
>> +	ret
>> +
>> +ENDPROC(kretprobe_trampoline)
>
> Thanks,
>
> 	M.
>
