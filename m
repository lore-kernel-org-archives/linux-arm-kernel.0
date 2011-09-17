From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 17 Sep 2011 20:32:59 +0800
Subject: [PATCH v2 6/6] arm/imx6q: add suspend/resume support
In-Reply-To: <20110917083007.GA26572@S2100-06.ap.freescale.net>
References: <1316097926-913-1-git-send-email-shawn.guo@linaro.org>
	<1316097926-913-7-git-send-email-shawn.guo@linaro.org>
	<20110915162829.GA4797@e102568-lin.cambridge.arm.com>
	<20110916060859.GG25928@S2100-06.ap.freescale.net>
	<20110916144539.GA18765@e102568-lin.cambridge.arm.com>
	<20110917083007.GA26572@S2100-06.ap.freescale.net>
Message-ID: <20110917123258.GC26572@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2011 at 04:30:09PM +0800, Shawn Guo wrote:
[...]
> > > +ENTRY(v7_cpu_resume)
> > > +	bl	v7_invalidate_l1
> > > +	bl	pl310_resume
> > > +	b	cpu_resume
> > > +ENDPROC(v7_cpu_resume)
> > > +
> > > +/*
> > > + * The following code is located into the .data section.  This is to
> > > + * allow pl310_pbase and pl310_aux_ctrl to be accessed with a relative
> > > + * load as we are running on physical address here.
> > > + */
> > > +	.data
> > > +	.align
> > > +ENTRY(pl310_resume)
> > > +	adr	r2, pl310_pbase
> > > +	ldmia	r2, {r0, r1}
> > > +	str	r1, [r0, #L2X0_AUX_CTRL]	@ restore aux_ctrl
> > > +	mov	r1, #0x1
> > > +	str	r1, [r0, #L2X0_CTRL]		@ re-enable L2
> > > +	mov	pc, lr
> > > +ENDPROC(pl310_resume)
> > > +
> > > +pl310_pbase:
> > > +	.long	0
> > > +pl310_aux_ctrl:
> > > +	.long	0
> > 
> > You might want to inline it and avoid the jump.
> > 
> One reason that I implemented pl310_resume as a function call is that
> I was trying to minimize the code that we have to put in .data section.
> Now I do not think it's a point that really matters.  So following your
> suggestion, here it is.  Please let me know it is not what you meant to
> see.
> 
> /*
>  * The following code is located into the .data section.  This is to
>  * allow pl310_pbase and pl310_aux_ctrl to be accessed with a relative
>  * load as we are running on physical address here.
>  */
>         .data
>         .align
> 
>         .macro  pl310_resume
>         adr     r2, pl310_pbase
>         ldmia   r2, {r0, r1}
>         str     r1, [r0, #L2X0_AUX_CTRL]        @ restore aux_ctrl
>         mov     r1, #0x1
>         str     r1, [r0, #L2X0_CTRL]            @ re-enable L2
>         .endm
> 
> ENTRY(v7_cpu_resume)
>         bl      v7_invalidate_l1
>         pl310_resume
>         b       cpu_resume
> ENDPROC(v7_cpu_resume)
> 
> .globl

Sorry.  This is a left-over of .globl playing, which should not be here.

> pl310_pbase:
>         .long   0
> pl310_aux_ctrl:
>         .long   0
> 

-- 
Regards,
Shawn
