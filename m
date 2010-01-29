From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 29 Jan 2010 17:56:55 +0530
Subject: [PATCH 1/3] OMAP4: Add L2 Cache support
In-Reply-To: <1264767365.4242.54.camel@pc1117.cambridge.arm.com>
References: <1264765589-18353-1-git-send-email-santosh.shilimkar@ti.com>
	<1264767365.4242.54.camel@pc1117.cambridge.arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C09C688C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for quick comment.
> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Friday, January 29, 2010 5:46 PM
> To: Shilimkar, Santosh
> Cc: tony at atomide.com; linux-arm-kernel at lists.infradead.org; rmk at arm.linux.org.uk; linux-
> omap at vger.kernel.org
> Subject: Re: [PATCH 1/3] OMAP4: Add L2 Cache support
> 
> On Fri, 2010-01-29 at 11:46 +0000, Santosh Shilimkar wrote:
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -28,6 +28,7 @@
> >  #include <plat/control.h>
> >  #include <plat/timer-gp.h>
> >  #include <asm/hardware/gic.h>
> > +#include <asm/hardware/cache-l2x0.h>
> >
> >  static struct platform_device sdp4430_lcd_device = {
> >         .name           = "sdp4430_lcd",
> > @@ -49,6 +50,38 @@ static struct omap_lcd_config sdp4430_lcd_config __initdata = {
> >  static struct omap_board_config_kernel sdp4430_config[] __initdata = {
> >         { OMAP_TAG_LCD,         &sdp4430_lcd_config },
> >  };
> > +#ifdef CONFIG_CACHE_L2X0
> > +static int __init omap_l2_cache_init(void)
> > +{
> > +       void __iomem *l2cache_base;
> > +
> > +       /* Static mapping, never released */
> > +       l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
> > +       BUG_ON(!l2cache_base);
> > +
> > +       /* Enable L2 Cache using secure api
> > +        * r0 contains the value to be modified and "r12" contains
> > +        * the monitor API number. This API uses few CPU registers
> > +        * internally and hence they need be backed up including
> > +        * link register "lr".
> > +        */
> > +       __asm__ __volatile__(
> > +               "stmfd r13!, {r0-r12, r14}\n"
> > +               "mov r0, #1\n"
> > +               "ldr r12, =0x102\n"
> > +               "dsb\n"
> > +               "smc\n"
> > +               "ldmfd r13!, {r0-r12, r14}");
> 
> Same comments as on the cache-l2x0.c changes - can you not let the
> compiler choose what to saved by declaring the clobbered register in the
> asm directive?
Since this code was used only ones in init, I haven't converted it to function. With clobber list
as well as you know adding r12 to clobber list, compiler don't generate the save code
and r11 can't be added to clobber list.

But I can do the same change as I did in the "cache-l2x0.c" Will send updated version.

Regards,
Santosh
