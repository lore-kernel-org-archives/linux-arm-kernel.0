From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 12 Sep 2011 17:22:35 +0100
Subject: [PATCH v2 2/3] ARM: iwmmxt: Port problematic iwmmxt support code
	to v7/Thumb-2
In-Reply-To: <alpine.LFD.2.00.1109121044410.20358@xanadu.home>
References: <201109081845.58260.arnd@arndb.de>
	<CAMPhdO82ho2WPrJ3irwLgfPOycQt=kyqK3hhtrLCjOw1vptTrg@mail.gmail.com>
	<20110908172002.GG2070@arm.com>
	<CAMPhdO9USGfrpgR0fXUL6024qWGLqsS72vzaO6AH1oo-TW1RtA@mail.gmail.com>
	<1315562102.7961.5.camel@linaro1>
	<alpine.LFD.2.00.1109090919170.20358@xanadu.home>
	<20110909164123.GB3069@arm.com>
	<alpine.LFD.2.00.1109091339540.20358@xanadu.home>
	<20110912143708.GB2020@arm.com>
	<alpine.LFD.2.00.1109121044410.20358@xanadu.home>
Message-ID: <20110912162235.GD2020@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 10:55:30AM -0400, Nicolas Pitre wrote:
> On Mon, 12 Sep 2011, Dave Martin wrote:
> 
> > On Fri, Sep 09, 2011 at 01:51:30PM -0400, Nicolas Pitre wrote:
> > > On Fri, 9 Sep 2011, Dave Martin wrote:
> > > 
> > > > On Fri, Sep 09, 2011 at 09:21:28AM -0400, Nicolas Pitre wrote:
> > > > > On Fri, 9 Sep 2011, Jon Medhurst (Tixy) wrote:
> > > > > 
> > > > > > On Thu, 2011-09-08 at 11:49 -0700, Eric Miao wrote:
> > > > > > > So the problem is really when compiling this file with existing toolchain,
> > > > > > > it's downgrading to v5 compatible mode, and the instruction below
> > > > > > > 
> > > > > > > sub pc, lr, r1, lsr #32
> > > > > > > 
> > > > > > > wouldn't be encoded when building a THUMB2 kernel. Considering the
> > > > > > > r1, lsr #32 is actually to create an explicit data dependency of the previous
> > > > > > > co-processor instruction, would it be one option to rewrite this as something
> > > > > > > like:
> > > > > > > 
> > > > > > > mov r1, r1
> > > > > > > mov pc, lr
> > > > > > 
> > > > > > That doesn't include a data dependency of PC on R1, so it's possible for
> > > > > > MOV PC, LR and subsequent instructions to be executed before MOV R1, R1
> > > > > > has completed. We would want...
> > > > > > 
> > > > > > add lr, lr, r1, lsr #32
> > > > > > mov pc, lr
> > > > > 
> > > > > But isn't the first insn unavailable with Thumb2?
> > > > > 
> > > > > Maybe something like:
> > > > > 
> > > > > 	sub	r1, r1, r1
> > > > > 	add	pc, lr, r1
> > > > 
> > > > Thumb-2 implies v7, the v7 implies that we have (and need) a real ISB.  So for the
> > > > Thumb-2 case, this should always become
> > > > 
> > > > 	isb
> > > 
> > > Don't forget that here we are talking about the Marvell implementation.  
> > > Since I've no doubt that the real isb certainly works, so far the 
> > > advertized isb has always been implemented with a CP readback with a 
> > > data dependency.  Don't forget that this CPU core can also pretend to be 
> > > an ARMv6 and they probably didn't duplicate the whole instruction 
> > > decoder for each modes.
> > 
> > If the isb instruction doesn't work for this in v7 mode, I think that
> > would be an architecture violation, but you're right that this may
> > not be available, or may not behave identically, when the CPU is
> > behaving like a v6 part.
> 
> I'm sure isb is available in ARMv7 mode.
> 
> What I'm saying is that the advertised trick for ARMv6 mode certainly 
> must work just as well here in ARMv7 mode.
> 
> > > So I really doubt the Marvell implementation would behave any 
> > > differently if this special isb is expressed in terms of Thumb2 rather 
> > > than ARM instructions as the backend is certainly common to all the 
> > > modes. If we can use the same implementation for all modes then we'll 
> > > just simplify maintenance of this code.
> > 
> > Agreed, but the trouble is that what constitutes a suitable data
> > dependency is completely microarchitecture dependent -- we're relying
> > on side-effects outside the architecture here.
> 
> Sure.  But what is there now is what is documented by Marvell docs i.e. 
> create a data dependency on the register used to read back the CP value.  
> I've seen a few implementation variations on that theme too.
> 
> > We can't code _exactly_ the same thing in Thumb-2 because of restrictions
> > in the instruction set, so we have to settle for something that "looks
> > similar" -- but there's no guarantee it will work.
> > 
> > Do you feel your judgement on this is authoritative?  If so, then
> > we can go ahead with your suggestion; otherwise we might need input
> > from someone else.
> 
> My suggestion would be what Tixy also proposed:
> 
> 	mrc	p15, 0, r1, c2, c0, 0
> 	add	lr, lr, r1, lsr #32
> 	mov	pc, lr
>
> Running this past people still at Marvell (I'm not anymore) wouldn't 
> hurt of course.

Sure, that might work, and if we have a sequence which works for all
build configurations, that's great.  But it needs to work for the right
reasons, otherwise we may be storing up nasty surprises for later.

As you/Russell suggest, I think Haojian or someone should comment.
