From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 10 Mar 2015 09:44:44 +0900
Subject: [PATCH 07/15] ARM: shmobile: lager: Add DU HDMI output support
In-Reply-To: <cover.1425947992.git.horms+renesas@verge.net.au>
References: <cover.1425947992.git.horms+renesas@verge.net.au>
Message-ID: <fd25cdd15b7f9d1dbddb03e44b82c48d69f24200.1425947992.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add DT nodes for the ADV7511 HDMI encoder and its HDMI output connector.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 0c3b678..631b3f5 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -222,6 +222,17 @@
 			};
 		};
 	};
+
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&adv7511_out>;
+			};
+		};
+	};
 };
 
 &du {
@@ -235,6 +246,11 @@
 				remote-endpoint = <&adv7123_in>;
 			};
 		};
+		port at 1 {
+			endpoint {
+				remote-endpoint = <&adv7511_in>;
+			};
+		};
 		port at 2 {
 			lvds_connector: endpoint {
 			};
@@ -506,6 +522,38 @@
 			};
 		};
 	};
+
+	hdmi at 39 {
+		compatible = "adi,adv7511w";
+		reg = <0x39>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
+
+		adi,input-depth = <8>;
+		adi,input-colorspace = "rgb";
+		adi,input-clock = "1x";
+		adi,input-style = <1>;
+		adi,input-justification = "evenly";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				adv7511_in: endpoint {
+					remote-endpoint = <&du_out_lvds0>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				adv7511_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
 };
 
 &iic3 {
-- 
2.1.4
