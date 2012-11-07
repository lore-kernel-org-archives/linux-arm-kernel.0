From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Nov 2012 12:59:14 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <20121106221437.GQ28327@n2100.arm.linux.org.uk>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <201211062114.49933.arnd@arndb.de>
 <20121106221437.GQ28327@n2100.arm.linux.org.uk>
Message-ID: <201211071259.15107.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 November 2012, Russell King - ARM Linux wrote:
> On Tue, Nov 06, 2012 at 09:14:49PM +0000, Arnd Bergmann wrote:
> > The other point is being able to build such a kernel, and this is what Will
> > seems to be interested in more. We have made VEXPRESS depend on
> > MULTIPLATFORM, which broke support for building a non-MMU vexpress kernel,
> > and I think we should fix that. The two options are either to make
> > vexpress be single-platform when building for !MMU, or to allow multiplatform
> > kernels to be built without MMU support in principle. I think the second
> > option is more logical and avoids complex Kconfig constructs.
> 
> The other thing here is... why does a platform which _was_ able to be
> built in isolation from every other platform suddenly become incapable
> of being so when they join the multiplatform conglomerate?  This just
> sounds totally perverse and wrong.
> 
> Surely it should be: platforms _not_ yet converted to multiplatform
> can't be selected with multi-platform support enabled?
> 
> So, maybe the _proper_ solution here is:
> 
> - change the big choice to be: config SINGLE_xxx
>   - these select config MACH_FOO / PLAT_FOO / ARCH_FOO
>   eg,
> 	config SINGLE_FOO
> 		bool "Support for foo platforms in single kernel"
> 		select MACH_FOO
> - add a final option: config MULTIPLATFORM
> - then add:
> 
> config MULTI_FOO
> 	bool "Include support for foo platforms"
> 	select MACH_FOO
> 	depends on MULTIPLATFORM || !MMU
> ...
> 
> config MACH_FOO
> 	bool

A few platforms are doing this. E.g. the vt8500 platform currently
allows both, and the at91 will only allow multiplatform to be selected
for the DT-aware systems, while the single-platform still allows both
DT and non-DT. In general, I'm fine with either approach (multiplatform
only or mixed) and I'd like to leave that choice to the platform
maintainers.

> Now, we don't _have_ to have the single and multi variants if they aren't
> appropriate for the platform, but we can cover all the cases: a platform
> where it's part of the multi-platform kernel when built for MMU, but is
> incapable of being a multi-platform kernel when built without MMU.
>
> And we can do it without _too_ much Kconfig pain, and certainly without
> having to delve into anything beyond arch/arm/Kconfig.

Sure, that works. My point was just that I think it would be simpler
to keep vexpress multiplatform-only if there are no reasons that prevent
us from doing that.

I also hope that we can at some point in the future get all ARMv6 and ARMv7
platforms to be multiplatform-only, while leaving each ARMv4/ARMv5 to be
any of single, multi, or mixed.

> I'd suggest at that point we separate out this stuff into a separate
> file - arch/arm/Kconfig.mach, which contains all the platform selection
> stuff.

Good idea, I like that.

	Arnd
