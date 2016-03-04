From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Fri,  4 Mar 2016 18:54:28 +0800
Subject: [PATCH v7 02/11] drm/hisilicon: Add hisilicon kirin drm master driver
In-Reply-To: <1457088877-131022-1-git-send-email-xinliang.liu@linaro.org>
References: <1457088877-131022-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1457088877-131022-3-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add kirin DRM master driver for hi6220 SoC which used in HiKey board.
Add dumb buffer feature.
Add prime dmabuf feature.

v7:
- Add config.mutex protection when accessing mode_config.connector_list.
- Clean up match data getting.
v6: None.
v5: None.
v4: None.
v3:
- Move and rename all the files to kirin sub-directory.
  So that we could separate different seires SoCs' driver.
- Replace drm_platform_init, load, unload implementation.
v2:
- Remove abtraction layer.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
---
 drivers/gpu/drm/Kconfig                         |   2 +
 drivers/gpu/drm/Makefile                        |   1 +
 drivers/gpu/drm/hisilicon/Kconfig               |   5 +
 drivers/gpu/drm/hisilicon/Makefile              |   5 +
 drivers/gpu/drm/hisilicon/kirin/Kconfig         |   9 +
 drivers/gpu/drm/hisilicon/kirin/Makefile        |   3 +
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 309 ++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  20 ++
 8 files changed, 354 insertions(+)
 create mode 100644 drivers/gpu/drm/hisilicon/Kconfig
 create mode 100644 drivers/gpu/drm/hisilicon/Makefile
 create mode 100644 drivers/gpu/drm/hisilicon/kirin/Kconfig
 create mode 100644 drivers/gpu/drm/hisilicon/kirin/Makefile
 create mode 100644 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
 create mode 100644 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index b50ae60f5f50..f5c5656e2547 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -277,3 +277,5 @@ source "drivers/gpu/drm/imx/Kconfig"
 source "drivers/gpu/drm/vc4/Kconfig"
 
 source "drivers/gpu/drm/etnaviv/Kconfig"
+
+source "drivers/gpu/drm/hisilicon/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 61766dec6a8d..60554832079c 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -74,3 +74,4 @@ obj-y			+= panel/
 obj-y			+= bridge/
 obj-$(CONFIG_DRM_FSL_DCU) += fsl-dcu/
 obj-$(CONFIG_DRM_ETNAVIV) += etnaviv/
+obj-y			+= hisilicon/
diff --git a/drivers/gpu/drm/hisilicon/Kconfig b/drivers/gpu/drm/hisilicon/Kconfig
new file mode 100644
index 000000000000..558c61b1b8e8
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/Kconfig
@@ -0,0 +1,5 @@
+#
+# hisilicon drm device configuration.
+# Please keep this list sorted alphabetically
+
+source "drivers/gpu/drm/hisilicon/kirin/Kconfig"
diff --git a/drivers/gpu/drm/hisilicon/Makefile b/drivers/gpu/drm/hisilicon/Makefile
new file mode 100644
index 000000000000..e3f6d493c996
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for hisilicon drm drivers.
+# Please keep this list sorted alphabetically
+
+obj-$(CONFIG_DRM_HISI_KIRIN) += kirin/
diff --git a/drivers/gpu/drm/hisilicon/kirin/Kconfig b/drivers/gpu/drm/hisilicon/kirin/Kconfig
new file mode 100644
index 000000000000..3ac4b8edeac1
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/kirin/Kconfig
@@ -0,0 +1,9 @@
+config DRM_HISI_KIRIN
+	tristate "DRM Support for Hisilicon Kirin series SoCs Platform"
+	depends on DRM
+	select DRM_KMS_HELPER
+	select DRM_GEM_CMA_HELPER
+	select DRM_KMS_CMA_HELPER
+	help
+	  Choose this option if you have a hisilicon Kirin chipsets(hi6220).
+	  If M is selected the module will be called kirin-drm.
diff --git a/drivers/gpu/drm/hisilicon/kirin/Makefile b/drivers/gpu/drm/hisilicon/kirin/Makefile
new file mode 100644
index 000000000000..cb346de47d48
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/kirin/Makefile
@@ -0,0 +1,3 @@
+kirin-drm-y := kirin_drm_drv.o
+
+obj-$(CONFIG_DRM_HISI_KIRIN) += kirin-drm.o
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
new file mode 100644
index 000000000000..976c9b1a3fd3
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -0,0 +1,309 @@
+/*
+ * Hisilicon Kirin SoCs drm master driver
+ *
+ * Copyright (c) 2016 Linaro Limited.
+ * Copyright (c) 2014-2016 Hisilicon Limited.
+ *
+ * Author:
+ *	Xinliang Liu <z.liuxinliang@hisilicon.com>
+ *	Xinliang Liu <xinliang.liu@linaro.org>
+ *	Xinwei Kong <kong.kongxinwei@hisilicon.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/of_platform.h>
+#include <linux/component.h>
+#include <linux/of_graph.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_atomic_helper.h>
+
+#include "kirin_drm_drv.h"
+
+static struct kirin_dc_ops *dc_ops;
+
+static int kirin_drm_kms_cleanup(struct drm_device *dev)
+{
+	dc_ops->cleanup(dev);
+	drm_mode_config_cleanup(dev);
+
+	return 0;
+}
+
+static const struct drm_mode_config_funcs kirin_drm_mode_config_funcs = {
+	.fb_create = drm_fb_cma_create,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+static void kirin_drm_mode_config_init(struct drm_device *dev)
+{
+	dev->mode_config.min_width = 0;
+	dev->mode_config.min_height = 0;
+
+	dev->mode_config.max_width = 2048;
+	dev->mode_config.max_height = 2048;
+
+	dev->mode_config.funcs = &kirin_drm_mode_config_funcs;
+}
+
+static int kirin_drm_kms_init(struct drm_device *dev)
+{
+	int ret;
+
+	dev_set_drvdata(dev->dev, dev);
+
+	/* dev->mode_config initialization */
+	drm_mode_config_init(dev);
+	kirin_drm_mode_config_init(dev);
+
+	/* display controller init */
+	ret = dc_ops->init(dev);
+	if (ret)
+		goto err_mode_config_cleanup;
+
+	/* bind and init sub drivers */
+	ret = component_bind_all(dev->dev, dev);
+	if (ret) {
+		DRM_ERROR("failed to bind all component.\n");
+		goto err_dc_cleanup;
+	}
+
+	/* reset all the states of crtc/plane/encoder/connector */
+	drm_mode_config_reset(dev);
+
+	return 0;
+
+err_dc_cleanup:
+	dc_ops->cleanup(dev);
+err_mode_config_cleanup:
+	drm_mode_config_cleanup(dev);
+
+	return ret;
+}
+
+static const struct file_operations kirin_drm_fops = {
+	.owner		= THIS_MODULE,
+	.open		= drm_open,
+	.release	= drm_release,
+	.unlocked_ioctl	= drm_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= drm_compat_ioctl,
+#endif
+	.poll		= drm_poll,
+	.read		= drm_read,
+	.llseek		= no_llseek,
+	.mmap		= drm_gem_cma_mmap,
+};
+
+static int kirin_gem_cma_dumb_create(struct drm_file *file,
+				     struct drm_device *dev,
+				     struct drm_mode_create_dumb *args)
+{
+	return drm_gem_cma_dumb_create_internal(file, dev, args);
+}
+
+static struct drm_driver kirin_drm_driver = {
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME |
+				  DRIVER_ATOMIC,
+	.fops			= &kirin_drm_fops,
+	.set_busid		= drm_platform_set_busid,
+
+	.gem_free_object	= drm_gem_cma_free_object,
+	.gem_vm_ops		= &drm_gem_cma_vm_ops,
+	.dumb_create		= kirin_gem_cma_dumb_create,
+	.dumb_map_offset	= drm_gem_cma_dumb_map_offset,
+	.dumb_destroy		= drm_gem_dumb_destroy,
+
+	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
+	.gem_prime_export	= drm_gem_prime_export,
+	.gem_prime_import	= drm_gem_prime_import,
+	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
+	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
+	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
+	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
+	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
+
+	.name			= "kirin",
+	.desc			= "Hisilicon Kirin SoCs' DRM Driver",
+	.date			= "20150718",
+	.major			= 1,
+	.minor			= 0,
+};
+
+static int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static int kirin_drm_connectors_register(struct drm_device *dev)
+{
+	struct drm_connector *connector;
+	struct drm_connector *failed_connector;
+	int ret;
+
+	mutex_lock(&dev->mode_config.mutex);
+	drm_for_each_connector(connector, dev) {
+		ret = drm_connector_register(connector);
+		if (ret) {
+			failed_connector = connector;
+			goto err;
+		}
+	}
+	mutex_unlock(&dev->mode_config.mutex);
+
+	return 0;
+
+err:
+	drm_for_each_connector(connector, dev) {
+		if (failed_connector == connector)
+			break;
+		drm_connector_unregister(connector);
+	}
+	mutex_unlock(&dev->mode_config.mutex);
+
+	return ret;
+}
+
+static int kirin_drm_bind(struct device *dev)
+{
+	struct drm_driver *driver = &kirin_drm_driver;
+	struct drm_device *drm_dev;
+	int ret;
+
+	drm_dev = drm_dev_alloc(driver, dev);
+	if (!drm_dev)
+		return -ENOMEM;
+
+	drm_dev->platformdev = to_platform_device(dev);
+
+	ret = kirin_drm_kms_init(drm_dev);
+	if (ret)
+		goto err_drm_dev_unref;
+
+	ret = drm_dev_register(drm_dev, 0);
+	if (ret)
+		goto err_kms_cleanup;
+
+	/* connectors should be registered after drm device register */
+	ret = kirin_drm_connectors_register(drm_dev);
+	if (ret)
+		goto err_drm_dev_unregister;
+
+	DRM_INFO("Initialized %s %d.%d.%d %s on minor %d\n",
+		 driver->name, driver->major, driver->minor, driver->patchlevel,
+		 driver->date, drm_dev->primary->index);
+
+	return 0;
+
+err_drm_dev_unregister:
+	drm_dev_unregister(drm_dev);
+err_kms_cleanup:
+	kirin_drm_kms_cleanup(drm_dev);
+err_drm_dev_unref:
+	drm_dev_unref(drm_dev);
+
+	return ret;
+}
+
+static void kirin_drm_unbind(struct device *dev)
+{
+	drm_put_dev(dev_get_drvdata(dev));
+}
+
+static const struct component_master_ops kirin_drm_ops = {
+	.bind = kirin_drm_bind,
+	.unbind = kirin_drm_unbind,
+};
+
+static struct device_node *kirin_get_remote_node(struct device_node *np)
+{
+	struct device_node *endpoint, *remote;
+
+	/* get the first endpoint, in our case only one remote node
+	 * is connected to display controller.
+	 */
+	endpoint = of_graph_get_next_endpoint(np, NULL);
+	if (!endpoint) {
+		DRM_ERROR("no valid endpoint node\n");
+		return ERR_PTR(-ENODEV);
+	}
+	of_node_put(endpoint);
+
+	remote = of_graph_get_remote_port_parent(endpoint);
+	if (!remote) {
+		DRM_ERROR("no valid remote node\n");
+		return ERR_PTR(-ENODEV);
+	}
+	of_node_put(remote);
+
+	if (!of_device_is_available(remote)) {
+		DRM_ERROR("not available for remote node\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	return remote;
+}
+
+static int kirin_drm_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct component_match *match = NULL;
+	struct device_node *remote;
+
+	dc_ops = (struct kirin_dc_ops *)of_device_get_match_data(dev);
+	if (!dc_ops) {
+		DRM_ERROR("failed to get dt id data\n");
+		return -EINVAL;
+	}
+
+	remote = kirin_get_remote_node(np);
+	if (IS_ERR(remote))
+		return PTR_ERR(remote);
+
+	component_match_add(dev, &match, compare_of, remote);
+
+	return component_master_add_with_match(dev, &kirin_drm_ops, match);
+
+	return 0;
+}
+
+static int kirin_drm_platform_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &kirin_drm_ops);
+	dc_ops = NULL;
+	return 0;
+}
+
+static const struct of_device_id kirin_drm_dt_ids[] = {
+	{ .compatible = "hisilicon,hi6220-ade",
+	  .data = &ade_dc_ops,
+	},
+	{ /* end node */ },
+};
+MODULE_DEVICE_TABLE(of, kirin_drm_dt_ids);
+
+static struct platform_driver kirin_drm_platform_driver = {
+	.probe = kirin_drm_platform_probe,
+	.remove = kirin_drm_platform_remove,
+	.driver = {
+		.name = "kirin-drm",
+		.of_match_table = kirin_drm_dt_ids,
+	},
+};
+
+module_platform_driver(kirin_drm_platform_driver);
+
+MODULE_AUTHOR("Xinliang Liu <xinliang.liu@linaro.org>");
+MODULE_AUTHOR("Xinliang Liu <z.liuxinliang@hisilicon.com>");
+MODULE_AUTHOR("Xinwei Kong <kong.kongxinwei@hisilicon.com>");
+MODULE_DESCRIPTION("hisilicon Kirin SoCs' DRM master driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
new file mode 100644
index 000000000000..75e9d82356d4
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright (c) 2016 Linaro Limited.
+ * Copyright (c) 2014-2016 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __KIRIN_DRM_DRV_H__
+#define __KIRIN_DRM_DRV_H__
+
+/* display controller init/cleanup ops */
+struct kirin_dc_ops {
+	int (*init)(struct drm_device *dev);
+	void (*cleanup)(struct drm_device *dev);
+};
+
+#endif /* __KIRIN_DRM_DRV_H__ */
-- 
2.7.1
