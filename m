From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Feb 2012 21:59:01 +0100
Subject: [PATCH 1/2] ARM: Add Kconfig option to use mkimage -T
 kernel_noload
In-Reply-To: <20120229204527.GD16999@n2100.arm.linux.org.uk>
References: <4F4E6F96.8080907@am.sony.com>
 <20120229191209.GN14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2122@HQMAIL01.nvidia.com>
 <20120229194409.GO14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2155@HQMAIL01.nvidia.com>
 <4F4E86A1.8010506@bluewatersys.com>
 <20120229201938.GB16999@n2100.arm.linux.org.uk>
 <4F4E89A8.4080909@bluewatersys.com>
 <20120229203958.GQ14173@pengutronix.de>
 <20120229204527.GD16999@n2100.arm.linux.org.uk>
Message-ID: <20120229205901.GR14173@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 08:45:27PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 29, 2012 at 09:39:58PM +0100, Uwe Kleine-K?nig wrote:
> > I'd bet your platform has cache support in the decompressor without
> > knowing which platform you use. I suggest commenting out
> > 
> > 	bl	cache_on
> > 
> > in arch/arm/boot/compressed/head.S to see the difference.
> > 
> > How do you build the uImage containing the zImage? If you use the
> > in-kernel uImage target booting that usually means:
> > 
> > 	- move the zImage to ZRELADDR
> > 	- jump into zImage
> > 	- decompress zImage to somewhere else
> > 	- move decompressed image to ZRELADDR
> > 	- jump to ZRELADDR
> > 
> > That is you have two relocations because the first location for sure
> > conflicts with the decompressed image.
> 
> Actually, we do this slightly differently nowadays.  Inside zImage:
> 
> 	- if zImage location conflicts, move the decompressed data
s/de//

> 	  and decompressor to another location
> 	- decompress zImage to ZRELADDR
> 	- jump to ZRELADDR
> 
> That reduces the size required for copying.  Of course, that copy can
> (as it's always been the case) be totally eliminated by ensuring that
> you load the zImage out of the way of the decompressed image.
> 
> So, really, comparing a standard uImage produced by the standard kernel
> with gzipped Image is far from a fair comparison.  And that's actually
> another argument for getting rid of the uImage target... it may make
> people think a bit about what they're doing rather than accepting
> whatever default location someone else chose for their kernel.
I'm all in favour to remove the uImage target because back in 2007 we
already had a similar discussion[1]. (Back then I still thought that
improving the uImage support would be a good idea.)

That said I think *in general* having support for U-Boot in the kernel
is fine because I think U-Boot is the bootloader used most. But if you
need some Kconfig settings or more than one Makefile target I think just
building an Image or zImage and doing the U-Boot wrapping without the
help of Linux' build system is preferable.

Best regards
Uwe

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/36547/focus=36588

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
