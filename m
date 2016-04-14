From: akurz@blala.de (Alexander Kurz)
Date: Thu, 14 Apr 2016 23:30:50 +0200
Subject: [PATCH 2/2] ARM: i.MX35 clk: Introduce DT include for clock provider
In-Reply-To: <1460669450-11729-1-git-send-email-akurz@blala.de>
References: <1460669450-11729-1-git-send-email-akurz@blala.de>
Message-ID: <1460669450-11729-2-git-send-email-akurz@blala.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use clock defines in order to make devicetrees more human readable

Signed-off-by: Alexander Kurz <akurz@blala.de>
---
 .../devicetree/bindings/clock/imx35-clock.txt      |  93 +----
 drivers/clk/imx/clk-imx35.c                        | 429 ++++++++++++---------
 include/dt-bindings/clock/imx35-clock.h            |  98 +++++
 3 files changed, 349 insertions(+), 271 deletions(-)
 create mode 100644 include/dt-bindings/clock/imx35-clock.h

diff --git a/Documentation/devicetree/bindings/clock/imx35-clock.txt b/Documentation/devicetree/bindings/clock/imx35-clock.txt
index f497832..2e88d25 100644
--- a/Documentation/devicetree/bindings/clock/imx35-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx35-clock.txt
@@ -7,94 +7,8 @@ Required properties:
 - #clock-cells: Should be <1>
 
 The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.  The following is a full list of i.MX35
-clocks and IDs.
-
-	Clock			ID
-	---------------------------
-	ckih			0
-	mpll			1
-	ppll			2
-	mpll_075		3
-	arm			4
-	hsp			5
-	hsp_div			6
-	hsp_sel			7
-	ahb			8
-	ipg			9
-	arm_per_div		10
-	ahb_per_div		11
-	ipg_per			12
-	uart_sel		13
-	uart_div		14
-	esdhc_sel		15
-	esdhc1_div		16
-	esdhc2_div		17
-	esdhc3_div		18
-	spdif_sel		19
-	spdif_div_pre		20
-	spdif_div_post		21
-	ssi_sel			22
-	ssi1_div_pre		23
-	ssi1_div_post		24
-	ssi2_div_pre		25
-	ssi2_div_post		26
-	usb_sel			27
-	usb_div			28
-	nfc_div			29
-	asrc_gate		30
-	pata_gate		31
-	audmux_gate		32
-	can1_gate		33
-	can2_gate		34
-	cspi1_gate		35
-	cspi2_gate		36
-	ect_gate		37
-	edio_gate		38
-	emi_gate		39
-	epit1_gate		40
-	epit2_gate		41
-	esai_gate		42
-	esdhc1_gate		43
-	esdhc2_gate		44
-	esdhc3_gate		45
-	fec_gate		46
-	gpio1_gate		47
-	gpio2_gate		48
-	gpio3_gate		49
-	gpt_gate		50
-	i2c1_gate		51
-	i2c2_gate		52
-	i2c3_gate		53
-	iomuxc_gate		54
-	ipu_gate		55
-	kpp_gate		56
-	mlb_gate		57
-	mshc_gate		58
-	owire_gate		59
-	pwm_gate		60
-	rngc_gate		61
-	rtc_gate		62
-	rtic_gate		63
-	scc_gate		64
-	sdma_gate		65
-	spba_gate		66
-	spdif_gate		67
-	ssi1_gate		68
-	ssi2_gate		69
-	uart1_gate		70
-	uart2_gate		71
-	uart3_gate		72
-	usbotg_gate		73
-	wdog_gate		74
-	max_gate		75
-	admux_gate		76
-	csi_gate		77
-	csi_div			78
-	csi_sel			79
-	iim_gate		80
-	gpu2d_gate		81
-	ckli_gate		82
+ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx35-clock.h
+for the full list of i.MXi35 clock IDs.
 
 Examples:
 
@@ -109,6 +23,7 @@ esdhc1: esdhc at 53fb4000 {
 	compatible = "fsl,imx35-esdhc";
 	reg = <0x53fb4000 0x4000>;
 	interrupts = <7>;
-	clocks = <&clks 9>, <&clks 8>, <&clks 43>;
+	clocks = <&clks IMX35_CLK_IPG>, <&clks IMX35_CLK_AHB>,
+		 <&clks IMX35_CLK_ESDHC1_GATE>;
 	clock-names = "ipg", "ahb", "per";
 };
diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index b0978d3..656bab7 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -13,6 +13,7 @@
 #include <linux/clkdev.h>
 #include <linux/of.h>
 #include <linux/err.h>
+#include <dt-bindings/clock/imx35-clock.h>
 #include <soc/imx/revision.h>
 #include <soc/imx/timer.h>
 #include <asm/irq.h>
@@ -65,30 +66,13 @@ static struct clk_onecell_data clk_data;
 static const char *std_sel[] = {"ppll", "arm"};
 static const char *ipg_per_sel[] = {"ahb_per_div", "arm_per_div"};
 
-enum mx35_clks {
-	ckih, mpll, ppll, mpll_075, arm, hsp, hsp_div, hsp_sel, ahb, ipg,
-	arm_per_div, ahb_per_div, ipg_per, uart_sel, uart_div, esdhc_sel,
-	esdhc1_div, esdhc2_div, esdhc3_div, spdif_sel, spdif_div_pre,
-	spdif_div_post, ssi_sel, ssi1_div_pre, ssi1_div_post, ssi2_div_pre,
-	ssi2_div_post, usb_sel, usb_div, nfc_div, asrc_gate, pata_gate,
-	audmux_gate, can1_gate, can2_gate, cspi1_gate, cspi2_gate, ect_gate,
-	edio_gate, emi_gate, epit1_gate, epit2_gate, esai_gate, esdhc1_gate,
-	esdhc2_gate, esdhc3_gate, fec_gate, gpio1_gate, gpio2_gate, gpio3_gate,
-	gpt_gate, i2c1_gate, i2c2_gate, i2c3_gate, iomuxc_gate, ipu_gate,
-	kpp_gate, mlb_gate, mshc_gate, owire_gate, pwm_gate, rngc_gate,
-	rtc_gate, rtic_gate, scc_gate, sdma_gate, spba_gate, spdif_gate,
-	ssi1_gate, ssi2_gate, uart1_gate, uart2_gate, uart3_gate, usbotg_gate,
-	wdog_gate, max_gate, admux_gate, csi_gate, csi_div, csi_sel, iim_gate,
-	gpu2d_gate, ckil, clk_max
-};
-
-static struct clk *clk[clk_max];
+static struct clk *clk[IMX35_CLK_MAX];
 
 static struct clk ** const uart_clks[] __initconst = {
-	&clk[ipg],
-	&clk[uart1_gate],
-	&clk[uart2_gate],
-	&clk[uart3_gate],
+	&clk[IMX35_CLK_IPG],
+	&clk[IMX35_CLK_UART1_GATE],
+	&clk[IMX35_CLK_UART2_GATE],
+	&clk[IMX35_CLK_UART3_GATE],
 	NULL
 };
 
@@ -114,19 +98,23 @@ static void __init _mx35_clocks_init(void)
 		aad = &clk_consumer[0];
 	}
 
-	clk[ckih] = imx_clk_fixed("ckih", 24000000);
-	clk[ckil] = imx_clk_fixed("ckih", 32768);
-	clk[mpll] = imx_clk_pllv1(IMX_PLLV1_IMX35, "mpll", "ckih", base + MX35_CCM_MPCTL);
-	clk[ppll] = imx_clk_pllv1(IMX_PLLV1_IMX35, "ppll", "ckih", base + MX35_CCM_PPCTL);
+	clk[IMX35_CLK_CKIH] = imx_clk_fixed("ckih", 24000000);
+	clk[IMX35_CLK_CKIL] = imx_clk_fixed("ckih", 32768);
+	clk[IMX35_CLK_MPLL] = imx_clk_pllv1(IMX_PLLV1_IMX35, "mpll", "ckih",
+		base + MX35_CCM_MPCTL);
+	clk[IMX35_CLK_PPLL] = imx_clk_pllv1(IMX_PLLV1_IMX35, "ppll", "ckih",
+		base + MX35_CCM_PPCTL);
 
-	clk[mpll] = imx_clk_fixed_factor("mpll_075", "mpll", 3, 4);
+	clk[IMX35_CLK_MPLL] = imx_clk_fixed_factor("mpll_075", "mpll", 3, 4);
 
 	if (aad->sel)
-		clk[arm] = imx_clk_fixed_factor("arm", "mpll_075", 1, aad->arm);
+		clk[IMX35_CLK_ARM] = imx_clk_fixed_factor("arm", "mpll_075",
+			1, aad->arm);
 	else
-		clk[arm] = imx_clk_fixed_factor("arm", "mpll", 1, aad->arm);
+		clk[IMX35_CLK_ARM] = imx_clk_fixed_factor("arm", "mpll",
+			1, aad->arm);
 
-	if (clk_get_rate(clk[arm]) > 400000000)
+	if (clk_get_rate(clk[IMX35_CLK_ARM]) > 400000000)
 		hsp_div = hsp_div_532;
 	else
 		hsp_div = hsp_div_400;
@@ -137,105 +125,179 @@ static void __init _mx35_clocks_init(void)
 		hsp_sel = 0;
 	}
 
-	clk[hsp] = imx_clk_fixed_factor("hsp", "arm", 1, hsp_div[hsp_sel]);
-
-	clk[ahb] = imx_clk_fixed_factor("ahb", "arm", 1, aad->ahb);
-	clk[ipg] = imx_clk_fixed_factor("ipg", "ahb", 1, 2);
-
-	clk[arm_per_div] = imx_clk_divider("arm_per_div", "arm", base + MX35_CCM_PDR4, 16, 6);
-	clk[ahb_per_div] = imx_clk_divider("ahb_per_div", "ahb", base + MXC_CCM_PDR0, 12, 3);
-	clk[ipg_per] = imx_clk_mux("ipg_per", base + MXC_CCM_PDR0, 26, 1, ipg_per_sel, ARRAY_SIZE(ipg_per_sel));
-
-	clk[uart_sel] = imx_clk_mux("uart_sel", base + MX35_CCM_PDR3, 14, 1, std_sel, ARRAY_SIZE(std_sel));
-	clk[uart_div] = imx_clk_divider("uart_div", "uart_sel", base + MX35_CCM_PDR4, 10, 6);
-
-	clk[esdhc_sel] = imx_clk_mux("esdhc_sel", base + MX35_CCM_PDR4, 9, 1, std_sel, ARRAY_SIZE(std_sel));
-	clk[esdhc1_div] = imx_clk_divider("esdhc1_div", "esdhc_sel", base + MX35_CCM_PDR3, 0, 6);
-	clk[esdhc2_div] = imx_clk_divider("esdhc2_div", "esdhc_sel", base + MX35_CCM_PDR3, 8, 6);
-	clk[esdhc3_div] = imx_clk_divider("esdhc3_div", "esdhc_sel", base + MX35_CCM_PDR3, 16, 6);
-
-	clk[spdif_sel] = imx_clk_mux("spdif_sel", base + MX35_CCM_PDR3, 22, 1, std_sel, ARRAY_SIZE(std_sel));
-	clk[spdif_div_pre] = imx_clk_divider("spdif_div_pre", "spdif_sel", base + MX35_CCM_PDR3, 29, 3); /* divide by 1 not allowed */ 
-	clk[spdif_div_post] = imx_clk_divider("spdif_div_post", "spdif_div_pre", base + MX35_CCM_PDR3, 23, 6);
-
-	clk[ssi_sel] = imx_clk_mux("ssi_sel", base + MX35_CCM_PDR2, 6, 1, std_sel, ARRAY_SIZE(std_sel));
-	clk[ssi1_div_pre] = imx_clk_divider("ssi1_div_pre", "ssi_sel", base + MX35_CCM_PDR2, 24, 3);
-	clk[ssi1_div_post] = imx_clk_divider("ssi1_div_post", "ssi1_div_pre", base + MX35_CCM_PDR2, 0, 6);
-	clk[ssi2_div_pre] = imx_clk_divider("ssi2_div_pre", "ssi_sel", base + MX35_CCM_PDR2, 27, 3);
-	clk[ssi2_div_post] = imx_clk_divider("ssi2_div_post", "ssi2_div_pre", base + MX35_CCM_PDR2, 8, 6);
-
-	clk[usb_sel] = imx_clk_mux("usb_sel", base + MX35_CCM_PDR4, 9, 1, std_sel, ARRAY_SIZE(std_sel));
-	clk[usb_div] = imx_clk_divider("usb_div", "usb_sel", base + MX35_CCM_PDR4, 22, 6);
-
-	clk[nfc_div] = imx_clk_divider("nfc_div", "ahb", base + MX35_CCM_PDR4, 28, 4);
-
-	clk[csi_sel] = imx_clk_mux("csi_sel", base + MX35_CCM_PDR2, 7, 1, std_sel, ARRAY_SIZE(std_sel));
-	clk[csi_div] = imx_clk_divider("csi_div", "csi_sel", base + MX35_CCM_PDR2, 16, 6);
-
-	clk[asrc_gate] = imx_clk_gate2("asrc_gate", "ipg", base + MX35_CCM_CGR0,  0);
-	clk[pata_gate] = imx_clk_gate2("pata_gate", "ipg", base + MX35_CCM_CGR0,  2);
-	clk[audmux_gate] = imx_clk_gate2("audmux_gate", "ipg", base + MX35_CCM_CGR0,  4);
-	clk[can1_gate] = imx_clk_gate2("can1_gate", "ipg", base + MX35_CCM_CGR0,  6);
-	clk[can2_gate] = imx_clk_gate2("can2_gate", "ipg", base + MX35_CCM_CGR0,  8);
-	clk[cspi1_gate] = imx_clk_gate2("cspi1_gate", "ipg", base + MX35_CCM_CGR0, 10);
-	clk[cspi2_gate] = imx_clk_gate2("cspi2_gate", "ipg", base + MX35_CCM_CGR0, 12);
-	clk[ect_gate] = imx_clk_gate2("ect_gate", "ipg", base + MX35_CCM_CGR0, 14);
-	clk[edio_gate] = imx_clk_gate2("edio_gate",   "ipg", base + MX35_CCM_CGR0, 16);
-	clk[emi_gate] = imx_clk_gate2("emi_gate", "ipg", base + MX35_CCM_CGR0, 18);
-	clk[epit1_gate] = imx_clk_gate2("epit1_gate", "ipg", base + MX35_CCM_CGR0, 20);
-	clk[epit2_gate] = imx_clk_gate2("epit2_gate", "ipg", base + MX35_CCM_CGR0, 22);
-	clk[esai_gate] = imx_clk_gate2("esai_gate",   "ipg", base + MX35_CCM_CGR0, 24);
-	clk[esdhc1_gate] = imx_clk_gate2("esdhc1_gate", "esdhc1_div", base + MX35_CCM_CGR0, 26);
-	clk[esdhc2_gate] = imx_clk_gate2("esdhc2_gate", "esdhc2_div", base + MX35_CCM_CGR0, 28);
-	clk[esdhc3_gate] = imx_clk_gate2("esdhc3_gate", "esdhc3_div", base + MX35_CCM_CGR0, 30);
-
-	clk[fec_gate] = imx_clk_gate2("fec_gate", "ipg", base + MX35_CCM_CGR1,  0);
-	clk[gpio1_gate] = imx_clk_gate2("gpio1_gate", "ipg", base + MX35_CCM_CGR1,  2);
-	clk[gpio2_gate] = imx_clk_gate2("gpio2_gate", "ipg", base + MX35_CCM_CGR1,  4);
-	clk[gpio3_gate] = imx_clk_gate2("gpio3_gate", "ipg", base + MX35_CCM_CGR1,  6);
-	clk[gpt_gate] = imx_clk_gate2("gpt_gate", "ipg", base + MX35_CCM_CGR1,  8);
-	clk[i2c1_gate] = imx_clk_gate2("i2c1_gate", "ipg_per", base + MX35_CCM_CGR1, 10);
-	clk[i2c2_gate] = imx_clk_gate2("i2c2_gate", "ipg_per", base + MX35_CCM_CGR1, 12);
-	clk[i2c3_gate] = imx_clk_gate2("i2c3_gate", "ipg_per", base + MX35_CCM_CGR1, 14);
-	clk[iomuxc_gate] = imx_clk_gate2("iomuxc_gate", "ipg", base + MX35_CCM_CGR1, 16);
-	clk[ipu_gate] = imx_clk_gate2("ipu_gate", "hsp", base + MX35_CCM_CGR1, 18);
-	clk[kpp_gate] = imx_clk_gate2("kpp_gate", "ipg", base + MX35_CCM_CGR1, 20);
-	clk[mlb_gate] = imx_clk_gate2("mlb_gate", "ahb", base + MX35_CCM_CGR1, 22);
-	clk[mshc_gate] = imx_clk_gate2("mshc_gate", "dummy", base + MX35_CCM_CGR1, 24);
-	clk[owire_gate] = imx_clk_gate2("owire_gate", "ipg_per", base + MX35_CCM_CGR1, 26);
-	clk[pwm_gate] = imx_clk_gate2("pwm_gate", "ipg_per", base + MX35_CCM_CGR1, 28);
-	clk[rngc_gate] = imx_clk_gate2("rngc_gate", "ipg", base + MX35_CCM_CGR1, 30);
-
-	clk[rtc_gate] = imx_clk_gate2("rtc_gate", "ipg", base + MX35_CCM_CGR2,  0);
-	clk[rtic_gate] = imx_clk_gate2("rtic_gate", "ahb", base + MX35_CCM_CGR2,  2);
-	clk[scc_gate] = imx_clk_gate2("scc_gate", "ipg", base + MX35_CCM_CGR2,  4);
-	clk[sdma_gate] = imx_clk_gate2("sdma_gate", "ahb", base + MX35_CCM_CGR2,  6);
-	clk[spba_gate] = imx_clk_gate2("spba_gate", "ipg", base + MX35_CCM_CGR2,  8);
-	clk[spdif_gate] = imx_clk_gate2("spdif_gate", "spdif_div_post", base + MX35_CCM_CGR2, 10);
-	clk[ssi1_gate] = imx_clk_gate2("ssi1_gate", "ssi1_div_post", base + MX35_CCM_CGR2, 12);
-	clk[ssi2_gate] = imx_clk_gate2("ssi2_gate", "ssi2_div_post", base + MX35_CCM_CGR2, 14);
-	clk[uart1_gate] = imx_clk_gate2("uart1_gate", "uart_div", base + MX35_CCM_CGR2, 16);
-	clk[uart2_gate] = imx_clk_gate2("uart2_gate", "uart_div", base + MX35_CCM_CGR2, 18);
-	clk[uart3_gate] = imx_clk_gate2("uart3_gate", "uart_div", base + MX35_CCM_CGR2, 20);
-	clk[usbotg_gate] = imx_clk_gate2("usbotg_gate", "ahb", base + MX35_CCM_CGR2, 22);
-	clk[wdog_gate] = imx_clk_gate2("wdog_gate", "ipg", base + MX35_CCM_CGR2, 24);
-	clk[max_gate] = imx_clk_gate2("max_gate", "dummy", base + MX35_CCM_CGR2, 26);
-	clk[admux_gate] = imx_clk_gate2("admux_gate", "ipg", base + MX35_CCM_CGR2, 30);
-
-	clk[csi_gate] = imx_clk_gate2("csi_gate", "csi_div", base + MX35_CCM_CGR3,  0);
-	clk[iim_gate] = imx_clk_gate2("iim_gate", "ipg", base + MX35_CCM_CGR3,  2);
-	clk[gpu2d_gate] = imx_clk_gate2("gpu2d_gate", "ahb", base + MX35_CCM_CGR3,  4);
+	clk[IMX35_CLK_HSP] = imx_clk_fixed_factor("hsp", "arm",
+		1, hsp_div[hsp_sel]);
+
+	clk[IMX35_CLK_AHB] = imx_clk_fixed_factor("ahb", "arm", 1, aad->ahb);
+	clk[IMX35_CLK_IPG] = imx_clk_fixed_factor("ipg", "ahb", 1, 2);
+
+	clk[IMX35_CLK_ARM_PER_DIV] = imx_clk_divider("arm_per_div", "arm",
+		base + MX35_CCM_PDR4, 16, 6);
+	clk[IMX35_CLK_AHB_PER_DIV] = imx_clk_divider("ahb_per_div", "ahb",
+		base + MXC_CCM_PDR0, 12, 3);
+	clk[IMX35_CLK_IPG_PER] = imx_clk_mux("ipg_per", base + MXC_CCM_PDR0,
+		26, 1, ipg_per_sel, ARRAY_SIZE(ipg_per_sel));
+
+	clk[IMX35_CLK_UART_SEL] = imx_clk_mux("uart_sel", base + MX35_CCM_PDR3,
+		14, 1, std_sel, ARRAY_SIZE(std_sel));
+	clk[IMX35_CLK_UART_DIV] = imx_clk_divider("uart_div", "uart_sel",
+		base + MX35_CCM_PDR4, 10, 6);
+
+	clk[IMX35_CLK_ESDHC_SEL] = imx_clk_mux("esdhc_sel",
+		base + MX35_CCM_PDR4, 9, 1, std_sel, ARRAY_SIZE(std_sel));
+	clk[IMX35_CLK_ESDHC1_DIV] = imx_clk_divider("esdhc1_div", "esdhc_sel",
+		base + MX35_CCM_PDR3, 0, 6);
+	clk[IMX35_CLK_ESDHC2_DIV] = imx_clk_divider("esdhc2_div", "esdhc_sel",
+		base + MX35_CCM_PDR3, 8, 6);
+	clk[IMX35_CLK_ESDHC3_DIV] = imx_clk_divider("esdhc3_div", "esdhc_sel",
+		base + MX35_CCM_PDR3, 16, 6);
+
+	clk[IMX35_CLK_SPDIF_SEL] = imx_clk_mux("spdif_sel",
+		base + MX35_CCM_PDR3, 22, 1, std_sel, ARRAY_SIZE(std_sel));
+	clk[IMX35_CLK_SPDIF_DIV_PRE] = imx_clk_divider("spdif_div_pre",
+		"spdif_sel", base + MX35_CCM_PDR3, 29, 3);
+		/* divide by 1 not allowed */
+	clk[IMX35_CLK_SPDIF_DIV_POST] = imx_clk_divider("spdif_div_post",
+		"spdif_div_pre", base + MX35_CCM_PDR3, 23, 6);
+
+	clk[IMX35_CLK_SSI_SEL] = imx_clk_mux("ssi_sel", base + MX35_CCM_PDR2,
+		6, 1, std_sel, ARRAY_SIZE(std_sel));
+	clk[IMX35_CLK_SSI1_DIV_PRE] = imx_clk_divider("ssi1_div_pre",
+		"ssi_sel", base + MX35_CCM_PDR2, 24, 3);
+	clk[IMX35_CLK_SSI1_DIV_POST] = imx_clk_divider("ssi1_div_post",
+		"ssi1_div_pre", base + MX35_CCM_PDR2, 0, 6);
+	clk[IMX35_CLK_SSI2_DIV_PRE] = imx_clk_divider("ssi2_div_pre",
+		"ssi_sel", base + MX35_CCM_PDR2, 27, 3);
+	clk[IMX35_CLK_SSI2_DIV_POST] = imx_clk_divider("ssi2_div_post",
+		"ssi2_div_pre", base + MX35_CCM_PDR2, 8, 6);
+
+	clk[IMX35_CLK_USB_SEL] = imx_clk_mux("usb_sel", base + MX35_CCM_PDR4,
+		9, 1, std_sel, ARRAY_SIZE(std_sel));
+	clk[IMX35_CLK_USB_DIV] = imx_clk_divider("usb_div", "usb_sel",
+		base + MX35_CCM_PDR4, 22, 6);
+
+	clk[IMX35_CLK_NFC_DIV] = imx_clk_divider("nfc_div", "ahb",
+		 base + MX35_CCM_PDR4, 28, 4);
+
+	clk[IMX35_CLK_CSI_SEL] = imx_clk_mux("csi_sel", base + MX35_CCM_PDR2,
+		7, 1, std_sel, ARRAY_SIZE(std_sel));
+	clk[IMX35_CLK_CSI_DIV] = imx_clk_divider("csi_div", "csi_sel",
+		 base + MX35_CCM_PDR2, 16, 6);
+
+	clk[IMX35_CLK_ASRC_GATE] = imx_clk_gate2("asrc_gate", "ipg",
+		base + MX35_CCM_CGR0,  0);
+	clk[IMX35_CLK_PATA_GATE] = imx_clk_gate2("pata_gate", "ipg",
+		base + MX35_CCM_CGR0,  2);
+	clk[IMX35_CLK_AUDMUX_GATE] = imx_clk_gate2("audmux_gate", "ipg",
+		base + MX35_CCM_CGR0,  4);
+	clk[IMX35_CLK_CAN1_GATE] = imx_clk_gate2("can1_gate", "ipg",
+		base + MX35_CCM_CGR0,  6);
+	clk[IMX35_CLK_CAN2_GATE] = imx_clk_gate2("can2_gate", "ipg",
+		base + MX35_CCM_CGR0,  8);
+	clk[IMX35_CLK_CSPI1_GATE] = imx_clk_gate2("cspi1_gate", "ipg",
+		base + MX35_CCM_CGR0, 10);
+	clk[IMX35_CLK_CSPI2_GATE] = imx_clk_gate2("cspi2_gate", "ipg",
+		base + MX35_CCM_CGR0, 12);
+	clk[IMX35_CLK_ECT_GATE] = imx_clk_gate2("ect_gate", "ipg",
+		base + MX35_CCM_CGR0, 14);
+	clk[IMX35_CLK_EDIO_GATE] = imx_clk_gate2("edio_gate", "ipg",
+		base + MX35_CCM_CGR0, 16);
+	clk[IMX35_CLK_EMI_GATE] = imx_clk_gate2("emi_gate", "ipg",
+		base + MX35_CCM_CGR0, 18);
+	clk[IMX35_CLK_EPIT1_GATE] = imx_clk_gate2("epit1_gate", "ipg",
+		base + MX35_CCM_CGR0, 20);
+	clk[IMX35_CLK_EPIT2_GATE] = imx_clk_gate2("epit2_gate", "ipg",
+		base + MX35_CCM_CGR0, 22);
+	clk[IMX35_CLK_ESAI_GATE] = imx_clk_gate2("esai_gate", "ipg",
+		base + MX35_CCM_CGR0, 24);
+	clk[IMX35_CLK_ESDHC1_GATE] = imx_clk_gate2("esdhc1_gate", "esdhc1_div",
+		base + MX35_CCM_CGR0, 26);
+	clk[IMX35_CLK_ESDHC2_GATE] = imx_clk_gate2("esdhc2_gate", "esdhc2_div",
+		base + MX35_CCM_CGR0, 28);
+	clk[IMX35_CLK_ESDHC3_GATE] = imx_clk_gate2("esdhc3_gate", "esdhc3_div",
+		base + MX35_CCM_CGR0, 30);
+
+	clk[IMX35_CLK_FEC_GATE] = imx_clk_gate2("fec_gate", "ipg",
+		base + MX35_CCM_CGR1,  0);
+	clk[IMX35_CLK_GPIO1_GATE] = imx_clk_gate2("gpio1_gate", "ipg",
+		base + MX35_CCM_CGR1,  2);
+	clk[IMX35_CLK_GPIO2_GATE] = imx_clk_gate2("gpio2_gate", "ipg",
+		base + MX35_CCM_CGR1,  4);
+	clk[IMX35_CLK_GPIO3_GATE] = imx_clk_gate2("gpio3_gate", "ipg",
+		base + MX35_CCM_CGR1,  6);
+	clk[IMX35_CLK_GPT_GATE] = imx_clk_gate2("gpt_gate", "ipg",
+		base + MX35_CCM_CGR1,  8);
+	clk[IMX35_CLK_I2C1_GATE] = imx_clk_gate2("i2c1_gate", "ipg_per",
+		base + MX35_CCM_CGR1, 10);
+	clk[IMX35_CLK_I2C2_GATE] = imx_clk_gate2("i2c2_gate", "ipg_per",
+		base + MX35_CCM_CGR1, 12);
+	clk[IMX35_CLK_I2C3_GATE] = imx_clk_gate2("i2c3_gate", "ipg_per",
+		base + MX35_CCM_CGR1, 14);
+	clk[IMX35_CLK_IOMUXC_GATE] = imx_clk_gate2("iomuxc_gate", "ipg",
+		base + MX35_CCM_CGR1, 16);
+	clk[IMX35_CLK_IPU_GATE] = imx_clk_gate2("ipu_gate", "hsp",
+		base + MX35_CCM_CGR1, 18);
+	clk[IMX35_CLK_KPP_GATE] = imx_clk_gate2("kpp_gate", "ipg",
+		base + MX35_CCM_CGR1, 20);
+	clk[IMX35_CLK_MLB_GATE] = imx_clk_gate2("mlb_gate", "ahb",
+		base + MX35_CCM_CGR1, 22);
+	clk[IMX35_CLK_MSHC_GATE] = imx_clk_gate2("mshc_gate", "dummy",
+		base + MX35_CCM_CGR1, 24);
+	clk[IMX35_CLK_OWIRE_GATE] = imx_clk_gate2("owire_gate", "ipg_per",
+		base + MX35_CCM_CGR1, 26);
+	clk[IMX35_CLK_PWM_GATE] = imx_clk_gate2("pwm_gate", "ipg_per",
+		base + MX35_CCM_CGR1, 28);
+	clk[IMX35_CLK_RNGC_GATE] = imx_clk_gate2("rngc_gate", "ipg",
+		base + MX35_CCM_CGR1, 30);
+
+	clk[IMX35_CLK_RTC_GATE] = imx_clk_gate2("rtc_gate", "ipg",
+		base + MX35_CCM_CGR2,  0);
+	clk[IMX35_CLK_RTIC_GATE] = imx_clk_gate2("rtic_gate", "ahb",
+		base + MX35_CCM_CGR2,  2);
+	clk[IMX35_CLK_SCC_GATE] = imx_clk_gate2("scc_gate", "ipg",
+		base + MX35_CCM_CGR2,  4);
+	clk[IMX35_CLK_SDMA_GATE] = imx_clk_gate2("sdma_gate", "ahb",
+		base + MX35_CCM_CGR2,  6);
+	clk[IMX35_CLK_SPBA_GATE] = imx_clk_gate2("spba_gate", "ipg",
+		base + MX35_CCM_CGR2,  8);
+	clk[IMX35_CLK_SPDIF_GATE] = imx_clk_gate2("spdif_gate",
+		"spdif_div_post", base + MX35_CCM_CGR2, 10);
+	clk[IMX35_CLK_SSI1_GATE] = imx_clk_gate2("ssi1_gate", "ssi1_div_post",
+		 base + MX35_CCM_CGR2, 12);
+	clk[IMX35_CLK_SSI2_GATE] = imx_clk_gate2("ssi2_gate", "ssi2_div_post",
+		 base + MX35_CCM_CGR2, 14);
+	clk[IMX35_CLK_UART1_GATE] = imx_clk_gate2("uart1_gate", "uart_div",
+		 base + MX35_CCM_CGR2, 16);
+	clk[IMX35_CLK_UART2_GATE] = imx_clk_gate2("uart2_gate", "uart_div",
+		 base + MX35_CCM_CGR2, 18);
+	clk[IMX35_CLK_UART3_GATE] = imx_clk_gate2("uart3_gate", "uart_div",
+		 base + MX35_CCM_CGR2, 20);
+	clk[IMX35_CLK_USBOTG_GATE] = imx_clk_gate2("usbotg_gate", "ahb",
+		 base + MX35_CCM_CGR2, 22);
+	clk[IMX35_CLK_WDOG_GATE] = imx_clk_gate2("wdog_gate", "ipg",
+		 base + MX35_CCM_CGR2, 24);
+	clk[IMX35_CLK_MAX_GATE] = imx_clk_gate2("max_gate", "dummy",
+		 base + MX35_CCM_CGR2, 26);
+	clk[IMX35_CLK_ADMUX_GATE] = imx_clk_gate2("admux_gate", "ipg",
+		 base + MX35_CCM_CGR2, 30);
+
+	clk[IMX35_CLK_CSI_GATE] = imx_clk_gate2("csi_gate", "csi_div",
+		 base + MX35_CCM_CGR3,  0);
+	clk[IMX35_CLK_IIM_GATE] = imx_clk_gate2("iim_gate", "ipg",
+		 base + MX35_CCM_CGR3,  2);
+	clk[IMX35_CLK_GPU2D_GATE] = imx_clk_gate2("gpu2d_gate", "ahb",
+		 base + MX35_CCM_CGR3,  4);
 
 	imx_check_clocks(clk, ARRAY_SIZE(clk));
 
-	clk_prepare_enable(clk[spba_gate]);
-	clk_prepare_enable(clk[gpio1_gate]);
-	clk_prepare_enable(clk[gpio2_gate]);
-	clk_prepare_enable(clk[gpio3_gate]);
-	clk_prepare_enable(clk[iim_gate]);
-	clk_prepare_enable(clk[emi_gate]);
-	clk_prepare_enable(clk[max_gate]);
-	clk_prepare_enable(clk[iomuxc_gate]);
+	clk_prepare_enable(clk[IMX35_CLK_SPBA_GATE]);
+	clk_prepare_enable(clk[IMX35_CLK_GPIO1_GATE]);
+	clk_prepare_enable(clk[IMX35_CLK_GPIO2_GATE]);
+	clk_prepare_enable(clk[IMX35_CLK_GPIO3_GATE]);
+	clk_prepare_enable(clk[IMX35_CLK_IIM_GATE]);
+	clk_prepare_enable(clk[IMX35_CLK_EMI_GATE]);
+	clk_prepare_enable(clk[IMX35_CLK_MAX_GATE]);
+	clk_prepare_enable(clk[IMX35_CLK_IOMUXC_GATE]);
 
 	/*
 	 * SCC is needed to boot via mmc after a watchdog reset. The clock code
@@ -243,7 +305,7 @@ static void __init _mx35_clocks_init(void)
 	 * handled here and not needed for mmc) and IIM (which is enabled
 	 * unconditionally above).
 	 */
-	clk_prepare_enable(clk[scc_gate]);
+	clk_prepare_enable(clk[IMX35_CLK_SCC_GATE]);
 
 	imx_register_uart_clocks(uart_clks);
 
@@ -254,64 +316,67 @@ int __init mx35_clocks_init(void)
 {
 	_mx35_clocks_init();
 
-	clk_register_clkdev(clk[pata_gate], NULL, "pata_imx");
-	clk_register_clkdev(clk[can1_gate], NULL, "flexcan.0");
-	clk_register_clkdev(clk[can2_gate], NULL, "flexcan.1");
-	clk_register_clkdev(clk[cspi1_gate], "per", "imx35-cspi.0");
-	clk_register_clkdev(clk[cspi1_gate], "ipg", "imx35-cspi.0");
-	clk_register_clkdev(clk[cspi2_gate], "per", "imx35-cspi.1");
-	clk_register_clkdev(clk[cspi2_gate], "ipg", "imx35-cspi.1");
-	clk_register_clkdev(clk[epit1_gate], NULL, "imx-epit.0");
-	clk_register_clkdev(clk[epit2_gate], NULL, "imx-epit.1");
-	clk_register_clkdev(clk[esdhc1_gate], "per", "sdhci-esdhc-imx35.0");
-	clk_register_clkdev(clk[ipg], "ipg", "sdhci-esdhc-imx35.0");
-	clk_register_clkdev(clk[ahb], "ahb", "sdhci-esdhc-imx35.0");
-	clk_register_clkdev(clk[esdhc2_gate], "per", "sdhci-esdhc-imx35.1");
-	clk_register_clkdev(clk[ipg], "ipg", "sdhci-esdhc-imx35.1");
-	clk_register_clkdev(clk[ahb], "ahb", "sdhci-esdhc-imx35.1");
-	clk_register_clkdev(clk[esdhc3_gate], "per", "sdhci-esdhc-imx35.2");
-	clk_register_clkdev(clk[ipg], "ipg", "sdhci-esdhc-imx35.2");
-	clk_register_clkdev(clk[ahb], "ahb", "sdhci-esdhc-imx35.2");
+	clk_register_clkdev(clk[IMX35_CLK_PATA_GATE], NULL, "pata_imx");
+	clk_register_clkdev(clk[IMX35_CLK_CAN1_GATE], NULL, "flexcan.0");
+	clk_register_clkdev(clk[IMX35_CLK_CAN2_GATE], NULL, "flexcan.1");
+	clk_register_clkdev(clk[IMX35_CLK_CSPI1_GATE], "per", "imx35-cspi.0");
+	clk_register_clkdev(clk[IMX35_CLK_CSPI1_GATE], "ipg", "imx35-cspi.0");
+	clk_register_clkdev(clk[IMX35_CLK_CSPI2_GATE], "per", "imx35-cspi.1");
+	clk_register_clkdev(clk[IMX35_CLK_CSPI2_GATE], "ipg", "imx35-cspi.1");
+	clk_register_clkdev(clk[IMX35_CLK_EPIT1_GATE], NULL, "imx-epit.0");
+	clk_register_clkdev(clk[IMX35_CLK_EPIT2_GATE], NULL, "imx-epit.1");
+	clk_register_clkdev(clk[IMX35_CLK_ESDHC1_GATE], "per",
+		"sdhci-esdhc-imx35.0");
+	clk_register_clkdev(clk[IMX35_CLK_IPG], "ipg", "sdhci-esdhc-imx35.0");
+	clk_register_clkdev(clk[IMX35_CLK_AHB], "ahb", "sdhci-esdhc-imx35.0");
+	clk_register_clkdev(clk[IMX35_CLK_ESDHC2_GATE], "per",
+		"sdhci-esdhc-imx35.1");
+	clk_register_clkdev(clk[IMX35_CLK_IPG], "ipg", "sdhci-esdhc-imx35.1");
+	clk_register_clkdev(clk[IMX35_CLK_AHB], "ahb", "sdhci-esdhc-imx35.1");
+	clk_register_clkdev(clk[IMX35_CLK_ESDHC3_GATE], "per",
+		"sdhci-esdhc-imx35.2");
+	clk_register_clkdev(clk[IMX35_CLK_IPG], "ipg", "sdhci-esdhc-imx35.2");
+	clk_register_clkdev(clk[IMX35_CLK_AHB], "ahb", "sdhci-esdhc-imx35.2");
 	/* i.mx35 has the i.mx27 type fec */
-	clk_register_clkdev(clk[fec_gate], NULL, "imx27-fec.0");
-	clk_register_clkdev(clk[gpt_gate], "per", "imx-gpt.0");
-	clk_register_clkdev(clk[ipg], "ipg", "imx-gpt.0");
-	clk_register_clkdev(clk[i2c1_gate], NULL, "imx21-i2c.0");
-	clk_register_clkdev(clk[i2c2_gate], NULL, "imx21-i2c.1");
-	clk_register_clkdev(clk[i2c3_gate], NULL, "imx21-i2c.2");
-	clk_register_clkdev(clk[ipu_gate], NULL, "ipu-core");
-	clk_register_clkdev(clk[ipu_gate], NULL, "mx3_sdc_fb");
-	clk_register_clkdev(clk[kpp_gate], NULL, "imx-keypad");
-	clk_register_clkdev(clk[owire_gate], NULL, "mxc_w1");
-	clk_register_clkdev(clk[sdma_gate], NULL, "imx35-sdma");
-	clk_register_clkdev(clk[ssi1_gate], NULL, "imx-ssi.0");
-	clk_register_clkdev(clk[ssi2_gate], NULL, "imx-ssi.1");
+	clk_register_clkdev(clk[IMX35_CLK_FEC_GATE], NULL, "imx27-fec.0");
+	clk_register_clkdev(clk[IMX35_CLK_GPT_GATE], "per", "imx-gpt.0");
+	clk_register_clkdev(clk[IMX35_CLK_IPG], "ipg", "imx-gpt.0");
+	clk_register_clkdev(clk[IMX35_CLK_I2C1_GATE], NULL, "imx21-i2c.0");
+	clk_register_clkdev(clk[IMX35_CLK_I2C2_GATE], NULL, "imx21-i2c.1");
+	clk_register_clkdev(clk[IMX35_CLK_I2C3_GATE], NULL, "imx21-i2c.2");
+	clk_register_clkdev(clk[IMX35_CLK_IPU_GATE], NULL, "ipu-core");
+	clk_register_clkdev(clk[IMX35_CLK_IPU_GATE], NULL, "mx3_sdc_fb");
+	clk_register_clkdev(clk[IMX35_CLK_KPP_GATE], NULL, "imx-keypad");
+	clk_register_clkdev(clk[IMX35_CLK_OWIRE_GATE], NULL, "mxc_w1");
+	clk_register_clkdev(clk[IMX35_CLK_SDMA_GATE], NULL, "imx35-sdma");
+	clk_register_clkdev(clk[IMX35_CLK_SSI1_GATE], NULL, "imx-ssi.0");
+	clk_register_clkdev(clk[IMX35_CLK_SSI2_GATE], NULL, "imx-ssi.1");
 	/* i.mx35 has the i.mx21 type uart */
-	clk_register_clkdev(clk[uart1_gate], "per", "imx21-uart.0");
-	clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.0");
-	clk_register_clkdev(clk[uart2_gate], "per", "imx21-uart.1");
-	clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.1");
-	clk_register_clkdev(clk[uart3_gate], "per", "imx21-uart.2");
-	clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.2");
+	clk_register_clkdev(clk[IMX35_CLK_UART1_GATE], "per", "imx21-uart.0");
+	clk_register_clkdev(clk[IMX35_CLK_IPG], "ipg", "imx21-uart.0");
+	clk_register_clkdev(clk[IMX35_CLK_UART2_GATE], "per", "imx21-uart.1");
+	clk_register_clkdev(clk[IMX35_CLK_IPG], "ipg", "imx21-uart.1");
+	clk_register_clkdev(clk[IMX35_CLK_UART3_GATE], "per", "imx21-uart.2");
+	clk_register_clkdev(clk[IMX35_CLK_IPG], "ipg", "imx21-uart.2");
 	/* i.mx35 has the i.mx21 type rtc */
-	clk_register_clkdev(clk[ckil], "ref", "imx21-rtc");
-	clk_register_clkdev(clk[rtc_gate], "ipg", "imx21-rtc");
-	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.0");
-	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.0");
-	clk_register_clkdev(clk[usbotg_gate], "ahb", "mxc-ehci.0");
-	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.1");
-	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.1");
-	clk_register_clkdev(clk[usbotg_gate], "ahb", "mxc-ehci.1");
-	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.2");
-	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.2");
-	clk_register_clkdev(clk[usbotg_gate], "ahb", "mxc-ehci.2");
-	clk_register_clkdev(clk[usb_div], "per", "imx-udc-mx27");
-	clk_register_clkdev(clk[ipg], "ipg", "imx-udc-mx27");
-	clk_register_clkdev(clk[usbotg_gate], "ahb", "imx-udc-mx27");
-	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
-	clk_register_clkdev(clk[nfc_div], NULL, "imx25-nand.0");
-	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
-	clk_register_clkdev(clk[admux_gate], "audmux", NULL);
+	clk_register_clkdev(clk[IMX35_CLK_CKIL], "ref", "imx21-rtc");
+	clk_register_clkdev(clk[IMX35_CLK_RTC_GATE], "ipg", "imx21-rtc");
+	clk_register_clkdev(clk[IMX35_CLK_USB_DIV], "per", "mxc-ehci.0");
+	clk_register_clkdev(clk[IMX35_CLK_IPG], "ipg", "mxc-ehci.0");
+	clk_register_clkdev(clk[IMX35_CLK_USBOTG_GATE], "ahb", "mxc-ehci.0");
+	clk_register_clkdev(clk[IMX35_CLK_USB_DIV], "per", "mxc-ehci.1");
+	clk_register_clkdev(clk[IMX35_CLK_IPG], "ipg", "mxc-ehci.1");
+	clk_register_clkdev(clk[IMX35_CLK_USBOTG_GATE], "ahb", "mxc-ehci.1");
+	clk_register_clkdev(clk[IMX35_CLK_USB_DIV], "per", "mxc-ehci.2");
+	clk_register_clkdev(clk[IMX35_CLK_IPG], "ipg", "mxc-ehci.2");
+	clk_register_clkdev(clk[IMX35_CLK_USBOTG_GATE], "ahb", "mxc-ehci.2");
+	clk_register_clkdev(clk[IMX35_CLK_USB_DIV], "per", "imx-udc-mx27");
+	clk_register_clkdev(clk[IMX35_CLK_IPG], "ipg", "imx-udc-mx27");
+	clk_register_clkdev(clk[IMX35_CLK_USBOTG_GATE], "ahb", "imx-udc-mx27");
+	clk_register_clkdev(clk[IMX35_CLK_WDOG_GATE], NULL, "imx2-wdt.0");
+	clk_register_clkdev(clk[IMX35_CLK_NFC_DIV], NULL, "imx25-nand.0");
+	clk_register_clkdev(clk[IMX35_CLK_CSI_GATE], NULL, "mx3-camera.0");
+	clk_register_clkdev(clk[IMX35_CLK_ADMUX_GATE], "audmux", NULL);
 
 	mxc_timer_init(MX35_GPT1_BASE_ADDR, MX35_INT_GPT, GPT_TYPE_IMX31);
 
diff --git a/include/dt-bindings/clock/imx35-clock.h b/include/dt-bindings/clock/imx35-clock.h
new file mode 100644
index 0000000..6d748ae
--- /dev/null
+++ b/include/dt-bindings/clock/imx35-clock.h
@@ -0,0 +1,98 @@
+/*
+ * Copyright (C) 2016 Alexander Kurz <akurz@blala.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX35_H
+#define __DT_BINDINGS_CLOCK_IMX35_H
+
+#define IMX35_CLK_CKIH	0
+#define IMX35_CLK_MPLL	1
+#define IMX35_CLK_PPLL	2
+#define IMX35_CLK_MPLL_075	3
+#define IMX35_CLK_ARM	4
+#define IMX35_CLK_HSP	5
+#define IMX35_CLK_HSP_DIV	6
+#define IMX35_CLK_HSP_SEL	7
+#define IMX35_CLK_AHB	8
+#define IMX35_CLK_IPG	9
+#define IMX35_CLK_ARM_PER_DIV	10
+#define IMX35_CLK_AHB_PER_DIV	11
+#define IMX35_CLK_IPG_PER	12
+#define IMX35_CLK_UART_SEL	13
+#define IMX35_CLK_UART_DIV	14
+#define IMX35_CLK_ESDHC_SEL	15
+#define IMX35_CLK_ESDHC1_DIV	16
+#define IMX35_CLK_ESDHC2_DIV	17
+#define IMX35_CLK_ESDHC3_DIV	18
+#define IMX35_CLK_SPDIF_SEL	19
+#define IMX35_CLK_SPDIF_DIV_PRE	20
+#define IMX35_CLK_SPDIF_DIV_POST	21
+#define IMX35_CLK_SSI_SEL	22
+#define IMX35_CLK_SSI1_DIV_PRE	23
+#define IMX35_CLK_SSI1_DIV_POST	24
+#define IMX35_CLK_SSI2_DIV_PRE	25
+#define IMX35_CLK_SSI2_DIV_POST	26
+#define IMX35_CLK_USB_SEL	27
+#define IMX35_CLK_USB_DIV	28
+#define IMX35_CLK_NFC_DIV	29
+#define IMX35_CLK_ASRC_GATE	30
+#define IMX35_CLK_PATA_GATE	31
+#define IMX35_CLK_AUDMUX_GATE	32
+#define IMX35_CLK_CAN1_GATE	33
+#define IMX35_CLK_CAN2_GATE	34
+#define IMX35_CLK_CSPI1_GATE	35
+#define IMX35_CLK_CSPI2_GATE	36
+#define IMX35_CLK_ECT_GATE	37
+#define IMX35_CLK_EDIO_GATE	38
+#define IMX35_CLK_EMI_GATE	39
+#define IMX35_CLK_EPIT1_GATE	40
+#define IMX35_CLK_EPIT2_GATE	41
+#define IMX35_CLK_ESAI_GATE	42
+#define IMX35_CLK_ESDHC1_GATE	43
+#define IMX35_CLK_ESDHC2_GATE	44
+#define IMX35_CLK_ESDHC3_GATE	45
+#define IMX35_CLK_FEC_GATE	46
+#define IMX35_CLK_GPIO1_GATE	47
+#define IMX35_CLK_GPIO2_GATE	48
+#define IMX35_CLK_GPIO3_GATE	49
+#define IMX35_CLK_GPT_GATE	50
+#define IMX35_CLK_I2C1_GATE	51
+#define IMX35_CLK_I2C2_GATE	52
+#define IMX35_CLK_I2C3_GATE	53
+#define IMX35_CLK_IOMUXC_GATE	54
+#define IMX35_CLK_IPU_GATE	55
+#define IMX35_CLK_KPP_GATE	56
+#define IMX35_CLK_MLB_GATE	57
+#define IMX35_CLK_MSHC_GATE	58
+#define IMX35_CLK_OWIRE_GATE	59
+#define IMX35_CLK_PWM_GATE	60
+#define IMX35_CLK_RNGC_GATE	61
+#define IMX35_CLK_RTC_GATE	62
+#define IMX35_CLK_RTIC_GATE	63
+#define IMX35_CLK_SCC_GATE	64
+#define IMX35_CLK_SDMA_GATE	65
+#define IMX35_CLK_SPBA_GATE	66
+#define IMX35_CLK_SPDIF_GATE	67
+#define IMX35_CLK_SSI1_GATE	68
+#define IMX35_CLK_SSI2_GATE	69
+#define IMX35_CLK_UART1_GATE	70
+#define IMX35_CLK_UART2_GATE	71
+#define IMX35_CLK_UART3_GATE	72
+#define IMX35_CLK_USBOTG_GATE	73
+#define IMX35_CLK_WDOG_GATE	74
+#define IMX35_CLK_MAX_GATE	75
+#define IMX35_CLK_ADMUX_GATE	76
+#define IMX35_CLK_CSI_GATE	77
+#define IMX35_CLK_CSI_DIV	78
+#define IMX35_CLK_CSI_SEL	79
+#define IMX35_CLK_IIM_GATE	80
+#define IMX35_CLK_GPU2D_GATE	81
+#define IMX35_CLK_CKIL	82
+#define IMX35_CLK_MAX	83
+
+#endif
-- 
2.1.4
