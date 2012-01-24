From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jan 2012 16:23:28 +0000
Subject: [PATCH 21/31] ARM: amba: realview: get rid of private platform
 amba_device initializer
In-Reply-To: <20120124160044.GM19798@mudshark.cambridge.arm.com>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAmo-0005Ff-DW@rmk-PC.arm.linux.org.uk>
 <20120124160044.GM19798@mudshark.cambridge.arm.com>
Message-ID: <20120124162328.GA8517@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 04:00:44PM +0000, Will Deacon wrote:
> Hi Russell,
> 
> On Fri, Jan 20, 2012 at 09:29:30AM +0000, Russell King - ARM Linux wrote:
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/mach-realview/core.h            |   20 ++++-----------
> >  arch/arm/mach-realview/realview_eb.c     |   38 +++++++++++++++---------------
> >  arch/arm/mach-realview/realview_pb1176.c |   38 +++++++++++++++---------------
> >  arch/arm/mach-realview/realview_pb11mp.c |   38 +++++++++++++++---------------
> >  arch/arm/mach-realview/realview_pba8.c   |   38 +++++++++++++++---------------
> >  arch/arm/mach-realview/realview_pbx.c    |   38 +++++++++++++++---------------
> >  6 files changed, 100 insertions(+), 110 deletions(-)
> 
> After applying this patch, I get compile-time errors in realview_*.c.
> E.g.:
> 
> arch/arm/mach-realview/realview_pb1176.c:158:1: error: ?AACI? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:159:1: error: ?MMCI0? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:160:1: error: ?KMI0? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:161:1: error: ?KMI1? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:162:1: error: ?PB1176_UART4? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:165:1: error: ?PB1176_SMC? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:166:1: error: ?SCTL? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:167:1: error: ?PB1176_WATCHDOG? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:168:1: error: ?PB1176_GPIO0? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:169:1: error: ?GPIO1? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:170:1: error: ?GPIO2? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:171:1: error: ?PB1176_RTC? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:172:1: error: ?SCI? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:173:1: error: ?PB1176_UART0? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:174:1: error: ?PB1176_UART1? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:175:1: error: ?PB1176_UART2? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:176:1: error: ?PB1176_UART3? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:177:1: error: ?PB1176_SSP? undeclared here (not in a function)
> arch/arm/mach-realview/realview_pb1176.c:178:1: error: ?PB1176_CLCD? undeclared here (not in a function)
> 
> > diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
> > index 735b57a..b1c6097 100644
> > --- a/arch/arm/mach-realview/core.h
> > +++ b/arch/arm/mach-realview/core.h
> > @@ -28,21 +28,11 @@
> >  #include <asm/setup.h>
> >  #include <asm/leds.h>
> > 
> > -#define AMBA_DEVICE(name,busid,base,plat)                      \
> > -static struct amba_device name##_device = {                    \
> > -       .dev            = {                                     \
> > -               .coherent_dma_mask = ~0,                        \
> > -               .init_name = busid,                             \
> > -               .platform_data = plat,                          \
> > -       },                                                      \
> > -       .res            = {                                     \
> > -               .start  = REALVIEW_##base##_BASE,               \
> > -               .end    = (REALVIEW_##base##_BASE) + SZ_4K - 1, \
> > -               .flags  = IORESOURCE_MEM,                       \
> > -       },                                                      
> 
> Which is because the old AMBA_DEVICE macro munges REALVIEW_ and _BASE
> around the peripheral identifier...
> 
> > +#define APB_DEVICE(name, busid, base, plat)                    \
> > +static AMBA_APB_DEVICE(name, busid, 0, base, base##_IRQ, plat)
> > +
> > +#define AHB_DEVICE(name, busid, base, plat)                    \
> > +static AMBA_AHB_DEVICE(name, busid, 0, base, base##_IRQ, plat)
> 
> ...whereas the new macros just use base directly.
> 
> Fixing the macro solves the build problem:
> 
> 
> diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
> index b1c6097..f8f2c0a 100644
> --- a/arch/arm/mach-realview/core.h
> +++ b/arch/arm/mach-realview/core.h
> @@ -29,10 +29,10 @@
>  #include <asm/leds.h>
>  
>  #define APB_DEVICE(name, busid, base, plat)                    \
> -static AMBA_APB_DEVICE(name, busid, 0, base, base##_IRQ, plat)
> +static AMBA_APB_DEVICE(name, busid, 0, REALVIEW_##base##_BASE, base##_IRQ, plat)
>  
>  #define AHB_DEVICE(name, busid, base, plat)                    \
> -static AMBA_AHB_DEVICE(name, busid, 0, base, base##_IRQ, plat)
> +static AMBA_AHB_DEVICE(name, busid, 0, REALVIEW_##base##_BASE, base##_IRQ, plat)
>  
>  struct machine_desc;
>  
> 
> but then I see a warning during boot:
> 
> [    1.669654] ------------[ cut here ]------------
> [    1.684021] WARNING: at drivers/amba/bus.c:514 amba_device_add+0x1b4/0x1d0()
> [    1.705585] Modules linked in:
> [    1.715195] [<c0013a00>] (unwind_backtrace+0x0/0xfc) from [<c03d1350>] (dump_stack+0x20/0x24)
> [    1.741288] [<c03d1350>] (dump_stack+0x20/0x24) from [<c001f9b8>] (warn_slowpath_common+0x5c/0x74)
> [    1.768689] [<c001f9b8>] (warn_slowpath_common+0x5c/0x74) from [<c001f9fc>] (warn_slowpath_null+0x2c/0x34)
> [    1.798165] [<c001f9fc>] (warn_slowpath_null+0x2c/0x34) from [<c023dcd4>] (amba_device_add+0x1b4/0x1d0)
> [    1.826857] [<c023dcd4>] (amba_device_add+0x1b4/0x1d0) from [<c023dd84>] (amba_device_register+0x94/0xc4)
> [    1.856106] [<c023dd84>] (amba_device_register+0x94/0xc4) from [<c0551934>] (realview_pb1176_init+0x74/0xac)
> [    1.886120] [<c0551934>] (realview_pb1176_init+0x74/0xac) from [<c054d60c>] (customize_machine+0x24/0x30)
> [    1.915340] [<c054d60c>] (customize_machine+0x24/0x30) from [<c000879c>] (do_one_initcall+0x48/0x1a0)
> [    1.943505] [<c000879c>] (do_one_initcall+0x48/0x1a0) from [<c054b870>] (kernel_init+0x80/0x128)
> [    1.970378] [<c054b870>] (kernel_init+0x80/0x128) from [<c000ea78>] (kernel_thread_exit+0x0/0x8)
> [    1.997192] ---[ end trace 1b75b31a2719ed1e ]---
> 
> I suspect that comes from PB1176_GPIO0_IRQ being -1.

It seems you've also tested the code which detects -1 IRQs too, which
is good.  PB1176 needs that GPIO0_IRQ fixing, but I suspect passing
zero may not be entirely a good thing for it as request_irq(0,...)
probably succeeds there.  I think that needs fixing before this warning
can go away.

In the mean time, it's just a warning, and its saying there's something
wrong there which needs fixing but without anything currently broken.
So it's working as designed.
