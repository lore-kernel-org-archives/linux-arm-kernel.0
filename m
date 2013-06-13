From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:36 +0900
Subject: [PATCH 12/12] ARM: shmobile: BOCK-W: add USB support
In-Reply-To: <1371106836-25388-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106836-25388-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106836-25388-13-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Register the USB PHY device from bockw_init(), passing the platform  data to it.
Set machine's init_late() method to r8a7778_init_late() in order for [EO]HCI to
get registered too...

Don't forget to add USB PENC0/1 pins to bockw_pinctrl_map[].

The patch has been tested on the BOCK-W board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index dac4365..7ed2401 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -38,12 +38,18 @@ static struct resource smsc911x_resources[] = {
 	DEFINE_RES_IRQ(irq_pin(0)), /* IRQ 0 */
 };
 
+static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
+
 static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* SCIF0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
 				  "scif0_data_a", "scif0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
 				  "scif0_ctrl", "scif0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
+				  "usb0", "usb0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
+				  "usb1", "usb1"),
 };
 
 #define IRQ0MR	0x30
@@ -54,6 +60,7 @@ static void __init bockw_init(void)
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
+	r8a7778_add_usb_phy_device(&usb_phy_platform_data);
 
 	pinctrl_register_mappings(bockw_pinctrl_map,
 				  ARRAY_SIZE(bockw_pinctrl_map));
@@ -91,4 +98,5 @@ DT_MACHINE_START(BOCKW_DT, "bockw")
 	.init_machine	= bockw_init,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= bockw_boards_compat_dt,
+	.init_late      = r8a7778_init_late,
 MACHINE_END
-- 
1.8.2.1
