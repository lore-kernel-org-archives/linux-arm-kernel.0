From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jul 2012 12:26:07 +0100
Subject: [PATCH] Fix undefined instruction exception handling
In-Reply-To: <20120729182236.GG6802@n2100.arm.linux.org.uk>
References: <20120729182236.GG6802@n2100.arm.linux.org.uk>
Message-ID: <20120730112607.GD15195@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sun, Jul 29, 2012 at 07:22:36PM +0100, Russell King - ARM Linux wrote:
> While trying to get a v3.5 kernel booted on the cubox, I noticed that
> VFP does not work correctly with VFP handling.  This is because of the
> confusion over 16-bit vs 32-bit instructions, and where PC is supposed
> to point to.
> 
> The rule is that FP handlers are entered with regs->ARM_pc pointing at
> the _next_ instruction to be executed.  However, if the exception is
> not handled, regs->ARM_pc points at the faulting instruction.

[...]

> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 0d1851c..ad595be 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -244,6 +244,19 @@ ENDPROC(__irq_svc)
>  	b	1b
>  #endif
>  
> +__und_fault:
> +	@ Correct the PC such that it is pointing at the instruction
> +	@ which caused the fault.  If the faulting instruction was ARM
> +	@ the PC will be pointing at the next instruction, and have to
> +	@ subtract 4.  Otherwise, it is Thumb, and the PC will be
> +	@ pointing at the second half of the Thumb instruction.  We
> +	@ have to substract 2.

s/substract/subtract/

>  __und_svc:
>  #ifdef CONFIG_KPROBES
> @@ -261,7 +274,7 @@ ENDPROC(__irq_svc)
>  	@
>  	@  r0 - instruction
>  	@
> -#ifndef	CONFIG_THUMB2_KERNEL
> +#ifndef CONFIG_THUMB2_KERNEL
>  	ldr	r0, [r4, #-4]
>  #else
>  	ldrh	r0, [r4, #-2]			@ Thumb instruction at LR - 2
> @@ -269,17 +282,24 @@ ENDPROC(__irq_svc)
>  	ldrhhs	r9, [r4]			@ bottom 16 bits
>  	orrhs	r0, r9, r0, lsl #16

Do we not need an addhs r4, r4, #2 here?

>  #endif
> -	adr	r9, BSYM(1f)
> +	adr	r9, BSYM(__und_svc_finish)
>  	mov	r2, r4
>  	bl	call_fpe

...otherwise the fp handler invoked by call_fpe will get confused and corrupt
the saved PC value. I suppose this might not matter at the moment, given that
we don't use FP in the kernel, but in that case a comment might be useful.

> +	ldr	r5, [sp, #S_PSR]
>  	mov	r0, sp				@ struct pt_regs *regs
> -	bl	do_undefinstr
> +	mov	r1, #4				@ PC correction to apply
> +#ifdef CONFIG_THUMB2_KERNEL
> +	tst	r5, #PSR_T_BIT
> +	movne	r1, #2
> +#endifi

If we fixup r4 above, I think we should set r1 depending on the instruction
size, like we do for userspace.

> diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
> index 4fa9903..4f9ca8d 100644
> --- a/arch/arm/vfp/entry.S
> +++ b/arch/arm/vfp/entry.S
> @@ -19,6 +19,15 @@
>  #include <asm/vfpmacros.h>
>  #include "../kernel/entry-header.S"
>  
> +@ VFP entry point.
> +@
> +@  r0  = instruction opcode (32-bit ARM or two 16-bit Thumb)
> +@  r2  = PC value to resume execution after successful emulation
> +@  r9  = normal "successful" return address
> +@  r10 = this threads thread_info structure
> +@  lr  = unrecognised instruction return address
> +@  IRQs disabled.
> +@

There's a similar comment a few lines above from this one which is now
contradictory -- can we just replace the old one with the new, correct one?

Will
