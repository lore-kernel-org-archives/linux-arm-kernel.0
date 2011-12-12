From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Dec 2011 17:25:28 -0500 (EST)
Subject: arm and patch phys offset
In-Reply-To: <20111212215736.GE20178@n2100.arm.linux.org.uk>
References: <201112112255.32534.michael@walle.cc>
 <alpine.LFD.2.02.1112111935590.2907@xanadu.home>
 <201112122212.35506.michael@walle.cc>
 <alpine.LFD.2.02.1112121627030.2907@xanadu.home>
 <20111212215736.GE20178@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1112121722520.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Dec 2011, Russell King - ARM Linux wrote:

> On Mon, Dec 12, 2011 at 04:38:07PM -0500, Nicolas Pitre wrote:
> > You could try instrumenting the patching code, although it is a bit 
> > tricky because of the non-standard register life rules in that file.  
> > But something like this should tell you if the expected amount of fixups 
> > were applied:
> > 
> > diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> > index 08c82fd844..7f43d1fe01 100644
> > --- a/arch/arm/kernel/head.S
> > +++ b/arch/arm/kernel/head.S
> > @@ -530,14 +530,23 @@ __fixup_a_pv_table:
> >  	bcc	1b
> >  	bx	lr
> >  #else
> > +	mov	r0, #0
> >  	b	2f
> >  1:	ldr	ip, [r7, r3]
> >  	bic	ip, ip, #0x000000ff
> >  	orr	ip, ip, r6	@ mask in offset bits 31-24
> >  	str	ip, [r7, r3]
> > +	add	r0, r0, #1
> >  2:	cmp	r4, r5
> >  	ldrcc	r7, [r4], #4	@ use branch for delay slot
> >  	bcc	1b
> 
> If you look at this code, there is _no_ way it can fixup only some entries
> in the table and not others - unless the CPU starts executing something
> which isn't this code.

As you might imagine, I already know that.  But getting the number out 
helps people gain confidence in the code they might not trust otherwise.


Nicolas
