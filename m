From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Sep 2013 13:28:12 +0200
Subject: [PATCH v2] ARM: new platform for Energy Micro's EFM32 Cortex-M3
 SoCs
In-Reply-To: <20130918153424.GR24802@pengutronix.de>
References: <1379447884-14025-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201309172245.25367.arnd@arndb.de> <20130918153424.GR24802@pengutronix.de>
Message-ID: <201309191328.12717.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 September 2013, Uwe Kleine-K?nig wrote:
> On Tue, Sep 17, 2013 at 10:45:25PM +0200, Arnd Bergmann wrote:
> > On Tuesday 17 September 2013, Uwe Kleine-K?nig wrote:
> > 
> > You should be able to add NOMMU platforms in combination with
> > CONFIG_MULTIPLATFORM now, which gets rid of most of these files.
> in next ARCH_MULTIPLATFORM still depends on MMU. What am I missing?

Oh, I saw a patch for that for VEXPRESS/Cortex-R7 some time ago. It was apparently
not merged. Please try just removing the depdency in Kconfig, I think it should
work fine.

> > > +
> > > +void __init efm32_init_time(void)
> > > +{
> > > +	of_clk_init(NULL);
> > > +	clocksource_of_init();
> > > +}
> > 
> > When Sebastian Hesselbarth's patches for of_clk_init() are merged,
> > this function can go away.
> Do you have a link?

http://lmgtfy.com/?q=hesselbarth+of_clk_init ;-)

I've put Sebastian on Cc, I guess he can comment on the status of his
patches, so we can come up with a plan for dealing with the dependency
here.

> > > diff --git a/arch/arm/mach-efm32/include/mach/debug-macro.S b/arch/arm/mach-efm32/include/mach/debug-macro.S
> > > new file mode 100644
> > > index 0000000..c58915c
> > > --- /dev/null
> > > +++ b/arch/arm/mach-efm32/include/mach/debug-macro.S
> > 
> > Please move this to arch/arm/include/debug/ like the other such
> > implementations.
> I don't mind, but I thought this is only for devices that are expected
> to be available on >1 platform.

Well, it's required for multiplatform, since the include/mach/ directory is no
longer visible to the debug code.

> > > diff --git a/arch/arm/mach-efm32/include/mach/entry-macro.S b/arch/arm/mach-efm32/include/mach/entry-macro.S
> > > new file mode 100644
> > > index 0000000..f0c0f7d
> > > --- /dev/null
> > > +++ b/arch/arm/mach-efm32/include/mach/entry-macro.S
> > > @@ -0,0 +1,5 @@
> > > +		.macro	get_irqnr_preamble, base, tmp
> > > +		.endm
> > > +
> > > +		.macro	arch_ret_to_user, tmp1, tmp2
> > > +		.endm
> > 
> > And use set_handle_irq() to register a handler from your irqchip driver
> > to get rid of this one.
> ISTR that I tried that, but I don't remember the details. I will retry.

Maybe you get some spurious interrupt before the irqchip is registered?

	Arndj
