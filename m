From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 22 Oct 2013 15:41:04 +0530
Subject: [PATCH v2 3/7] drm/exynos: add hdmiphy platform driver for exynos5420
In-Reply-To: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
References: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1382436668-15813-4-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5420 hdmiphy device is a platform device, unlike
predecessor SoCs where it used to be a I2C device. This
support is added to the hdmiphy platform driver.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 drivers/gpu/drm/exynos/Makefile                  |    1 +
 drivers/gpu/drm/exynos/exynos_hdmi.c             |   61 +++-
 drivers/gpu/drm/exynos/exynos_hdmiphy_platform.c |  363 ++++++++++++++++++++++
 drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h     |    1 +
 4 files changed, 413 insertions(+), 13 deletions(-)
 create mode 100644 drivers/gpu/drm/exynos/exynos_hdmiphy_platform.c

diff --git a/drivers/gpu/drm/exynos/Makefile b/drivers/gpu/drm/exynos/Makefile
index 463239b..eedd145 100644
--- a/drivers/gpu/drm/exynos/Makefile
+++ b/drivers/gpu/drm/exynos/Makefile
@@ -13,6 +13,7 @@ exynosdrm-$(CONFIG_DRM_EXYNOS_DMABUF) += exynos_drm_dmabuf.o
 exynosdrm-$(CONFIG_DRM_EXYNOS_FIMD)	+= exynos_drm_fimd.o
 exynosdrm-$(CONFIG_DRM_EXYNOS_HDMI)	+= exynos_hdmi.o exynos_mixer.o \
 					   exynos_ddc.o exynos_hdmiphy_i2c.o \
+					   exynos_hdmiphy_platform.o \
 					   exynos_drm_hdmi.o
 exynosdrm-$(CONFIG_DRM_EXYNOS_VIDI)	+= exynos_drm_vidi.o
 exynosdrm-$(CONFIG_DRM_EXYNOS_G2D)	+= exynos_drm_g2d.o
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 444541d..e199d7d 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -35,6 +35,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_i2c.h>
+#include <linux/of_platform.h>
 
 #include <drm/exynos_drm.h>
 
@@ -1608,10 +1609,14 @@ static int hdmi_register_phy_device(struct hdmi_context *hdata, bool i2c_dev)
 {
 	struct device_node *np;
 	struct i2c_client *client;
+	struct platform_device *pdev;
 	int ret;
 
 	/* register hdmiphy driver */
-	ret = exynos_hdmiphy_i2c_driver_register();
+	if (i2c_dev)
+		ret = exynos_hdmiphy_i2c_driver_register();
+	else
+		ret = exynos_hdmiphy_platform_driver_register();
 	if (ret) {
 		DRM_ERROR("failed to register phy driver. ret %d.\n", ret);
 		goto err;
@@ -1624,16 +1629,29 @@ static int hdmi_register_phy_device(struct hdmi_context *hdata, bool i2c_dev)
 		goto err;
 	}
 
-	/* find hdmi phy on i2c bus */
-	client = of_find_i2c_device_by_node(np);
-	if (!client) {
-		DRM_ERROR("Could not find i2c 'phy' device\n");
-		ret = -ENODEV;
-		goto err;
+	if (i2c_dev) {
+		/* find hdmi phy on i2c bus */
+		client = of_find_i2c_device_by_node(np);
+		if (!client) {
+			DRM_ERROR("Could not find i2c 'phy' device\n");
+			ret = -ENODEV;
+			goto err;
+		}
+		hdata->phy_dev = &client->dev;
+		hdata->phy_ops = exynos_hdmiphy_i2c_device_get_ops(
+					hdata->phy_dev);
+	} else {
+		/* find hdmi phy on platform bus */
+		pdev = of_find_device_by_node(np);
+		if (!pdev) {
+			DRM_ERROR("Could not find platform 'phy' device\n");
+			ret = -ENODEV;
+			goto err;
+		}
+		hdata->phy_dev = &pdev->dev;
+		hdata->phy_ops = exynos_hdmiphy_platform_device_get_ops(
+					hdata->phy_dev);
 	}
-	hdata->phy_dev = &client->dev;
-	hdata->phy_ops = exynos_hdmiphy_i2c_device_get_ops(
-				hdata->phy_dev);
 
 	if (!hdata->phy_ops) {
 		ret = -EINVAL;
@@ -1652,6 +1670,11 @@ static struct hdmi_drv_data exynos5250_hdmi_drv_data = {
 	.i2c_hdmiphy = 1,
 };
 
+static struct hdmi_drv_data exynos5420_hdmi_drv_data = {
+	.type = HDMI_TYPE14,
+	.i2c_hdmiphy = 0,
+};
+
 static struct of_device_id hdmi_match_types[] = {
 	{
 		.compatible = "samsung,exynos5-hdmi",
@@ -1660,6 +1683,9 @@ static struct of_device_id hdmi_match_types[] = {
 		.compatible = "samsung,exynos4212-hdmi",
 		.data	= &exynos5250_hdmi_drv_data,
 	}, {
+		.compatible = "samsung,exynos5420-hdmi",
+		.data	= &exynos5420_hdmi_drv_data,
+	}, {
 		/* end node */
 	}
 };
@@ -1767,7 +1793,10 @@ static int hdmi_probe(struct platform_device *pdev)
 	return 0;
 
 err_hdmiphy:
-	exynos_hdmiphy_i2c_driver_unregister();
+	if (drv->i2c_hdmiphy)
+		exynos_hdmiphy_i2c_driver_unregister();
+	else
+		exynos_hdmiphy_platform_driver_unregister();
 err_ddc:
 	i2c_del_driver(&ddc_driver);
 	return ret;
@@ -1776,11 +1805,17 @@ err_ddc:
 static int hdmi_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct exynos_drm_hdmi_context *ctx = get_hdmi_context(dev);
+	struct hdmi_context *hdata = ctx->ctx;
 
 	pm_runtime_disable(dev);
 
-	/* hdmiphy i2c driver */
-	exynos_hdmiphy_i2c_driver_unregister();
+	/* hdmiphy driver */
+	if (i2c_verify_client(hdata->phy_dev))
+		exynos_hdmiphy_i2c_driver_unregister();
+	else
+		exynos_hdmiphy_platform_driver_unregister();
+
 	/* DDC i2c driver */
 	i2c_del_driver(&ddc_driver);
 
diff --git a/drivers/gpu/drm/exynos/exynos_hdmiphy_platform.c b/drivers/gpu/drm/exynos/exynos_hdmiphy_platform.c
new file mode 100644
index 0000000..053d854
--- /dev/null
+++ b/drivers/gpu/drm/exynos/exynos_hdmiphy_platform.c
@@ -0,0 +1,363 @@
+/*
+ * Copyright (C) 2013 Samsung Electronics Co.Ltd
+ * Authors:
+ *	Rahul Sharma <rahul.sharma@samsung.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <drm/drmP.h>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "regs-hdmiphy.h"
+#include "exynos_hdmiphy.h"
+#include "exynos_hdmiphy_priv.h"
+
+/* default phy config settings for exynos5420 */
+static struct hdmiphy_config hdmiphy_5420_configs[] = {
+	{
+		.pixel_clock = 25200000,
+		.conf = {
+			0x52, 0x3F, 0x55, 0x40, 0x01, 0x00, 0xC8, 0x82,
+			0xC8, 0xBD, 0xD8, 0x45, 0xA0, 0xAC, 0x80, 0x06,
+			0x80, 0x01, 0x84, 0x05, 0x02, 0x24, 0x66, 0x54,
+			0xF4, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 27000000,
+		.conf = {
+			0xD1, 0x22, 0x51, 0x40, 0x08, 0xFC, 0xE0, 0x98,
+			0xE8, 0xCB, 0xD8, 0x45, 0xA0, 0xAC, 0x80, 0x06,
+			0x80, 0x09, 0x84, 0x05, 0x02, 0x24, 0x66, 0x54,
+			0xE4, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 27027000,
+		.conf = {
+			0xD1, 0x2D, 0x72, 0x40, 0x64, 0x12, 0xC8, 0x43,
+			0xE8, 0x0E, 0xD9, 0x45, 0xA0, 0xAC, 0x80, 0x06,
+			0x80, 0x09, 0x84, 0x05, 0x02, 0x24, 0x66, 0x54,
+			0xE3, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 36000000,
+		.conf = {
+			0x51, 0x2D, 0x55, 0x40, 0x40, 0x00, 0xC8, 0x02,
+			0xC8, 0x0E, 0xD9, 0x45, 0xA0, 0xAC, 0x80, 0x08,
+			0x80, 0x09, 0x84, 0x05, 0x02, 0x24, 0x66, 0x54,
+			0xAB, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 40000000,
+		.conf = {
+			0xD1, 0x21, 0x31, 0x40, 0x3C, 0x28, 0xC8, 0x87,
+			0xE8, 0xC8, 0xD8, 0x45, 0xA0, 0xAC, 0x80, 0x08,
+			0x80, 0x09, 0x84, 0x05, 0x02, 0x24, 0x66, 0x54,
+			0x9A, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 65000000,
+		.conf = {
+			0xD1, 0x36, 0x34, 0x40, 0x0C, 0x04, 0xC8, 0x82,
+			0xE8, 0x45, 0xD9, 0x45, 0xA0, 0xAC, 0x80, 0x08,
+			0x80, 0x09, 0x84, 0x05, 0x02, 0x24, 0x66, 0x54,
+			0xBD, 0x24, 0x01, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 71000000,
+		.conf = {
+			0xD1, 0x3B, 0x35, 0x40, 0x0C, 0x04, 0xC8, 0x85,
+			0xE8, 0x63, 0xD9, 0x45, 0xA0, 0xAC, 0x80, 0x08,
+			0x80, 0x09, 0x84, 0x05, 0x02, 0x24, 0x66, 0x54,
+			0x57, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 74176000,
+		.conf = {
+			0xD1, 0x1F, 0x10, 0x40, 0x5B, 0xEF, 0xC8, 0x81,
+			0xE8, 0xB9, 0xD8, 0x45, 0xA0, 0xAC, 0x80, 0x56,
+			0x80, 0x09, 0x84, 0x05, 0x02, 0x24, 0x66, 0x54,
+			0xA6, 0x24, 0x01, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 74250000,
+		.conf = {
+			0xD1, 0x1F, 0x10, 0x40, 0x40, 0xF8, 0xC8, 0x81,
+			0xE8, 0xBA, 0xD8, 0x45, 0xA0, 0xAC, 0x80, 0x56,
+			0x80, 0x09, 0x84, 0x05, 0x02, 0x24, 0x66, 0x54,
+			0xA5, 0x24, 0x01, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 83500000,
+		.conf = {
+			0xD1, 0x23, 0x11, 0x40, 0x0C, 0xFB, 0xC8, 0x85,
+			0xE8, 0xD1, 0xD8, 0x45, 0xA0, 0xAC, 0x80, 0x08,
+			0x80, 0x09, 0x84, 0x05, 0x02, 0x24, 0x66, 0x54,
+			0x4A, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 106500000,
+		.conf = {
+			0xD1, 0x2C, 0x12, 0x40, 0x0C, 0x09, 0xC8, 0x84,
+			0xE8, 0x0A, 0xD9, 0x45, 0xA0, 0xAC, 0x80, 0x08,
+			0x80, 0x09, 0x84, 0x05, 0x02, 0x24, 0x66, 0x54,
+			0x73, 0x24, 0x01, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 108000000,
+		.conf = {
+			0x51, 0x2D, 0x15, 0x40, 0x01, 0x00, 0xC8, 0x82,
+			0xC8, 0x0E, 0xD9, 0x45, 0xA0, 0xAC, 0x80, 0x08,
+			0x80, 0x09, 0x84, 0x05, 0x02, 0x24, 0x66, 0x54,
+			0xC7, 0x25, 0x03, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 146250000,
+		.conf = {
+			0xD1, 0x3D, 0x15, 0x40, 0x18, 0xFD, 0xC8, 0x83,
+			0xE8, 0x6E, 0xD9, 0x45, 0xA0, 0xAC, 0x80, 0x08,
+			0x80, 0x09, 0x84, 0x05, 0x02, 0x24, 0x66, 0x54,
+			0x54, 0x24, 0x01, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 148500000,
+		.conf = {
+			0xD1, 0x1F, 0x00, 0x40, 0x40, 0xF8, 0xC8, 0x81,
+			0xE8, 0xBA, 0xD8, 0x45, 0xA0, 0xAC, 0x80, 0x66,
+			0x80, 0x09, 0x84, 0x05, 0x02, 0x24, 0x66, 0x54,
+			0x4B, 0x25, 0x03, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+};
+
+static struct hdmiphy_config *hdmiphy_find_conf(struct hdmiphy_context *hdata,
+			unsigned int pixel_clk)
+{
+	int i;
+
+	for (i = 0; i < hdata->nr_confs; i++)
+		if (hdata->confs[i].pixel_clock == pixel_clk)
+			return &hdata->confs[i];
+
+	return NULL;
+}
+
+static int hdmiphy_reg_writeb(struct hdmiphy_context *hdata,
+			u32 reg_offset, u8 value)
+{
+	if (reg_offset >= HDMIPHY_REG_COUNT)
+		return -EINVAL;
+
+	writeb(value, hdata->regs + (reg_offset<<2));
+	return 0;
+}
+
+static int hdmiphy_reg_write_buf(struct hdmiphy_context *hdata,
+			u32 reg_offset, const u8 *buf, u32 len)
+{
+	int i;
+
+	if ((reg_offset + len) > HDMIPHY_REG_COUNT)
+		return -EINVAL;
+
+	for (i = 0; i < len; i++)
+		writeb(buf[i], hdata->regs +
+			((reg_offset + i)<<2));
+	return 0;
+}
+
+static int hdmiphy_check_mode(struct device *dev,
+			struct drm_display_mode *mode)
+{
+	struct hdmiphy_context *hdata = dev_get_drvdata(dev);
+	const struct hdmiphy_config *conf;
+
+	DRM_DEBUG("%s xres=%d, yres=%d, refresh=%d, intl=%d clock=%d\n",
+		__func__, mode->hdisplay, mode->vdisplay,
+		mode->vrefresh, (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		? true : false, mode->clock * 1000);
+
+	conf = hdmiphy_find_conf(hdata, mode->clock * 1000);
+	if (!conf) {
+		DRM_DEBUG("Display Mode is not supported.\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int hdmiphy_mode_set(struct device *dev,
+			struct drm_display_mode *mode)
+{
+	struct hdmiphy_context *hdata = dev_get_drvdata(dev);
+
+	DRM_DEBUG_KMS("[%d]\n", __LINE__);
+
+	hdata->current_conf = hdmiphy_find_conf(hdata, mode->clock * 1000);
+	if (!hdata->current_conf) {
+		DRM_ERROR("Display Mode is not supported.\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int hdmiphy_commit(struct device *dev)
+{
+	struct hdmiphy_context *hdata = dev_get_drvdata(dev);
+	int ret;
+
+	DRM_DEBUG_KMS("[%d]\n", __LINE__);
+
+	ret = hdmiphy_reg_write_buf(hdata, 1, hdata->current_conf->conf,
+			HDMIPHY_REG_COUNT - 1);
+	if (ret) {
+		DRM_ERROR("failed to configure hdmiphy. ret %d.\n", ret);
+		return ret;
+	}
+
+	/* need this delay before phy can be set to operation. */
+	usleep_range(10000, 12000);
+	return 0;
+}
+
+static void hdmiphy_enable(struct device *dev, int enable)
+{
+	struct hdmiphy_context *hdata = dev_get_drvdata(dev);
+
+	DRM_DEBUG_KMS("[%d]\n", __LINE__);
+
+	if (enable)
+		hdmiphy_reg_writeb(hdata, HDMIPHY_MODE_SET_DONE,
+				HDMIPHY_MODE_EN);
+	else
+		hdmiphy_reg_writeb(hdata, HDMIPHY_MODE_SET_DONE, 0);
+}
+
+static void hdmiphy_poweron(struct device *dev, int mode)
+{
+
+	DRM_DEBUG_KMS("[%d]\n", __LINE__);
+
+}
+
+struct exynos_hdmiphy_ops *exynos_hdmiphy_platform_device_get_ops
+			(struct device *dev)
+{
+	struct hdmiphy_context *hdata = dev_get_drvdata(dev);
+	DRM_DEBUG_KMS("[%d]\n", __LINE__);
+
+	if (hdata)
+		return hdata->ops;
+
+	return NULL;
+}
+
+static struct exynos_hdmiphy_ops phy_ops = {
+	.check_mode = hdmiphy_check_mode,
+	.mode_set = hdmiphy_mode_set,
+	.commit = hdmiphy_commit,
+	.enable = hdmiphy_enable,
+	.poweron = hdmiphy_poweron,
+};
+
+static struct hdmiphy_drv_data exynos5420_hdmiphy_drv_data = {
+	.confs = hdmiphy_5420_configs,
+	.count = ARRAY_SIZE(hdmiphy_5420_configs)
+};
+
+static struct of_device_id hdmiphy_platform_device_match_types[] = {
+	{
+		.compatible = "samsung,exynos5420-hdmiphy",
+		.data	= &exynos5420_hdmiphy_drv_data,
+	}, {
+		/* end node */
+	}
+};
+
+static int hdmiphy_platform_device_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hdmiphy_context *hdata;
+	struct hdmiphy_drv_data *drv;
+	struct resource *res;
+	const struct of_device_id *match;
+
+	DRM_DEBUG_KMS("[%d]\n", __LINE__);
+
+	hdata = devm_kzalloc(dev, sizeof(*hdata), GFP_KERNEL);
+	if (!hdata) {
+		DRM_ERROR("failed to allocate hdmiphy context.\n");
+		return -ENOMEM;
+	}
+
+	match = of_match_node(of_match_ptr(
+		hdmiphy_platform_device_match_types),
+		dev->of_node);
+
+	if (!match)
+		return -ENODEV;
+
+	drv = (struct hdmiphy_drv_data *)match->data;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		DRM_ERROR("failed to find phy registers\n");
+		return -ENOENT;
+	}
+
+	hdata->regs = devm_request_and_ioremap(&pdev->dev, res);
+	if (!hdata->regs) {
+		DRM_ERROR("failed to map registers\n");
+		return -ENXIO;
+	}
+
+	hdata->confs = drv->confs;
+	hdata->nr_confs = drv->count;
+	hdata->ops = &phy_ops;
+
+	platform_set_drvdata(pdev, hdata);
+	return 0;
+}
+
+struct platform_driver hdmiphy_platform_driver = {
+	.driver = {
+		.name	= "exynos-hdmiphy",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(
+				hdmiphy_platform_device_match_types),
+	},
+	.probe		= hdmiphy_platform_device_probe,
+};
+
+int exynos_hdmiphy_platform_driver_register(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&hdmiphy_platform_driver);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void exynos_hdmiphy_platform_driver_unregister(void)
+{
+	platform_driver_unregister(&hdmiphy_platform_driver);
+}
diff --git a/drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h b/drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h
index 4948c81..9ba46d4 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h
+++ b/drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h
@@ -15,6 +15,7 @@
 
 struct hdmiphy_context {
 	/* hdmiphy resources */
+	void __iomem		*regs;
 	struct exynos_hdmiphy_ops	*ops;
 	struct hdmiphy_config	*confs;
 	unsigned int		nr_confs;
-- 
1.7.10.4
