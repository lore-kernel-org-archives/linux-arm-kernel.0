From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 02 Jan 2017 15:27:21 +0000
Subject: [PATCH 3/5] ARM: dts: armada388-clearfog: move I2C nodes
In-Reply-To: <E1cO4UH-0008SR-GW@rmk-PC.armlinux.org.uk>
References: <E1cO4UH-0008SR-GW@rmk-PC.armlinux.org.uk>
Message-ID: <E1cO4W9-000069-IZ@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the I2C nodes over to use the label form to reference the I2C
controllers, rather than replicating the device node path.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/armada-388-clearfog.dtsi | 245 ++++++++++++++---------------
 1 file changed, 120 insertions(+), 125 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
index 7946400b4bf2..eeb845bbe3f3 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
+++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
@@ -92,131 +92,6 @@
 				};
 			};
 
-			i2c at 11000 {
-				/* Is there anything on this? */
-				clock-frequency = <100000>;
-				pinctrl-0 = <&i2c0_pins>;
-				pinctrl-names = "default";
-				status = "okay";
-
-				/*
-				 * PCA9655 GPIO expander, up to 1MHz clock.
-				 *  0-CON3 CLKREQ#
-				 *  1-CON3 PERST#
-				 *  2-
-				 *  3-CON3 W_DISABLE
-				 *  4-
-				 *  5-USB3 overcurrent
-				 *  6-USB3 power
-				 *  7-
-				 *  8-JP4 P1
-				 *  9-JP4 P4
-				 * 10-JP4 P5
-				 * 11-m.2 DEVSLP
-				 * 12-SFP_LOS
-				 * 13-SFP_TX_FAULT
-				 * 14-SFP_TX_DISABLE
-				 * 15-SFP_MOD_DEF0
-				 */
-				expander0: gpio-expander at 20 {
-					/*
-					 * This is how it should be:
-					 * compatible = "onnn,pca9655",
-					 *	 "nxp,pca9555";
-					 * but you can't do this because of
-					 * the way I2C works.
-					 */
-					compatible = "nxp,pca9555";
-					gpio-controller;
-					#gpio-cells = <2>;
-					reg = <0x20>;
-
-					pcie1_0_clkreq {
-						gpio-hog;
-						gpios = <0 GPIO_ACTIVE_LOW>;
-						input;
-						line-name = "pcie1.0-clkreq";
-					};
-					pcie1_0_w_disable {
-						gpio-hog;
-						gpios = <3 GPIO_ACTIVE_LOW>;
-						output-low;
-						line-name = "pcie1.0-w-disable";
-					};
-					usb3_ilimit {
-						gpio-hog;
-						gpios = <5 GPIO_ACTIVE_LOW>;
-						input;
-						line-name = "usb3-current-limit";
-					};
-					usb3_power {
-						gpio-hog;
-						gpios = <6 GPIO_ACTIVE_HIGH>;
-						output-high;
-						line-name = "usb3-power";
-					};
-					m2_devslp {
-						gpio-hog;
-						gpios = <11 GPIO_ACTIVE_HIGH>;
-						output-low;
-						line-name = "m.2 devslp";
-					};
-					sfp_los {
-						/* SFP loss of signal */
-						gpio-hog;
-						gpios = <12 GPIO_ACTIVE_HIGH>;
-						input;
-						line-name = "sfp-los";
-					};
-					sfp_tx_fault {
-						/* SFP laser fault */
-						gpio-hog;
-						gpios = <13 GPIO_ACTIVE_HIGH>;
-						input;
-						line-name = "sfp-tx-fault";
-					};
-					sfp_tx_disable {
-						/* SFP transmit disable */
-						gpio-hog;
-						gpios = <14 GPIO_ACTIVE_HIGH>;
-						output-low;
-						line-name = "sfp-tx-disable";
-					};
-					sfp_mod_def0 {
-						/* SFP module present */
-						gpio-hog;
-						gpios = <15 GPIO_ACTIVE_LOW>;
-						input;
-						line-name = "sfp-mod-def0";
-					};
-				};
-
-				/* The MCP3021 is 100kHz clock only */
-				mikrobus_adc: mcp3021 at 4c {
-					compatible = "microchip,mcp3021";
-					reg = <0x4c>;
-				};
-
-				/* Also something at 0x64 */
-			};
-
-			i2c at 11100 {
-				/*
-				 * Routed to SFP, mikrobus, and PCIe.
-				 * SFP limits this to 100kHz, and requires
-				 *  an AT24C01A/02/04 with address pins tied
-				 *  low, which takes addresses 0x50 and 0x51.
-				 * Mikrobus doesn't specify beyond an I2C
-				 *  bus being present.
-				 * PCIe uses ARP to assign addresses, or
-				 *  0x63-0x64.
-				 */
-				clock-frequency = <100000>;
-				pinctrl-0 = <&clearfog_i2c1_pins>;
-				pinctrl-names = "default";
-				status = "okay";
-			};
-
 			sata at a8000 {
 				/* pinctrl? */
 				status = "okay";
@@ -272,6 +147,126 @@
 	};
 };
 
+&i2c0 {
+	/* Is there anything on this? */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	/*
+	 * PCA9655 GPIO expander, up to 1MHz clock.
+	 *  0-CON3 CLKREQ#
+	 *  1-CON3 PERST#
+	 *  2-
+	 *  3-CON3 W_DISABLE
+	 *  4-
+	 *  5-USB3 overcurrent
+	 *  6-USB3 power
+	 *  7-
+	 *  8-JP4 P1
+	 *  9-JP4 P4
+	 * 10-JP4 P5
+	 * 11-m.2 DEVSLP
+	 * 12-SFP_LOS
+	 * 13-SFP_TX_FAULT
+	 * 14-SFP_TX_DISABLE
+	 * 15-SFP_MOD_DEF0
+	 */
+	expander0: gpio-expander at 20 {
+		/*
+		 * This is how it should be:
+		 * compatible = "onnn,pca9655", "nxp,pca9555";
+		 * but you can't do this because of the way I2C works.
+		 */
+		compatible = "nxp,pca9555";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0x20>;
+
+		pcie1_0_clkreq {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "pcie1.0-clkreq";
+		};
+		pcie1_0_w_disable {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "pcie1.0-w-disable";
+		};
+		usb3_ilimit {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "usb3-current-limit";
+		};
+		usb3_power {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "usb3-power";
+		};
+		m2_devslp {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "m.2 devslp";
+		};
+		sfp_los {
+			/* SFP loss of signal */
+			gpio-hog;
+			gpios = <12 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "sfp-los";
+		};
+		sfp_tx_fault {
+			/* SFP laser fault */
+			gpio-hog;
+			gpios = <13 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "sfp-tx-fault";
+		};
+		sfp_tx_disable {
+			/* SFP transmit disable */
+			gpio-hog;
+			gpios = <14 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "sfp-tx-disable";
+		};
+		sfp_mod_def0 {
+			/* SFP module present */
+			gpio-hog;
+			gpios = <15 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "sfp-mod-def0";
+		};
+	};
+
+	/* The MCP3021 is 100kHz clock only */
+	mikrobus_adc: mcp3021 at 4c {
+		compatible = "microchip,mcp3021";
+		reg = <0x4c>;
+	};
+
+	/* Also something at 0x64 */
+};
+
+&i2c1 {
+	/*
+	 * Routed to SFP, mikrobus, and PCIe.
+	 * SFP limits this to 100kHz, and requires an AT24C01A/02/04 with
+	 *  address pins tied low, which takes addresses 0x50 and 0x51.
+	 * Mikrobus doesn't specify beyond an I2C bus being present.
+	 * PCIe uses ARP to assign addresses, or 0x63-0x64.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&clearfog_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &pinctrl {
 	clearfog_i2c1_pins: i2c1-pins {
 		/* SFP, PCIe, mSATA, mikrobus */
-- 
2.7.4
