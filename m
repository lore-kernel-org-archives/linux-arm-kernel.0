From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Aug 2013 19:47:43 +0200
Subject: [RFC v1 5/5] ARM: mvebu: add board init for Armada 1500
In-Reply-To: <5212312A.20401@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201308172108.38824.arnd@arndb.de> <5212312A.20401@gmail.com>
Message-ID: <201308191947.43960.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 August 2013, Sebastian Hesselbarth wrote:
> On 08/17/13 21:08, Arnd Bergmann wrote:
> > On Friday 16 August 2013, Jason Cooper wrote:
>
> > You should really try to find out what driver uses this. If you have a requirement
> > that VIRT == PHYS here, the most likely explanation is that some driver accidentally
> > uses readl/writel on the physical address rather than on the result of ioremap.
> >
> > You can try shrinking the area using bisection until you have found the offending
> > driver based on the address.
> 
> I just removed the above and it still works. Must have been a placebo
> for me to believe it made it working.

Ah, good.

> >>> +static void __init armada_1500_timer_and_clk_init(void)
> >>> +{
> >>> +	of_clk_init(NULL);
> >>> +	clocksource_of_init();
> >>> +}
> >>> +
> >>> +static void __init armada_1500_dt_init(void)
> >>> +{
> >>> +	l2x0_of_init(0x70c00000, 0xfeffffff);
> >
> > New platforms should call this as 'l2x0_of_init(0, 0);' and get the bits from DT.
> 
> Is there any work on "get the bits from DT" already? I looked in
> arm-soc/for-next and for-next but couldn't find any parsing of
> aux_*.

Have a look at the pl310_of_setup() and aurora_of_setup() functions, they parse
the available properties and edit the mask. You might have to add further properties
in the same way.

> > Note that we should really change the common code to do both the of_clk_init()
> > and the l2x0_of_init() automatically, but that needs to be done with some care,
> > in order to not break any of the existing platforms. Would you be able to do
> > one of the two? We can then get the next person that wants to add a platform
> > to do the last one ;-)
> 
> Haven't had a look at cache init, but of_clk_init(NULL). Since most
> platforms need clocks prior timer, I guess any initcall is too late?

Right.

> Below init sequence guessing may be wrong, but that is what I read
> from init/main.c and arm arch init.
> 
> Looking through arch/ there is arc, arm, arm64, and metag using
> of_clk_init(NULL).
> 
> arch/arc/plat-tb10x and arch/arm64 call it right before
> of_platform_populate which is after time_init() and too late for
> us, arch/metag calls it within time_init().
> 
> On arch/arm of_clk_init(NULL) is heavily spread among mach- subdirs
> with exynos, highbank, imx (all sub-machs), mvebu, nspire, rockchip,
> sti, and vexpress calling it in .init_time; tegra calls it even
> earlier in .init_irq, socfpga in .init_machine. With latest clocksource
> driver for Orion, -dove, -orion5x, and -mv78xx0, will also need clocks
> prior timer.
>
> If we are going for an arch/arm specific call to of_clk_init(NULL),
> we could also call it from time_init(); after asking the tegra guys
> about the specific requirement to have them (and the drivers using
> it) ready before timers have been initialized.
> 
> For the transition period, we should add a static bool to of_clk_init
> to WARN_ON double registration attempts.
> 
> I could prepare some patches to convert existing arch/arm users to
> get some noise on the corresponding mailing lists. Maybe one of the
> tegra guys is also reading this and can comment on .init_irq before.

Sounds good. I think it can easily be done in a way that it's harmless
to call it multiple times with a NULL argument, which would take care
of platforms that might need it to be called earlier.

I've gone over the platforms with Mark Rutland before and we found
four other platforms that need a little work before the conversion
can work:

* arch/arm/mach-highbank/highbank.c needs to map sregs_base before
  calling of_clk_init().

* Similar code in drivers/clk/clk-vt8500.c and drivers/clk/zynq/clkc.c

* arch/arm/mach-imx/clk-imx51-imx53.c has a lot of interdependencies
  with other code.

One could either change those to not depend on a pointer outside of
the driver, which would be the cleaner approach but possibly more
work, or they could be changed back to using a non-NULL argument,
at least as an intermediate step, so calling of_clk_init(NULL) won't
actually initialize these.

	Arnd
