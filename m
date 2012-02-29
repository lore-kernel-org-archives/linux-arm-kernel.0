From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Feb 2012 21:30:56 +0100
Subject: [PATCH 1/2] ARM: Add Kconfig option to use mkimage -T
 kernel_noload
In-Reply-To: <4F4E86A1.8010506@bluewatersys.com>
References: <1330473804-23348-1-git-send-email-swarren@nvidia.com>
 <20120229122942.GF3318@game.jcrosoft.org>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF206A@HQMAIL01.nvidia.com>
 <20120229181430.GI3318@game.jcrosoft.org>
 <4F4E6F96.8080907@am.sony.com>
 <20120229191209.GN14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2122@HQMAIL01.nvidia.com>
 <20120229194409.GO14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2155@HQMAIL01.nvidia.com>
 <4F4E86A1.8010506@bluewatersys.com>
Message-ID: <20120229203056.GP14173@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 09:12:17AM +1300, Andre Renaud wrote:
> On 01/03/12 08:59, Stephen Warren wrote:
> > Uwe Kleine-K?nig wrote at Wednesday, February 29, 2012 12:44 PM:
> > ...
> >> If you want to give incentive for U-Boot to improve, drop the target
> >> today. And note that at least people caring about boot time must not use
> >> the kernel's uImage target anyhow.
> > 
> > If you enable the new config option in this patch, then the performance
> > issue is solved; U-Boot doesn't copy the kernel image any more, and the
> > kernel decompressor can write directly to the appropriate location without
> > moving the image first (assuming your board boot script loads the uImage
> > to a non-conflicting address).
> 
> I may have missed part of this, but isn't one of the points regarding
> this that the zImage decompressor always runs with data cache disabled,
> resulting in a slow decompress, where as if the U-Boot decompressor is
> used (ie, gzipping the Image, and telling U-Boot to decompress), then it
> can run with caches enabled, improving boot speed?
This is wrong. The zImage decompressor runs with caches on. The
advantage that U-Boot (maybe) has when doing the decompression itself is
that the cache for reading the zImage is already hot when U-Boot copied it
from NAND to RAM first. (I don't know if U-Boot can decompress directly
from NAND without writing the Image to RAM first?!)

> Thus the relocation issue is not really the speed hit, rather it is the
> image decompression.
I'm sure that letting U-Boot decompress an image that first has to be
moved to prevent it being overwritten during decompression is slower
than jumping into zImage if the image isn't relocated.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
