From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 22 Aug 2012 21:36:29 +0800
Subject: [PATCH v2 3/4] clk: mxs: replace imx28 clk_register_clkdev with clock
 DT lookup
In-Reply-To: <1345642590-29905-1-git-send-email-shawn.guo@linaro.org>
References: <1345642590-29905-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1345642590-29905-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It really becomes a maintenance issue that every time a device needs
to look up (clk_get) a clock we have to patch kernel clock file to call
clk_register_clkdev for that clock.

Since clock DT support which is meant to resolve clock lookup in device
tree is in place, the patch moves imx28 client devices' clock lookup
over to device tree, so that any new lookup to be added at later time
can just get done in DT instead of kernel.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/clock/imx28-clock.txt      |   99 +++++++++++++++++
 arch/arm/boot/dts/imx28.dtsi                       |   35 ++++++-
 drivers/clk/mxs/clk-imx28.c                        |  113 ++------------------
 3 files changed, 142 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx28-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/imx28-clock.txt b/Documentation/devicetree/bindings/clock/imx28-clock.txt
new file mode 100644
index 0000000..aa2af28
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx28-clock.txt
@@ -0,0 +1,99 @@
+* Clock bindings for Freescale i.MX28
+
+Required properties:
+- compatible: Should be "fsl,imx28-clkctrl"
+- reg: Address and length of the register set
+- #clock-cells: Should be <1>
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.  The following is a full list of i.MX28
+clocks and IDs.
+
+	Clock		ID
+	------------------
+	ref_xtal	0
+	pll0		1
+	pll1		2
+	pll2		3
+	ref_cpu		4
+	ref_emi		5
+	ref_io0		6
+	ref_io1		7
+	ref_pix		8
+	ref_hsadc	9
+	ref_gpmi	10
+	saif0_sel	11
+	saif1_sel	12
+	gpmi_sel	13
+	ssp0_sel	14
+	ssp1_sel	15
+	ssp2_sel	16
+	ssp3_sel	17
+	emi_sel		18
+	etm_sel		19
+	lcdif_sel	20
+	cpu		21
+	ptp_sel		22
+	cpu_pll		23
+	cpu_xtal	24
+	hbus		25
+	xbus		26
+	ssp0_div	27
+	ssp1_div	28
+	ssp2_div	29
+	ssp3_div	30
+	gpmi_div	31
+	emi_pll		32
+	emi_xtal	33
+	lcdif_div	34
+	etm_div		35
+	ptp		36
+	saif0_div	37
+	saif1_div	38
+	clk32k_div	39
+	rtc		40
+	lradc		41
+	spdif_div	42
+	clk32k		43
+	pwm		44
+	uart		45
+	ssp0		46
+	ssp1		47
+	ssp2		48
+	ssp3		49
+	gpmi		50
+	spdif		51
+	emi		52
+	saif0		53
+	saif1		54
+	lcdif		55
+	etm		56
+	fec		57
+	can0		58
+	can1		59
+	usb0		60
+	usb1		61
+	usb0_pwr	62
+	usb1_pwr	63
+	enet_out	64
+
+Examples:
+
+clks: clkctrl at 80040000 {
+	compatible = "fsl,imx28-clkctrl";
+	reg = <0x80040000 0x2000>;
+	#clock-cells = <1>;
+	clock-output-names =
+		...
+		"uart",		/* 45 */
+		...
+		"end_of_list";
+};
+
+auart0: serial at 8006a000 {
+	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
+	reg = <0x8006a000 0x2000>;
+	interrupts = <112 70 71>;
+	clocks = <&clks 45>;
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 3fa6d19..4098309 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -65,6 +65,7 @@
 			dma-apbh at 80004000 {
 				compatible = "fsl,imx28-dma-apbh";
 				reg = <0x80004000 0x2000>;
+				clocks = <&clks 25>;
 			};
 
 			perfmon at 80006000 {
@@ -81,6 +82,7 @@
 				reg-names = "gpmi-nand", "bch";
 				interrupts = <88>, <41>;
 				interrupt-names = "gpmi-dma", "bch";
+				clocks = <&clks 50>;
 				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
@@ -88,6 +90,7 @@
 			ssp0: ssp at 80010000 {
 				reg = <0x80010000 0x2000>;
 				interrupts = <96 82>;
+				clocks = <&clks 46>;
 				fsl,ssp-dma-channel = <0>;
 				status = "disabled";
 			};
@@ -95,6 +98,7 @@
 			ssp1: ssp at 80012000 {
 				reg = <0x80012000 0x2000>;
 				interrupts = <97 83>;
+				clocks = <&clks 47>;
 				fsl,ssp-dma-channel = <1>;
 				status = "disabled";
 			};
@@ -102,6 +106,7 @@
 			ssp2: ssp at 80014000 {
 				reg = <0x80014000 0x2000>;
 				interrupts = <98 84>;
+				clocks = <&clks 48>;
 				fsl,ssp-dma-channel = <2>;
 				status = "disabled";
 			};
@@ -109,6 +114,7 @@
 			ssp3: ssp at 80016000 {
 				reg = <0x80016000 0x2000>;
 				interrupts = <99 85>;
+				clocks = <&clks 49>;
 				fsl,ssp-dma-channel = <3>;
 				status = "disabled";
 			};
@@ -523,6 +529,7 @@
 			dma-apbx at 80024000 {
 				compatible = "fsl,imx28-dma-apbx";
 				reg = <0x80024000 0x2000>;
+				clocks = <&clks 26>;
 			};
 
 			dcp at 80028000 {
@@ -551,6 +558,7 @@
 				compatible = "fsl,imx28-lcdif";
 				reg = <0x80030000 0x2000>;
 				interrupts = <38 86>;
+				clocks = <&clks 55>;
 				status = "disabled";
 			};
 
@@ -558,6 +566,8 @@
 				compatible = "fsl,imx28-flexcan", "fsl,p1010-flexcan";
 				reg = <0x80032000 0x2000>;
 				interrupts = <8>;
+				clocks = <&clks 58>, <&clks 58>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -565,6 +575,8 @@
 				compatible = "fsl,imx28-flexcan", "fsl,p1010-flexcan";
 				reg = <0x80034000 0x2000>;
 				interrupts = <9>;
+				clocks = <&clks 59>, <&clks 59>;
+				clock-names = "ipg", "per";
 				status = "disabled";
 			};
 
@@ -611,15 +623,17 @@
 			reg = <0x80040000 0x40000>;
 			ranges;
 
-			clkctl at 80040000 {
+			clks: clkctrl at 80040000 {
+				compatible = "fsl,imx28-clkctrl";
 				reg = <0x80040000 0x2000>;
-				status = "disabled";
+				#clock-cells = <1>;
 			};
 
 			saif0: saif at 80042000 {
 				compatible = "fsl,imx28-saif";
 				reg = <0x80042000 0x2000>;
 				interrupts = <59 80>;
+				clocks = <&clks 53>;
 				fsl,saif-dma-channel = <4>;
 				status = "disabled";
 			};
@@ -633,6 +647,7 @@
 				compatible = "fsl,imx28-saif";
 				reg = <0x80046000 0x2000>;
 				interrupts = <58 81>;
+				clocks = <&clks 54>;
 				fsl,saif-dma-channel = <5>;
 				status = "disabled";
 			};
@@ -677,6 +692,7 @@
 			pwm: pwm at 80064000 {
 				compatible = "fsl,imx28-pwm", "fsl,imx23-pwm";
 				reg = <0x80064000 0x2000>;
+				clocks = <&clks 44>;
 				#pwm-cells = <2>;
 				fsl,pwm-number = <8>;
 				status = "disabled";
@@ -691,6 +707,7 @@
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006a000 0x2000>;
 				interrupts = <112 70 71>;
+				clocks = <&clks 45>;
 				status = "disabled";
 			};
 
@@ -698,6 +715,7 @@
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006c000 0x2000>;
 				interrupts = <113 72 73>;
+				clocks = <&clks 45>;
 				status = "disabled";
 			};
 
@@ -705,6 +723,7 @@
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x8006e000 0x2000>;
 				interrupts = <114 74 75>;
+				clocks = <&clks 45>;
 				status = "disabled";
 			};
 
@@ -712,6 +731,7 @@
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x80070000 0x2000>;
 				interrupts = <115 76 77>;
+				clocks = <&clks 45>;
 				status = "disabled";
 			};
 
@@ -719,6 +739,7 @@
 				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
 				reg = <0x80072000 0x2000>;
 				interrupts = <116 78 79>;
+				clocks = <&clks 45>;
 				status = "disabled";
 			};
 
@@ -726,18 +747,22 @@
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x80074000 0x1000>;
 				interrupts = <47>;
+				clocks = <&clks 45>, <&clks 26>;
+				clock-names = "uart", "apb_pclk";
 				status = "disabled";
 			};
 
 			usbphy0: usbphy at 8007c000 {
 				compatible = "fsl,imx28-usbphy", "fsl,imx23-usbphy";
 				reg = <0x8007c000 0x2000>;
+				clocks = <&clks 62>;
 				status = "disabled";
 			};
 
 			usbphy1: usbphy at 8007e000 {
 				compatible = "fsl,imx28-usbphy", "fsl,imx23-usbphy";
 				reg = <0x8007e000 0x2000>;
+				clocks = <&clks 63>;
 				status = "disabled";
 			};
 		};
@@ -754,6 +779,7 @@
 			compatible = "fsl,imx28-usb", "fsl,imx27-usb";
 			reg = <0x80080000 0x10000>;
 			interrupts = <93>;
+			clocks = <&clks 60>;
 			fsl,usbphy = <&usbphy0>;
 			status = "disabled";
 		};
@@ -762,6 +788,7 @@
 			compatible = "fsl,imx28-usb", "fsl,imx27-usb";
 			reg = <0x80090000 0x10000>;
 			interrupts = <92>;
+			clocks = <&clks 61>;
 			fsl,usbphy = <&usbphy1>;
 			status = "disabled";
 		};
@@ -775,6 +802,8 @@
 			compatible = "fsl,imx28-fec";
 			reg = <0x800f0000 0x4000>;
 			interrupts = <101>;
+			clocks = <&clks 57>, <&clks 57>;
+			clock-names = "ipg", "ahb";
 			status = "disabled";
 		};
 
@@ -782,6 +811,8 @@
 			compatible = "fsl,imx28-fec";
 			reg = <0x800f4000 0x4000>;
 			interrupts = <102>;
+			clocks = <&clks 57>, <&clks 57>;
+			clock-names = "ipg", "ahb";
 			status = "disabled";
 		};
 
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index e3aab67..613e76f 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <mach/common.h>
 #include <mach/mx28.h>
 #include "clk.h"
@@ -120,90 +121,6 @@ static void __init clk_misc_init(void)
 	writel_relaxed(val, FRAC0);
 }
 
-static struct clk_lookup uart_lookups[] = {
-	{ .dev_id = "duart", },
-	{ .dev_id = "mxs-auart.0", },
-	{ .dev_id = "mxs-auart.1", },
-	{ .dev_id = "mxs-auart.2", },
-	{ .dev_id = "mxs-auart.3", },
-	{ .dev_id = "mxs-auart.4", },
-	{ .dev_id = "8006a000.serial", },
-	{ .dev_id = "8006c000.serial", },
-	{ .dev_id = "8006e000.serial", },
-	{ .dev_id = "80070000.serial", },
-	{ .dev_id = "80072000.serial", },
-	{ .dev_id = "80074000.serial", },
-};
-
-static struct clk_lookup hbus_lookups[] = {
-	{ .dev_id = "imx28-dma-apbh", },
-	{ .dev_id = "80004000.dma-apbh", },
-};
-
-static struct clk_lookup xbus_lookups[] = {
-	{ .dev_id = "duart", .con_id = "apb_pclk"},
-	{ .dev_id = "80074000.serial", .con_id = "apb_pclk"},
-	{ .dev_id = "imx28-dma-apbx", },
-	{ .dev_id = "80024000.dma-apbx", },
-};
-
-static struct clk_lookup ssp0_lookups[] = {
-	{ .dev_id = "imx28-mmc.0", },
-	{ .dev_id = "80010000.ssp", },
-};
-
-static struct clk_lookup ssp1_lookups[] = {
-	{ .dev_id = "imx28-mmc.1", },
-	{ .dev_id = "80012000.ssp", },
-};
-
-static struct clk_lookup ssp2_lookups[] = {
-	{ .dev_id = "imx28-mmc.2", },
-	{ .dev_id = "80014000.ssp", },
-};
-
-static struct clk_lookup ssp3_lookups[] = {
-	{ .dev_id = "imx28-mmc.3", },
-	{ .dev_id = "80016000.ssp", },
-};
-
-static struct clk_lookup lcdif_lookups[] = {
-	{ .dev_id = "imx28-fb", },
-	{ .dev_id = "80030000.lcdif", },
-};
-
-static struct clk_lookup gpmi_lookups[] = {
-	{ .dev_id = "imx28-gpmi-nand", },
-	{ .dev_id = "8000c000.gpmi-nand", },
-};
-
-static struct clk_lookup fec_lookups[] = {
-	{ .dev_id = "imx28-fec.0", },
-	{ .dev_id = "imx28-fec.1", },
-	{ .dev_id = "800f0000.ethernet", },
-	{ .dev_id = "800f4000.ethernet", },
-};
-
-static struct clk_lookup can0_lookups[] = {
-	{ .dev_id = "flexcan.0", },
-	{ .dev_id = "80032000.can", },
-};
-
-static struct clk_lookup can1_lookups[] = {
-	{ .dev_id = "flexcan.1", },
-	{ .dev_id = "80034000.can", },
-};
-
-static struct clk_lookup saif0_lookups[] = {
-	{ .dev_id = "mxs-saif.0", },
-	{ .dev_id = "80042000.saif", },
-};
-
-static struct clk_lookup saif1_lookups[] = {
-	{ .dev_id = "mxs-saif.1", },
-	{ .dev_id = "80046000.saif", },
-};
-
 static const char *sel_cpu[]  __initconst = { "ref_cpu", "ref_xtal", };
 static const char *sel_io0[]  __initconst = { "ref_io0", "ref_xtal", };
 static const char *sel_io1[]  __initconst = { "ref_io1", "ref_xtal", };
@@ -228,6 +145,7 @@ enum imx28_clk {
 };
 
 static struct clk *clks[clk_max];
+static struct clk_onecell_data clk_data;
 
 static enum imx28_clk clks_init_on[] __initdata = {
 	cpu, hbus, xbus, emi, uart,
@@ -235,6 +153,7 @@ static enum imx28_clk clks_init_on[] __initdata = {
 
 int __init mx28_clocks_init(void)
 {
+	struct device_node *np;
 	int i;
 
 	clk_misc_init();
@@ -312,27 +231,15 @@ int __init mx28_clocks_init(void)
 			return PTR_ERR(clks[i]);
 		}
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx28-clkctrl");
+	if (np) {
+		clk_data.clks = clks;
+		clk_data.clk_num = ARRAY_SIZE(clks);
+		of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	}
+
 	clk_register_clkdev(clks[clk32k], NULL, "timrot");
 	clk_register_clkdev(clks[enet_out], NULL, "enet_out");
-	clk_register_clkdev(clks[pwm], NULL, "80064000.pwm");
-	clk_register_clkdevs(clks[hbus], hbus_lookups, ARRAY_SIZE(hbus_lookups));
-	clk_register_clkdevs(clks[xbus], xbus_lookups, ARRAY_SIZE(xbus_lookups));
-	clk_register_clkdevs(clks[uart], uart_lookups, ARRAY_SIZE(uart_lookups));
-	clk_register_clkdevs(clks[ssp0], ssp0_lookups, ARRAY_SIZE(ssp0_lookups));
-	clk_register_clkdevs(clks[ssp1], ssp1_lookups, ARRAY_SIZE(ssp1_lookups));
-	clk_register_clkdevs(clks[ssp2], ssp2_lookups, ARRAY_SIZE(ssp2_lookups));
-	clk_register_clkdevs(clks[ssp3], ssp3_lookups, ARRAY_SIZE(ssp3_lookups));
-	clk_register_clkdevs(clks[gpmi], gpmi_lookups, ARRAY_SIZE(gpmi_lookups));
-	clk_register_clkdevs(clks[saif0], saif0_lookups, ARRAY_SIZE(saif0_lookups));
-	clk_register_clkdevs(clks[saif1], saif1_lookups, ARRAY_SIZE(saif1_lookups));
-	clk_register_clkdevs(clks[lcdif], lcdif_lookups, ARRAY_SIZE(lcdif_lookups));
-	clk_register_clkdevs(clks[fec], fec_lookups, ARRAY_SIZE(fec_lookups));
-	clk_register_clkdevs(clks[can0], can0_lookups, ARRAY_SIZE(can0_lookups));
-	clk_register_clkdevs(clks[can1], can1_lookups, ARRAY_SIZE(can1_lookups));
-	clk_register_clkdev(clks[usb0_pwr], NULL, "8007c000.usbphy");
-	clk_register_clkdev(clks[usb1_pwr], NULL, "8007e000.usbphy");
-	clk_register_clkdev(clks[usb0], NULL, "80080000.usb");
-	clk_register_clkdev(clks[usb1], NULL, "80090000.usb");
 
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clks[clks_init_on[i]]);
-- 
1.7.5.4
