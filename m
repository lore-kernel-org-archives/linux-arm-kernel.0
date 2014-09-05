From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 5 Sep 2014 15:22:46 +0100
Subject: [PATCH v2 1/4] arm64, thunder: Add Kconfig option for Cavium
 Thunder SoC Family
In-Reply-To: <7863371.EMkUuntQWU@wuerfel>
References: <1409903205-2762-1-git-send-email-rric@kernel.org>
 <20140905110552.GH30401@n2100.arm.linux.org.uk>
 <20140905125147.GC20164@leverpostej> <7863371.EMkUuntQWU@wuerfel>
Message-ID: <20140905142245.GG20164@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[...]

> A common pattern these days is to do dependencies like
> 
> arch/*/Kconfig:
> 	config ARCH_FOO
> 	bool "Enable support for Foo platform"
> 	help
> 	  ...
> 
> 
> drivers/*/Kconfig
> 	config SUBSYS_FOO
> 	bool "SUBSYS driver for Foo"
> 	depends on ARCH_FOO || COMPILE_TEST
> 	depends on OF && REGULATOR && GENERIC_PHY # or whatever

Russell's comments w.r.t. Kconfig warnings when config names change
still holds regardless of select vs depends on.

> That way we can enable everything in the defconfig, but someone
> who likes to build a more specialized kernel can disable the
> other platforms and won't get the drivers that are specific to
> those.
> 
> I personally think this is a bit more verbose than what we need, but
> I don't strongly object doing it that way.

You'd still be able to do this without ARCH_FOO, though you would need
to know which drivers are necessary for a particular SoC. That seems to
be the way things are handled on x86; I don't recall having to select
support for specific machines there, just the individual drivers.

> The code size really should not matter much on ARM64 though: it's
> unlikely we will see a lot of systems with less than a few gigabytes
> of memory, and I expect that a generic kernel would be e.g. 6 MB
> instead of 4 MB for a platform specific kernel.

Agreed. If there kernel size begins looking unwieldy we either need to
be compiling more things as modules or a more drastic kernel weight loss
program.

Mark.
