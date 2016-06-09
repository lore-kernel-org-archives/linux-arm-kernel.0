From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Thu,  9 Jun 2016 18:25:05 +0200
Subject: [PATCH V2 5/5] dts/imx6q-b850v3: Use GE B850v3 LVDS/DP++ Bridge
In-Reply-To: <cover.1465486875.git.peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
 <cover.1465486875.git.peter.senna@collabora.com>
Message-ID: <3c492c8fcbe409536e791f5062e6eb42d06d76fa.1465486875.git.peter.senna@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configures the GE B850v3 LVDS/DP++ bridge on the dts file.

Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
---
Changes from V1:
 - Replaced '_' by '-' in node names or compatible strings
 - Added missing @73 to b850v3-lvds-dp-bridge

 arch/arm/boot/dts/imx6q-b850v3.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
index 88a70de..a57dd5b 100644
--- a/arch/arm/boot/dts/imx6q-b850v3.dts
+++ b/arch/arm/boot/dts/imx6q-b850v3.dts
@@ -77,6 +77,13 @@
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
 
@@ -147,3 +154,27 @@
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
+		port at 0 {
+			reg = <0>;
+			b850v3_lvds_dp_bridge_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
+};
-- 
2.5.5
