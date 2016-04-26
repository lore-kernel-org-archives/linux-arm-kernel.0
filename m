From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 13:59:57 +0200
Subject: [PATCH 0/3] ARM: nommu: R-class fixes
In-Reply-To: <571F49A2.3000706@arm.com>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
 <6943381.tLU1c7RclQ@wuerfel> <571F49A2.3000706@arm.com>
Message-ID: <5485255.0LNbKf2a8b@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 April 2016 11:57:38 Vladimir Murzin wrote:
> On 26/04/16 10:10, Arnd Bergmann wrote:
> > On Tuesday 26 April 2016 09:17:14 Vladimir Murzin wrote:

> > Turning it around would limit the platforms to the ones that
> > explictly turn on NOMMU support. In order to make ARMv7-R support
> > work, we need either another top-level platform option next to
> > ARCH_MULTIPLATFORM and ARM_SINGLE_ARMV7M, or add ARMv7-R in
> > the CPU selection phase as an alternative to ARMv4/5 and ARMv6/7-A.
> > 
> 
> It depends if we what NOMMU represented (apart from M-class) R-class
> only or R-class + A-class without MMU.

Exactly. The same is of course true for the older architectures:
There are tons of ARM7TDMI, ARM946, ARM1156 or Marvell Feroceon cores
without MMU, but we don't currently support any of them with an
upstream kernel. Respectively, we should in theory be able to
run on any of the other MMU based cores that we do support (ARM720T,
StrongARM, ARM92x, ARM1136/1176/MPCore, ...) with the MMU disabled,
but neither of the two scenarios seems interesting for mainline
kernels in this age any more.

What we know is that ARMv7-M is widely used, ARMv7-R makes a lot of
sense to use, and there are probably use cases for ARMv7-A without
MMU.

> >>> What hardware platform do you use? It would be nice to make it a little
> >>> more explicit which platforms can use the ARMv7-R, or an ARMv7-A with
> >>> the MMU disabled.
> >>
> >> Currently I'm dealing mostly with ARMv7-R FVP models which represents
> >> Vexpress with R-class tile (it is why this mini series have MPU
> >> patches). I've never tried ARMv7-A with the MMU disabled and I'm quite
> >> in doubt if it is feasible.
> > 
> > What is the difference? I always assumed that ARMv7-R and ARMv7-A are
> > sufficiently close that you can run the same kernel on both as long
> > as you use neither the MMU nor the MPU.
> 
> Right they are quite close and shares a lot of code except MMU and MPU,
> and I'd think without MMU/MPU such configurations are limited with UP
> only. I've not though of such option before, so I'd need to try and see.
> 
> On the other hand assumption that NOMMU == ARMv7-A - MMU, makes me think
> that any ARMv7 platform should be available for selection if CONFIG_MMU
> is deselected. At least such approach gives better build coverage and if
> there are platforms which suffer from such assumption runtime they can
> be guarded with COMPILE_TEST.

I think one problem is that with MMU disabled ARMv7-A, you implicitly
disable the caches and that is probably what you are thinking of for
SMP support as well (atomic instructions need caches).

However, this can be worked around using a static page table set up
at boot time that creates hugepage entries with appropriate flags for
RAM and I/O areas. If we ever had a usecase for running this setup
in production, we could even fake an MPU that way.

	Arnd
