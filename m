From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 22 Oct 2013 15:41:05 +0530
Subject: [PATCH v2 4/7] drm/exynos: add hdmiphy pmu bit control in hdmiphy
 drivers
In-Reply-To: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
References: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1382436668-15813-5-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before hdmiphy operation like config, start etc, hdmiphy
bit in PMU block should be enabled. Earlier this happens
in hdmi driver through a dummy "hdmiphy" clock.

Pmu bit control is added in both i2c and platform driver
for exynos hdmiphy.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 .../devicetree/bindings/video/exynos_hdmiphy.txt   |    8 ++-
 drivers/gpu/drm/exynos/exynos_hdmiphy_i2c.c        |   55 ++++++++++++++++++++
 drivers/gpu/drm/exynos/exynos_hdmiphy_platform.c   |   55 ++++++++++++++++++++
 drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h       |    1 +
 4 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/video/exynos_hdmiphy.txt b/Documentation/devicetree/bindings/video/exynos_hdmiphy.txt
index 162f641..91e6578 100644
--- a/Documentation/devicetree/bindings/video/exynos_hdmiphy.txt
+++ b/Documentation/devicetree/bindings/video/exynos_hdmiphy.txt
@@ -5,11 +5,17 @@ Required properties:
 	1) "samsung,exynos5-hdmiphy" <DEPRECATED>
 	2) "samsung,exynos4210-hdmiphy".
 	3) "samsung,exynos4212-hdmiphy".
-- reg: I2C address of the hdmiphy device.
+- reg: Physical address of the hdmiphy device.
+- phy-power-control: this child node represents phy power control
+	register which is inside the pmu block (power management unit).
 
 Example:
 
 	hdmiphy {
 		compatible = "samsung,exynos4210-hdmiphy";
 		reg = <0x38>;
+
+		phy-power-control {
+			reg = <0x10040700 0x04>;
+		};
 	};
diff --git a/drivers/gpu/drm/exynos/exynos_hdmiphy_i2c.c b/drivers/gpu/drm/exynos/exynos_hdmiphy_i2c.c
index 76b3a74..6b411bd 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmiphy_i2c.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmiphy_i2c.c
@@ -201,6 +201,47 @@ static struct hdmiphy_config *hdmiphy_find_conf(struct hdmiphy_context *hdata,
 	return NULL;
 }
 
+static int hdmiphy_dt_parse_power_control(struct i2c_client *client)
+{
+	struct device_node *phy_pow_ctrl_node;
+	struct hdmiphy_context *hdata = i2c_get_clientdata(client);
+	u32 buf[2];
+	int ret = 0;
+
+	phy_pow_ctrl_node = of_get_child_by_name(client->dev.of_node,
+			"phy-power-control");
+	if (!phy_pow_ctrl_node) {
+		DRM_ERROR("Failed to find phy power control node\n");
+		return -ENODEV;
+	}
+
+	/* reg property holds two informations: addr of pmu register, size */
+	if (of_property_read_u32_array(phy_pow_ctrl_node, "reg", buf, 2)) {
+		DRM_ERROR("faild to get phy power control reg\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdata->phy_pow_ctrl_reg = devm_ioremap(&client->dev, buf[0], buf[1]);
+	if (!hdata->phy_pow_ctrl_reg) {
+		DRM_ERROR("failed to ioremap phy pmu reg\n");
+		ret = -ENOMEM;
+	}
+
+out:
+	of_node_put(phy_pow_ctrl_node);
+	return ret;
+}
+
+static inline void hdmiphy_pow_ctrl_reg_writemask(
+			struct hdmiphy_context *hdata,
+			u32 value, u32 mask)
+{
+	u32 old = readl(hdata->phy_pow_ctrl_reg);
+	value = (value & mask) | (old & ~mask);
+	writel(value, hdata->phy_pow_ctrl_reg);
+}
+
 static int hdmiphy_reg_writeb(struct device *dev,
 			u32 reg_offset, u8 value)
 {
@@ -313,9 +354,16 @@ static void hdmiphy_enable(struct device *dev, int enable)
 
 static void hdmiphy_poweron(struct device *dev, int mode)
 {
+	struct hdmiphy_context *hdata = dev_get_drvdata(dev);
 
 	DRM_DEBUG_KMS("[%d]\n", __LINE__);
 
+	if (mode)
+		hdmiphy_pow_ctrl_reg_writemask(hdata, PMU_HDMI_PHY_ENABLE,
+		PMU_HDMI_PHY_CONTROL_MASK);
+	else
+		hdmiphy_pow_ctrl_reg_writemask(hdata, PMU_HDMI_PHY_DISABLE,
+		PMU_HDMI_PHY_CONTROL_MASK);
 }
 
 struct exynos_hdmiphy_ops *exynos_hdmiphy_i2c_device_get_ops
@@ -370,6 +418,7 @@ static int hdmiphy_i2c_device_probe(struct i2c_client *client,
 	struct hdmiphy_context *hdata;
 	struct hdmiphy_drv_data *drv;
 	const struct of_device_id *match;
+	int ret;
 
 	DRM_DEBUG_KMS("[%d]\n", __LINE__);
 
@@ -393,6 +442,12 @@ static int hdmiphy_i2c_device_probe(struct i2c_client *client,
 	hdata->ops = &phy_ops;
 
 	i2c_set_clientdata(client, hdata);
+	ret = hdmiphy_dt_parse_power_control(client);
+	if (ret) {
+		DRM_ERROR("failed to map hdmiphy pow control reg.\n");
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/exynos/exynos_hdmiphy_platform.c b/drivers/gpu/drm/exynos/exynos_hdmiphy_platform.c
index 053d854..8fe1786 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmiphy_platform.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmiphy_platform.c
@@ -160,6 +160,47 @@ static struct hdmiphy_config *hdmiphy_find_conf(struct hdmiphy_context *hdata,
 	return NULL;
 }
 
+static int hdmiphy_dt_parse_power_control(struct platform_device *pdev)
+{
+	struct device_node *phy_pow_ctrl_node;
+	struct hdmiphy_context *hdata = platform_get_drvdata(pdev);
+	u32 buf[2];
+	int ret = 0;
+
+	phy_pow_ctrl_node = of_get_child_by_name(pdev->dev.of_node,
+			"phy-power-control");
+	if (!phy_pow_ctrl_node) {
+		DRM_ERROR("Failed to find phy power control node\n");
+		return -ENODEV;
+	}
+
+	/* reg property holds two informations: addr of pmu register, size */
+	if (of_property_read_u32_array(phy_pow_ctrl_node, "reg", buf, 2)) {
+		DRM_ERROR("faild to get phy power control reg\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdata->phy_pow_ctrl_reg = devm_ioremap(&pdev->dev, buf[0], buf[1]);
+	if (!hdata->phy_pow_ctrl_reg) {
+		DRM_ERROR("failed to ioremap phy pmu reg\n");
+		ret = -ENOMEM;
+	}
+
+out:
+	of_node_put(phy_pow_ctrl_node);
+	return ret;
+}
+
+static void hdmiphy_pow_ctrl_reg_writemask(
+			struct hdmiphy_context *hdata,
+			u32 value, u32 mask)
+{
+	u32 old = readl(hdata->phy_pow_ctrl_reg);
+	value = (value & mask) | (old & ~mask);
+	writel(value, hdata->phy_pow_ctrl_reg);
+}
+
 static int hdmiphy_reg_writeb(struct hdmiphy_context *hdata,
 			u32 reg_offset, u8 value)
 {
@@ -252,9 +293,16 @@ static void hdmiphy_enable(struct device *dev, int enable)
 
 static void hdmiphy_poweron(struct device *dev, int mode)
 {
+	struct hdmiphy_context *hdata = dev_get_drvdata(dev);
 
 	DRM_DEBUG_KMS("[%d]\n", __LINE__);
 
+	if (mode)
+		hdmiphy_pow_ctrl_reg_writemask(hdata, PMU_HDMI_PHY_ENABLE,
+			PMU_HDMI_PHY_CONTROL_MASK);
+	else
+		hdmiphy_pow_ctrl_reg_writemask(hdata, PMU_HDMI_PHY_DISABLE,
+			PMU_HDMI_PHY_CONTROL_MASK);
 }
 
 struct exynos_hdmiphy_ops *exynos_hdmiphy_platform_device_get_ops
@@ -298,6 +346,7 @@ static int hdmiphy_platform_device_probe(struct platform_device *pdev)
 	struct hdmiphy_drv_data *drv;
 	struct resource *res;
 	const struct of_device_id *match;
+	int ret;
 
 	DRM_DEBUG_KMS("[%d]\n", __LINE__);
 
@@ -333,6 +382,12 @@ static int hdmiphy_platform_device_probe(struct platform_device *pdev)
 	hdata->ops = &phy_ops;
 
 	platform_set_drvdata(pdev, hdata);
+	ret = hdmiphy_dt_parse_power_control(pdev);
+	if (ret) {
+		DRM_ERROR("failed to map hdmiphy pow control reg.\n");
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h b/drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h
index 9ba46d4..5987baf 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h
+++ b/drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h
@@ -15,6 +15,7 @@
 
 struct hdmiphy_context {
 	/* hdmiphy resources */
+	void __iomem		*phy_pow_ctrl_reg;
 	void __iomem		*regs;
 	struct exynos_hdmiphy_ops	*ops;
 	struct hdmiphy_config	*confs;
-- 
1.7.10.4
