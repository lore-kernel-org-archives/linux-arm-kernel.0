From: msalter@redhat.com (Mark Salter)
Date: Wed, 29 Jan 2014 15:58:44 -0500
Subject: [PATCH v4 2/5] arm: add new asm macro update_sctlr
In-Reply-To: <20140129182805.GF11329@bivouac.eciton.net>
References: <1389445524-30623-1-git-send-email-leif.lindholm@linaro.org>
 <1389445524-30623-3-git-send-email-leif.lindholm@linaro.org>
 <20140122112055.GF1621@mudshark.cambridge.arm.com>
 <20140129182805.GF11329@bivouac.eciton.net>
Message-ID: <1391029124.2488.50.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-01-29 at 18:28 +0000, Leif Lindholm wrote:
> On Wed, Jan 22, 2014 at 11:20:55AM +0000, Will Deacon wrote:
> > > +#ifdef CONFIG_CPU_CP15
> > > +/* Macro for setting/clearing bits in sctlr */
> > > +   .macro update_sctlr, set:req, clear:req, tmp:req, tmp2:req
> > > +   mrc     p15, 0, \tmp, c1, c0, 0
> > > +   ldr     \tmp2, =\set
> > > +   orr     \tmp, \tmp, \tmp2
> > > +   ldr     \tmp2, =\clear
> > > +   mvn     \tmp2, \tmp2
> > > +   and     \tmp, \tmp, \tmp2
> > > +   mcr     p15, 0, \tmp, c1, c0, 0
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

Register parameters are just strings, so how about this:

	.macro foo bar=, baz=
	.ifnc \bar,
	mov \bar,#0
	.endif
	.ifnc \baz,
	mov \baz,#1
	.endif
	.endm

	foo x0
	foo
	foo x1, x2
	foo ,x3

Results in:

0000000000000000 <.text>:
   0:	d2800000 	mov	x0, #0x0                   	// #0
   4:	d2800001 	mov	x1, #0x0                   	// #0
   8:	d2800022 	mov	x2, #0x1                   	// #1
   c:	d2800023 	mov	x3, #0x1                   	// #1
