From: aford173@gmail.com (Adam Ford)
Date: Mon,  7 May 2018 07:37:21 -0500
Subject: [PATCH V3] ARM: dts: da850-evm: use phandles to extend nodes
Message-ID: <20180507123721.9264-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many node labels in the device tree (like serial0, serial1, etc) are being
redefined, so let's modernize the device tree by using phandles to
extend the existing nodes.  This helps reduce the whitespace.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Rebase against 4.18/dt and fix subject.

V2: Rename subject per feedback from Sekhar.
    Extend notes from tps6507x
    Add empty line after each node
    
diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 339cae353302..3c486d8675b8 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -27,143 +27,6 @@
 		spi0 = &spi1;
 	};
 
-	soc at 1c00000 {
-		pmx_core: pinmux at 14120 {
-			status = "okay";
-
-			mcasp0_pins: pinmux_mcasp0_pins {
-				pinctrl-single,bits = <
-					/*
-					 * AHCLKX, ACLKX, AFSX, AHCLKR, ACLKR,
-					 * AFSR, AMUTE
-					 */
-					0x00 0x11111111 0xffffffff
-					/* AXR11, AXR12 */
-					0x04 0x00011000 0x000ff000
-				>;
-			};
-			nand_pins: nand_pins {
-				pinctrl-single,bits = <
-					/* EMA_WAIT[0], EMA_OE, EMA_WE, EMA_CS[4], EMA_CS[3] */
-					0x1c 0x10110110  0xf0ff0ff0
-					/*
-					 * EMA_D[0], EMA_D[1], EMA_D[2],
-					 * EMA_D[3], EMA_D[4], EMA_D[5],
-					 * EMA_D[6], EMA_D[7]
-					 */
-					0x24 0x11111111  0xffffffff
-					/* EMA_A[1], EMA_A[2] */
-					0x30 0x01100000  0x0ff00000
-				>;
-			};
-		};
-		serial0: serial at 42000 {
-			status = "okay";
-		};
-		serial1: serial at 10c000 {
-			status = "okay";
-		};
-		serial2: serial at 10d000 {
-			status = "okay";
-		};
-		rtc0: rtc at 23000 {
-			status = "okay";
-		};
-		i2c0: i2c at 22000 {
-			status = "okay";
-			clock-frequency = <100000>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c0_pins>;
-
-			tps: tps at 48 {
-				reg = <0x48>;
-			};
-			tlv320aic3106: tlv320aic3106 at 18 {
-				#sound-dai-cells = <0>;
-				compatible = "ti,tlv320aic3106";
-				reg = <0x18>;
-				status = "okay";
-
-				/* Regulators */
-				IOVDD-supply = <&vdcdc2_reg>;
-				/* Derived from VBAT: Baseboard 3.3V / 1.8V */
-				AVDD-supply = <&vbat>;
-				DRVDD-supply = <&vbat>;
-				DVDD-supply = <&vbat>;
-			};
-			tca6416: gpio at 20 {
-				compatible = "ti,tca6416";
-				reg = <0x20>;
-				gpio-controller;
-				#gpio-cells = <2>;
-			};
-		};
-		wdt: wdt at 21000 {
-			status = "okay";
-		};
-		mmc0: mmc at 40000 {
-			max-frequency = <50000000>;
-			bus-width = <4>;
-			status = "okay";
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins>;
-		};
-		spi1: spi at 30e000 {
-			status = "okay";
-			pinctrl-names = "default";
-			pinctrl-0 = <&spi1_pins &spi1_cs0_pin>;
-			flash: m25p80 at 0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "m25p64";
-				spi-max-frequency = <30000000>;
-				m25p,fast-read;
-				reg = <0>;
-				partition at 0 {
-					label = "U-Boot-SPL";
-					reg = <0x00000000 0x00010000>;
-					read-only;
-				};
-				partition at 1 {
-					label = "U-Boot";
-					reg = <0x00010000 0x00080000>;
-					read-only;
-				};
-				partition at 2 {
-					label = "U-Boot-Env";
-					reg = <0x00090000 0x00010000>;
-					read-only;
-				};
-				partition at 3 {
-					label = "Kernel";
-					reg = <0x000a0000 0x00280000>;
-				};
-				partition at 4 {
-					label = "Filesystem";
-					reg = <0x00320000 0x00400000>;
-				};
-				partition at 5 {
-					label = "MAC-Address";
-					reg = <0x007f0000 0x00010000>;
-					read-only;
-				};
-			};
-		};
-		mdio: mdio at 224000 {
-			status = "okay";
-			pinctrl-names = "default";
-			pinctrl-0 = <&mdio_pins>;
-			bus_freq = <2200000>;
-		};
-		eth0: ethernet at 220000 {
-			status = "okay";
-			pinctrl-names = "default";
-			pinctrl-0 = <&mii_pins>;
-		};
-		gpio: gpio at 226000 {
-			status = "okay";
-		};
-	};
 	vbat: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
@@ -200,56 +63,200 @@
 	};
 };
 
+&pmx_core {
+	status = "okay";
+
+	mcasp0_pins: pinmux_mcasp0_pins {
+		pinctrl-single,bits = <
+			/*
+			 * AHCLKX, ACLKX, AFSX, AHCLKR, ACLKR,
+			 * AFSR, AMUTE
+			 */
+			0x00 0x11111111 0xffffffff
+			/* AXR11, AXR12 */
+			0x04 0x00011000 0x000ff000
+		>;
+	};
+	nand_pins: nand_pins {
+		pinctrl-single,bits = <
+			/* EMA_WAIT[0], EMA_OE, EMA_WE, EMA_CS[4], EMA_CS[3] */
+			0x1c 0x10110110  0xf0ff0ff0
+			/*
+			 * EMA_D[0], EMA_D[1], EMA_D[2],
+			 * EMA_D[3], EMA_D[4], EMA_D[5],
+			 * EMA_D[6], EMA_D[7]
+			 */
+			0x24 0x11111111  0xffffffff
+			/* EMA_A[1], EMA_A[2] */
+			0x30 0x01100000  0x0ff00000
+		>;
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&rtc0 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+
+	tps: tps at 48 {
+		reg = <0x48>;
+	};
+	tlv320aic3106: tlv320aic3106 at 18 {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3106";
+		reg = <0x18>;
+		status = "okay";
+
+		/* Regulators */
+		IOVDD-supply = <&vdcdc2_reg>;
+		/* Derived from VBAT: Baseboard 3.3V / 1.8V */
+		AVDD-supply = <&vbat>;
+		DRVDD-supply = <&vbat>;
+		DVDD-supply = <&vbat>;
+	};
+	tca6416: gpio at 20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&wdt {
+	status = "okay";
+};
+
+&mmc0 {
+	max-frequency = <50000000>;
+	bus-width = <4>;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins &spi1_cs0_pin>;
+	flash: m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p64";
+		spi-max-frequency = <30000000>;
+		m25p,fast-read;
+		reg = <0>;
+		partition at 0 {
+			label = "U-Boot-SPL";
+			reg = <0x00000000 0x00010000>;
+			read-only;
+		};
+		partition at 1 {
+			label = "U-Boot";
+			reg = <0x00010000 0x00080000>;
+			read-only;
+		};
+		partition at 2 {
+			label = "U-Boot-Env";
+			reg = <0x00090000 0x00010000>;
+			read-only;
+		};
+		partition at 3 {
+			label = "Kernel";
+			reg = <0x000a0000 0x00280000>;
+		};
+		partition at 4 {
+			label = "Filesystem";
+			reg = <0x00320000 0x00400000>;
+		};
+		partition at 5 {
+			label = "MAC-Address";
+			reg = <0x007f0000 0x00010000>;
+			read-only;
+		};
+	};
+};
+&mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins>;
+	bus_freq = <2200000>;
+};
+
+&eth0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mii_pins>;
+};
+
+&gpio {
+	status = "okay";
+};
+
 /include/ "tps6507x.dtsi"
 
 &tps {
 	vdcdc1_2-supply = <&vbat>;
 	vdcdc3-supply = <&vbat>;
 	vldo1_2-supply = <&vbat>;
+};
 
-	regulators {
-		vdcdc1_reg: regulator at 0 {
-			regulator-name = "VDCDC1_3.3V";
-			regulator-min-microvolt = <3150000>;
-			regulator-max-microvolt = <3450000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
+&vdcdc1_reg {
+	regulator-name = "VDCDC1_3.3V";
+	regulator-min-microvolt = <3150000>;
+	regulator-max-microvolt = <3450000>;
+	regulator-always-on;
+	regulator-boot-on;
+};
 
-		vdcdc2_reg: regulator at 1 {
-			regulator-name = "VDCDC2_3.3V";
-			regulator-min-microvolt = <1710000>;
-			regulator-max-microvolt = <3450000>;
-			regulator-always-on;
-			regulator-boot-on;
-			ti,defdcdc_default = <1>;
-		};
+&vdcdc2_reg {
+	regulator-name = "VDCDC2_3.3V";
+	regulator-min-microvolt = <1710000>;
+	regulator-max-microvolt = <3450000>;
+	regulator-always-on;
+	regulator-boot-on;
+	ti,defdcdc_default = <1>;
+};
 
-		vdcdc3_reg: regulator at 2 {
-			regulator-name = "VDCDC3_1.2V";
-			regulator-min-microvolt = <950000>;
-			regulator-max-microvolt = <1350000>;
-			regulator-always-on;
-			regulator-boot-on;
-			ti,defdcdc_default = <1>;
-		};
+&vdcdc3_reg {
+	regulator-name = "VDCDC3_1.2V";
+	regulator-min-microvolt = <950000>;
+	regulator-max-microvolt = <1350000>;
+	regulator-always-on;
+	regulator-boot-on;
+	ti,defdcdc_default = <1>;
+};
 
-		ldo1_reg: regulator at 3 {
-			regulator-name = "LDO1_1.8V";
-			regulator-min-microvolt = <1710000>;
-			regulator-max-microvolt = <1890000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
+&ldo1_reg {
+	regulator-name = "LDO1_1.8V";
+	regulator-min-microvolt = <1710000>;
+	regulator-max-microvolt = <1890000>;
+	regulator-always-on;
+	regulator-boot-on;
+};
 
-		ldo2_reg: regulator at 4 {
-			regulator-name = "LDO2_1.2V";
-			regulator-min-microvolt = <1140000>;
-			regulator-max-microvolt = <1320000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-	};
+&ldo2_reg {
+	regulator-name = "LDO2_1.2V";
+	regulator-min-microvolt = <1140000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-always-on;
+	regulator-boot-on;
 };
 
 &mcasp0 {
-- 
2.17.0
