From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 May 2013 16:57:15 +0800
Subject: [PATCH v3 2/4] ARM: imx: add initial support for MVF600
In-Reply-To: <5396520.ZTuSn9S4Vd@wuerfel>
References: <1368684648-20826-1-git-send-email-b35083@freescale.com>
 <1368684648-20826-3-git-send-email-b35083@freescale.com>
 <5396520.ZTuSn9S4Vd@wuerfel>
Message-ID: <20130517085714.GG8607@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Allow me help respond a little bit.

On Thu, May 16, 2013 at 12:29:28PM +0200, Arnd Bergmann wrote:
> On Thursday 16 May 2013 14:10:46 Jingchang Lu wrote:
> 
> > index a402248..b9c01a1 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -835,6 +835,21 @@ config SOC_IMX6SL
> >  	help
> >  	  This enables support for Freescale i.MX6 SoloLite processor.
> >  
> > +config SOC_MVF600
> > +	bool "Vybrid Family MVF600 support"
> > +	select CPU_V7
> > +	select ARM_GIC
> > +	select CLKSRC_OF
> > +	select PINCTRL
> > +	select PINCTRL_MVF600
> > +	select MVF600_PIT_TIMER
> > +	select PL310_ERRATA_588369 if CACHE_PL310
> > +	select PL310_ERRATA_727915 if CACHE_PL310
> > +	select PL310_ERRATA_769419 if CACHE_PL310
> > +
> > +	help
> > +	  This enable support for Freescale Vybrid MVF600 processor.
> > +
> >  endif
> 
> Shouldn't that 'depends on ARCH_MULTI_V7'?
> 
SOC_MVF600 is added as a sub-item of ARCH_MXC which already handles the
ARCH_MULTI_* dependency.

> Can you describe how much Vybrid is actually like MXC? Do you actually
> use most of the mach-imx code?
> 
Jingchang mentioned some IP blocks shared between IMX and Vybrid.  Right
now, mvf600 reuses mxc_restart() and some amount of clk code
clk-pllv3.c, clk-gate2.c clk.c etc. in arch/arm/mach-imx.

> > diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> > index 208e76f..55cdba0 100644
> > --- a/arch/arm/mach-imx/common.h
> > +++ b/arch/arm/mach-imx/common.h
> > @@ -70,6 +70,7 @@ extern int mx51_clocks_init_dt(void);
> >  extern int mx53_clocks_init_dt(void);
> >  extern int mx6q_clocks_init(void);
> >  extern int imx6sl_clocks_init(void);
> > +extern int mvf600_clocks_init(void);
> >  extern struct platform_device *mxc_register_gpio(char *name, int id,
> >  	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
> >  extern void mxc_set_cpu_type(unsigned int type);
> 
> This hunk belongs into the first patch, right?
> 
The declaration is only used in this patch by mach-mvf600.c.

> Actually I think you should move that driver to drivers/clk and use
> of_clk_init(NULL) to initialize it.
> 
The mvf600 clock driver uses a lot of base clk support from mach-imx,
and can not be moved into drivers/clk as a single driver.  Right now, in
IMX clock drivers, we call of_clk_init() to only register fixed rate
clocks, since all the other clocks are not represented in device tree.

> > +static void __init mvf600_init_machine(void)
> > +{
> > +	mxc_arch_reset_init_dt();
> 
> I don't see the mxc_arch_reset_init_dt function in 3.10-rc1. Where does it
> get introduced?
> 
It gets introduced by my series below.  And I guess Jiangchang is basing
his series on my imx/soc branch.

http://thread.gmane.org/gmane.linux.ports.arm.kernel/235986/focus=236091

> It would be nice if we could integrate that into the watchdog driver,
> so that driver just registers a pm_restart function when it gets loaded.
> It is a rather small driver, so it would not hurt to always load it.
> 
Sound like a good idea.  We will consider it as another cleanup task for
mach-imx.

> > +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > +}
> 
> It would be nicer if you could just use the default init_machine.
> 
> > +static void __init mvf600_init_irq(void)
> > +{
> > +	struct device_node *np;
> > +	void __iomem *mscm_base;
> > +	int i;
> > +
> > +	l2x0_of_init(0, ~0UL);
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "fsl,mvf600-mscm");
> > +	mscm_base = of_iomap(np, 0);
> > +	if (!mscm_base)
> > +		return;
> > +
> > +	/* route all shared peripheral interrupts to CP0 */
> > +	for (i = 0; i < 111; i++)
> > +		__raw_writew(1, mscm_base + 0x880 + 2 * i);
> > +
> > +	iounmap(mscm_base);
> > +
> > +	irqchip_init();
> > +}
> 
> What is the mscm? Shouldn't the boot loader have set this up correctly?
> If you can remove that code from the kernel, you can use the default
> irqchip_init call.
> 
Yeah, and if we find another way for l2x0_of_init() call.

> > +static void __init mvf600_init_time(void)
> > +{
> > +	mvf600_clocks_init();
> > +	clocksource_of_init();
> > +}
> 
> I would like to call of_clk_init(NULL) unconditionally on all machines
> in 3.11, so this function could also go away.
> 
of_clk_init() has been called in mvf600_clocks_init(), but as explained
as above, it only registers fixed rate clocks and can not save
mvf600_clocks_init() call right now where most of mvf600 clocks gets
registered.

> > +static const char *mvf600_dt_compat[] __initdata = {
> > +	"fsl,mvf600",
> > +	NULL,
> > +};
> > +
> > +DT_MACHINE_START(VYBRID_VF6XX, "Freescale Vybrid MVF600 (Device Tree)")
> > +	.init_irq	= mvf600_init_irq,
> > +	.init_time	= mvf600_init_time,
> > +	.init_machine   = mvf600_init_machine,
> > +	.dt_compat	= mvf600_dt_compat,
> > +	.restart	= mxc_restart,
> > +MACHINE_END
> 
> If we can do all of the above, we can actually remove the entire machine
> descriptor here, since all its members are NULL.
> 
Yeah, we understand the goal, and this will be the goal of mach-imx
cleanup.

Shawn
