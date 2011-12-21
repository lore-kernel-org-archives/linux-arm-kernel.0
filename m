From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 21 Dec 2011 23:23:47 +0800
Subject: [PATCH] ARM: imx6q: build pm code only when CONFIG_PM selected
In-Reply-To: <20209.62098.146087.510816@ipc1.ka-ro>
References: <1324478303-3899-1-git-send-email-eric.miao@linaro.org>
 <20209.62098.146087.510816@ipc1.ka-ro>
Message-ID: <20111221152345.GA6470@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 03:52:02PM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Eric Miao writes:
> [...]
> > diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
> > index 6229efb..a59cae7 100644
> > --- a/arch/arm/mach-imx/head-v7.S
> > +++ b/arch/arm/mach-imx/head-v7.S
> > @@ -71,6 +71,7 @@ ENTRY(v7_secondary_startup)
> >  ENDPROC(v7_secondary_startup)
> >  #endif
> >  
> > +#ifdef CONFIG_PM
> >  /*
> >   * The following code is located into the .data section.  This is to
> >   * allow phys_l2x0_saved_regs to be accessed with a relative load
> > @@ -97,3 +98,4 @@ ENDPROC(v7_cpu_resume)
> >  	.globl	phys_l2x0_saved_regs
> >  phys_l2x0_saved_regs:
> >          .long   0
> > +#endif
> >
> While you are changing mach-imx/head-v7.S you could also fix a build
> error with 'CONFIG_CACHE_L2x0' disabled.
> I just found this, but sending a patch now would conflict with your
> patch:

I think it should be a separate patch.  The conflict should be trivial
to be solved on my tree or arm-soc tree.

> 
> diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
> index 6229efb..830b5c8 100644
> --- a/arch/arm/mach-imx/head-v7.S
> +++ b/arch/arm/mach-imx/head-v7.S
> @@ -80,12 +80,14 @@ ENDPROC(v7_secondary_startup)
>  	.align
>  
>  	.macro	pl310_resume
> +#ifdef CONFIG_CACHE_L2X0
>  	ldr	r2, phys_l2x0_saved_regs
>  	ldr	r0, [r2, #L2X0_R_PHY_BASE]	@ get physical base of l2x0
>  	ldr	r1, [r2, #L2X0_R_AUX_CTRL]	@ get aux_ctrl value
>  	str	r1, [r0, #L2X0_AUX_CTRL]	@ restore aux_ctrl
>  	mov	r1, #0x1
>  	str	r1, [r0, #L2X0_CTRL]		@ re-enable L2
> +#endif
>  	.endm
>  
>  ENTRY(v7_cpu_resume)
> @@ -94,6 +96,8 @@ ENTRY(v7_cpu_resume)
>  	b	cpu_resume
>  ENDPROC(v7_cpu_resume)
>  
> +#ifdef CONFIG_CACHE_L2X0
>  	.globl	phys_l2x0_saved_regs
>  phys_l2x0_saved_regs:
>          .long   0
> +#endif

But I'm thinking about if we can solve this at L2X0 level instead of
introducing ifdef all over every platform code.

-- 
Regards,
Shawn
