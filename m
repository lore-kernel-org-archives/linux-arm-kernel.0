From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 Jan 2014 19:27:18 +0000
Subject: [PATCH v4 2/5] arm: add new asm macro update_sctlr
In-Reply-To: <20140129182805.GF11329@bivouac.eciton.net>
References: <1389445524-30623-1-git-send-email-leif.lindholm@linaro.org>
 <1389445524-30623-3-git-send-email-leif.lindholm@linaro.org>
 <20140122112055.GF1621@mudshark.cambridge.arm.com>
 <20140129182805.GF11329@bivouac.eciton.net>
Message-ID: <20140129192718.GT26622@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leif,

On Wed, Jan 29, 2014 at 06:28:05PM +0000, Leif Lindholm wrote:
> On Wed, Jan 22, 2014 at 11:20:55AM +0000, Will Deacon wrote:
> > > +#ifdef CONFIG_CPU_CP15
> > > +/* Macro for setting/clearing bits in sctlr */
> > > +	.macro update_sctlr, set:req, clear:req, tmp:req, tmp2:req
> > > +	mrc	p15, 0, \tmp, c1, c0, 0
> > > +	ldr	\tmp2, =\set
> > > +	orr	\tmp, \tmp, \tmp2
> > > +	ldr	\tmp2, =\clear
> > > +	mvn	\tmp2, \tmp2
> > > +	and	\tmp, \tmp, \tmp2
> > > +	mcr	p15, 0, \tmp, c1, c0, 0
> > 
> > I think this would be cleaner if you force the caller to put set and clear
> > into registers beforehand, rather than have to do the literal load every
> > time. Also, I don't think set and clear should be required (and then you can
> > lose tmp2 as well).
> 
> I can't figure out how to make register-parameters non-required
> (i.e. conditionalise on whether an optional parameter was provided),
> so my attempt of refactoring actually ends up using an additional
> register:
> 
> #ifdef CONFIG_CPU_CP15
> /* Macro for setting/clearing bits in sctlr */
> 	.macro	update_sctlr, set:req, clear:req, tmp:req
> 	mrc	p15, 0, \tmp, c1, c0, 0
> 	orr	\tmp, \set
> 	mvn	\clear, \clear
> 	and	\tmp, \tmp, \clear
> 	mcr	p15, 0, \tmp, c1, c0, 0
> 	.endm
> #endif
> 
> If you think that's an improvement I can do that, and I have (just)
> enough registers to spare.
> If I'm being daft with my macro issues, do point it out.

I was thinking along the lines of:

	.macro  update_sctlr, tmp:req, set=0, clear=0
	.if	\set
	orr ...
	.endif
	.if	\clear
	bic ...
	.endif
	.endm

however, that puts us back to the problem of having to pass immediates
instead of registers. Gas *does* seem to accept the following:

	.macro  update_sctlr, tmp:req, set=0, clear=0
	.if	\set != 0
	orr ...
	.endif
	.if	\clear != 0
	bic ...
	.endif
	.endm

which is filthy, so we'd need to see how beautiful the caller ends up being
to justify that!

Will
