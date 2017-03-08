From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed,  8 Mar 2017 12:46:37 -0500
Subject: [PATCH 1/2] [kernel] ARM: dts: lpc32xx: phy3250: add clcd
 configuration
In-Reply-To: <20170308174638.25578-1-slemieux.tyco@gmail.com>
References: <20170308174638.25578-1-slemieux.tyco@gmail.com>
Message-ID: <20170308174638.25578-2-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liam Beguin <lbeguin@tycoint.com>

Updating CLCD board and panel definiton to use
up-to-date devicetree hardware description.

Signed-off-by: Liam Beguin <lbeguin@tycoint.com>
Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
 arch/arm/boot/dts/lpc3250-phy3250.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/lpc3250-phy3250.dts b/arch/arm/boot/dts/lpc3250-phy3250.dts
index fd95e2b10357..1e5dbbad6cc4 100644
--- a/arch/arm/boot/dts/lpc3250-phy3250.dts
+++ b/arch/arm/boot/dts/lpc3250-phy3250.dts
@@ -72,7 +72,42 @@
 };
 
 &clcd {
+	interrupt-names = "combined";
+	max-memory-bandwidth = <11700000>; /* Bps, 240x320 at 60 16bpp */
 	status = "okay";
+
+	port {
+		clcd_pads: endpoint {
+			remote-endpoint = <&clcd_panel>;
+			arm,pl11x,tft-r0g0b0-pads = <3 10 19>; /* Set LCD to BGR 565 */
+		};
+	};
+
+	panel {
+		compatible = "panel-dpi";
+
+		port {
+			clcd_panel: endpoint {
+				remote-endpoint = <&clcd_pads>;
+			};
+		};
+
+		panel-timing {
+			clock-frequency = <5850000>;
+
+			hactive = <240>;
+			hback-porch = <11>;
+			hfront-porch = <22>;
+			hsync-len = <5>;
+
+			vactive = <320>;
+			vback-porch = <2>;
+			vfront-porch = <1>;
+			vsync-len = <2>;
+
+			pixelclk-active = <1>;
+		};
+	};
 };
 
 &i2c1 {
-- 
2.11.0
