From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 13 Aug 2010 12:13:09 +0200
Subject: [PATCH 1/3] ARM: mx27_defconfig: enable switches used in mx27 code
In-Reply-To: <1281515788-9989-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1281515788-9989-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100813101309.GA9135@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 10:36:26AM +0200, Uwe Kleine-K?nig wrote:
> - enable all mx27 machines (MACH_CPUIMX27, MACH_PCA100, MACH_MXT_TD60)
>   including optional features for CPUIMX27
> - eukrea_mbimx27-baseboard.c uses TOUCHSCREEN_ADS7846
> - mach-cpuimx27.c uses SERIAL_8250
> - several machines make use of SPI_IMX (selects SPI_BITBANG)
> - drop VGA_CONSOLE as this isn't selectable anymore since fb78b51cb11e
> - several machines make use of USB_ULPI (depends on USB, but don't
>   enable USB_DEVICE_CLASS as it's deprecated)
BTW, this commit breaks cpuimx27 and pca100 on top of linus/master

	  CC      arch/arm/mach-imx/mach-cpuimx27.o
	arch/arm/mach-imx/mach-cpuimx27.c: In function 'eukrea_cpuimx27_init':
	arch/arm/mach-imx/mach-cpuimx27.c:282: error: 'USB_OTG_DRV_VBUS' undeclared (first use in this function)
	arch/arm/mach-imx/mach-cpuimx27.c:282: error: (Each undeclared identifier is reported only once
	arch/arm/mach-imx/mach-cpuimx27.c:282: error: for each function it appears in.)
	arch/arm/mach-imx/mach-cpuimx27.c:282: error: 'USB_OTG_DRV_VBUS_EXT' undeclared (first use in this function)
	make[3]: *** [arch/arm/mach-imx/mach-cpuimx27.o] Error 1
	make[2]: *** [arch/arm/mach-imx/mach-cpuimx27.o] Error 2
	  CC      arch/arm/mach-imx/mach-pca100.o
	arch/arm/mach-imx/mach-pca100.c: In function 'pca100_init':
	arch/arm/mach-imx/mach-pca100.c:422: error: 'USB_OTG_DRV_VBUS' undeclared (first use in this function)
	arch/arm/mach-imx/mach-pca100.c:422: error: (Each undeclared identifier is reported only once
	arch/arm/mach-imx/mach-pca100.c:422: error: for each function it appears in.)
	arch/arm/mach-imx/mach-pca100.c:422: error: 'USB_OTG_DRV_VBUS_EXT' undeclared (first use in this function)
	make[3]: *** [arch/arm/mach-imx/mach-pca100.o] Error 1
	make[2]: *** [arch/arm/mach-imx/mach-pca100.o] Error 2

Bisecting this problem yields:
	
commit 13dd0c9767349b280cf131c34461f85e5effc42a
Author: Igor Grinberg <grinberg@compulab.co.il>
Date:   Thu Jul 15 16:00:16 2010 +0300

    USB: otg/ulpi: extend the generic ulpi driver.
    
    1) Introduce ulpi specific flags for control of the ulpi phy
    2) Extend the generic ulpi driver with support for Function and
    Interface control of upli phy
    3) Update the platforms using the generic ulpi driver with new ulpi
    flags
    4) Remove the otg control flags not in use
    
    Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
    Signed-off-by: Mike Rapoport <mike@compulab.co.il>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 arch/arm/mach-mx3/mach-armadillo5x0.c    |    4 +-
 arch/arm/mach-mx3/mach-mx31lilly.c       |    4 +-
 arch/arm/mach-mx3/mach-mx31lite.c        |    2 +-
 arch/arm/mach-mx3/mach-mx31moboard.c     |    2 +-
 arch/arm/mach-mx3/mach-pcm037.c          |    4 +-
 arch/arm/mach-mx3/mach-pcm043.c          |    2 +-
 arch/arm/mach-mx3/mx31moboard-smartbot.c |    2 +-
 drivers/usb/otg/ulpi.c                   |  127 +++++++++++++++++++++++++++---
 include/linux/usb/otg.h                  |    7 --
 include/linux/usb/ulpi.h                 |   39 +++++++++
 10 files changed, 166 insertions(+), 27 deletions(-)


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
