From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 21 May 2013 14:14:41 +0200
Subject: [PATCH v4 20/21] ARM: shmobile: marzen-reference: Move pinctrl
 mappings to device tree
In-Reply-To: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1369138482-5871-21-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the pinctrl mappings in board code by device tree mappings.
For devices that are still instantiated from board code reference the
mappings as the default pin controller state to apply them at boot time.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts  | 35 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-marzen-reference.c | 27 -------------------
 2 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index fe32e1a..596e313 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -37,6 +37,9 @@
 	lan0 at 18000000 {
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x18000000 0x100>;
+		pinctrl-0 = <&lan0_pins>;
+		pinctrl-names = "default";
+
 		phy-mode = "mii";
 		interrupt-parent = <&irqpin0>;
 		interrupts = <1 0x4>;
@@ -46,3 +49,35 @@
 		vdd33a-supply = <&fixedregulator3v3>;
 	};
 };
+
+&pfc {
+	pinctrl-0 = <&scif2_pins &scif4_pins &sdhi0_pins>;
+	pinctrl-names = "default";
+
+	lan0_pins: lan0 {
+		intc {
+			renesas,groups = "intc_irq1_b";
+			renesas,function = "intc";
+		};
+		lbsc {
+			renesas,groups = "lbsc_ex_cs0";
+			renesas,function = "lbsc";
+		};
+	};
+
+	scif2_pins: scif2 {
+		renesas,groups = "scif2_data_c";
+		renesas,function = "scif2";
+	};
+
+	scif4_pins: scif4 {
+		renesas,groups = "scif4_data";
+		renesas,function = "scif4";
+	};
+
+	sdhi0_pins: sdhi0 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd",
+				 "sdhi0_wp";
+		renesas,function = "sdhi0";
+	};
+};
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index fa7fc07..3d1c439 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -19,41 +19,14 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/pinctrl/machine.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 
-static const struct pinctrl_map marzen_pinctrl_map[] = {
-	/* SCIF2 (CN18: DEBUG0) */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "fffc0000.pfc",
-				  "scif2_data_c", "scif2"),
-	/* SCIF4 (CN19: DEBUG1) */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "fffc0000.pfc",
-				  "scif4_data", "scif4"),
-	/* SDHI0 */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "fffc0000.pfc",
-				  "sdhi0_data4", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "fffc0000.pfc",
-				  "sdhi0_ctrl", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "fffc0000.pfc",
-				  "sdhi0_cd", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "fffc0000.pfc",
-				  "sdhi0_wp", "sdhi0"),
-	/* SMSC */
-	PIN_MAP_MUX_GROUP_DEFAULT("18000000.lan0", "fffc0000.pfc",
-				  "intc_irq1_b", "intc"),
-	PIN_MAP_MUX_GROUP_DEFAULT("18000000.lan0", "fffc0000.pfc",
-				  "lbsc_ex_cs0", "lbsc"),
-};
-
 static void __init marzen_init(void)
 {
-	pinctrl_register_mappings(marzen_pinctrl_map,
-				  ARRAY_SIZE(marzen_pinctrl_map));
-
 	r8a7779_add_standard_devices_dt();
 }
 
-- 
1.8.1.5
