From: eric@anholt.net (Eric Anholt)
Date: Fri, 18 Mar 2016 19:42:43 -0700
Subject: [PATCH 2/5] panel-simple: Add the 7" DPI panel from Adafruit.
In-Reply-To: <1458355366-7073-1-git-send-email-eric@anholt.net>
References: <1458355366-7073-1-git-send-email-eric@anholt.net>
Message-ID: <1458355366-7073-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a basic TFT panel with a 40-pin FPC connector on it.  The
specification doesn't define timings, but the Adafruit instructions
were setting up 800x480 CVT.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bindings/display/panel/ontat,yx700wv03.txt     |  7 +++++
 drivers/gpu/drm/panel/panel-simple.c               | 33 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ontat,yx700wv03.txt

diff --git a/Documentation/devicetree/bindings/display/panel/ontat,yx700wv03.txt b/Documentation/devicetree/bindings/display/panel/ontat,yx700wv03.txt
new file mode 100644
index 0000000..3d8a5e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ontat,yx700wv03.txt
@@ -0,0 +1,7 @@
+On Tat Industrial Company 7" DPI TFT panel.
+
+Required properties:
+- compatible: should be "ontat,yx700wv03"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index f88a631..6583fdd 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1176,6 +1176,36 @@ static const struct panel_desc shelly_sca07010_bfn_lnn = {
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
+/* 800x480 CVT.  The panel appears to be quite accepting, at least as
+ * far as pixel clocks, but this is the timing that was being used in
+ * the Adafruit installation instructions.
+ */
+static const struct drm_display_mode ontat_yx700wv03_mode = {
+	.clock = 29500,
+	.hdisplay = 800,
+	.hsync_start = 824,
+	.hsync_end = 896,
+	.htotal = 992,
+	.vdisplay = 480,
+	.vsync_start = 483,
+	.vsync_end = 493,
+	.vtotal = 500,
+	.vrefresh = 60,
+};
+
+/* Specification at
+ * https://www.adafruit.com/images/product-files/2406/c3163.pdf
+ */
+static const struct panel_desc ontat_yx700wv03 = {
+	.modes = &ontat_yx700wv03_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 154,
+		.height = 83,
+	},
+};
+
 static const struct of_device_id platform_of_match[] = {
 	{
 		.compatible = "ampire,am800480r3tmqwa1h",
@@ -1265,6 +1295,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "okaya,rs800480t-7x0gp",
 		.data = &okaya_rs800480t_7x0gp,
 	}, {
+		.compatible = "ontat,yx700wv03",
+		.data = &ontat_yx700wv03,
+	}, {
 		.compatible = "ortustech,com43h4m85ulc",
 		.data = &ortustech_com43h4m85ulc,
 	}, {
-- 
2.7.0
