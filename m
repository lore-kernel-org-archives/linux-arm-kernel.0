From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 28 Nov 2012 15:55:30 -0200
Subject: [PATCH] ARM: mx27: Replace clk_register_clkdev with clock DT lookup
Message-ID: <1354125330-18872-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
task for the clock devices easier.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 .../devicetree/bindings/clock/imx27-clock.txt      |  117 ++++++++++++++++++++
 arch/arm/boot/dts/imx27.dtsi                       |   31 ++++++
 arch/arm/mach-imx/clk-imx27.c                      |    9 ++
 arch/arm/mach-imx/imx27-dt.c                       |   18 +--
 4 files changed, 158 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx27-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/imx27-clock.txt b/Documentation/devicetree/bindings/clock/imx27-clock.txt
new file mode 100644
index 0000000..ab1a56e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx27-clock.txt
@@ -0,0 +1,117 @@
+* Clock bindings for Freescale i.MX27
+
+Required properties:
+- compatible: Should be "fsl,imx27-ccm"
+- reg: Address and length of the register set
+- interrupts: Should contain CCM interrupt
+- #clock-cells: Should be <1>
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.  The following is a full list of i.MX27
+clocks and IDs.
+
+	Clock		    ID
+	-----------------------
+	dummy                0
+	ckih                 1
+	ckil                 2
+	mpll                 3
+	spll                 4
+	mpll_main2           5
+	ahb                  6
+	ipg                  7
+	nfc_div              8
+	per1_div             9
+	per2_div             10
+	per3_div             11
+	per4_div             12
+	vpu_sel              13
+	vpu_div              14
+	usb_div              15
+	cpu_sel              16
+	clko_sel             17
+	cpu_div              18
+	clko_div             19
+	ssi1_sel             20
+	ssi2_sel             21
+	ssi1_div             22
+	ssi2_div             23
+	clko_en              24
+	ssi2_ipg_gate        25
+	ssi1_ipg_gate        26
+	slcdc_ipg_gate       27
+	sdhc3_ipg_gate       28
+	sdhc2_ipg_gate       29
+	sdhc1_ipg_gate       30
+	scc_ipg_gate         31
+	sahara_ipg_gate      32
+	rtc_ipg_gate         33
+	pwm_ipg_gate         34
+	owire_ipg_gate       35
+	lcdc_ipg_gate        36
+	kpp_ipg_gate         37
+	iim_ipg_gate         38
+	i2c2_ipg_gate        39
+	i2c1_ipg_gate        40
+	gpt6_ipg_gate        41
+	gpt5_ipg_gate        42
+	gpt4_ipg_gate        43
+	gpt3_ipg_gate        44
+	gpt2_ipg_gate        45
+	gpt1_ipg_gate        46
+	gpio_ipg_gate        47
+	fec_ipg_gate         48
+	emma_ipg_gate        49
+	dma_ipg_gate         50
+	cspi3_ipg_gate       51
+	cspi2_ipg_gate       52
+	cspi1_ipg_gate       53
+	nfc_baud_gate        54
+	ssi2_baud_gate       55
+	ssi1_baud_gate       56
+	vpu_baud_gate        57
+	per4_gate            58
+	per3_gate            59
+	per2_gate            60
+	per1_gate            61
+	usb_ahb_gate         62
+	slcdc_ahb_gate       63
+	sahara_ahb_gate      64
+	lcdc_ahb_gate        65
+	vpu_ahb_gate         66
+	fec_ahb_gate         67
+	emma_ahb_gate        68
+	emi_ahb_gate         69
+	dma_ahb_gate         70
+	csi_ahb_gate         71
+	brom_ahb_gate        72
+	ata_ahb_gate         73
+	wdog_ipg_gate        74
+	usb_ipg_gate         75
+	uart6_ipg_gate       76
+	uart5_ipg_gate       77
+	uart4_ipg_gate       78
+	uart3_ipg_gate       79
+	uart2_ipg_gate       80
+	uart1_ipg_gate       81
+	ckih_div1p5          82
+	fpm                  83
+	mpll_osc_sel         84
+	mpll_sel             85
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
+	clocks = <&clks 81>, <&clks 61>;
+	clock-names = "ipg", "per";
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index b8d3905..d26da1b 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -62,12 +62,15 @@
 				compatible = "fsl,imx27-wdt", "fsl,imx21-wdt";
 				reg = <0x10002000 0x4000>;
 				interrupts = <27>;
+				clocks = <&clks 0>;
 			};
 
 			uart1: serial at 1000a000 {
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000a000 0x1000>;
 				interrupts = <20>;
+				clocks = <&clks 81>, <&clks 61>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -75,6 +78,8 @@
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000b000 0x1000>;
 				interrupts = <19>;
+				clocks = <&clks 80>, <&clks 61>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -82,6 +87,8 @@
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000c000 0x1000>;
 				interrupts = <18>;
+				clocks = <&clks 79>, <&clks 61>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -89,6 +96,8 @@
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000d000 0x1000>;
 				interrupts = <17>;
+				clocks = <&clks 78>, <&clks 61>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -98,6 +107,8 @@
 				compatible = "fsl,imx27-cspi";
 				reg = <0x1000e000 0x1000>;
 				interrupts = <16>;
+				clocks = <&clks 53>, <&clks 0>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -107,6 +118,8 @@
 				compatible = "fsl,imx27-cspi";
 				reg = <0x1000f000 0x1000>;
 				interrupts = <15>;
+				clocks = <&clks 52>, <&clks 0>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -116,6 +129,7 @@
 				compatible = "fsl,imx27-i2c", "fsl,imx21-i2c";
 				reg = <0x10012000 0x1000>;
 				interrupts = <12>;
+				clocks = <&clks 40>;
 				status = "disabled";
 			};
 
@@ -185,6 +199,8 @@
 				compatible = "fsl,imx27-cspi";
 				reg = <0x10017000 0x1000>;
 				interrupts = <6>;
+				clocks = <&clks 51>, <&clks 0>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -192,6 +208,8 @@
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1001b000 0x1000>;
 				interrupts = <49>;
+				clocks = <&clks 77>, <&clks 61>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -199,6 +217,8 @@
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1001c000 0x1000>;
 				interrupts = <48>;
+				clocks = <&clks 78>, <&clks 61>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -208,6 +228,7 @@
 				compatible = "fsl,imx27-i2c", "fsl,imx21-i2c";
 				reg = <0x1001d000 0x1000>;
 				interrupts = <1>;
+				clocks = <&clks 39>;
 				status = "disabled";
 			};
 
@@ -215,10 +236,19 @@
 				compatible = "fsl,imx27-fec";
 				reg = <0x1002b000 0x4000>;
 				interrupts = <50>;
+				clocks = <&clks 48>, <&clks 67>, <&clks 0>;
+				clock-names = "ipg", "ahb", "ptp";
 				status = "disabled";
 			};
+
+			clks: ccm at 10027000{
+				compatible = "fsl,imx27-ccm";
+				reg = <0x10027000 0x1000>;
+				#clock-cells = <1>;
+			};
 		};
 
+
 		nfc: nand at d8000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -226,6 +256,7 @@
 			compatible = "fsl,imx27-nand";
 			reg = <0xd8000000 0x1000>;
 			interrupts = <29>;
+			clocks = <&clks 54>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 4c1d1e4..1d66b1b 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -86,10 +86,12 @@ enum mx27_clks {
 };
 
 static struct clk *clk[clk_max];
+static struct clk_onecell_data clk_data;
 
 int __init mx27_clocks_init(unsigned long fref)
 {
 	int i;
+	struct device_node *np;
 
 	clk[dummy] = imx_clk_fixed("dummy", 0);
 	clk[ckih] = imx_clk_fixed("ckih", fref);
@@ -197,6 +199,13 @@ int __init mx27_clocks_init(unsigned long fref)
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
index ebfae96..fd23175 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -18,25 +18,9 @@
 #include "common.h"
 #include "mx27.h"
 
-static const struct of_dev_auxdata imx27_auxdata_lookup[] __initconst = {
-	OF_DEV_AUXDATA("fsl,imx27-uart", MX27_UART1_BASE_ADDR, "imx21-uart.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx27-uart", MX27_UART2_BASE_ADDR, "imx21-uart.1", NULL),
-	OF_DEV_AUXDATA("fsl,imx27-uart", MX27_UART3_BASE_ADDR, "imx21-uart.2", NULL),
-	OF_DEV_AUXDATA("fsl,imx27-fec", MX27_FEC_BASE_ADDR, "imx27-fec.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx27-i2c", MX27_I2C1_BASE_ADDR, "imx21-i2c.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx27-i2c", MX27_I2C2_BASE_ADDR, "imx21-i2c.1", NULL),
-	OF_DEV_AUXDATA("fsl,imx27-cspi", MX27_CSPI1_BASE_ADDR, "imx27-cspi.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx27-cspi", MX27_CSPI2_BASE_ADDR, "imx27-cspi.1", NULL),
-	OF_DEV_AUXDATA("fsl,imx27-cspi", MX27_CSPI3_BASE_ADDR, "imx27-cspi.2", NULL),
-	OF_DEV_AUXDATA("fsl,imx27-wdt", MX27_WDOG_BASE_ADDR, "imx2-wdt.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx27-nand", MX27_NFC_BASE_ADDR, "imx27-nand.0", NULL),
-	{ /* sentinel */ }
-};
-
 static void __init imx27_dt_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     imx27_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static void __init imx27_timer_init(void)
-- 
1.7.9.5
