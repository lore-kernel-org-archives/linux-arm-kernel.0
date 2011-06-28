From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 Jun 2011 17:11:27 +0100
Subject: Problem with GDB when debugging IRQ handlers
In-Reply-To: <BANLkTi=dzYV5tdHaZL91oHjMfuVtXUCD5A@mail.gmail.com>
References: <4E088DE1.2060809@gmail.com> <4E089AB3.1090801@codesourcery.com>
	<20110628103946.GC21898@n2100.arm.linux.org.uk>
	<BANLkTinvrJ5MAZABDmdmQk6UZHDKJQo1+A@mail.gmail.com>
	<20110628142045.GC7255@1n450.cable.virginmedia.net>
	<20110628143014.GD7255@1n450.cable.virginmedia.net>
	<BANLkTinL7-Kjx5fHrwHYHHhgjJ-6ex3=eA@mail.gmail.com>
	<BANLkTinoLB89VAWh-tSswq+H9EcmcQWnXQ@mail.gmail.com>
	<20110628150631.GD24904@e102109-lin.cambridge.arm.com>
	<BANLkTi=dzYV5tdHaZL91oHjMfuVtXUCD5A@mail.gmail.com>
Message-ID: <20110628161127.GG24904@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 04:45:52PM +0100, Dmitry Eremin-Solenikov wrote:
> Here is a part of gdb log generated using the attached patch:
[...]
> #11 0xc0033810 in kernel_thread_helper ()
> #12 0xc0033810 in kernel_thread_helper ()
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)

Maybe you can add something similar to the kernel_thread_helper in
arch/arm/kernel/process.c? I'm not sure whether there is something like
.cantunwind (as for the kernel unwinding information).

> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index e8d8856..44daf40 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -28,6 +28,7 @@
>  #include "entry-header.S"
>  #include <asm/entry-macro-multi.S>
>  
> +	.cfi_sections	.debug_frame
>  /*
>   * Interrupt handling.  Preserves r7, r8, r9
>   */
> @@ -113,6 +114,7 @@ ENDPROC(__und_invalid)
>  
>  	.macro	svc_entry, stack_hole=0
>   UNWIND(.fnstart		)
> +	.cfi_startproc
>   UNWIND(.save {r0 - pc}		)
>  	sub	sp, sp, #(S_FRAME_SIZE + \stack_hole - 4)
>  #ifdef CONFIG_THUMB2_KERNEL
> @@ -146,6 +148,24 @@ ENDPROC(__und_invalid)
>  	@  r4 - orig_r0 (see pt_regs definition in ptrace.h)
>  	@
>  	stmia	r5, {r0 - r4}
> +	.cfi_def_cfa_offset S_PC + 4
> +	.cfi_offset 14, -4
> +#define	CFI_REG_OFF(r) .cfi_offset r, (r - 16) * 4
> +	CFI_REG_OFF(13)
> +	CFI_REG_OFF(12)
> +	CFI_REG_OFF(11)
> +	CFI_REG_OFF(10)
> +	CFI_REG_OFF(9)
> +	CFI_REG_OFF(8)
> +	CFI_REG_OFF(7)
> +	CFI_REG_OFF(6)
> +	CFI_REG_OFF(5)
> +	CFI_REG_OFF(4)
> +	CFI_REG_OFF(3)
> +	CFI_REG_OFF(2)
> +	CFI_REG_OFF(1)
> +	CFI_REG_OFF(0)
> +#undef CFI_REG_OFF
>  	.endm

Do we need all the registers in here for gdb stack unwinding? In general
we would only need LR, SP and FP.

-- 
Catalin
