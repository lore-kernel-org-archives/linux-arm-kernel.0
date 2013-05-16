From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 17 May 2013 01:41:59 +0400
Subject: [PATCH v2] ARM: shmobile: BOCK-W: add Ether support
Message-ID: <201305170141.59791.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register Ether device from bockw_init(), passing the platform data to it, adding
only the RMII pin group to bockw_pinctrl_map[].  Although the LINK signal exists
on the board, it's connected to the link/activity LED  output of the PHY, thus
the link disappears and reappears after each packet. We'd be better off ignoring
such signal and getting the link state from the PHY indirectly.

Also, Ether has pin conflict with VIN1, so the latter is not registered when the
'sh_eth' driver is enabled now.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is atop of Simon's 'renesas.git' repo, 'renesas-next-20130515v2' tag
and my recent yet unapplied patches.

Note that it's compile and run time dependent on the current Linus' tree. 

Changes from the original posting:
- refreshed the patch.

 arch/arm/mach-shmobile/board-bockw.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/mach-shmobile/board-bockw.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-bockw.c
+++ renesas/arch/arm/mach-shmobile/board-bockw.c
@@ -67,6 +67,20 @@ static struct sh_mobile_sdhi_info sdhi0_
 
 static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
 
+static struct sh_eth_plat_data ether_platform_data __initdata = {
+	.phy		= 0x01,
+	.edmac_endian	= EDMAC_LITTLE_ENDIAN,
+	.register_type	= SH_ETH_REG_FAST_RCAR,
+	.phy_interface	= PHY_INTERFACE_MODE_RMII,
+	/*
+	 * Although the LINK signal is available on the board, it's connected to
+	 * the link/activity LED output of the PHY, thus the link disappears and
+	 * reappears after each packet.  We'd be better off ignoring such signal
+	 * and getting the link state from the PHY indirectly.
+	 */
+	.no_ether_link	= 1,
+};
+
 static struct rcar_vin_platform_data vin_platform_data __initdata = {
 	.flags	= RCAR_VIN_BT656,
 };
@@ -87,6 +101,9 @@ BOCKW_CAMERA(0);
 BOCKW_CAMERA(1);
 
 static const struct pinctrl_map bockw_pinctrl_map[] = {
+	/* Ether */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7778",
+				  "ether_rmii", "ether"),
 	/* SCIF0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
 				  "scif0_data_a", "scif0"),
@@ -129,8 +146,11 @@ static void __init bockw_init(void)
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
 	r8a7778_add_usb_phy_device(&usb_phy_platform_data);
+	r8a7778_add_ether_device(&ether_platform_data);
 	r8a7778_add_vin_device(0, &vin_platform_data);
-	r8a7778_add_vin_device(1, &vin_platform_data);
+	/* VIN1 has a pin conflict with Ether */
+	if (!IS_ENABLED(CONFIG_SH_ETH))
+		r8a7778_add_vin_device(1, &vin_platform_data);
 	platform_device_register_data(&platform_bus, "soc-camera-pdrv", 0,
 				      &iclink0_ml86v7667,
 				      sizeof(iclink0_ml86v7667));
