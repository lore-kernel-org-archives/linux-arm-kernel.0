From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 20 Jul 2016 11:18:50 +0800
Subject: [PATCH 2/2] dt-bindings: add simple-panel-dsi and simple-panel
In-Reply-To: <1468984730-23186-1-git-send-email-mark.yao@rock-chips.com>
References: <1468984730-23186-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1468984730-23186-2-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow user add display timing on device tree with simple-panel-dsi
or simple-panel.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 .../bindings/display/panel/simple-panel.txt        | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/simple-panel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
index 1341bbf..bc66970 100644
--- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
+++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
@@ -4,10 +4,22 @@ Required properties:
 - power-supply: regulator to provide the supply voltage
 
 Optional properties:
+- compatible: value maybe one of the following
+		"simple-panel";
+		"simple-panel-dsi";
+
 - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
 - enable-gpios: GPIO pin to enable or disable the panel
 - backlight: phandle of the backlight device attached to the panel
 
+Required properties when compatible is "simple-panel" or "simple-panel-dsi":
+- display-timings: see display-timing.txt for information
+
+Optional properties when compatible is a dsi devices:
+- dsi,flags: dsi operation mode related flags
+- dsi,format: pixel format for video mode
+- dsi,lanes: number of active data lanes
+
 Example:
 
 	panel: panel {
@@ -19,3 +31,39 @@ Example:
 
 		backlight = <&backlight>;
 	};
+
+Or:
+	panel: panel {
+		compatible = "simple-panel-dsi";
+		ddc-i2c-bus = <&panelddc>;
+
+		power-supply = <&vdd_pnl_reg>;
+		enable-gpios = <&gpio 90 0>;
+
+		backlight = <&backlight>;
+
+		dsi,flags = <MIPI_DSI_MODE_VIDEO |
+			     MIPI_DSI_MODE_VIDEO_BURST |
+			     MIPI_DSI_MODE_VIDEO_SYNC_PULSE>;
+		dsi,format = <MIPI_DSI_FMT_RGB888>;
+		dsi,lanes = <4>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency = <160000000>;
+				hactive = <1200>;
+				vactive = <1920>;
+				hback-porch = <21>;
+				hfront-porch = <120>;
+				vback-porch = <18>;
+				vfront-porch = <21>;
+				hsync-len = <20>;
+				vsync-len = <3>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <0>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
-- 
1.9.1
