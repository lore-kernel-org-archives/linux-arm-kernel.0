From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Wed, 20 Jan 2010 19:51:48 +0100
Subject: [PATCH] otg Kconfig: let USB_OTG_UTILS select USB_ULPI option
In-Reply-To: <20100120183450.GA30066@pengutronix.de>
References: <20100120183450.GA30066@pengutronix.de>
Message-ID: <1264013508-11247-1-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_USB_ULPI=y, CONFIG_USB<=m, CONFIG_PCI=n and
CONFIG_USB_OTG_UTILS=n, which is the default used for mx31moboard,
the build of all mx3 platform fails because drivers/usb/otg/ulpi.c
where otg_ulpi_create is defined is not compiled.

Build error:
arch/arm/mach-mx3/built-in.o: In function `mxc_board_init':
kzmarm11.c:(.init.text+0x73c): undefined reference to `otg_ulpi_create'
kzmarm11.c:(.init.text+0x1020): undefined reference to `otg_ulpi_create'

This isn't a strong dependency as drivers/usb/otg/ulpi.c doesn't
use functions defined in drivers/usb/otg/otg.o and is only needed
to get ulpi.o linked into the kernel image.

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 drivers/usb/otg/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index de56b3d..3d2d3e5 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -44,6 +44,7 @@ config ISP1301_OMAP
 config USB_ULPI
 	bool "Generic ULPI Transceiver Driver"
 	depends on ARM
+	select USB_OTG_UTILS
 	help
 	  Enable this to support ULPI connected USB OTG transceivers which
 	  are likely found on embedded boards.
-- 
1.6.3.3
