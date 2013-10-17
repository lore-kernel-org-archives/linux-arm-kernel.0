From: denis@eukrea.com (Denis Carikli)
Date: Thu, 17 Oct 2013 17:02:06 +0200
Subject: [Patch v2][ 08/37] video: mx3fb: Add device tree suport.
In-Reply-To: <1382022155-21954-1-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
Message-ID: <1382022155-21954-9-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev at vger.kernel.org
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 .../devicetree/bindings/video/fsl,mx3-fb.txt       |   52 ++++++++
 drivers/video/Kconfig                              |    2 +
 drivers/video/mx3fb.c                              |  133 +++++++++++++++++---
 3 files changed, 171 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/fsl,mx3-fb.txt

diff --git a/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt b/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
new file mode 100644
index 0000000..ae0b343
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
@@ -0,0 +1,52 @@
+Freescale mx3 Framebuffer
+
+This framebuffer driver supports the imx31 and imx35 devices.
+
+Required properties:
+- compatible : Must be "fsl,mx3-fb".
+- reg : Should contain 1 register ranges(address and length).
+- dmas : Phandle to the ipu dma node as described in
+	Documentation/devicetree/bindings/dma/dma.txt
+- dma-names : Must be "tx".
+- clocks : Phandle to the ipu source clock.
+- display: Phandle to a display node as described in
+	Documentation/devicetree/bindings/video/display-timing.txt
+	Additional, the display node has to define properties:
+	- bits-per-pixel: lcd panel bit-depth.
+
+Optional properties:
+- ipu-disp-format: could be "rgb666", "rgb565", or "rgb888".
+  If not specified defaults to "rgb666".
+
+Example:
+
+	lcdc: mx3fb at 53fc00b4 {
+		compatible = "fsl,mx3-fb";
+		reg = <0x53fc00b4 0x0b>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcdc_1>;
+		clocks = <&clks 55>;
+		dmas = <&ipu 14>;
+		dma-names = "tx";
+	};
+
+	...
+
+	cmo_qvga: display {
+		model = "CMO-QVGA";
+		bits-per-pixel = <16>;
+		native-mode = <&qvga_timings>;
+		display-timings {
+			qvga_timings: 320x240 {
+				clock-frequency = <6500000>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <30>;
+				hfront-porch = <38>;
+				vback-porch = <20>;
+				vfront-porch = <3>;
+				hsync-len = <15>;
+				vsync-len = <4>;
+			};
+		};
+	};
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 14317b7..2a638df 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2359,6 +2359,8 @@ config FB_MX3
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select VIDEOMODE_HELPERS
+	select FB_MODE_HELPERS
 	default y
 	help
 	  This is a framebuffer device for the i.MX31 LCD Controller. So
diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index 37704da..8683dda 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -32,6 +32,8 @@
 #include <linux/platform_data/dma-imx.h>
 #include <linux/platform_data/video-mx3fb.h>
 
+#include <video/of_display_timing.h>
+
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
@@ -759,11 +761,13 @@ static int __set_par(struct fb_info *fbi, bool lock)
 			sig_cfg.Hsync_pol = true;
 		if (fbi->var.sync & FB_SYNC_VERT_HIGH_ACT)
 			sig_cfg.Vsync_pol = true;
-		if (fbi->var.sync & FB_SYNC_CLK_INVERT)
+		if ((fbi->var.sync & FB_SYNC_CLK_INVERT) ||
+		    (fbi->var.sync & FB_SYNC_PIXDAT_HIGH_ACT))
 			sig_cfg.clk_pol = true;
 		if (fbi->var.sync & FB_SYNC_DATA_INVERT)
 			sig_cfg.data_pol = true;
-		if (fbi->var.sync & FB_SYNC_OE_ACT_HIGH)
+		if ((fbi->var.sync & FB_SYNC_OE_ACT_HIGH) ||
+		    (fbi->var.sync & FB_SYNC_DE_HIGH_ACT))
 			sig_cfg.enable_pol = true;
 		if (fbi->var.sync & FB_SYNC_CLK_IDLE_EN)
 			sig_cfg.clkidle_en = true;
@@ -1392,21 +1396,63 @@ static struct fb_info *mx3fb_init_fbinfo(struct device *dev, struct fb_ops *ops)
 	return fbi;
 }
 
+static int match_dt_disp_data(const char *property)
+{
+	if (!strcmp("rgb666", property))
+		return IPU_DISP_DATA_MAPPING_RGB666;
+	else if (!strcmp("rgb565", property))
+		return IPU_DISP_DATA_MAPPING_RGB565;
+	else if (!strcmp("rgb888", property))
+		return IPU_DISP_DATA_MAPPING_RGB888;
+	else
+		return -EINVAL;
+}
+
 static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 {
 	struct device *dev = mx3fb->dev;
 	struct mx3fb_platform_data *mx3fb_pdata = dev_get_platdata(dev);
-	const char *name = mx3fb_pdata->name;
+	struct device_node *np = dev->of_node;
+	const char *name;
+	const char *ipu_disp_format;
 	unsigned int irq;
 	struct fb_info *fbi;
 	struct mx3fb_info *mx3fbi;
 	const struct fb_videomode *mode;
 	int ret, num_modes;
+	struct fb_videomode of_mode;
+	enum disp_data_mapping	disp_data_fmt = IPU_DISP_DATA_MAPPING_RGB666;
+	struct device_node *display_np, *timings_np;
+
+	if (np) {
+		of_property_read_string(np, "ipu-disp-format",
+					&ipu_disp_format);
+		if (!ipu_disp_format) {
+			dev_err(dev, "Can't get ipu display data mapping.\n");
+			return -EINVAL;
+		}
+
+		mx3fb->disp_data_fmt = match_dt_disp_data(ipu_disp_format);
+		if (mx3fb->disp_data_fmt == -EINVAL) {
+			dev_err(dev, "Illegal display data format \"%s\"\n",
+				ipu_disp_format);
+			return -EINVAL;
+		}
 
-	if (mx3fb_pdata->disp_data_fmt >= ARRAY_SIZE(di_mappings)) {
-		dev_err(dev, "Illegal display data format %d\n",
+		display_np = of_parse_phandle(np, "display", 0);
+		if (!display_np) {
+			dev_err(dev, "failed to find display phandle\n");
+			return -ENOENT;
+		}
+
+		of_property_read_string(display_np, "model", &name);
+	} else {
+		name = mx3fb_pdata->name;
+		if (mx3fb_pdata->disp_data_fmt >= ARRAY_SIZE(di_mappings)) {
+			dev_err(dev, "Illegal display data format %d\n",
 				mx3fb_pdata->disp_data_fmt);
-		return -EINVAL;
+			return -EINVAL;
+		}
 	}
 
 	ichan->client = mx3fb;
@@ -1427,12 +1473,39 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 		goto emode;
 	}
 
-	if (mx3fb_pdata->mode && mx3fb_pdata->num_modes) {
-		mode = mx3fb_pdata->mode;
-		num_modes = mx3fb_pdata->num_modes;
+	if (np) {
+		of_property_read_string(np, "ipu-disp-format",
+					&ipu_disp_format);
+		if (!ipu_disp_format) {
+			dev_err(dev, "Can't get ipu display data mapping.\n");
+			return -EINVAL;
+		}
+
+		disp_data_fmt = match_dt_disp_data(ipu_disp_format);
+
+		if (disp_data_fmt == -EINVAL) {
+			dev_err(dev, "Illegal display data format \"%s\" for "
+				"the node %s\n", ipu_disp_format, np->name);
+			return -EINVAL;
+		}
+
+		ret = of_get_fb_videomode(display_np, &of_mode,
+					  OF_USE_NATIVE_MODE);
+		if (!ret) {
+			mode = &of_mode;
+			num_modes = 1;
+		} else {
+			mode = mx3fb_modedb;
+			num_modes = ARRAY_SIZE(mx3fb_modedb);
+		}
 	} else {
-		mode = mx3fb_modedb;
-		num_modes = ARRAY_SIZE(mx3fb_modedb);
+		if (mx3fb_pdata->mode || !mx3fb_pdata->num_modes) {
+			mode = mx3fb_pdata->mode;
+			num_modes = mx3fb_pdata->num_modes;
+		} else {
+			mode = mx3fb_modedb;
+			num_modes = ARRAY_SIZE(mx3fb_modedb);
+		}
 	}
 
 	if (!fb_find_mode(&fbi->var, fbi, fb_mode, mode,
@@ -1462,7 +1535,10 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 	mx3fbi->mx3fb		= mx3fb;
 	mx3fbi->blank		= FB_BLANK_NORMAL;
 
-	mx3fb->disp_data_fmt	= mx3fb_pdata->disp_data_fmt;
+	if (!np)
+		mx3fb->disp_data_fmt = mx3fb_pdata->disp_data_fmt;
+	else
+		mx3fb->disp_data_fmt = disp_data_fmt;
 
 	init_completion(&mx3fbi->flip_cmpl);
 	disable_irq(ichan->eof_irq);
@@ -1494,13 +1570,26 @@ emode:
 	return ret;
 }
 
+static int imx_dma_is_dt_ipu(struct dma_chan *chan)
+{
+	/* Example: 53fc0000.ipu */
+	if (chan && chan->device && chan->device->dev) {
+		char *name = dev_name(chan->device->dev);
+		name = strchr(name, '.');
+		if (name)
+			return !strcmp(name, ".ipu");
+	}
+
+	return 0;
+}
+
 static bool chan_filter(struct dma_chan *chan, void *arg)
 {
 	struct dma_chan_request *rq = arg;
 	struct device *dev;
 	struct mx3fb_platform_data *mx3fb_pdata;
 
-	if (!imx_dma_is_ipu(chan))
+	if (!imx_dma_is_ipu(chan) && !imx_dma_is_dt_ipu(chan))
 		return false;
 
 	if (!rq)
@@ -1509,8 +1598,12 @@ static bool chan_filter(struct dma_chan *chan, void *arg)
 	dev = rq->mx3fb->dev;
 	mx3fb_pdata = dev_get_platdata(dev);
 
-	return rq->id == chan->chan_id &&
-		mx3fb_pdata->dma_dev == chan->device->dev;
+	/* When using the devicetree, mx3fb_pdata is NULL */
+	if (imx_dma_is_dt_ipu(chan))
+		return rq->id == chan->chan_id;
+	else
+		return rq->id == chan->chan_id &&
+			mx3fb_pdata->dma_dev == chan->device->dev;
 }
 
 static void release_fbi(struct fb_info *fbi)
@@ -1567,7 +1660,8 @@ static int mx3fb_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_SLAVE, mask);
 	dma_cap_set(DMA_PRIVATE, mask);
 	rq.id = IDMAC_SDC_0;
-	chan = dma_request_channel(mask, chan_filter, &rq);
+	chan = dma_request_slave_channel_compat(mask, chan_filter, &rq, dev,
+						"tx");
 	if (!chan) {
 		ret = -EBUSY;
 		goto ersdc0;
@@ -1610,9 +1704,16 @@ static int mx3fb_remove(struct platform_device *dev)
 	return 0;
 }
 
+static struct of_device_id mx3fb_of_dev_id[] = {
+	{ .compatible = "fsl,mx3-fb", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mx3fb_of_dev_id);
+
 static struct platform_driver mx3fb_driver = {
 	.driver = {
 		.name = MX3FB_NAME,
+		.of_match_table = mx3fb_of_dev_id,
 		.owner = THIS_MODULE,
 	},
 	.probe = mx3fb_probe,
-- 
1.7.9.5
