From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 17 Apr 2013 01:34:47 +0400
Subject: [PATCH v3 3/4] ARM: shmobile: BOCK-W: add USB support
Message-ID: <201304170134.47851.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the USB PHY device from bockw_init(), passing the platform  data to it.
Set machine's init_late() method to r8a7778_init_late() in order for [EO]HCI to
get registered too...

The patch has been tested on the BOCK-W board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes since version 2:
- refreshed the patch.

Changes since the original posting:
- removed initializer for no longer existing field in 'usb_phy_platform_data',
  modified the comment to the 'ferrite_bead' field initializer.

 arch/arm/mach-shmobile/board-bockw.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: renesas/arch/arm/mach-shmobile/board-bockw.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-bockw.c
+++ renesas/arch/arm/mach-shmobile/board-bockw.c
@@ -54,6 +54,10 @@ static struct resource smsc911x_resource
 	DEFINE_RES_IRQ(irq_pin(0)), /* IRQ 0 */
 };
 
+static struct rcar_phy_platform_data usb_phy_platform_data = {
+	.ferrite_bead	= true,		/* not sure about this... */
+};
+
 static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* SCIF0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
@@ -70,6 +74,7 @@ static void __init bockw_init(void)
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
+	r8a7778_add_usb_phy_device(&usb_phy_platform_data);
 
 	pinctrl_register_mappings(bockw_pinctrl_map,
 				  ARRAY_SIZE(bockw_pinctrl_map));
@@ -110,4 +115,5 @@ DT_MACHINE_START(BOCKW_DT, "bockw")
 	.init_machine	= bockw_init,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= bockw_boards_compat_dt,
+	.init_late      = r8a7778_init_late,
 MACHINE_END
