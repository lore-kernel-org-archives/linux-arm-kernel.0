From: b32955@freescale.com (Huang Shijie)
Date: Wed, 25 Apr 2012 11:06:24 +0800
Subject: [PATCH v2 3/3] ARM: mx6q: add gpmi-nand dt support
In-Reply-To: <1335323184-11233-1-git-send-email-b32955@freescale.com>
References: <1335323184-11233-1-git-send-email-b32955@freescale.com>
Message-ID: <1335323184-11233-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add gpmi-nand dt support, and add the proper clock for gpmi-nand.
Also enable the gpmi for mx6q-arm2 board.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6q-arm2.dts |    4 ++++
 arch/arm/boot/dts/imx6q.dtsi     |   12 ++++++++++++
 arch/arm/mach-imx/clock-imx6q.c  |    5 +++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index ce1c823..34d09da 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -26,6 +26,10 @@
 	};
 
 	soc {
+		gpmi-nand at 00112000 {
+			status = "okay";
+		};
+
 		aips-bus at 02100000 { /* AIPS2 */
 			enet at 02188000 {
 				phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 4905f51..0a0ebf0 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -87,6 +87,18 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		gpmi-nand at 00112000 {
+			compatible = "fsl,imx6q-gpmi-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x00112000 0x2000>, <0x00114000 0x2000>;
+			reg-names = "gpmi-nand", "bch";
+			interrupts = <0 13 0x04>, <0 15 0x04>;
+			interrupt-names = "gpmi-dma", "bch";
+			fsl,gpmi-dma-channel = <0>;
+			status = "disabled";
+		};
+
 		timer at 00a00600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x00a00600 0x20>;
diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index 111c328..e3dc1b3 100644
--- a/arch/arm/mach-imx/clock-imx6q.c
+++ b/arch/arm/mach-imx/clock-imx6q.c
@@ -1859,7 +1859,8 @@ DEF_CLK(pwm1_clk,	  CCGR4, CG8,  &ipg_perclk,	  NULL);
 DEF_CLK(pwm2_clk,	  CCGR4, CG9,  &ipg_perclk,	  NULL);
 DEF_CLK(pwm3_clk,	  CCGR4, CG10, &ipg_perclk,	  NULL);
 DEF_CLK(pwm4_clk,	  CCGR4, CG11, &ipg_perclk,	  NULL);
-DEF_CLK(gpmi_bch_apb_clk, CCGR4, CG12, &usdhc3_clk,	  NULL);
+DEF_CLK(per1_bch_clk,     CCGR4, CG6,  &usdhc3_clk,	  NULL);
+DEF_CLK(gpmi_bch_apb_clk, CCGR4, CG12, &usdhc3_clk,	  &per1_bch_clk);
 DEF_CLK(gpmi_bch_clk,	  CCGR4, CG13, &usdhc4_clk,	  &gpmi_bch_apb_clk);
 DEF_CLK(gpmi_apb_clk,	  CCGR4, CG15, &usdhc3_clk,	  &gpmi_bch_clk);
 DEF_CLK(gpmi_io_clk,	  CCGR4, CG14, &enfc_clk,	  &gpmi_apb_clk);
@@ -1988,7 +1989,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "pwm2_clk", pwm2_clk),
 	_REGISTER_CLOCK(NULL, "pwm3_clk", pwm3_clk),
 	_REGISTER_CLOCK(NULL, "pwm4_clk", pwm4_clk),
-	_REGISTER_CLOCK(NULL, "gpmi_io_clk", gpmi_io_clk),
+	_REGISTER_CLOCK("112000.gpmi-nand", NULL, gpmi_io_clk),
 	_REGISTER_CLOCK(NULL, "usboh3_clk", usboh3_clk),
 	_REGISTER_CLOCK(NULL, "sata_clk", sata_clk),
 	_REGISTER_CLOCK(NULL, "cko1_clk", cko1_clk),
-- 
1.7.0.4
