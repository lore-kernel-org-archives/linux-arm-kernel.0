From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 27 Jan 2015 04:44:02 +0000
Subject: [PATCH 2/7] pm: at91: pm_suspend: add the WFI support for ARMv7
In-Reply-To: <54C63B8A.9000702@cogentembedded.com>
References: <1422266617-24381-1-git-send-email-wenyou.yang@atmel.com>
 <1422266761-24487-1-git-send-email-wenyou.yang@atmel.com>
 <54C63B8A.9000702@cogentembedded.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFD35CC6@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Thank you for your review.

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sergei.shtylyov at cogentembedded.com]
> Sent: Monday, January 26, 2015 9:05 PM
> To: Yang, Wenyou; Ferre, Nicolas; linux at arm.linux.org.uk
> Cc: sylvain.rochet at finsecur.com; Vilchez, Patrice; linux-kernel at vger.kernel.org;
> alexandre.belloni at free-electrons.com; peda at axentia.se; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 2/7] pm: at91: pm_suspend: add the WFI support for ARMv7
> 
> Hello.
> 
> On 1/26/2015 1:06 PM, Wenyou Yang wrote:
> 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >   arch/arm/mach-at91/pm_suspend.S |   54
> ++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 53 insertions(+), 1 deletion(-)
> 
> > diff --git a/arch/arm/mach-at91/pm_suspend.S
> > b/arch/arm/mach-at91/pm_suspend.S index 122a3f1..e796722 100644
> > --- a/arch/arm/mach-at91/pm_suspend.S
> > +++ b/arch/arm/mach-at91/pm_suspend.S
> > @@ -53,6 +53,58 @@ mode	.req	r6
> >   	beq	1b
> >   	.endm
> >
> > +/*
> > + * Put the processor to enter the WFI state  */
> > +	.macro _do_wfi
> > +
> > +#if defined(CONFIG_CPU_V7)
> > +	/*
> > +	 * Execute an ISB instruction to flush the pipeline to ensure
> > +	 * that all of operations have beem completed.
> 
>     Been.
> 
> > +	 */
> > +	isb
> > +
> > +	/*
> > +	 * Execute an ISB instruction to ensure that all of the
> 
>     ISB again, while you're executing DSB/DMB?
>
Thank you for your pointing.
 
> > +	 * CP15 register changes have been committed.
> > +	 */
> > +	dsb
> > +	dmb
> > +
> > +	/* Disable the processor's clock */
> > +	mov	tmp1, #AT91_PMC_PCK
> 
>     What's 'tmp1'? Is that a register name?
Yes, a register name defined at the head of file.

> 
> > +	str	tmp1, [pmc, #AT91_PMC_SCDR]
> > +
> > +	/* Execute a WFI instruction */
> 
>     Self-obvious comment, I'd say...
> 
> > +	wfi	@ Wait For Interrupt
> > +
> > +	/*
> > +	 * CPU can specualatively prefetch the instructions
> 
>     Speculatively.
Thanks.
> 
> [...]
> 
> WBR, Sergei


Best Regards,
Wenyou Yang
