From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 May 2013 14:29:52 +0200
Subject: [PATCH v3 2/4] ARM: imx: add initial support for MVF600
In-Reply-To: <20130517085714.GG8607@S2101-09.ap.freescale.net>
References: <1368684648-20826-1-git-send-email-b35083@freescale.com>
 <5396520.ZTuSn9S4Vd@wuerfel>
 <20130517085714.GG8607@S2101-09.ap.freescale.net>
Message-ID: <201305171429.52646.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 May 2013, Shawn Guo wrote:
> On Thu, May 16, 2013 at 12:29:28PM +0200, Arnd Bergmann wrote:
> > On Thursday 16 May 2013 14:10:46 Jingchang Lu wrote:
> > > +config SOC_MVF600
> > 
> > Shouldn't that 'depends on ARCH_MULTI_V7'?
> > 
> SOC_MVF600 is added as a sub-item of ARCH_MXC which already handles the
> ARCH_MULTI_* dependency.

Ah, makes sense.

> > Can you describe how much Vybrid is actually like MXC? Do you actually
> > use most of the mach-imx code?
> > 
> Jingchang mentioned some IP blocks shared between IMX and Vybrid.  Right
> now, mvf600 reuses mxc_restart() and some amount of clk code
> clk-pllv3.c, clk-gate2.c clk.c etc. in arch/arm/mach-imx.

Ok.

> > Actually I think you should move that driver to drivers/clk and use
> > of_clk_init(NULL) to initialize it.
> > 
> The mvf600 clock driver uses a lot of base clk support from mach-imx,
> and can not be moved into drivers/clk as a single driver.  Right now, in
> IMX clock drivers, we call of_clk_init() to only register fixed rate
> clocks, since all the other clocks are not represented in device tree.

What are your plans for this in the long run?

> > It would be nice if we could integrate that into the watchdog driver,
> > so that driver just registers a pm_restart function when it gets loaded.
> > It is a rather small driver, so it would not hurt to always load it.
> > 
> Sound like a good idea.  We will consider it as another cleanup task for
> mach-imx.

Ok
 
> > What is the mscm? Shouldn't the boot loader have set this up correctly?
> > If you can remove that code from the kernel, you can use the default
> > irqchip_init call.
> > 
> Yeah, and if we find another way for l2x0_of_init() call.

Good point. That is something we need to do anyway.

> > > +static const char *mvf600_dt_compat[] __initdata = {
> > > +	"fsl,mvf600",
> > > +	NULL,
> > > +};
> > > +
> > > +DT_MACHINE_START(VYBRID_VF6XX, "Freescale Vybrid MVF600 (Device Tree)")
> > > +	.init_irq	= mvf600_init_irq,
> > > +	.init_time	= mvf600_init_time,
> > > +	.init_machine   = mvf600_init_machine,
> > > +	.dt_compat	= mvf600_dt_compat,
> > > +	.restart	= mxc_restart,
> > > +MACHINE_END
> > 
> > If we can do all of the above, we can actually remove the entire machine
> > descriptor here, since all its members are NULL.
> > 
> Yeah, we understand the goal, and this will be the goal of mach-imx
> cleanup.

Ok. I guess we just won't be there for 3.11 then.

	Arnd
