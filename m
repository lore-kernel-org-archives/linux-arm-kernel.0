From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 2 Jun 2013 02:40:55 +0400
Subject: [PATCH v3] ARM: shmobile: BOCK-W: add Ether support
Message-ID: <201306020240.55702.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register Ether device from bockw_init(), passing the platform data to it, adding
only the RMII pin group to bockw_pinctrl_map[].  Although the LINK signal exists
on the board, it's connected to the link/activity LED  output of the PHY, thus
the link disappears and reappears after each packet. We'd be better off ignoring
such signal and getting the link state from the PHY indirectly.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is atop of Simon's 'renesas.git' repo, 'renesas-next-20130528' tag
and the USB patches just reposted. I decided to move it ahead of the VIN patches
as it can be merged right now since all dependecies have been already met.

Changes from version 2:
- resolved rejects due to patch move;
- removed the code dealing with the pin conflict with VIN1 and the note related
  to it from the changelog.

Changes from the original posting:
- refreshed the patch.

 arch/arm/mach-shmobile/board-bockw.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Index: renesas/arch/arm/mach-shmobile/board-bockw.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-bockw.c
+++ renesas/arch/arm/mach-shmobile/board-bockw.c
@@ -65,7 +65,24 @@ static struct sh_mobile_sdhi_info sdhi0_
 
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
 static const struct pinctrl_map bockw_pinctrl_map[] = {
+	/* Ether */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7778",
+				  "ether_rmii", "ether"),
 	/* SCIF0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
 				  "scif0_data_a", "scif0"),
@@ -98,6 +115,7 @@ static void __init bockw_init(void)
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
 	r8a7778_add_usb_phy_device(&usb_phy_platform_data);
+	r8a7778_add_ether_device(&ether_platform_data);
 
 	pinctrl_register_mappings(bockw_pinctrl_map,
 				  ARRAY_SIZE(bockw_pinctrl_map));
