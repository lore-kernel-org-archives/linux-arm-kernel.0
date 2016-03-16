From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 16 Mar 2016 12:41:54 +0100
Subject: [PATCH v2 3/3] ARM: imx6: adopt DT to new GPC binding
In-Reply-To: <1458128514-9560-1-git-send-email-l.stach@pengutronix.de>
References: <1458128514-9560-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1458128514-9560-3-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adopt the i.MX6Q/DL DT to the new and more flexible GPC binding.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2: update new GPU nodes present in v4.5
---
 arch/arm/boot/dts/imx6q.dtsi   |  2 +-
 arch/arm/boot/dts/imx6qdl.dtsi | 38 +++++++++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 0d93c0e8f9ba..eafc757293f8 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -125,7 +125,7 @@
 			clocks = <&clks IMX6QDL_CLK_OPENVG_AXI>,
 				 <&clks IMX6QDL_CLK_GPU2D_CORE>;
 			clock-names = "bus", "core";
-			power-domains = <&gpc 1>;
+			power-domains = <&pd_pu>;
 		};
 
 		ipu2: ipu at 02800000 {
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index f74d3db4846d..54b7d651be2e 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1,3 +1,4 @@
+
 /*
  * Copyright 2011 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
@@ -147,7 +148,7 @@
 				 <&clks IMX6QDL_CLK_GPU3D_CORE>,
 				 <&clks IMX6QDL_CLK_GPU3D_SHADER>;
 			clock-names = "bus", "core", "shader";
-			power-domains = <&gpc 1>;
+			power-domains = <&pd_pu>;
 		};
 
 		gpu_2d: gpu at 00134000 {
@@ -157,7 +158,7 @@
 			clocks = <&clks IMX6QDL_CLK_GPU2D_AXI>,
 				 <&clks IMX6QDL_CLK_GPU2D_CORE>;
 			clock-names = "bus", "core";
-			power-domains = <&gpc 1>;
+			power-domains = <&pd_pu>;
 		};
 
 		timer at 00a00600 {
@@ -423,7 +424,7 @@
 				clocks = <&clks IMX6QDL_CLK_VPU_AXI>,
 					 <&clks IMX6QDL_CLK_MMDC_CH0_AXI>;
 				clock-names = "per", "ahb";
-				power-domains = <&gpc 1>;
+				power-domains = <&pd_pu>;
 				resets = <&src 1>;
 				iram = <&ocram>;
 			};
@@ -786,14 +787,29 @@
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
2.7.0
