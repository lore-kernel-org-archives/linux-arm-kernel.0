From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 11 Apr 2013 17:00:18 +0200
Subject: [PATCH 4/8] video: atmel_lcdfb: add device tree suport
In-Reply-To: <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130411145741.GB25242@game.jcrosoft.org>
 <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1365692422-9565-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

get display timings from device tree
Use videomode helpers to get display timings and configurations from
device tree

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-fbdev at vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 .../devicetree/bindings/video/atmel,lcdc.txt       |   75 ++++++
 drivers/video/Kconfig                              |    2 +
 drivers/video/atmel_lcdfb.c                        |  244 +++++++++++++++++---
 3 files changed, 289 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/atmel,lcdc.txt

diff --git a/Documentation/devicetree/bindings/video/atmel,lcdc.txt b/Documentation/devicetree/bindings/video/atmel,lcdc.txt
new file mode 100644
index 0000000..1ec175e
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/atmel,lcdc.txt
@@ -0,0 +1,75 @@
+Atmel LCDC Framebuffer
+-----------------------------------------------------
+
+Required properties:
+- compatible :
+	"atmel,at91sam9261-lcdc" , 
+	"atmel,at91sam9263-lcdc" ,
+	"atmel,at91sam9g10-lcdc" ,
+	"atmel,at91sam9g45-lcdc" ,
+	"atmel,at91sam9g45es-lcdc" ,
+	"atmel,at91sam9rl-lcdc" ,
+	"atmel,at32ap-lcdc"
+- reg : Should contain 1 register ranges(address and length)
+- interrupts : framebuffer controller interrupt
+- display: a phandle pointing to the display node
+
+Required nodes:
+- display: a display node is required to initialize the lcd panel
+	This should be in the board dts.
+- default-mode: a videomode within the display with timing parameters
+	as specified below.
+
+Example:
+
+	fb0: fb at 0x00500000 {
+		compatible = "atmel,at91sam9g45-lcdc";
+		reg = <0x00500000 0x1000>;
+		interrupts = <23 3 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_fb>;
+		display = <&display0>;
+		status = "okay";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+	};
+
+Atmel LCDC Display
+-----------------------------------------------------
+Required properties (as per of_videomode_helper):
+
+ - atmel,dmacon: dma controler configuration
+ - atmel,lcdcon2: lcd controler configuration
+ - atmel,guard-time: lcd guard time (Delay in frame periods)
+ - bits-per-pixel: lcd panel bit-depth.
+
+Optional properties (as per of_videomode_helper):
+ - atmel,lcdcon-backlight: enable backlight
+ - atmel,lcd-wiring-mode: lcd wiring mode "RGB" or "BRG"
+ - atmel,power-control-gpio: gpio to power on or off the LCD (as many as needed)
+
+Example:
+	display0: display {
+		bits-per-pixel = <32>;
+		atmel,lcdcon-backlight;
+		atmel,dmacon = <0x1>;
+		atmel,lcdcon2 = <0x80008002>;
+		atmel,guard-time = <9>;
+		atmel,lcd-wiring-mode = <1>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency = <9000000>;
+				hactive = <480>;
+				vactive = <272>;
+				hback-porch = <1>;
+				hfront-porch = <1>;
+				vback-porch = <40>;
+				vfront-porch = <1>;
+				hsync-len = <45>;
+				vsync-len = <1>;
+			};
+		};
+	};
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4c1546f..0687482 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1018,6 +1018,8 @@ config FB_ATMEL
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_MODE_HELPERS
+	select OF_VIDEOMODE
 	help
 	  This enables support for the AT91/AT32 LCD Controller.
 
diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index f67e226..4a31570 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -20,7 +20,11 @@
 #include <linux/gfp.h>
 #include <linux/module.h>
 #include <linux/platform_data/atmel.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <video/of_display_timing.h>
+#include <video/videomode.h>
 
 #include <mach/cpu.h>
 #include <asm/gpio.h>
@@ -59,6 +63,13 @@ struct atmel_lcdfb_info {
 	struct atmel_lcdfb_config *config;
 };
 
+struct atmel_lcdfb_power_ctrl_gpio {
+	int gpio;
+	int active_low;
+
+	struct list_head list;
+};
+
 #define lcdc_readl(sinfo, reg)		__raw_readl((sinfo)->mmio+(reg))
 #define lcdc_writel(sinfo, reg, val)	__raw_writel((val), (sinfo)->mmio+(reg))
 
@@ -945,16 +956,187 @@ static void atmel_lcdfb_stop_clock(struct atmel_lcdfb_info *sinfo)
 	clk_disable(sinfo->lcdc_clk);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id atmel_lcdfb_dt_ids[] = {
+	{ .compatible = "atmel,at91sam9261-lcdc" , .data = &at91sam9261_config, },
+	{ .compatible = "atmel,at91sam9263-lcdc" , .data = &at91sam9263_config, },
+	{ .compatible = "atmel,at91sam9g10-lcdc" , .data = &at91sam9g10_config, },
+	{ .compatible = "atmel,at91sam9g45-lcdc" , .data = &at91sam9g45_config, },
+	{ .compatible = "atmel,at91sam9g45es-lcdc" , .data = &at91sam9g45es_config, },
+	{ .compatible = "atmel,at91sam9rl-lcdc" , .data = &at91sam9rl_config, },
+	{ .compatible = "atmel,at32ap-lcdc" , .data = &at32ap_config, },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, atmel_lcdfb_dt_ids);
+
+static const char *atmel_lcdfb_wiring_modes[] = {
+	[ATMEL_LCDC_WIRING_BGR]	= "BRG",
+	[ATMEL_LCDC_WIRING_RGB]	= "RGB",
+};
+
+const int atmel_lcdfb_get_of_wiring_modes(struct device_node *np)
+{
+	const char *mode;
+	int err, i;
+
+	err = of_property_read_string(np, "atmel,lcd-wiring-mode", &mode);
+	if (err < 0)
+		return ATMEL_LCDC_WIRING_BGR;
+
+	for (i = 0; i < ARRAY_SIZE(atmel_lcdfb_wiring_modes); i++)
+		if (!strcasecmp(mode, atmel_lcdfb_wiring_modes[i]))
+			return i;
+
+	return -ENODEV;
+}
+
+static void atmel_lcdfb_power_control_gpio(struct atmel_lcdfb_pdata *pdata, int on)
+{
+	struct atmel_lcdfb_power_ctrl_gpio *og;
+
+	list_for_each_entry(og, &pdata->pwr_gpios, list)
+		gpio_set_value(og->gpio, on);
+}
+
+static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
+{
+	struct fb_info *info = sinfo->info;
+	struct atmel_lcdfb_pdata *pdata = &sinfo->pdata;
+	struct fb_var_screeninfo *var = &info->var;
+	struct device *dev = &sinfo->pdev->dev;
+	struct device_node *np =dev->of_node;
+	struct device_node *display_np;
+	struct device_node *timings_np;
+	struct display_timings *timings;
+	enum of_gpio_flags flags;
+	struct atmel_lcdfb_power_ctrl_gpio *og;
+	bool is_gpio_power = false;
+	int ret = -ENOENT;
+	int i, gpio;
+
+	sinfo->config = (struct atmel_lcdfb_config*)
+		of_match_device(atmel_lcdfb_dt_ids, dev)->data;
+
+	display_np = of_parse_phandle(np, "display", 0);
+	if (!display_np) {
+		dev_err(dev, "failed to find display phandle\n");
+		return -ENOENT;
+	}
+
+	ret = of_property_read_u32(display_np, "bits-per-pixel", &var->bits_per_pixel);
+	if (ret < 0) {
+		dev_err(dev, "failed to get property bits-per-pixel\n");
+		goto put_display_node;
+	}
+
+	ret = of_property_read_u32(display_np, "atmel,guard-time", &pdata->guard_time);
+	if (ret < 0) {
+		dev_err(dev, "failed to get property atmel,guard-time\n");
+		goto put_display_node;
+	}
+
+	ret = of_property_read_u32(display_np, "atmel,lcdcon2", &pdata->default_lcdcon2);
+	if (ret < 0) {
+		dev_err(dev, "failed to get property atmel,lcdcon2\n");
+		goto put_display_node;
+	}
+
+	ret = of_property_read_u32(display_np, "atmel,dmacon", &pdata->default_dmacon);
+	if (ret < 0) {
+		dev_err(dev, "failed to get property bits-per-pixel\n");
+		goto put_display_node;
+	}
+
+	ret = -ENOMEM;
+	for (i = 0; i < of_gpio_named_count(display_np, "atmel,power-control-gpio"); i++) {
+		gpio = of_get_named_gpio_flags(display_np, "atmel,power-control-gpio",
+					       i, &flags);
+		if (gpio < 0)
+			continue;
+
+		og = devm_kzalloc(dev, sizeof(*og), GFP_KERNEL);
+		if (!og)
+			goto put_display_node;
+
+		og->gpio = gpio;
+		og->active_low = flags & OF_GPIO_ACTIVE_LOW;
+		is_gpio_power = true;
+		ret = devm_gpio_request(dev, gpio, "lcd-power-control-gpio");
+		if (ret) {
+			dev_err(dev, "request gpio %d failed\n", gpio);
+			goto put_display_node;
+		}
+
+		ret = gpio_direction_output(gpio, og->active_low);
+		if (ret) {
+			dev_err(dev, "set direction output gpio %d failed\n", gpio);
+			goto put_display_node;
+		}
+	}
+
+	if (is_gpio_power)
+		pdata->atmel_lcdfb_power_control = atmel_lcdfb_power_control_gpio;
+
+	ret = atmel_lcdfb_get_of_wiring_modes(display_np);
+	if (ret < 0) {
+		dev_err(dev, "invalid atmel,lcd-wiring-mode\n");
+		goto put_display_node;
+	}
+	pdata->lcd_wiring_mode = ret;
+
+	pdata->lcdcon_is_backlight = of_property_read_bool(display_np, "atmel,lcdcon-backlight");
+
+	timings = of_get_display_timings(display_np);
+	if (!timings) {
+		dev_err(dev, "failed to get display timings\n");
+		goto put_display_node;
+	}
+
+	timings_np = of_find_node_by_name(display_np, "display-timings");
+	if (!timings_np) {
+		dev_err(dev, "failed to find display-timings node\n");
+		goto put_display_node;
+	}
+
+	for (i = 0; i < of_get_child_count(timings_np); i++) {
+		struct videomode vm;
+		struct fb_videomode fb_vm;
+
+		ret = videomode_from_timing(timings, &vm, i);
+		if (ret < 0)
+			goto put_timings_node;
+		ret = fb_videomode_from_videomode(&vm, &fb_vm);
+		if (ret < 0)
+			goto put_timings_node;
+
+		fb_add_videomode(&fb_vm, &info->modelist);
+	}
+
+	return 0;
+
+put_timings_node:
+	of_node_put(timings_np);
+put_display_node:
+	of_node_put(display_np);
+	return ret;
+}
+#else
+static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
+{
+	return 0;
+}
+#endif
 
 static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct fb_info *info;
 	struct atmel_lcdfb_info *sinfo;
-	struct atmel_lcdfb_pdata *pdata;
-	struct fb_videomode fbmode;
+	struct atmel_lcdfb_pdata *pdata = NULL;
 	struct resource *regs = NULL;
 	struct resource *map = NULL;
+	struct fb_modelist *modelist;
 	int ret;
 
 	dev_dbg(dev, "%s BEGIN\n", __func__);
@@ -967,17 +1149,35 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 	}
 
 	sinfo = info->par;
+	sinfo->pdev = pdev;
+	sinfo->info = info;
+
+	INIT_LIST_HEAD(&info->modelist);
 
-	if (dev->platform_data) {
-		pdata = (struct atmel_lcdfb_pdata *)dev->platform_data;
+	if (pdev->dev.of_node) {
+		ret = atmel_lcdfb_of_init(sinfo);
+		if (ret)
+			goto free_info;
+	} else if (dev->platform_data) {
+		struct fb_monspecs *monspecs;
+		int i;
+
+		pdata = dev->platform_data;
+		monspecs = pdata->default_monspecs;
 		sinfo->pdata = *pdata;
+
+		for (i = 0; i < monspecs->modedb_len; i++)
+			fb_add_videomode(&monspecs->modedb[i], &info->modelist);
+
+		sinfo->config = atmel_lcdfb_get_config(pdev);
+
+		info->var.bits_per_pixel = pdata->default_bpp ? pdata->default_bpp : 16;
+		memcpy(&info->monspecs, pdata->default_monspecs, sizeof(info->monspecs));
 	} else {
 		dev_err(dev, "cannot get default configuration\n");
 		goto free_info;
 	}
-	sinfo->info = info;
-	sinfo->pdev = pdev;
-	sinfo->config = atmel_lcdfb_get_config(pdev);
+
 	if (!sinfo->config)
 		goto free_info;
 
@@ -986,7 +1186,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 	info->pseudo_palette = sinfo->pseudo_palette;
 	info->fbops = &atmel_lcdfb_ops;
 
-	memcpy(&info->monspecs, pdata->default_monspecs, sizeof(info->monspecs));
 	info->fix = atmel_lcdfb_fix;
 
 	/* Enable LCDC Clocks */
@@ -1002,14 +1201,11 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 	}
 	atmel_lcdfb_start_clock(sinfo);
 
-	ret = fb_find_mode(&info->var, info, NULL, info->monspecs.modedb,
-			info->monspecs.modedb_len, info->monspecs.modedb,
-			pdata->default_bpp);
-	if (!ret) {
-		dev_err(dev, "no suitable video mode found\n");
-		goto stop_clk;
-	}
+	modelist = list_first_entry(&info->modelist,
+			struct fb_modelist, list);
+	fb_videomode_to_var(&info->var, &modelist->mode);
 
+	atmel_lcdfb_check_var(&info->var, info);
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs) {
@@ -1093,18 +1289,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 		goto unregister_irqs;
 	}
 
-	/*
-	 * This makes sure that our colour bitfield
-	 * descriptors are correctly initialised.
-	 */
-	atmel_lcdfb_check_var(&info->var, info);
-
-	ret = fb_set_var(info, &info->var);
-	if (ret) {
-		dev_warn(dev, "unable to set display parameters\n");
-		goto free_cmap;
-	}
-
 	dev_set_drvdata(dev, info);
 
 	/*
@@ -1116,10 +1300,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 		goto reset_drvdata;
 	}
 
-	/* add selected videomode to modelist */
-	fb_var_to_videomode(&fbmode, &info->var);
-	fb_add_videomode(&fbmode, &info->modelist);
-
 	/* Power up the LCDC screen */
 	atmel_lcdfb_power_control(sinfo, 1);
 
@@ -1130,7 +1310,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 
 reset_drvdata:
 	dev_set_drvdata(dev, NULL);
-free_cmap:
 	fb_dealloc_cmap(&info->cmap);
 unregister_irqs:
 	cancel_work_sync(&sinfo->task);
@@ -1249,6 +1428,7 @@ static struct platform_driver atmel_lcdfb_driver = {
 	.driver		= {
 		.name	= "atmel_lcdfb",
 		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(atmel_lcdfb_dt_ids),
 	},
 };
 
-- 
1.7.10.4
