From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:03:00 +0200
Subject: [PATCH 05/29] arm64: dts: renesas: draak: Describe HDMI input
In-Reply-To: <cover.1529933747.git.horms+renesas@verge.net.au>
References: <cover.1529933747.git.horms+renesas@verge.net.au>
Message-ID: <1b1b30a233d41fe764190340654f648fe15905d2.1529933747.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Describe HDMI input connector and ADV7612 HDMI decoder installed on
R-Car Gen3 Draak board.

The video signal routing to the HDMI decoder to the video input interface
VIN4 is multiplexed with CVBS input path, and enabled/disabled through
on-board switches SW-49, SW-50, SW-51 and SW-52.

As the default board switches configuration connects CVBS input to VIN4,
leave the HDMI decoder unconnected in DTS.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index a1b71c7d01b6..f62627ce6a72 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -69,6 +69,17 @@
 		};
 	};
 
+	hdmi-in {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&adv7612_in>;
+			};
+		};
+	};
+
 	memory at 48000000 {
 		device_type = "memory";
 		/* first 128MB is reserved for secure area. */
@@ -207,6 +218,44 @@
 				};
 			};
 		};
+
+	};
+
+	hdmi-decoder at 4c {
+		compatible = "adi,adv7612";
+		reg = <0x4c>;
+		default-input = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+
+				adv7612_in: endpoint {
+					remote-endpoint = <&hdmi_con_in>;
+				};
+			};
+
+			port at 2 {
+				reg = <2>;
+
+				/*
+				 * The VIN4 video input path is shared between
+				 * CVBS and HDMI inputs through SW[49-53]
+				 * switches.
+				 *
+				 * CVBS is the default selection, leave HDMI
+				 * not connected here.
+				 */
+				adv7612_out: endpoint {
+					pclk-sample = <0>;
+					hsync-active = <0>;
+					vsync-active = <0>;
+				};
+			};
+		};
 	};
 };
 
-- 
2.11.0
