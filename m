From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 2 Jun 2013 02:12:25 +0400
Subject: [PATCH v8 3/3] ARM: shmobile: BOCK-W: add USB support
In-Reply-To: <201306020206.47199.sergei.shtylyov@cogentembedded.com>
References: <201306020206.47199.sergei.shtylyov@cogentembedded.com>
Message-ID: <201306020212.25957.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the USB PHY device from bockw_init(), passing the platform  data to it.
Set machine's init_late() method to r8a7778_init_late() in order for [EO]HCI to
get registered too...

Don't forget to add USB PENC0/1 pins to bockw_pinctrl_map[].

The patch has been tested on the BOCK-W board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes since version 6:
- added USB PENC0/1 pins to bockw_pinctrl_map[].

Changes since version 4:
- annotated 'usb_phy_platform_data' as '__initdata' since it's kmemdup()'ed
  while registering the platform device anyway;
- refreshed the patch.

Changes since version 3:
- removed initializer for 'usb_phy_platform_data' letting it be set to all 0s;
- refreshed the patch.

Changes since version 2:
- refreshed the patch.

Changes since the original posting:
- removed initializer for no longer existing field in 'usb_phy_platform_data',
  modified the comment to the 'ferrite_bead' field initializer.

 arch/arm/mach-shmobile/board-bockw.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: renesas/arch/arm/mach-shmobile/board-bockw.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-bockw.c
+++ renesas/arch/arm/mach-shmobile/board-bockw.c
@@ -63,6 +63,8 @@ static struct sh_mobile_sdhi_info sdhi0_
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 };
 
+static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
+
 static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* SCIF0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
@@ -78,6 +80,10 @@ static const struct pinctrl_map bockw_pi
 				  "sdhi0_data4", "sdhi0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7778",
 				  "sdhi0_wp", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
+				  "usb0", "usb0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
+				  "usb1", "usb1"),
 };
 
 #define FPGA	0x18200000
@@ -91,6 +97,7 @@ static void __init bockw_init(void)
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
+	r8a7778_add_usb_phy_device(&usb_phy_platform_data);
 
 	pinctrl_register_mappings(bockw_pinctrl_map,
 				  ARRAY_SIZE(bockw_pinctrl_map));
@@ -146,4 +153,5 @@ DT_MACHINE_START(BOCKW_DT, "bockw")
 	.init_machine	= bockw_init,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= bockw_boards_compat_dt,
+	.init_late      = r8a7778_init_late,
 MACHINE_END
