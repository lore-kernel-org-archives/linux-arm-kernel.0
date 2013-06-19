From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 19 Jun 2013 22:22:19 +0900
Subject: [PATCH 1/5] ARM: shmobile: BOCK-W: add Ether support
In-Reply-To: <1371648143-18376-1-git-send-email-horms+renesas@verge.net.au>
References: <1371648143-18376-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371648143-18376-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Register Ether device from bockw_init(), passing the platform data to it, adding
only the RMII pin group to bockw_pinctrl_map[].  Although the LINK signal exists
on the board, it's connected to the link/activity LED  output of the PHY, thus
the link disappears and reappears after each packet. We'd be better off ignoring
such signal and getting the link state from the PHY indirectly.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[horms+renesas at verge.net.au: manually applied]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 2b6103e..bfe8f67 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -63,7 +63,24 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 };
 
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
@@ -85,6 +102,7 @@ static void __init bockw_init(void)
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
+	r8a7778_add_ether_device(&ether_platform_data);
 
 	pinctrl_register_mappings(bockw_pinctrl_map,
 				  ARRAY_SIZE(bockw_pinctrl_map));
-- 
1.8.2.1
