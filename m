From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 20 Nov 2012 15:05:33 -0200
Subject: [PATCH v2] ARM: mx5: Replace clk_register_clkdev with clock DT lookup
Message-ID: <1353431133-3643-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
task for the clock devices easier.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Removed duplicated clock entries and clk_max
- Fix imx51/imx53 names in the explanation of fsl,<soc>-ccm
- Fix sdhc clocks

 .../devicetree/bindings/clock/imx5-clock.txt       |  191 ++++++++++++++++++++
 arch/arm/boot/dts/imx51.dtsi                       |   39 ++++
 arch/arm/boot/dts/imx53.dtsi                       |   48 +++++
 arch/arm/mach-imx/clk-imx51-imx53.c                |   26 +--
 arch/arm/mach-imx/imx51-dt.c                       |   28 +--
 arch/arm/mach-imx/mach-imx53.c                     |   31 +---
 6 files changed, 293 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx5-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.txt b/Documentation/devicetree/bindings/clock/imx5-clock.txt
new file mode 100644
index 0000000..50380aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx5-clock.txt
@@ -0,0 +1,191 @@
+* Clock bindings for Freescale i.MX5
+
+Required properties:
+- compatible: Should be "fsl,<soc>-ccm" , where <soc> can be imx51 or imx53
+- reg: Address and length of the register set
+- interrupts: Should contain CCM interrupt
+- #clock-cells: Should be <1>
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.  The following is a full list of i.MX5
+clocks and IDs.
+
+	Clock			ID
+	---------------------------
+	dummy			0
+	ckil			1
+	osc			2
+	ckih1			3
+	ckih2			4
+	ahb			5
+	ipg			6
+	axi_a			7
+	axi_b			8
+	uart_pred		9
+	uart_root		10
+	esdhc_a_pred		11
+	esdhc_b_pred		12
+	esdhc_c_s		13
+	esdhc_d_s		14
+	emi_sel			15
+	emi_slow_podf		16
+	nfc_podf		17
+	ecspi_pred		18
+	ecspi_podf		19
+	usboh3_pred		20
+	usboh3_podf		21
+	usb_phy_pred		22
+	usb_phy_podf		23
+	cpu_podf		24
+	di_pred			25
+	tve_di			26
+	tve_s			27
+	uart1_ipg_gate		28
+	uart1_per_gate		29
+	uart2_ipg_gate		30
+	uart2_per_gate		31
+	uart3_ipg_gate		32
+	uart3_per_gate		33
+	i2c1_gate		34
+	i2c2_gate		35
+	gpt_ipg_gate		36
+	pwm1_ipg_gate		37
+	pwm1_hf_gate		38
+	pwm2_ipg_gate		39
+	pwm2_hf_gate		40
+	gpt_hf_gate		41
+	fec_gate		42
+	usboh3_per_gate		43
+	esdhc1_ipg_gate		44
+	esdhc2_ipg_gate		45
+	esdhc3_ipg_gate		46
+	esdhc4_ipg_gate		47
+	ssi1_ipg_gate		48
+	ssi2_ipg_gate		49
+	ssi3_ipg_gate		50
+	ecspi1_ipg_gate		51
+	ecspi1_per_gate		52
+	ecspi2_ipg_gate		53
+	ecspi2_per_gate		54
+	cspi_ipg_gate		55
+	sdma_gate		56
+	emi_slow_gate		57
+	ipu_s			58
+	ipu_gate		59
+	nfc_gate		60
+	ipu_di1_gate		61
+	vpu_s			62
+	vpu_gate		63
+	vpu_reference_gate	64
+	uart4_ipg_gate		65
+	uart4_per_gate		66
+	uart5_ipg_gate		67
+	uart5_per_gate		68
+	tve_gate		69
+	tve_pred		70
+	esdhc1_per_gate		71
+	esdhc2_per_gate		72
+	esdhc3_per_gate		73
+	esdhc4_per_gate		74
+	usb_phy_gate		75
+	hsi2c_gate		76
+	mipi_hsc1_gate		77
+	mipi_hsc2_gate		78
+	mipi_esc_gate		79
+	mipi_hsp_gate		80
+	ldb_di1_div_3_5		81
+	ldb_di1_div		82
+	ldb_di0_div_3_5		83
+	ldb_di0_div		84
+	ldb_di1_gate		85
+	can2_serial_gate	86
+	can2_ipg_gate		87
+	i2c3_gate		88
+	lp_apm			89
+	periph_apm		100
+	main_bus		101
+	ahb_max			102
+	aips_tz1		103
+	aips_tz2		104
+	tmax1			105
+	tmax2			106
+	tmax3			107
+	spba			108
+	uart_sel		109
+	esdhc_a_sel		110
+	esdhc_b_sel		111
+	esdhc_a_podf		112
+	esdhc_b_podf		113
+	ecspi_sel		114
+	usboh3_sel		115
+	usb_phy_sel		116
+	iim_gate		117
+	usboh3_gate		118
+	emi_fast_gate		119
+	ipu_di0_gate		120
+	gpc_dvfs		121
+	pll1_sw			122
+	pll2_sw			123
+	pll3_sw			124
+	ipu_di0_sel		125
+	ipu_di1_sel		126
+	tve_ext_sel		127
+	mx51_mipi		128
+	pll4_sw			129
+	ldb_di1_sel		130
+	di_pll4_podf		131
+	ldb_di0_sel		132
+	ldb_di0_gate		133
+	usb_phy1_gate		134
+	usb_phy2_gate		135
+	per_lp_apm		136
+	per_pred1		137
+	per_pred2		138
+	per_podf		139
+	per_root		140
+	ssi_apm			141
+	ssi1_root_sel		142
+	ssi2_root_sel		143
+	ssi3_root_sel		144
+	ssi_ext1_sel		145
+	ssi_ext2_sel		146
+	ssi_ext1_com_sel	147
+	ssi_ext2_com_sel	148
+	ssi1_root_pred		149
+	ssi1_root_podf		150
+	ssi2_root_pred		151
+	ssi2_root_podf		152
+	ssi_ext1_pred		153
+	ssi_ext1_podf		154
+	ssi_ext2_pred		155
+	ssi_ext2_podf		156
+	ssi1_root_gate		157
+	ssi2_root_gate		158
+	ssi3_root_gate		159
+	ssi_ext1_gate		160
+	ssi_ext2_gate		161
+	epit1_ipg_gate		162
+	epit1_hf_gate		163
+	epit2_ipg_gate		164
+	epit2_hf_gate		165
+	can_sel			166
+	can1_serial_gate	167
+	can1_ipg_gate		168
+
+Examples (for mx53):
+
+clks: ccm at 53fd4000{
+	compatible = "fsl,imx53-ccm";
+	reg = <0x53fd4000 0x4000>;
+	interrupts = <0 71 0x04 0 72 0x04>;
+	#clock-cells = <1>;
+};
+
+can1: can at 53fc8000 {
+	compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
+	reg = <0x53fc8000 0x4000>;
+	interrupts = <82>;
+	clocks = <&clks 168>, <&clks 167>;
+	clock-names = "ipg", "per";
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 54aea74..991a34f 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -80,6 +80,8 @@
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70004000 0x4000>;
 					interrupts = <1>;
+					clocks = <&clks 44>, <&clks 0>, <&clks 71>;
+					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
 
@@ -87,6 +89,8 @@
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70008000 0x4000>;
 					interrupts = <2>;
+					clocks = <&clks 45>, <&clks 0>, <&clks 72>;
+					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
 
@@ -94,6 +98,8 @@
 					compatible = "fsl,imx51-uart", "fsl,imx21-uart";
 					reg = <0x7000c000 0x4000>;
 					interrupts = <33>;
+					clocks = <&clks 32>, <&clks 33>;
+					clock-names = "ipg", "per";
 					status = "disabled";
 				};
 
@@ -103,6 +109,8 @@
 					compatible = "fsl,imx51-ecspi";
 					reg = <0x70010000 0x4000>;
 					interrupts = <36>;
+					clocks = <&clks 51>, <&clks 52>;
+					clock-names = "ipg", "per";
 					status = "disabled";
 				};
 
@@ -110,6 +118,7 @@
 					compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 					reg = <0x70014000 0x4000>;
 					interrupts = <30>;
+					clocks = <&clks 49>;
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
 					status = "disabled";
@@ -119,6 +128,8 @@
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70020000 0x4000>;
 					interrupts = <3>;
+					clocks = <&clks 46>, <&clks 0>, <&clks 73>;
+					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
 
@@ -126,6 +137,8 @@
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70024000 0x4000>;
 					interrupts = <4>;
+					clocks = <&clks 47>, <&clks 0>, <&clks 74>;
+					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
 			};
@@ -202,12 +215,14 @@
 				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
 				reg = <0x73f98000 0x4000>;
 				interrupts = <58>;
+				clocks = <&clks 0>;
 			};
 
 			wdog at 73f9c000 { /* WDOG2 */
 				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
 				reg = <0x73f9c000 0x4000>;
 				interrupts = <59>;
+				clocks = <&clks 0>;
 				status = "disabled";
 			};
 
@@ -331,6 +346,8 @@
 				compatible = "fsl,imx51-uart", "fsl,imx21-uart";
 				reg = <0x73fbc000 0x4000>;
 				interrupts = <31>;
+				clocks = <&clks 28>, <&clks 29>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -338,8 +355,17 @@
 				compatible = "fsl,imx51-uart", "fsl,imx21-uart";
 				reg = <0x73fc0000 0x4000>;
 				interrupts = <32>;
+				clocks = <&clks 30>, <&clks 31>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
+
+			clks: ccm at 73fd4000{
+				compatible = "fsl,imx51-ccm";
+				reg = <0x73fd4000 0x4000>;
+				interrupts = <0 71 0x04 0 72 0x04>;
+				#clock-cells = <1>;
+			};
 		};
 
 		aips at 80000000 {	/* AIPS2 */
@@ -355,6 +381,8 @@
 				compatible = "fsl,imx51-ecspi";
 				reg = <0x83fac000 0x4000>;
 				interrupts = <37>;
+				clocks = <&clks 53>, <&clks 54>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -362,6 +390,8 @@
 				compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
 				reg = <0x83fb0000 0x4000>;
 				interrupts = <6>;
+				clocks = <&clks 56>, <&clks 56>;
+				clock-names = "ipg", "ahb";
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
 			};
 
@@ -371,6 +401,8 @@
 				compatible = "fsl,imx51-cspi", "fsl,imx35-cspi";
 				reg = <0x83fc0000 0x4000>;
 				interrupts = <38>;
+				clocks = <&clks 55>, <&clks 0>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -380,6 +412,7 @@
 				compatible = "fsl,imx51-i2c", "fsl,imx21-i2c";
 				reg = <0x83fc4000 0x4000>;
 				interrupts = <63>;
+				clocks = <&clks 35>;
 				status = "disabled";
 			};
 
@@ -389,6 +422,7 @@
 				compatible = "fsl,imx51-i2c", "fsl,imx21-i2c";
 				reg = <0x83fc8000 0x4000>;
 				interrupts = <62>;
+				clocks = <&clks 34>;
 				status = "disabled";
 			};
 
@@ -396,6 +430,7 @@
 				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 				reg = <0x83fcc000 0x4000>;
 				interrupts = <29>;
+				clocks = <&clks 48>;
 				fsl,fifo-depth = <15>;
 				fsl,ssi-dma-events = <29 28 27 26>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
@@ -411,6 +446,7 @@
 				compatible = "fsl,imx51-nand";
 				reg = <0x83fdb000 0x1000 0xcfff0000 0x10000>;
 				interrupts = <8>;
+				clocks = <&clks 60>;
 				status = "disabled";
 			};
 
@@ -418,6 +454,7 @@
 				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 				reg = <0x83fe8000 0x4000>;
 				interrupts = <96>;
+				clocks = <&clks 50>;
 				fsl,fifo-depth = <15>;
 				fsl,ssi-dma-events = <47 46 37 35>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
@@ -427,6 +464,8 @@
 				compatible = "fsl,imx51-fec", "fsl,imx27-fec";
 				reg = <0x83fec000 0x4000>;
 				interrupts = <87>;
+				clocks = <&clks 42>, <&clks 42>, <&clks 42>;
+				clock-names = "ipg", "ahb", "ptp";
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index caf09ff..b80334f 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -85,6 +85,8 @@
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50004000 0x4000>;
 					interrupts = <1>;
+					clocks = <&clks 44>, <&clks 0>, <&clks 71>;
+					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
 
@@ -92,6 +94,8 @@
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50008000 0x4000>;
 					interrupts = <2>;
+					clocks = <&clks 45>, <&clks 0>, <&clks 72>;
+					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
 
@@ -99,6 +103,8 @@
 					compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 					reg = <0x5000c000 0x4000>;
 					interrupts = <33>;
+					clocks = <&clks 32>, <&clks 33>;
+					clock-names = "ipg", "per";
 					status = "disabled";
 				};
 
@@ -108,6 +114,8 @@
 					compatible = "fsl,imx53-ecspi", "fsl,imx51-ecspi";
 					reg = <0x50010000 0x4000>;
 					interrupts = <36>;
+					clocks = <&clks 51>, <&clks 52>;
+					clock-names = "ipg", "per";
 					status = "disabled";
 				};
 
@@ -115,6 +123,7 @@
 					compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
 					reg = <0x50014000 0x4000>;
 					interrupts = <30>;
+					clocks = <&clks 49>;
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
 					status = "disabled";
@@ -124,6 +133,8 @@
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50020000 0x4000>;
 					interrupts = <3>;
+					clocks = <&clks 46>, <&clks 0>, <&clks 73>;
+					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
 
@@ -131,6 +142,8 @@
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50024000 0x4000>;
 					interrupts = <4>;
+					clocks = <&clks 47>, <&clks 0>, <&clks 74>;
+					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
 			};
@@ -207,12 +220,14 @@
 				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
 				reg = <0x53f98000 0x4000>;
 				interrupts = <58>;
+				clocks = <&clks 0>;
 			};
 
 			wdog at 53f9c000 { /* WDOG2 */
 				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
 				reg = <0x53f9c000 0x4000>;
 				interrupts = <59>;
+				clocks = <&clks 0>;
 				status = "disabled";
 			};
 
@@ -375,6 +390,8 @@
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x53fbc000 0x4000>;
 				interrupts = <31>;
+				clocks = <&clks 28>, <&clks 29>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -382,6 +399,8 @@
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x53fc0000 0x4000>;
 				interrupts = <32>;
+				clocks = <&clks 30>, <&clks 31>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -389,6 +408,8 @@
 				compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
 				reg = <0x53fc8000 0x4000>;
 				interrupts = <82>;
+				clocks = <&clks 168>, <&clks 167>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -396,9 +417,18 @@
 				compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
 				reg = <0x53fcc000 0x4000>;
 				interrupts = <83>;
+				clocks = <&clks 168>, <&clks 167>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
+			clks: ccm at 53fd4000{
+				compatible = "fsl,imx53-ccm";
+				reg = <0x53fd4000 0x4000>;
+				interrupts = <0 71 0x04 0 72 0x04>;
+				#clock-cells = <1>;
+			};
+
 			gpio5: gpio at 53fdc000 {
 				compatible = "fsl,imx53-gpio", "fsl,imx35-gpio";
 				reg = <0x53fdc000 0x4000>;
@@ -435,6 +465,7 @@
 				compatible = "fsl,imx53-i2c", "fsl,imx21-i2c";
 				reg = <0x53fec000 0x4000>;
 				interrupts = <64>;
+				clocks = <&clks 88>;
 				status = "disabled";
 			};
 
@@ -442,6 +473,8 @@
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x53ff0000 0x4000>;
 				interrupts = <13>;
+				clocks = <&clks 65>, <&clks 66>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 		};
@@ -457,6 +490,8 @@
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x63f90000 0x4000>;
 				interrupts = <86>;
+				clocks = <&clks 67>, <&clks 68>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -466,6 +501,8 @@
 				compatible = "fsl,imx53-ecspi", "fsl,imx51-ecspi";
 				reg = <0x63fac000 0x4000>;
 				interrupts = <37>;
+				clocks = <&clks 53>, <&clks 54>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -473,6 +510,8 @@
 				compatible = "fsl,imx53-sdma", "fsl,imx35-sdma";
 				reg = <0x63fb0000 0x4000>;
 				interrupts = <6>;
+				clocks = <&clks 56>, <&clks 56>;
+				clock-names = "ipg", "ahb";
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
 			};
 
@@ -482,6 +521,8 @@
 				compatible = "fsl,imx53-cspi", "fsl,imx35-cspi";
 				reg = <0x63fc0000 0x4000>;
 				interrupts = <38>;
+				clocks = <&clks 55>, <&clks 0>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -491,6 +532,7 @@
 				compatible = "fsl,imx53-i2c", "fsl,imx21-i2c";
 				reg = <0x63fc4000 0x4000>;
 				interrupts = <63>;
+				clocks = <&clks 35>;
 				status = "disabled";
 			};
 
@@ -500,6 +542,7 @@
 				compatible = "fsl,imx53-i2c", "fsl,imx21-i2c";
 				reg = <0x63fc8000 0x4000>;
 				interrupts = <62>;
+				clocks = <&clks 34>;
 				status = "disabled";
 			};
 
@@ -507,6 +550,7 @@
 				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
 				reg = <0x63fcc000 0x4000>;
 				interrupts = <29>;
+				clocks = <&clks 48>;
 				fsl,fifo-depth = <15>;
 				fsl,ssi-dma-events = <29 28 27 26>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
@@ -522,6 +566,7 @@
 				compatible = "fsl,imx53-nand";
 				reg = <0x63fdb000 0x1000 0xf7ff0000 0x10000>;
 				interrupts = <8>;
+				clocks = <&clks 60>;
 				status = "disabled";
 			};
 
@@ -529,6 +574,7 @@
 				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
 				reg = <0x63fe8000 0x4000>;
 				interrupts = <96>;
+				clocks = <&clks 50>;
 				fsl,fifo-depth = <15>;
 				fsl,ssi-dma-events = <47 46 45 44>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
@@ -538,6 +584,8 @@
 				compatible = "fsl,imx53-fec", "fsl,imx25-fec";
 				reg = <0x63fec000 0x4000>;
 				interrupts = <87>;
+				clocks = <&clks 42>, <&clks 42>, <&clks 42>;
+				clock-names = "ipg", "ahb", "ptp";
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 6cb9795..0e92562 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -87,6 +87,7 @@ enum imx5_clks {
 };
 
 static struct clk *clk[clk_max];
+static struct clk_onecell_data clk_data;
 
 static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 		unsigned long rate_osc, unsigned long rate_ckih1,
@@ -314,6 +315,7 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 			unsigned long rate_ckih1, unsigned long rate_ckih2)
 {
 	int i;
+	struct device_node *np;
 
 	clk[pll1_sw] = imx_clk_pllv2("pll1_sw", "osc", MX51_DPLL1_BASE);
 	clk[pll2_sw] = imx_clk_pllv2("pll2_sw", "osc", MX51_DPLL2_BASE);
@@ -342,6 +344,11 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 			pr_err("i.MX51 clk %d: register failed with %ld\n",
 				i, PTR_ERR(clk[i]));
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx51-ccm");
+	clk_data.clks = clk;
+	clk_data.clk_num = ARRAY_SIZE(clk);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+
 	mx5_clocks_common_init(rate_ckil, rate_osc, rate_ckih1, rate_ckih2);
 
 	clk_register_clkdev(clk[hsi2c_gate], NULL, "imx21-i2c.2");
@@ -365,10 +372,6 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_register_clkdev(clk[esdhc4_ipg_gate], "ipg", "sdhci-esdhc-imx51.3");
 	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx51.3");
 	clk_register_clkdev(clk[esdhc4_per_gate], "per", "sdhci-esdhc-imx51.3");
-	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "83fcc000.ssi");
-	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "70014000.ssi");
-	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "83fe8000.ssi");
-	clk_register_clkdev(clk[nfc_gate], NULL, "83fdb000.nand");
 
 	/* set the usboh3 parent to pll2_sw */
 	clk_set_parent(clk[usboh3_sel], clk[pll2_sw]);
@@ -392,6 +395,7 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 {
 	int i;
 	unsigned long r;
+	struct device_node *np;
 
 	clk[pll1_sw] = imx_clk_pllv2("pll1_sw", "osc", MX53_DPLL1_BASE);
 	clk[pll2_sw] = imx_clk_pllv2("pll2_sw", "osc", MX53_DPLL2_BASE);
@@ -436,6 +440,11 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 			pr_err("i.MX53 clk %d: register failed with %ld\n",
 				i, PTR_ERR(clk[i]));
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx53-ccm");
+	clk_data.clks = clk;
+	clk_data.clk_num = ARRAY_SIZE(clk);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+
 	mx5_clocks_common_init(rate_ckil, rate_osc, rate_ckih1, rate_ckih2);
 
 	clk_register_clkdev(clk[vpu_gate], NULL, "imx53-vpu.0");
@@ -458,15 +467,6 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_register_clkdev(clk[esdhc4_ipg_gate], "ipg", "sdhci-esdhc-imx53.3");
 	clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx53.3");
 	clk_register_clkdev(clk[esdhc4_per_gate], "per", "sdhci-esdhc-imx53.3");
-	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "63fcc000.ssi");
-	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "50014000.ssi");
-	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "63fd0000.ssi");
-	clk_register_clkdev(clk[nfc_gate], NULL, "63fdb000.nand");
-	clk_register_clkdev(clk[can1_ipg_gate], "ipg", "53fc8000.can");
-	clk_register_clkdev(clk[can1_serial_gate], "per", "53fc8000.can");
-	clk_register_clkdev(clk[can2_ipg_gate], "ipg", "53fcc000.can");
-	clk_register_clkdev(clk[can2_serial_gate], "per", "53fcc000.can");
-	clk_register_clkdev(clk[dummy], NULL, "53fa4000.rtc");
 
 	/* set SDHC root clock to 200MHZ*/
 	clk_set_rate(clk[esdhc_a_podf], 200000000);
diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index 5074299..5ffa40c 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -19,35 +19,9 @@
 #include "common.h"
 #include "mx51.h"
 
-/*
- * Lookup table for attaching a specific name and platform_data pointer to
- * devices as they get created by of_platform_populate().  Ideally this table
- * would not exist, but the current clock implementation depends on some devices
- * having a specific name.
- */
-static const struct of_dev_auxdata imx51_auxdata_lookup[] __initconst = {
-	OF_DEV_AUXDATA("fsl,imx51-uart", MX51_UART1_BASE_ADDR, "imx21-uart.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx51-uart", MX51_UART2_BASE_ADDR, "imx21-uart.1", NULL),
-	OF_DEV_AUXDATA("fsl,imx51-uart", MX51_UART3_BASE_ADDR, "imx21-uart.2", NULL),
-	OF_DEV_AUXDATA("fsl,imx51-fec", MX51_FEC_BASE_ADDR, "imx27-fec.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC1_BASE_ADDR, "sdhci-esdhc-imx51.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC2_BASE_ADDR, "sdhci-esdhc-imx51.1", NULL),
-	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC3_BASE_ADDR, "sdhci-esdhc-imx51.2", NULL),
-	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC4_BASE_ADDR, "sdhci-esdhc-imx51.3", NULL),
-	OF_DEV_AUXDATA("fsl,imx51-ecspi", MX51_ECSPI1_BASE_ADDR, "imx51-ecspi.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx51-ecspi", MX51_ECSPI2_BASE_ADDR, "imx51-ecspi.1", NULL),
-	OF_DEV_AUXDATA("fsl,imx51-cspi", MX51_CSPI_BASE_ADDR, "imx35-cspi.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx51-i2c", MX51_I2C1_BASE_ADDR, "imx21-i2c.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx51-i2c", MX51_I2C2_BASE_ADDR, "imx21-i2c.1", NULL),
-	OF_DEV_AUXDATA("fsl,imx51-sdma", MX51_SDMA_BASE_ADDR, "imx35-sdma", NULL),
-	OF_DEV_AUXDATA("fsl,imx51-wdt", MX51_WDOG1_BASE_ADDR, "imx2-wdt.0", NULL),
-	{ /* sentinel */ }
-};
-
 static void __init imx51_dt_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     imx51_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static void __init imx51_timer_init(void)
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index e71e6261..860284d 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -23,34 +23,6 @@
 #include "common.h"
 #include "mx53.h"
 
-/*
- * Lookup table for attaching a specific name and platform_data pointer to
- * devices as they get created by of_platform_populate().  Ideally this table
- * would not exist, but the current clock implementation depends on some devices
- * having a specific name.
- */
-static const struct of_dev_auxdata imx53_auxdata_lookup[] __initconst = {
-	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART1_BASE_ADDR, "imx21-uart.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART2_BASE_ADDR, "imx21-uart.1", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART3_BASE_ADDR, "imx21-uart.2", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART4_BASE_ADDR, "imx21-uart.3", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART5_BASE_ADDR, "imx21-uart.4", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-fec", MX53_FEC_BASE_ADDR, "imx25-fec.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC1_BASE_ADDR, "sdhci-esdhc-imx53.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC2_BASE_ADDR, "sdhci-esdhc-imx53.1", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC3_BASE_ADDR, "sdhci-esdhc-imx53.2", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC4_BASE_ADDR, "sdhci-esdhc-imx53.3", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-ecspi", MX53_ECSPI1_BASE_ADDR, "imx51-ecspi.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-ecspi", MX53_ECSPI2_BASE_ADDR, "imx51-ecspi.1", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-cspi", MX53_CSPI_BASE_ADDR, "imx35-cspi.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-i2c", MX53_I2C1_BASE_ADDR, "imx21-i2c.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-i2c", MX53_I2C2_BASE_ADDR, "imx21-i2c.1", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-i2c", MX53_I2C3_BASE_ADDR, "imx21-i2c.2", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-sdma", MX53_SDMA_BASE_ADDR, "imx35-sdma", NULL),
-	OF_DEV_AUXDATA("fsl,imx53-wdt", MX53_WDOG1_BASE_ADDR, "imx2-wdt.0", NULL),
-	{ /* sentinel */ }
-};
-
 static void __init imx53_qsb_init(void)
 {
 	struct clk *clk;
@@ -69,8 +41,7 @@ static void __init imx53_dt_init(void)
 	if (of_machine_is_compatible("fsl,imx53-qsb"))
 		imx53_qsb_init();
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     imx53_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static void __init imx53_timer_init(void)
-- 
1.7.9.5
