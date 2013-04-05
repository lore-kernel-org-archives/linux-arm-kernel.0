From: horms@verge.net.au (Simon Horman)
Date: Fri, 5 Apr 2013 11:22:53 +0900
Subject: [PATCH/RFC 2/3] ARM: shmobile: initialise clock early on
 kzm9g-reference
In-Reply-To: <Pine.LNX.4.64.1304040847260.21548@axis700.grange>
References: <1365005636-17526-1-git-send-email-g.liakhovetski@gmx.de>
 <1365005636-17526-3-git-send-email-g.liakhovetski@gmx.de>
 <20130404033158.GA28297@verge.net.au>
 <Pine.LNX.4.64.1304040847260.21548@axis700.grange>
Message-ID: <20130405022253.GA29203@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 04, 2013 at 09:13:07AM +0200, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Thu, 4 Apr 2013, Simon Horman wrote:
> 
> > On Wed, Apr 03, 2013 at 06:13:55PM +0200, Guennadi Liakhovetski wrote:
> > > To prepare to enable TWD on kzm9g-reference, clock initialisation has to be
> > > done early. Move it from .init_machine to .init_time stage.
> > 
> > I'm pretty surprised by this given how much effort has
> > been made to avoid early clock initialisation.
> 
> Yes, sorry, I probably failed to explain exactly the meaning of "RFC" in 
> these patches. My goal was to find a way to activate the TWD on kzm9g in 
> the "-reference" configuration, i.e. with DT, when TWD is also 
> instantiated as a DT node. This didn't work out of the box by simply 
> adding the respective DT node as in patch/rfc #3 in this series. Doing 
> that just resulted in a lock up with no output. The reason was, that TWD 
> was trying to initialise before any other timers / clocks and its 
> calibration in twd_calibrate_rate() was cycling endlessly. So, I tried to 
> find a way to fix this lock-up, which produced these RFCs. I'm perfectly 
> aware, that this might not be what we want to have in the mainline, this 
> is just an illustration, what I had to do to get TWD running with DT.

Thanks for the clarification, I understand.

> As for "avoid early clock initialisation" - I'm aware of this goal in 
> principle, but I'm not sure about details - how early is too early and 
> when it is already allowed, why is this important with DT and not with 
> legacy (because we want to initialise all clocks from DT?), what are 
> proper ways to solve problems like this one? Note, that TWD has to be 
> registered before secondary_start_kernel() is run. So, we need a 
> clocksource before that time for a successful TWD calibration.

I wonder if this problem can be resolved using init priorities?

In general I believe the idea is that early clocks can and should
be avoided because they should not be necessary. If they are necessary
in some cases then I assume we will use them.

Magnus, can you clarify this?

> Thanks
> Guennadi
> 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > > ---
> > >  arch/arm/mach-shmobile/board-kzm9g-reference.c |    8 +++++++-
> > >  arch/arm/mach-shmobile/setup-sh73a0.c          |   13 +++++++++----
> > >  2 files changed, 16 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> > > index aefa50d..0f9b276 100644
> > > --- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> > > +++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> > > @@ -90,6 +90,12 @@ static void __init kzm_init(void)
> > >  #endif
> > >  }
> > >  
> > > +static void __init timer_init(void)
> > > +{
> > > +	sh73a0_clock_init();
> > > +	shmobile_timer_init();
> > > +}
> > > +
> > >  static const char *kzm9g_boards_compat_dt[] __initdata = {
> > >  	"renesas,kzm9g-reference",
> > >  	NULL,
> > > @@ -102,6 +108,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
> > >  	.nr_irqs	= NR_IRQS_LEGACY,
> > >  	.init_irq	= irqchip_init,
> > >  	.init_machine	= kzm_init,
> > > -	.init_time	= shmobile_timer_init,
> > > +	.init_time	= timer_init,
> > >  	.dt_compat	= kzm9g_boards_compat_dt,
> > >  MACHINE_END
> > > diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
> > > index 0469e84..8a1bc1c 100644
> > > --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> > > +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> > > @@ -1018,9 +1018,6 @@ void __init sh73a0_add_standard_devices_dt(void)
> > >  {
> > >  	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id = -1, };
> > >  
> > > -	/* clocks are setup late during boot in the case of DT */
> > > -	sh73a0_clock_init();
> > > -
> > >  	platform_add_devices(sh73a0_devices_dt,
> > >  			     ARRAY_SIZE(sh73a0_devices_dt));
> > >  	of_platform_populate(NULL, of_default_bus_match_table,
> > > @@ -1030,6 +1027,14 @@ void __init sh73a0_add_standard_devices_dt(void)
> > >  	platform_device_register_full(&devinfo);
> > >  }
> > >  
> > > +static void __init add_standard_devices(void)
> > > +{
> > > +	/* clocks are setup late during boot in the case of DT */
> > > +	sh73a0_clock_init();
> > > +
> > > +	sh73a0_add_standard_devices_dt();
> > > +}
> > > +
> > >  static const char *sh73a0_boards_compat_dt[] __initdata = {
> > >  	"renesas,sh73a0",
> > >  	NULL,
> > > @@ -1041,7 +1046,7 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
> > >  	.init_early	= sh73a0_init_delay,
> > >  	.nr_irqs	= NR_IRQS_LEGACY,
> > >  	.init_irq	= irqchip_init,
> > > -	.init_machine	= sh73a0_add_standard_devices_dt,
> > > +	.init_machine	= add_standard_devices,
> > >  	.init_time	= shmobile_timer_init,
> > >  	.dt_compat	= sh73a0_boards_compat_dt,
> > >  MACHINE_END
> > > -- 
> > > 1.7.2.5
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > > the body of a message to majordomo at vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > 
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
