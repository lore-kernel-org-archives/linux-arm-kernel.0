From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 11 Jul 2011 14:14:45 -0400 (EDT)
Subject: [PATCH 02/51] ARM: Thumb-2: Support Thumb-2 in undefined
	instruction handler
In-Reply-To: <1310209058-20980-3-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
	<1310209058-20980-3-git-send-email-tixy@yxit.co.uk>
Message-ID: <alpine.LFD.2.00.1107111414070.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 9 Jul 2011, Tixy wrote:

> From: Jon Medhurst <tixy@yxit.co.uk>
> 
> This patch allows undef_hook's to be specified for 32-bit Thumb
> instructions and also to be used for thumb kernel-side code.
> 
> 32-bit Thumb instructions are specified in the form:
> 	((first_half << 16 ) | second_half)
> which matches the layout used by the ARM ARM.
> 
> ptrace was handling 32-bit Thumb instructions by hooking the first
> halfword and manually checking the second half. This method would be
> broken by this patch so it is migrated to make use of the new Thumb-2
> support.
> 
> Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> ---
>  arch/arm/include/asm/ptrace.h |    8 ++++++++
>  arch/arm/kernel/ptrace.c      |   28 +++-------------------------
>  arch/arm/kernel/traps.c       |   17 ++++++++++++++++-
>  3 files changed, 27 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
> index 312d108..d484871 100644
> --- a/arch/arm/include/asm/ptrace.h
> +++ b/arch/arm/include/asm/ptrace.h
> @@ -200,6 +200,14 @@ extern unsigned long profile_pc(struct pt_regs *regs);
>  #define PREDICATE_ALWAYS	0xe0000000
>  
>  /*
> + * True if instr is a 32-bit thumb instruction. This works if instr
> + * is the first or only half-word of a thumb instruction. It also works
> + * when instr holds all 32-bits of a wide thumb instruction if stored
> + * in the form (first_half<<16)|(second_half)
> + */
> +#define is_wide_instruction(instr)	((unsigned)(instr) >= 0xe800)
> +
> +/*
>   * kprobe-based event tracer support
>   */
>  #include <linux/stddef.h>
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index 9726006..897ade0 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -228,34 +228,12 @@ static struct undef_hook thumb_break_hook = {
>  	.fn		= break_trap,
>  };
>  
> -static int thumb2_break_trap(struct pt_regs *regs, unsigned int instr)
> -{
> -	unsigned int instr2;
> -	void __user *pc;
> -
> -	/* Check the second half of the instruction.  */
> -	pc = (void __user *)(instruction_pointer(regs) + 2);
> -
> -	if (processor_mode(regs) == SVC_MODE) {
> -		instr2 = *(u16 *) pc;
> -	} else {
> -		get_user(instr2, (u16 __user *)pc);
> -	}
> -
> -	if (instr2 == 0xa000) {
> -		ptrace_break(current, regs);
> -		return 0;
> -	} else {
> -		return 1;
> -	}
> -}
> -
>  static struct undef_hook thumb2_break_hook = {
> -	.instr_mask	= 0xffff,
> -	.instr_val	= 0xf7f0,
> +	.instr_mask	= 0xffffffff,
> +	.instr_val	= 0xf7f0a000,
>  	.cpsr_mask	= PSR_T_BIT,
>  	.cpsr_val	= PSR_T_BIT,
> -	.fn		= thumb2_break_trap,
> +	.fn		= break_trap,
>  };
>  
>  static int __init ptrace_break_init(void)
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 6807cb1..2d3436e 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -355,9 +355,24 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
>  	pc = (void __user *)instruction_pointer(regs);
>  
>  	if (processor_mode(regs) == SVC_MODE) {
> -		instr = *(u32 *) pc;
> +#ifdef CONFIG_THUMB2_KERNEL
> +		if (thumb_mode(regs)) {
> +			instr = ((u16 *)pc)[0];
> +			if (is_wide_instruction(instr)) {
> +				instr <<= 16;
> +				instr |= ((u16 *)pc)[1];
> +			}
> +		} else
> +#endif
> +			instr = *(u32 *) pc;
>  	} else if (thumb_mode(regs)) {
>  		get_user(instr, (u16 __user *)pc);
> +		if (is_wide_instruction(instr)) {
> +			unsigned int instr2;
> +			get_user(instr2, (u16 __user *)pc+1);
> +			instr <<= 16;
> +			instr |= instr2;
> +		}
>  	} else {
>  		get_user(instr, (u32 __user *)pc);
>  	}
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
