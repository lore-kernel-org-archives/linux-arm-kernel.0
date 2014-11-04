From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:29 +0900
Subject: [PATCH 06/10] ARM: shmobile: marzen: Enable DU device in DT
In-Reply-To: <cover.1415058552.git.horms+renesas@verge.net.au>
References: <cover.1415058552.git.horms+renesas@verge.net.au>
Message-ID: <a7aee3ac437be568e6285c10d765ec074fa19587.1415058552.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Specify the DU output topology, enable the DU device and configure the
related pins.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 83 ++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index c160404..765978f 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -68,6 +68,78 @@
 			gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	vga-encoder {
+		compatible = "adi,adv7123";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				vga_enc_in: endpoint {
+					remote-endpoint = <&du_out_rgb0>;
+				};
+			};
+			port at 1 {
+				reg = <1>;
+				vga_enc_out: endpoint {
+					remote-endpoint = <&vga_in>;
+				};
+			};
+		};
+	};
+
+	vga {
+		compatible = "vga-connector";
+
+		port {
+			vga_in: endpoint {
+				remote-endpoint = <&vga_enc_out>;
+			};
+		};
+	};
+
+	lvds-encoder {
+		compatible = "thine,thc63lvdm83d";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				lvds_enc_in: endpoint {
+					remote-endpoint = <&du_out_rgb1>;
+				};
+			};
+			port at 1 {
+				reg = <1>;
+				lvds_connector: endpoint {
+				};
+			};
+		};
+	};
+};
+
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ports {
+		port at 0 {
+			endpoint {
+				remote-endpoint = <&vga_enc_in>;
+			};
+		};
+		port at 1 {
+			endpoint {
+				remote-endpoint = <&lvds_enc_in>;
+			};
+		};
+	};
 };
 
 &irqpin0 {
@@ -83,6 +155,17 @@
 };
 
 &pfc {
+	du_pins: du {
+		du0 {
+			renesas,groups = "du0_rgb888", "du0_sync_1", "du0_clk_out_0";
+			renesas,function = "du0";
+		};
+		du1 {
+			renesas,groups = "du1_rgb666", "du1_sync_1", "du1_clk_out";
+			renesas,function = "du1";
+		};
+	};
+
 	lan0_pins: lan0 {
 		intc {
 			renesas,groups = "intc_irq1_b";
-- 
2.1.1
