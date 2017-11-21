From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Nov 2017 20:50:01 -0200
Subject: [PATCH 1/3] ARM: dts: imx6sx: Fix the PCI representation
In-Reply-To: <1511304601-1149-1-git-send-email-festevam@gmail.com>
References: <1511304601-1149-1-git-send-email-festevam@gmail.com>
Message-ID: <1511304601-1149-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Currently the imx pci driver fails to probe on i.MX6SX.

Fix the PCI representation so that the driver can be probed and
PCI devices can be detected.

Tested on a im6sx-sdb board:

# lspci 
00:00.0 Class 0604: 16c3:abcd
01:00.0 Class 0280: 8086:08b1

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
We still need to add a power domain description for PCI on i.MX6SX,
but this can be addded later.

This current patch is a real improvement as it allows to detect
PCI devices now.

 arch/arm/boot/dts/imx6sx.dtsi | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 5b03ba3..0e608a4 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1304,25 +1304,28 @@
 
 		pcie: pcie at 8ffc000 {
 			compatible = "fsl,imx6sx-pcie", "snps,dw-pcie";
-			reg = <0x08ffc000 0x4000>; /* DBI */
+			reg = <0x08ffc000 0x04000>, <0x08f00000 0x80000>;
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
 			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0 0          0x08f80000 0 0x00010000 /* downstream I/O */
+				  0x82000000 0 0x01000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clks IMX6SX_CLK_PCIE_REF_125M>,
-				 <&clks IMX6SX_CLK_PCIE_AXI>,
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gpc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gpc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gpc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gpc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX6SX_CLK_PCIE_AXI>,
 				 <&clks IMX6SX_CLK_LVDS1_OUT>,
+				 <&clks IMX6SX_CLK_PCIE_REF_125M>,
 				 <&clks IMX6SX_CLK_DISPLAY_AXI>;
-			clock-names = "pcie_ref_125m", "pcie_axi",
-				      "lvds_gate", "display_axi";
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_inbound_axi";
 			status = "disabled";
 		};
 	};
-- 
2.7.4
