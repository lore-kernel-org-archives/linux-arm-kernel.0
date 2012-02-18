From: notasas@gmail.com (Grazvydas Ignotas)
Date: Sun, 19 Feb 2012 00:43:05 +0200
Subject: [PATCH] ARM: omap: pandora: fix usbhs platform data
Message-ID: <1329604985-24740-1-git-send-email-notasas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turned out wrong OMAP HSUSB port was configured on pandora,
but still managed to work somehow. This was noticed after enabling
in-kernel mux, where USB muxing was causing other devices not to work,
because hsusb1 pins (instead of hsusb2) were wrongly remuxed, which
are used for other things on pandora.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 1644b73..2224b5d 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -343,7 +343,7 @@ static struct regulator_consumer_supply pandora_vcc_lcd_supply[] = {
 };
 
 static struct regulator_consumer_supply pandora_usb_phy_supply[] = {
-	REGULATOR_SUPPLY("hsusb0", "ehci-omap.0"),
+	REGULATOR_SUPPLY("hsusb1", "ehci-omap.0"),
 };
 
 /* ads7846 on SPI and 2 nub controllers on I2C */
@@ -561,13 +561,13 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 
-	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
-	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[0] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
 	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
 	.phy_reset  = true,
-	.reset_gpio_port[0]  = 16,
-	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[0]  = -EINVAL,
+	.reset_gpio_port[1]  = 16,
 	.reset_gpio_port[2]  = -EINVAL
 };
 
-- 
1.7.0.4
