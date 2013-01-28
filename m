From: rogerq@ti.com (Roger Quadros)
Date: Mon, 28 Jan 2013 13:30:23 +0200
Subject: [PATCH 22/30] ARM: OMAP: devkit8000: Adapt to ehci-omap changes
In-Reply-To: <1359372631-8180-1-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
Message-ID: <1359372631-8180-23-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform device for 'nop-usb-xceiv'. This will be used as a
PHY for HS USB Port 1, so provide binding information for it.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 051ec0d..f0fd75a 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -32,6 +32,7 @@
 
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
+#include <linux/usb/phy.h>
 #include "id.h"
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -429,22 +430,21 @@ static void __init omap_dm9000_init(void)
 	eth_addr[5] = (odi.id_0 & 0x000000ff);
 }
 
+/* PHY device on HS USB Port 1 i.e. nop_usb_xceiv.1 */
+static struct platform_device hsusb1_phy_device = {
+	.name = "nop_usb_xceiv",
+	.id = 1,
+};
+
 static struct platform_device *devkit8000_devices[] __initdata = {
 	&leds_gpio,
 	&keys_gpio,
 	&omap_dm9000_dev,
+	&hsusb1_phy_device,
 };
 
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
-
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
-	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
-	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
-
-	.phy_reset  = true,
-	.reset_gpio_port[0]  = -EINVAL,
-	.reset_gpio_port[1]  = -EINVAL,
-	.reset_gpio_port[2]  = -EINVAL
 };
 
 #ifdef CONFIG_OMAP_MUX
@@ -623,6 +623,10 @@ static void __init devkit8000_init(void)
 	omap_ads7846_init(2, OMAP3_DEVKIT_TS_GPIO, 0, NULL);
 
 	usb_musb_init(NULL);
+
+	/* PHY on HSUSB Port 1 i.e. index 0 */
+	usb_bind_phy("ehci-omap.0", 0, "nop_usb_xceiv.1");
+
 	usbhs_init(&usbhs_bdata);
 	board_nand_init(devkit8000_nand_partitions,
 			ARRAY_SIZE(devkit8000_nand_partitions), NAND_CS,
-- 
1.7.4.1
