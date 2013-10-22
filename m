From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 22 Oct 2013 15:41:02 +0530
Subject: [PATCH v2 1/7] drm/exynos: move hdmiphy code to hdmiphy i2c driver
In-Reply-To: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
References: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1382436668-15813-2-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos hdmiphy operations and configs are kept inside
the hdmi driver. Hdmiphy related code is very tightly
coupled with hdmi IP driver.

This patch moves hdmiphy related code to hdmiphy I2C driver
which  supports hdmiphys which are accessible through i2c
control bus for example in exynos4210, exynos4212 and
exynos5250.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 .../devicetree/bindings/video/exynos_hdmi.txt      |    2 +
 drivers/gpu/drm/exynos/Makefile                    |    2 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |  362 ++++-------------
 drivers/gpu/drm/exynos/exynos_hdmiphy.c            |   65 ---
 drivers/gpu/drm/exynos/exynos_hdmiphy.h            |   46 +++
 drivers/gpu/drm/exynos/exynos_hdmiphy_i2c.c        |  429 ++++++++++++++++++++
 drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h       |   34 ++
 drivers/gpu/drm/exynos/regs-hdmiphy.h              |   37 ++
 8 files changed, 629 insertions(+), 348 deletions(-)
 delete mode 100644 drivers/gpu/drm/exynos/exynos_hdmiphy.c
 create mode 100644 drivers/gpu/drm/exynos/exynos_hdmiphy.h
 create mode 100644 drivers/gpu/drm/exynos/exynos_hdmiphy_i2c.c
 create mode 100644 drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h
 create mode 100644 drivers/gpu/drm/exynos/regs-hdmiphy.h

diff --git a/Documentation/devicetree/bindings/video/exynos_hdmi.txt b/Documentation/devicetree/bindings/video/exynos_hdmi.txt
index 50decf8..240eca5 100644
--- a/Documentation/devicetree/bindings/video/exynos_hdmi.txt
+++ b/Documentation/devicetree/bindings/video/exynos_hdmi.txt
@@ -25,6 +25,7 @@ Required properties:
 		sclk_pixel.
 - clock-names: aliases as per driver requirements for above clock IDs:
 	"hdmi", "sclk_hdmi", "sclk_pixel", "sclk_hdmiphy" and "mout_hdmi".
+- phy: it points to hdmiphy dt node.
 Example:
 
 	hdmi {
@@ -32,4 +33,5 @@ Example:
 		reg = <0x14530000 0x100000>;
 		interrupts = <0 95 0>;
 		hpd-gpio = <&gpx3 7 1>;
+		phy = <&hdmiphy>;
 	};
diff --git a/drivers/gpu/drm/exynos/Makefile b/drivers/gpu/drm/exynos/Makefile
index 639b49e..463239b 100644
--- a/drivers/gpu/drm/exynos/Makefile
+++ b/drivers/gpu/drm/exynos/Makefile
@@ -12,7 +12,7 @@ exynosdrm-$(CONFIG_DRM_EXYNOS_IOMMU) += exynos_drm_iommu.o
 exynosdrm-$(CONFIG_DRM_EXYNOS_DMABUF) += exynos_drm_dmabuf.o
 exynosdrm-$(CONFIG_DRM_EXYNOS_FIMD)	+= exynos_drm_fimd.o
 exynosdrm-$(CONFIG_DRM_EXYNOS_HDMI)	+= exynos_hdmi.o exynos_mixer.o \
-					   exynos_ddc.o exynos_hdmiphy.o \
+					   exynos_ddc.o exynos_hdmiphy_i2c.o \
 					   exynos_drm_hdmi.o
 exynosdrm-$(CONFIG_DRM_EXYNOS_VIDI)	+= exynos_drm_vidi.o
 exynosdrm-$(CONFIG_DRM_EXYNOS_G2D)	+= exynos_drm_g2d.o
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index f67ffca..bbb9fbf 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -34,6 +34,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/of_i2c.h>
 
 #include <drm/exynos_drm.h>
 
@@ -41,6 +42,7 @@
 #include "exynos_drm_hdmi.h"
 
 #include "exynos_hdmi.h"
+#include "exynos_hdmiphy.h"
 
 #include <linux/gpio.h>
 #include <media/s5p_hdmi.h>
@@ -193,9 +195,10 @@ struct hdmi_context {
 	int				irq;
 
 	struct i2c_client		*ddc_port;
-	struct i2c_client		*hdmiphy_port;
+	struct device			*phy_dev;
+	struct exynos_hdmiphy_ops		*phy_ops;
 
-	/* current hdmiphy conf regs */
+	/* current hdmi ip configuration registers. */
 	struct hdmi_conf_regs		mode_conf;
 
 	struct hdmi_resources		res;
@@ -205,186 +208,17 @@ struct hdmi_context {
 	enum hdmi_type			type;
 };
 
-struct hdmiphy_config {
-	int pixel_clock;
-	u8 conf[32];
-};
-
-/* list of phy config settings */
-static const struct hdmiphy_config hdmiphy_v13_configs[] = {
-	{
-		.pixel_clock = 27000000,
-		.conf = {
-			0x01, 0x05, 0x00, 0xD8, 0x10, 0x1C, 0x30, 0x40,
-			0x6B, 0x10, 0x02, 0x51, 0xDF, 0xF2, 0x54, 0x87,
-			0x84, 0x00, 0x30, 0x38, 0x00, 0x08, 0x10, 0xE0,
-			0x22, 0x40, 0xE3, 0x26, 0x00, 0x00, 0x00, 0x00,
-		},
-	},
-	{
-		.pixel_clock = 27027000,
-		.conf = {
-			0x01, 0x05, 0x00, 0xD4, 0x10, 0x9C, 0x09, 0x64,
-			0x6B, 0x10, 0x02, 0x51, 0xDF, 0xF2, 0x54, 0x87,
-			0x84, 0x00, 0x30, 0x38, 0x00, 0x08, 0x10, 0xE0,
-			0x22, 0x40, 0xE3, 0x26, 0x00, 0x00, 0x00, 0x00,
-		},
-	},
-	{
-		.pixel_clock = 74176000,
-		.conf = {
-			0x01, 0x05, 0x00, 0xD8, 0x10, 0x9C, 0xef, 0x5B,
-			0x6D, 0x10, 0x01, 0x51, 0xef, 0xF3, 0x54, 0xb9,
-			0x84, 0x00, 0x30, 0x38, 0x00, 0x08, 0x10, 0xE0,
-			0x22, 0x40, 0xa5, 0x26, 0x01, 0x00, 0x00, 0x00,
-		},
-	},
-	{
-		.pixel_clock = 74250000,
-		.conf = {
-			0x01, 0x05, 0x00, 0xd8, 0x10, 0x9c, 0xf8, 0x40,
-			0x6a, 0x10, 0x01, 0x51, 0xff, 0xf1, 0x54, 0xba,
-			0x84, 0x00, 0x10, 0x38, 0x00, 0x08, 0x10, 0xe0,
-			0x22, 0x40, 0xa4, 0x26, 0x01, 0x00, 0x00, 0x00,
-		},
-	},
-	{
-		.pixel_clock = 148500000,
-		.conf = {
-			0x01, 0x05, 0x00, 0xD8, 0x10, 0x9C, 0xf8, 0x40,
-			0x6A, 0x18, 0x00, 0x51, 0xff, 0xF1, 0x54, 0xba,
-			0x84, 0x00, 0x10, 0x38, 0x00, 0x08, 0x10, 0xE0,
-			0x22, 0x40, 0xa4, 0x26, 0x02, 0x00, 0x00, 0x00,
-		},
-	},
-};
-
-static const struct hdmiphy_config hdmiphy_v14_configs[] = {
-	{
-		.pixel_clock = 25200000,
-		.conf = {
-			0x01, 0x51, 0x2A, 0x75, 0x40, 0x01, 0x00, 0x08,
-			0x82, 0x80, 0xfc, 0xd8, 0x45, 0xa0, 0xac, 0x80,
-			0x08, 0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86,
-			0x54, 0xf4, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
-		},
-	},
-	{
-		.pixel_clock = 27000000,
-		.conf = {
-			0x01, 0xd1, 0x22, 0x51, 0x40, 0x08, 0xfc, 0x20,
-			0x98, 0xa0, 0xcb, 0xd8, 0x45, 0xa0, 0xac, 0x80,
-			0x06, 0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86,
-			0x54, 0xe4, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
-		},
-	},
-	{
-		.pixel_clock = 27027000,
-		.conf = {
-			0x01, 0xd1, 0x2d, 0x72, 0x40, 0x64, 0x12, 0x08,
-			0x43, 0xa0, 0x0e, 0xd9, 0x45, 0xa0, 0xac, 0x80,
-			0x08, 0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86,
-			0x54, 0xe3, 0x24, 0x00, 0x00, 0x00, 0x01, 0x00,
-		},
-	},
-	{
-		.pixel_clock = 36000000,
-		.conf = {
-			0x01, 0x51, 0x2d, 0x55, 0x40, 0x01, 0x00, 0x08,
-			0x82, 0x80, 0x0e, 0xd9, 0x45, 0xa0, 0xac, 0x80,
-			0x08, 0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86,
-			0x54, 0xab, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
-		},
-	},
-	{
-		.pixel_clock = 40000000,
-		.conf = {
-			0x01, 0x51, 0x32, 0x55, 0x40, 0x01, 0x00, 0x08,
-			0x82, 0x80, 0x2c, 0xd9, 0x45, 0xa0, 0xac, 0x80,
-			0x08, 0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86,
-			0x54, 0x9a, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
-		},
-	},
-	{
-		.pixel_clock = 65000000,
-		.conf = {
-			0x01, 0xd1, 0x36, 0x34, 0x40, 0x1e, 0x0a, 0x08,
-			0x82, 0xa0, 0x45, 0xd9, 0x45, 0xa0, 0xac, 0x80,
-			0x08, 0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86,
-			0x54, 0xbd, 0x24, 0x01, 0x00, 0x00, 0x01, 0x80,
-		},
-	},
-	{
-		.pixel_clock = 74176000,
-		.conf = {
-			0x01, 0xd1, 0x3e, 0x35, 0x40, 0x5b, 0xde, 0x08,
-			0x82, 0xa0, 0x73, 0xd9, 0x45, 0xa0, 0xac, 0x80,
-			0x56, 0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86,
-			0x54, 0xa6, 0x24, 0x01, 0x00, 0x00, 0x01, 0x80,
-		},
-	},
-	{
-		.pixel_clock = 74250000,
-		.conf = {
-			0x01, 0xd1, 0x1f, 0x10, 0x40, 0x40, 0xf8, 0x08,
-			0x81, 0xa0, 0xba, 0xd8, 0x45, 0xa0, 0xac, 0x80,
-			0x3c, 0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86,
-			0x54, 0xa5, 0x24, 0x01, 0x00, 0x00, 0x01, 0x00,
-		},
-	},
-	{
-		.pixel_clock = 83500000,
-		.conf = {
-			0x01, 0xd1, 0x23, 0x11, 0x40, 0x0c, 0xfb, 0x08,
-			0x85, 0xa0, 0xd1, 0xd8, 0x45, 0xa0, 0xac, 0x80,
-			0x08, 0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86,
-			0x54, 0x93, 0x24, 0x01, 0x00, 0x00, 0x01, 0x80,
-		},
-	},
-	{
-		.pixel_clock = 106500000,
-		.conf = {
-			0x01, 0xd1, 0x2c, 0x12, 0x40, 0x0c, 0x09, 0x08,
-			0x84, 0xa0, 0x0a, 0xd9, 0x45, 0xa0, 0xac, 0x80,
-			0x08, 0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86,
-			0x54, 0x73, 0x24, 0x01, 0x00, 0x00, 0x01, 0x80,
-		},
-	},
-	{
-		.pixel_clock = 108000000,
-		.conf = {
-			0x01, 0x51, 0x2d, 0x15, 0x40, 0x01, 0x00, 0x08,
-			0x82, 0x80, 0x0e, 0xd9, 0x45, 0xa0, 0xac, 0x80,
-			0x08, 0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86,
-			0x54, 0xc7, 0x25, 0x03, 0x00, 0x00, 0x01, 0x80,
-		},
-	},
-	{
-		.pixel_clock = 146250000,
-		.conf = {
-			0x01, 0xd1, 0x3d, 0x15, 0x40, 0x18, 0xfd, 0x08,
-			0x83, 0xa0, 0x6e, 0xd9, 0x45, 0xa0, 0xac, 0x80,
-			0x08, 0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86,
-			0x54, 0x50, 0x25, 0x03, 0x00, 0x00, 0x01, 0x80,
-		},
-	},
-	{
-		.pixel_clock = 148500000,
-		.conf = {
-			0x01, 0xd1, 0x1f, 0x00, 0x40, 0x40, 0xf8, 0x08,
-			0x81, 0xa0, 0xba, 0xd8, 0x45, 0xa0, 0xac, 0x80,
-			0x3c, 0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86,
-			0x54, 0x4b, 0x25, 0x03, 0x00, 0x00, 0x01, 0x00,
-		},
-	},
-};
-
 struct hdmi_infoframe {
 	enum HDMI_PACKET_TYPE type;
 	u8 ver;
 	u8 len;
 };
 
+struct hdmi_drv_data {
+	enum hdmi_type	type;
+	bool		i2c_hdmiphy;
+};
+
 static inline u32 hdmi_reg_read(struct hdmi_context *hdata, u32 reg_id)
 {
 	return readl(hdata->regs + reg_id);
@@ -769,28 +603,6 @@ static struct edid *hdmi_get_edid(void *ctx, struct drm_connector *connector)
 	return raw_edid;
 }
 
-static int hdmi_find_phy_conf(struct hdmi_context *hdata, u32 pixel_clock)
-{
-	const struct hdmiphy_config *confs;
-	int count, i;
-
-	if (hdata->type == HDMI_TYPE13) {
-		confs = hdmiphy_v13_configs;
-		count = ARRAY_SIZE(hdmiphy_v13_configs);
-	} else if (hdata->type == HDMI_TYPE14) {
-		confs = hdmiphy_v14_configs;
-		count = ARRAY_SIZE(hdmiphy_v14_configs);
-	} else
-		return -EINVAL;
-
-	for (i = 0; i < count; i++)
-		if (confs[i].pixel_clock == pixel_clock)
-			return i;
-
-	DRM_DEBUG_KMS("Could not find phy config for %d\n", pixel_clock);
-	return -EINVAL;
-}
-
 static int hdmi_check_mode(void *ctx, struct drm_display_mode *mode)
 {
 	struct hdmi_context *hdata = ctx;
@@ -801,7 +613,7 @@ static int hdmi_check_mode(void *ctx, struct drm_display_mode *mode)
 		(mode->flags & DRM_MODE_FLAG_INTERLACE) ? true :
 		false, mode->clock * 1000);
 
-	ret = hdmi_find_phy_conf(hdata, mode->clock * 1000);
+	ret = hdata->phy_ops->check_mode(hdata->phy_dev, mode);
 	if (ret < 0)
 		return ret;
 	return 0;
@@ -1302,19 +1114,13 @@ static void hdmi_mode_apply(struct hdmi_context *hdata)
 
 static void hdmiphy_conf_reset(struct hdmi_context *hdata)
 {
-	u8 buffer[2];
 	u32 reg;
 
 	clk_disable_unprepare(hdata->res.sclk_hdmi);
 	clk_set_parent(hdata->res.mout_hdmi, hdata->res.sclk_pixel);
 	clk_prepare_enable(hdata->res.sclk_hdmi);
 
-	/* operation mode */
-	buffer[0] = 0x1f;
-	buffer[1] = 0x00;
-
-	if (hdata->hdmiphy_port)
-		i2c_master_send(hdata->hdmiphy_port, buffer, 2);
+	hdata->phy_ops->enable(hdata->phy_dev, 0);
 
 	if (hdata->type == HDMI_TYPE13)
 		reg = HDMI_V13_PHY_RSTOUT;
@@ -1333,76 +1139,24 @@ static void hdmiphy_poweron(struct hdmi_context *hdata)
 	if (hdata->type == HDMI_TYPE14)
 		hdmi_reg_writemask(hdata, HDMI_PHY_CON_0, 0,
 			HDMI_PHY_POWER_OFF_EN);
+
+	hdata->phy_ops->poweron(hdata->phy_dev, 1);
 }
 
 static void hdmiphy_poweroff(struct hdmi_context *hdata)
 {
+	hdata->phy_ops->poweron(hdata->phy_dev, 0);
+
 	if (hdata->type == HDMI_TYPE14)
 		hdmi_reg_writemask(hdata, HDMI_PHY_CON_0, ~0,
 			HDMI_PHY_POWER_OFF_EN);
 }
 
-static void hdmiphy_conf_apply(struct hdmi_context *hdata)
-{
-	const u8 *hdmiphy_data;
-	u8 buffer[32];
-	u8 operation[2];
-	u8 read_buffer[32] = {0, };
-	int ret;
-	int i;
-
-	if (!hdata->hdmiphy_port) {
-		DRM_ERROR("hdmiphy is not attached\n");
-		return;
-	}
-
-	/* pixel clock */
-	i = hdmi_find_phy_conf(hdata, hdata->mode_conf.pixel_clock);
-	if (i < 0) {
-		DRM_ERROR("failed to find hdmiphy conf\n");
-		return;
-	}
-
-	if (hdata->type == HDMI_TYPE13)
-		hdmiphy_data = hdmiphy_v13_configs[i].conf;
-	else
-		hdmiphy_data = hdmiphy_v14_configs[i].conf;
-
-	memcpy(buffer, hdmiphy_data, 32);
-	ret = i2c_master_send(hdata->hdmiphy_port, buffer, 32);
-	if (ret != 32) {
-		DRM_ERROR("failed to configure HDMIPHY via I2C\n");
-		return;
-	}
-
-	usleep_range(10000, 12000);
-
-	/* operation mode */
-	operation[0] = 0x1f;
-	operation[1] = 0x80;
-
-	ret = i2c_master_send(hdata->hdmiphy_port, operation, 2);
-	if (ret != 2) {
-		DRM_ERROR("failed to enable hdmiphy\n");
-		return;
-	}
-
-	ret = i2c_master_recv(hdata->hdmiphy_port, read_buffer, 32);
-	if (ret < 0) {
-		DRM_ERROR("failed to read hdmiphy config\n");
-		return;
-	}
-
-	for (i = 0; i < ret; i++)
-		DRM_DEBUG_KMS("hdmiphy[0x%02x] write[0x%02x] - "
-			"recv [0x%02x]\n", i, buffer[i], read_buffer[i]);
-}
-
 static void hdmi_conf_apply(struct hdmi_context *hdata)
 {
 	hdmiphy_conf_reset(hdata);
-	hdmiphy_conf_apply(hdata);
-
+	hdata->phy_ops->commit(hdata->phy_dev);
+	hdata->phy_ops->enable(hdata->phy_dev, 1);
 	mutex_lock(&hdata->hdmi_mutex);
 	hdmi_conf_reset(hdata);
 	hdmi_conf_init(hdata);
@@ -1646,6 +1400,8 @@ static void hdmi_mode_set(void *ctx, struct drm_display_mode *mode)
 		hdmi_v13_mode_set(hdata, mode);
 	else
 		hdmi_v14_mode_set(hdata, mode);
+
+	hdata->phy_ops->mode_set(hdata->phy_dev, mode);
 }
 
 static void hdmi_get_max_resol(void *ctx, unsigned int *width,
@@ -1824,7 +1580,7 @@ fail:
 	return -ENODEV;
 }
 
-static struct i2c_client *hdmi_ddc, *hdmi_hdmiphy;
+static struct i2c_client *hdmi_ddc;
 
 void hdmi_attach_ddc_client(struct i2c_client *ddc)
 {
@@ -1832,12 +1588,6 @@ void hdmi_attach_ddc_client(struct i2c_client *ddc)
 		hdmi_ddc = ddc;
 }
 
-void hdmi_attach_hdmiphy_client(struct i2c_client *hdmiphy)
-{
-	if (hdmiphy)
-		hdmi_hdmiphy = hdmiphy;
-}
-
 static struct s5p_hdmi_platform_data *drm_hdmi_dt_parse_pdata
 					(struct device *dev)
 {
@@ -1862,13 +1612,61 @@ err_data:
 	return NULL;
 }
 
+static int hdmi_register_phy_device(struct hdmi_context *hdata, bool i2c_dev)
+{
+	struct device_node *np;
+	struct i2c_client *client;
+	int ret;
+
+	/* register hdmiphy driver */
+	ret = exynos_hdmiphy_i2c_driver_register();
+	if (ret) {
+		DRM_ERROR("failed to register phy driver. ret %d.\n", ret);
+		goto err;
+	}
+
+	np = of_parse_phandle(hdata->dev->of_node, "phy", 0);
+	if (!np) {
+		DRM_ERROR("Could not find 'phy' property\n");
+		ret = -ENOENT;
+		goto err;
+	}
+
+	/* find hdmi phy on i2c bus */
+	client = of_find_i2c_device_by_node(np);
+	if (!client) {
+		DRM_ERROR("Could not find i2c 'phy' device\n");
+		ret = -ENODEV;
+		goto err;
+	}
+	hdata->phy_dev = &client->dev;
+	hdata->phy_ops = exynos_hdmiphy_i2c_device_get_ops(
+				hdata->phy_dev);
+
+	if (!hdata->phy_ops) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	of_node_put(np);
+	return 0;
+err:
+	of_node_put(np);
+	return ret;
+}
+
+static struct hdmi_drv_data exynos5250_hdmi_drv_data = {
+	.type = HDMI_TYPE14,
+	.i2c_hdmiphy = 1,
+};
+
 static struct of_device_id hdmi_match_types[] = {
 	{
 		.compatible = "samsung,exynos5-hdmi",
-		.data	= (void	*)HDMI_TYPE14,
+		.data	= &exynos5250_hdmi_drv_data,
 	}, {
 		.compatible = "samsung,exynos4212-hdmi",
-		.data	= (void	*)HDMI_TYPE14,
+		.data	= &exynos5250_hdmi_drv_data,
 	}, {
 		/* end node */
 	}
@@ -1881,6 +1679,7 @@ static int hdmi_probe(struct platform_device *pdev)
 	struct hdmi_context *hdata;
 	struct s5p_hdmi_platform_data *pdata;
 	struct resource *res;
+	struct hdmi_drv_data *drv;
 	const struct of_device_id *match;
 	int ret;
 
@@ -1909,8 +1708,9 @@ static int hdmi_probe(struct platform_device *pdev)
 	match = of_match_node(hdmi_match_types, dev->of_node);
 	if (!match)
 		return -ENODEV;
-	hdata->type = (enum hdmi_type)match->data;
+	drv = (struct hdmi_drv_data *)match->data;
 
+	hdata->type = drv->type;
 	hdata->hpd_gpio = pdata->hpd_gpio;
 	hdata->dev = dev;
 
@@ -1939,15 +1739,13 @@ static int hdmi_probe(struct platform_device *pdev)
 
 	hdata->ddc_port = hdmi_ddc;
 
-	/* hdmiphy i2c driver */
-	if (i2c_add_driver(&hdmiphy_driver)) {
-		DRM_ERROR("failed to register hdmiphy i2c driver\n");
-		ret = -ENOENT;
+	/* hdmiphy driver */
+	ret = hdmi_register_phy_device(hdata, drv->i2c_hdmiphy);
+	if (ret) {
+		DRM_ERROR("failed to get hdmiphy device. ret %d.\n", ret);
 		goto err_ddc;
 	}
 
-	hdata->hdmiphy_port = hdmi_hdmiphy;
-
 	hdata->irq = gpio_to_irq(hdata->hpd_gpio);
 	if (hdata->irq < 0) {
 		DRM_ERROR("failed to get GPIO irq\n");
@@ -1977,7 +1775,7 @@ static int hdmi_probe(struct platform_device *pdev)
 	return 0;
 
 err_hdmiphy:
-	i2c_del_driver(&hdmiphy_driver);
+	exynos_hdmiphy_i2c_driver_unregister();
 err_ddc:
 	i2c_del_driver(&ddc_driver);
 	return ret;
@@ -1990,7 +1788,7 @@ static int hdmi_remove(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 
 	/* hdmiphy i2c driver */
-	i2c_del_driver(&hdmiphy_driver);
+	exynos_hdmiphy_i2c_driver_unregister();
 	/* DDC i2c driver */
 	i2c_del_driver(&ddc_driver);
 
diff --git a/drivers/gpu/drm/exynos/exynos_hdmiphy.c b/drivers/gpu/drm/exynos/exynos_hdmiphy.c
deleted file mode 100644
index 59abb14..0000000
--- a/drivers/gpu/drm/exynos/exynos_hdmiphy.c
+++ /dev/null
@@ -1,65 +0,0 @@
-/*
- * Copyright (C) 2011 Samsung Electronics Co.Ltd
- * Authors:
- *	Seung-Woo Kim <sw0312.kim@samsung.com>
- *	Inki Dae <inki.dae@samsung.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-
-#include <drm/drmP.h>
-
-#include <linux/kernel.h>
-#include <linux/i2c.h>
-#include <linux/of.h>
-
-#include "exynos_drm_drv.h"
-#include "exynos_hdmi.h"
-
-
-static int hdmiphy_probe(struct i2c_client *client,
-	const struct i2c_device_id *id)
-{
-	hdmi_attach_hdmiphy_client(client);
-
-	dev_info(&client->adapter->dev, "attached s5p_hdmiphy "
-		"into i2c adapter successfully\n");
-
-	return 0;
-}
-
-static int hdmiphy_remove(struct i2c_client *client)
-{
-	dev_info(&client->adapter->dev, "detached s5p_hdmiphy "
-		"from i2c adapter successfully\n");
-
-	return 0;
-}
-
-static struct of_device_id hdmiphy_match_types[] = {
-	{
-		.compatible = "samsung,exynos5-hdmiphy",
-	}, {
-		.compatible = "samsung,exynos4210-hdmiphy",
-	}, {
-		.compatible = "samsung,exynos4212-hdmiphy",
-	}, {
-		/* end node */
-	}
-};
-
-struct i2c_driver hdmiphy_driver = {
-	.driver = {
-		.name	= "exynos-hdmiphy",
-		.owner	= THIS_MODULE,
-		.of_match_table = hdmiphy_match_types,
-	},
-	.probe		= hdmiphy_probe,
-	.remove		= hdmiphy_remove,
-	.command		= NULL,
-};
-EXPORT_SYMBOL(hdmiphy_driver);
diff --git a/drivers/gpu/drm/exynos/exynos_hdmiphy.h b/drivers/gpu/drm/exynos/exynos_hdmiphy.h
new file mode 100644
index 0000000..26f279d
--- /dev/null
+++ b/drivers/gpu/drm/exynos/exynos_hdmiphy.h
@@ -0,0 +1,46 @@
+/*
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ * Authors:
+ *	Rahul Sharma <rahul.sharma@samsung.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef _EXYNOS_HDMIPHY_H_
+#define _EXYNOS_HDMIPHY_H_
+
+/*
+ * Exynos DRM Hdmiphy Structure.
+ *
+ * @check_mode: check if mode is supported.
+ * @mode_set: set the mode if supported.
+ * @commit: apply the mode.
+ * @enable: enable phy operation.
+ * @poweron: phy power on or off.
+ */
+struct exynos_hdmiphy_ops {
+	int (*check_mode)(struct device *dev,
+			struct drm_display_mode *mode);
+	int (*mode_set)(struct device *dev,
+			struct drm_display_mode *mode);
+	int (*commit)(struct device *dev);
+	void (*enable)(struct device *dev, int enable);
+	void (*poweron)(struct device *dev, int mode);
+};
+
+int exynos_hdmiphy_i2c_driver_register(void);
+void exynos_hdmiphy_i2c_driver_unregister(void);
+
+int exynos_hdmiphy_platform_driver_register(void);
+void exynos_hdmiphy_platform_driver_unregister(void);
+
+struct exynos_hdmiphy_ops *exynos_hdmiphy_i2c_device_get_ops
+			(struct device *dev);
+struct exynos_hdmiphy_ops *exynos_hdmiphy_platform_device_get_ops
+			(struct device *dev);
+
+#endif
diff --git a/drivers/gpu/drm/exynos/exynos_hdmiphy_i2c.c b/drivers/gpu/drm/exynos/exynos_hdmiphy_i2c.c
new file mode 100644
index 0000000..76b3a74
--- /dev/null
+++ b/drivers/gpu/drm/exynos/exynos_hdmiphy_i2c.c
@@ -0,0 +1,429 @@
+/*
+ * Copyright (C) 2013 Samsung Electronics Co.Ltd
+ * Authors:
+ *	Rahul Sharma <rahul.sharma@samsung.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;	either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <drm/drmP.h>
+
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include "regs-hdmiphy.h"
+#include "exynos_hdmiphy.h"
+#include "exynos_hdmiphy_priv.h"
+
+/* list of default phy config settings */
+static struct hdmiphy_config hdmiphy_4212_configs[] = {
+	{
+		.pixel_clock = 25200000,
+		.conf = {
+			0x51, 0x2A, 0x75, 0x40, 0x01, 0x00, 0x08, 0x82,
+			0x80, 0xfc, 0xd8, 0x45, 0xa0, 0xac, 0x80, 0x08,
+			0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86, 0x54,
+			0xf4, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 27000000,
+		.conf = {
+			0xd1, 0x22, 0x51, 0x40, 0x08, 0xfc, 0x20, 0x98,
+			0xa0, 0xcb, 0xd8, 0x45, 0xa0, 0xac, 0x80, 0x06,
+			0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86, 0x54,
+			0xe4, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 27027000,
+		.conf = {
+			0xd1, 0x2d, 0x72, 0x40, 0x64, 0x12, 0x08, 0x43,
+			0xa0, 0x0e, 0xd9, 0x45, 0xa0, 0xac, 0x80, 0x08,
+			0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86, 0x54,
+			0xe3, 0x24, 0x00, 0x00, 0x00, 0x01, 0x00,
+		},
+	},
+	{
+		.pixel_clock = 36000000,
+		.conf = {
+			0x51, 0x2d, 0x55, 0x40, 0x01, 0x00, 0x08, 0x82,
+			0x80, 0x0e, 0xd9, 0x45, 0xa0, 0xac, 0x80, 0x08,
+			0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86, 0x54,
+			0xab, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 40000000,
+		.conf = {
+			0x51, 0x32, 0x55, 0x40, 0x01, 0x00, 0x08, 0x82,
+			0x80, 0x2c, 0xd9, 0x45, 0xa0, 0xac, 0x80, 0x08,
+			0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86, 0x54,
+			0x9a, 0x24, 0x00, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 65000000,
+		.conf = {
+			0xd1, 0x36, 0x34, 0x40, 0x1e, 0x0a, 0x08, 0x82,
+			0xa0, 0x45, 0xd9, 0x45, 0xa0, 0xac, 0x80, 0x08,
+			0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86, 0x54,
+			0xbd, 0x24, 0x01, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 74176000,
+		.conf = {
+			0xd1, 0x3e, 0x35, 0x40, 0x5b, 0xde, 0x08, 0x82,
+			0xa0, 0x73, 0xd9, 0x45, 0xa0, 0xac, 0x80, 0x56,
+			0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86, 0x54,
+			0xa6, 0x24, 0x01, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 74250000,
+		.conf = {
+			0xd1, 0x1f, 0x10, 0x40, 0x40, 0xf8, 0x08, 0x81,
+			0xa0, 0xba, 0xd8, 0x45, 0xa0, 0xac, 0x80, 0x3c,
+			0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86, 0x54,
+			0xa5, 0x24, 0x01, 0x00, 0x00, 0x01, 0x00,
+		},
+	},
+	{
+		.pixel_clock = 83500000,
+		.conf = {
+			0xd1, 0x23, 0x11, 0x40, 0x0c, 0xfb, 0x08, 0x85,
+			0xa0, 0xd1, 0xd8, 0x45, 0xa0, 0xac, 0x80, 0x08,
+			0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86, 0x54,
+			0x93, 0x24, 0x01, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 106500000,
+		.conf = {
+			0xd1, 0x2c, 0x12, 0x40, 0x0c, 0x09, 0x08, 0x84,
+			0xa0, 0x0a, 0xd9, 0x45, 0xa0, 0xac, 0x80, 0x08,
+			0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86, 0x54,
+			0x73, 0x24, 0x01, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 108000000,
+		.conf = {
+			0x51, 0x2d, 0x15, 0x40, 0x01, 0x00, 0x08, 0x82,
+			0x80, 0x0e, 0xd9, 0x45, 0xa0, 0xac, 0x80, 0x08,
+			0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86, 0x54,
+			0xc7, 0x25, 0x03, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 146250000,
+		.conf = {
+			0xd1, 0x3d, 0x15, 0x40, 0x18, 0xfd, 0x08, 0x83,
+			0xa0, 0x6e, 0xd9, 0x45, 0xa0, 0xac, 0x80, 0x08,
+			0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86, 0x54,
+			0x50, 0x25, 0x03, 0x00, 0x00, 0x01, 0x80,
+		},
+	},
+	{
+		.pixel_clock = 148500000,
+		.conf = {
+			0xd1, 0x1f, 0x00, 0x40, 0x40, 0xf8, 0x08, 0x81,
+			0xa0, 0xba, 0xd8, 0x45, 0xa0, 0xac, 0x80, 0x3c,
+			0x80, 0x11, 0x04, 0x02, 0x22, 0x44, 0x86, 0x54,
+			0x4b, 0x25, 0x03, 0x00, 0x00, 0x01, 0x00,
+		},
+	},
+};
+
+static struct hdmiphy_config hdmiphy_4210_configs[] = {
+	{
+		.pixel_clock = 27000000,
+		.conf = {
+			0x05, 0x00, 0xD8, 0x10, 0x1C, 0x30, 0x40, 0x6B,
+			0x10, 0x02, 0x51, 0xDF, 0xF2, 0x54, 0x87, 0x84,
+			0x00, 0x30, 0x38, 0x00, 0x08, 0x10, 0xE0, 0x22,
+			0x40, 0xE3, 0x26, 0x00, 0x00, 0x00, 0x00,
+		},
+	},
+	{
+		.pixel_clock = 27027000,
+		.conf = {
+			0x05, 0x00, 0xD4, 0x10, 0x9C, 0x09, 0x64, 0x6B,
+			0x10, 0x02, 0x51, 0xDF, 0xF2, 0x54, 0x87, 0x84,
+			0x00, 0x30, 0x38, 0x00, 0x08, 0x10, 0xE0, 0x22,
+			0x40, 0xE3, 0x26, 0x00, 0x00, 0x00, 0x00,
+		},
+	},
+	{
+		.pixel_clock = 74176000,
+		.conf = {
+			0x05, 0x00, 0xD8, 0x10, 0x9C, 0xef, 0x5B, 0x6D,
+			0x10, 0x01, 0x51, 0xef, 0xF3, 0x54, 0xb9, 0x84,
+			0x00, 0x30, 0x38, 0x00, 0x08, 0x10, 0xE0, 0x22,
+			0x40, 0xa5, 0x26, 0x01, 0x00, 0x00, 0x00,
+		},
+	},
+	{
+		.pixel_clock = 74250000,
+		.conf = {
+			0x05, 0x00, 0xd8, 0x10, 0x9c, 0xf8, 0x40, 0x6a,
+			0x10, 0x01, 0x51, 0xff, 0xf1, 0x54, 0xba, 0x84,
+			0x00, 0x10, 0x38, 0x00, 0x08, 0x10, 0xe0, 0x22,
+			0x40, 0xa4, 0x26, 0x01, 0x00, 0x00, 0x00,
+		},
+	},
+	{
+		.pixel_clock = 148500000,
+		.conf = {
+			0x05, 0x00, 0xD8, 0x10, 0x9C, 0xf8, 0x40, 0x6A,
+			0x18, 0x00, 0x51, 0xff, 0xF1, 0x54, 0xba, 0x84,
+			0x00, 0x10, 0x38, 0x00, 0x08, 0x10, 0xE0, 0x22,
+			0x40, 0xa4, 0x26, 0x02, 0x00, 0x00, 0x00,
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
+static int hdmiphy_reg_writeb(struct device *dev,
+			u32 reg_offset, u8 value)
+{
+	u8 buffer[2];
+	int ret;
+
+	if (reg_offset >= HDMIPHY_REG_COUNT)
+		return -EINVAL;
+
+	buffer[0] = reg_offset;
+	buffer[1] = value;
+
+	ret = i2c_master_send(to_i2c_client(dev),
+			buffer, 2);
+	if (ret == 2)
+		return 0;
+	return ret;
+}
+
+static int hdmiphy_reg_write_buf(struct device *dev,
+			u32 reg_offset, const u8 *buf, u32 len)
+{
+	int ret;
+	u8 buffer[HDMIPHY_REG_COUNT];
+
+	if ((reg_offset + len) > HDMIPHY_REG_COUNT)
+		return -EINVAL;
+
+	buffer[0] = reg_offset;
+	memcpy(&buffer[1], buf, len);
+
+	ret = i2c_master_send(to_i2c_client(dev),
+			buffer, len);
+	if (ret == len)
+		return 0;
+	return ret;
+}
+
+static int hdmiphy_check_mode(struct device *dev,
+			struct drm_display_mode *mode)
+{
+	struct hdmiphy_context *hdata = dev_get_drvdata(dev);
+	const struct hdmiphy_config *conf;
+
+	DRM_DEBUG("xres=%d, yres=%d, refresh=%d, intl=%d clock=%d\n",
+		mode->hdisplay, mode->vdisplay,
+		mode->vrefresh, (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		? true : false, mode->clock * 1000);
+
+	conf = hdmiphy_find_conf(hdata, (mode->clock * 1000));
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
+	ret = hdmiphy_reg_write_buf(dev, 1, hdata->current_conf->conf,
+			HDMIPHY_REG_COUNT - 1);
+	if (ret) {
+		DRM_ERROR("failed to configure hdmiphy.\n");
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
+	int ret;
+
+	DRM_DEBUG_KMS("[%d]\n", __LINE__);
+
+	if (enable)
+		ret = hdmiphy_reg_writeb(dev, HDMIPHY_MODE_SET_DONE,
+				HDMIPHY_MODE_EN);
+	else
+		ret = hdmiphy_reg_writeb(dev, HDMIPHY_MODE_SET_DONE, 0);
+
+	if (ret < 0) {
+		DRM_ERROR("failed to %s hdmiphy. ret %d.\n",
+				enable ? "enable" : "disable", ret);
+		return;
+	}
+}
+
+static void hdmiphy_poweron(struct device *dev, int mode)
+{
+
+	DRM_DEBUG_KMS("[%d]\n", __LINE__);
+
+}
+
+struct exynos_hdmiphy_ops *exynos_hdmiphy_i2c_device_get_ops
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
+static struct hdmiphy_drv_data exynos4212_hdmiphy_drv_data = {
+	.confs = hdmiphy_4212_configs,
+	.count = ARRAY_SIZE(hdmiphy_4212_configs)
+};
+
+static struct hdmiphy_drv_data exynos4210_hdmiphy_drv_data = {
+	.confs = hdmiphy_4210_configs,
+	.count = ARRAY_SIZE(hdmiphy_4210_configs)
+};
+
+static struct of_device_id hdmiphy_i2c_device_match_types[] = {
+	{
+		.compatible = "samsung,exynos5-hdmiphy",
+		.data	= &exynos4212_hdmiphy_drv_data,
+	}, {
+		.compatible = "samsung,exynos4210-hdmiphy",
+		.data	= &exynos4210_hdmiphy_drv_data,
+	}, {
+		.compatible = "samsung,exynos4212-hdmiphy",
+		.data	= &exynos4212_hdmiphy_drv_data,
+	}, {
+		/* end node */
+	}
+};
+
+static int hdmiphy_i2c_device_probe(struct i2c_client *client,
+	const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct hdmiphy_context *hdata;
+	struct hdmiphy_drv_data *drv;
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
+		hdmiphy_i2c_device_match_types),
+		dev->of_node);
+
+	if (!match)
+		return -ENODEV;
+
+	drv = (struct hdmiphy_drv_data *)match->data;
+
+	hdata->confs = drv->confs;
+	hdata->nr_confs = drv->count;
+	hdata->ops = &phy_ops;
+
+	i2c_set_clientdata(client, hdata);
+	return 0;
+}
+
+static const struct i2c_device_id hdmiphy_id[] = {
+	{ },
+};
+
+struct i2c_driver hdmiphy_i2c_driver = {
+	.driver = {
+		.name	= "exynos-hdmiphy",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(
+				hdmiphy_i2c_device_match_types),
+	},
+	.id_table		= hdmiphy_id,
+	.probe		= hdmiphy_i2c_device_probe,
+	.command		= NULL,
+};
+
+int exynos_hdmiphy_i2c_driver_register(void)
+{
+	int ret;
+
+	ret = i2c_add_driver(&hdmiphy_i2c_driver);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void exynos_hdmiphy_i2c_driver_unregister(void)
+{
+	i2c_del_driver(&hdmiphy_i2c_driver);
+}
diff --git a/drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h b/drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h
new file mode 100644
index 0000000..4948c81
--- /dev/null
+++ b/drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h
@@ -0,0 +1,34 @@
+/*
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ * Authors:
+ *	Rahul Sharma <rahul.sharma@samsung.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;	either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef _EXYNOS_HDMI_PRIV_H_
+#define _EXYNOS_HDMI_PRIV_H_
+
+struct hdmiphy_context {
+	/* hdmiphy resources */
+	struct exynos_hdmiphy_ops	*ops;
+	struct hdmiphy_config	*confs;
+	unsigned int		nr_confs;
+	struct hdmiphy_config	*current_conf;
+};
+
+struct hdmiphy_config {
+	int pixel_clock;
+	u8 conf[HDMIPHY_REG_COUNT];
+};
+
+struct hdmiphy_drv_data {
+	struct hdmiphy_config *confs;
+	unsigned int count;
+};
+
+#endif
diff --git a/drivers/gpu/drm/exynos/regs-hdmiphy.h b/drivers/gpu/drm/exynos/regs-hdmiphy.h
new file mode 100644
index 0000000..97e87ab
--- /dev/null
+++ b/drivers/gpu/drm/exynos/regs-hdmiphy.h
@@ -0,0 +1,37 @@
+/*
+ *
+ *  regs-hdmiphy.h
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ * http://www.samsung.com/
+ *
+ * HDMI-PHY register header file for Samsung HDMI driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef SAMSUNG_REGS_HDMIPHY_H
+#define SAMSUNG_REGS_HDMIPHY_H
+
+#define HDMIPHY_REG_COUNT	32
+
+/*
+ * Register part
+*/
+#define HDMIPHY_MODE_SET_DONE	0x1f
+
+/*
+ * Bit definition part
+ */
+
+/* HDMIPHY_MODE_SET_DONE */
+#define HDMIPHY_MODE_EN		(1 << 7)
+
+/* hdmiphy pmu control bits */
+#define PMU_HDMI_PHY_CONTROL_MASK	1
+#define PMU_HDMI_PHY_ENABLE		1
+#define PMU_HDMI_PHY_DISABLE		0
+
+#endif /* SAMSUNG_REGS_HDMIPHY_H */
-- 
1.7.10.4
