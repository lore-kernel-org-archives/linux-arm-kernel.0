From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 15 May 2013 02:18:03 +0200
Subject: [PATCH v3 03/20] ARM: shmobile: r8a7740: Add pin control device to
 device tree
In-Reply-To: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1368577100-3530-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pfc node to the r8a7740 device tree and remove manual pinmux
initialization from the corresponding board files.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7740.dtsi                           |  8 ++++++++
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c | 16 ++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 25dc930..2fa3708 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -135,4 +135,12 @@
 			      0 72 0x4
 			      0 73 0x4>;
 	};
+
+	pfc: pfc at e6050000 {
+		compatible = "renesas,pfc-r8a7740";
+		reg = <0xe6050000 0x8000>,
+		      <0xe605800c 0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 03b85fe..f25b6aa 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -121,7 +121,7 @@
 
 static const struct pinctrl_map eva_pinctrl_map[] = {
 	/* SCIFA1 */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.1", "pfc-r8a7740",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.1", "e6050000.pfc",
 				  "scifa1_data", "scifa1"),
 };
 
@@ -170,22 +170,22 @@ static void __init eva_init(void)
 	eva_clock_init();
 
 	pinctrl_register_mappings(eva_pinctrl_map, ARRAY_SIZE(eva_pinctrl_map));
-	r8a7740_pinmux_init();
 
 	r8a7740_meram_workaround();
 
-	/*
-	 * Touchscreen
-	 * TODO: Move reset GPIO over to .dts when we can reference it
-	 */
-	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
-
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
 	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
 #endif
 
 	r8a7740_add_standard_devices_dt();
+
+	/*
+	 * Touchscreen
+	 * TODO: Move reset GPIO over to .dts when we can reference it
+	 */
+	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
+
 	r8a7740_pm_init();
 }
 
-- 
1.8.1.5
