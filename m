From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 20:44:41 +0000
Subject: [PATCH 3/6] arm: kconfig: don't select TWD with local timer for
 Armada 370/XP
In-Reply-To: <CAKGA1b=9WQNwHOz=k13XVc=MyZT1UrcaYj8muF2A5B4eJA5+MA@mail.gmail.com>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <201301211831.45947.arnd@arndb.de>
 <CAKGA1b=9WQNwHOz=k13XVc=MyZT1UrcaYj8muF2A5B4eJA5+MA@mail.gmail.com>
Message-ID: <201301212044.41865.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Matt Sealey wrote:
> On Mon, Jan 21, 2013 at 12:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 21 January 2013, Gregory CLEMENT wrote:
> >> @@ -1624,7 +1624,7 @@ config LOCAL_TIMERS
> >>         bool "Use local timer interrupts"
> >>         depends on SMP
> >>         default y
> >> -       select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
> >> +       select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT && !ARMADA_370_XP_TIMER)
> >>
> >
> > Maybe it can be written as
> >
> > config LOCAL_TIMERS
> >         bool "Use local timer interrupts"
> >         depends on SMP
> >         default y
> >
> > config HAVE_ARM_TWD
> >         depends on LOCAL_TIMERS
> >         default ARCH_MULTIPLATFORM || (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
> >         default y
> >
> > This will still be slightly wrong (generating extra code) on a multiplatform
> > kernel that has no platform other than MSM or EXYNOS, but the other alternative
> > would be that each platform with TWD support has to select HAVE_ARM_TWD itself.
> 
> Why would having each platform with TWD support select HAVE_ARM_TWD be
> a problem?

Not a big one, it's just one more Kconfig line for each of a large number
of platforms in the long run.

> On multiplatform kernels where at least one arch has TWD support, it
> will be included, and where not, it will not.
> 
> It doesn't seem logical for a feature descriptor (HAVE_ARM_TWD) to
> rely on greater knowledge of what platforms may or may not support it.
> If we had to include every platform in that list it would be unwieldy.

I would expect that all future platforms have ARM_TWD, so the list
of the platforms that don't is not going to grow much, but the list
of platforms that do will keep growing.

> Which leads me to this; I wonder if there should be a policy document
> that basically describes what HAVE_* really is meant for, and how
> dependencies on ARCH_* (or MACH_* in the world of multiplatform)
> should be handled for architectural features? That way there's a
> little more fixed definition of how Kconfigs should be written to
> effectively support multiplatform kernels and allow people to identify
> misuses and get rid of them for multiplatform, if only just to get the
> information out of the heads of maintainers and into a file somewhere
> that we can reference... maybe it exists already but I am missing it?

Documentation is generally considered a good thing, but few people
can be bothered to write it, and few of the other people that should
read it actually do.

To some extent this problem will improve over time for the ARM
multiplatform support as we find all the bugs like this one
and fix them.

	Arnd
