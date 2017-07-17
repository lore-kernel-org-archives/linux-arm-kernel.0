From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 17 Jul 2017 22:25:03 +0200
Subject: [PATCH 4/5] ARM: dts: imx6: RDU2: Add Switch interrupts
In-Reply-To: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
References: <1500323104-11583-1-git-send-email-andrew@lunn.ch>
Message-ID: <1500323104-11583-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell switch has its interrupt pin connected to a GPIO
line. Wire this up in the device tree. This then allows us to use
interrupts from the embedded Ethernet PHYs in the switch. Also wire
them up in device tree.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 53 ++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index d67bf81524a2..83f311a51cca 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -630,13 +630,19 @@
 		#size-cells = <0>;
 		status = "okay";
 
-		switch at 0 {
+		switch: switch at 0 {
 			compatible = "marvell,mv88e6085";
+			pinctrl-0 = <&pinctrl_switch_irq>;
+			pinctrl-names = "default";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
 			dsa,member = <0 0>;
 			eeprom-length = <512>;
+			interrupt-parent = <&gpio6>;
+			interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 
 			ports {
 				#address-cells = <1>;
@@ -645,11 +651,13 @@
 				port at 0 {
 					reg = <0>;
 					label = "gigabit_proc";
+					phy-handle = <&switchphy0>;
 				};
 
 				port at 1 {
 					reg = <1>;
 					label = "netaux";
+					phy-handle = <&switchphy1>;
 				};
 
 				port at 2 {
@@ -666,11 +674,48 @@
 				port at 3 {
 					reg = <3>;
 					label = "netright";
+					phy-handle = <&switchphy3>;
 				};
 
 				port at 4 {
 					reg = <4>;
 					label = "netleft";
+					phy-handle = <&switchphy4>;
+				};
+			};
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				switchphy0: switchphy at 0 {
+					reg = <0>;
+					interrupt-parent = <&switch>;
+					interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				switchphy1: switchphy at 1 {
+					reg = <1>;
+					interrupt-parent = <&switch>;
+					interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				switchphy2: switchphy at 2 {
+					reg = <2>;
+					interrupt-parent = <&switch>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				switchphy3: switchphy at 3 {
+					reg = <3>;
+					interrupt-parent = <&switch>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				switchphy4: switchphy at 4 {
+					reg = <4>;
+					interrupt-parent = <&switch>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
 				};
 			};
 		};
@@ -891,6 +936,12 @@
 		>;
 	};
 
+	pinctrl_switch_irq: switchgrp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT17__GPIO6_IO03	0x4001b000
+		>;
+	};
+
 	pinctrl_tc358767: tc358767grp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_9__GPIO1_IO09		0x10
-- 
2.13.2
