From: jagan@amarulasolutions.com (Jagan Teki)
Date: Sat,  3 Nov 2018 15:38:59 +0530
Subject: [PATCH 09/10] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD
 panel
In-Reply-To: <20181103100900.30313-1-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
Message-ID: <20181103100900.30313-10-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.

Add panel driver for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note: init sequence is referenced from 
https://github.com/longsleep/linux-pine64/blob/pine64-hacks-1.2/drivers/video/sunxi/disp2/disp/lcd/mb709_mipi.c

 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-feiyang-fy07024di26a30d.c | 305 ++++++++++++++++++
 3 files changed, 315 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index d0d4e60f5153..bc70896fe43c 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -47,6 +47,15 @@ config DRM_PANEL_SIMPLE
 	  that it can be automatically turned off when the panel goes into a
 	  low power state.
 
+config DRM_PANEL_FEIYANG_FY07024DI26A30D
+	tristate "Feiyang FY07024DI26A30-D MIPI-DSI LCD panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Feiyang FY07024DI26A30-D MIPI-DSI interface.
+
 config DRM_PANEL_ILITEK_IL9322
 	tristate "Ilitek ILI9322 320x240 QVGA panels"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 88011f06edb8..e23c017639c7 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
 obj-$(CONFIG_DRM_PANEL_BANANAPI_S070WV20_ICN6211) += panel-bananapi-s070wv20-icn6211.o
 obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
 obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
+obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
 obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
new file mode 100644
index 000000000000..718631a72d8b
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2018 Amarula Solutions
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fb.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+#include <video/mipi_display.h>
+
+struct fy07024di26a30d {
+	struct drm_panel	panel;
+	struct mipi_dsi_device	*dsi;
+
+	struct backlight_device	*backlight;
+	struct regulator	*dvdd;
+	struct regulator	*avdd;
+	struct gpio_desc	*reset;
+
+	bool			is_enabled;
+	bool			is_prepared;
+};
+
+static inline struct fy07024di26a30d *panel_to_fy07024di26a30d(struct drm_panel *panel)
+{
+	return container_of(panel, struct fy07024di26a30d, panel);
+}
+
+struct fy07024di26a30d_init_cmd {
+	size_t len;
+	const char *data;
+};
+
+#define FY07024DI26A30D(...) { \
+	.len = sizeof((char[]){__VA_ARGS__}), \
+	.data = (char[]){__VA_ARGS__} }
+
+static const struct fy07024di26a30d_init_cmd fy07024di26a30d_init_cmds[] = {
+	FY07024DI26A30D(0x80, 0x58),
+	FY07024DI26A30D(0x81, 0x47),
+	FY07024DI26A30D(0x82, 0xD4),
+	FY07024DI26A30D(0x83, 0x88),
+	FY07024DI26A30D(0x84, 0xA9),
+	FY07024DI26A30D(0x85, 0xC3),
+	FY07024DI26A30D(0x86, 0x82),
+};
+
+static int fy07024di26a30d_prepare(struct drm_panel *panel)
+{
+	struct fy07024di26a30d *ctx = panel_to_fy07024di26a30d(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	unsigned int i;
+	int ret;
+
+	if (ctx->is_prepared)
+		return 0;
+
+	gpiod_set_value(ctx->reset, 1);
+	msleep(50);
+
+	gpiod_set_value(ctx->reset, 0);
+	msleep(20);
+
+	gpiod_set_value(ctx->reset, 1);
+	msleep(200);
+
+	for (i = 0; i < ARRAY_SIZE(fy07024di26a30d_init_cmds); i++) {
+		const struct fy07024di26a30d_init_cmd *cmd =
+						&fy07024di26a30d_init_cmds[i];
+
+		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, cmd->len);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0) {
+		dev_err(panel->dev, "failed to set display on: %d\n", ret);
+		return ret;
+	}
+
+	ctx->is_prepared = true;
+
+	return 0;
+}
+
+static int fy07024di26a30d_enable(struct drm_panel *panel)
+{
+	struct fy07024di26a30d *ctx = panel_to_fy07024di26a30d(panel);
+
+	if (ctx->is_enabled)
+		return 0;
+
+	msleep(120);
+
+	backlight_enable(ctx->backlight);
+	ctx->is_enabled = true;
+
+	return 0;
+}
+
+static int fy07024di26a30d_disable(struct drm_panel *panel)
+{
+	struct fy07024di26a30d *ctx = panel_to_fy07024di26a30d(panel);
+
+	if (!ctx->is_enabled)
+		return 0;
+
+	backlight_disable(ctx->backlight);
+	ctx->is_enabled = false;
+
+	return 0;
+}
+
+static int fy07024di26a30d_unprepare(struct drm_panel *panel)
+{
+	struct fy07024di26a30d *ctx = panel_to_fy07024di26a30d(panel);
+	int ret;
+
+	if (!ctx->is_prepared)
+		return 0;
+
+	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
+	if (ret < 0)
+		dev_err(panel->dev, "failed to set display off: %d\n", ret);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
+	if (ret < 0)
+		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
+
+	msleep(100);
+
+	regulator_disable(ctx->avdd);
+
+	regulator_disable(ctx->dvdd);
+
+	gpiod_set_value(ctx->reset, 0);
+
+	gpiod_set_value(ctx->reset, 1);
+
+	gpiod_set_value(ctx->reset, 0);
+
+	ctx->is_prepared = false;
+
+	return 0;
+}
+
+static const struct drm_display_mode fy07024di26a30d_default_mode = {
+	.clock = 55000,
+	.vrefresh = 60,
+
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 396,
+	.hsync_end = 1024 + 396 + 20,
+	.htotal = 1024 + 396 + 20 + 100,
+
+	.vdisplay = 600,
+	.vsync_start = 600 + 12,
+	.vsync_end = 600 + 12 + 2,
+	.vtotal = 600 + 12 + 2 + 21,
+};
+
+static int fy07024di26a30d_get_modes(struct drm_panel *panel)
+{
+	struct drm_connector *connector = panel->connector;
+	struct fy07024di26a30d *ctx = panel_to_fy07024di26a30d(panel);
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(panel->drm, &fy07024di26a30d_default_mode);
+	if (!mode) {
+		dev_err(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
+			fy07024di26a30d_default_mode.hdisplay,
+			fy07024di26a30d_default_mode.vdisplay,
+			fy07024di26a30d_default_mode.vrefresh);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static const struct drm_panel_funcs fy07024di26a30d_funcs = {
+	.disable = fy07024di26a30d_disable,
+	.unprepare = fy07024di26a30d_unprepare,
+	.prepare = fy07024di26a30d_prepare,
+	.enable = fy07024di26a30d_enable,
+	.get_modes = fy07024di26a30d_get_modes,
+};
+
+static int fy07024di26a30d_dsi_probe(struct mipi_dsi_device *dsi)
+{
+	struct device_node *np;
+	struct fy07024di26a30d *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	mipi_dsi_set_drvdata(dsi, ctx);
+	ctx->dsi = dsi;
+
+	drm_panel_init(&ctx->panel);
+	ctx->panel.dev = &dsi->dev;
+	ctx->panel.funcs = &fy07024di26a30d_funcs;
+
+	ctx->dvdd = devm_regulator_get(&dsi->dev, "dvdd");
+	if (IS_ERR(ctx->dvdd)) {
+		dev_err(&dsi->dev, "Couldn't get dvdd regulator\n");
+		return PTR_ERR(ctx->dvdd);
+	}
+
+	ctx->avdd = devm_regulator_get(&dsi->dev, "avdd");
+	if (IS_ERR(ctx->avdd)) {
+		dev_err(&dsi->dev, "Couldn't get avdd regulator\n");
+		return PTR_ERR(ctx->avdd);
+	}
+
+	ret = regulator_enable(ctx->dvdd);
+	if (ret)
+		return ret;
+
+	msleep(100);
+
+	ret = regulator_enable(ctx->avdd);
+	if (ret)
+		return ret;
+
+	msleep(5);
+
+	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset)) {
+		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
+		return PTR_ERR(ctx->reset);
+	}
+
+	np = of_parse_phandle(dsi->dev.of_node, "backlight", 0);
+	if (np) {
+		ctx->backlight = of_find_backlight_by_node(np);
+		of_node_put(np);
+
+		if (!ctx->backlight)
+			return -EPROBE_DEFER;
+	}
+
+	ret = drm_panel_add(&ctx->panel);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->lanes = 4;
+
+	return mipi_dsi_attach(dsi);
+}
+
+static int fy07024di26a30d_dsi_remove(struct mipi_dsi_device *dsi)
+{
+	struct fy07024di26a30d *ctx = mipi_dsi_get_drvdata(dsi);
+
+	mipi_dsi_detach(dsi);
+	drm_panel_remove(&ctx->panel);
+
+	if (ctx->backlight)
+		put_device(&ctx->backlight->dev);
+
+	return 0;
+}
+
+static const struct of_device_id fy07024di26a30d_of_match[] = {
+	{ .compatible = "feiyang,fy07024di26a30d", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, fy07024di26a30d_of_match);
+
+static struct mipi_dsi_driver fy07024di26a30d_driver = {
+	.probe = fy07024di26a30d_dsi_probe,
+	.remove = fy07024di26a30d_dsi_remove,
+	.driver = {
+		.name = "feiyang-fy07024di26a30d",
+		.of_match_table = fy07024di26a30d_of_match,
+	},
+};
+module_mipi_dsi_driver(fy07024di26a30d_driver);
+
+MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
+MODULE_DESCRIPTION("Feiyang FY07024DI26A30-D MIPI-DSI LCD panel");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0.321.gffc6fa0e3
