From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 Jun 2011 15:42:02 +0100
Subject: Problem with GDB when debugging IRQ handlers
In-Reply-To: <20110628143758.GF21898@n2100.arm.linux.org.uk>
References: <20110627125306.GA30646@doriath.ww600.siemens.net>
	<20110627132735.GE16103@n2100.arm.linux.org.uk>
	<4E088DE1.2060809@gmail.com> <4E089AB3.1090801@codesourcery.com>
	<20110628103946.GC21898@n2100.arm.linux.org.uk>
	<BANLkTinvrJ5MAZABDmdmQk6UZHDKJQo1+A@mail.gmail.com>
	<20110628142045.GC7255@1n450.cable.virginmedia.net>
	<20110628143014.GD7255@1n450.cable.virginmedia.net>
	<20110628143758.GF21898@n2100.arm.linux.org.uk>
Message-ID: <20110628144202.GC24904@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 03:37:59PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 28, 2011 at 03:30:14PM +0100, Catalin Marinas wrote:
> > Actually since the return address is in S_PC (which maybe gdb assumes it
> > would be the saved LR), this is probably not be correct. After SVC
> > entry, we have he following structure on the stack:
> > 
> > 	ORIG_r0
> > 	CPSR
> > 		<--- assuming this is the Call Frame Address (SP+S_PC+4)
> > 	PC	<--- CFA - 4
> > 	LR	<--- don't care
> > 	SP	<--- CFA - 12
> > 	...
> 
> If I'm reading this correctly, it's not correct.
> 
> parent SP -->	parent context stack
> 		[possible empty word]
> 		ORIG_r0
> 		parent context CPSR
> 		parent context PC
> 		parent context LR
> 		parent context SP
> 		...
> new SP -->	R0
> 
> That empty word may or may not be present if the parent SP is aligned to
> a 64-bit boundary.

But it shouldn't matter if we tell gdb that the previous SP (parent) is
stored in the current stack at CFA - 12. It calculates CFA by adding
S_PC+4 to the current SP, in which case the possible empty word doesn't
matter.

But please note that I don't have any gdb experience, so we need someone
else to confirm.

-- 
Catalin
