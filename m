From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 12 Mar 2012 18:42:59 +0100
Subject: [PATCH 1/2] ARM: Add Kconfig option to use mkimage -T
 kernel_noload
In-Reply-To: <20120229205901.GR14173@pengutronix.de>
References: <4F4E6F96.8080907@am.sony.com>
 <20120229204527.GD16999@n2100.arm.linux.org.uk>
 <20120229205901.GR14173@pengutronix.de>
Message-ID: <201203121843.00025.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Uwe Kleine-K?nig,

> On Wed, Feb 29, 2012 at 08:45:27PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Feb 29, 2012 at 09:39:58PM +0100, Uwe Kleine-K?nig wrote:
> > > I'd bet your platform has cache support in the decompressor without
> > > knowing which platform you use. I suggest commenting out
> > > 
> > > 	bl	cache_on
> > > 
> > > in arch/arm/boot/compressed/head.S to see the difference.
> > > 
> > > How do you build the uImage containing the zImage? If you use the
> > > 
> > > in-kernel uImage target booting that usually means:
> > > 	- move the zImage to ZRELADDR
> > > 	- jump into zImage
> > > 	- decompress zImage to somewhere else
> > > 	- move decompressed image to ZRELADDR
> > > 	- jump to ZRELADDR
> > > 
> > > That is you have two relocations because the first location for sure
> > > conflicts with the decompressed image.
> > 
> > Actually, we do this slightly differently nowadays.  Inside zImage:
> > 	- if zImage location conflicts, move the decompressed data
> 
> s/de//
> 
> > 	  and decompressor to another location
> > 	
> > 	- decompress zImage to ZRELADDR
> > 	- jump to ZRELADDR
> > 
> > That reduces the size required for copying.  Of course, that copy can
> > (as it's always been the case) be totally eliminated by ensuring that
> > you load the zImage out of the way of the decompressed image.
> > 
> > So, really, comparing a standard uImage produced by the standard kernel
> > with gzipped Image is far from a fair comparison.  And that's actually
> > another argument for getting rid of the uImage target... it may make
> > people think a bit about what they're doing rather than accepting
> > whatever default location someone else chose for their kernel.
> 
> I'm all in favour to remove the uImage target because back in 2007 we
> already had a similar discussion[1]. (Back then I still thought that
> improving the uImage support would be a good idea.)
> 
> That said I think *in general* having support for U-Boot in the kernel
> is fine because I think U-Boot is the bootloader used most. But if you
> need some Kconfig settings or more than one Makefile target I think just
> building an Image or zImage and doing the U-Boot wrapping without the
> help of Linux' build system is preferable.

I believe eventually everyone will converge to having this option enabled. 
Therefore this config option will just be always on and can be squashed away.

> 
> Best regards
> Uwe
> 
> [1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/36547/focus=36588

Best regards,
Marek Vasut
