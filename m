From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun,  6 May 2018 23:48:59 +0200
Subject: [PATCH v3 1/3] drm/panel: Add RGB666 variant of Innolux AT070TN90
Message-ID: <20180506214901.23429-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds timings for the RGB666 variant of the Innolux AT070TN90 panel,
as found on the Ainol AW1 tablet.

The panel also supports RGB888 output. When RGB666 mode is used instead,
the two extra lanes per component are grounded.

In the future, it might become necessary to introduce a dedicated
device-tree property to specify the bus format and maybe specify it in
the mode description instead of panel description so that the
appropriate mode can be selected for each bus format.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index cbf1ab404ee7..351742df8ee1 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1086,6 +1086,29 @@ static const struct panel_desc innolux_at070tn92 = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
+static const struct drm_display_mode innolux_at070tn90_mode = {
+	.clock = 40000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 112,
+	.hsync_end = 800 + 112 + 1,
+	.htotal = 800 + 112 + 1 + 87,
+	.vdisplay = 480,
+	.vsync_start = 480 + 141,
+	.vsync_end = 480 + 141 + 1,
+	.vtotal = 480 + 141 + 1 + 38,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc innolux_at070tn90 = {
+	.modes = &innolux_at070tn90_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+};
+
 static const struct display_timing innolux_g101ice_l01_timing = {
 	.pixelclock = { 60400000, 71100000, 74700000 },
 	.hactive = { 1280, 1280, 1280 },
@@ -2154,6 +2177,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,at070tn92",
 		.data = &innolux_at070tn92,
+	}, {
+		.compatible = "innolux,at070tn90",
+		.data = &innolux_at070tn90,
 	}, {
 		.compatible ="innolux,g101ice-l01",
 		.data = &innolux_g101ice_l01
-- 
2.17.0
