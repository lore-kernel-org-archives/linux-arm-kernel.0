From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Sun, 26 Aug 2018 13:47:12 -0500
Subject: [PATCH] drm/rockchip: Use struct_size() in devm_kzalloc()
Message-ID: <20180826184712.GA9330@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
	int stuff;
        void *entry[];
};

instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

or, like in this particular case:

size = sizeof(struct foo) + sizeof(void *) * count;
instance = devm_kzalloc(dev, size, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = devm_kzalloc(dev, struct_size(instance, entry, count),
GFP_KERNEL);

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 1359e5c..cf64e4d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -32,6 +32,7 @@
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/component.h>
+#include <linux/overflow.h>
 
 #include <linux/reset.h>
 #include <linux/delay.h>
@@ -1561,7 +1562,6 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	struct drm_device *drm_dev = data;
 	struct vop *vop;
 	struct resource *res;
-	size_t alloc_size;
 	int ret, irq;
 
 	vop_data = of_device_get_match_data(dev);
@@ -1569,8 +1569,8 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 		return -ENODEV;
 
 	/* Allocate vop struct and its vop_win array */
-	alloc_size = sizeof(*vop) + sizeof(*vop->win) * vop_data->win_size;
-	vop = devm_kzalloc(dev, alloc_size, GFP_KERNEL);
+	vop = devm_kzalloc(dev, struct_size(vop, win, vop_data->win_size),
+			   GFP_KERNEL);
 	if (!vop)
 		return -ENOMEM;
 
-- 
2.7.4
