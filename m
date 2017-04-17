From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Mon, 17 Apr 2017 15:02:13 +0900
Subject: [PATCH v2 2/3] drm/panel: s6e3ha2: Add support for s6e3hf2 panel on
 TM2e board
In-Reply-To: <1492408934-22096-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1492408934-22096-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170417060219epcas5p4726fab1b7a58ac3d832e2be86873a37d@epcas5p4.samsung.com>
Message-ID: <1492408934-22096-3-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supports TM2e panel and the panel has 1600x2560 resolution
in 5.65" physical.

This identify panel type with compatibility string, also invoke
display mode that matches the type. So add the check code for s6e3ha2
compatibility and s6e3hf2 type and select the drm_display_mode of
default and edge type.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c | 64 ++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
index 4cc08d7..c7b418b 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
@@ -16,6 +16,7 @@
 #include <drm/drm_panel.h>
 #include <linux/backlight.h>
 #include <linux/gpio/consumer.h>
+#include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 
 #define S6E3HA2_MIN_BRIGHTNESS		0
@@ -218,6 +219,16 @@
 	0x1d, 0x1e, 0x1f, 0x20, 0x21
 };
 
+enum s6e3ha2_type {
+	HA2_TYPE,
+	HF2_TYPE,
+};
+
+struct s6e3ha2_panel_desc {
+	const struct drm_display_mode *mode;
+	enum s6e3ha2_type type;
+};
+
 struct s6e3ha2 {
 	struct device *dev;
 	struct drm_panel panel;
@@ -226,6 +237,8 @@ struct s6e3ha2 {
 	struct regulator_bulk_data supplies[2];
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *enable_gpio;
+
+	const struct s6e3ha2_panel_desc *desc;
 };
 
 static int s6e3ha2_dcs_write(struct s6e3ha2 *ctx, const void *data, size_t len)
@@ -283,11 +296,19 @@ static int s6e3ha2_single_dsi_set(struct s6e3ha2 *ctx)
 static int s6e3ha2_freq_calibration(struct s6e3ha2 *ctx)
 {
 	s6e3ha2_dcs_write_seq_static(ctx, 0xfd, 0x1c);
+	if (ctx->desc->type == HF2_TYPE)
+		s6e3ha2_dcs_write_seq_static(ctx, 0xf2, 0x67, 0x40, 0xc5);
 	s6e3ha2_dcs_write_seq_static(ctx, 0xfe, 0x20, 0x39);
 	s6e3ha2_dcs_write_seq_static(ctx, 0xfe, 0xa0);
 	s6e3ha2_dcs_write_seq_static(ctx, 0xfe, 0x20);
-	s6e3ha2_dcs_write_seq_static(ctx, 0xce, 0x03, 0x3b, 0x12, 0x62, 0x40,
-				0x80, 0xc0, 0x28, 0x28, 0x28, 0x28, 0x39, 0xc5);
+
+	if (ctx->desc->type == HA2_TYPE)
+		s6e3ha2_dcs_write_seq_static(ctx, 0xce, 0x03, 0x3b, 0x12, 0x62,
+			0x40, 0x80, 0xc0, 0x28, 0x28, 0x28, 0x28, 0x39, 0xc5);
+	else
+		s6e3ha2_dcs_write_seq_static(ctx, 0xce, 0x03, 0x3b, 0x14, 0x6d,
+			0x40, 0x80, 0xc0, 0x28, 0x28, 0x28, 0x28, 0x39, 0xc5);
+
 	return 0;
 }
 
@@ -583,7 +604,7 @@ static int s6e3ha2_enable(struct drm_panel *panel)
 	return 0;
 }
 
-static const struct drm_display_mode default_mode = {
+static const struct drm_display_mode s6e3ha2_mode = {
 	.clock = 222372,
 	.hdisplay = 1440,
 	.hsync_start = 1440 + 1,
@@ -597,16 +618,41 @@ static int s6e3ha2_enable(struct drm_panel *panel)
 	.flags = 0,
 };
 
+static const struct s6e3ha2_panel_desc samsung_s6e3ha2 = {
+	.mode = &s6e3ha2_mode,
+	.type = HA2_TYPE,
+};
+
+static const struct drm_display_mode s6e3hf2_mode = {
+	.clock = 247856,
+	.hdisplay = 1600,
+	.hsync_start = 1600 + 1,
+	.hsync_end = 1600 + 1 + 1,
+	.htotal = 1600 + 1 + 1 + 1,
+	.vdisplay = 2560,
+	.vsync_start = 2560 + 1,
+	.vsync_end = 2560 + 1 + 1,
+	.vtotal = 2560 + 1 + 1 + 15,
+	.vrefresh = 60,
+	.flags = 0,
+};
+
+static const struct s6e3ha2_panel_desc samsung_s6e3hf2 = {
+	.mode = &s6e3hf2_mode,
+	.type = HF2_TYPE,
+};
+
 static int s6e3ha2_get_modes(struct drm_panel *panel)
 {
 	struct drm_connector *connector = panel->connector;
+	struct s6e3ha2 *ctx = container_of(panel, struct s6e3ha2, panel);
 	struct drm_display_mode *mode;
 
-	mode = drm_mode_duplicate(panel->drm, &default_mode);
+	mode = drm_mode_duplicate(panel->drm, ctx->desc->mode);
 	if (!mode) {
 		DRM_ERROR("failed to add mode %ux%ux@%u\n",
-				default_mode.hdisplay, default_mode.vdisplay,
-				default_mode.vrefresh);
+			ctx->desc->mode->hdisplay, ctx->desc->mode->vdisplay,
+			ctx->desc->mode->vrefresh);
 		return -ENOMEM;
 	}
 
@@ -642,6 +688,7 @@ static int s6e3ha2_probe(struct mipi_dsi_device *dsi)
 	mipi_dsi_set_drvdata(dsi, ctx);
 
 	ctx->dev = dev;
+	ctx->desc = of_device_get_match_data(dev);
 
 	dsi->lanes = 4;
 	dsi->format = MIPI_DSI_FMT_RGB888;
@@ -717,7 +764,10 @@ static int s6e3ha2_remove(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id s6e3ha2_of_match[] = {
-	{ .compatible = "samsung,s6e3ha2" },
+	{ .compatible = "samsung,s6e3ha2",
+	  .data = &samsung_s6e3ha2 },
+	{ .compatible = "samsung,s6e3hf2",
+	  .data = &samsung_s6e3hf2 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, s6e3ha2_of_match);
-- 
1.9.1
