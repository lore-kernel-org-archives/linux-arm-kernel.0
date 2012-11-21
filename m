From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 21 Nov 2012 19:15:26 -0200
Subject: [RFC] ARM: mx27: Replace clk_register_clkdev with clock DT lookup
Message-ID: <1353532526-12897-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
task for the clock devices easier.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Sascha/Shawn,

Trying the same approach from mx6/mx5 does not work on mx27.
This patch causes the console to be messed up.

Any suggestion as to what should be different for mx27?

Thanks

 .../devicetree/bindings/clock/imx27-clock.txt      |  111 ++++++++++++++++++++
 arch/arm/boot/dts/imx27.dtsi                       |    8 ++
 arch/arm/mach-imx/clk-imx27.c                      |    9 ++
 arch/arm/mach-imx/imx27-dt.c                       |    3 +-
 4 files changed, 129 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx27-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/imx27-clock.txt b/Documentation/devicetree/bindings/clock/imx27-clock.txt
new file mode 100644
index 0000000..e874a36
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx27-clock.txt
@@ -0,0 +1,111 @@
+* Clock bindings for Freescale i.MX27
+
+Required properties:
+- compatible: Should be "fsl,imx27-ccm"
+- reg: Address and length of the register set
+- #clock-cells: Should be <1>
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.  The following is a full list of i.MX27
+clocks and IDs.
+
+	Clock			ID
+	---------------------------
+	dummy			0 
+	ckih			1
+	ckil			2
+	mpll			3
+	spll			4
+	mpll_main2		5
+	ahb ipg			6
+	nfc_div 		7
+	per1_div		8
+	per2_div 		9
+	per3_div		10 
+	per4_div 		11
+	vpu_sel 		12
+	vpu_div 		13
+	usb_div 		14
+	cpu_sel			15
+	clko_sel 		16
+	cpu_div			17
+	clko_div		18
+	ssi1_sel		19
+	ssi2_sel		20
+	ssi1_div		21
+	ssi2_div		22
+	clko_en			23
+	ssi2_ipg_gate		24
+	ssi1_ipg_gate		25
+	slcdc_ipg_gate		26
+	sdhc3_ipg_gate		27
+	sdhc2_ipg_gate		28
+	sdhc1_ipg_gate		29
+	scc_ipg_gate		30
+	sahara_ipg_gate		31
+	rtc_ipg_gate		32
+	pwm_ipg_gate		33
+	owire_ipg_gate		34
+	lcdc_ipg_gate		35
+	kpp_ipg_gate		36
+	iim_ipg_gate		37
+	i2c2_ipg_gate		38
+	i2c1_ipg_gate		39
+	gpt6_ipg_gate		40
+	gpt5_ipg_gate		41
+	gpt4_ipg_gate		42
+	gpt3_ipg_gate		43
+	gpt2_ipg_gate		44
+	gpt1_ipg_gate		45
+	gpio_ipg_gate		46
+	fec_ipg_gate		47
+	emma_ipg_gate		48	
+	dma_ipg_gate		49
+	cspi3_ipg_gate		50
+	cspi2_ipg_gate		51
+	cspi1_ipg_gate		52
+	nfc_baud_gate		53
+	ssi2_baud_gate		54
+	ssi1_baud_gate		55
+	vpu_baud_gate		56
+	per4_gate		57
+	per3_gate		58
+	per2_gate		59
+	per1_gate		60
+	usb_ahb_gate		61
+	slcdc_ahb_gate		62
+	sahara_ahb_gate		63
+	lcdc_ahb_gate		64
+	vpu_ahb_gate		65
+	fec_ahb_gate		66
+	emma_ahb_gate		67	
+	emi_ahb_gate		68
+	dma_ahb_gate		69
+	csi_ahb_gate		70
+	brom_ahb_gate		71
+	ata_ahb_gate		72
+	wdog_ipg_gate		73
+	usb_ipg_gate		74
+	uart6_ipg_gate		75
+	uart5_ipg_gate		76
+	uart4_ipg_gate		77
+	uart3_ipg_gate		78
+	uart2_ipg_gate		79
+	uart1_ipg_gate		80
+
+Examples:
+
+clks: ccm at 10027000{
+	compatible = "fsl,imx27-ccm";
+	reg = <0x10027000 0x1000>;
+	#clock-cells = <1>;
+};
+
+uart1: serial at 1000a000 {
+	compatible = "fsl,imx27-uart", "fsl,imx21-uart";
+	reg = <0x1000a000 0x1000>;
+	interrupts = <20>;
+	clocks = <&clks 80>, <&clks 60>;
+	clock-names = "ipg", "per";
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 8676152..da1e99e 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -68,6 +68,8 @@
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000a000 0x1000>;
 				interrupts = <20>;
+				clocks = <&clks 80>, <&clks 60>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -226,6 +228,12 @@
 				interrupts = <50>;
 				status = "disabled";
 			};
+
+			clks: ccm at 10027000{
+				compatible = "fsl,imx27-ccm";
+				reg = <0x10027000 0x1000>;
+				#clock-cells = <1>;
+			};
 		};
 
 		nand at d8000000 {
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 366e5d5..d15862c 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -83,10 +83,12 @@ enum mx27_clks {
 };
 
 static struct clk *clk[clk_max];
+static struct clk_onecell_data clk_data;
 
 int __init mx27_clocks_init(unsigned long fref)
 {
 	int i;
+	struct device_node *np;
 
 	clk[dummy] = imx_clk_fixed("dummy", 0);
 	clk[ckih] = imx_clk_fixed("ckih", fref);
@@ -186,6 +188,13 @@ int __init mx27_clocks_init(unsigned long fref)
 			pr_err("i.MX27 clk %d: register failed with %ld\n",
 				i, PTR_ERR(clk[i]));
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx27-ccm");
+	if (np) {
+		clk_data.clks = clk;
+		clk_data.clk_num = ARRAY_SIZE(clk);
+		of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	}
+
 	clk_register_clkdev(clk[uart1_ipg_gate], "ipg", "imx21-uart.0");
 	clk_register_clkdev(clk[per1_gate], "per", "imx21-uart.0");
 	clk_register_clkdev(clk[uart2_ipg_gate], "ipg", "imx21-uart.1");
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index e80d523..41e62f7 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -34,8 +34,7 @@ static const struct of_dev_auxdata imx27_auxdata_lookup[] __initconst = {
 
 static void __init imx27_dt_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     imx27_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static void __init imx27_timer_init(void)
-- 
1.7.9.5
