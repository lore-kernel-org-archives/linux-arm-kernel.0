From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Jul 2010 08:38:04 -0400 (EDT)
Subject: [RFC,
	PATCH 2/3] arm: use addruart macro to establish debug mappings
In-Reply-To: <1279100540.15089.62.camel@pororo.lan>
References: <1279073377.401935.180250562939.2.gpush@pororo>
	<alpine.LFD.2.00.1007132343410.10598@xanadu.home>
	<1279100540.15089.62.camel@pororo.lan>
Message-ID: <alpine.LFD.2.00.1007140828300.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Jul 2010, Jeremy Kerr wrote:

> Hi Nicolas,
> 
> > > -	ldr	r3, [r8, #MACHINFO_PGOFFIO]
> > > +	addruart r7, r3
> > > +	lsr	r3, r3, #20
> > > +	lsl	r3, r3, #2
> > 
> > Not all binutils versions support that syntax. You should rather use:
> > 
> > 	mov	r3, r3, lsr #20
> > 	mov	r3, r3, lsl #2
> 
> Ah, didn't know about that. Thanks.
> 
> Just for my own info - do you know which binutils don't support lsl/lsr?

About anything that was released 2 years ago and before, or something in 
that ballpark (sorry I don't have the exact version handy).

> > >  	add	r0, r4, r3
> > >  	rsb	r3, r3, #0x4000			@ PTRS_PER_PGD*sizeof(long)
> > >  	cmp	r3, #0x0800			@ limit to 512MB
> > >  	movhi	r3, #0x0800
> > >  	add	r6, r0, r3
> > > -	ldr	r3, [r8, #MACHINFO_PHYSIO]
> > > +	mov	r3, #0xff000000
> > > +	orr	r3, r3, #0x00c00000
> > > +	and	r3, r7, r3
> > > +	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
> > >  	orr	r3, r3, r7
> > 
> > You may replace those last 5 instructions with:
> > 
> > 	ldr	r3, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
> > 	mov	r7, r7, lsr #20
> > 	orr	r3, r3, r7, lsl #20	
> 
> No, we need io_mmuflags in r7 for later usage. But I've taken the
> general idea and done this instead:
> 
> 	[addruart returns phys addr in r7]
> 
> 	mov	r3, r7, lsr #20
> 	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
> 	orr	r3, r7, r3, lsl #20

Good.

FYI: here we don't care as much since this is debugging code, but in a 
hot path you'd try to put something in between the ldr into r7 and its 
usage as there is a load result delay (at least one cycle, sometimes 
more)that can be filled by any other instruction that is not using the 
loaded reg.

> Thanks for the review, I appreciate it.

My pleasure.  :-)


Nicolas
