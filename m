From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Aug 2016 09:22:34 +0200
Subject: [PATCH 01/10] reset: ath79: add driver Kconfig option
In-Reply-To: <1779401.H3WQxbgf2J@wuerfel>
References: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
 <20643424.8eBLZWavEG@wuerfel>
 <CAK7LNAT4rZoQJaPLiA_Hg=PJ9AD4Z-oLVadq5WDgQ2etCYUFFA@mail.gmail.com>
 <1779401.H3WQxbgf2J@wuerfel>
Message-ID: <1472109754.3032.18.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 24.08.2016, 22:06 +0200 schrieb Arnd Bergmann:
> On Thursday, August 25, 2016 3:18:55 AM CEST Masahiro Yamada wrote:
> > Hi Arnd,
> > 
> > 
> > 2016-08-25 0:51 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> > > On Wednesday, August 24, 2016 3:28:53 PM CEST Philipp Zabel wrote:
> > >>  if RESET_CONTROLLER
> > >>
> > >> +config RESET_ATH79
> > >> +       bool "AR71xx Reset Driver" if COMPILE_TEST
> > >> +       default ATH79
> > >> +       help
> > >> +         This enables the ATH79 reset controller driver that supports the
> > >> +         AR71xx SoC reset controller.
> > >> +
> > >>
> > >
> > > Nice series!
> > >
> > > Just note that there is one possible problem with COMPILE_TEST
> > > when the platforms are enabled, as you can then disable a driver
> > > that is normally there, and that can in turn cause problems in
> > > rare cases, e.g. when the driver has a global function that is
> > > called from platform code. I don't know if any of the drivers
> > > do that, but if they do, you'd have to use
> > >
> > > config RESET_ATH79
> > >        bool "AR71xx Reset Driver" if COMPILE_TEST && !ATH79
> > >        default ATH79
> > >
> > > to ensure that it's impossible to disable the driver on platforms
> > > that require it.
> > 
> > Hmm,
> > Can we do this only when we really have to do so?
> > I think we should not care about such a rare case that may not happen.
> > 
> > Let's start with only "if COMPILE_TEST",
> > and take a look at it if a build error is detected.
> > 
> > Anyway, depending on platform code is a sign of weird implementation.
> > 
> > It might be better to find a potential issue rather than hide it.
> > 
> > 
> > 
> 
> I just checked the object files in an allyesconfig build and found
> one instance:
> 
> arch/arm/mach-sunxi/sunxi.c:extern void __init sun6i_reset_init(void);
> arch/arm/mach-sunxi/sunxi.c:            sun6i_reset_init();
> drivers/reset/reset-sunxi.c:void __init sun6i_reset_init(void)
> 
> We should definitely make sure this one is handled right, and maybe
> check the source code for other instances.

I'll add "&& !ARCH_SUNXI" to the RESET_SUNXI symbol

The only other drivers that have __init symbols are the STiH4xx reset
drivers, which I haven't touched yet: STIH4xx_RESET symbols are already
selected by their respective SOC_STIH4xx under ARCH_STI. And the hi6220
driver, which doesn't have a user yet.

regards
Philipp
