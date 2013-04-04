From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 5 Apr 2013 03:10:38 +0400
Subject: [PATCH 7/8] ARM: shmobile: Marzen: pass platform data to USB PHY
 device
Message-ID: <201304050310.39289.sergei.shtylyov@cogentembedded.com>
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

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/board-marzen.c         |    5 +++++
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 ++
 arch/arm/mach-shmobile/setup-r8a7779.c        |   16 ++++++++--------
 3 files changed, 15 insertions(+), 8 deletions(-)

Index: renesas/arch/arm/mach-shmobile/board-marzen.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-marzen.c
+++ renesas/arch/arm/mach-shmobile/board-marzen.c
@@ -56,6 +56,10 @@ static struct regulator_consumer_supply 
 	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
 };
 
+static struct rcar_phy_platform_data usb_phy_platform_data = {
+	.usbpctrl0	= 0,
+};
+
 /* SMSC LAN89218 */
 static struct resource smsc911x_resources[] = {
 	[0] = {
@@ -230,6 +234,7 @@ static void __init marzen_init(void)
 	r8a7779_pinmux_init();
 
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
+#include <linux/usb/rcar-phy.h>
 
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
@@ -407,13 +407,6 @@ static struct resource usb_phy_resources
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
 
@@ -586,7 +579,6 @@ static struct platform_device *r8a7779_d
 	&scif5_device,
 	&tmu00_device,
 	&tmu01_device,
-	&usb_phy_device,
 };
 
 static struct platform_device *r8a7779_standard_devices[] __initdata = {
@@ -621,6 +613,14 @@ void __init r8a7779_add_ether_device(str
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
 
