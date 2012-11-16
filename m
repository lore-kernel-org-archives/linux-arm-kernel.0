From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 16 Nov 2012 15:36:55 -0200
Subject: [RFC] ARM: mx5: Replace clk_register_clkdev with clock DT lookup
Message-ID: <1353087415-10442-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam fabio.estevam at freescale.com>

Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
task for the clock devices easier.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Shawn/Sascha,

I do not have access to any mx5 hardware at the moment to try it, so that's
why I marked it as RFC.

 .../devicetree/bindings/clock/imx5-clock.txt       |  192 ++++++++++++++++++++
 arch/arm/boot/dts/imx51.dtsi                       |   11 ++
 arch/arm/boot/dts/imx53.dtsi                       |   15 ++
 arch/arm/mach-imx/clk-imx51-imx53.c                |   26 +--
 4 files changed, 231 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx5-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.txt b/Documentation/devicetree/bindings/clock/imx5-clock.txt
new file mode 100644
index 0000000..25da30f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx5-clock.txt
@@ -0,0 +1,192 @@
+* Clock bindings for Freescale i.MX5
+
+Required properties:
+- compatible: Should be "fsl,imx5-ccm"
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
+	clk_max			169
+
+Examples:
+
+clks: ccm at 53fd4000{
+	compatible = "fsl,imx5-ccm";
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
index 54aea74..b15d276 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -110,6 +110,7 @@
 					compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 					reg = <0x70014000 0x4000>;
 					interrupts = <30>;
+					clocks = <&clks 49>;
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
 					status = "disabled";
@@ -340,6 +341,13 @@
 				interrupts = <32>;
 				status = "disabled";
 			};
+
+			clks: ccm at 73fd4000{
+				compatible = "fsl,imx5-ccm";
+				reg = <0x73fd4000 0x4000>;
+				interrupts = <0 71 0x04 0 72 0x04>;
+				#clock-cells = <1>;
+			};
 		};
 
 		aips at 80000000 {	/* AIPS2 */
@@ -396,6 +404,7 @@
 				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 				reg = <0x83fcc000 0x4000>;
 				interrupts = <29>;
+				clocks = <&clks 48>;
 				fsl,fifo-depth = <15>;
 				fsl,ssi-dma-events = <29 28 27 26>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
@@ -411,6 +420,7 @@
 				compatible = "fsl,imx51-nand";
 				reg = <0x83fdb000 0x1000 0xcfff0000 0x10000>;
 				interrupts = <8>;
+				clocks = <&clks 60>;
 				status = "disabled";
 			};
 
@@ -418,6 +428,7 @@
 				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 				reg = <0x83fe8000 0x4000>;
 				interrupts = <96>;
+				clocks = <&clks 50>;
 				fsl,fifo-depth = <15>;
 				fsl,ssi-dma-events = <47 46 37 35>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index caf09ff..22b7c05 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -115,6 +115,7 @@
 					compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
 					reg = <0x50014000 0x4000>;
 					interrupts = <30>;
+					clocks = <&clks 49>;
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
 					status = "disabled";
@@ -389,6 +390,8 @@
 				compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
 				reg = <0x53fc8000 0x4000>;
 				interrupts = <82>;
+				clocks = <&clks 168>, <&clks 167>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -396,9 +399,18 @@
 				compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
 				reg = <0x53fcc000 0x4000>;
 				interrupts = <83>;
+				clocks = <&clks 168>, <&clks 167>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
+			clks: ccm at 53fd4000{
+				compatible = "fsl,imx5-ccm";
+				reg = <0x53fd4000 0x4000>;
+				interrupts = <0 71 0x04 0 72 0x04>;
+				#clock-cells = <1>;
+			};
+
 			gpio5: gpio at 53fdc000 {
 				compatible = "fsl,imx53-gpio", "fsl,imx35-gpio";
 				reg = <0x53fdc000 0x4000>;
@@ -507,6 +519,7 @@
 				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
 				reg = <0x63fcc000 0x4000>;
 				interrupts = <29>;
+				clocks = <&clks 48>;
 				fsl,fifo-depth = <15>;
 				fsl,ssi-dma-events = <29 28 27 26>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
@@ -522,6 +535,7 @@
 				compatible = "fsl,imx53-nand";
 				reg = <0x63fdb000 0x1000 0xf7ff0000 0x10000>;
 				interrupts = <8>;
+				clocks = <&clks 60>;
 				status = "disabled";
 			};
 
@@ -529,6 +543,7 @@
 				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
 				reg = <0x63fe8000 0x4000>;
 				interrupts = <96>;
+				clocks = <&clks 50>;
 				fsl,fifo-depth = <15>;
 				fsl,ssi-dma-events = <47 46 45 44>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 6cb9795..def2613 100644
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
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx5-ccm");
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
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx5-ccm");
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
-- 
1.7.9.5
