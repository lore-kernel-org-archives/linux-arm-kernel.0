From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 10 May 2018 14:40:46 +0530
Subject: [PATCH V3] ARM: dts: da850-evm: use phandles to extend nodes
In-Reply-To: <20180507123721.9264-1-aford173@gmail.com>
References: <20180507123721.9264-1-aford173@gmail.com>
Message-ID: <ae8292b2-b167-7a96-70be-1cfea6059874@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 May 2018 06:07 PM, Adam Ford wrote:
> Many node labels in the device tree (like serial0, serial1, etc) are being
> redefined, so let's modernize the device tree by using phandles to
> extend the existing nodes.  This helps reduce the whitespace.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

I applied this without the pmic changes. I am not convinced about those. 
The tps node is already being referred to as phandle. I am not sure 
referring to each individual regulator using phandle is needed. Other 
files like am335x-evm.dts don't do it as well.

Another thing is whether we really need the tp6507x.dtsi file. It does 
not seem to contain much and also da850-evm.dts is the only file 
including it. So it seems pretty pointless to me.

Here is what I committed.

Thanks,
Sekhar

---8<---
commit ae62a32d6019a8225e2c32e631b8b0d039151131 (refs/heads/v4.18/dt)
Author:     Adam Ford <aford173@gmail.com>
AuthorDate: Mon May 7 07:37:21 2018 -0500
Commit:     Sekhar Nori <nsekhar@ti.com>
CommitDate: Thu May 10 14:01:15 2018 +0530

    ARM: dts: da850-evm: use phandles to extend nodes
    
    Many node labels in the device tree (like serial0, serial1, etc) are being
    redefined, so let's modernize the device tree by using phandles to
    extend the existing nodes.  This helps reduce the whitespace.
    
    Signed-off-by: Adam Ford <aford173@gmail.com>
    [nsekhar at ti.com: drop tps6507x related changes]
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 339cae353302..9389f95f4094 100644
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
@@ -200,6 +63,153 @@
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
+
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
