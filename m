From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Aug 2016 17:35:54 +0200
Subject: Why do we need reset_control_get_optional() ?
In-Reply-To: <1470387358.3141.17.camel@pengutronix.de>
References: <CAK7LNAQnitMMp5wMXXvVeS-UFF=Fo9m=M1hL=5f4=RF8JYCnGg@mail.gmail.com>
 <3400649.NoVKUzu81R@wuerfel> <1470387358.3141.17.camel@pengutronix.de>
Message-ID: <1793038.JVifRUCe28@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, August 5, 2016 10:55:58 AM CEST Philipp Zabel wrote:
> Am Samstag, den 30.07.2016, 22:13 +0200 schrieb Arnd Bergmann:
> > On Friday, July 29, 2016 3:08:15 PM CEST Philipp Zabel wrote:
> > > Hi Masahiro,
> > > 
> > > Am Donnerstag, den 28.07.2016, 19:29 +0900 schrieb Masahiro Yamada:
> > > [...]
> > > > However, I think the following makes more sense:
> > > > 
> > > > 
> > > > menuconfig RESET_CONTROLLER
> > > >         bool "Reset Controller Support"
> > > >         depends on (ARCH_HAS_RESET_CONTROLLER || COMPILE_TEST)
> > > >         default y
> > > >         help
> > > >           Generic Reset Controller support.
> > > 
> > > That looks sensible to me. You'll only have to enable the reset
> > > controller framework if either some enabled architecture has a reset
> > > controller (in which case you want the driver for it to be activated by
> > > default), or if you want to compile test some of the reset drivers.
> > 
> > This still doesn't let a platform 'select RESET_FOO', unless they
> > also select RESET_CONTROLLER and ARCH_HAS_RESET_CONTROLLER.
> > 
> > Why do we need to guard all drivers inside of two symbols?
> 
> Does the platform have to select RESET_FOO at all? Wouldn't it be enough
> for RESET_FOO to have "default ARCH_FOO" ?

It depends on what you want to achieve. With a user-visible option
and "default ARCH_FOO", you can disable the driver manually, and
another driver that has "depends on ARCH_FOO" can not rely on this
one being present as it currently can.

If we do this as

config RESET_FOO
	bool "FOO reset controller" if COMPILE_TEST && !ARCH_FOO
	default ARCH_FOO

then I think we get both: you won't be able to turn it off
but also get the build testing.

> Currently ARCH_HAS_RESET_CONTROLLER is used to default y the
> RESET_CONTROLLER symbol. Maybe we should add another
> ARCH_REQUIRE_RESET_CONTROLLER and have that select RESET_CONTROLLER,
> similarly to how it is done for GPIOLIB?

GPIOLIB just stopped using it, there is now only CONFIG_GPIOLIB
that can get selected by platforms that need it.

> config ARCH_HAS_RESET_CONTROLLER
> 	bool
> 	help
> 	  Selecting this option from the architecture Kconfig enables
> 	  the RESET_CONTROLLER framework by default but does not select
> 	  it. Use it for architectures that still work without reset
> 	  controller support and thus allow the user to disable it.
> 
> config ARCH_REQUIRE_RESET_CONTROLLER
> 	bool
> 	select RESET_CONTROLLER
> 	help
> 	  Selecting this option from the architecture Kconfig selects
> 	  the RESET_CONTROLLER framework. Use it for architectures that
> 	  should not be built without the reset controller framework
> 	  enabled.
> 
> menuconfig RESET_CONTROLLER
>         bool "Reset Controller Support"
>         default ARCH_HAS_RESET_CONTROLLER || COMPILE_TEST
>         help
>           Generic Reset Controller support.
> 
>           This framework is designed to abstract reset handling of devices
>           via GPIOs or SoC-internal reset controller modules.
> 
>           If unsure, say no.
> 
> The platforms could then select one of the ARCH_*_RESET_CONTROLLER
> symbols and nobody would have to select RESET_CONTROLLER directly, for
> example:
> 
> menuconfig ARCH_TEGRA                                                                                                                         
>         bool "NVIDIA Tegra"
>         depends on ARCH_MULTI_V7
>         select ARCH_REQUIRE_GPIOLIB
>         select ARCH_REQUIRE_RESET_CONTROLLER
>         select ARCH_SUPPORTS_TRUSTED_FOUNDATIONS

I never really like the way it was done for gpiolib. I think the
easiest way would be to have a menu for the reset controllers that
does not have any dependencies whatsoever, and make the individual
reset drivers select CONFIG_RESET_CONTROLLER, which then becomes
a hidden symbol that enables the core code.

	Arnd
