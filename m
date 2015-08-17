From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 17 Aug 2015 14:21:20 +0900
Subject: [RFC v2 4/4] arm64: ftrace: add a stack frame for exception
 handler
In-Reply-To: <6399AE18-786B-41C2-B1C7-428567D9CF47@gmail.com>
References: <1438674249-3447-1-git-send-email-takahiro.akashi@linaro.org>
 <1438674249-3447-5-git-send-email-takahiro.akashi@linaro.org>
 <6399AE18-786B-41C2-B1C7-428567D9CF47@gmail.com>
Message-ID: <55D16F50.3060009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2015 11:57 PM, Jungseok Lee wrote:
> On Aug 4, 2015, at 4:44 PM, AKASHI Takahiro wrote:
>
> Hi Akashi,
>
>> On arm64, an exception handler use the same stack as in non-exception
>> contexts, but doesn't create a stack frame for elx_xx entry, only updating
>> sp register. This behavior results in save_stace_trace() missing a function
>> that is the one when an exception happens.
>>
>> This patch creates a stack frame for this case, and puts an additional
>> entry for the function  in a stack trace list.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>> arch/arm64/kernel/entry.S      |    4 ++++
>> arch/arm64/kernel/stacktrace.c |   17 +++++++++++++++++
>> 2 files changed, 21 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index f860bfd..aacb6c6 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -107,6 +107,8 @@
>> 	str	x21, [sp, #S_SYSCALLNO]
>> 	.endif
>>
>> +	/* create a stack frame for stack tracer */
>> +	mov	x29, sp
>> 	/*
>> 	 * Registers that may be useful after this macro is invoked:
>> 	 *
>> @@ -737,3 +739,5 @@ ENTRY(sys_rt_sigreturn_wrapper)
>> 	mov	x0, sp
>> 	b	sys_rt_sigreturn
>> ENDPROC(sys_rt_sigreturn_wrapper)
>> +
>> +ENTRY(end_of_vectors)
>> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
>> index d1790eb..22ce7c9 100644
>> --- a/arch/arm64/kernel/stacktrace.c
>> +++ b/arch/arm64/kernel/stacktrace.c
>> @@ -25,6 +25,10 @@
>> #include <asm/stacktrace.h>
>>
>> #define S_FRAME_SIZE sizeof(struct pt_regs) /* asm-offsets.h */
>> +#define S_FP offsetof(struct pt_regs, regs[29])
>> +#define S_LR offsetof(struct pt_regs, regs[30])
>> +
>> +extern unsigned int *vectors, *end_of_vectors;
>>
>> /*
>>   * AArch64 PCS assigns the frame pointer to x29.
>> @@ -50,6 +54,19 @@ int notrace unwind_frame(struct stackframe *frame)
>> 	if (fp < low || fp > high - 0x18 || fp & 0xf)
>> 		return -EINVAL;
>>
>> +	if ((frame->pc >= (unsigned long)&vectors) &&
>> +			(frame->pc < (unsigned long)&end_of_vectors)) {
>> +		/*
>> +		 * Expection handler does not use a normal format of
>> +		 * stack frame, but allocates struct pt_regs.
>> +		 */
>> +		frame->sp = frame->sp + S_FRAME_SIZE;
>> +		frame->fp = *(unsigned long *)(fp + S_FP);
>> +		frame->pc = *(unsigned long *)(fp + S_LR);
>
> Not frame->pc = *(unsigned long *)(fp + S_PC)? Don't we need to look up elr_el1
> since this is an exception?

You are right. Will fix it if I submit the next version.

>> +
>> +		return 0;
>> +	}
>> +
>> 	frame->sp = fp + 0x10;
>
> I'm just curious about this constant, 0x10. Do you have an idea on this value?
> As reviewing objdump of vmlinux, it looks needed to analyze the first store-pair
> instruction of each function.
>
> Please correct me if I'm wrong.

I don't know Catalin's intention here, but fp always points to saved pair of
<fp, lr> and so, in general, "fp + 0x10" is the address of succeeding local variables
in callee function. (Remember my acsii art :)
This can be the easily-approximated (but not accurate) stack pointer of caller unless
we decode function prologues.

Thanks,
-Takahiro AKASHI

> Best Regards
> Jungseok Lee
>
