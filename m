From: kbingham@kernel.org (Kieran Bingham)
Date: Fri, 16 Feb 2018 12:32:35 +0000
Subject: [PATCH v2] arm64: dts: renesas: r8a77995-draak: Enable DU
In-Reply-To: <1518683903-10681-7-git-send-email-kbingham@kernel.org>
References: <1518683903-10681-7-git-send-email-kbingham@kernel.org>
Message-ID: <1518784355-17272-1-git-send-email-kbingham@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Enable the DU, providing only the VGA output for now.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

Just a v2 update to fix the PFC name, and collect Laurent's RB tag.  The
remainder of the series will likely be postponed due to dependencies on LVDS
changes etc.

v2:
 - Update du_dot_clk_0 name to match Ulrich's PFC configuration.

 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 51 ++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index af07da240be0..37025251078a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -27,6 +27,38 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	vga {
+		compatible = "vga-connector";
+
+		port {
+			vga_in: endpoint {
+				remote-endpoint = <&adv7123_out>;
+			};
+		};
+	};
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
+				adv7123_in: endpoint {
+					remote-endpoint = <&du_out_rgb>;
+				};
+			};
+			port at 1 {
+				reg = <1>;
+				adv7123_out: endpoint {
+					remote-endpoint = <&vga_in>;
+				};
+			};
+		};
+	};
+
 	memory at 48000000 {
 		device_type = "memory";
 		/* first 128MB is reserved for secure area. */
@@ -46,6 +78,11 @@
 		};
 	};
 
+	du_pins: du {
+		groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
+		function = "du";
+	};
+
 	i2c0_pins: i2c0 {
 		groups = "i2c0";
 		function = "i2c0";
@@ -95,6 +132,20 @@
 	status = "okay";
 };
 
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ports {
+		port at 0 {
+			endpoint {
+				remote-endpoint = <&adv7123_in>;
+			};
+		};
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.7.4
