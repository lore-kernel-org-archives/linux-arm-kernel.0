From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Feb 2012 22:38:33 +0000
Subject: [PATCH 00/15] mach/io.h cleanup and removal
In-Reply-To: <4F3AD806.50402@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <201202142126.49849.arnd@arndb.de> <4F3AD806.50402@gmail.com>
Message-ID: <201202142238.33697.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 February 2012, Rob Herring wrote:
> > I agree that this is the ideal, but as far as I can tell, we have a
> > significant amount of functions that are defined in platform specific
> > code but used in platform specific drivers. E.g. when you have a
> > piece of code dealing with system management registers in your platform,
> > that would be used in the cpufreq, irqchip, watchdog and more drivers.
> 
> From my quick survey, those categories are really the exception. I would
> guess platform_data structs is at least half of it. Older platforms seem
> to be another big chunk.

Good to hear. We can certainly take care of the platform data by moving
it to include/linux/platform_data/*.h and the older platforms can
usually keep exporting their header files because we won't get them
to build into the same kernel with other platforms.

> Lack of a common usb phy infrastructure is another example of custom
> platform functions (tegra usb_phy.h).

Good point.

> > * Any symbol that is required to be visible in device drivers
> > gets declared in arch/arm/include/mach-*/*.h, but we are very
> > careful about adding only the absolute minimum here.
> 
> Why not include/linux? Any includes for drivers which are either
> multiple arches (ahci_platform.h) or multiple ARM machines
> (linux/amba/pl061.h) are already there. Every platform trying to dump
> dozens of includes there would certainly get attention and force some
> clean-up.

I strongly believe that any header file should be as localized as possible:

a) no header, all declarations in the one file using it
b) header file in local directory
c) header file in per-platform directory
d) header file in per-architecture directory
e) global header file

We need to get rid of category c in order to make cross-platform kernels
work. Ideally we would move everything into categories a and b, which is
often possible, but for those cases where it doesn't work the logical step
is to have it in arch specific code, not global.

	Arnd
