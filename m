From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue,  8 Nov 2016 17:55:36 +0100
Subject: [PATCH] arm: imx6qp: correct LDB clock inputs
Message-ID: <20161108165536.19656-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6QP the LDB clock tree has changed to move the clk gate
before the divider, to prevent clock glitches propagating downstream.

A consequence of this change is that the clk divider is now the
parent of the LDB inputs. Reflect this change in the devicetree
to allow the LDB driver to properly configure the display clocks.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index 886dbf2eca49..caaa04036c8a 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -87,3 +87,13 @@
 		};
 	};
 };
+
+&ldb {
+	clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>, <&clks IMX6QDL_CLK_LDB_DI1_SEL>,
+		 <&clks IMX6QDL_CLK_IPU1_DI0_SEL>, <&clks IMX6QDL_CLK_IPU1_DI1_SEL>,
+		 <&clks IMX6QDL_CLK_IPU2_DI0_SEL>, <&clks IMX6QDL_CLK_IPU2_DI1_SEL>,
+		 <&clks IMX6QDL_CLK_LDB_DI0_PODF>, <&clks IMX6QDL_CLK_LDB_DI1_PODF>;
+	clock-names = "di0_pll", "di1_pll",
+		      "di0_sel", "di1_sel", "di2_sel", "di3_sel",
+		      "di0", "di1";
+};
-- 
2.10.1
