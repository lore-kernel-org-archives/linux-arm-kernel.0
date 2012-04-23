From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 Apr 2012 09:48:56 +0200
Subject: [PATCH 1/3] ARM: imx: Add common imx cpuidle init functionality.
In-Reply-To: <20120423071013.GS26306@S2101-09.ap.freescale.net>
References: <CAMXH7KFYA24sPUcwgKfwVLNPA0jWQ-QG02y+SfPNnAqdiv0+gg@mail.gmail.com>
 <CAMXH7KGgSmvfqUTC1bufBz0QXbt01dHsPo1cbRA9jLj9mGmfjg@mail.gmail.com>
 <20120419064308.GH3852@pengutronix.de>
 <20120420020816.GH22219@S2101-09.ap.freescale.net>
 <CAMXH7KE2RtdNy3G61guZb2uWy3rn267Z3eEVEgN5e==tHHsiuA@mail.gmail.com>
 <20120423051813.GM26306@S2101-09.ap.freescale.net>
 <20120423062739.GX3852@pengutronix.de>
 <20120423065259.GR26306@S2101-09.ap.freescale.net>
 <20120423065623.GA3852@pengutronix.de>
 <20120423071013.GS26306@S2101-09.ap.freescale.net>
Message-ID: <20120423074856.GU20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 03:10:15PM +0800, Shawn Guo wrote:
> On Mon, Apr 23, 2012 at 08:56:23AM +0200, Sascha Hauer wrote:
> > On Mon, Apr 23, 2012 at 02:53:01PM +0800, Shawn Guo wrote:
> > > On Mon, Apr 23, 2012 at 08:27:39AM +0200, Sascha Hauer wrote:
> > > > On Mon, Apr 23, 2012 at 01:18:21PM +0800, Shawn Guo wrote:
> > > > > On Sun, Apr 22, 2012 at 11:44:39PM -0500, Rob Lee wrote:
> ...
> > > > i.MX6 SoC. We could directly ask the devicetree in an initcall or we
> > > > could introduce a cpu_is_mx6() just like we have a macro for all other
> > > > i.MX SoCs.
> > > > 
> > > Oops, my reply was a brain-dead one.  Hmm, then it seems that we have
> > > to introduce cpu_is_mx6() which I tried hard to avoid.  I do not have
> > > a preference between defining a macro and asking device tree.
> > 
> > Since we already have a place in early setup code in which we know that
> > we are running on an i.MX6 I suggest for the sake of the symmetry of the
> > universe that we introduce a cpu_is_mx6.
> > 
> Let me try last time.  What about having a late_initcall hook in
> machine_desc?

Also fine with me.

> 
> Regards,
> Shawn
> 
> 8<---
> 
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index d7692ca..0b1c94b 100644
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -43,6 +43,7 @@ struct machine_desc {
>         void                    (*init_irq)(void);
>         struct sys_timer        *timer;         /* system tick timer    */
>         void                    (*init_machine)(void);
> +       void                    (*init_late)(void);
>  #ifdef CONFIG_MULTI_IRQ_HANDLER
>         void                    (*handle_irq)(struct pt_regs *);
>  #endif
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index ebfac78..549f036 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -800,6 +800,14 @@ static int __init customize_machine(void)
>  }
>  arch_initcall(customize_machine);
> 
> +static int __init init_machine_late(void)
> +{
> +       if (machine_desc->init_late)
> +               machine_desc->init_late();
> +       return 0;
> +}
> +late_initcall(init_machine_late);
> +
>  #ifdef CONFIG_KEXEC
>  static inline unsigned long long get_total_mem(void)
>  {
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index da6c1d9..0e3640f 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -142,6 +142,7 @@ DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad (Device Tree)")
>         .handle_irq     = imx6q_handle_irq,
>         .timer          = &imx6q_timer,
>         .init_machine   = imx6q_init_machine,
> +       .init_late      = imx6q_init_late,
>         .dt_compat      = imx6q_dt_compat,
>         .restart        = imx6q_restart,
>  MACHINE_END
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
