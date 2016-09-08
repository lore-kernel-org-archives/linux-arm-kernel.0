From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  8 Sep 2016 09:43:07 +0200
Subject: [PATCH 11/30] arm64: dts: r8a7795: renesas: salvator-x: Enable DU
In-Reply-To: <cover.1473320411.git.horms+renesas@verge.net.au>
References: <cover.1473320411.git.horms+renesas@verge.net.au>
Message-ID: <aadc4ee00a0ec4de5e4aea9f879ab738fd34d0e1.1473320411.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Only the VGA output is supported for now.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 4332ec7bb38c..64a29a87a724 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -146,6 +146,50 @@
 			sound-dai = <&ak4613>;
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
+	vga {
+		compatible = "vga-connector";
+
+		port {
+			vga_in: endpoint {
+				remote-endpoint = <&adv7123_out>;
+			};
+		};
+	};
+};
+
+&du {
+	status = "okay";
+
+	ports {
+		port at 0 {
+			endpoint {
+				remote-endpoint = <&adv7123_in>;
+			};
+		};
+	};
 };
 
 &extal_clk {
-- 
2.7.0.rc3.207.g0ac5344
