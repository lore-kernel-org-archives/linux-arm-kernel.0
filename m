From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 2 Jun 2013 01:55:04 +0400
Subject: [PATCH v8 8/9] ARM: shmobile: Marzen: pass platform data to USB PHY
 device
In-Reply-To: <201306020128.05914.sergei.shtylyov@cogentembedded.com>
References: <201306020128.05914.sergei.shtylyov@cogentembedded.com>
Message-ID: <201306020155.04976.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we're now going to setup the USBPCTRL0 register using the USB PHY device's
platform data, we now need a way to pass those platform data from the board file
to the device which is situated in setup-r8a7779.c -- and what I'm suggesting is
r8a7779_add_usb_phy_device() that will register USB PHY platform device with the
passed platform data using platform_device_register_resndata() call; creating
this function involves deletion of 'usb_phy_device' from r8a7779_devices_dt[],
so that it will no longer be registered for the generic R8A7779 machine (where
we can't provide the platform data anyway), hence EHCI/OHCI drivers will fail
to load as well.

For the Marzen board, this new function will be called from marzen_init() to
register the USB PHY device early enough.

Note that the board and the SoC code have to be in one patch to keep the code
bisectable...

The patch has been tested on the Marzen board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>

---
Changes since version 6:
- renamed the R-Car PHY driver header file in #include.

Changes since version 5:
- annotated USB PHY resources and platform data as '__initdata' since they're
  kmemdup()'ed while registering the platform device anyway;
- fixed typo in the changelog.

Changes since version 4:
- refreshed the patch.

Changes since version 3:
- removed the initializer for 'usb_phy_platform_data';
- refreshed the 'board-marzen.c' file.

Changes since version 2:
- refreshed atop of the prior patches;
- added a note about testing to the changelog;
- added ACKs from Simon Horman and Kuninori Morimoto.

Changes since the original posting:
- added a note about bisectability to the changelog.

 arch/arm/mach-shmobile/board-marzen.c         |    3 +++
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 ++
 arch/arm/mach-shmobile/setup-r8a7779.c        |   18 +++++++++---------
 3 files changed, 14 insertions(+), 9 deletions(-)

Index: renesas/arch/arm/mach-shmobile/board-marzen.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-marzen.c
+++ renesas/arch/arm/mach-shmobile/board-marzen.c
@@ -57,6 +57,8 @@ static struct regulator_consumer_supply 
 	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
 };
 
+static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
+
 /* SMSC LAN89218 */
 static struct resource smsc911x_resources[] = {
 	[0] = {
@@ -232,6 +234,7 @@ static void __init marzen_init(void)
 	r8a7779_init_irq_extpin(1); /* IRQ1 as individual interrupt */
 
 	r8a7779_add_standard_devices();
+	r8a7779_add_usb_phy_device(&usb_phy_platform_data);
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 }
 
Index: renesas/arch/arm/mach-shmobile/include/mach/r8a7779.h
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ renesas/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -4,6 +4,7 @@
 #include <linux/sh_clk.h>
 #include <linux/pm_domain.h>
 #include <linux/sh_eth.h>
+#include <linux/platform_data/usb-rcar-phy.h>
 
 struct platform_device;
 
@@ -33,6 +34,7 @@ extern void r8a7779_add_early_devices(vo
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_add_standard_devices_dt(void);
 extern void r8a7779_add_ether_device(struct sh_eth_plat_data *pdata);
+extern void r8a7779_add_usb_phy_device(struct rcar_phy_platform_data *pdata);
 extern void r8a7779_init_late(void);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -389,7 +389,7 @@ static struct platform_device sata_devic
 };
 
 /* USB PHY */
-static struct resource usb_phy_resources[] = {
+static struct resource usb_phy_resources[] __initdata = {
 	[0] = {
 		.start		= 0xffe70800,
 		.end		= 0xffe70900 - 1,
@@ -397,13 +397,6 @@ static struct resource usb_phy_resources
 	},
 };
 
-static struct platform_device usb_phy_device = {
-	.name		= "rcar_usb_phy",
-	.id		= -1,
-	.resource	= usb_phy_resources,
-	.num_resources	= ARRAY_SIZE(usb_phy_resources),
-};
-
 /* USB */
 static struct usb_phy *phy;
 
@@ -575,7 +568,6 @@ static struct platform_device *r8a7779_d
 	&scif5_device,
 	&tmu00_device,
 	&tmu01_device,
-	&usb_phy_device,
 };
 
 static struct platform_device *r8a7779_standard_devices[] __initdata = {
@@ -610,6 +602,14 @@ void __init r8a7779_add_ether_device(str
 					  pdata, sizeof(*pdata));
 }
 
+void __init r8a7779_add_usb_phy_device(struct rcar_phy_platform_data *pdata)
+{
+	platform_device_register_resndata(&platform_bus, "rcar_usb_phy", -1,
+					  usb_phy_resources,
+					  ARRAY_SIZE(usb_phy_resources),
+					  pdata, sizeof(*pdata));
+}
+
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
 void __init __weak r8a7779_register_twd(void) { }
 
