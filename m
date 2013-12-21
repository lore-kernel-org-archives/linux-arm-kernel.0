From: marvin24@gmx.de (Marc Dietrich)
Date: Sat, 21 Dec 2013 21:38:12 +0100
Subject: [PATCH 1/2] drm/panel: Add support for Samsung LTN101NT05 panel
Message-ID: <f03a644deb858f10affb7b039f9982bac81b02c9.1387656959.git.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Samsung LNT101NT05 10.1" WXVGA panel can be supported by the simple panel
driver.

Cc: linux-fbdev at vger.kernel.org
Cc: dri-devel at lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
This isn't strickly required to get the panel up, but Thierry suggested on IRC to
include it anyway, in case someone else has some use for it.

 .../bindings/panel/samsung,ltn101nt05.txt          |    7 +++++
 drivers/gpu/drm/panel/panel-simple.c               |   27 +++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/panel/samsung,ltn101nt05.txt

diff --git a/Documentation/devicetree/bindings/panel/samsung,ltn101nt05.txt b/Documentation/devicetree/bindings/panel/samsung,ltn101nt05.txt
new file mode 100644
index 0000000..ef522c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/panel/samsung,ltn101nt05.txt
@@ -0,0 +1,7 @@
+Samsung Electronics 10.1" WSVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "samsung,ltn101nt05"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 3e611af..7f9ddb5 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -338,6 +338,28 @@ static const struct panel_desc chunghwa_claa101wb01 = {
 	},
 };
 
+static const struct drm_display_mode samsung_ltn101nt05_mode = {
+	.clock = 54030,
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 24,
+	.hsync_end = 1024 + 24 + 136,
+	.htotal = 1024 + 24 + 136 + 160,
+	.vdisplay = 600,
+	.vsync_start = 600 + 3,
+	.vsync_end = 600 + 3 + 6,
+	.vtotal = 600 + 3 + 6 + 61,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc samsung_ltn101nt05 = {
+	.modes = &samsung_ltn101nt05_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 1024,
+		.height = 600,
+	},
+};
+
 static const struct of_device_id platform_of_match[] = {
 	{
 		.compatible = "auo,b101aw03",
@@ -346,6 +368,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "chunghwa,claa101wb01",
 		.data = &chunghwa_claa101wb01
 	}, {
+		.compatible = "samsung,ltn101nt05",
+		.data = &samsung_ltn101nt05,
+	}, {
 		.compatible = "simple-panel",
 	}, {
 		/* sentinel */
-- 
1.7.9.5
