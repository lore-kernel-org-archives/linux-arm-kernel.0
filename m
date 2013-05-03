From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 May 2013 15:56:42 +0200
Subject: [PATCH 9/9] ARM: ux500: always select ABX500_CORE
In-Reply-To: <CACRpkdaNd0Ej-bM0MaXNdyHeWWH0CMi+mKKvtV5-891OFETtEA@mail.gmail.com>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
 <1883078.Smcmxe7hlB@wuerfel>
 <CACRpkdaNd0Ej-bM0MaXNdyHeWWH0CMi+mKKvtV5-891OFETtEA@mail.gmail.com>
Message-ID: <1500795.gEuGziRZET@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 May 2013 15:33:17 Linus Walleij wrote:
> On Fri, May 3, 2013 at 2:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> > This leavs the debugging
> > interface as the only sub-option. Do you know if that is
> > actually being used by developers, or is this one of those interfaces
> > that were created during bringup and then never touched again
> > after everything worked?
> 
> Something like that, but as long as new platforms using that
> ASIC is coming out it remains quite usable for this.
> 
> It is also used for hardware validation, where you hook up the
> system with a lot of electric probes and want to set specific
> bits here and there to validate functionality. There just a minor
> change to the silicon or packaging triggers such re-validation.
> 
> The usecase is similar to the debug interface we invented for
> pin control recently, however there we managed to make things
> centralized.

Ok, makes sense.

> > Regarding AB3100, I assume the relationship to U300 is similar to
> > that between DB8500 and AB8500. Are you able to boot a U300 system
> > without touching AB3100?
> 
> I would say no. The system will be in some bootstrap state unless
> you bring up the AB3100, and especially the regulators.
> 
> These are default y but should arguably be selected y
> instead.
> 
> The U300 SoC will bootstrap power in a strange way until the
> regulators are up, and then hand over to software-controlled
> regulators for powering the SoC and release that bootstrap.
> 
> This is not harmful but a very strange and it's doubtful whether
> I would call that "fully booted". It's something like booting
> into "safe mode"
> http://en.wikipedia.org/wiki/Safe_mode

I see.

> Not enabling regulators on the U300 will have other strange
> effects ... like MMC/SD not working. Yet we can not have
> depends on REGULATORS in the Kconfig for the MMCI driver
> since this driver is also used on systems without the regulator
> framework (hardwired power).
> 
> All these run-time "makes sense" is in a bit of flux as compared
> to config-and-compile-time "makes sense" unfortunately.
> 
> I lean toward selecting AB3100 and REGULATOR_AB3100
> for the U300 actually.

Should we still allow building them on other platforms then?
Right now, these depend on the platforms that actually use
the hardware, but in other places, we just allow everything to
be built that compiles without errors.
Is it theoretically possible to use the AB in combination with
another (non-ST-Ericsson) digital baseband?

	Arnd
