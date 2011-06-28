From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 Jun 2011 16:06:32 +0100
Subject: Problem with GDB when debugging IRQ handlers
In-Reply-To: <BANLkTinoLB89VAWh-tSswq+H9EcmcQWnXQ@mail.gmail.com>
References: <20110627125306.GA30646@doriath.ww600.siemens.net>
	<20110627132735.GE16103@n2100.arm.linux.org.uk>
	<4E088DE1.2060809@gmail.com> <4E089AB3.1090801@codesourcery.com>
	<20110628103946.GC21898@n2100.arm.linux.org.uk>
	<BANLkTinvrJ5MAZABDmdmQk6UZHDKJQo1+A@mail.gmail.com>
	<20110628142045.GC7255@1n450.cable.virginmedia.net>
	<20110628143014.GD7255@1n450.cable.virginmedia.net>
	<BANLkTinL7-Kjx5fHrwHYHHhgjJ-6ex3=eA@mail.gmail.com>
	<BANLkTinoLB89VAWh-tSswq+H9EcmcQWnXQ@mail.gmail.com>
Message-ID: <20110628150631.GD24904@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 03:54:11PM +0100, Dmitry Eremin-Solenikov wrote:
> On 6/28/11, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
> > On 6/28/11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> Actually since the return address is in S_PC (which maybe gdb assumes it
> >> would be the saved LR), this is probably not be correct. After SVC
> >> entry, we have he following structure on the stack:
> >>
> >> 	ORIG_r0
> >> 	CPSR
> >> 		<--- assuming this is the Call Frame Address (SP+S_PC+4)
> >> 	PC	<--- CFA - 4
> >> 	LR	<--- don't care
> >> 	SP	<--- CFA - 12
> >> 	...
> >>
> >>
> >> So we tell gdb about this with something like below (untested):
> >>
> >> 	.cfi_def_cfa_offset S_PC + 4
> >> 	.cfi_offset 14, -4
> >> 	.cfi_offset 13, -12
> >
> > This brings "unknown CFA rule" gdb exception, but it seems I got your idea.
> 
> No, this seems to work, it was my fault. I got more or less reasonable
> backtrace now.

Does gdb manage to get into the parent stack frame?

BTW, are you compiling with FRAME_POINTER enabled? In this case you
would need to set some offset for the FP register (11). If you don't
mind missing the first part in the parent context, maybe something like
below:

	.cfi_def_cfa_offset S_PC
	.cfi_offset 14, -4
	.cfi_offset 13, -8
	.cfi_offset 11, -16

-- 
Catalin
