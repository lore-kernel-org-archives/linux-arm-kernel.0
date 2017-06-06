From: stefan@agner.ch (Stefan Agner)
Date: Mon,  5 Jun 2017 23:30:49 -0700
Subject: [PATCH v5 2/3] ARM: dts: imx7: add GPMI NAND and APBH DMA
In-Reply-To: <cover.b62c3a17bd60de48d8fb2ade6dde4f2bc60aaf3c.1496730576.git-series.stefan@agner.ch>
References: <cover.b62c3a17bd60de48d8fb2ade6dde4f2bc60aaf3c.1496730576.git-series.stefan@agner.ch>
Message-ID: <151ddece1e1427d0b69c4ff11b86a69b6a035d0d.1496730576.git-series.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i.MX 7 APBH DMA and GPMI NAND modules.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7s.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index c4f12fd..d71acd8 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -995,5 +995,37 @@
 				status = "disabled";
 			};
 		};
+
+		dma_apbh: dma-apbh at 33000000 {
+			compatible = "fsl,imx7d-dma-apbh", "fsl,imx28-dma-apbh";
+			reg = <0x33000000 0x2000>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
+			#dma-cells = <1>;
+			dma-channels = <4>;
+			clocks = <&clks IMX7D_NAND_USDHC_BUS_RAWNAND_CLK>;
+			clock-names = "dma_apbh_bch", "dma_apbh_io";
+		};
+
+		gpmi: gpmi-nand at 33002000{
+			compatible = "fsl,imx7d-gpmi-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x33002000 0x2000>, <0x33004000 0x4000>;
+			reg-names = "gpmi-nand", "bch";
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "bch";
+			clocks = <&clks IMX7D_NAND_RAWNAND_CLK>,
+				<&clks IMX7D_NAND_USDHC_BUS_RAWNAND_CLK>;
+			clock-names = "gpmi_io", "gpmi_bch_apb";
+			dmas = <&dma_apbh 0>;
+			dma-names = "rx-tx";
+			status = "disabled";
+			assigned-clocks = <&clks IMX7D_NAND_ROOT_SRC>;
+			assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_500M_CLK>;
+		};
 	};
 };
-- 
git-series 0.9.1
