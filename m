From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 13 Nov 2018 16:46:26 +0530
Subject: [PATCH v4 19/26] drm/panel: Add Bananapi S070WV20-CT16 ICN6211
 MIPI-DSI to RGB bridge
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
Message-ID: <20181113111633.20189-20-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB bridge
panel which can be used to connect via DSI port on BPI-M64 board,
so add a driver for it.

The same panel PCB comes with parallel RBG which is supported via
panel-simple driver with "bananapi,s070wv20-ct16" compatible.

BSP dclock of 30MHz is not working with existing sunxi-ng and sun4i
sun4i_dclk_recalc, so updated to 55MHz can result proper working
nkm dividers.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../panel/panel-bananapi-s070wv20-icn6211.c   | 298 ++++++++++++++++++
 4 files changed, 314 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a25549205cc1..f5bb2ffa1089 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4601,6 +4601,12 @@ M:	Dave Airlie <airlied@redhat.com>
 S:	Odd Fixes
 F:	drivers/gpu/drm/ast/
 
+DRM DRIVER FOR BANANAPI S070WV20-CT16 ICN6211 MIPI-DSI TO RGB PANELS
+M:	Jagan Teki <jagan@amarulasolutions.com>
+S:	Maintained
+F:	drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c
+F:	Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
+
 DRM DRIVER FOR BOCHS VIRTUAL GPU
 M:	Gerd Hoffmann <kraxel@redhat.com>
 L:	virtualization at lists.linux-foundation.org
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 6020c30a33b3..20b88c275421 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -17,6 +17,15 @@ config DRM_PANEL_ARM_VERSATILE
 	  reference designs. The panel is detected using special registers
 	  in the Versatile family syscon registers.
 
+config DRM_PANEL_BANANAPI_S070WV20_ICN6211
+	tristate "Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge panel driver"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Bananapi S070WV20-CT16 MIPI-DSI controller.
+
 config DRM_PANEL_LVDS
 	tristate "Generic LVDS panel driver"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 5ccaaa9d13af..04696bb85218 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
+obj-$(CONFIG_DRM_PANEL_BANANAPI_S070WV20_ICN6211) += panel-bananapi-s070wv20-icn6211.o
 obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
 obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
diff --git a/drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c b/drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c
new file mode 100644
index 000000000000..10174495a6c8
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Amarula Solutions
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+struct s070wv20 {
+	struct drm_panel	panel;
+	struct mipi_dsi_device	*dsi;
+
+	struct backlight_device	*backlight;
+	struct regulator	*dvdd;
+	struct regulator	*avdd;
+	struct gpio_desc	*reset;
+};
+
+static inline struct s070wv20 *panel_to_s070wv20(struct drm_panel *panel)
+{
+	return container_of(panel, struct s070wv20, panel);
+}
+
+struct s070wv20_init_cmd {
+	size_t len;
+	const char *data;
+};
+
+#define S070WV20_INIT_CMD(...) { \
+	.len = sizeof((char[]){__VA_ARGS__}), \
+	.data = (char[]){__VA_ARGS__} }
+
+static const struct s070wv20_init_cmd s070wv20_init_cmds[] = {
+	S070WV20_INIT_CMD(0x7A, 0xC1),
+	S070WV20_INIT_CMD(0x20, 0x20),
+	S070WV20_INIT_CMD(0x21, 0xE0),
+	S070WV20_INIT_CMD(0x22, 0x13),
+	S070WV20_INIT_CMD(0x23, 0x28),
+	S070WV20_INIT_CMD(0x24, 0x30),
+	S070WV20_INIT_CMD(0x25, 0x28),
+	S070WV20_INIT_CMD(0x26, 0x00),
+	S070WV20_INIT_CMD(0x27, 0x0D),
+	S070WV20_INIT_CMD(0x28, 0x03),
+	S070WV20_INIT_CMD(0x29, 0x1D),
+	S070WV20_INIT_CMD(0x34, 0x80),
+	S070WV20_INIT_CMD(0x36, 0x28),
+	S070WV20_INIT_CMD(0xB5, 0xA0),
+	S070WV20_INIT_CMD(0x5C, 0xFF),
+	S070WV20_INIT_CMD(0x2A, 0x01),
+	S070WV20_INIT_CMD(0x56, 0x92),
+	S070WV20_INIT_CMD(0x6B, 0x71),
+	S070WV20_INIT_CMD(0x69, 0x2B),
+	S070WV20_INIT_CMD(0x10, 0x40),
+	S070WV20_INIT_CMD(0x11, 0x98),
+	S070WV20_INIT_CMD(0xB6, 0x20),
+	S070WV20_INIT_CMD(0x51, 0x20),
+	S070WV20_INIT_CMD(0x09, 0x10),
+};
+
+static int s070wv20_prepare(struct drm_panel *panel)
+{
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	unsigned int i;
+	int ret;
+
+	msleep(50);
+
+	gpiod_set_value(ctx->reset, 1);
+	msleep(50);
+
+	gpiod_set_value(ctx->reset, 0);
+	msleep(50);
+
+	gpiod_set_value(ctx->reset, 1);
+	msleep(20);
+
+	for (i = 0; i < ARRAY_SIZE(s070wv20_init_cmds); i++) {
+		const struct s070wv20_init_cmd *cmd = &s070wv20_init_cmds[i];
+
+		ret = mipi_dsi_generic_write(dsi, cmd->data, cmd->len);
+		if (ret < 0)
+			return ret;
+
+		msleep(10);
+	}
+
+	return 0;
+}
+
+static int s070wv20_enable(struct drm_panel *panel)
+{
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+
+	msleep(120);
+
+	mipi_dsi_dcs_set_display_on(ctx->dsi);
+	backlight_enable(ctx->backlight);
+
+	return 0;
+}
+
+static int s070wv20_disable(struct drm_panel *panel)
+{
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+
+	backlight_disable(ctx->backlight);
+	return mipi_dsi_dcs_set_display_on(ctx->dsi);
+}
+
+static int s070wv20_unprepare(struct drm_panel *panel)
+{
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+	int ret;
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
+	return 0;
+}
+
+static const struct drm_display_mode s070wv20_default_mode = {
+	.clock = 55000,
+	.vrefresh = 60,
+
+	.hdisplay = 800,
+	.hsync_start = 800 + 40,
+	.hsync_end = 800 + 40 + 48,
+	.htotal = 800 + 40 + 48 + 40,
+
+	.vdisplay = 480,
+	.vsync_start = 480 + 13,
+	.vsync_end = 480 + 13 + 3,
+	.vtotal = 480 + 13 + 3 + 29,
+
+	.width_mm	= 86,
+	.height_mm	= 154,
+};
+
+static int s070wv20_get_modes(struct drm_panel *panel)
+{
+	struct drm_connector *connector = panel->connector;
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(panel->drm, &s070wv20_default_mode);
+	if (!mode) {
+		dev_err(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
+			s070wv20_default_mode.hdisplay,
+			s070wv20_default_mode.vdisplay,
+			s070wv20_default_mode.vrefresh);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_probed_add(connector, mode);
+
+	panel->connector->display_info.width_mm = mode->width_mm;
+	panel->connector->display_info.height_mm = mode->height_mm;
+
+	return 1;
+}
+
+static const struct drm_panel_funcs s070wv20_funcs = {
+	.disable = s070wv20_disable,
+	.unprepare = s070wv20_unprepare,
+	.prepare = s070wv20_prepare,
+	.enable = s070wv20_enable,
+	.get_modes = s070wv20_get_modes,
+};
+
+static int s070wv20_dsi_probe(struct mipi_dsi_device *dsi)
+{
+	struct device_node *np;
+	struct s070wv20 *ctx;
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
+	ctx->panel.funcs = &s070wv20_funcs;
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
+	msleep(5);
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
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->lanes = 4;
+
+	return mipi_dsi_attach(dsi);
+}
+
+static int s070wv20_dsi_remove(struct mipi_dsi_device *dsi)
+{
+	struct s070wv20 *ctx = mipi_dsi_get_drvdata(dsi);
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
+static const struct of_device_id s070wv20_of_match[] = {
+	{ .compatible = "bananapi,s070wv20-ct16-icn6211", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, s070wv20_of_match);
+
+static struct mipi_dsi_driver s070wv20_driver = {
+	.probe = s070wv20_dsi_probe,
+	.remove = s070wv20_dsi_remove,
+	.driver = {
+		.name = "bananapi-s070wv20-ct16-icn6211",
+		.of_match_table = s070wv20_of_match,
+	},
+};
+module_mipi_dsi_driver(s070wv20_driver);
+
+MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
+MODULE_DESCRIPTION("Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0.321.gffc6fa0e3
