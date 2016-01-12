From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 12 Jan 2016 18:21:30 +0100
Subject: [PATCH 13/14] ARM: dts: imx6ul: add gpmi support
In-Reply-To: <1452619291-13625-13-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-2-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-3-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-4-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-5-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-6-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-7-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-8-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-9-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-10-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-11-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-12-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-13-git-send-email-LW@KARO-electronics.de>
Message-ID: <1452619291-13625-14-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ul.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 0123480..710e6ca 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -141,6 +141,39 @@
 			reg = <0x00900000 0x20000>;
 		};
 
+		dma_apbh: dma-apbh at 01804000 {
+			compatible = "fsl,imx6q-dma-apbh", "fsl,imx28-dma-apbh";
+			reg = <0x01804000 0x2000>;
+			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 13 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
+			#dma-cells = <1>;
+			dma-channels = <4>;
+			clocks = <&clks IMX6UL_CLK_APBHDMA>;
+		};
+
+		gpmi: gpmi-nand at 01806000         {
+			compatible = "fsl,imx6q-gpmi-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x01806000 0x2000>, <0x01808000 0x2000>;
+			reg-names = "gpmi-nand", "bch";
+			interrupts = <0 15 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "bch";
+			clocks = <&clks IMX6UL_CLK_GPMI_IO>,
+				 <&clks IMX6UL_CLK_GPMI_APB>,
+				 <&clks IMX6UL_CLK_GPMI_BCH>,
+				 <&clks IMX6UL_CLK_GPMI_BCH_APB>,
+				 <&clks IMX6UL_CLK_PER_BCH>;
+			clock-names = "gpmi_io", "gpmi_apb", "gpmi_bch",
+				      "gpmi_bch_apb", "per1_bch";
+			dmas = <&dma_apbh 0>;
+			dma-names = "rx-tx";
+			status = "disabled";
+		};
+
 		aips1: aips-bus at 02000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
-- 
2.1.4
