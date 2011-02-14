From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 14 Feb 2011 15:10:18 -0500 (EST)
Subject: [PATCH v4 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
In-Reply-To: <20110214153726.GA20144@arm.com>
References: <1297263683-10621-1-git-send-email-dave.martin@linaro.org>
	<87pqqy6tdj.fsf@ti.com> <20110214131750.GA2869@arm.com>
	<alpine.LFD.2.00.1102140950580.14920@xanadu.home>
	<20110214153726.GA20144@arm.com>
Message-ID: <alpine.LFD.2.00.1102141110500.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Feb 2011, Dave Martin wrote:

> On Mon, Feb 14, 2011 at 10:00:23AM -0500, Nicolas Pitre wrote:
> > > +#ifdef CONFIG_THUMB2_KERNEL
> > > +	.align
> > > +	bx	pc
> > > +	nop
> > > +	.arm
> > 
> > Also here, the .align has the potential to introduce a zero halfword in 
> > the instruction stream before the bx.  What about:
> > 
> > 	adr	r3, 1f
> > 	bx	r3
> > 	.align
> > 	.arm
> > 1:	...
> 
> .align inserts a 16-bit nop when misaligned in Thumb in a text section,

Ah, OK then.  I didn't know about that. In ARM mode the all-zero bits 
decode to an instruction that sort of does nothing, but this isn't an 
eleguant nop, and that's what .align (used to?) insert as padding.

> and a word-aligned bx pc is a specific architecturally allowed way
> to do an inline switch to ARM.  The linker uses this trick for PLT
> veneers etc.

Yep.  It's just that with my suggestion the bx wasn't necessarily 
aligned.

> A nicer fix for doing this sort of call from low-level code which
> might be ARM is to convert arch/arm/mm/*-v7.S to use "bx lr" to return.
> 
> Generally, we can do this for all arches >= v5, without any
> incompatibility.  However, since the need for it will be rare and it
> will generate patch noise for not much real benefit,
> I haven't proposed this.

This can be done in those places where this might be needed without 
having to convert them all.


Nicolas
