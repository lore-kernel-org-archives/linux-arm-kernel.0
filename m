From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 10 Jul 2018 11:24:19 +0100
Subject: [PATCH 2/3] drm/armada: add OF reserved memory support
In-Reply-To: <20180710102344.GH17271@n2100.armlinux.org.uk>
References: <20180710102344.GH17271@n2100.armlinux.org.uk>
Message-ID: <E1fcpoh-0003Z2-BB@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Existing Armada DRM makes use of reserved memory for allocating
contiguous screen buffers, which currently prevents its use with
DT systems.  Add support for this for DT systems.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/armada/Makefile      |  3 +++
 drivers/gpu/drm/armada/armada_drv.c  | 24 ++++++++++++++++--
 drivers/gpu/drm/armada/armada_rmem.c | 49 ++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/armada/armada_rmem.c

diff --git a/drivers/gpu/drm/armada/Makefile b/drivers/gpu/drm/armada/Makefile
index ecf25cf9f9f5..0b8bf3b8aa6a 100644
--- a/drivers/gpu/drm/armada/Makefile
+++ b/drivers/gpu/drm/armada/Makefile
@@ -5,3 +5,6 @@ armada-y	+= armada_510.o
 armada-$(CONFIG_DEBUG_FS) += armada_debugfs.o
 
 obj-$(CONFIG_DRM_ARMADA) := armada.o
+
+armada-rmem-$(CONFIG_DRM_ARMADA) += armada_rmem.o
+obj-y += $(armada-rmem-y) $(armada-rmem-m)
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 217f0590fd61..a9ee492a2810 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -9,6 +9,7 @@
 #include <linux/component.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
+#include <linux/of_reserved_mem.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_of.h>
@@ -96,6 +97,9 @@ static int armada_drm_bind(struct device *dev)
 			return -EINVAL;
 	}
 
+	if (!mem && dev->of_node)
+		mem = dev->platform_data;
+
 	if (!mem)
 		return -ENXIO;
 
@@ -250,9 +254,17 @@ static int armada_drm_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	ret = drm_of_component_probe(dev, compare_dev_name, &armada_master_ops);
-	if (ret != -EINVAL)
+	if (dev->of_node) {
+		ret = of_reserved_mem_device_init(dev);
+		if (ret && ret != -ENODEV)
+			return ret;
+
+		ret = drm_of_component_probe(dev, compare_of,
+					     &armada_master_ops);
+		if (ret)
+			of_reserved_mem_device_release(dev);
 		return ret;
+	}
 
 	if (dev->platform_data) {
 		char **devices = dev->platform_data;
@@ -287,6 +299,7 @@ static int armada_drm_probe(struct platform_device *pdev)
 static int armada_drm_remove(struct platform_device *pdev)
 {
 	component_master_del(&pdev->dev, &armada_master_ops);
+	of_reserved_mem_device_release(&pdev->dev);
 	return 0;
 }
 
@@ -300,11 +313,18 @@ static const struct platform_device_id armada_drm_platform_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, armada_drm_platform_ids);
 
+static const struct of_device_id armada_drm_dt_ids[] = {
+	{ .compatible = "marvell,dove-display-subsystem", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, armada_drm_dt_ids);
+
 static struct platform_driver armada_drm_platform_driver = {
 	.probe	= armada_drm_probe,
 	.remove	= armada_drm_remove,
 	.driver	= {
 		.name	= "armada-drm",
+		.of_match_table = armada_drm_dt_ids,
 	},
 	.id_table = armada_drm_platform_ids,
 };
diff --git a/drivers/gpu/drm/armada/armada_rmem.c b/drivers/gpu/drm/armada/armada_rmem.c
new file mode 100644
index 000000000000..36bb20e426b6
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_rmem.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2017 Russell King
+#include <linux/errno.h>
+#include <linux/of.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/slab.h>
+
+static int armada_rmem_dev_init(struct reserved_mem *rmem, struct device *dev)
+{
+	struct resource *r;
+
+	if (dev->platform_data)
+		return -EBUSY;
+
+	r = kzalloc(sizeof(*r), GFP_KERNEL);
+	if (!r)
+		return -ENOMEM;
+
+	r->start = rmem->base;
+	r->end = rmem->base + rmem->size - 1;
+	r->flags = IORESOURCE_MEM;
+
+	rmem->priv = r;
+	dev->platform_data = r;
+
+	return 0;
+}
+
+static void armada_rmem_dev_release(struct reserved_mem *rmem,
+	struct device *dev)
+{
+	kfree(rmem->priv);
+	rmem->priv = NULL;
+	dev->platform_data = NULL;
+}
+
+static const struct reserved_mem_ops armada_rmem_ops = {
+	.device_init = armada_rmem_dev_init,
+	.device_release = armada_rmem_dev_release,
+};
+
+static int __init armada_rmem_init(struct reserved_mem *rmem)
+{
+	rmem->ops = &armada_rmem_ops;
+	return 0;
+}
+
+RESERVEDMEM_OF_DECLARE(armada_rmem, "marvell,dove-framebuffer",
+			armada_rmem_init);
-- 
2.7.4
