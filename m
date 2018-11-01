From: contact@paulk.fr (Paul Kocialkowski)
Date: Thu,  1 Nov 2018 21:00:43 +0100
Subject: [PATCH v2 5/7] drm/panel: simple: Add support for the LeMaker
 BL035-RGB-002 3.5" LCD
In-Reply-To: <20181101200045.6078-1-contact@paulk.fr>
References: <20181101200045.6078-1-contact@paulk.fr>
Message-ID: <20181101200045.6078-6-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the 3.5" LCD panel from LeMaker, sold for use with
BananaPi boards. It comes with a 24-bit RGB888 parallel interface and
requires an active-low DE signal

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 90296090340e..8e147cfa7b88 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1562,6 +1562,30 @@ static const struct panel_desc kyo_tcg121xglp = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
 };
 
+static const struct drm_display_mode lemaker_bl035_rgb_002_mode = {
+	.clock = 7000,
+	.hdisplay = 320,
+	.hsync_start = 320 + 20,
+	.hsync_end = 320 + 20 + 30,
+	.htotal = 320 + 20 + 30 + 38,
+	.vdisplay = 240,
+	.vsync_start = 240 + 4,
+	.vsync_end = 240 + 4 + 3,
+	.vtotal = 240 + 4 + 3 + 15,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc lemaker_bl035_rgb_002 = {
+	.modes = &lemaker_bl035_rgb_002_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 70,
+		.height = 52,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_LOW,
+};
+
 static const struct drm_display_mode lg_lb070wv8_mode = {
 	.clock = 33246,
 	.hdisplay = 800,
@@ -2569,6 +2593,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "kyo,tcg121xglp",
 		.data = &kyo_tcg121xglp,
+	}, {
+		.compatible = "lemaker,bl035-rgb-002",
+		.data = &lemaker_bl035_rgb_002,
 	}, {
 		.compatible = "lg,lb070wv8",
 		.data = &lg_lb070wv8,
-- 
2.19.1
