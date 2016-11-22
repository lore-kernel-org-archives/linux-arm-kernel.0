From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 22 Nov 2016 11:45:50 -0800
Subject: [PATCH 3/4] ARM: dts: davinci: da850-lcdk: enable VPIF capture via
 TVP5147
In-Reply-To: <20161122194551.3420-1-khilman@baylibre.com>
References: <20161122194551.3420-1-khilman@baylibre.com>
Message-ID: <20161122194551.3420-4-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable video capture via the on-board TVP5147 decoder hooked up to ch0
one of the VPIF capture input.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 03f9bfda5385..39db2ffa1902 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -138,6 +138,24 @@
 		reg = <0x18>;
 		status = "okay";
 	};
+
+	tvp5147 at 5d {
+		compatible = "ti,tvp5147";
+		reg = <0x5d>;
+		status = "okay";
+
+		port {
+			composite: endpoint {
+				hsync-active = <1>;
+				vsync-active = <1>;
+				pclk-sample = <0>;
+
+				/* VPIF channel 0 (lower 8-bits) */
+				remote-endpoint = <&vpif_ch0>;
+				bus-width = <8>;
+			};
+		};
+	};
 };
 
 &mcasp0 {
@@ -227,3 +245,15 @@
 		};
 	};
 };
+
+&vpif {
+	status = "okay";
+};
+
+&vpif_capture {
+	status = "okay";
+};
+
+&vpif_ch0 {
+	remote-endpoint = <&composite>;
+};
-- 
2.9.3
