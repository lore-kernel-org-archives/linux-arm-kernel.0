From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Dec 2017 00:24:58 -0200
Subject: [PATCH 2/2] ARM: dts: imx6sx: Add support for PCI power domain
In-Reply-To: <1513304698-15169-1-git-send-email-festevam@gmail.com>
References: <1513304698-15169-1-git-send-email-festevam@gmail.com>
Message-ID: <1513304698-15169-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Previously PCI support was working because the bootloader has previously
powered up the PCI power domain.

Represent the PCI power domain, so that PCI is functional without
relying on the PCI support from the bootloader.

Tested on a imx6sx-sdb board with no PCI support in the bootloader.

Reported-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 40c6738c..c6ea6ec 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -750,6 +750,19 @@
 				#interrupt-cells = <3>;
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&intc>;
+				clocks = <&clks IMX6SX_CLK_IPG>;
+				clock-names = "ipg";
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					pd_pci: power-domain at 3 {
+						reg = <3>;
+						#power-domain-cells = <0>;
+						power-supply = <&reg_pcie>;
+					};
+				};
 			};
 
 			iomuxc: iomuxc at 20e0000 {
@@ -1328,6 +1341,7 @@
 				 <&clks IMX6SX_CLK_PCIE_REF_125M>,
 				 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_inbound_axi";
+			power-domains = <&pd_pci>;
 			status = "disabled";
 		};
 	};
-- 
2.7.4
