From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  7 Jun 2016 21:10:25 -0300
Subject: [PATCH 1/2] ARM: dts: imx6sx: Fix PCIE support
Message-ID: <1465344626-15883-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Adjust the PCIE node in order to get it working with a mainline
kernel.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 6a993bfda..6ffcc94 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1252,24 +1252,28 @@
 
 		pcie: pcie at 0x08000000 {
 			compatible = "fsl,imx6sx-pcie", "snps,dw-pcie";
-			reg = <0x08ffc000 0x4000>; /* DBI */
+			reg = <0x08ffc000 0x4000>, <0x08f00000 0x80000>;
+			reg-names = "dbi", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-				  /* configuration space */
-			ranges = <0x00000800 0 0x08f00000 0x08f00000 0 0x00080000
-				  /* downstream I/O */
-				  0x81000000 0 0          0x08f80000 0 0x00010000
-				  /* non-prefetchable memory */
-				  0x82000000 0 0x08000000 0x08000000 0 0x00f00000>;
+			ranges = <0x81000000 0 0          0x08f80000 0 0x00010000 /* downstream I/O */
+				  0x82000000 0 0x08000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
-			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clks IMX6SX_CLK_PCIE_REF_125M>,
-				 <&clks IMX6SX_CLK_PCIE_AXI>,
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX6SX_CLK_PCIE_AXI>,
 				 <&clks IMX6SX_CLK_LVDS1_OUT>,
+				 <&clks IMX6SX_CLK_PCIE_REF_125M>,
 				 <&clks IMX6SX_CLK_DISPLAY_AXI>;
-			clock-names = "pcie_ref_125m", "pcie_axi",
-				      "lvds_gate", "display_axi";
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_inbound_axi";
+			pcie-phy-supply = <&reg_pcie>;
 			status = "disabled";
 		};
 	};
-- 
1.9.1
