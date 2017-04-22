From: stefan@agner.ch (Stefan Agner)
Date: Fri, 21 Apr 2017 18:23:37 -0700
Subject: [PATCH v2 4/5] ARM: dts: imx7: add GPMI NAND
In-Reply-To: <20170422012338.4635-1-stefan@agner.ch>
References: <20170422012338.4635-1-stefan@agner.ch>
Message-ID: <20170422012338.4635-5-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i.MX 7 GPMI NAND module.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7s.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 843eb379e1ea..9645257638d4 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -995,5 +995,36 @@
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
+			clocks = <&clks IMX7D_NAND_USDHC_BUS_ROOT_CLK>,
+				<&clks IMX7D_NAND_ROOT_CLK>;
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
+			clocks = <&clks IMX7D_NAND_ROOT_CLK>,
+				<&clks IMX7D_NAND_USDHC_BUS_ROOT_CLK>;
+			clock-names = "gpmi_io", "gpmi_bch_apb";
+			dmas = <&dma_apbh 0>;
+			dma-names = "rx-tx";
+			status = "disabled";
+		};
 	};
 };
-- 
2.12.2
