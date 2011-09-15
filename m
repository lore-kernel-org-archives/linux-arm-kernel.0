From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 15 Sep 2011 22:45:21 +0800
Subject: [PATCH v2 1/6] arm/imx6q: add device tree source
In-Reply-To: <1316097926-913-1-git-send-email-shawn.guo@linaro.org>
References: <1316097926-913-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1316097926-913-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds device tree source and documentation for imx6q platform.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.txt |    6 +
 arch/arm/boot/dts/imx6q-sabreauto.dts         |   71 ++++
 arch/arm/boot/dts/imx6q.dtsi                  |  547 +++++++++++++++++++++++++
 3 files changed, 624 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/fsl.txt
 create mode 100644 arch/arm/boot/dts/imx6q-sabreauto.dts
 create mode 100644 arch/arm/boot/dts/imx6q.dtsi

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
new file mode 100644
index 0000000..345bfc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -0,0 +1,6 @@
+Freescale i.MX Platforms Device Tree Bindings
+-----------------------------------------------
+
+i.MX6 Quad SABRE Automotive Board
+Required root node properties:
+    - compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-sabreauto.dts
new file mode 100644
index 0000000..ad14d36
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
@@ -0,0 +1,71 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "imx6q.dtsi"
+
+/ {
+	model = "Freescale i.MX6 Quad SABRE Automotive Board";
+	compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
+
+	chosen {
+		bootargs = "console=ttymxc3,115200 root=/dev/mmcblk3p3 rootwait";
+	};
+
+	memory {
+		reg = <0x10000000 0x80000000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clkl {
+			compatible = "fsl,imx6q-clkl", "fixed-clock";
+			clock-frequency = <32768>;
+		};
+
+		clkh {
+			compatible = "fsl,imx6q-clkh", "fixed-clock";
+			clock-frequency = <0>;
+		};
+
+		osc {
+			compatible = "fsl,imx6q-osc", "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+	};
+
+	soc {
+		aips-bus at 02100000 { /* AIPS2 */
+			enet at 02188000 {
+				phy-mode = "rgmii";
+				local-mac-address = [00 04 9F 01 1B 61];
+				status = "okay";
+			};
+
+			uart3: uart at 021f0000 { /* UART4 */
+				status = "okay";
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		debug-led {
+			label = "Heartbeat";
+			gpios = <&gpio2 25 0>; /* GPIO3_25 */
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
new file mode 100644
index 0000000..8cc2036
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -0,0 +1,547 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a9";
+			reg = <2>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a9";
+			reg = <3>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	intc: interrupt-controller at 00a01000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupt-controller;
+		reg = <0x00a01000 0x1000>,
+		      <0x00a00100 0x100>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&intc>;
+		ranges;
+
+		timer at 00a00600 {
+			compatible = "arm,smp-twd";
+			reg = <0x00a00600 0x100>;
+			interrupts = <29 0 0xf>;
+		};
+
+		L2: l2-cache at 00a02000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x00a02000 0x1000>;
+			interrupts = <124 4 0>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		aips-bus at 02000000 { /* AIPS1 */
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x02000000 0x100000>;
+			ranges;
+
+			spba-bus at 02000000 {
+				compatible = "fsl,spba-bus", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x02000000 0x40000>;
+				ranges;
+
+				spdif at 02004000 {
+					reg = <0x02004000 0x4000>;
+					interrupts = <84 4 0>;
+				};
+
+				ecspi at 02008000 { /* eCSPI1 */
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
+					reg = <0x02008000 0x4000>;
+					interrupts = <63 4 0>;
+					status = "disabled";
+				};
+
+				ecspi at 0200c000 { /* eCSPI2 */
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
+					reg = <0x0200c000 0x4000>;
+					interrupts = <64 4 0>;
+					status = "disabled";
+				};
+
+				ecspi at 02010000 { /* eCSPI3 */
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
+					reg = <0x02010000 0x4000>;
+					interrupts = <65 4 0>;
+					status = "disabled";
+				};
+
+				ecspi at 02014000 { /* eCSPI4 */
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
+					reg = <0x02014000 0x4000>;
+					interrupts = <66 4 0>;
+					status = "disabled";
+				};
+
+				ecspi at 02018000 { /* eCSPI5 */
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
+					reg = <0x02018000 0x4000>;
+					interrupts = <67 4 0>;
+					status = "disabled";
+				};
+
+				uart0: uart at 02020000 { /* UART1 */
+					compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
+					reg = <0x02020000 0x4000>;
+					interrupts = <58 4 0>;
+					status = "disabled";
+				};
+
+				esai at 02024000 {
+					reg = <0x02024000 0x4000>;
+					interrupts = <83 4 0>;
+				};
+
+				ssi at 02028000 { /* SSI1 */
+					reg = <0x02028000 0x4000>;
+					interrupts = <78 4 0>;
+				};
+
+				ssi at 0202c000 { /* SSI2 */
+					reg = <0x0202c000 0x4000>;
+					interrupts = <79 4 0>;
+				};
+
+				ssi at 02030000 { /* SSI3 */
+					reg = <0x02030000 0x4000>;
+					interrupts = <80 4 0>;
+				};
+
+				asrc at 02034000 {
+					reg = <0x02034000 0x4000>;
+					interrupts = <82 4 0>;
+				};
+
+				spba at 0203c000 {
+					reg = <0x0203c000 0x4000>;
+				};
+			};
+
+			vpu at 02040000 {
+				reg = <0x02040000 0x3c000>;
+				interrupts = <35 4 0 44 4 0>;
+			};
+
+			aipstz at 0207c000 { /* AIPSTZ1 */
+				reg = <0x0207c000 0x4000>;
+			};
+
+			pwm at 02080000 { /* PWM1 */
+				reg = <0x02080000 0x4000>;
+				interrupts = <115 4 0>;
+			};
+
+			pwm at 02084000 { /* PWM2 */
+				reg = <0x02084000 0x4000>;
+				interrupts = <116 4 0>;
+			};
+
+			pwm at 02088000 { /* PWM3 */
+				reg = <0x02088000 0x4000>;
+				interrupts = <117 4 0>;
+			};
+
+			pwm at 0208c000 { /* PWM4 */
+				reg = <0x0208c000 0x4000>;
+				interrupts = <118 4 0>;
+			};
+
+			flexcan at 02090000 { /* CAN1 */
+				reg = <0x02090000 0x4000>;
+				interrupts = <142 4 0>;
+			};
+
+			flexcan at 02094000 { /* CAN2 */
+				reg = <0x02094000 0x4000>;
+				interrupts = <143 4 0>;
+			};
+
+			gpt at 02098000 {
+				compatible = "fsl,imx6q-gpt";
+				reg = <0x02098000 0x4000>;
+				interrupts = <87 4 0>;
+			};
+
+			gpio0: gpio at 0209c000 { /* GPIO1 */
+				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				reg = <0x0209c000 0x4000>;
+				interrupts = <98 4 0 99 4 0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio1: gpio at 020a0000 { /* GPIO2 */
+				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				reg = <0x020a0000 0x4000>;
+				interrupts = <100 4 0 101 4 0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio2: gpio at 020a4000 { /* GPIO3 */
+				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				reg = <0x020a4000 0x4000>;
+				interrupts = <102 4 0 103 4 0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio3: gpio at 020a8000 { /* GPIO4 */
+				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				reg = <0x020a8000 0x4000>;
+				interrupts = <104 4 0 105 4 0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio4: gpio at 020ac000 { /* GPIO5 */
+				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				reg = <0x020ac000 0x4000>;
+				interrupts = <106 4 0 107 4 0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio5: gpio at 020b0000 { /* GPIO6 */
+				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				reg = <0x020b0000 0x4000>;
+				interrupts = <108 4 0 109 4 0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio6: gpio at 020b4000 { /* GPIO7 */
+				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				reg = <0x020b4000 0x4000>;
+				interrupts = <110 4 0 111 4 0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			kpp at 020b8000 {
+				reg = <0x020b8000 0x4000>;
+				interrupts = <114 4 0>;
+			};
+
+			wdog at 020bc000 { /* WDOG1 */
+				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
+				reg = <0x020bc000 0x4000>;
+				interrupts = <112 4 0>;
+				status = "disabled";
+			};
+
+			wdog at 020c0000 { /* WDOG2 */
+				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
+				reg = <0x020c0000 0x4000>;
+				interrupts = <113 4 0>;
+				status = "disabled";
+			};
+
+			ccm at 020c4000 {
+				compatible = "fsl,imx6q-ccm";
+				reg = <0x020c4000 0x4000>;
+				interrupts = <119 4 0 120 4 0>;
+			};
+
+			anatop at 020c8000 {
+				compatible = "fsl,imx6q-anatop";
+				reg = <0x020c8000 0x1000>;
+				interrupts = <81 4 0 86 4 0 159 4 0>;
+			};
+
+			usbphy at 020c9000 { /* USBPHY1 */
+				reg = <0x020c9000 0x1000>;
+				interrupts = <76 4 0>;
+			};
+
+			usbphy at 020ca000 { /* USBPHY2 */
+				reg = <0x020ca000 0x1000>;
+				interrupts = <77 4 0>;
+			};
+
+			snvs at 020cc000 {
+				reg = <0x020cc000 0x4000>;
+				interrupts = <51 4 0 52 4 0>;
+			};
+
+			epit at 020d0000 { /* EPIT1 */
+				reg = <0x020d0000 0x4000>;
+				interrupts = <88 4 0>;
+			};
+
+			epit at 020d4000 { /* EPIT2 */
+				reg = <0x020d4000 0x4000>;
+				interrupts = <89 4 0>;
+			};
+
+			src at 020d8000 {
+				compatible = "fsl,imx6q-src";
+				reg = <0x020d8000 0x4000>;
+				interrupts = <123 4 0 128 4 0>;
+			};
+
+			gpc at 020dc000 {
+				compatible = "fsl,imx6q-gpc";
+				reg = <0x020dc000 0x4000>;
+				interrupts = <121 4 0 122 4 0>;
+			};
+
+			iomuxc at 020e0000 {
+				reg = <0x020e0000 0x4000>;
+			};
+
+			dcic at 020e4000 { /* DCIC1 */
+				reg = <0x020e4000 0x4000>;
+				interrupts = <156 4 0>;
+			};
+
+			dcic at 020e8000 { /* DCIC2 */
+				reg = <0x020e8000 0x4000>;
+				interrupts = <157 4 0>;
+			};
+
+			sdma at 020ec000 {
+				compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
+				reg = <0x020ec000 0x4000>;
+				interrupts = <34 4 0>;
+			};
+		};
+
+		aips-bus at 02100000 { /* AIPS2 */
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x02100000 0x100000>;
+			ranges;
+
+			caam at 02100000 {
+				reg = <0x02100000 0x40000>;
+				interrupts = <137 4 0 138 4 0>;
+			};
+
+			aipstz at 0217c000 { /* AIPSTZ2 */
+				reg = <0x0217c000 0x4000>;
+			};
+
+			enet at 02188000 {
+				compatible = "fsl,imx6q-fec";
+				reg = <0x02188000 0x4000>;
+				interrupts = <150 4 0 151 4 0>;
+				status = "disabled";
+			};
+
+			mlb at 0218c000 {
+				reg = <0x0218c000 0x4000>;
+				interrupts = <85 4 0 149 4 0 158 4 0>;
+			};
+
+			usdhc at 02190000 { /* uSDHC1 */
+				reg = <0x02190000 0x4000>;
+				interrupts = <54 4 0>;
+			};
+
+			usdhc at 02194000 { /* uSDHC2 */
+				reg = <0x02194000 0x4000>;
+				interrupts = <55 4 0>;
+			};
+
+			usdhc at 02198000 { /* uSDHC3 */
+				reg = <0x02198000 0x4000>;
+				interrupts = <56 4 0>;
+			};
+
+			usdhc at 0219c000 { /* uSDHC4 */
+				reg = <0x0219c000 0x4000>;
+				interrupts = <57 4 0>;
+			};
+
+			i2c at 021a0000 { /* I2C1 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx6q-i2c", "fsl,imx1-i2c";
+				reg = <0x021a0000 0x4000>;
+				interrupts = <68 4 0>;
+				status = "disabled";
+			};
+
+			i2c at 021a4000 { /* I2C2 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx6q-i2c", "fsl,imx1-i2c";
+				reg = <0x021a4000 0x4000>;
+				interrupts = <69 4 0>;
+				status = "disabled";
+			};
+
+			i2c at 021a8000 { /* I2C3 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx6q-i2c", "fsl,imx1-i2c";
+				reg = <0x021a8000 0x4000>;
+				interrupts = <70 4 0>;
+				status = "disabled";
+			};
+
+			romcp at 021ac000 {
+				reg = <0x021ac000 0x4000>;
+			};
+
+			mmdc at 021b0000 { /* MMDC0 */
+				compatible = "fsl,imx6q-mmdc";
+				reg = <0x021b0000 0x4000>;
+			};
+
+			mmdc at 021b4000 { /* MMDC1 */
+				reg = <0x021b4000 0x4000>;
+			};
+
+			weim at 021b8000 {
+				reg = <0x021b8000 0x4000>;
+				interrupts = <46 4 0>;
+			};
+
+			ocotp at 021bc000 {
+				reg = <0x021bc000 0x4000>;
+			};
+
+			ocotp at 021c0000 {
+				reg = <0x021c0000 0x4000>;
+				interrupts = <53 4 0>;
+			};
+
+			tzasc at 021d0000 { /* TZASC1 */
+				reg = <0x021d0000 0x4000>;
+				interrupts = <140 4 0>;
+			};
+
+			tzasc at 021d4000 { /* TZASC2 */
+				reg = <0x021d4000 0x4000>;
+				interrupts = <141 4 0>;
+			};
+
+			audmux at 021d8000 {
+				reg = <0x021d8000 0x4000>;
+			};
+
+			mipi at 021dc000 { /* MIPI-CSI */
+				reg = <0x021dc000 0x4000>;
+			};
+
+			mipi at 021e0000 { /* MIPI-DSI */
+				reg = <0x021e0000 0x4000>;
+			};
+
+			vdoa at 021e4000 {
+				reg = <0x021e4000 0x4000>;
+				interrupts = <50 4 0>;
+			};
+
+			uart1: uart at 021e8000 { /* UART2 */
+				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
+				reg = <0x021e8000 0x4000>;
+				interrupts = <59 4 0>;
+				status = "disabled";
+			};
+
+			uart2: uart at 021ec000 { /* UART3 */
+				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
+				reg = <0x021ec000 0x4000>;
+				interrupts = <60 4 0>;
+				status = "disabled";
+			};
+
+			uart3: uart at 021f0000 { /* UART4 */
+				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
+				reg = <0x021f0000 0x4000>;
+				interrupts = <61 4 0>;
+				status = "disabled";
+			};
+
+			uart4: uart at 021f4000 { /* UART5 */
+				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
+				reg = <0x021f4000 0x4000>;
+				interrupts = <62 4 0>;
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
1.7.4.1
