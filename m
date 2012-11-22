From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 22 Nov 2012 17:10:46 -0200
Subject: [PATCH 4/4] ARM: mx31: Replace clk_register_clkdev with clock DT
 lookup
In-Reply-To: <1353611447-7732-1-git-send-email-fabio.estevam@freescale.com>
References: <1353611447-7732-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1353611447-7732-4-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
task for the clock devices easier.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 .../devicetree/bindings/clock/imx31-clock.txt      |   91 ++++++++++++++++++++
 arch/arm/boot/dts/imx31.dtsi                       |   17 ++++
 arch/arm/mach-imx/clk-imx31.c                      |   10 +++
 arch/arm/mach-imx/imx31-dt.c                       |   17 +---
 4 files changed, 119 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx31-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/imx31-clock.txt b/Documentation/devicetree/bindings/clock/imx31-clock.txt
new file mode 100644
index 0000000..19df842
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx31-clock.txt
@@ -0,0 +1,91 @@
+* Clock bindings for Freescale i.MX31
+
+Required properties:
+- compatible: Should be "fsl,imx31-ccm"
+- reg: Address and length of the register set
+- interrupts: Should contain CCM interrupt
+- #clock-cells: Should be <1>
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.  The following is a full list of i.MX31
+clocks and IDs.
+
+	Clock		    ID
+	-----------------------
+	dummy	             0
+	ckih                 1
+	ckil                 2
+	mpll                 3
+	spll                 4
+	upll                 5
+	mcu_main             6
+	hsp                  7
+	ahb                  8
+	nfc                  9
+	ipg                  10
+	per_div              11
+	per                  12
+	csi_sel              13
+	fir_sel              14
+	csi_div              15
+	usb_div_pre          16
+	usb_div_post         17
+	fir_div_pre          18
+	fir_div_post         19
+	sdhc1_gate           20
+	sdhc2_gate           21
+	gpt_gate             22
+	epit1_gate           23
+	epit2_gate           24
+	iim_gate             25
+	ata_gate             26
+	sdma_gate            27
+	cspi3_gate           28
+	rng_gate             29
+	uart1_gate           30
+	uart2_gate           31
+	ssi1_gate            32
+	i2c1_gate            33
+	i2c2_gate            34
+	i2c3_gate            35
+	hantro_gate          36
+	mstick1_gate         37
+	mstick2_gate         38
+	csi_gate             39
+	rtc_gate             40
+	wdog_gate            41
+	pwm_gate             42
+	sim_gate             43
+	ect_gate             44
+	usb_gate             45
+	kpp_gate             46
+	ipu_gate             47
+	uart3_gate           48
+	uart4_gate           49
+	uart5_gate           50
+	owire_gate           51
+	ssi2_gate            52
+	cspi1_gate           53
+	cspi2_gate           54
+	gacc_gate            55
+	emi_gate             56
+	rtic_gate            57
+	firi_gate            58
+
+Examples:
+
+clks: ccm at 53f80000{
+	compatible = "fsl,imx31-ccm";
+	reg = <0x53f80000 0x4000>;
+	interrupts = <0 31 0x04 0 53 0x04>;
+	#clock-cells = <1>;
+};
+
+uart1: serial at 43f90000 {
+	compatible = "fsl,imx31-uart", "fsl,imx21-uart";
+	reg = <0x43f90000 0x4000>;
+	interrupts = <45>;
+	clocks = <&clks 10>, <&clks 30>;
+	clock-names = "ipg", "per";
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index eef7099..454c2d1 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -45,6 +45,8 @@
 				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
 				reg = <0x43f90000 0x4000>;
 				interrupts = <45>;
+				clocks = <&clks 10>, <&clks 30>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -52,12 +54,16 @@
 				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
 				reg = <0x43f94000 0x4000>;
 				interrupts = <32>;
+				clocks = <&clks 10>, <&clks 31>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
 			uart4: serial at 43fb0000 {
 				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
 				reg = <0x43fb0000 0x4000>;
+				clocks = <&clks 10>, <&clks 49>;
+				clock-names = "ipg", "per";
 				interrupts = <46>;
 				status = "disabled";
 			};
@@ -66,6 +72,8 @@
 				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
 				reg = <0x43fb4000 0x4000>;
 				interrupts = <47>;
+				clocks = <&clks 10>, <&clks 50>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 		};
@@ -81,8 +89,17 @@
 				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
 				reg = <0x5000c000 0x4000>;
 				interrupts = <18>;
+				clocks = <&clks 10>, <&clks 48>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
+
+			clks: ccm at 53f80000{
+				compatible = "fsl,imx31-ccm";
+				reg = <0x53f80000 0x4000>;
+				interrupts = <0 31 0x04 0 53 0x04>;
+				#clock-cells = <1>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index 07af70d..c103c60 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -46,11 +46,13 @@ enum mx31_clks {
 };
 
 static struct clk *clk[clk_max];
+static struct clk_onecell_data clk_data;
 
 int __init mx31_clocks_init(unsigned long fref)
 {
 	void __iomem *base = MX31_IO_ADDRESS(MX31_CCM_BASE_ADDR);
 	int i;
+	struct device_node *np;
 
 	clk[dummy] = imx_clk_fixed("dummy", 0);
 	clk[ckih] = imx_clk_fixed("ckih", fref);
@@ -117,6 +119,14 @@ int __init mx31_clocks_init(unsigned long fref)
 			pr_err("imx31 clk %d: register failed with %ld\n",
 				i, PTR_ERR(clk[i]));
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx31-ccm");
+
+	if (np) {
+		clk_data.clks = clk;
+		clk_data.clk_num = ARRAY_SIZE(clk);
+		of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	}
+
 	clk_register_clkdev(clk[gpt_gate], "per", "imx-gpt.0");
 	clk_register_clkdev(clk[ipg], "ipg", "imx-gpt.0");
 	clk_register_clkdev(clk[cspi1_gate], NULL, "imx31-cspi.0");
diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
index af476de..dc083d3 100644
--- a/arch/arm/mach-imx/imx31-dt.c
+++ b/arch/arm/mach-imx/imx31-dt.c
@@ -18,24 +18,9 @@
 #include "common.h"
 #include "mx31.h"
 
-static const struct of_dev_auxdata imx31_auxdata_lookup[] __initconst = {
-	OF_DEV_AUXDATA("fsl,imx31-uart", MX31_UART1_BASE_ADDR,
-			"imx21-uart.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx31-uart", MX31_UART2_BASE_ADDR,
-			"imx21-uart.1", NULL),
-	OF_DEV_AUXDATA("fsl,imx31-uart", MX31_UART3_BASE_ADDR,
-			"imx21-uart.2", NULL),
-	OF_DEV_AUXDATA("fsl,imx31-uart", MX31_UART4_BASE_ADDR,
-			"imx21-uart.3", NULL),
-	OF_DEV_AUXDATA("fsl,imx31-uart", MX31_UART5_BASE_ADDR,
-			"imx21-uart.4", NULL),
-	{ /* sentinel */ }
-};
-
 static void __init imx31_dt_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     imx31_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static void __init imx31_timer_init(void)
-- 
1.7.9.5
