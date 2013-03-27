From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 27 Mar 2013 18:30:45 +0100
Subject: [PATCH v2 11/11] ARM i.MX6q: Add LDB device to device tree
In-Reply-To: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
References: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1364405445-5271-12-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Add ldb device tree node and clock lookups.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6q.dtsi   | 17 +++++++++++++++++
 arch/arm/boot/dts/imx6qdl.dtsi | 26 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index cba021e..1a30227 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -294,3 +294,20 @@
 		};
 	};
 };
+
+&ldb {
+	clocks = <&clks 33>, <&clks 34>,
+		 <&clks 39>, <&clks 40>, <&clks 41>, <&clks 42>,
+		 <&clks 135>, <&clks 136>;
+	clock-names = "di0_pll", "di1_pll",
+		      "di0_sel", "di1_sel", "di2_sel", "di3_sel",
+		      "di0", "di1";
+
+	lvds-channel at 0 {
+		crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
+	};
+
+	lvds-channel at 1 {
+		crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 06ec460..dd5ef96 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -529,6 +529,32 @@
 				reg = <0x020e0000 0x38>;
 			};
 
+			ldb: ldb at 020e0008 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx6q-ldb", "fsl,imx53-ldb";
+				clocks = <&clks 33>, <&clks 34>,
+					 <&clks 39>, <&clks 40>,
+					 <&clks 135>, <&clks 136>;
+				clock-names = "di0_pll", "di1_pll",
+					      "di0_sel", "di1_sel",
+					      "di0", "di1";
+				gpr = <&gpr>;
+				status = "disabled";
+
+				lvds-channel at 0 {
+					reg = <0>;
+					crtcs = <&ipu1 0>;
+					status = "disabled";
+				};
+
+				lvds-channel at 1 {
+					reg = <1>;
+					crtcs = <&ipu1 1>;
+					status = "disabled";
+				};
+			};
+
 			dcic1: dcic at 020e4000 {
 				reg = <0x020e4000 0x4000>;
 				interrupts = <0 124 0x04>;
-- 
1.8.2.rc2
