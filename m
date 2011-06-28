From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 Jun 2011 15:20:45 +0100
Subject: Problem with GDB when debugging IRQ handlers
In-Reply-To: <BANLkTinvrJ5MAZABDmdmQk6UZHDKJQo1+A@mail.gmail.com>
References: <20110627125306.GA30646@doriath.ww600.siemens.net>
	<20110627132735.GE16103@n2100.arm.linux.org.uk>
	<4E088DE1.2060809@gmail.com> <4E089AB3.1090801@codesourcery.com>
	<20110628103946.GC21898@n2100.arm.linux.org.uk>
	<BANLkTinvrJ5MAZABDmdmQk6UZHDKJQo1+A@mail.gmail.com>
Message-ID: <20110628142045.GC7255@1n450.cable.virginmedia.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 04:06:11PM +0400, Dmitry Eremin-Solenikov wrote:
> On 6/28/11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> I did some checks. It seems, the problem isn't related to unwinder. At least
> it looks like kernel has all necessary unwinding subops. It looks like the
> problem is really related to the lack of necessary .cfi information. At least
> when i added .cfi_startproc/.cfi_endproc annotations to entry-armv.S code,
> gdb stopped decoding backtrace with the "previous frame identical to this frame"
> error. Unfortunately I don't have enough knowledge to add .cfi annotations to
> irq handlers.

I think it may have stopped decoding because of some information it
reads from the stack doesn't look sane. But I wonder whether we could
get it looping again depending on the register values in the interrupted
context.

> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index e8d8856..d77f9d7 100644
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

Could you add some directives like below in the svc_entry macro (after
"sub sp...", not sure if it matters) and check whether gdb behaves
better:

	.cfi_def_cfa_offset S_PC
	.cfi_offset 14, -4

Thanks.

-- 
Catalin
