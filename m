From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 28 Sep 2013 04:45:33 +0400
Subject: [PATCH 2/2] ARM: shmobile: BOCK-W: add CAN0 support
In-Reply-To: <201309280441.52414.sergei.shtylyov@cogentembedded.com>
References: <201309280441.52414.sergei.shtylyov@cogentembedded.com>
Message-ID: <201309280445.34234.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register platform device and pin data for CAN0 controller on the BOCK-W board. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/board-bockw.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: renesas/arch/arm/mach-shmobile/board-bockw.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-bockw.c
+++ renesas/arch/arm/mach-shmobile/board-bockw.c
@@ -19,6 +19,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/can/platform/rcar_can.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
@@ -193,6 +194,16 @@ static struct resource usb_phy_resources
 static struct rcar_phy_platform_data usb_phy_platform_data __initdata =
 	USB_PHY_SETTING;
 
+/* CAN */
+static struct resource can_resources[] __initdata = {
+	/* CAN0 */
+	DEFINE_RES_MEM(0xfffd0000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x64)),
+};
+
+static struct rcar_can_platform_data can_platform_data __initdata = {
+	.clock_select	= CLKR_CLKP1,
+};
 
 /* SDHI */
 static struct sh_mobile_sdhi_info sdhi0_info __initdata = {
@@ -523,6 +534,9 @@ static const struct pinctrl_map bockw_pi
 				  "ssi7_data", "ssi"),
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
 				  "ssi8_data", "ssi"),
+	/* CAN0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar_can.0", "pfc-r8a7778",
+				  "can0_data_a", "can0"),
 	/* Ether */
 	PIN_MAP_MUX_GROUP_DEFAULT("r8a777x-ether", "pfc-r8a7778",
 				  "ether_rmii", "ether"),
@@ -684,6 +698,12 @@ static void __init bockw_init(void)
 
 		platform_device_register_full(&cardinfo);
 	}
+
+	platform_device_register_resndata(&platform_bus, "rcar_can", 0,
+					  can_resources,
+					  ARRAY_SIZE(can_resources),
+					  &can_platform_data,
+					  sizeof(can_platform_data));
 }
 
 static void __init bockw_init_late(void)
