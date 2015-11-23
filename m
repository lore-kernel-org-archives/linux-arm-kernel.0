From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 23 Nov 2015 16:07:03 +0100
Subject: [PATCH 3/3] ARM: imx6: adopt DT to new GPC binding
In-Reply-To: <1448291223-9938-1-git-send-email-l.stach@pengutronix.de>
References: <1448291223-9938-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1448291223-9938-4-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adopt the i.MX6Q/DL DT to the new and more flexible GPC binding.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 2b6cc8bf3c5c..0426a1cbf24e 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -402,7 +402,7 @@
 				clocks = <&clks IMX6QDL_CLK_VPU_AXI>,
 					 <&clks IMX6QDL_CLK_MMDC_CH0_AXI>;
 				clock-names = "per", "ahb";
-				power-domains = <&gpc 1>;
+				power-domains = <&pd_pu>;
 				resets = <&src 1>;
 				iram = <&ocram>;
 			};
@@ -765,14 +765,29 @@
 				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 90 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&intc>;
-				pu-supply = <&reg_pu>;
-				clocks = <&clks IMX6QDL_CLK_GPU3D_CORE>,
-					 <&clks IMX6QDL_CLK_GPU3D_SHADER>,
-					 <&clks IMX6QDL_CLK_GPU2D_CORE>,
-					 <&clks IMX6QDL_CLK_GPU2D_AXI>,
-					 <&clks IMX6QDL_CLK_OPENVG_AXI>,
-					 <&clks IMX6QDL_CLK_VPU_AXI>;
-				#power-domain-cells = <1>;
+				clocks = <&clks IMX6QDL_CLK_IPG>;
+				clock-names = "ipg";
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					power-domain at 0 {
+						reg = <0>;
+						#power-domain-cells = <0>;
+					};
+					pd_pu: power-domain at 1 {
+						reg = <1>;
+						#power-domain-cells = <0>;
+						domain-supply = <&reg_pu>;
+						clocks = <&clks IMX6QDL_CLK_GPU3D_CORE>,
+						         <&clks IMX6QDL_CLK_GPU3D_SHADER>,
+						         <&clks IMX6QDL_CLK_GPU2D_CORE>,
+						         <&clks IMX6QDL_CLK_GPU2D_AXI>,
+						         <&clks IMX6QDL_CLK_OPENVG_AXI>,
+						         <&clks IMX6QDL_CLK_VPU_AXI>;
+					};
+				};
 			};
 
 			gpr: iomuxc-gpr at 020e0000 {
-- 
2.6.2
