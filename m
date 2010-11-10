From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 10 Nov 2010 16:43:31 -0500 (EST)
Subject: [RFC PATCH v3] ARM: Introduce patching of phys_to_virt and vice
	versa
In-Reply-To: <20101110203744.GE27571@n2100.arm.linux.org.uk>
References: <AANLkTikhcHTRYQki3cCYbWFY_POWX4E26Jau8nYpuDs0@mail.gmail.com>
	<20101108114948.GC14138@n2100.arm.linux.org.uk>
	<20101110164508.GB27571@n2100.arm.linux.org.uk>
	<20101110175549.GD27571@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1011101327520.13911@xanadu.home>
	<20101110203744.GE27571@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1011101632220.13911@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Nov 2010, Russell King - ARM Linux wrote:

> On Wed, Nov 10, 2010 at 03:23:50PM -0500, Nicolas Pitre wrote:
> > > 	add	rd, rn, #PHYS_OFFSET - PAGE_OFFSET
> > > 
> > > and phys_to_virt() is:
> > > 
> > > 	sub	rd, rn, #PHYS_OFFSET - PAGE_OFFSET
> > 
> > Does this work even if PHYS_OFFSET - PAGE_OFFSET goes negative? 
> 
> Yes.
> 
> 	add	rd, rn, #0xc0000000
> 	sub	rd, rn, #0x40000000
> 
> are identical operations.  The operand is an 8 bit constant, zero padded,
> rotated right by (in this case) 8 bits - there can be no sign extension.

OK.

> > On Wed, 10 Nov 2010, Russell King - ARM Linux wrote:
> > > Here's something which uses the above ideas (untested).  I think this is
> > > something we can (and should) do unconditionally for the !XIP cases.
> > 
> > What do you mean by "unconditionally"?
> 
> For any machine where the v:p offset is respresentable.  It means that
> we increase the amount of testing, and actually this becomes the
> standard way.

Well, sure.  This can become the default, but I wouldn't remove the 
ability to optimize everything at compile time for those who prefer the 
tightest kernel possible.

> > > +2:	cmp	r4, r5
> > > +	ldrlo	r7, [r4], #4
> > > +	ldrlo	ip, [r7, r3]
> > > +	bic	ip, ip, #0x000000ff
> > > +	bic	ip, ip, #0x00000f00
> > > +	orr	ip, ip, r6
> > 
> > The above 3 insns could be replaced with:
> > 
> > 	mov	ip, ip, lsr #12
> > 	orr	ip, r6, ip, lsl #12
> 
> They could be, but it's not worth optimizing to that extent - we're
> already hitting load delays for both of those ldr instructions that
> this isn't going to be blindingly fast... at least there aren't
> thousands of them to fixup.

Sure.  This is not critical, but even worse is the fact that this is all 
running with all caches off.  So having one less insn in the loop may 
help, even if only to serve as a good ARM coding example (will be more 
significant with thumb2).


Nicolas
