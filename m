From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 16 Apr 2010 13:28:05 -0500
Subject: [spi-devel-general] [PATCH v3 0/2] spi: driver for Cirrus
	EP93xx	SPI controller
In-Reply-To: <cover.1271156934.git.mika.westerberg@iki.fi>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
Message-ID: <0D753D10438DA54287A00B0270842697636D710785@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 13, 2010 7:10 AM, Mika Westerberg wrote:
> Hello,
> 
> This is third revision of the driver. Thanks to Martin Guy who tested and
> reviewed the code.
> 
> Changes since v2:
> 	- corrected spi clock rate calculation
> 	- interrupt handling is now more efficient
> 	- driver now supports polling mode as well, this can be selected with
> 	  'transfer_method' module parameter.
> 	- controller is disabled in probe function
> 	- some cosmetic changes
> 
> I have been testing this on my TS-7260 board (ep9302 based) with mmc_spi and
> at25 drivers.
> 
> Note that patch 2/2 depends on patch that is already in Russell's patch
> tracking system:
> 	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5998/1
> 

Hello Mika,

I finally was able to get this working on my system.  Not sure what the issue
was earlier.

The only thing I don't like right off hand is the chip select handling.

The way it currently is done you are limited to using only the built-in GPIO's
of the EP93xx.  This prohibits a system from using an external i2c/spi/etc.
gpio expander to provide more chip selects.  And if a platform is not setup
correctly, the BUG_ON in cs_to_gpio in your example for the tx72xx is pretty
nasty.

Ryan and I worked out a runtime setup/cleanup for the spi device chip selects
in the spi driver I have in my tree.  I will take a look at it and see how
much trouble it will be to implement in your driver.

Anyway, now that I have your driver functioning I will be able to actually
provide some feedback to you.

Regards,
Hartley
