From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 Jun 2011 10:09:41 +0100
Subject: Problem with GDB when debugging IRQ handlers
In-Reply-To: <BANLkTinLG1LSB0iBrGZC6KYcTxF_NDgdqA@mail.gmail.com>
References: <20110628103946.GC21898@n2100.arm.linux.org.uk>
	<BANLkTinvrJ5MAZABDmdmQk6UZHDKJQo1+A@mail.gmail.com>
	<20110628142045.GC7255@1n450.cable.virginmedia.net>
	<20110628143014.GD7255@1n450.cable.virginmedia.net>
	<BANLkTinL7-Kjx5fHrwHYHHhgjJ-6ex3=eA@mail.gmail.com>
	<BANLkTinoLB89VAWh-tSswq+H9EcmcQWnXQ@mail.gmail.com>
	<20110628150631.GD24904@e102109-lin.cambridge.arm.com>
	<BANLkTi=dzYV5tdHaZL91oHjMfuVtXUCD5A@mail.gmail.com>
	<20110628161127.GG24904@e102109-lin.cambridge.arm.com>
	<BANLkTinLG1LSB0iBrGZC6KYcTxF_NDgdqA@mail.gmail.com>
Message-ID: <20110629090941.GD10623@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 11:26:28PM +0100, Dmitry Eremin-Solenikov wrote:
> On 6/28/11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Jun 28, 2011 at 04:45:52PM +0100, Dmitry Eremin-Solenikov wrote:
> >>  	.macro	svc_entry, stack_hole=0
> >>   UNWIND(.fnstart		)
> >> +	.cfi_startproc
> >>   UNWIND(.save {r0 - pc}		)
> >>  	sub	sp, sp, #(S_FRAME_SIZE + \stack_hole - 4)
> >>  #ifdef CONFIG_THUMB2_KERNEL
> >> @@ -146,6 +148,24 @@ ENDPROC(__und_invalid)
> >>  	@  r4 - orig_r0 (see pt_regs definition in ptrace.h)
> >>  	@
> >>  	stmia	r5, {r0 - r4}
> >> +	.cfi_def_cfa_offset S_PC + 4
> >> +	.cfi_offset 14, -4
> >> +#define	CFI_REG_OFF(r) .cfi_offset r, (r - 16) * 4
> >> +	CFI_REG_OFF(13)
> >> +	CFI_REG_OFF(12)
> >> +	CFI_REG_OFF(11)
> >> +	CFI_REG_OFF(10)
> >> +	CFI_REG_OFF(9)
> >> +	CFI_REG_OFF(8)
> >> +	CFI_REG_OFF(7)
> >> +	CFI_REG_OFF(6)
> >> +	CFI_REG_OFF(5)
> >> +	CFI_REG_OFF(4)
> >> +	CFI_REG_OFF(3)
> >> +	CFI_REG_OFF(2)
> >> +	CFI_REG_OFF(1)
> >> +	CFI_REG_OFF(0)
> >> +#undef CFI_REG_OFF
> >>  	.endm
> >
> > Do we need all the registers in here for gdb stack unwinding? In general
> > we would only need LR, SP and FP.
> 
> CFI info isn't only related to stack unwinding. IIUC (I'll have to run
> more experiments) these instrutions will help me to get correct
> variables/arguments values in the before-exception stack frames.

OK, in this case we may need to add some annotations. You could actually
generate a .s file from and existing C one (including -g) and see what
.cfi directives it generates.

-- 
Catalin
