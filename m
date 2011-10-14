From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 14 Oct 2011 13:53:13 -0400 (EDT)
Subject: [PATCH] arm/tegra: select AUTO_ZRELADDR by default
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173BE1A283@HQMAIL01.nvidia.com>
References: <1317172068-14872-1-git-send-email-pdeschrijver@nvidia.com>
	<20111014071500.GP21648@n2100.arm.linux.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF173BE1A260@HQMAIL01.nvidia.com>
	<201110141729.41515.arnd@arndb.de>
	<74CDBE0F657A3D45AFBB94109FB122FF173BE1A283@HQMAIL01.nvidia.com>
Message-ID: <alpine.LFD.2.02.1110141348270.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Oct 2011, Stephen Warren wrote:

> Arnd Bergmann wrote at Friday, October 14, 2011 9:30 AM:
> ...
> > You mention that tegra30 will require AUTO_ZRELADDR.
> 
> Well, just to be clear, here's the situation I think:
> 
> Tegra20's SDRAM starts at physical address 0.
> 
> Tegra30's SDRAM starts at physical address 2G.
> 
> To support that, we could either:
> 
> a) Introduce a new Kconfig variable for Tegra30, make T20/T30 mutually
> exclusive, and update arch/arm/mach-tegra/Makefile.boot to set zreladdr
> etc. based on the new Tegra30 config variable too. Then, there's no need
> for AUTO_ZRELADDR anywhere.
> 
> b) Have no new config variable, build a unified T20/T30 kernel, leave
> Makefile.boot untouched, and rely on using AUTO_ZRELADDR for Tegra30 to
> account for the different SDRAM physical addresses.

As I explained yesterday, I'm working on more cleanups that involve
reworking the dependencies around ZBOOTROM, AUTO_ZRELADDR and friends, 
and removing zreladdr for all platforms.  So please do not come up with 
Tegra specific hacks to fix this up.  So for the time being I'd simply 
suggest using the minimal fix i.e.:

	select AUTO_ZRELADDR if !ZBOOT_ROM

And eventually this will disappear entirely in favor of a single global 
config option which is not platform dependent.


Nicolas
