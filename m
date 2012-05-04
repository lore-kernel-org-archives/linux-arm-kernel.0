From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 19:57:14 +0000
Subject: [PATCH 00/02] mach-shmobile: Emma Mobile EV2 - first shot
In-Reply-To: <20120503144645.6390.62303.sendpatchset@w520>
References: <20120503144645.6390.62303.sendpatchset@w520>
Message-ID: <201205041957.14205.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 May 2012, Magnus Damm wrote:
> mach-shmobile: Emma Mobile EV2 - first shot
> 
> [PATCH 01/02] mach-shmobile: Emma Mobile EV2 SoC base support
> [PATCH 02/02] mach-shmobile: KZM9D board prototype support
> 
> This series adds experimental Emma Mobile EV2 support to
> mach-shmobile. Yet another dual core Cortex-A9 SoC.
> 
> At this point only serial and timer is supported. Future work
> includes GPIO, network device, SMP and DT support. If possible
> it would be nice to use the common clocks on this platform.
> 
> To boot this on actual hardware you also need the following:
> "[PATCH] serial8250-em: Emma Mobile UART driver V2"
> "[PATCH] clocksource: em_sti: Emma Mobile STI driver"
> 
> Any reason to not put this in mach-shmobile?

Well, from all I can tell it shares basically zero code with the
rest of mach-shmobile, so I would be more comfortable with creating
a new mach-emma directory for this.

Clearly you have an interest in building it into the same kernel
as the shmobile/rmobile platforms, but there seems to be little
technical reason to keep them together. Since we are still missing
a bit of infrastructure to actually build multiple platform
directories together, how about doing this similar to some of
the mach-s3c24* directories:?

You can have a single Kconfig entry for shmobile and emma, but
leave the code in separate directories, and just refer to the
arch/arm/mach-shmobile/include/mach/ directory for the global
headers (they are obviously identical right now). The additions
to mach/common.h can easily become a local header file instead
of getting listed in mach/*.h. I believe you don't actually need
the other headers you currently include (mach/hardware.h, mach/irqs.h),
so it would be completely standalone aside from the header files
that are required for building, and it can still be built
together with shmobile.

	Arnd
