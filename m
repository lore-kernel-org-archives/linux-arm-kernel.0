From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 21 May 2013 14:14:33 +0200
Subject: [PATCH v4 12/21] ARM: shmobile: sh73a0: Add pin control device to
 device tree
In-Reply-To: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1369138482-5871-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pfc node to the sh73a0 device tree and remove manual pinmux
initialization from the corresponding board files.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0.dtsi                  |  8 ++++++++
 arch/arm/mach-shmobile/board-kzm9g-reference.c | 27 +++++++++++++-------------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 17fd9c6..9b1e8f8 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -233,4 +233,12 @@
 		cap-sd-highspeed;
 		status = "disabled";
 	};
+
+	pfc: pfc at e6050000 {
+		compatible = "renesas,pfc-sh73a0";
+		reg = <0xe6050000 0x8000>,
+		      <0xe605801c 0x1c>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 44055fe..6ff6ca2 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -40,35 +40,35 @@ static unsigned long pin_pullup_conf[] = {
 };
 
 static const struct pinctrl_map kzm_pinctrl_map[] = {
-	PIN_MAP_MUX_GROUP_DEFAULT("e6826000.i2c", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("e6826000.i2c", "e6050000.pfc",
 				  "i2c3_1", "i2c3"),
 	/* MMCIF */
-	PIN_MAP_MUX_GROUP_DEFAULT("e6bd0000.mmcif", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("e6bd0000.mmcif", "e6050000.pfc",
 				  "mmc0_data8_0", "mmc0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("e6bd0000.mmcif", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("e6bd0000.mmcif", "e6050000.pfc",
 				  "mmc0_ctrl_0", "mmc0"),
-	PIN_MAP_CONFIGS_PIN_DEFAULT("e6bd0000.mmcif", "pfc-sh73a0",
+	PIN_MAP_CONFIGS_PIN_DEFAULT("e6bd0000.mmcif", "e6050000.pfc",
 				    "PORT279", pin_pullup_conf),
-	PIN_MAP_CONFIGS_GROUP_DEFAULT("e6bd0000.mmcif", "pfc-sh73a0",
+	PIN_MAP_CONFIGS_GROUP_DEFAULT("e6bd0000.mmcif", "e6050000.pfc",
 				      "mmc0_data8_0", pin_pullup_conf),
 	/* SCIFA4 */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "e6050000.pfc",
 				  "scifa4_data", "scifa4"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "e6050000.pfc",
 				  "scifa4_ctrl", "scifa4"),
 	/* SDHI0 */
-	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "e6050000.pfc",
 				  "sdhi0_data4", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "e6050000.pfc",
 				  "sdhi0_ctrl", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "e6050000.pfc",
 				  "sdhi0_cd", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "e6050000.pfc",
 				  "sdhi0_wp", "sdhi0"),
 	/* SDHI2 */
-	PIN_MAP_MUX_GROUP_DEFAULT("ee140000.sdhi", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("ee140000.sdhi", "e6050000.pfc",
 				  "sdhi2_data4", "sdhi2"),
-	PIN_MAP_MUX_GROUP_DEFAULT("ee140000.sdhi", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("ee140000.sdhi", "e6050000.pfc",
 				  "sdhi2_ctrl", "sdhi2"),
 };
 
@@ -76,7 +76,6 @@ static void __init kzm_init(void)
 {
 	sh73a0_add_standard_devices_dt();
 	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
-	sh73a0_pinmux_init();
 
 	/* enable SD */
 	gpio_request_one(15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
-- 
1.8.1.5
