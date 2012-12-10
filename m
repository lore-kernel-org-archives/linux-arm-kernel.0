From: boojin.kim@samsung.com (Boojin Kim)
Date: Mon, 10 Dec 2012 10:19:03 +0900
Subject: [PATCH 1/3] ARM: MM: Add the workaround of Errata 774769
In-Reply-To: <20121210000825.GH14363@n2100.arm.linux.org.uk>
References: <001701cdd669$19e8cdd0$4dba6970$%kim@samsung.com>
 <20121210000825.GH14363@n2100.arm.linux.org.uk>
Message-ID: <002101cdd674$57884070$0698c150$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:

> > -3:	mov	r10, #0
> > +	/* Cortex-A15 Errata */
> > +3:	ldr	r10, =0x00000c0f		@ Cortex-A15 primary part number
> > +	teq	r0, r10
> > +	bne	4f
> > +#ifdef CONFIG_ARM_ERRATA_774769
>
> There's not much point testing for the part number of the work-around isn't
> enabled.
The errata 773022 on second patch series is also required to checking the part number.
In my opinion, the testing for Cortex-A15 primary part number is required
before working the work-around to support several A15 errata.

>
> > +	teq	r6, #0x4			@ present in r0p4
> > +	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register
>
> 	tsteq	r10, #1 << 15
>
> to avoid writing to the aux control register if the errata has already been
> applied.
Do you mean "tsteq	r10, #1 << 25" ?
If yes, it needs to branch and will make a little complicated
And, I think maybe this function could be the first step to configure this erratum.

Thanks for your review

>
> > +	orreq	r10, r10, #1 << 25		@ set bit #25
> > +	mcreq	p15, 0, r10, c1, c0, 1		@ write aux control register
> > +#endif
> > +
> > +4:	mov	r10, #0
> >  	mcr	p15, 0, r10, c7, c5, 0		@ I+BTB cache invalidate
> >  	dsb
> >  #ifdef CONFIG_MMU
> > --
> > 1.7.5.4
> >
> >
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
