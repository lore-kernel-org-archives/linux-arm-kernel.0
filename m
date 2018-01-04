From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu,  4 Jan 2018 11:42:19 +0530
Subject: [PATCH v2 1/7] drm/panel: simple: add support for Ampire
 AM-800480AYTZQW-00H
In-Reply-To: <1515046345-15881-1-git-send-email-jagan@amarulasolutions.com>
References: <1515046345-15881-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1515046345-15881-2-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the Ampire AM-800480AYTZQW-00H 7.0" WGA LCD,
which can be supported by the simple panel driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Updated binding info about optional properties, node and example

 .../display/panel/ampire,am-800480aytzqw-00h.txt   | 25 ++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt

diff --git a/Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt b/Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt
new file mode 100644
index 0000000..abb5eee
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt
@@ -0,0 +1,25 @@
+Ampire AM-800480AYTZQW-00H 7.0" WVGA TFT LCD panel
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
+
+Required properties:
+- compatible: should be "ampire,am-800480aytzqw-00h"
+
+Optional properties:
+- backlight: phandle of the backlight device attached to the panel
+
+Optional nodes:
+- Video port for LVDS panel input.
+
+Example:
+	panel {
+		compatible = "ampire,am-800480aytzqw-00h";
+		backlight = <&backlight_lvds>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 8fd0b01..e262462 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -412,6 +412,30 @@ static const struct panel_desc ampire_am_480272h3tmqw_t01h = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
+static const struct display_timing ampire_am_800480aytzqw_00h_timing = {
+	.pixelclock = { 27700000, 29200000, 39600000 },
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 12, 40, 212 },
+	.hback_porch = { 88, 88, 88 },
+	.hsync_len = { 1, 2, 40 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 1, 13, 88 },
+	.vback_porch = { 32, 32, 32 },
+	.vsync_len = { 1, 2, 3 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
+};
+
+static const struct panel_desc ampire_am_800480aytzqw_00h = {
+	.timings = &ampire_am_800480aytzqw_00h_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+};
+
 static const struct drm_display_mode ampire_am800480r3tmqwa1h_mode = {
 	.clock = 33333,
 	.hdisplay = 800,
@@ -2054,6 +2078,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "ampire,am-480272h3tmqw-t01h",
 		.data = &ampire_am_480272h3tmqw_t01h,
 	}, {
+		.compatible = "ampire,am-800480aytzqw-00h",
+		.data = &ampire_am_800480aytzqw_00h,
+	}, {
 		.compatible = "ampire,am800480r3tmqwa1h",
 		.data = &ampire_am800480r3tmqwa1h,
 	}, {
-- 
2.7.4
