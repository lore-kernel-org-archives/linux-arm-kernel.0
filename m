From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 14 Apr 2018 17:55:30 -0300
Subject: [PATCH] ARM: dts: imx6ul: Add CAAM support
Message-ID: <1523739330-27363-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Add CAAM support on i.MX6UL.

Also, since CAAM is not available on i.MX6ULL the CAAM node
needs to be deleted in the imx6ull.dtsi.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi  | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ull.dtsi |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 1241972..2b854d1 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -769,6 +769,36 @@
 			reg = <0x02100000 0x100000>;
 			ranges;
 
+			crypto: caam at 2140000 {
+				compatible = "fsl,imx6ul-caam", "fsl,sec-v4.0";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x2140000 0x3c000>;
+				ranges = <0 0x2140000 0x3c000>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_CAAM_IPG>, <&clks IMX6UL_CLK_CAAM_ACLK>,
+					 <&clks IMX6UL_CLK_CAAM_MEM>;
+				clock-names = "ipg", "aclk", "mem";
+
+				sec_jr0: jr0 at 1000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x1000 0x1000>;
+					interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr1: jr1 at 2000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x2000 0x1000>;
+					interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr2: jr2 at 3000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x3000 0x1000>;
+					interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+
 			usbotg1: usb at 2184000 {
 				compatible = "fsl,imx6ul-usb", "fsl,imx27-usb";
 				reg = <0x02184000 0x200>;
diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index 571ddd7..ebc25c9 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -45,6 +45,8 @@
 
 /* Delete UART8 in AIPS-1 (i.MX6UL specific) */
 /delete-node/ &uart8;
+/* Delete CAAM node in AIPS-2 (i.MX6UL specific) */
+/delete-node/ &crypto;
 
 / {
 	soc {
-- 
2.7.4
