From: dave.long@linaro.org (David Long)
Date: Wed, 20 Jul 2016 15:08:42 -0400
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <578F4608.4030901@arm.com>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578F4608.4030901@arm.com>
Message-ID: <578FCC3A.6090805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2016 05:36 AM, Marc Zyngier wrote:
> On 08/07/16 17:35, David Long wrote:
>> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>>
>> Add support for basic kernel probes(kprobes) and jump probes
>> (jprobes) for ARM64.
>>
>> Kprobes utilizes software breakpoint and single step debug
>> exceptions supported on ARM v8.
>>
>> A software breakpoint is placed at the probe address to trap the
>> kernel execution into the kprobe handler.
>>
>> ARM v8 supports enabling single stepping before the break exception
>> return (ERET), with next PC in exception return address (ELR_EL1). The
>> kprobe handler prepares an executable memory slot for out-of-line
>> execution with a copy of the original instruction being probed, and
>> enables single stepping. The PC is set to the out-of-line slot address
>> before the ERET. With this scheme, the instruction is executed with the
>> exact same register context except for the PC (and DAIF) registers.
>>
>> Debug mask (PSTATE.D) is enabled only when single stepping a recursive
>> kprobe, e.g.: during kprobes reenter so that probed instruction can be
>> single stepped within the kprobe handler -exception- context.
>> The recursion depth of kprobe is always 2, i.e. upon probe re-entry,
>> any further re-entry is prevented by not calling handlers and the case
>> counted as a missed kprobe).
>>
>> Single stepping from the x-o-l slot has a drawback for PC-relative accesses
>> like branching and symbolic literals access as the offset from the new PC
>> (slot address) may not be ensured to fit in the immediate value of
>> the opcode. Such instructions need simulation, so reject
>> probing them.
>>
>> Instructions generating exceptions or cpu mode change are rejected
>> for probing.
>>
>> Exclusive load/store instructions are rejected too.  Additionally, the
>> code is checked to see if it is inside an exclusive load/store sequence
>> (code from Pratyush).
>>
>> System instructions are mostly enabled for stepping, except MSR/MRS
>> accesses to "DAIF" flags in PSTATE, which are not safe for
>> probing.
>>
>> This also changes arch/arm64/include/asm/ptrace.h to use
>> include/asm-generic/ptrace.h.
>>
>> Thanks to Steve Capper and Pratyush Anand for several suggested
>> Changes.
>>
>> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>> ---
>
> [...]
>
>> +void __kprobes jprobe_return(void)
>> +{
>> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +
>> +	/*
>> +	 * Jprobe handler return by entering break exception,
>> +	 * encoded same as kprobe, but with following conditions
>> +	 * -a magic number in x0 to identify from rest of other kprobes.
>> +	 * -restore stack addr to original saved pt_regs
>> +	 */
>> +	asm volatile ("ldr x0, [%0]\n\t"
>> +		      "mov sp, x0\n\t"
>> +		      ".globl jprobe_return_break\n\t"
>> +		      "jprobe_return_break:\n\t"
>> +		      "brk %1\n\t"
>> +		      :
>> +		      : "r"(&kcb->jprobe_saved_regs.sp),
>> +		      "I"(BRK64_ESR_KPROBES)
>> +		      : "memory");
>
> A couple of remarks here:
> - the comment seems wrong, as you load the stack pointer in X0, nothing
> else, and seem to identify the jprobe by looking at the PC, not X0.

Yes, this describes how it originally worked but I changed it based on 
earlier feedback. Apparently this comment did not get updated.

> - using explicit registers is really ugly. How about something like this
> instead:
>
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index c89811d..823cf92 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -513,13 +513,12 @@ void __kprobes jprobe_return(void)
>   	 * -a magic number in x0 to identify from rest of other kprobes.
>   	 * -restore stack addr to original saved pt_regs
>   	 */
> -	asm volatile ("ldr x0, [%0]\n\t"
> -		      "mov sp, x0\n\t"
> +	asm volatile ("mov sp, %0\n\t"
>   		      ".globl jprobe_return_break\n\t"
>   		      "jprobe_return_break:\n\t"
>   		      "brk %1\n\t"
>   		      :
> -		      : "r"(&kcb->jprobe_saved_regs.sp),
> +		      : "r" (kcb->jprobe_saved_regs.sp),
>   		      "I"(BRK64_ESR_KPROBES)
>   		      : "memory");
>   }
>

OK

> though hijacking SP in the middle of a C function still feels pretty fragile.
>
> Thanks,
>
> 	M.
>

Thanks,
-dl
