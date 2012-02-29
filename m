From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Feb 2012 21:39:58 +0100
Subject: [PATCH 1/2] ARM: Add Kconfig option to use mkimage -T
 kernel_noload
In-Reply-To: <4F4E89A8.4080909@bluewatersys.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF17BDDF206A@HQMAIL01.nvidia.com>
 <20120229181430.GI3318@game.jcrosoft.org>
 <4F4E6F96.8080907@am.sony.com>
 <20120229191209.GN14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2122@HQMAIL01.nvidia.com>
 <20120229194409.GO14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2155@HQMAIL01.nvidia.com>
 <4F4E86A1.8010506@bluewatersys.com>
 <20120229201938.GB16999@n2100.arm.linux.org.uk>
 <4F4E89A8.4080909@bluewatersys.com>
Message-ID: <20120229203958.GQ14173@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 09:25:12AM +1300, Andre Renaud wrote:
> Hi Russell,
> >> I may have missed part of this, but isn't one of the points regarding
> >> this that the zImage decompressor always runs with data cache disabled,
> > 
> > Most certainly not.  We've had the data cache enabled for years and
> > years.  And I mean 10+ years.  We may have been lacking support on
> > some CPUs, but that was because of lack of contributions.
> > 
> >> resulting in a slow decompress, where as if the U-Boot decompressor is
> >> used (ie, gzipping the Image, and telling U-Boot to decompress), then it
> >> can run with caches enabled, improving boot speed?
> > 
> > That's pure FUD.
> 
> I don't want to open a can of worms on this, and I certainly haven't
> looked into the image decompressor within the Linux kernel, but from a
> boot speed point of view we certainly see a significant speed
> improvement switching from zImage to gzipped-Image. Do you know which
> platforms include the data-cache support in the decompressor?
I'd bet your platform has cache support in the decompressor without
knowing which platform you use. I suggest commenting out

	bl	cache_on

in arch/arm/boot/compressed/head.S to see the difference.

How do you build the uImage containing the zImage? If you use the
in-kernel uImage target booting that usually means:

	- move the zImage to ZRELADDR
	- jump into zImage
	- decompress zImage to somewhere else
	- move decompressed image to ZRELADDR
	- jump to ZRELADDR

That is you have two relocations because the first location for sure
conflicts with the decompressed image.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
