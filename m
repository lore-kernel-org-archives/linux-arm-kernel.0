From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Feb 2012 20:45:27 +0000
Subject: [PATCH 1/2] ARM: Add Kconfig option to use mkimage -T
 kernel_noload
In-Reply-To: <20120229203958.GQ14173@pengutronix.de>
References: <20120229181430.GI3318@game.jcrosoft.org>
 <4F4E6F96.8080907@am.sony.com> <20120229191209.GN14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2122@HQMAIL01.nvidia.com>
 <20120229194409.GO14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2155@HQMAIL01.nvidia.com>
 <4F4E86A1.8010506@bluewatersys.com>
 <20120229201938.GB16999@n2100.arm.linux.org.uk>
 <4F4E89A8.4080909@bluewatersys.com> <20120229203958.GQ14173@pengutronix.de>
Message-ID: <20120229204527.GD16999@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 09:39:58PM +0100, Uwe Kleine-K?nig wrote:
> I'd bet your platform has cache support in the decompressor without
> knowing which platform you use. I suggest commenting out
> 
> 	bl	cache_on
> 
> in arch/arm/boot/compressed/head.S to see the difference.
> 
> How do you build the uImage containing the zImage? If you use the
> in-kernel uImage target booting that usually means:
> 
> 	- move the zImage to ZRELADDR
> 	- jump into zImage
> 	- decompress zImage to somewhere else
> 	- move decompressed image to ZRELADDR
> 	- jump to ZRELADDR
> 
> That is you have two relocations because the first location for sure
> conflicts with the decompressed image.

Actually, we do this slightly differently nowadays.  Inside zImage:

	- if zImage location conflicts, move the decompressed data
	  and decompressor to another location
	- decompress zImage to ZRELADDR
	- jump to ZRELADDR

That reduces the size required for copying.  Of course, that copy can
(as it's always been the case) be totally eliminated by ensuring that
you load the zImage out of the way of the decompressed image.

So, really, comparing a standard uImage produced by the standard kernel
with gzipped Image is far from a fair comparison.  And that's actually
another argument for getting rid of the uImage target... it may make
people think a bit about what they're doing rather than accepting
whatever default location someone else chose for their kernel.
