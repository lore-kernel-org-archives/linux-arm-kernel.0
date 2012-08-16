From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 16 Aug 2012 16:08:46 +0800
Subject: [PATCH 2/2] ARM: imx6q: replace clk_register_clkdev with clock DT
 lookup
In-Reply-To: <1345104526-14797-1-git-send-email-shawn.guo@linaro.org>
References: <1345104526-14797-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1345104526-14797-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It really becomes an issue that every time a device needs to look
up (clk_get) a clock we have to patch kernel clock file to call
clk_register_clkdev for that clock.

Since clock DT support which is meant to resolve clock lookup in device
tree is in place, the patch moves imx6q client devices' clock lookup
over to device tree, so that any new lookup to be added at later time
can just get done in DT instead of kernel.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/clock/imx6q-clock.txt      |  223 +++++++++++++++++
 arch/arm/boot/dts/imx6q-sabrelite.dts              |    1 +
 arch/arm/boot/dts/imx6q.dtsi                       |  261 +++++++++++++++++++-
 arch/arm/mach-imx/clk-imx6q.c                      |   41 +---
 arch/arm/mach-imx/mach-imx6q.c                     |    1 -
 5 files changed, 477 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
new file mode 100644
index 0000000..19d8126
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
@@ -0,0 +1,223 @@
+* Clock bindings for Freescale i.MX6 Quad
+
+Required properties:
+- compatible: Should be "fsl,imx6q-ccm"
+- reg: Address and length of the register set
+- interrupts: Should contain CCM interrupt
+- #clock-cells: Should be <1>
+- clock-output-names: A list of clock output names that CCM provides.
+  The full list of all valid clock names and IDs is below.
+
+	Name			ID
+	---------------------------
+	dummy			0
+	ckil			1
+	ckih			2
+	osc			3
+	pll2_pfd0_352m		4
+	pll2_pfd1_594m		5
+	pll2_pfd2_396m		6
+	pll3_pfd0_720m		7
+	pll3_pfd1_540m		8
+	pll3_pfd2_508m		9
+	pll3_pfd3_454m		10
+	pll2_198m		11
+	pll3_120m		12
+	pll3_80m		13
+	pll3_60m		14
+	twd			15
+	step			16
+	pll1_sw			17
+	periph_pre		18
+	periph2_pre		19
+	periph_clk2_sel		20
+	periph2_clk2_sel	21
+	axi_sel			22
+	esai_sel		23
+	asrc_sel		24
+	spdif_sel		25
+	gpu2d_axi		26
+	gpu3d_axi		27
+	gpu2d_core_sel		28
+	gpu3d_core_sel		29
+	gpu3d_shader_sel	30
+	ipu1_sel		31
+	ipu2_sel		32
+	ldb_di0_sel		33
+	ldb_di1_sel		34
+	ipu1_di0_pre_sel	35
+	ipu1_di1_pre_sel	36
+	ipu2_di0_pre_sel	37
+	ipu2_di1_pre_sel	38
+	ipu1_di0_sel		39
+	ipu1_di1_sel		40
+	ipu2_di0_sel		41
+	ipu2_di1_sel		42
+	hsi_tx_sel		43
+	pcie_axi_sel		44
+	ssi1_sel		45
+	ssi2_sel		46
+	ssi3_sel		47
+	usdhc1_sel		48
+	usdhc2_sel		49
+	usdhc3_sel		50
+	usdhc4_sel		51
+	enfc_sel		52
+	emi_sel			53
+	emi_slow_sel		54
+	vdo_axi_sel		55
+	vpu_axi_sel		56
+	cko1_sel		57
+	periph			58
+	periph2			59
+	periph_clk2		60
+	periph2_clk2		61
+	ipg			62
+	ipg_per			63
+	esai_pred		64
+	esai_podf		65
+	asrc_pred		66
+	asrc_podf		67
+	spdif_pred		68
+	spdif_podf		69
+	can_root		70
+	ecspi_root		71
+	gpu2d_core_podf		72
+	gpu3d_core_podf		73
+	gpu3d_shader		74
+	ipu1_podf		75
+	ipu2_podf		76
+	ldb_di0_podf		77
+	ldb_di1_podf		78
+	ipu1_di0_pre		79
+	ipu1_di1_pre		80
+	ipu2_di0_pre		81
+	ipu2_di1_pre		82
+	hsi_tx_podf		83
+	ssi1_pred		84
+	ssi1_podf		85
+	ssi2_pred		86
+	ssi2_podf		87
+	ssi3_pred		88
+	ssi3_podf		89
+	uart_serial_podf	90
+	usdhc1_podf		91
+	usdhc2_podf		92
+	usdhc3_podf		93
+	usdhc4_podf		94
+	enfc_pred		95
+	enfc_podf		96
+	emi_podf		97
+	emi_slow_podf		98
+	vpu_axi_podf		99
+	cko1_podf		100
+	axi			101
+	mmdc_ch0_axi_podf	102
+	mmdc_ch1_axi_podf	103
+	arm			104
+	ahb			105
+	apbh_dma		106
+	asrc			107
+	can1_ipg		108
+	can1_serial		109
+	can2_ipg		110
+	can2_serial		111
+	ecspi1			112
+	ecspi2			113
+	ecspi3			114
+	ecspi4			115
+	ecspi5			116
+	enet			117
+	esai			118
+	gpt_ipg			119
+	gpt_ipg_per		120
+	gpu2d_core		121
+	gpu3d_core		122
+	hdmi_iahb		123
+	hdmi_isfr		124
+	i2c1			125
+	i2c2			126
+	i2c3			127
+	iim			128
+	enfc			129
+	ipu1			130
+	ipu1_di0		131
+	ipu1_di1		132
+	ipu2			133
+	ipu2_di0		134
+	ldb_di0			135
+	ldb_di1			136
+	ipu2_di1		137
+	hsi_tx			138
+	mlb			139
+	mmdc_ch0_axi		140
+	mmdc_ch1_axi		141
+	ocram			142
+	openvg_axi		143
+	pcie_axi		144
+	pwm1			145
+	pwm2			146
+	pwm3			147
+	pwm4			148
+	per1_bch		149
+	gpmi_bch_apb		150
+	gpmi_bch		151
+	gpmi_io			152
+	gpmi_apb		153
+	sata			154
+	sdma			155
+	spba			156
+	ssi1			157
+	ssi2			158
+	ssi3			159
+	uart_ipg		160
+	uart_serial		161
+	usboh3			162
+	usdhc1			163
+	usdhc2			164
+	usdhc3			165
+	usdhc4			166
+	vdo_axi			167
+	vpu_axi			168
+	cko1			169
+	pll1_sys		170
+	pll2_bus		171
+	pll3_usb_otg		172
+	pll4_audio		173
+	pll5_video		174
+	pll6_mlb		175
+	pll7_usb_host		176
+	pll8_enet		177
+	ssi1_ipg		178
+	ssi2_ipg		179
+	ssi3_ipg		180
+	rom			181
+	usbphy1			182
+	usbphy2			183
+	ldb_di0_div_3_5		184
+	ldb_di1_div_3_5		185
+
+  The ID will be used by clock consumer in the first cell of "clocks"
+  phandle to specify the desired clock.
+
+Examples:
+
+clks: ccm at 020c4000 {
+	compatible = "fsl,imx6q-ccm";
+	reg = <0x020c4000 0x4000>;
+	interrupts = <0 87 0x04 0 88 0x04>;
+	#clock-cells = <1>;
+	clock-output-names = ...
+			     "uart_ipg",
+			     "uart_serial",
+			     ...;
+};
+
+uart1: serial at 02020000 {
+	compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
+	reg = <0x02020000 0x4000>;
+	interrupts = <0 26 0x04>;
+	clocks = <&clks 160>, <&clks 161>;
+	clock-names = "ipg", "per";
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 72f30f3..cfdbe53 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -111,6 +111,7 @@
 				codec: sgtl5000 at 0a {
 					compatible = "fsl,sgtl5000";
 					reg = <0x0a>;
+					clocks = <&clks 169>;
 					VDDA-supply = <&reg_2p5v>;
 					VDDIO-supply = <&reg_3p3v>;
 				};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 0052fe7..acff2dc 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -93,18 +93,23 @@
 		dma-apbh at 00110000 {
 			compatible = "fsl,imx6q-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x00110000 0x2000>;
+			clocks = <&clks 106>;
 		};
 
 		gpmi-nand at 00112000 {
-		       compatible = "fsl,imx6q-gpmi-nand";
-		       #address-cells = <1>;
-		       #size-cells = <1>;
-		       reg = <0x00112000 0x2000>, <0x00114000 0x2000>;
-		       reg-names = "gpmi-nand", "bch";
-		       interrupts = <0 13 0x04>, <0 15 0x04>;
-		       interrupt-names = "gpmi-dma", "bch";
-		       fsl,gpmi-dma-channel = <0>;
-		       status = "disabled";
+			compatible = "fsl,imx6q-gpmi-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x00112000 0x2000>, <0x00114000 0x2000>;
+			reg-names = "gpmi-nand", "bch";
+			interrupts = <0 13 0x04>, <0 15 0x04>;
+			interrupt-names = "gpmi-dma", "bch";
+			clocks = <&clks 152>, <&clks 153>, <&clks 151>,
+				 <&clks 150>, <&clks 149>;
+			clock-names = "gpmi_io", "gpmi_apb", "gpmi_bch",
+				      "gpmi_bch_apb", "per1_bch";
+			fsl,gpmi-dma-channel = <0>;
+			status = "disabled";
 		};
 
 		timer at 00a00600 {
@@ -146,6 +151,8 @@
 					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
 					reg = <0x02008000 0x4000>;
 					interrupts = <0 31 0x04>;
+					clocks = <&clks 112>, <&clks 112>;
+					clock-names = "ipg", "per";
 					status = "disabled";
 				};
 
@@ -155,6 +162,8 @@
 					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
 					reg = <0x0200c000 0x4000>;
 					interrupts = <0 32 0x04>;
+					clocks = <&clks 113>, <&clks 113>;
+					clock-names = "ipg", "per";
 					status = "disabled";
 				};
 
@@ -164,6 +173,8 @@
 					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
 					reg = <0x02010000 0x4000>;
 					interrupts = <0 33 0x04>;
+					clocks = <&clks 114>, <&clks 114>;
+					clock-names = "ipg", "per";
 					status = "disabled";
 				};
 
@@ -173,6 +184,8 @@
 					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
 					reg = <0x02014000 0x4000>;
 					interrupts = <0 34 0x04>;
+					clocks = <&clks 115>, <&clks 115>;
+					clock-names = "ipg", "per";
 					status = "disabled";
 				};
 
@@ -182,6 +195,8 @@
 					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
 					reg = <0x02018000 0x4000>;
 					interrupts = <0 35 0x04>;
+					clocks = <&clks 116>, <&clks 116>;
+					clock-names = "ipg", "per";
 					status = "disabled";
 				};
 
@@ -189,6 +204,8 @@
 					compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02020000 0x4000>;
 					interrupts = <0 26 0x04>;
+					clocks = <&clks 160>, <&clks 161>;
+					clock-names = "ipg", "per";
 					status = "disabled";
 				};
 
@@ -201,6 +218,7 @@
 					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
+					clocks = <&clks 178>;
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <38 37>;
 					status = "disabled";
@@ -210,6 +228,7 @@
 					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
+					clocks = <&clks 179>;
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <42 41>;
 					status = "disabled";
@@ -219,6 +238,7 @@
 					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
+					clocks = <&clks 180>;
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <46 45>;
 					status = "disabled";
@@ -358,6 +378,7 @@
 				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <0 80 0x04>;
+				clocks = <&clks 0>;
 				status = "disabled";
 			};
 
@@ -365,13 +386,203 @@
 				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <0 81 0x04>;
+				clocks = <&clks 0>;
 				status = "disabled";
 			};
 
-			ccm at 020c4000 {
+			clks: ccm at 020c4000 {
 				compatible = "fsl,imx6q-ccm";
 				reg = <0x020c4000 0x4000>;
 				interrupts = <0 87 0x04 0 88 0x04>;
+				#clock-cells = <1>;
+				clock-output-names =
+					"dummy",		/* 0 */
+					"ckil",			/* 1 */
+					"ckih",			/* 2 */
+					"osc",			/* 3 */
+					"pll2_pfd0_352m",	/* 4 */
+					"pll2_pfd1_594m",	/* 5 */
+					"pll2_pfd2_396m",	/* 6 */
+					"pll3_pfd0_720m",	/* 7 */
+					"pll3_pfd1_540m",	/* 8 */
+					"pll3_pfd2_508m",	/* 9 */
+					"pll3_pfd3_454m",	/* 10 */
+					"pll2_198m",		/* 11 */
+					"pll3_120m",		/* 12 */
+					"pll3_80m",		/* 13 */
+					"pll3_60m",		/* 14 */
+					"twd",			/* 15 */
+					"step",			/* 16 */
+					"pll1_sw",		/* 17 */
+					"periph_pre",		/* 18 */
+					"periph2_pre",		/* 19 */
+					"periph_clk2_sel",	/* 20 */
+					"periph2_clk2_sel",	/* 21 */
+					"axi_sel",		/* 22 */
+					"esai_sel",		/* 23 */
+					"asrc_sel",		/* 24 */
+					"spdif_sel",		/* 25 */
+					"gpu2d_axi",		/* 26 */
+					"gpu3d_axi",		/* 27 */
+					"gpu2d_core_sel",	/* 28 */
+					"gpu3d_core_sel",	/* 29 */
+					"gpu3d_shader_sel",	/* 30 */
+					"ipu1_sel",		/* 31 */
+					"ipu2_sel",		/* 32 */
+					"ldb_di0_sel",		/* 33 */
+					"ldb_di1_sel",		/* 34 */
+					"ipu1_di0_pre_sel",	/* 35 */
+					"ipu1_di1_pre_sel",	/* 36 */
+					"ipu2_di0_pre_sel",	/* 37 */
+					"ipu2_di1_pre_sel",	/* 38 */
+					"ipu1_di0_sel",		/* 39 */
+					"ipu1_di1_sel",		/* 40 */
+					"ipu2_di0_sel",		/* 41 */
+					"ipu2_di1_sel",		/* 42 */
+					"hsi_tx_sel",		/* 43 */
+					"pcie_axi_sel",		/* 44 */
+					"ssi1_sel",		/* 45 */
+					"ssi2_sel",		/* 46 */
+					"ssi3_sel",		/* 47 */
+					"usdhc1_sel",		/* 48 */
+					"usdhc2_sel",		/* 49 */
+					"usdhc3_sel",		/* 50 */
+					"usdhc4_sel",		/* 51 */
+					"enfc_sel",		/* 52 */
+					"emi_sel",		/* 53 */
+					"emi_slow_sel",		/* 54 */
+					"vdo_axi_sel",		/* 55 */
+					"vpu_axi_sel",		/* 56 */
+					"cko1_sel",		/* 57 */
+					"periph",		/* 58 */
+					"periph2",		/* 59 */
+					"periph_clk2",		/* 60 */
+					"periph2_clk2",		/* 61 */
+					"ipg",			/* 62 */
+					"ipg_per",		/* 63 */
+					"esai_pred",		/* 64 */
+					"esai_podf",		/* 65 */
+					"asrc_pred",		/* 66 */
+					"asrc_podf",		/* 67 */
+					"spdif_pred",		/* 68 */
+					"spdif_podf",		/* 69 */
+					"can_root",		/* 70 */
+					"ecspi_root",		/* 71 */
+					"gpu2d_core_podf",	/* 72 */
+					"gpu3d_core_podf",	/* 73 */
+					"gpu3d_shader",		/* 74 */
+					"ipu1_podf",		/* 75 */
+					"ipu2_podf",		/* 76 */
+					"ldb_di0_podf",		/* 77 */
+					"ldb_di1_podf",		/* 78 */
+					"ipu1_di0_pre",		/* 79 */
+					"ipu1_di1_pre",		/* 80 */
+					"ipu2_di0_pre",		/* 81 */
+					"ipu2_di1_pre",		/* 82 */
+					"hsi_tx_podf",		/* 83 */
+					"ssi1_pred",		/* 84 */
+					"ssi1_podf",		/* 85 */
+					"ssi2_pred",		/* 86 */
+					"ssi2_podf",		/* 87 */
+					"ssi3_pred",		/* 88 */
+					"ssi3_podf",		/* 89 */
+					"uart_serial_podf",	/* 90 */
+					"usdhc1_podf",		/* 91 */
+					"usdhc2_podf",		/* 92 */
+					"usdhc3_podf",		/* 93 */
+					"usdhc4_podf",		/* 94 */
+					"enfc_pred",		/* 95 */
+					"enfc_podf",		/* 96 */
+					"emi_podf",		/* 97 */
+					"emi_slow_podf",	/* 98 */
+					"vpu_axi_podf",		/* 99 */
+					"cko1_podf",		/* 100 */
+					"axi",			/* 101 */
+					"mmdc_ch0_axi_podf",	/* 102 */
+					"mmdc_ch1_axi_podf",	/* 103 */
+					"arm",			/* 104 */
+					"ahb",			/* 105 */
+					"apbh_dma",		/* 106 */
+					"asrc",			/* 107 */
+					"can1_ipg",		/* 108 */
+					"can1_serial",		/* 109 */
+					"can2_ipg",		/* 110 */
+					"can2_serial",		/* 111 */
+					"ecspi1",		/* 112 */
+					"ecspi2",		/* 113 */
+					"ecspi3",		/* 114 */
+					"ecspi4",		/* 115 */
+					"ecspi5",		/* 116 */
+					"enet",			/* 117 */
+					"esai",			/* 118 */
+					"gpt_ipg",		/* 119 */
+					"gpt_ipg_per",		/* 120 */
+					"gpu2d_core",		/* 121 */
+					"gpu3d_core",		/* 122 */
+					"hdmi_iahb",		/* 123 */
+					"hdmi_isfr",		/* 124 */
+					"i2c1",			/* 125 */
+					"i2c2",			/* 126 */
+					"i2c3",			/* 127 */
+					"iim",			/* 128 */
+					"enfc",			/* 129 */
+					"ipu1",			/* 130 */
+					"ipu1_di0",		/* 131 */
+					"ipu1_di1",		/* 132 */
+					"ipu2",			/* 133 */
+					"ipu2_di0",		/* 134 */
+					"ldb_di0",		/* 135 */
+					"ldb_di1",		/* 136 */
+					"ipu2_di1",		/* 137 */
+					"hsi_tx",		/* 138 */
+					"mlb",			/* 139 */
+					"mmdc_ch0_axi",		/* 140 */
+					"mmdc_ch1_axi",		/* 141 */
+					"ocram",		/* 142 */
+					"openvg_axi",		/* 143 */
+					"pcie_axi",		/* 144 */
+					"pwm1",			/* 145 */
+					"pwm2",			/* 146 */
+					"pwm3",			/* 147 */
+					"pwm4",			/* 148 */
+					"per1_bch",		/* 149 */
+					"gpmi_bch_apb",		/* 150 */
+					"gpmi_bch",		/* 151 */
+					"gpmi_io",		/* 152 */
+					"gpmi_apb",		/* 153 */
+					"sata",			/* 154 */
+					"sdma",			/* 155 */
+					"spba",			/* 156 */
+					"ssi1",			/* 157 */
+					"ssi2",			/* 158 */
+					"ssi3",			/* 159 */
+					"uart_ipg",		/* 160 */
+					"uart_serial",		/* 161 */
+					"usboh3",		/* 162 */
+					"usdhc1",		/* 163 */
+					"usdhc2",		/* 164 */
+					"usdhc3",		/* 165 */
+					"usdhc4",		/* 166 */
+					"vdo_axi",		/* 167 */
+					"vpu_axi",		/* 168 */
+					"cko1",			/* 169 */
+					"pll1_sys",		/* 170 */
+					"pll2_bus",		/* 171 */
+					"pll3_usb_otg",		/* 172 */
+					"pll4_audio",		/* 173 */
+					"pll5_video",		/* 174 */
+					"pll6_mlb",		/* 175 */
+					"pll7_usb_host",	/* 176 */
+					"pll8_enet",		/* 177 */
+					"ssi1_ipg",		/* 178 */
+					"ssi2_ipg",		/* 179 */
+					"ssi3_ipg",		/* 180 */
+					"rom",			/* 181 */
+					"usbphy1",		/* 182 */
+					"usbphy2",		/* 183 */
+					"ldb_di0_div_3_5",	/* 184 */
+					"ldb_di1_div_3_5",	/* 185 */
+					"end_of_list";
 			};
 
 			anatop at 020c8000 {
@@ -468,12 +679,14 @@
 				compatible = "fsl,imx6q-usbphy", "fsl,imx23-usbphy";
 				reg = <0x020c9000 0x1000>;
 				interrupts = <0 44 0x04>;
+				clocks = <&clks 182>;
 			};
 
 			usbphy2: usbphy at 020ca000 {
 				compatible = "fsl,imx6q-usbphy", "fsl,imx23-usbphy";
 				reg = <0x020ca000 0x1000>;
 				interrupts = <0 45 0x04>;
+				clocks = <&clks 183>;
 			};
 
 			snvs at 020cc000 {
@@ -608,6 +821,9 @@
 				compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <0 2 0x04>;
+				clocks = <&clks 155>, <&clks 155>;
+				clock-names = "ipg", "ahb";
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q-to1.bin";
 			};
 		};
 
@@ -631,6 +847,7 @@
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184000 0x200>;
 				interrupts = <0 43 0x04>;
+				clocks = <&clks 162>;
 				fsl,usbphy = <&usbphy1>;
 				status = "disabled";
 			};
@@ -639,6 +856,7 @@
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184200 0x200>;
 				interrupts = <0 40 0x04>;
+				clocks = <&clks 162>;
 				fsl,usbphy = <&usbphy2>;
 				status = "disabled";
 			};
@@ -647,6 +865,7 @@
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184400 0x200>;
 				interrupts = <0 41 0x04>;
+				clocks = <&clks 162>;
 				status = "disabled";
 			};
 
@@ -654,6 +873,7 @@
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184600 0x200>;
 				interrupts = <0 42 0x04>;
+				clocks = <&clks 162>;
 				status = "disabled";
 			};
 
@@ -661,6 +881,8 @@
 				compatible = "fsl,imx6q-fec";
 				reg = <0x02188000 0x4000>;
 				interrupts = <0 118 0x04 0 119 0x04>;
+				clocks = <&clks 117>, <&clks 117>;
+				clock-names = "ipg", "ahb";
 				status = "disabled";
 			};
 
@@ -673,6 +895,8 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02190000 0x4000>;
 				interrupts = <0 22 0x04>;
+				clocks = <&clks 163>, <&clks 163>, <&clks 163>;
+				clock-names = "ipg", "ahb", "per";
 				status = "disabled";
 			};
 
@@ -680,6 +904,8 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02194000 0x4000>;
 				interrupts = <0 23 0x04>;
+				clocks = <&clks 164>, <&clks 164>, <&clks 164>;
+				clock-names = "ipg", "ahb", "per";
 				status = "disabled";
 			};
 
@@ -687,6 +913,8 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02198000 0x4000>;
 				interrupts = <0 24 0x04>;
+				clocks = <&clks 165>, <&clks 165>, <&clks 165>;
+				clock-names = "ipg", "ahb", "per";
 				status = "disabled";
 			};
 
@@ -694,6 +922,8 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x0219c000 0x4000>;
 				interrupts = <0 25 0x04>;
+				clocks = <&clks 166>, <&clks 166>, <&clks 166>;
+				clock-names = "ipg", "ahb", "per";
 				status = "disabled";
 			};
 
@@ -703,6 +933,7 @@
 				compatible = "fsl,imx6q-i2c", "fsl,imx1-i2c";
 				reg = <0x021a0000 0x4000>;
 				interrupts = <0 36 0x04>;
+				clocks = <&clks 125>;
 				status = "disabled";
 			};
 
@@ -712,6 +943,7 @@
 				compatible = "fsl,imx6q-i2c", "fsl,imx1-i2c";
 				reg = <0x021a4000 0x4000>;
 				interrupts = <0 37 0x04>;
+				clocks = <&clks 126>;
 				status = "disabled";
 			};
 
@@ -721,6 +953,7 @@
 				compatible = "fsl,imx6q-i2c", "fsl,imx1-i2c";
 				reg = <0x021a8000 0x4000>;
 				interrupts = <0 38 0x04>;
+				clocks = <&clks 127>;
 				status = "disabled";
 			};
 
@@ -784,6 +1017,8 @@
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021e8000 0x4000>;
 				interrupts = <0 27 0x04>;
+				clocks = <&clks 160>, <&clks 161>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -791,6 +1026,8 @@
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021ec000 0x4000>;
 				interrupts = <0 28 0x04>;
+				clocks = <&clks 160>, <&clks 161>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -798,6 +1035,8 @@
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021f0000 0x4000>;
 				interrupts = <0 29 0x04>;
+				clocks = <&clks 160>, <&clks 161>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -805,6 +1044,8 @@
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021f4000 0x4000>;
 				interrupts = <0 30 0x04>;
+				clocks = <&clks 160>, <&clks 161>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 8e46407..433c683 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -387,48 +387,11 @@ int __init mx6q_clocks_init(void)
 			pr_err("i.MX6q clk %d: register failed with %ld\n",
 				i, PTR_ERR(clk[i]));
 
+	of_clk_add_provider(np, of_clk_src_onecell_get, NULL);
+
 	clk_register_clkdev(clk[gpt_ipg], "ipg", "imx-gpt.0");
 	clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
 	clk_register_clkdev(clk[twd], NULL, "smp_twd");
-	clk_register_clkdev(clk[apbh_dma], NULL, "110000.dma-apbh");
-	clk_register_clkdev(clk[per1_bch], "per1_bch", "112000.gpmi-nand");
-	clk_register_clkdev(clk[gpmi_bch_apb], "gpmi_bch_apb", "112000.gpmi-nand");
-	clk_register_clkdev(clk[gpmi_bch], "gpmi_bch", "112000.gpmi-nand");
-	clk_register_clkdev(clk[gpmi_apb], "gpmi_apb", "112000.gpmi-nand");
-	clk_register_clkdev(clk[gpmi_io], "gpmi_io", "112000.gpmi-nand");
-	clk_register_clkdev(clk[usboh3], NULL, "2184000.usb");
-	clk_register_clkdev(clk[usboh3], NULL, "2184200.usb");
-	clk_register_clkdev(clk[usboh3], NULL, "2184400.usb");
-	clk_register_clkdev(clk[usboh3], NULL, "2184600.usb");
-	clk_register_clkdev(clk[usbphy1], NULL, "20c9000.usbphy");
-	clk_register_clkdev(clk[usbphy2], NULL, "20ca000.usbphy");
-	clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.serial");
-	clk_register_clkdev(clk[uart_serial], "per", "21e8000.serial");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "21e8000.serial");
-	clk_register_clkdev(clk[uart_serial], "per", "21ec000.serial");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "21ec000.serial");
-	clk_register_clkdev(clk[uart_serial], "per", "21f0000.serial");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "21f0000.serial");
-	clk_register_clkdev(clk[uart_serial], "per", "21f4000.serial");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "21f4000.serial");
-	clk_register_clkdev(clk[enet], NULL, "2188000.ethernet");
-	clk_register_clkdev(clk[usdhc1], NULL, "2190000.usdhc");
-	clk_register_clkdev(clk[usdhc2], NULL, "2194000.usdhc");
-	clk_register_clkdev(clk[usdhc3], NULL, "2198000.usdhc");
-	clk_register_clkdev(clk[usdhc4], NULL, "219c000.usdhc");
-	clk_register_clkdev(clk[i2c1], NULL, "21a0000.i2c");
-	clk_register_clkdev(clk[i2c2], NULL, "21a4000.i2c");
-	clk_register_clkdev(clk[i2c3], NULL, "21a8000.i2c");
-	clk_register_clkdev(clk[ecspi1], NULL, "2008000.ecspi");
-	clk_register_clkdev(clk[ecspi2], NULL, "200c000.ecspi");
-	clk_register_clkdev(clk[ecspi3], NULL, "2010000.ecspi");
-	clk_register_clkdev(clk[ecspi4], NULL, "2014000.ecspi");
-	clk_register_clkdev(clk[ecspi5], NULL, "2018000.ecspi");
-	clk_register_clkdev(clk[sdma], NULL, "20ec000.sdma");
-	clk_register_clkdev(clk[dummy], NULL, "20bc000.wdog");
-	clk_register_clkdev(clk[dummy], NULL, "20c0000.wdog");
-	clk_register_clkdev(clk[ssi1_ipg], NULL, "2028000.ssi");
 	clk_register_clkdev(clk[cko1_sel], "cko1_sel", NULL);
 	clk_register_clkdev(clk[ahb], "ahb", NULL);
 	clk_register_clkdev(clk[cko1], "cko1", NULL);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 6f9c23b..957f5fe 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -94,7 +94,6 @@ static void __init imx6q_sabrelite_cko1_setup(void)
 	clk_set_parent(cko1_sel, ahb);
 	rate = clk_round_rate(cko1, 16000000);
 	clk_set_rate(cko1, rate);
-	clk_register_clkdev(cko1, NULL, "0-000a");
 put_clk:
 	if (!IS_ERR(cko1_sel))
 		clk_put(cko1_sel);
-- 
1.7.5.4
