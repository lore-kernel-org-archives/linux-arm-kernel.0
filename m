From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 20:12:07 +0200
Subject: [PATCH 0/3] ARM: nommu: R-class fixes
In-Reply-To: <571F5E06.7040406@arm.com>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
 <5485255.0LNbKf2a8b@wuerfel> <571F5E06.7040406@arm.com>
Message-ID: <5591261.0X3WRSsdGl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 April 2016 13:24:38 Vladimir Murzin wrote:
> On 26/04/16 12:59, Arnd Bergmann wrote:
> > On Tuesday 26 April 2016 11:57:38 Vladimir Murzin wrote:
> >> On 26/04/16 10:10, Arnd Bergmann wrote:
> >>>>> What hardware platform do you use? It would be nice to make it a little
> >>>>> more explicit which platforms can use the ARMv7-R, or an ARMv7-A with
> >>>>> the MMU disabled.
> >>>>
> >>>> Currently I'm dealing mostly with ARMv7-R FVP models which represents
> >>>> Vexpress with R-class tile (it is why this mini series have MPU
> >>>> patches). I've never tried ARMv7-A with the MMU disabled and I'm quite
> >>>> in doubt if it is feasible.
> >>>
> >>> What is the difference? I always assumed that ARMv7-R and ARMv7-A are
> >>> sufficiently close that you can run the same kernel on both as long
> >>> as you use neither the MMU nor the MPU.
> >>
> >> Right they are quite close and shares a lot of code except MMU and MPU,
> >> and I'd think without MMU/MPU such configurations are limited with UP
> >> only. I've not though of such option before, so I'd need to try and see.
> >>
> >> On the other hand assumption that NOMMU == ARMv7-A - MMU, makes me think
> >> that any ARMv7 platform should be available for selection if CONFIG_MMU
> >> is deselected. At least such approach gives better build coverage and if
> >> there are platforms which suffer from such assumption runtime they can
> >> be guarded with COMPILE_TEST.
> > 
> > I think one problem is that with MMU disabled ARMv7-A, you implicitly
> > disable the caches and that is probably what you are thinking of for
> > SMP support as well (atomic instructions need caches).
> 
> Another problem is that we need to provide DRAM_BASE and DRAM_SIZE for
> such builds, but it can be addressed with 1:1 mappings you've described
> below

But that's not any different between ARMv7-A and ARMv7-R, right?

> > However, this can be worked around using a static page table set up
> > at boot time that creates hugepage entries with appropriate flags for
> > RAM and I/O areas. If we ever had a usecase for running this setup
> > in production, we could even fake an MPU that way.
> 
> I'd think that support for FDPIC would make it one step closer.

Yes, that would be very useful.

> I conclude that we don't want dedicated option for R-class cores and we
> start from assumption that NOMMU covers: M-, R- and A- (without MMU or
> 1:1 mapping) cores. Please, correct me.

I'm still undecided on that. On the one hand it would be nice to support
building a kernel that can run on both ARMv7-A and ARMv7-R, especially
when you are talking about pluggable CPU modules on the same baseboard
in case of RealView and Versatile Express.

On the other hand, separating the two has the advantage of keeping it
simple, as we don't have to worry about all the ARMv7-A platforms
and whether we actually want to allow their kernels to be built with
MMU disabled.

	Arnd
