From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 28 Mar 2012 09:28:54 +0900
Subject: [PATCH 1/2] ARM: lib: Add optimized memcpy with 64 byte pld size
In-Reply-To: <alpine.LFD.2.02.1203262231220.24151@xanadu.home>
References: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
 <00cf01cd0bb0$4fa49c30$eeedd490$%kim@samsung.com>
 <alpine.LFD.2.02.1203262231220.24151@xanadu.home>
Message-ID: <013501cd0c79$c1e244e0$45a6cea0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas wrote:

> This creates quite convoluted code.  If this is worth doing, we'll have
> to find a cleaner way to do this.
>
> Could you please provide performance measurement numbers with and
> without this patch, and similarly for the next patch?
>
> Did you try enabling the cache alignment code?  What performance
> difference if any did you see?
My patch brings about 10% better result on cache boundary.
64bytes PLD size makes the cache efficiency be higher on machines that has 64byte cache line.
And, Which one is convoluted code? Can you explain it more detail?
Thank you for  your review.

>
> > ---
> >  arch/arm/Kconfig             |    7 ++++++
> >  arch/arm/lib/copy_template.S |   44 +++++++++++++++++++++++++++++++++--------
> >  2 files changed, 42 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 8fec56d..ba306b3 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1132,6 +1132,13 @@ config ARM_NR_BANKS
> >  	default 16 if ARCH_EP93XX
> >  	default 8
> >
> > +config ARM_PLD_SIZE
> > +	int
> > +	default 64 if ARCH_EXYNOS5
> > +	default 32
> > +	help
> > +	  Configure preload size used on memcpy(). Select 64 for cortex-a15.
> > +
> >  config IWMMXT
> >  	bool "Enable iWMMXt support"
> >  	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4
> > diff --git a/arch/arm/lib/copy_template.S b/arch/arm/lib/copy_template.S
> > index 805e3f8..7dc5b8c 100644
> > --- a/arch/arm/lib/copy_template.S
> > +++ b/arch/arm/lib/copy_template.S
> > @@ -66,6 +66,7 @@
> >   *	than one 32bit instruction in Thumb-2)
> >   */
> >
> > +#define PLDSIZE	(CONFIG_ARM_PLD_SIZE)
> >
> >  		enter	r4, lr
> >
> > @@ -90,19 +91,44 @@
> >  	CALGN(	add	pc, r4, ip		)
> >
> >  	PLD(	pld	[r1, #0]		)
> > -2:	PLD(	subs	r2, r2, #96		)
> > -	PLD(	pld	[r1, #28]		)
> > +
> > +#if (PLDSIZE == 64)
> > +2:	PLD(	cmp	r2, #32)
> > +	PLD(	blt	.32cpy)
> > +.64cpy:	PLD(	subs	r2, r2, #(PLDSIZE*3+32)	)
> > +	PLD(	pld	[r1, #PLDSIZE-4]	)
> >  	PLD(	blt	4f			)
> > -	PLD(	pld	[r1, #60]		)
> > -	PLD(	pld	[r1, #92]		)
> > +	PLD(	pld	[r1, #PLDSIZE*2-4]	)
> > +	PLD(	pld	[r1, #PLDSIZE*3-4]	)
> > +
> > +3:	PLD(	pld	[r1, #PLDSIZE*4-4]	)
> > +4:		ldr8w   r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> > +		str8w   r0, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> > +		ldr8w   r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> > +		str8w   r0, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> > +		subs	r2, r2, #PLDSIZE
> > +		bge	3b
> > +	PLD(	cmn	r2, #(PLDSIZE*3)	)
> > +	PLD(	bge	4b			)
> > +	PLD(	cmn	r2, #(PLDSIZE*4-32)	)
> > +	PLD(	blt	5f)
> > +.32cpy:		ldr8w   r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> > +		str8w   r0, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> > +#else
> > +2:	PLD(	subs	r2, r2, #(PLDSIZE*3)	)
> > +	PLD(	pld	[r1, #(PLDSIZE-4)]	)
> > +	PLD(	blt	4f			)
> > +	PLD(	pld	[r1, #(PLDSIZE*2-4)]	)
> > +	PLD(	pld	[r1, #(PLDSIZE*3-4)]	)
> >
> > -3:	PLD(	pld	[r1, #124]		)
> > -4:		ldr8w	r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> > -		subs	r2, r2, #32
> > -		str8w	r0, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> > +3:	PLD(	pld	[r1, #(PLDSIZE*4-4)]	)
> > +4:		ldr8w   r1, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> > +		subs	r2, r2, #PLDSIZE
> > +		str8w   r0, r3, r4, r5, r6, r7, r8, ip, lr, abort=20f
> >  		bge	3b
> > -	PLD(	cmn	r2, #96			)
> > +	PLD(	cmn	r2, #(PLDSIZE*3)	)
> >  	PLD(	bge	4b			)
> > +#endif
> >
> >  5:		ands	ip, r2, #28
> >  		rsb	ip, ip, #32
> > --
> > 1.7.1
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
