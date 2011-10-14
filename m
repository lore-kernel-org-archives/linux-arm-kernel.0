From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 14 Oct 2011 14:07:57 -0400 (EDT)
Subject: [PATCH] ARM: mutually exclude ZBOOT_ROM and AUTO_ZRELADDR
In-Reply-To: <201110141829.48634.arnd@arndb.de>
References: <20111014071500.GP21648@n2100.arm.linux.org.uk>
	<1318607945-6807-1-git-send-email-olof@lixom.net>
	<201110141829.48634.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1110141405520.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Oct 2011, Arnd Bergmann wrote:

> On Friday 14 October 2011, Olof Johansson wrote:
> > This way platforms that want it can select AUTO_ZRELADDR without issues caused by
> > someone manually also enabling ZBOOT_ROM.
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 82973b2..2ad58e8 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1814,6 +1814,7 @@ config ZBOOT_ROM_BSS
> >  config ZBOOT_ROM
> >  	bool "Compressed boot loader in ROM/flash"
> >  	depends on ZBOOT_ROM_TEXT != ZBOOT_ROM_BSS
> > +	depends on !AUTO_ZRELADDR
> >  	help
> >  	  Say Y here if you intend to execute your compressed kernel image
> >  	  (zImage) directly from ROM or flash.  If unsure, say N.
> 
> Unfortunately, you cannot have it both ways:
> 
> arnd at ocdc-kvm:~/linux-arm$ make O=obj-tmp CROSS_COMPILE=arm-linux-gnueabi- ARCH=arm  -sj20  menuconfig
> arch/arm/Kconfig:1761:error: recursive dependency detected!
> arch/arm/Kconfig:1761:  symbol ZBOOT_ROM depends on AUTO_ZRELADDR

Ah, right.

OK, like I said I'm reworking the whole thing, so the cheapest fix for 
the time being  is "select AUTO_ZRELADDR if !ZBOOT_ROM".


Nicolas
