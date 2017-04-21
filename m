From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 21 Apr 2017 16:38:53 +0800
Subject: [PATCH v2 5/9] drm/sun4i: backend: Save pointer to device tree node
In-Reply-To: <20170421083857.29636-1-wens@csie.org>
References: <20170421083857.29636-1-wens@csie.org>
Message-ID: <20170421083857.29636-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save a pointer to the backend's underlying device tree node in its
data structure. This will be used later for downstream tcons to find
and match their respective upstream backends.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 1 +
 drivers/gpu/drm/sun4i/sun4i_backend.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 0b4222312e49..e9eca057ff35 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -352,6 +352,7 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 		return -ENOMEM;
 	dev_set_drvdata(dev, backend);
 
+	backend->node = dev->of_node;
 	backend->id = sun4i_backend_of_get_id(dev->of_node);
 	if (backend->id < 0)
 		return backend->id;
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 45b7fc110590..6327a2985fe6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -15,6 +15,7 @@
 
 #include <linux/clk.h>
 #include <linux/list.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -140,6 +141,7 @@
 #define SUN4I_BACKEND_PIPE_OFF(p)		(0x5000 + (0x400 * (p)))
 
 struct sun4i_backend {
+	struct device_node	*node;
 	struct regmap		*regs;
 
 	struct reset_control	*reset;
-- 
2.11.0
