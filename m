From: kong.kongxinwei@hisilicon.com (Xinwei Kong)
Date: Tue, 15 Sep 2015 17:37:08 +0800
Subject: [PATCH RFC 2/8] drm: hisilicon: Add new DRM driver for hisilicon Soc
In-Reply-To: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <1442309834-21420-3-git-send-email-kong.kongxinwei@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch creates this driver itself and register all the sub-components
which is from DTS inode, this driver uses components framework mechanism
to bind all the sub-components.

This patch also introduces a memory manager for hisilison drm. As cma
framebuffer helpers can no more be used.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Jiwen Qi <qijiwen@hisilicon.com>
Signed-off-by: Yu Gong <gongyu@hisilicon.com>
---
 arch/arm64/configs/defconfig             |   5 +
 drivers/gpu/drm/Kconfig                  |   2 +
 drivers/gpu/drm/Makefile                 |   1 +
 drivers/gpu/drm/hisilicon/Kconfig        |   9 ++
 drivers/gpu/drm/hisilicon/Makefile       |   7 ++
 drivers/gpu/drm/hisilicon/hisi_ade.c     | 166 +++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_drv.c | 206 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_dsi.c | 131 ++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_fb.c  | 156 +++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_fb.h  |  26 ++++
 10 files changed, 709 insertions(+)
 create mode 100644 drivers/gpu/drm/hisilicon/Kconfig
 create mode 100644 drivers/gpu/drm/hisilicon/Makefile
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_ade.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_drv.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_fb.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_fb.h

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4e17e7e..c2ea280 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -146,6 +146,8 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_SYSCON=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+
+
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
@@ -199,3 +201,6 @@ CONFIG_CRYPTO_GHASH_ARM64_CE=y
 CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
 CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
 CONFIG_CRYPTO_AES_ARM64_NEON_BLK=y
+CONFIG_DRM=y
+CONFIG_DRM_HISI=y
+# CONFIG_DRM_HISI_FBDEV is not set
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index c46ca31..31ee120 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -240,3 +240,5 @@ source "drivers/gpu/drm/sti/Kconfig"
 source "drivers/gpu/drm/amd/amdkfd/Kconfig"
 
 source "drivers/gpu/drm/imx/Kconfig"
+
+source "drivers/gpu/drm/hisilicon/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 5713d05..47936d4 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_DRM_MSM) += msm/
 obj-$(CONFIG_DRM_TEGRA) += tegra/
 obj-$(CONFIG_DRM_STI) += sti/
 obj-$(CONFIG_DRM_IMX) += imx/
+obj-$(CONFIG_DRM_HISI) += hisilicon/
 obj-y			+= i2c/
 obj-y			+= panel/
 obj-y			+= bridge/
diff --git a/drivers/gpu/drm/hisilicon/Kconfig b/drivers/gpu/drm/hisilicon/Kconfig
new file mode 100644
index 0000000..60b42e4
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/Kconfig
@@ -0,0 +1,9 @@
+config DRM_HISI
+	tristate "DRM Support for Hisilicon Terminal SoCs Platform"
+	depends on DRM
+	select DRM_KMS_HELPER
+	select DRM_GEM_CMA_HELPER
+	help
+	  Choose this option if you have a hisilicon terminal chipset.
+	  If M is selected the module will be called hisi-drm.
+
diff --git a/drivers/gpu/drm/hisilicon/Makefile b/drivers/gpu/drm/hisilicon/Makefile
new file mode 100644
index 0000000..3f042fd
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/Makefile
@@ -0,0 +1,7 @@
+hisi-drm-y := hisi_drm_drv.o \
+	      hisi_ade.o \
+	      hisi_drm_dsi.o \
+	      hisi_drm_fb.o \
+
+obj-$(CONFIG_DRM_HISI)	+= hisi-drm.o
+
diff --git a/drivers/gpu/drm/hisilicon/hisi_ade.c b/drivers/gpu/drm/hisilicon/hisi_ade.c
new file mode 100644
index 0000000..9b58d20
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_ade.c
@@ -0,0 +1,166 @@
+/*
+ * Hisilicon Terminal SoCs drm driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: Xinwei Kong <kong.kongxinwei@hisilicon.com> for hisilicon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/component.h>
+
+#include <drm/drm_gem_cma_helper.h>
+
+struct ade_hardware_context {
+	void __iomem  *base;
+	void __iomem  *media_base;
+
+	int irq;
+	u32 ade_core_rate;
+	u32 media_noc_rate;
+
+	struct clk *ade_core_clk;
+	struct clk *media_noc_clk;
+	struct clk *ade_pix_clk;
+	bool power_on;
+};
+
+struct hisi_ade {
+	struct ade_hardware_context ctx;
+};
+
+static int ade_dts_parse(struct platform_device *pdev,
+			 struct ade_hardware_context *ctx)
+{
+	struct resource *res;
+	struct device *dev;
+	struct device_node *np;
+	int ret;
+
+	dev = &pdev->dev;
+	np  = dev->of_node;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ade_base");
+	ctx->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctx->base)) {
+		DRM_ERROR("failed to remap ade io base\n");
+		return  PTR_ERR(ctx->base);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "media_base");
+	ctx->media_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctx->media_base)) {
+		DRM_ERROR("failed to remap media io base\n");
+		return PTR_ERR(ctx->media_base);
+	}
+
+	ctx->irq = platform_get_irq(pdev, 0);
+	if (ctx->irq < 0) {
+		DRM_ERROR("failed to parse the irq\n");
+		return -ENODEV;
+	}
+
+	ctx->ade_core_clk = devm_clk_get(&pdev->dev, "clk_ade_core");
+	if (!ctx->ade_core_clk) {
+		DRM_ERROR("failed to parse the ade core clock\n");
+		return -ENODEV;
+	}
+	ctx->media_noc_clk = devm_clk_get(&pdev->dev,
+					"aclk_codec_jpeg_src");
+	if (!ctx->media_noc_clk) {
+		DRM_ERROR("failed to parse the codec jpeg\n");
+	    return -ENODEV;
+	}
+	ctx->ade_pix_clk = devm_clk_get(&pdev->dev, "clk_ade_pix");
+	if (!ctx->ade_pix_clk) {
+		DRM_ERROR("failed to parse the ade pixel src\n");
+	    return -ENODEV;
+	}
+
+	ret = of_property_read_u32(np, "ade_core_clk_rate",
+				   &ctx->ade_core_rate);
+	if (ret) {
+		DRM_ERROR("failed to parse the ade core clk rate\n");
+	    return -ENODEV;
+	}
+	ret = of_property_read_u32(np, "media_noc_clk_rate",
+				   &ctx->media_noc_rate);
+	if (ret) {
+		DRM_ERROR("failed to parse the media noc clk rate\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int ade_bind(struct device *dev, struct device *master, void *data)
+{
+	return 0;
+}
+
+static void ade_unbind(struct device *dev, struct device *master,
+		       void *data)
+{
+	/* do nothing */
+}
+
+static const struct component_ops ade_ops = {
+	.bind	= ade_bind,
+	.unbind	= ade_unbind,
+};
+
+static int ade_probe(struct platform_device *pdev)
+{
+	struct hisi_ade *ade;
+	int ret;
+
+	ade = devm_kzalloc(&pdev->dev, sizeof(*ade), GFP_KERNEL);
+	if (!ade) {
+		DRM_ERROR("failed to alloc hisi_ade\n");
+		return -ENOMEM;
+	}
+
+	ret = ade_dts_parse(pdev, &ade->ctx);
+	if (ret) {
+		DRM_ERROR("failed to parse ade dts!\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, ade);
+
+	return component_add(&pdev->dev, &ade_ops);
+}
+
+static int ade_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &ade_ops);
+
+	return 0;
+}
+
+static const struct of_device_id ade_of_match[] = {
+	{ .compatible = "hisilicon,hi6220-ade" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ade_of_match);
+
+static struct platform_driver ade_driver = {
+	.probe = ade_probe,
+	.remove = ade_remove,
+	.driver = {
+		   .name = "hisi-ade",
+		   .owner = THIS_MODULE,
+		   .of_match_table = ade_of_match,
+	},
+};
+
+module_platform_driver(ade_driver);
+
+MODULE_AUTHOR("Xinwei Kong <kong.kongxinwei@hisilicon.com>");
+MODULE_AUTHOR("Xinliang Liu <z.liuxinliang@huawei.com>");
+MODULE_DESCRIPTION("hisilicon SoC DRM driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_drv.c b/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
new file mode 100644
index 0000000..0983ad7
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
@@ -0,0 +1,206 @@
+/*
+ * Hisilicon Terminal SoCs drm driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: Xinwei Kong <kong.kongxinwei@hisilicon.com> for hisilicon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/of_platform.h>
+#include <linux/component.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+
+#include "hisi_drm_fb.h"
+
+#define DRIVER_NAME	"hisi-drm"
+
+static int hisi_drm_unload(struct drm_device *dev)
+{
+	drm_vblank_cleanup(dev);
+	drm_mode_config_cleanup(dev);
+	dev->dev_private = NULL;
+
+	return 0;
+}
+
+static const struct drm_mode_config_funcs hisi_drm_mode_config_funcs = {
+	.fb_create = hisi_drm_fb_create,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+static void hisi_drm_mode_config_init(struct drm_device *dev)
+{
+	dev->mode_config.min_width = 0;
+	dev->mode_config.min_height = 0;
+
+	dev->mode_config.max_width = 2048;
+	dev->mode_config.max_height = 2048;
+
+	dev->mode_config.funcs = &hisi_drm_mode_config_funcs;
+}
+
+static int hisi_drm_load(struct drm_device *dev, unsigned long flags)
+{
+	int ret;
+
+	/* debug setting
+	drm_debug = DRM_UT_DRIVER|DRM_UT_KMS; */
+
+	/* dev->mode_config initialization */
+	drm_mode_config_init(dev);
+	hisi_drm_mode_config_init(dev);
+
+	/* only support one crtc now */
+	ret = drm_vblank_init(dev, 1);
+	if (ret)
+		goto out_err;
+
+	ret = component_bind_all(dev->dev, dev);
+	if (ret)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	hisi_drm_unload(dev);
+	return ret;
+}
+
+static const struct file_operations hisi_drm_fops = {
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
+static struct dma_buf *hisi_drm_gem_prime_export(struct drm_device *dev,
+						 struct drm_gem_object *obj,
+						 int flags)
+{
+	/* we want to be able to write in mmapped buffer */
+	flags |= O_RDWR;
+	return drm_gem_prime_export(dev, obj, flags);
+}
+
+static struct drm_driver hisi_drm_driver = {
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME
+				| DRIVER_HAVE_IRQ,
+	.load			= hisi_drm_load,
+	.unload                 = hisi_drm_unload,
+	.fops			= &hisi_drm_fops,
+	.set_busid		= drm_platform_set_busid,
+
+	.gem_free_object	= drm_gem_cma_free_object,
+	.gem_vm_ops		= &drm_gem_cma_vm_ops,
+	.dumb_create		= drm_gem_cma_dumb_create,
+	.dumb_map_offset	= drm_gem_cma_dumb_map_offset,
+	.dumb_destroy		= drm_gem_dumb_destroy,
+
+	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
+	.gem_prime_export	= hisi_drm_gem_prime_export,
+	.gem_prime_import	= drm_gem_prime_import,
+	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
+	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
+	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
+	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
+	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
+
+	.name			= "hisi",
+	.desc			= "Hisilicon Terminal SoCs DRM Driver",
+	.date			= "20150830",
+	.major			= 1,
+	.minor			= 0,
+};
+
+/* -----------------------------------------------------------------------------
+ * Platform driver
+ */
+
+static int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static int hisi_drm_bind(struct device *dev)
+{
+	dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	return drm_platform_init(&hisi_drm_driver, to_platform_device(dev));
+}
+
+static void hisi_drm_unbind(struct device *dev)
+{
+	drm_put_dev(dev_get_drvdata(dev));
+}
+
+static const struct component_master_ops hisi_drm_ops = {
+	.bind = hisi_drm_bind,
+	.unbind = hisi_drm_unbind,
+};
+
+static int hisi_drm_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *child_np;
+	struct component_match *match = NULL;
+
+	of_platform_populate(node, NULL, NULL, dev);
+
+	child_np = of_get_next_available_child(node, NULL);
+	while (child_np) {
+		component_match_add(dev, &match, compare_of, child_np);
+		of_node_put(child_np);
+		child_np = of_get_next_available_child(node, child_np);
+	}
+
+	return component_master_add_with_match(dev, &hisi_drm_ops, match);
+
+	return 0;
+}
+
+static int hisi_drm_platform_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &hisi_drm_ops);
+	of_platform_depopulate(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id hisi_drm_dt_ids[] = {
+	{ .compatible = "hisilicon,display-subsystem", },
+	{ /* end node */ },
+};
+MODULE_DEVICE_TABLE(of, hisi_drm_dt_ids);
+
+static struct platform_driver hisi_drm_platform_driver = {
+	.probe = hisi_drm_platform_probe,
+	.remove = hisi_drm_platform_remove,
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = DRIVER_NAME,
+		.of_match_table = hisi_drm_dt_ids,
+	},
+};
+
+module_platform_driver(hisi_drm_platform_driver);
+
+MODULE_AUTHOR("Xinwei Kong <kong.kongxinwei@hisilicon.com>");
+MODULE_AUTHOR("Xinliang Liu <z.liuxinliang@huawei.com>");
+MODULE_DESCRIPTION("hisilicon SoC DRM driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
new file mode 100644
index 0000000..a8dbaad
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
@@ -0,0 +1,131 @@
+/*
+ * Hisilicon Terminal SoCs drm driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: Xinwei Kong <kong.kongxinwei@hisilicon.com> for hisilicon
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/component.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_encoder_slave.h>
+
+#define DSI_24BITS_1               (5)
+
+struct hisi_dsi {
+	u32 lanes;
+	u32 format;
+	u32 date_enable_pol;
+	u32 mode_flags;
+	u8 color_mode;
+	void *ctx;
+};
+
+struct hisi_dsi_context {
+	struct hisi_dsi dsi;
+	struct clk *dsi_cfg_clk;
+	struct drm_device *dev;
+
+	void __iomem *base;
+	int nominal_pixel_clk_kHz;
+};
+
+static int hisi_dsi_bind(struct device *dev, struct device *master,
+			 void *data)
+{
+	int ret = 0;
+
+	return ret;
+}
+
+static void hisi_dsi_unbind(struct device *dev, struct device *master,
+			    void *data)
+{
+	/* do nothing */
+}
+
+static const struct component_ops hisi_dsi_ops = {
+	.bind	= hisi_dsi_bind,
+	.unbind	= hisi_dsi_unbind,
+};
+
+static int hisi_dsi_probe(struct platform_device *pdev)
+{
+	struct hisi_dsi_context *ctx;
+	struct hisi_dsi *dsi;
+	struct resource *res;
+	struct device_node *slave_node;
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		DRM_ERROR("failed to allocate hisi dsi context.\n");
+		ret = -ENOMEM;
+	}
+
+	ctx->dsi_cfg_clk = devm_clk_get(&pdev->dev, "pclk_dsi");
+	if (IS_ERR(ctx->dsi_cfg_clk)) {
+		DRM_ERROR("failed to parse the dsi config clock\n");
+		ret = PTR_ERR(ctx->dsi_cfg_clk);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctx->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctx->base)) {
+		DRM_ERROR("failed to remap dsi io region\n");
+		ret = PTR_ERR(ctx->base);
+	}
+
+	slave_node = of_parse_phandle(np, "encoder-slave", 0);
+	if (!slave_node) {
+		DRM_ERROR("failed to parse the slave encoder node\n");
+		return -EINVAL;
+	}
+
+	dsi = &ctx->dsi;
+	dsi->ctx = ctx;
+	dsi->lanes = 3;
+	dsi->date_enable_pol = 0;
+	dsi->color_mode = DSI_24BITS_1;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
+
+	return component_add(&pdev->dev, &hisi_dsi_ops);
+}
+
+static int hisi_dsi_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &hisi_dsi_ops);
+
+	return 0;
+}
+
+static const struct of_device_id hisi_dsi_of_match[] = {
+	{.compatible = "hisilicon,hi6220-dsi"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hisi_dsi_of_match);
+
+static struct platform_driver hisi_dsi_driver = {
+	.probe = hisi_dsi_probe,
+	.remove = hisi_dsi_remove,
+	.driver = {
+		.name = "hisi-dsi",
+		.owner = THIS_MODULE,
+		.of_match_table = hisi_dsi_of_match,
+	},
+};
+
+module_platform_driver(hisi_dsi_driver);
+
+MODULE_AUTHOR("Xinwei Kong <kong.kongxinwei@hisilicon.com>");
+MODULE_AUTHOR("Xinliang Liu <z.liuxinliang@huawei.com>");
+MODULE_DESCRIPTION("hisilicon SoC DRM driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_fb.c b/drivers/gpu/drm/hisilicon/hisi_drm_fb.c
new file mode 100644
index 0000000..5dace8b
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_fb.c
@@ -0,0 +1,156 @@
+/*
+ * Hisilicon Terminal SoCs drm fbdev driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: z.liuxinliang at huawei.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_crtc_helper.h>
+
+#include "hisi_drm_fb.h"
+
+struct hisi_drm_fb *to_hisi_drm_fb(struct drm_framebuffer *fb)
+{
+	return container_of(fb, struct hisi_drm_fb, fb);
+}
+
+void hisi_drm_fb_destroy(struct drm_framebuffer *fb)
+{
+	struct hisi_drm_fb *hisi_fb = to_hisi_drm_fb(fb);
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		if (hisi_fb->obj[i])
+			drm_gem_object_unreference_unlocked
+				(&hisi_fb->obj[i]->base);
+	}
+
+	drm_framebuffer_cleanup(fb);
+	kfree(hisi_fb);
+}
+
+static int hisi_drm_fb_create_handle(struct drm_framebuffer *fb,
+				     struct drm_file *file_priv,
+				     unsigned int *handle)
+{
+	struct hisi_drm_fb *hisi_fb = to_hisi_drm_fb(fb);
+
+	return drm_gem_handle_create(file_priv,
+			&hisi_fb->obj[0]->base, handle);
+}
+
+static int hisi_drm_fb_dirty(struct drm_framebuffer *fb,
+			     struct drm_file *file_priv,
+			     unsigned flags,
+			     unsigned color,
+			     struct drm_clip_rect *clips,
+			     unsigned num_clips)
+{
+	/* TODO */
+	return 0;
+}
+
+static struct drm_framebuffer_funcs hisi_drm_fb_funcs = {
+	.destroy	= hisi_drm_fb_destroy,
+	.create_handle	= hisi_drm_fb_create_handle,
+	.dirty		= hisi_drm_fb_dirty,
+};
+
+struct hisi_drm_fb *hisi_drm_fb_alloc(struct drm_device *dev,
+				      struct drm_mode_fb_cmd2 *mode_cmd,
+				      struct drm_gem_cma_object **obj,
+				      unsigned int num_planes, bool is_fbdev_fb)
+{
+	struct hisi_drm_fb *hisi_fb;
+	int ret;
+	int i;
+
+	hisi_fb = kzalloc(sizeof(*hisi_fb), GFP_KERNEL);
+	if (!hisi_fb)
+		return ERR_PTR(-ENOMEM);
+
+	hisi_fb->is_fbdev_fb = is_fbdev_fb;
+	drm_helper_mode_fill_fb_struct(&hisi_fb->fb, mode_cmd);
+
+	for (i = 0; i < num_planes; i++)
+		hisi_fb->obj[i] = obj[i];
+
+	ret = drm_framebuffer_init(dev, &hisi_fb->fb, &hisi_drm_fb_funcs);
+	if (ret) {
+		DRM_ERROR("Failed to initialize framebuffer: %d\n", ret);
+		kfree(hisi_fb);
+		return ERR_PTR(ret);
+	}
+
+	return hisi_fb;
+}
+
+/**
+ * hisi_drm_fb_create() - (struct drm_mode_config_funcs *)->fb_create callback
+ *function
+ * If your hardware has special alignment or pitch requirements these should be
+ * checked before calling this function.
+ */
+
+struct drm_framebuffer *hisi_drm_fb_create(struct drm_device *dev,
+					   struct drm_file *file_priv,
+					   struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	struct hisi_drm_fb *hisi_fb;
+	struct drm_gem_cma_object *objs[4];
+	struct drm_gem_object *obj;
+	unsigned int hsub;
+	unsigned int vsub;
+	int ret;
+	int i;
+
+	/* TODO: Need to use ion heaps to create frame buffer?? */
+
+	hsub = drm_format_horz_chroma_subsampling(mode_cmd->pixel_format);
+	vsub = drm_format_vert_chroma_subsampling(mode_cmd->pixel_format);
+
+	for (i = 0; i < drm_format_num_planes(mode_cmd->pixel_format); i++) {
+		unsigned int width = mode_cmd->width / (i ? hsub : 1);
+		unsigned int height = mode_cmd->height / (i ? vsub : 1);
+		unsigned int min_size;
+
+		obj = drm_gem_object_lookup(dev, file_priv,
+					    mode_cmd->handles[i]);
+		if (!obj) {
+			DRM_ERROR("Failed to lookup GEM object\n");
+			ret = -ENXIO;
+			goto err_gem_object_unreference;
+		}
+
+		min_size = (height - 1) * mode_cmd->pitches[i]
+		     + width * drm_format_plane_cpp(mode_cmd->pixel_format, i)
+		     + mode_cmd->offsets[i];
+
+		if (obj->size < min_size) {
+			drm_gem_object_unreference_unlocked(obj);
+			ret = -EINVAL;
+			goto err_gem_object_unreference;
+		}
+		objs[i] = to_drm_gem_cma_obj(obj);
+	}
+
+	hisi_fb = hisi_drm_fb_alloc(dev, mode_cmd, objs, i, false);
+	if (IS_ERR(hisi_fb)) {
+		ret = PTR_ERR(hisi_fb);
+		goto err_gem_object_unreference;
+	}
+
+	return &hisi_fb->fb;
+
+err_gem_object_unreference:
+	for (i--; i >= 0; i--)
+		drm_gem_object_unreference_unlocked(&objs[i]->base);
+	return ERR_PTR(ret);
+}
+
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_fb.h b/drivers/gpu/drm/hisilicon/hisi_drm_fb.h
new file mode 100644
index 0000000..1db1289
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_fb.h
@@ -0,0 +1,26 @@
+/*
+ * Hisilicon Terminal SoCs drm fbdev driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author: z.liuxinliang at huawei.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __HISI_DRM_FB_H__
+#define __HISI_DRM_FB_H__
+
+struct hisi_drm_fb {
+	struct drm_framebuffer		fb;
+	struct drm_gem_cma_object	*obj[4];
+	bool is_fbdev_fb;
+};
+
+struct drm_framebuffer *hisi_drm_fb_create(struct drm_device *dev,
+					   struct drm_file *file_priv,
+					   struct drm_mode_fb_cmd2 *mode_cmd);
+
+#endif /* __HISI_DRM_FB_H__ */
-- 
1.9.1
