From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Sep 2015 16:11:59 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56054DA8.4050903@free.fr>
References: <56001B78.2090001@free.fr> <2210529.vnGEGUl8Dr@wuerfel>
 <56054DA8.4050903@free.fr>
Message-ID: <7559792.th4E1kM5gi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 September 2015 15:35:36 Mason wrote:
> On 25/09/2015 15:17, Arnd Bergmann wrote:
> > On Friday 25 September 2015 15:06:32 Mason wrote:
> >> On 22/09/2015 16:51, Arnd Bergmann wrote:
> >>
> >>> Move this to the platform Kconfig file. Also, drop all the
> >>> 'select' statements that are implied by ARCH_MULTIPLATFORM
> >>> and ARCH_MULTI_V7
> >>
> >> I've trimmed my platform Kconfig down to:
> >>
> >> config ARCH_TANGO4
> >>         bool "Sigma Designs Tango4 (SMP87xx)"
> >>         default y
> > 
> > drop the default
> > 
> > add
> > 	depends on CPU_MULTI_V7
> 
> I've done this higher up.
> 
> menuconfig ARCH_TANGOX
> 	bool "Sigma Designs Tango" if ARCH_MULTI_V7
> 	help
> 	  something useful
> 
> if ARCH_TANGOX
> config ARCH_TANGO4
> ...
> endif
> 
> So 'default y' enables ARCH_TANGO4 only if ARCH_TANGOX is selected,
> right?

You should really only have one of the two.

> >>         select ARCH_HAS_HOLES_MEMORYMODEL
> >>         select ARM_ERRATA_754322
> >>         select ARM_ERRATA_764369
> > 
> > 	add 'if SMP'
> > 
> >>         select ARM_GIC
> >>         select CACHE_L2X0
> > 
> > remove CACHE_L2X0, we want to be able to turn this off.
> 
> Some people run with L2 disabled? That's a strange thing to do.

I can help for testing. Most importantly, we currently allow that
configuration today, and it's not up to you to forbid other platforms
from doing it.

If you can prove that we never need to disable that option, send
another patch to make it unconditional.

> >>         select CLKSRC_MMIO
> >>         select GENERIC_IRQ_CHIP
> >>         select HAVE_ARM_SCU
> >>         select HAVE_ARM_TWD
> > 
> > 	'if SMP'
> > 
> >>         select NEON
> >>         select SMP
> > 
> > These should be user-selectable as well, so drop the 'select'
> > and make sure the kernel builds with them turned off.
> 
> It will build, but it won't run! My port uses the TWD for clockevents,
> and smp_twd.c is only compiled if HAVE_ARM_TWD. So I must set SMP.

I think this has come up before and should be fixed. Could you
send a patch that allows using TWD in uniprocessor configurations?

> >> Didn't find much documentation on ARCH_HAS_HOLES_MEMORYMODEL.
> >> What is it used for?
> > 
> > You need this if the RAM is not physically contiguous, e.g. 256MB at one
> > address and another 256MB somewhere else.
> > 
> >> Is it OK to select CACHE_L2X0, NEON, and SMP?
> > 
> > no
> 
> Then I have a major problem... my port requires SMP.

That would be very unusual.

	Arnd
