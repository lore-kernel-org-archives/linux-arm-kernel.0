From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 26 Jan 2018 09:23:51 +0100
Subject: [PATCH 2/3] ARM: dts: imx6ull: add support for the esai interface
In-Reply-To: <1516955032-21167-1-git-send-email-LW@KARO-electronics.de>
References: <1516955032-21167-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1516955032-21167-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The address space taken by the UART8 on the i.MX6UL is used for the
ESAI interface on i.MX6ULL.

Since the ESAI unit on i.MX6ULL has two more bits in the TFCR register
(TFIN, TAENB) it deserves to get its own compatible string, though the
bits are currently not used by the driver.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 Documentation/devicetree/bindings/sound/fsl,esai.txt |  4 ++--
 arch/arm/boot/dts/imx6ull.dtsi                       | 17 +++++++++++++++++
 sound/soc/fsl/fsl_esai.c                             |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
index cacd18b..4103f46 100644
--- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
@@ -7,8 +7,8 @@ other DSPs. It has up to six transmitters and four receivers.
 
 Required properties:
 
-  - compatible		: Compatible list, must contain "fsl,imx35-esai" or
-			  "fsl,vf610-esai"
+  - compatible		: Compatible list, must contain "fsl,imx35-esai",
+			  "fsl,vf610-esai" or "fsl,imx6ull-esai"
 
   - reg			: Offset and length of the register set for the device.
 
diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index abc815f..8724fdb2 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -47,6 +47,23 @@
 		aips-bus at 2000000 {
 			spba-bus at 2000000 {
 				/delete-node/ serial at 2024000;
+
+				esai: esai at 2024000 {
+					compatible = "fsl,imx6ull-esai", "fsl,imx35-esai";
+					reg = <0x02024000 0x4000>;
+					interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6ULL_CLK_ESAI_IPG>,
+						 <&clks IMX6ULL_CLK_ESAI_MEM>,
+						 <&clks IMX6ULL_CLK_ESAI_EXTAL>,
+						 <&clks IMX6ULL_CLK_ESAI_IPG>,
+						 <&clks IMX6UL_CLK_SPBA>;
+					clock-names = "core", "mem", "extal",
+						      "fsys", "spba";
+					dmas = <&sdma 0 21 0>,
+					       <&sdma 47 21 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 			};
 		};
 
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index cef79a1..5b6a53f 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -910,6 +910,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id fsl_esai_dt_ids[] = {
+	{ .compatible = "fsl,imx6ull-esai", },
 	{ .compatible = "fsl,imx35-esai", },
 	{ .compatible = "fsl,vf610-esai", },
 	{}
-- 
2.1.4
