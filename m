From: robherring2@gmail.com (Rob Herring)
Date: Tue, 14 Feb 2012 15:54:14 -0600
Subject: [PATCH 00/15] mach/io.h cleanup and removal
In-Reply-To: <201202142126.49849.arnd@arndb.de>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <4F3AB8FE.2060704@gmail.com> <20120214204339.GV1426@atomide.com>
 <201202142126.49849.arnd@arndb.de>
Message-ID: <4F3AD806.50402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2012 03:26 PM, Arnd Bergmann wrote:
> On Tuesday 14 February 2012, Tony Lindgren wrote:
>>> c) Don't allow mach includes in drivers and sound dirs for
>>> multi-platform kernels. This is already the case for any multi-arch
>>> driver. A lot of the headers are platform_data structs or things that
>>> should be cleaned up or need common infrastructure. Some cases I've
>>> found seem like the include is unnecessary. Also, just fixing up the
>>> name or path is no guarantee of avoiding namespace collisions.
>>
>> Out of the three options c) makes most sense for multi-subarch kernels.
>> And that avoids having to sort out the name collisions with defines.
> 
> I agree that this is the ideal, but as far as I can tell, we have a
> significant amount of functions that are defined in platform specific
> code but used in platform specific drivers. E.g. when you have a
> piece of code dealing with system management registers in your platform,
> that would be used in the cpufreq, irqchip, watchdog and more drivers.

>From my quick survey, those categories are really the exception. I would
guess platform_data structs is at least half of it. Older platforms seem
to be another big chunk.

Lack of a common usb phy infrastructure is another example of custom
platform functions (tegra usb_phy.h).

> There has to be some place where we can put function declarations
> for stuff like this, while at the same time we should try to minimise
> the amount that is required.
> 
>> For dealing with legacy platforms, I too would prefer b).
> 
> How about this:
> 
> * We stop providing arch/arm/{mach,plat}-*/include/ to C files
> outside of arch/arm/{mach,plat}-* when CONFIG_MULTIPLATFORM is
> enabled.
> 
> * Any symbol that is required to be visible in device drivers
> gets declared in arch/arm/include/mach-*/*.h, but we are very
> careful about adding only the absolute minimum here.

Why not include/linux? Any includes for drivers which are either
multiple arches (ahci_platform.h) or multiple ARM machines
(linux/amba/pl061.h) are already there. Every platform trying to dump
dozens of includes there would certainly get attention and force some
clean-up.

Rob
