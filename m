From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Tue, 28 Feb 2017 15:28:13 +0100
Subject: [PATCH V2 4/4] dts/imx6q-b850v3: Use megachips-stdpxxxx-ge-b850v3-fw
 bridges (LVDS-DP++)
In-Reply-To: <cover.1488287639.git.peter.senna@collabora.com>
References: <cover.1488287639.git.peter.senna@collabora.com>
Message-ID: <fdac63782b508d8ded862a4470b9fb1eef98305d.1488287639.git.peter.senna@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configures the megachips-stdpxxxx-ge-b850v3-fw bridges on the GE
B850v3 dts file.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Martin Donnelly <martin.donnelly@ge.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
---
Unchanged from V1.

 arch/arm/boot/dts/imx6q-b850v3.dts | 68 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
index b237429..3ec54da 100644
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
+				remote-endpoint = <&stdp4028_in>;
+			};
+		};
 	};
 };
 
@@ -146,3 +153,64 @@
 &usdhc2 {
 	status = "disabled";
 };
+
+&mux2_i2c2 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	stdp4028 at 73 {
+		compatible = "megachips,stdp4028-ge-b850v3-fw";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg = <0x73>;
+
+		interrupt-parent = <&gpio2>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				stdp4028_in: endpoint {
+					remote-endpoint = <&lvds0_out>;
+				};
+			};
+			port at 1 {
+				reg = <1>;
+				stdp4028_out: endpoint {
+					remote-endpoint = <&stdp2690_in>;
+				};
+			};
+		};
+	};
+
+	stdp2690 at 72 {
+		compatible = "megachips,stdp2690-ge-b850v3-fw";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg = <0x72>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				stdp2690_in: endpoint {
+					remote-endpoint = <&stdp4028_out>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				stdp2690_out: endpoint {
+					/* Connector for external display */
+				};
+			};
+		};
+	};
+};
-- 
2.9.3
