From: b32955@freescale.com (Huang Shijie)
Date: Wed, 25 Apr 2012 11:06:23 +0800
Subject: [PATCH v2 2/3] ARM: mx28: add gpmi-nand dt support
In-Reply-To: <1335323184-11233-1-git-send-email-b32955@freescale.com>
References: <1335323184-11233-1-git-send-email-b32955@freescale.com>
Message-ID: <1335323184-11233-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add gpmi-nand device tree support, and add proper clock for it.
Also enable the gpmi support for mx28-evk board.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts |    4 ++++
 arch/arm/boot/dts/imx28.dtsi    |   18 +++++++++---------
 arch/arm/mach-mxs/clock-mx28.c  |    2 +-
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 157ecac..66a4b3b 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -22,6 +22,10 @@
 
         apb at 80000000 {
                 apbh at 80000000 {
+			gpmi-nand at 8000c000 {
+				status = "okay";
+			};
+
 			mmc1: ssp at 80010000 {
 				slot-8bit;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index dd209a3..c1e783e 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -62,15 +62,15 @@
 				status = "disabled";
 			};
 
-			bch at 8000a000 {
-				reg = <0x8000a000 2000>;
-				interrupts = <41>;
-				status = "disabled";
-			};
-
-			gpmi at 8000c000 {
-				reg = <0x8000c000 2000>;
-				interrupts = <42 88>;
+			gpmi-nand at 8000c000 {
+				compatible = "fsl,imx28-gpmi-nand";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x8000c000 2000>, <0x8000a000 2000>;
+				reg-names = "gpmi-nand", "bch";
+				interrupts = <88>, <41>;
+				interrupt-names = "gpmi-dma", "bch";
+				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 8401854..6fe6737 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -617,7 +617,6 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("duart", NULL, uart_clk)
 	_REGISTER_CLOCK("imx28-fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("imx28-fec.1", NULL, fec_clk)
-	_REGISTER_CLOCK("imx28-gpmi-nand", NULL, gpmi_clk)
 	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
 	_REGISTER_CLOCK("mxs-auart.1", NULL, uart_clk)
 	_REGISTER_CLOCK("mxs-auart.2", NULL, uart_clk)
@@ -649,6 +648,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxs-saif.0", NULL, saif0_clk)
 	_REGISTER_CLOCK("mxs-saif.1", NULL, saif1_clk)
 	/* for DT */
+	_REGISTER_CLOCK("8000c000.gpmi-nand", NULL, gpmi_clk)
 	_REGISTER_CLOCK("80074000.serial", NULL, uart_clk)
 	_REGISTER_CLOCK("800f0000.ethernet", NULL, fec_clk)
 	_REGISTER_CLOCK("800f4000.ethernet", NULL, fec_clk)
-- 
1.7.0.4
