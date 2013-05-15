From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 15 May 2013 02:18:12 +0200
Subject: [PATCH v3 12/20] ARM: shmobile: armadillo-reference: Move pinctrl
 mappings to device tree
In-Reply-To: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1368577100-3530-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the pinctrl mappings in board code by device tree mappings.
For devices that are still instantiated from board code reference the
mappings as the default pin controller state to apply them at boot time.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts  | 10 ++++++++++
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c |  9 ---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 09ea22c..4a7ae32 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -43,3 +43,13 @@
 		interrupts = <2 0>; /* IRQ10: hwirq 2 on irqpin1 */
 	};
 };
+
+&pfc {
+	pinctrl-0 = <&scifa1_pins>;
+	pinctrl-names = "default";
+
+	scifa1_pins: scifa1 {
+		renesas,groups = "scifa1_data";
+		renesas,function = "scifa1";
+	};
+};
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index f25b6aa..4ddd299 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -24,7 +24,6 @@
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
-#include <linux/pinctrl/machine.h>
 #include <mach/common.h>
 #include <mach/r8a7740.h>
 #include <asm/mach/arch.h>
@@ -119,12 +118,6 @@
  *	usbhsf_power_ctrl()
  */
 
-static const struct pinctrl_map eva_pinctrl_map[] = {
-	/* SCIFA1 */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.1", "e6050000.pfc",
-				  "scifa1_data", "scifa1"),
-};
-
 static void __init eva_clock_init(void)
 {
 	struct clk *system	= clk_get(NULL, "system_clk");
@@ -169,8 +162,6 @@ static void __init eva_init(void)
 	r8a7740_clock_init(MD_CK0 | MD_CK2);
 	eva_clock_init();
 
-	pinctrl_register_mappings(eva_pinctrl_map, ARRAY_SIZE(eva_pinctrl_map));
-
 	r8a7740_meram_workaround();
 
 #ifdef CONFIG_CACHE_L2X0
-- 
1.8.1.5
