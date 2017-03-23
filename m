From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 23 Mar 2017 15:13:13 +0100
Subject: [PATCH 2/2] ARM: dts: imx6qp: add PRG nodes and hook up to IPUs
In-Reply-To: <20170323141313.11241-1-l.stach@pengutronix.de>
References: <20170323141313.11241-1-l.stach@pengutronix.de>
Message-ID: <20170323141313.11241-3-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT nodes for the Prefetch Resolve Gaskets found on i.MX6QP
and hook them up to the assigned IPU nodes.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qp.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index d9c0cd0baddb..59453f2ac4ba 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -92,6 +92,24 @@
 				clock-names = "axi";
 				fsl,iram = <&ocram3>;
 			};
+
+			prg1: prg at 21cc000 {
+				compatible = "fsl,imx6qp-prg";
+				reg = <0x021cc000 0x1000>;
+				clocks = <&clks IMX6QDL_CLK_PRG0_APB>,
+					 <&clks IMX6QDL_CLK_PRG0_AXI>;
+				clock-names = "ipg", "axi";
+				fsl,pres = <&pre1>, <&pre2>, <&pre3>;
+			};
+
+			prg2: prg at 21cd000 {
+				compatible = "fsl,imx6qp-prg";
+				reg = <0x021cd000 0x1000>;
+				clocks = <&clks IMX6QDL_CLK_PRG1_APB>,
+					 <&clks IMX6QDL_CLK_PRG1_AXI>;
+				clock-names = "ipg", "axi";
+				fsl,pres = <&pre4>, <&pre2>, <&pre3>;
+			};
 		};
 	};
 };
@@ -104,10 +122,12 @@
 
 &ipu1 {
 	compatible = "fsl,imx6qp-ipu", "fsl,imx6q-ipu";
+	fsl,prg = <&prg1>;
 };
 
 &ipu2 {
 	compatible = "fsl,imx6qp-ipu", "fsl,imx6q-ipu";
+	fsl,prg = <&prg2>;
 };
 
 &ldb {
-- 
2.11.0
