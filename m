From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Fri, 21 Sep 2012 16:52:16 +0530
Subject: [PATCH V6 2/2] video: drm: exynos: Add device tree support
In-Reply-To: <1348226536-22899-1-git-send-email-l.krishna@samsung.com>
References: <1348226536-22899-1-git-send-email-l.krishna@samsung.com>
Message-ID: <1348226536-22899-3-git-send-email-l.krishna@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree based discovery support for exynos DRM-FIMD
driver which includes driver modification to handle platform data in
both the cases with DT and non-DT, Also adds the documentation for bindings.

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 .../devicetree/bindings/drm/exynos/fimd.txt        |   80 ++++++++++++++++
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |   95 +++++++++++++++++++-
 2 files changed, 173 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/drm/exynos/fimd.txt

diff --git a/Documentation/devicetree/bindings/drm/exynos/fimd.txt b/Documentation/devicetree/bindings/drm/exynos/fimd.txt
new file mode 100644
index 0000000..e94120c
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/exynos/fimd.txt
@@ -0,0 +1,80 @@
+* Samsung Display Controller using DRM frame work
+
+The display controller is used to transfer image data from memory to an
+external LCD driver interface. It supports various color formats such as
+rgb and yuv.
+
+Required properties:
+ - compatible: Should be "samsung,exynos5-fimd" or "samsung,exynos4-fimd" for
+   fimd using DRM frame work.
+ - reg: physical base address of the controller and length of memory
+   mapped region.
+ - interrupts: Three interrupts should be specified. The interrupts should be
+   specified in the following order.
+   - VSYNC interrupt
+   - FIFO level interrupt
+   - FIMD System Interrupt
+
+ - samsung,fimd-display: This property should specify the phandle of the
+   display device node which holds the video interface timing with the
+   below mentioned properties.
+
+   - lcd-htiming: Specifies the horizontal timing for the overlay. The
+     horizontal timing includes four parameters in the following order.
+
+     - horizontal back porch (in number of lcd clocks)
+     - horizontal front porch (in number of lcd clocks)
+     - hsync pulse width (in number of lcd clocks)
+     - Display panels X resolution.
+
+   - lcd-vtiming: Specifies the vertical timing for the overlay. The
+     vertical timing includes four parameters in the following order.
+
+     - vertical back porch (in number of lcd lines)
+     - vertical front porch (in number of lcd lines)
+     - vsync pulse width (in number of lcd clocks)
+     - Display panels Y resolution.
+
+
+ - samsung,default-window: Specifies the default window number of the fimd controller.
+
+ - samsung,fimd-win-bpp: Specifies the bits per pixel.
+
+Optional properties:
+ - samsung,fimd-vidout-rgb: Video output format is RGB.
+ - samsung,fimd-inv-vclk: invert video clock polarity.
+ - samsung,fimd-frame-rate: Number of video frames per second.
+
+Example:
+
+	The following is an example for the fimd controller is split into
+	two portions. The SoC specific portion can be specified in the SoC
+	specific dts file. The board specific portion can be specified in the
+	board specific dts file.
+
+	- SoC Specific portion
+
+	fimd {
+		compatible = "samsung,exynos5-fimd";
+		interrupt-parent = <&combiner>;
+		reg = <0x14400000 0x40000>;
+		interrupts = <18 5>, <18 4>, <18 6>;
+	};
+
+	- Board Specific portion
+
+	lcd_fimd0: lcd_panel0 {
+			lcd-htiming = <4 4 4 480>;
+			lcd-vtiming = <4 4 4 320>;
+			supports-mipi-panel;
+	};
+
+	fimd {
+		samsung,fimd-display = <&lcd_fimd0>;
+		samsung,fimd-vidout-rgb;
+		samsung,fimd-inv-vclk;
+		samsung,fimd-frame-rate = <60>;
+		samsung,default-window = <0>;
+		samsung,fimd-win-bpp = <32>;
+	};
+
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 1ad10b6..b2d22ac 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <video/samsung_fimd.h>
 #include <drm/exynos_drm.h>
@@ -103,9 +104,18 @@ struct fimd_context {
 	struct exynos_drm_panel_info *panel;
 };
 
+static const struct of_device_id fimd_dt_match[];
+
 static inline struct fimd_driver_data *drm_fimd_get_driver_data(
 	struct platform_device *pdev)
 {
+#ifdef CONFIG_OF
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+		match = of_match_ptr(fimd_dt_match);
+		return (struct fimd_driver_data *)match->data;
+	}
+#endif
 	return (struct fimd_driver_data *)
 		platform_get_device_id(pdev)->driver_data;
 }
@@ -809,12 +819,77 @@ static int fimd_power_on(struct fimd_context *ctx, bool enable)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct exynos_drm_fimd_pdata *drm_fimd_dt_parse_pdata(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct device_node *disp_np;
+	struct exynos_drm_fimd_pdata *pd;
+	u32 data[4];
+
+	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd) {
+		dev_err(dev, "memory allocation for pdata failed\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (of_get_property(np, "samsung,fimd-vidout-rgb", NULL))
+		pd->vidcon0 |= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB;
+	if (of_get_property(np, "samsung,fimd-inv-hsync", NULL))
+		pd->vidcon1 |= VIDCON1_INV_HSYNC;
+	if (of_get_property(np, "samsung,fimd-inv-vsync", NULL))
+		pd->vidcon1 |= VIDCON1_INV_VSYNC;
+	if (of_get_property(np, "samsung,fimd-inv-vclk", NULL))
+		pd->vidcon1 |= VIDCON1_INV_VCLK;
+	if (of_get_property(np, "samsung,fimd-inv-vden", NULL))
+		pd->vidcon1 |= VIDCON1_INV_VDEN;
+
+	disp_np = of_parse_phandle(np, "samsung,fimd-display", 0);
+	if (!disp_np) {
+		dev_err(dev, "unable to find display panel info\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (of_property_read_u32_array(disp_np, "lcd-htiming", data, 4)) {
+		dev_err(dev, "invalid horizontal timing\n");
+		return ERR_PTR(-EINVAL);
+	}
+	pd->panel.timing.left_margin = data[0];
+	pd->panel.timing.right_margin = data[1];
+	pd->panel.timing.hsync_len = data[2];
+	pd->panel.timing.xres = data[3];
+
+	if (of_property_read_u32_array(disp_np, "lcd-vtiming", data, 4)) {
+		dev_err(dev, "invalid vertical timing\n");
+		return ERR_PTR(-EINVAL);
+	}
+	pd->panel.timing.upper_margin = data[0];
+	pd->panel.timing.lower_margin = data[1];
+	pd->panel.timing.vsync_len = data[2];
+	pd->panel.timing.yres = data[3];
+
+	of_property_read_u32(np, "samsung,fimd-frame-rate",
+				&pd->panel.timing.refresh);
+
+	of_property_read_u32(np, "samsung,default-window", &pd->default_win);
+
+	of_property_read_u32(np, "samsung,fimd-win-bpp", &pd->bpp);
+
+	return pd;
+}
+#else
+static struct exynos_drm_fimd_pdata *drm_fimd_dt_parse_pdata(struct device *dev)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
 static int __devinit fimd_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct fimd_context *ctx;
 	struct exynos_drm_subdrv *subdrv;
-	struct exynos_drm_fimd_pdata *pdata;
+	struct exynos_drm_fimd_pdata *pdata = pdev->dev.platform_data;
 	struct exynos_drm_panel_info *panel;
 	struct resource *res;
 	int win;
@@ -822,7 +897,11 @@ static int __devinit fimd_probe(struct platform_device *pdev)
 
 	DRM_DEBUG_KMS("%s\n", __FILE__);
 
-	pdata = pdev->dev.platform_data;
+	if (pdev->dev.of_node) {
+		pdata = drm_fimd_dt_parse_pdata(&pdev->dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
 	if (!pdata) {
 		dev_err(dev, "no platform data specified\n");
 		return -EINVAL;
@@ -1011,6 +1090,17 @@ static struct platform_device_id fimd_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, fimd_driver_ids);
 
+#ifdef CONFIG_OF
+static const struct of_device_id fimd_dt_match[] = {
+	{ .compatible = "samsung,exynos5-fimd",
+	  .data	= &exynos5_fimd_driver_data },
+	{ .compatible = "samsung,exynos4-fimd",
+	  .data = &exynos4_fimd_driver_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, fimd_dt_match);
+#endif
+
 static const struct dev_pm_ops fimd_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(fimd_suspend, fimd_resume)
 	SET_RUNTIME_PM_OPS(fimd_runtime_suspend, fimd_runtime_resume, NULL)
@@ -1024,5 +1114,6 @@ struct platform_driver fimd_driver = {
 		.name	= "exynos4-fb",
 		.owner	= THIS_MODULE,
 		.pm	= &fimd_pm_ops,
+		.of_match_table = of_match_ptr(fimd_dt_match),
 	},
 };
-- 
1.7.0.4
