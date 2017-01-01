From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Sun,  1 Jan 2017 21:24:32 +0100
Subject: [PATCH V7 4/4] dts/imx6q-b850v3: Use GE B850v3 LVDS/DP++ Bridge
In-Reply-To: <cover.1483301745.git.peter.senna@collabora.com>
References: <cover.1483301745.git.peter.senna@collabora.com>
Message-ID: <6ebee60090b46bbd329732d7e962c5a694045d15.1483301745.git.peter.senna@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configures the GE B850v3 LVDS/DP++ bridge on the dts file.

Cc: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Martin Donnelly <martin.donnelly@ge.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
---
 arch/arm/boot/dts/imx6q-b850v3.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
index 167f744..ce0ca3a 100644
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
+		reg = <0x73 0x72>;
+		reg-names = "main", "edid";
+
+		interrupt-parent = <&gpio2>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
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
