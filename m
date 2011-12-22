From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 22 Dec 2011 11:30:52 +0800
Subject: [PATCH] ARM: imx6q: build pm code only when CONFIG_PM selected
In-Reply-To: <CAMPhdO-EG7Sy7ekHnXMh8qBKchuM92zmeXExc59E65g-_2RY=g@mail.gmail.com>
References: <1324478303-3899-1-git-send-email-eric.miao@linaro.org>
 <20209.62098.146087.510816@ipc1.ka-ro>
 <20111221152345.GA6470@S2100-06.ap.freescale.net>
 <20111221153327.GB6470@S2100-06.ap.freescale.net>
 <CAMPhdO-EG7Sy7ekHnXMh8qBKchuM92zmeXExc59E65g-_2RY=g@mail.gmail.com>
Message-ID: <20111222033051.GE6470@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 10:50:58AM +0800, Eric Miao wrote:
> On Wed, Dec 21, 2011 at 11:33 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > On Wed, Dec 21, 2011 at 11:23:47PM +0800, Shawn Guo wrote:
> >> > diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
> >> > index 6229efb..830b5c8 100644
> >> > --- a/arch/arm/mach-imx/head-v7.S
> >> > +++ b/arch/arm/mach-imx/head-v7.S
> >> > @@ -80,12 +80,14 @@ ENDPROC(v7_secondary_startup)
> >> > ? ? .align
> >> >
> >> > ? ? .macro ?pl310_resume
> >> > +#ifdef CONFIG_CACHE_L2X0
> >> > ? ? ldr ? ? r2, phys_l2x0_saved_regs
> >> > ? ? ldr ? ? r0, [r2, #L2X0_R_PHY_BASE] ? ? ?@ get physical base of l2x0
> >> > ? ? ldr ? ? r1, [r2, #L2X0_R_AUX_CTRL] ? ? ?@ get aux_ctrl value
> >> > ? ? str ? ? r1, [r0, #L2X0_AUX_CTRL] ? ? ? ?@ restore aux_ctrl
> >> > ? ? mov ? ? r1, #0x1
> >> > ? ? str ? ? r1, [r0, #L2X0_CTRL] ? ? ? ? ? ?@ re-enable L2
> >> > +#endif
> >> > ? ? .endm
> >> >
> >> > ?ENTRY(v7_cpu_resume)
> >> > @@ -94,6 +96,8 @@ ENTRY(v7_cpu_resume)
> >> > ? ? b ? ? ? cpu_resume
> >> > ?ENDPROC(v7_cpu_resume)
> >> >
> >> > +#ifdef CONFIG_CACHE_L2X0
> >> > ? ? .globl ?phys_l2x0_saved_regs
> >> > ?phys_l2x0_saved_regs:
> >> > ? ? ? ? ?.long ? 0
> >> > +#endif
> >>
> >> But I'm thinking about if we can solve this at L2X0 level instead of
> >> introducing ifdef all over every platform code.
> >>
> > Never mind. ?Even if we have L2X0_R_PHY_BASE L2X0_R_AUX_CTRL defined
> > for non-L2X0 build, we still need ifdef for pl310_resume calling.
> >
> > But can we save one ifdef by leaving phys_l2x0_saved_regs there?
> 
> Or we can have something like this:
> 

Looks good to me.  Care to create a patch for this?  I will try to
queue both of them.

-- 
Regards,
Shawn

> 
> diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
> index a59cae7..cec23a8 100644
> --- a/arch/arm/mach-imx/head-v7.S
> +++ b/arch/arm/mach-imx/head-v7.S
> @@ -80,6 +80,7 @@ ENDPROC(v7_secondary_startup)
>         .data
>         .align
> 
> +#ifdef CONFIG_CACHE_L2X0
>         .macro  pl310_resume
>         ldr     r2, phys_l2x0_saved_regs
>         ldr     r0, [r2, #L2X0_R_PHY_BASE]      @ get physical base of l2x0
> @@ -89,13 +90,17 @@ ENDPROC(v7_secondary_startup)
>         str     r1, [r0, #L2X0_CTRL]            @ re-enable L2
>         .endm
> 
> +       .globl  phys_l2x0_saved_regs
> +phys_l2x0_saved_regs:
> +        .long   0
> +#else
> +       .macro  pl310_resume
> +       .endm
> +#endif
> +
>  ENTRY(v7_cpu_resume)
>         bl      v7_invalidate_l1
>         pl310_resume
>         b       cpu_resume
>  ENDPROC(v7_cpu_resume)
> -
> -       .globl  phys_l2x0_saved_regs
> -phys_l2x0_saved_regs:
> -        .long   0
>  #endif
> 
