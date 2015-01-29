From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Thu, 29 Jan 2015 02:36:01 +0000
Subject: [PATCH 2/7] pm: at91: pm_suspend: add the WFI support for ARMv7
In-Reply-To: <20150128112551.GA13253@e102568-lin.cambridge.arm.com>
References: <1422266617-24381-1-git-send-email-wenyou.yang@atmel.com>
 <1422266761-24487-1-git-send-email-wenyou.yang@atmel.com>
 <20150128112551.GA13253@e102568-lin.cambridge.arm.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFD38E3C@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

Thank you for your review.

> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi at arm.com]
> Sent: Wednesday, January 28, 2015 7:26 PM
> To: Yang, Wenyou
> Cc: Ferre, Nicolas; linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; alexandre.belloni at free-electrons.com;
> sylvain.rochet at finsecur.com; peda at axentia.se; Vilchez, Patrice
> Subject: Re: [PATCH 2/7] pm: at91: pm_suspend: add the WFI support for ARMv7
> 
> On Mon, Jan 26, 2015 at 10:06:01AM +0000, Wenyou Yang wrote:
> 
> Commit log please.
Added in the v2.0

> 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >  arch/arm/mach-at91/pm_suspend.S |   54
> ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 53 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-at91/pm_suspend.S
> > b/arch/arm/mach-at91/pm_suspend.S index 122a3f1..e796722 100644
> > --- a/arch/arm/mach-at91/pm_suspend.S
> > +++ b/arch/arm/mach-at91/pm_suspend.S
> > @@ -53,6 +53,58 @@ mode	.req	r6
> >  	beq	1b
> >  	.endm
> >
> > +/*
> > + * Put the processor to enter the WFI state  */
> > +	.macro _do_wfi
> 
> You will have to explain why you need this, really.
I don't understand your meaning.

> 
> > +
> > +#if defined(CONFIG_CPU_V7)
> > +	/*
> > +	 * Execute an ISB instruction to flush the pipeline to ensure
> > +	 * that all of operations have beem completed.
> 
> s/beem/been
Thanks.

> 
> > +	 */
> > +	isb
> > +
> > +	/*
> > +	 * Execute an ISB instruction to ensure that all of the
> > +	 * CP15 register changes have been committed.
> > +	 */
> > +	dsb
> 
> This is a dsb not an isb.
Changed in the v2.0

> 
> > +	dmb
> 
> You have to explain why you need every single one of these barriers, otherwise I
> am NAKing this patch.
No need this one?

> 
> > +
> > +	/* Disable the processor's clock */
> > +	mov	tmp1, #AT91_PMC_PCK
> > +	str	tmp1, [pmc, #AT91_PMC_SCDR]
> > +
> > +	/* Execute a WFI instruction */
> > +	wfi	@ Wait For Interrupt
> 
> This one looks ok :)
> 
> > +
> > +	/*
> > +	 * CPU can specualatively prefetch the instructions
> > +	 * so add NOPs after WFI. Sixteen NOPs as Cortex-A5 pipeline.
> 
> So what ? I suspect your issue is related to wfi completion on pending IRQ. I
> would like to know the details that describe the issue you are trying to solve here
> please.
Honestly, I referred to others, I will dig more, and test it.

> 
> > +	 */
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +	nop
> > +#else
> > +	mcr	p15, 0, tmp1, c7, c0, 4
> > +#endif
> 
> Tell us what's the problem you have to solve, first, then we will see how to fix it.
> 
> Thanks,
> Lorenzo
> 
> > +
> > +	.endm
> > +
> >  	.text
> >
> >  /*
> > @@ -181,7 +233,7 @@ sdr_sr_done:
> >
> >  skip_disable_main_clock:
> >  	/* Wait for interrupt */
> > -	mcr	p15, 0, tmp1, c7, c0, 4
> > +	_do_wfi
> >
> >  	tst	mode, #AT91_PM_SLOW_CLOCK
> >  	beq	skip_enable_main_clock
> > --
> > 1.7.9.5
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >

Best Regards,
Wenyou Yang
