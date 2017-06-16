From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:30:43 +0200
Subject: [PATCH 3/6] ARM: dts: gose: add composite video input
In-Reply-To: <cover.1497618353.git.horms+renesas@verge.net.au>
References: <cover.1497618353.git.horms+renesas@verge.net.au>
Message-ID: <8cae359049a88b75217b1c93774cfe3c3e610304.1497618353.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Adds VIN, decoder and connector.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 59 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 30f083528468..76e3aca2029e 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -275,6 +275,16 @@
 		};
 	};
 
+	composite-in {
+		compatible = "composite-video-connector";
+
+		port {
+			composite_con_in: endpoint {
+				remote-endpoint = <&adv7180_in>;
+			};
+		};
+	};
+
 	x2_clk: x2-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -411,6 +421,11 @@
 		groups = "vin0_data24", "vin0_sync", "vin0_clkenb", "vin0_clk";
 		function = "vin0";
 	};
+
+	vin1_pins: vin1 {
+		groups = "vin1_data8", "vin1_clk";
+		function = "vin1";
+	};
 };
 
 &ether {
@@ -542,6 +557,32 @@
 		reg = <0x12>;
 	};
 
+	composite-in at 20 {
+		compatible = "adi,adv7180cp";
+		reg = <0x20>;
+		remote = <&vin1>;
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				adv7180_in: endpoint {
+					remote-endpoint = <&composite_con_in>;
+				};
+			};
+
+			port at 3 {
+				reg = <3>;
+				adv7180_out: endpoint {
+					bus-width = <8>;
+					remote-endpoint = <&vin1ep>;
+				};
+			};
+		};
+	};
+
 	hdmi at 39 {
 		compatible = "adi,adv7511w";
 		reg = <0x39>;
@@ -670,3 +711,21 @@
 		};
 	};
 };
+
+/* composite video input */
+&vin1 {
+	pinctrl-0 = <&vin1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vin1ep: endpoint {
+			remote-endpoint = <&adv7180_out>;
+			bus-width = <8>;
+		};
+	};
+};
-- 
2.1.4
