From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 May 2018 15:40:53 +0200
Subject: [PATCH] drm/pl111: Fix module probe bug
Message-ID: <20180503134053.24945-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a30933c27602 ("drm/pl111: Support the Versatile Express")
Added a second module using the builtin_platform_driver() call,
which works fine as long as you do not try to build the PL111
driver as a module, because a module can only have one initcall
and cause the following build bug:

(...) multiple definition of `init_module' (...)

Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: Robin Murphy <robin.murphy@arm.com>
Fixes: a30933c27602 ("drm/pl111: Support the Versatile Express")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_versatile.c | 7 +++++++
 drivers/gpu/drm/pl111/pl111_vexpress.c  | 5 ++++-
 drivers/gpu/drm/pl111/pl111_vexpress.h  | 7 +++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
index 78ddf8534fd2..2f0daab30973 100644
--- a/drivers/gpu/drm/pl111/pl111_versatile.c
+++ b/drivers/gpu/drm/pl111/pl111_versatile.c
@@ -326,6 +326,13 @@ int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 	if (versatile_clcd_type == VEXPRESS_CLCD_V2M) {
 		struct platform_device *pdev;
 
+		/* Registers a driver for the muxfpga */
+		ret = vexpress_muxfpga_init();
+		if (ret) {
+			dev_err(dev, "unable to intialized muxfpga driver\n");
+			return ret;
+		}
+
 		/* Call into deep Vexpress configuration API */
 		pdev = of_find_device_by_node(np);
 		if (!pdev) {
diff --git a/drivers/gpu/drm/pl111/pl111_vexpress.c b/drivers/gpu/drm/pl111/pl111_vexpress.c
index c9fee625faf1..508878c9bd52 100644
--- a/drivers/gpu/drm/pl111/pl111_vexpress.c
+++ b/drivers/gpu/drm/pl111/pl111_vexpress.c
@@ -122,4 +122,7 @@ static struct platform_driver vexpress_muxfpga_driver = {
 	.probe = vexpress_muxfpga_probe,
 };
 
-builtin_platform_driver(vexpress_muxfpga_driver);
+int vexpress_muxfpga_init(void)
+{
+	return platform_driver_register(&vexpress_muxfpga_driver);
+}
diff --git a/drivers/gpu/drm/pl111/pl111_vexpress.h b/drivers/gpu/drm/pl111/pl111_vexpress.h
index 49876417f7b6..40fbe42369dc 100644
--- a/drivers/gpu/drm/pl111/pl111_vexpress.h
+++ b/drivers/gpu/drm/pl111/pl111_vexpress.h
@@ -10,6 +10,8 @@ int pl111_vexpress_clcd_init(struct device *dev,
 			     struct pl111_drm_dev_private *priv,
 			     struct regmap *map);
 
+int vexpress_muxfpga_init(void);
+
 #else
 
 static int inline pl111_vexpress_clcd_init(struct device *dev,
@@ -19,4 +21,9 @@ static int inline pl111_vexpress_clcd_init(struct device *dev,
 	return -ENODEV;
 }
 
+static inline int vexpress_muxfpga_init(void)
+{
+	return 0;
+}
+
 #endif
-- 
2.17.0
