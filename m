From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  7 Sep 2018 12:19:46 +0800
Subject: [PATCH v2 4/6] drm/panel: simple: Add support for Banana Pi 7"
 S070WV20-CT16 panel
In-Reply-To: <20180907041948.19913-1-wens@csie.org>
References: <20180907041948.19913-1-wens@csie.org>
Message-ID: <20180907041948.19913-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This panel is marketed as Banana Pi 7" LCD display. On the back is
a sticker denoting the model name S070WV20-CT16.

This is a 7" 800x480 panel connected through a 24-bit RGB interface.
However the panel only does 262k colors.

Depending on the variant, the PCB attached to the panel module either
supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
itself.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../display/panel/bananapi,s070wv20-ct16.txt  | 12 +++++++++
 drivers/gpu/drm/panel/panel-simple.c          | 25 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt

diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
new file mode 100644
index 000000000000..35bc0c839f49
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
@@ -0,0 +1,12 @@
+Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
+
+Required properties:
+- compatible: should be "bananapi,s070wv20-ct16"
+- power-supply: see ./panel-common.txt
+
+Optional properties:
+- enable-gpios: see ./simple-panel.txt
+- backlight: see ./simple-panel.txt
+
+This binding is compatible with the simple-panel binding, which is specified
+in ./simple-panel.txt.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 97964f7f2ace..52d6ac572825 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -772,6 +772,28 @@ static const struct panel_desc avic_tm070ddh03 = {
 	},
 };
 
+static const struct drm_display_mode bananapi_s070wv20_ct16_mode = {
+	.clock = 30000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 40,
+	.hsync_end = 800 + 40 + 48,
+	.htotal = 800 + 40 + 48 + 40,
+	.vdisplay = 480,
+	.vsync_start = 480 + 13,
+	.vsync_end = 480 + 13 + 3,
+	.vtotal = 480 + 13 + 3 + 29,
+};
+
+static const struct panel_desc bananapi_s070wv20_ct16 = {
+	.modes = &bananapi_s070wv20_ct16_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+};
+
 static const struct drm_display_mode boe_hv070wsa_mode = {
 	.clock = 40800,
 	.hdisplay = 1024,
@@ -2369,6 +2391,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "avic,tm070ddh03",
 		.data = &avic_tm070ddh03,
+	}, {
+		.compatible = "bananapi,s070wv20-ct16",
+		.data = &bananapi_s070wv20_ct16,
 	}, {
 		.compatible = "boe,hv070wsa-100",
 		.data = &boe_hv070wsa
-- 
2.19.0.rc1
