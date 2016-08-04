From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Fri,  5 Aug 2016 00:37:01 +0200
Subject: [PATCH V4 4/4] dts/imx6q-b850v3: Use GE B850v3 LVDS/DP++ Bridge
In-Reply-To: <cover.1470346720.git.peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
 <cover.1470346720.git.peter.senna@collabora.com>
Message-ID: <d992a694942e7b7b6a0dccf56a1f91e5d07a823d.1470346720.git.peter.senna@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configures the GE B850v3 LVDS/DP++ bridge on the dts file.

Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
---
Changes from V3:
 - 4/4 instead of 5/5

Unchanged from V2

Changes from V1:
 - Replaced '_' by '-' in node names or compatible strings
 - Added missing @73 to b850v3-lvds-dp-bridge

 arch/arm/boot/dts/imx6q-b850v3.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
index 167f744..8db3bf2 100644
--- a/arch/arm/boot/dts/imx6q-b850v3.dts
+++ b/arch/arm/boot/dts/imx6q-b850v3.dts
@@ -72,6 +72,13 @@
 		fsl,data-mapping = "spwg";
 		fsl,data-width = <24>;
 		status = "okay";
+
+		port at 4 {
+			reg = <4>;
+			lvds0_out: endpoint {
+				remote-endpoint = <&b850v3_lvds_dp_bridge_in>;
+			};
+		};
 	};
 };
 
@@ -142,3 +149,26 @@
 		reg = <0x4a>;
 	};
 };
+
+&mux2_i2c2 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	b850v3-lvds-dp-bridge at 73 {
+		compatible = "ge,b850v3-lvds-dp";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg = <0x73>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+
+		edid-reg = <0x72>;
+
+		port {
+			b850v3_lvds_dp_bridge_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
+};
-- 
2.5.5
