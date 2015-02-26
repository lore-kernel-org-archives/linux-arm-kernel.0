From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:21:17 +0900
Subject: [PATCH 20/32] ARM: shmobile: koelsch: Add DU HDMI output support
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
Message-ID: <83a0731b39f3bc2421960e6169f8440ca673a20f.1424849129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add DT nodes for the ADV7511 HDMI encoder and its HDMI output connector
and configure the DISP pin group that drives the HDMI transmitter DE
pin.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 50 ++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index a3c2780..624bb2c 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -258,6 +258,17 @@
 			system-clock-frequency = <11289600>;
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
@@ -266,6 +277,11 @@
 	status = "okay";
 
 	ports {
+		port at 0 {
+			endpoint {
+				remote-endpoint = <&adv7511_in>;
+			};
+		};
 		port at 1 {
 			lvds_connector: endpoint {
 			};
@@ -284,7 +300,7 @@
 	};
 
 	du_pins: du {
-		renesas,groups = "du_rgb666", "du_sync", "du_clk_out_0";
+		renesas,groups = "du_rgb666", "du_sync", "du_disp", "du_clk_out_0";
 		renesas,function = "du";
 	};
 
@@ -506,6 +522,38 @@
 		};
 	};
 
+	hdmi at 39 {
+		compatible = "adi,adv7511w";
+		reg = <0x39>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
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
+					remote-endpoint = <&du_out_rgb>;
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
+
 	eeprom at 50 {
 		compatible = "renesas,24c02";
 		reg = <0x50>;
-- 
2.1.4
