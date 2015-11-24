From: alex.aring@gmail.com (Alexander Aring)
Date: Tue, 24 Nov 2015 22:02:51 +0100
Subject: [PATCH 2/3] ARM: bcm2835: add rpi power domain driver
In-Reply-To: <CAPDyKFqiGe+E6WRELduZJoKwFRkgnFxBvPjEa3jX04EAC3vXrA@mail.gmail.com>
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
 <1447956490-22930-3-git-send-email-alex.aring@gmail.com>
 <CAPDyKFqiGe+E6WRELduZJoKwFRkgnFxBvPjEa3jX04EAC3vXrA@mail.gmail.com>
Message-ID: <20151124210249.GA4270@omega>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 24, 2015 at 09:44:59PM +0100, Ulf Hansson wrote:
> [...]
> 
> > diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> > index 8c53c55..20479d7 100644
> > --- a/arch/arm/mach-bcm/Kconfig
> > +++ b/arch/arm/mach-bcm/Kconfig
> > @@ -134,6 +134,16 @@ config ARCH_BCM2835
> >           This enables support for the Broadcom BCM2835 SoC. This SoC is
> >           used in the Raspberry Pi and Roku 2 devices.
> >
> > +config RASPBERRYPI_POWER
> 
> You don't need a new Kconfig option I think. If you fold in the below
> "select" under ARCH_BCM2835, that should work as well, right?
> 
> select PM_GENERIC_DOMAINS if (RASPBERRYPI_FIRMWARE && PM && OF)
> 

I think this depends on what the maintainers like to have here.

The raspberrypi firmware isn't BCM2835 specific, when some SoC which is
BCM2835 and enabled the RASPBERRYPI_FIRMWARE (for what reason ever) it will
enable also the power domain driver for the RPi.

When some BCM2835 enable it, then it will do nothing because the
devicetree entries should not match then.

> > +       bool "Raspberry Pi power domain driver"
> > +       depends on ARCH_BCM2835
> > +       depends on RASPBERRYPI_FIRMWARE
> > +       select PM_GENERIC_DOMAINS if PM
> > +       select PM_GENERIC_DOMAINS_OF if PM
> > +       help
> > +         This enables support for the RPi power domains which can be enabled
> > +         or disabled via the RPi firmware.
> > +
> >  config ARCH_BCM_63XX
> >         bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
> >         depends on MMU
> > diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> > index 892261f..fec2d6b 100644
> > --- a/arch/arm/mach-bcm/Makefile
> > +++ b/arch/arm/mach-bcm/Makefile
> > @@ -36,6 +36,7 @@ endif
> >
> >  # BCM2835
> >  obj-$(CONFIG_ARCH_BCM2835)     += board_bcm2835.o
> > +obj-$(CONFIG_RASPBERRYPI_POWER)        += raspberrypi-power.o
> 
> According to above, then this should become:
> 
> obj-$(CONFIG_PM_GENERIC_DOMAINS) += raspberrypi-power.o
> 

What about other BCM$FOOBAR arch's which might select/enables
CONFIG_PM_GENERIC_DOMAINS somehow?

Like ARCH_BCM_63XX.

Possible other solution would be to make the CONFIG_RASPBERRYPI_POWER as
a hidden entry inside Kconfig without a prompt.

Then it should look like this:

config RASPBERRYPI_POWER
	bool
	select PM_GENERIC_DOMAINS
	select PM_GENERIC_DOMAINS_OF

config ARCH_BCM2835
	...
	select RASPBERRYPI_POWER if (RASPBERRYPI_FIRMWARE && PM && OF)
	...

and leave the Makefile as it is.

- Alex
