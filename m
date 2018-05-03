From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 May 2018 16:04:31 +0200
Subject: [PATCH v2] drm/pl111: Fix module probe bug
Message-ID: <20180503140431.5798-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- In my stress I missed that if there are several CLCD instances
  on the board the platform_driver_register() call will return
  -EBUSY so we need to ignore that explicitly, all we want is to
  register the driver at least once.
---
 drivers/gpu/drm/pl111/pl111_versatile.c |  7 +++++++
 drivers/gpu/drm/pl111/pl111_vexpress.c  | 12 ++++++++++--
 drivers/gpu/drm/pl111/pl111_vexpress.h  |  7 +++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
index 78ddf8534fd2..ad769e3e9fd3 100644
--- a/drivers/gpu/drm/pl111/pl111_versatile.c
+++ b/drivers/gpu/drm/pl111/pl111_versatile.c
@@ -326,6 +326,13 @@ int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 	if (versatile_clcd_type == VEXPRESS_CLCD_V2M) {
 		struct platform_device *pdev;
 
+		/* Registers a driver for the muxfpga */
+		ret = vexpress_muxfpga_init();
+		if (ret) {
+			dev_err(dev, "unable to intialize muxfpga driver\n");
+			return ret;
+		}
+
 		/* Call into deep Vexpress configuration API */
 		pdev = of_find_device_by_node(np);
 		if (!pdev) {
diff --git a/drivers/gpu/drm/pl111/pl111_vexpress.c b/drivers/gpu/drm/pl111/pl111_vexpress.c
index c9fee625faf1..c30f63cd66a8 100644
--- a/drivers/gpu/drm/pl111/pl111_vexpress.c
+++ b/drivers/gpu/drm/pl111/pl111_vexpress.c
@@ -106,7 +106,6 @@ static int vexpress_muxfpga_probe(struct platform_device *pdev)
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 	dev_set_drvdata(dev, map);
-
 	return 0;
 }
 
@@ -122,4 +121,13 @@ static struct platform_driver vexpress_muxfpga_driver = {
 	.probe = vexpress_muxfpga_probe,
 };
 
-builtin_platform_driver(vexpress_muxfpga_driver);
+int vexpress_muxfpga_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&vexpress_muxfpga_driver);
+	/* -EBUSY just means this driver is already registered */
+	if (ret && ret != -EBUSY)
+		return ret;
+	return 0;
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
