From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 15 May 2012 20:13:47 +0800
Subject: [PATCH 1/2] ARM: dts: add device tree source for imx6dl
Message-ID: <1337084027-19401-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6dl (i.MX6 DualLite) is a derivative of SoC imx6q, and it's
highly compatible with imx6q.  This patch renames imx6q.dtsi to
imx6.dtsi with some cosmetic changes, and split out the differences
between imx6dl and imx6q into imx6dl.dtsi and imx6q.dtsi respectively.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6.dtsi   |  691 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6dl.dtsi |   62 ++++
 arch/arm/boot/dts/imx6q.dtsi  |  677 +---------------------------------------
 3 files changed, 757 insertions(+), 673 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl.dtsi

diff --git a/arch/arm/boot/dts/imx6.dtsi b/arch/arm/boot/dts/imx6.dtsi
new file mode 100644
index 0000000..72e5434
--- /dev/null
+++ b/arch/arm/boot/dts/imx6.dtsi
@@ -0,0 +1,691 @@
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
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
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
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ckil {
+			compatible = "fsl,imx-ckil", "fixed-clock";
+			clock-frequency = <32768>;
+		};
+
+		ckih1 {
+			compatible = "fsl,imx-ckih1", "fixed-clock";
+			clock-frequency = <0>;
+		};
+
+		osc {
+			compatible = "fsl,imx-osc", "fixed-clock";
+			clock-frequency = <24000000>;
+		};
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
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x00a00600 0x20>;
+			interrupts = <1 13 0xf01>;
+		};
+
+		L2: l2-cache at 00a02000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x00a02000 0x1000>;
+			interrupts = <0 92 0x04>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		aips1: aips-bus at 02000000 {
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
+					interrupts = <0 52 0x04>;
+				};
+
+				ecspi1: ecspi at 02008000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx51-ecspi";
+					reg = <0x02008000 0x4000>;
+					interrupts = <0 31 0x04>;
+					status = "disabled";
+				};
+
+				ecspi2: ecspi at 0200c000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx51-ecspi";
+					reg = <0x0200c000 0x4000>;
+					interrupts = <0 32 0x04>;
+					status = "disabled";
+				};
+
+				ecspi3: ecspi at 02010000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx51-ecspi";
+					reg = <0x02010000 0x4000>;
+					interrupts = <0 33 0x04>;
+					status = "disabled";
+				};
+
+				ecspi4: ecspi at 02014000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx51-ecspi";
+					reg = <0x02014000 0x4000>;
+					interrupts = <0 34 0x04>;
+					status = "disabled";
+				};
+
+				uart1: serial at 02020000 {
+					compatible = "fsl,imx21-uart";
+					reg = <0x02020000 0x4000>;
+					interrupts = <0 26 0x04>;
+					status = "disabled";
+				};
+
+				esai at 02024000 {
+					reg = <0x02024000 0x4000>;
+					interrupts = <0 51 0x04>;
+				};
+
+				ssi1: ssi at 02028000 {
+					compatible = "fsl,imx21-ssi";
+					reg = <0x02028000 0x4000>;
+					interrupts = <0 46 0x04>;
+					fsl,fifo-depth = <15>;
+					fsl,ssi-dma-events = <38 37>;
+					status = "disabled";
+				};
+
+				ssi2: ssi at 0202c000 {
+					compatible = "fsl,imx21-ssi";
+					reg = <0x0202c000 0x4000>;
+					interrupts = <0 47 0x04>;
+					fsl,fifo-depth = <15>;
+					fsl,ssi-dma-events = <42 41>;
+					status = "disabled";
+				};
+
+				ssi3: ssi at 02030000 {
+					compatible = "fsl,imx21-ssi";
+					reg = <0x02030000 0x4000>;
+					interrupts = <0 48 0x04>;
+					fsl,fifo-depth = <15>;
+					fsl,ssi-dma-events = <46 45>;
+					status = "disabled";
+				};
+
+				asrc at 02034000 {
+					reg = <0x02034000 0x4000>;
+					interrupts = <0 50 0x04>;
+				};
+
+				spba at 0203c000 {
+					reg = <0x0203c000 0x4000>;
+				};
+			};
+
+			vpu at 02040000 {
+				reg = <0x02040000 0x3c000>;
+				interrupts = <0 3 0x04 0 12 0x04>;
+			};
+
+			aipstz1: aipstz at 0207c000 {
+				reg = <0x0207c000 0x4000>;
+			};
+
+			pwm1: pwm at 02080000 {
+				reg = <0x02080000 0x4000>;
+				interrupts = <0 83 0x04>;
+			};
+
+			pwm2: pwm at 02084000 {
+				reg = <0x02084000 0x4000>;
+				interrupts = <0 84 0x04>;
+			};
+
+			pwm3: pwm at 02088000 {
+				reg = <0x02088000 0x4000>;
+				interrupts = <0 85 0x04>;
+			};
+
+			pwm4: pwm at 0208c000 {
+				reg = <0x0208c000 0x4000>;
+				interrupts = <0 86 0x04>;
+			};
+
+			can1: flexcan at 02090000 {
+				reg = <0x02090000 0x4000>;
+				interrupts = <0 110 0x04>;
+			};
+
+			can2: flexcan at 02094000 {
+				reg = <0x02094000 0x4000>;
+				interrupts = <0 111 0x04>;
+			};
+
+			gpt at 02098000 {
+				compatible = "fsl,imx6q-gpt";
+				reg = <0x02098000 0x4000>;
+				interrupts = <0 55 0x04>;
+			};
+
+			gpio1: gpio at 0209c000 {
+				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				reg = <0x0209c000 0x4000>;
+				interrupts = <0 66 0x04 0 67 0x04>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio2: gpio at 020a0000 {
+				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				reg = <0x020a0000 0x4000>;
+				interrupts = <0 68 0x04 0 69 0x04>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio3: gpio at 020a4000 {
+				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				reg = <0x020a4000 0x4000>;
+				interrupts = <0 70 0x04 0 71 0x04>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio4: gpio at 020a8000 {
+				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				reg = <0x020a8000 0x4000>;
+				interrupts = <0 72 0x04 0 73 0x04>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio5: gpio at 020ac000 {
+				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				reg = <0x020ac000 0x4000>;
+				interrupts = <0 74 0x04 0 75 0x04>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio6: gpio at 020b0000 {
+				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				reg = <0x020b0000 0x4000>;
+				interrupts = <0 76 0x04 0 77 0x04>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio7: gpio at 020b4000 {
+				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
+				reg = <0x020b4000 0x4000>;
+				interrupts = <0 78 0x04 0 79 0x04>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			kpp at 020b8000 {
+				reg = <0x020b8000 0x4000>;
+				interrupts = <0 82 0x04>;
+			};
+
+			wdog1: wdog at 020bc000 {
+				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
+				reg = <0x020bc000 0x4000>;
+				interrupts = <0 80 0x04>;
+				status = "disabled";
+			};
+
+			wdog2: wdog at 020c0000 {
+				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
+				reg = <0x020c0000 0x4000>;
+				interrupts = <0 81 0x04>;
+				status = "disabled";
+			};
+
+			ccm at 020c4000 {
+				compatible = "fsl,imx6q-ccm";
+				reg = <0x020c4000 0x4000>;
+				interrupts = <0 87 0x04 0 88 0x04>;
+			};
+
+			anatop at 020c8000 {
+				compatible = "fsl,imx6q-anatop";
+				reg = <0x020c8000 0x1000>;
+				interrupts = <0 49 0x04 0 54 0x04 0 127 0x04>;
+
+				regulator-1p1 at 110 {
+					compatible = "fsl,anatop-regulator";
+					regulator-name = "vdd1p1";
+					regulator-min-microvolt = <800000>;
+					regulator-max-microvolt = <1375000>;
+					regulator-always-on;
+					anatop-reg-offset = <0x110>;
+					anatop-vol-bit-shift = <8>;
+					anatop-vol-bit-width = <5>;
+					anatop-min-bit-val = <4>;
+					anatop-min-voltage = <800000>;
+					anatop-max-voltage = <1375000>;
+				};
+
+				regulator-3p0 at 120 {
+					compatible = "fsl,anatop-regulator";
+					regulator-name = "vdd3p0";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <3150000>;
+					regulator-always-on;
+					anatop-reg-offset = <0x120>;
+					anatop-vol-bit-shift = <8>;
+					anatop-vol-bit-width = <5>;
+					anatop-min-bit-val = <0>;
+					anatop-min-voltage = <2625000>;
+					anatop-max-voltage = <3400000>;
+				};
+
+				regulator-2p5 at 130 {
+					compatible = "fsl,anatop-regulator";
+					regulator-name = "vdd2p5";
+					regulator-min-microvolt = <2000000>;
+					regulator-max-microvolt = <2750000>;
+					regulator-always-on;
+					anatop-reg-offset = <0x130>;
+					anatop-vol-bit-shift = <8>;
+					anatop-vol-bit-width = <5>;
+					anatop-min-bit-val = <0>;
+					anatop-min-voltage = <2000000>;
+					anatop-max-voltage = <2750000>;
+				};
+
+				regulator-vddcore at 140 {
+					compatible = "fsl,anatop-regulator";
+					regulator-name = "cpu";
+					regulator-min-microvolt = <725000>;
+					regulator-max-microvolt = <1450000>;
+					regulator-always-on;
+					anatop-reg-offset = <0x140>;
+					anatop-vol-bit-shift = <0>;
+					anatop-vol-bit-width = <5>;
+					anatop-min-bit-val = <1>;
+					anatop-min-voltage = <725000>;
+					anatop-max-voltage = <1450000>;
+				};
+
+				regulator-vddpu at 140 {
+					compatible = "fsl,anatop-regulator";
+					regulator-name = "vddpu";
+					regulator-min-microvolt = <725000>;
+					regulator-max-microvolt = <1450000>;
+					regulator-always-on;
+					anatop-reg-offset = <0x140>;
+					anatop-vol-bit-shift = <9>;
+					anatop-vol-bit-width = <5>;
+					anatop-min-bit-val = <1>;
+					anatop-min-voltage = <725000>;
+					anatop-max-voltage = <1450000>;
+				};
+
+				regulator-vddsoc at 140 {
+					compatible = "fsl,anatop-regulator";
+					regulator-name = "vddsoc";
+					regulator-min-microvolt = <725000>;
+					regulator-max-microvolt = <1450000>;
+					regulator-always-on;
+					anatop-reg-offset = <0x140>;
+					anatop-vol-bit-shift = <18>;
+					anatop-vol-bit-width = <5>;
+					anatop-min-bit-val = <1>;
+					anatop-min-voltage = <725000>;
+					anatop-max-voltage = <1450000>;
+				};
+			};
+
+			usbphy1: usbphy at 020c9000 {
+				reg = <0x020c9000 0x1000>;
+				interrupts = <0 44 0x04>;
+			};
+
+			usbphy2: usbphy at 020ca000 {
+				reg = <0x020ca000 0x1000>;
+				interrupts = <0 45 0x04>;
+			};
+
+			snvs at 020cc000 {
+				reg = <0x020cc000 0x4000>;
+				interrupts = <0 19 0x04 0 20 0x04>;
+			};
+
+			epit1: epit at 020d0000 {
+				reg = <0x020d0000 0x4000>;
+				interrupts = <0 56 0x04>;
+			};
+
+			epit2: epit at 020d4000 {
+				reg = <0x020d4000 0x4000>;
+				interrupts = <0 57 0x04>;
+			};
+
+			src at 020d8000 {
+				compatible = "fsl,imx6q-src";
+				reg = <0x020d8000 0x4000>;
+				interrupts = <0 91 0x04 0 96 0x04>;
+			};
+
+			gpc at 020dc000 {
+				compatible = "fsl,imx6q-gpc";
+				reg = <0x020dc000 0x4000>;
+				interrupts = <0 89 0x04 0 90 0x04>;
+			};
+
+			iomuxc at 020e0000 {
+				compatible = "fsl,imx6q-iomuxc";
+				reg = <0x020e0000 0x4000>;
+
+				/* shared pinctrl settings */
+				audmux {
+					pinctrl_audmux_1: audmux-1 {
+						fsl,pins = <18   0x80000000	/* MX6Q_PAD_SD2_DAT0__AUDMUX_AUD4_RXD */
+							    1586 0x80000000	/* MX6Q_PAD_SD2_DAT3__AUDMUX_AUD4_TXC */
+							    11   0x80000000	/* MX6Q_PAD_SD2_DAT2__AUDMUX_AUD4_TXD */
+							    3    0x80000000>;	/* MX6Q_PAD_SD2_DAT1__AUDMUX_AUD4_TXFS */
+					};
+				};
+
+				i2c1 {
+					pinctrl_i2c1_1: i2c1grp-1 {
+						fsl,pins = <137 0x4001b8b1	/* MX6Q_PAD_EIM_D21__I2C1_SCL */
+							    196 0x4001b8b1>;	/* MX6Q_PAD_EIM_D28__I2C1_SDA */
+					};
+				};
+
+				serial2 {
+					pinctrl_serial2_1: serial2grp-1 {
+						fsl,pins = <183 0x1b0b1		/* MX6Q_PAD_EIM_D26__UART2_TXD */
+							    191 0x1b0b1>;	/* MX6Q_PAD_EIM_D27__UART2_RXD */
+					};
+				};
+
+				usdhc3 {
+					pinctrl_usdhc3_1: usdhc3grp-1 {
+						fsl,pins = <1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
+							    1281 0x10059	/* MX6Q_PAD_SD3_CLK__USDHC3_CLK	*/
+							    1289 0x17059	/* MX6Q_PAD_SD3_DAT0__USDHC3_DAT0 */
+							    1297 0x17059	/* MX6Q_PAD_SD3_DAT1__USDHC3_DAT1 */
+							    1305 0x17059	/* MX6Q_PAD_SD3_DAT2__USDHC3_DAT2 */
+							    1312 0x17059	/* MX6Q_PAD_SD3_DAT3__USDHC3_DAT3 */
+							    1265 0x17059	/* MX6Q_PAD_SD3_DAT4__USDHC3_DAT4 */
+							    1257 0x17059	/* MX6Q_PAD_SD3_DAT5__USDHC3_DAT5 */
+							    1249 0x17059	/* MX6Q_PAD_SD3_DAT6__USDHC3_DAT6 */
+							    1241 0x17059>;	/* MX6Q_PAD_SD3_DAT7__USDHC3_DAT7 */
+					};
+				};
+
+				usdhc4 {
+					pinctrl_usdhc4_1: usdhc4grp-1 {
+						fsl,pins = <1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
+							    1392 0x10059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
+							    1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
+							    1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
+							    1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
+							    1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
+							    1493 0x17059	/* MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 */
+							    1501 0x17059	/* MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 */
+							    1509 0x17059	/* MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 */
+							    1517 0x17059>;	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
+					};
+				};
+			};
+			};
+
+			dcic1: dcic at 020e4000 {
+				reg = <0x020e4000 0x4000>;
+				interrupts = <0 124 0x04>;
+			};
+
+			dcic2: dcic at 020e8000 {
+				reg = <0x020e8000 0x4000>;
+				interrupts = <0 125 0x04>;
+			};
+
+			sdma at 020ec000 {
+				compatible = "fsl,imx35-sdma";
+				reg = <0x020ec000 0x4000>;
+				interrupts = <0 2 0x04>;
+			};
+		};
+
+		aips2: aips-bus at 02100000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x02100000 0x100000>;
+			ranges;
+
+			caam at 02100000 {
+				reg = <0x02100000 0x40000>;
+				interrupts = <0 105 0x04 0 106 0x04>;
+			};
+
+			aipstz2: aipstz at 0217c000 {
+				reg = <0x0217c000 0x4000>;
+			};
+
+			ethernet at 02188000 {
+				compatible = "fsl,imx6q-fec";
+				reg = <0x02188000 0x4000>;
+				interrupts = <0 118 0x04 0 119 0x04>;
+				status = "disabled";
+			};
+
+			mlb at 0218c000 {
+				reg = <0x0218c000 0x4000>;
+				interrupts = <0 53 0x04 0 117 0x04 0 126 0x04>;
+			};
+
+			usdhc1: usdhc at 02190000 {
+				compatible = "fsl,imx6q-usdhc";
+				reg = <0x02190000 0x4000>;
+				interrupts = <0 22 0x04>;
+				status = "disabled";
+			};
+
+			usdhc2: usdhc at 02194000 {
+				compatible = "fsl,imx6q-usdhc";
+				reg = <0x02194000 0x4000>;
+				interrupts = <0 23 0x04>;
+				status = "disabled";
+			};
+
+			usdhc3: usdhc at 02198000 {
+				compatible = "fsl,imx6q-usdhc";
+				reg = <0x02198000 0x4000>;
+				interrupts = <0 24 0x04>;
+				status = "disabled";
+			};
+
+			usdhc4: usdhc at 0219c000 {
+				compatible = "fsl,imx6q-usdhc";
+				reg = <0x0219c000 0x4000>;
+				interrupts = <0 25 0x04>;
+				status = "disabled";
+			};
+
+			i2c1: i2c at 021a0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx1-i2c";
+				reg = <0x021a0000 0x4000>;
+				interrupts = <0 36 0x04>;
+				status = "disabled";
+			};
+
+			i2c2: i2c at 021a4000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx1-i2c";
+				reg = <0x021a4000 0x4000>;
+				interrupts = <0 37 0x04>;
+				status = "disabled";
+			};
+
+			i2c3: i2c at 021a8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx1-i2c";
+				reg = <0x021a8000 0x4000>;
+				interrupts = <0 38 0x04>;
+				status = "disabled";
+			};
+
+			romcp at 021ac000 {
+				reg = <0x021ac000 0x4000>;
+			};
+
+			mmdc0: mmdc at 021b0000 {
+				compatible = "fsl,imx6q-mmdc";
+				reg = <0x021b0000 0x4000>;
+			};
+
+			mmdc1: mmdc at 021b4000 {
+				reg = <0x021b4000 0x4000>;
+			};
+
+			weim at 021b8000 {
+				reg = <0x021b8000 0x4000>;
+				interrupts = <0 14 0x04>;
+			};
+
+			ocotp at 021bc000 {
+				reg = <0x021bc000 0x4000>;
+			};
+
+			ocotp at 021c0000 {
+				reg = <0x021c0000 0x4000>;
+				interrupts = <0 21 0x04>;
+			};
+
+			tzasc1: tzasc at 021d0000 {
+				reg = <0x021d0000 0x4000>;
+				interrupts = <0 108 0x04>;
+			};
+
+			tzasc2: tzasc at 021d4000 {
+				reg = <0x021d4000 0x4000>;
+				interrupts = <0 109 0x04>;
+			};
+
+			audmux at 021d8000 {
+				compatible = "fsl,imx31-audmux";
+				reg = <0x021d8000 0x4000>;
+				status = "disabled";
+			};
+
+			mipi_csi: mipi at 021dc000 {
+				reg = <0x021dc000 0x4000>;
+			};
+
+			mipi_dsi: mipi at 021e0000 {
+				reg = <0x021e0000 0x4000>;
+			};
+
+			vdoa at 021e4000 {
+				reg = <0x021e4000 0x4000>;
+				interrupts = <0 18 0x04>;
+			};
+
+			uart2: serial at 021e8000 {
+				compatible = "fsl,imx21-uart";
+				reg = <0x021e8000 0x4000>;
+				interrupts = <0 27 0x04>;
+				status = "disabled";
+			};
+
+			uart3: serial at 021ec000 {
+				compatible = "fsl,imx21-uart";
+				reg = <0x021ec000 0x4000>;
+				interrupts = <0 28 0x04>;
+				status = "disabled";
+			};
+
+			uart4: serial at 021f0000 {
+				compatible = "fsl,imx21-uart";
+				reg = <0x021f0000 0x4000>;
+				interrupts = <0 29 0x04>;
+				status = "disabled";
+			};
+
+			uart5: serial at 021f4000 {
+				compatible = "fsl,imx21-uart";
+				reg = <0x021f4000 0x4000>;
+				interrupts = <0 30 0x04>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
new file mode 100644
index 0000000..713e51e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -0,0 +1,62 @@
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
+/include/ "imx6.dtsi"
+
+/ {
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
+	};
+
+	soc {
+		aips1: aips-bus at 02000000 {
+			pxp at 020f0000 {
+				reg = <0x020f0000 0x4000>;
+				interrupts = <0 98 0x04>;
+			};
+
+			epdc at 020f4000 {
+				reg = <0x020f4000 0x4000>;
+				interrupts = <0 97 0x04>;
+			};
+
+			lcdif at 020f8000 {
+				reg = <0x020f8000 0x4000>;
+				interrupts = <0 39 0x04>;
+			};
+		};
+
+		aips2: aips-bus at 02100000 {
+			i2c4: i2c at 021f8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx1-i2c";
+				reg = <0x021f8000 0x4000>;
+				interrupts = <0 35 0x04>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 8c90cba..b154232 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -10,17 +10,9 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "skeleton.dtsi"
+/include/ "imx6.dtsi"
 
 / {
-	aliases {
-		serial0 = &uart1;
-		serial1 = &uart2;
-		serial2 = &uart3;
-		serial3 = &uart4;
-		serial4 = &uart5;
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -50,678 +42,17 @@
 		};
 	};
 
-	intc: interrupt-controller at 00a01000 {
-		compatible = "arm,cortex-a9-gic";
-		#interrupt-cells = <3>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		interrupt-controller;
-		reg = <0x00a01000 0x1000>,
-		      <0x00a00100 0x100>;
-	};
-
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ckil {
-			compatible = "fsl,imx-ckil", "fixed-clock";
-			clock-frequency = <32768>;
-		};
-
-		ckih1 {
-			compatible = "fsl,imx-ckih1", "fixed-clock";
-			clock-frequency = <0>;
-		};
-
-		osc {
-			compatible = "fsl,imx-osc", "fixed-clock";
-			clock-frequency = <24000000>;
-		};
-	};
-
 	soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "simple-bus";
-		interrupt-parent = <&intc>;
-		ranges;
-
-		timer at 00a00600 {
-			compatible = "arm,cortex-a9-twd-timer";
-			reg = <0x00a00600 0x20>;
-			interrupts = <1 13 0xf01>;
-		};
-
-		L2: l2-cache at 00a02000 {
-			compatible = "arm,pl310-cache";
-			reg = <0x00a02000 0x1000>;
-			interrupts = <0 92 0x04>;
-			cache-unified;
-			cache-level = <2>;
-		};
-
-		aips-bus at 02000000 { /* AIPS1 */
-			compatible = "fsl,aips-bus", "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x02000000 0x100000>;
-			ranges;
-
+		aips2: aips-bus at 02100000 {
 			spba-bus at 02000000 {
-				compatible = "fsl,spba-bus", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0x02000000 0x40000>;
-				ranges;
-
-				spdif at 02004000 {
-					reg = <0x02004000 0x4000>;
-					interrupts = <0 52 0x04>;
-				};
-
-				ecspi at 02008000 { /* eCSPI1 */
-					#address-cells = <1>;
-					#size-cells = <0>;
-					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
-					reg = <0x02008000 0x4000>;
-					interrupts = <0 31 0x04>;
-					status = "disabled";
-				};
-
-				ecspi at 0200c000 { /* eCSPI2 */
-					#address-cells = <1>;
-					#size-cells = <0>;
-					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
-					reg = <0x0200c000 0x4000>;
-					interrupts = <0 32 0x04>;
-					status = "disabled";
-				};
-
-				ecspi at 02010000 { /* eCSPI3 */
-					#address-cells = <1>;
-					#size-cells = <0>;
-					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
-					reg = <0x02010000 0x4000>;
-					interrupts = <0 33 0x04>;
-					status = "disabled";
-				};
-
-				ecspi at 02014000 { /* eCSPI4 */
+				ecspi5: ecspi at 02018000 {
 					#address-cells = <1>;
 					#size-cells = <0>;
-					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
-					reg = <0x02014000 0x4000>;
-					interrupts = <0 34 0x04>;
-					status = "disabled";
-				};
-
-				ecspi at 02018000 { /* eCSPI5 */
-					#address-cells = <1>;
-					#size-cells = <0>;
-					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
+					compatible = "fsl,imx51-ecspi";
 					reg = <0x02018000 0x4000>;
 					interrupts = <0 35 0x04>;
 					status = "disabled";
 				};
-
-				uart1: serial at 02020000 {
-					compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
-					reg = <0x02020000 0x4000>;
-					interrupts = <0 26 0x04>;
-					status = "disabled";
-				};
-
-				esai at 02024000 {
-					reg = <0x02024000 0x4000>;
-					interrupts = <0 51 0x04>;
-				};
-
-				ssi1: ssi at 02028000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
-					reg = <0x02028000 0x4000>;
-					interrupts = <0 46 0x04>;
-					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <38 37>;
-					status = "disabled";
-				};
-
-				ssi2: ssi at 0202c000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
-					reg = <0x0202c000 0x4000>;
-					interrupts = <0 47 0x04>;
-					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <42 41>;
-					status = "disabled";
-				};
-
-				ssi3: ssi at 02030000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
-					reg = <0x02030000 0x4000>;
-					interrupts = <0 48 0x04>;
-					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <46 45>;
-					status = "disabled";
-				};
-
-				asrc at 02034000 {
-					reg = <0x02034000 0x4000>;
-					interrupts = <0 50 0x04>;
-				};
-
-				spba at 0203c000 {
-					reg = <0x0203c000 0x4000>;
-				};
-			};
-
-			vpu at 02040000 {
-				reg = <0x02040000 0x3c000>;
-				interrupts = <0 3 0x04 0 12 0x04>;
-			};
-
-			aipstz at 0207c000 { /* AIPSTZ1 */
-				reg = <0x0207c000 0x4000>;
-			};
-
-			pwm at 02080000 { /* PWM1 */
-				reg = <0x02080000 0x4000>;
-				interrupts = <0 83 0x04>;
-			};
-
-			pwm at 02084000 { /* PWM2 */
-				reg = <0x02084000 0x4000>;
-				interrupts = <0 84 0x04>;
-			};
-
-			pwm at 02088000 { /* PWM3 */
-				reg = <0x02088000 0x4000>;
-				interrupts = <0 85 0x04>;
-			};
-
-			pwm at 0208c000 { /* PWM4 */
-				reg = <0x0208c000 0x4000>;
-				interrupts = <0 86 0x04>;
-			};
-
-			flexcan at 02090000 { /* CAN1 */
-				reg = <0x02090000 0x4000>;
-				interrupts = <0 110 0x04>;
-			};
-
-			flexcan at 02094000 { /* CAN2 */
-				reg = <0x02094000 0x4000>;
-				interrupts = <0 111 0x04>;
-			};
-
-			gpt at 02098000 {
-				compatible = "fsl,imx6q-gpt";
-				reg = <0x02098000 0x4000>;
-				interrupts = <0 55 0x04>;
-			};
-
-			gpio1: gpio at 0209c000 {
-				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
-				reg = <0x0209c000 0x4000>;
-				interrupts = <0 66 0x04 0 67 0x04>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-
-			gpio2: gpio at 020a0000 {
-				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
-				reg = <0x020a0000 0x4000>;
-				interrupts = <0 68 0x04 0 69 0x04>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-
-			gpio3: gpio at 020a4000 {
-				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
-				reg = <0x020a4000 0x4000>;
-				interrupts = <0 70 0x04 0 71 0x04>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-
-			gpio4: gpio at 020a8000 {
-				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
-				reg = <0x020a8000 0x4000>;
-				interrupts = <0 72 0x04 0 73 0x04>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-
-			gpio5: gpio at 020ac000 {
-				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
-				reg = <0x020ac000 0x4000>;
-				interrupts = <0 74 0x04 0 75 0x04>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-
-			gpio6: gpio at 020b0000 {
-				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
-				reg = <0x020b0000 0x4000>;
-				interrupts = <0 76 0x04 0 77 0x04>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-
-			gpio7: gpio at 020b4000 {
-				compatible = "fsl,imx6q-gpio", "fsl,imx31-gpio";
-				reg = <0x020b4000 0x4000>;
-				interrupts = <0 78 0x04 0 79 0x04>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-
-			kpp at 020b8000 {
-				reg = <0x020b8000 0x4000>;
-				interrupts = <0 82 0x04>;
-			};
-
-			wdog at 020bc000 { /* WDOG1 */
-				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
-				reg = <0x020bc000 0x4000>;
-				interrupts = <0 80 0x04>;
-				status = "disabled";
-			};
-
-			wdog at 020c0000 { /* WDOG2 */
-				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
-				reg = <0x020c0000 0x4000>;
-				interrupts = <0 81 0x04>;
-				status = "disabled";
-			};
-
-			ccm at 020c4000 {
-				compatible = "fsl,imx6q-ccm";
-				reg = <0x020c4000 0x4000>;
-				interrupts = <0 87 0x04 0 88 0x04>;
-			};
-
-			anatop at 020c8000 {
-				compatible = "fsl,imx6q-anatop";
-				reg = <0x020c8000 0x1000>;
-				interrupts = <0 49 0x04 0 54 0x04 0 127 0x04>;
-
-				regulator-1p1 at 110 {
-					compatible = "fsl,anatop-regulator";
-					regulator-name = "vdd1p1";
-					regulator-min-microvolt = <800000>;
-					regulator-max-microvolt = <1375000>;
-					regulator-always-on;
-					anatop-reg-offset = <0x110>;
-					anatop-vol-bit-shift = <8>;
-					anatop-vol-bit-width = <5>;
-					anatop-min-bit-val = <4>;
-					anatop-min-voltage = <800000>;
-					anatop-max-voltage = <1375000>;
-				};
-
-				regulator-3p0 at 120 {
-					compatible = "fsl,anatop-regulator";
-					regulator-name = "vdd3p0";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <3150000>;
-					regulator-always-on;
-					anatop-reg-offset = <0x120>;
-					anatop-vol-bit-shift = <8>;
-					anatop-vol-bit-width = <5>;
-					anatop-min-bit-val = <0>;
-					anatop-min-voltage = <2625000>;
-					anatop-max-voltage = <3400000>;
-				};
-
-				regulator-2p5 at 130 {
-					compatible = "fsl,anatop-regulator";
-					regulator-name = "vdd2p5";
-					regulator-min-microvolt = <2000000>;
-					regulator-max-microvolt = <2750000>;
-					regulator-always-on;
-					anatop-reg-offset = <0x130>;
-					anatop-vol-bit-shift = <8>;
-					anatop-vol-bit-width = <5>;
-					anatop-min-bit-val = <0>;
-					anatop-min-voltage = <2000000>;
-					anatop-max-voltage = <2750000>;
-				};
-
-				regulator-vddcore at 140 {
-					compatible = "fsl,anatop-regulator";
-					regulator-name = "cpu";
-					regulator-min-microvolt = <725000>;
-					regulator-max-microvolt = <1450000>;
-					regulator-always-on;
-					anatop-reg-offset = <0x140>;
-					anatop-vol-bit-shift = <0>;
-					anatop-vol-bit-width = <5>;
-					anatop-min-bit-val = <1>;
-					anatop-min-voltage = <725000>;
-					anatop-max-voltage = <1450000>;
-				};
-
-				regulator-vddpu at 140 {
-					compatible = "fsl,anatop-regulator";
-					regulator-name = "vddpu";
-					regulator-min-microvolt = <725000>;
-					regulator-max-microvolt = <1450000>;
-					regulator-always-on;
-					anatop-reg-offset = <0x140>;
-					anatop-vol-bit-shift = <9>;
-					anatop-vol-bit-width = <5>;
-					anatop-min-bit-val = <1>;
-					anatop-min-voltage = <725000>;
-					anatop-max-voltage = <1450000>;
-				};
-
-				regulator-vddsoc at 140 {
-					compatible = "fsl,anatop-regulator";
-					regulator-name = "vddsoc";
-					regulator-min-microvolt = <725000>;
-					regulator-max-microvolt = <1450000>;
-					regulator-always-on;
-					anatop-reg-offset = <0x140>;
-					anatop-vol-bit-shift = <18>;
-					anatop-vol-bit-width = <5>;
-					anatop-min-bit-val = <1>;
-					anatop-min-voltage = <725000>;
-					anatop-max-voltage = <1450000>;
-				};
-			};
-
-			usbphy at 020c9000 { /* USBPHY1 */
-				reg = <0x020c9000 0x1000>;
-				interrupts = <0 44 0x04>;
-			};
-
-			usbphy at 020ca000 { /* USBPHY2 */
-				reg = <0x020ca000 0x1000>;
-				interrupts = <0 45 0x04>;
-			};
-
-			snvs at 020cc000 {
-				reg = <0x020cc000 0x4000>;
-				interrupts = <0 19 0x04 0 20 0x04>;
-			};
-
-			epit at 020d0000 { /* EPIT1 */
-				reg = <0x020d0000 0x4000>;
-				interrupts = <0 56 0x04>;
-			};
-
-			epit at 020d4000 { /* EPIT2 */
-				reg = <0x020d4000 0x4000>;
-				interrupts = <0 57 0x04>;
-			};
-
-			src at 020d8000 {
-				compatible = "fsl,imx6q-src";
-				reg = <0x020d8000 0x4000>;
-				interrupts = <0 91 0x04 0 96 0x04>;
-			};
-
-			gpc at 020dc000 {
-				compatible = "fsl,imx6q-gpc";
-				reg = <0x020dc000 0x4000>;
-				interrupts = <0 89 0x04 0 90 0x04>;
-			};
-
-			iomuxc at 020e0000 {
-				compatible = "fsl,imx6q-iomuxc";
-				reg = <0x020e0000 0x4000>;
-
-				/* shared pinctrl settings */
-				audmux {
-					pinctrl_audmux_1: audmux-1 {
-						fsl,pins = <18   0x80000000	/* MX6Q_PAD_SD2_DAT0__AUDMUX_AUD4_RXD */
-							    1586 0x80000000	/* MX6Q_PAD_SD2_DAT3__AUDMUX_AUD4_TXC */
-							    11   0x80000000	/* MX6Q_PAD_SD2_DAT2__AUDMUX_AUD4_TXD */
-							    3    0x80000000>;	/* MX6Q_PAD_SD2_DAT1__AUDMUX_AUD4_TXFS */
-					};
-				};
-
-				i2c1 {
-					pinctrl_i2c1_1: i2c1grp-1 {
-						fsl,pins = <137 0x4001b8b1	/* MX6Q_PAD_EIM_D21__I2C1_SCL */
-							    196 0x4001b8b1>;	/* MX6Q_PAD_EIM_D28__I2C1_SDA */
-					};
-				};
-
-				serial2 {
-					pinctrl_serial2_1: serial2grp-1 {
-						fsl,pins = <183 0x1b0b1		/* MX6Q_PAD_EIM_D26__UART2_TXD */
-							    191 0x1b0b1>;	/* MX6Q_PAD_EIM_D27__UART2_RXD */
-					};
-				};
-
-				usdhc3 {
-					pinctrl_usdhc3_1: usdhc3grp-1 {
-						fsl,pins = <1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
-							    1281 0x10059	/* MX6Q_PAD_SD3_CLK__USDHC3_CLK	*/
-							    1289 0x17059	/* MX6Q_PAD_SD3_DAT0__USDHC3_DAT0 */
-							    1297 0x17059	/* MX6Q_PAD_SD3_DAT1__USDHC3_DAT1 */
-							    1305 0x17059	/* MX6Q_PAD_SD3_DAT2__USDHC3_DAT2 */
-							    1312 0x17059	/* MX6Q_PAD_SD3_DAT3__USDHC3_DAT3 */
-							    1265 0x17059	/* MX6Q_PAD_SD3_DAT4__USDHC3_DAT4 */
-							    1257 0x17059	/* MX6Q_PAD_SD3_DAT5__USDHC3_DAT5 */
-							    1249 0x17059	/* MX6Q_PAD_SD3_DAT6__USDHC3_DAT6 */
-							    1241 0x17059>;	/* MX6Q_PAD_SD3_DAT7__USDHC3_DAT7 */
-					};
-				};
-
-				usdhc4 {
-					pinctrl_usdhc4_1: usdhc4grp-1 {
-						fsl,pins = <1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
-							    1392 0x10059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
-							    1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
-							    1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
-							    1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
-							    1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
-							    1493 0x17059	/* MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 */
-							    1501 0x17059	/* MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 */
-							    1509 0x17059	/* MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 */
-							    1517 0x17059>;	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
-					};
-				};
-			};
-
-			dcic at 020e4000 { /* DCIC1 */
-				reg = <0x020e4000 0x4000>;
-				interrupts = <0 124 0x04>;
-			};
-
-			dcic at 020e8000 { /* DCIC2 */
-				reg = <0x020e8000 0x4000>;
-				interrupts = <0 125 0x04>;
-			};
-
-			sdma at 020ec000 {
-				compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
-				reg = <0x020ec000 0x4000>;
-				interrupts = <0 2 0x04>;
-			};
-		};
-
-		aips-bus at 02100000 { /* AIPS2 */
-			compatible = "fsl,aips-bus", "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x02100000 0x100000>;
-			ranges;
-
-			caam at 02100000 {
-				reg = <0x02100000 0x40000>;
-				interrupts = <0 105 0x04 0 106 0x04>;
-			};
-
-			aipstz at 0217c000 { /* AIPSTZ2 */
-				reg = <0x0217c000 0x4000>;
-			};
-
-			ethernet at 02188000 {
-				compatible = "fsl,imx6q-fec";
-				reg = <0x02188000 0x4000>;
-				interrupts = <0 118 0x04 0 119 0x04>;
-				status = "disabled";
-			};
-
-			mlb at 0218c000 {
-				reg = <0x0218c000 0x4000>;
-				interrupts = <0 53 0x04 0 117 0x04 0 126 0x04>;
-			};
-
-			usdhc at 02190000 { /* uSDHC1 */
-				compatible = "fsl,imx6q-usdhc";
-				reg = <0x02190000 0x4000>;
-				interrupts = <0 22 0x04>;
-				status = "disabled";
-			};
-
-			usdhc at 02194000 { /* uSDHC2 */
-				compatible = "fsl,imx6q-usdhc";
-				reg = <0x02194000 0x4000>;
-				interrupts = <0 23 0x04>;
-				status = "disabled";
-			};
-
-			usdhc at 02198000 { /* uSDHC3 */
-				compatible = "fsl,imx6q-usdhc";
-				reg = <0x02198000 0x4000>;
-				interrupts = <0 24 0x04>;
-				status = "disabled";
-			};
-
-			usdhc at 0219c000 { /* uSDHC4 */
-				compatible = "fsl,imx6q-usdhc";
-				reg = <0x0219c000 0x4000>;
-				interrupts = <0 25 0x04>;
-				status = "disabled";
-			};
-
-			i2c at 021a0000 { /* I2C1 */
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx6q-i2c", "fsl,imx1-i2c";
-				reg = <0x021a0000 0x4000>;
-				interrupts = <0 36 0x04>;
-				status = "disabled";
-			};
-
-			i2c at 021a4000 { /* I2C2 */
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx6q-i2c", "fsl,imx1-i2c";
-				reg = <0x021a4000 0x4000>;
-				interrupts = <0 37 0x04>;
-				status = "disabled";
-			};
-
-			i2c at 021a8000 { /* I2C3 */
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx6q-i2c", "fsl,imx1-i2c";
-				reg = <0x021a8000 0x4000>;
-				interrupts = <0 38 0x04>;
-				status = "disabled";
-			};
-
-			romcp at 021ac000 {
-				reg = <0x021ac000 0x4000>;
-			};
-
-			mmdc at 021b0000 { /* MMDC0 */
-				compatible = "fsl,imx6q-mmdc";
-				reg = <0x021b0000 0x4000>;
-			};
-
-			mmdc at 021b4000 { /* MMDC1 */
-				reg = <0x021b4000 0x4000>;
-			};
-
-			weim at 021b8000 {
-				reg = <0x021b8000 0x4000>;
-				interrupts = <0 14 0x04>;
-			};
-
-			ocotp at 021bc000 {
-				reg = <0x021bc000 0x4000>;
-			};
-
-			ocotp at 021c0000 {
-				reg = <0x021c0000 0x4000>;
-				interrupts = <0 21 0x04>;
-			};
-
-			tzasc at 021d0000 { /* TZASC1 */
-				reg = <0x021d0000 0x4000>;
-				interrupts = <0 108 0x04>;
-			};
-
-			tzasc at 021d4000 { /* TZASC2 */
-				reg = <0x021d4000 0x4000>;
-				interrupts = <0 109 0x04>;
-			};
-
-			audmux at 021d8000 {
-				compatible = "fsl,imx6q-audmux", "fsl,imx31-audmux";
-				reg = <0x021d8000 0x4000>;
-				status = "disabled";
-			};
-
-			mipi at 021dc000 { /* MIPI-CSI */
-				reg = <0x021dc000 0x4000>;
-			};
-
-			mipi at 021e0000 { /* MIPI-DSI */
-				reg = <0x021e0000 0x4000>;
-			};
-
-			vdoa at 021e4000 {
-				reg = <0x021e4000 0x4000>;
-				interrupts = <0 18 0x04>;
-			};
-
-			uart2: serial at 021e8000 {
-				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
-				reg = <0x021e8000 0x4000>;
-				interrupts = <0 27 0x04>;
-				status = "disabled";
-			};
-
-			uart3: serial at 021ec000 {
-				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
-				reg = <0x021ec000 0x4000>;
-				interrupts = <0 28 0x04>;
-				status = "disabled";
-			};
-
-			uart4: serial at 021f0000 {
-				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
-				reg = <0x021f0000 0x4000>;
-				interrupts = <0 29 0x04>;
-				status = "disabled";
-			};
-
-			uart5: serial at 021f4000 {
-				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
-				reg = <0x021f4000 0x4000>;
-				interrupts = <0 30 0x04>;
-				status = "disabled";
 			};
 		};
 	};
-- 
1.7.4.1
