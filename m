From: denis@eukrea.com (Denis Carikli)
Date: Mon,  4 Nov 2013 17:15:21 +0100
Subject: [PATCHv4][ 3/6] video: mx3fb: Add device tree suport.
In-Reply-To: <1383581724-14817-1-git-send-email-denis@eukrea.com>
References: <1383581724-14817-1-git-send-email-denis@eukrea.com>
Message-ID: <1383581724-14817-3-git-send-email-denis@eukrea.com>
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
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v3->v4:
- Updated bindings.
- Updated documentation accordinly.
- Updated code accordinly.
- Fixed the lack of "ret =" in
  of_property_read_string(display_np, "model", &name);
- Supressed some compilation warnings.

ChangeLog v2->v3:
- The device tree bindings were reworked in order to make it look more like the
  IPUv3 bindings.
- The interface_pix_fmt property now looks like the IPUv3 one.
---
 .../devicetree/bindings/video/fsl,mx3-fb.txt       |   42 +++++++
 drivers/video/Kconfig                              |    2 +
 drivers/video/mx3fb.c                              |  119 +++++++++++++++++---
 3 files changed, 148 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/fsl,mx3-fb.txt

diff --git a/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt b/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
new file mode 100644
index 0000000..60faff5
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
@@ -0,0 +1,42 @@
+Freescale MX3 framebuffer.
+==========================
+
+Required properties:
+- compatible: Should be "fsl,mx3fb". compatible chips include the imx31 and the
+  imx35.
+- reg: should be register base and length as documented in the datasheet.
+- clocks: Handle to the ipu_gate clock.
+- display: Phandle to a "fsl,mx3-parallel-display" compatible display node.
+
+Example:
+
+lcdc: mx3fb at 53fc00b4 {
+	compatible = "fsl,mx3-fb";
+	reg = <0x53fc00b4 0x0b>;
+	clocks = <&clks 55>;
+};
+
+Display support
+===============
+Required properties:
+- compatible: Should be "fsl,mx3-parallel-display".
+- model : The user-visible name of the display.
+
+Optional properties:
+- interface_pix_fmt: How this display is connected to the
+  crtc. Currently supported types: "rgb24", "rgb565", "rgb666".
+
+It can also have an optional timing subnode as described in
+  Documentation/devicetree/bindings/video/display-timing.txt.
+
+Example:
+
+display0: display at di0 {
+	compatible = "fsl,mx3-parallel-display";
+	interface-pix-fmt = "rgb666";
+	model = "CMO-QVGA";
+};
+
+&lcdc {
+	display = <&display0>;
+}
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 84b685f..edcfa33 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2357,6 +2357,8 @@ config FB_MX3
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select VIDEOMODE_HELPERS
+	select FB_MODE_HELPERS
 	default y
 	help
 	  This is a framebuffer device for the i.MX31 LCD Controller. So
diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index cfdb380..75087c8 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -31,6 +31,8 @@
 #include <linux/platform_data/dma-imx.h>
 #include <linux/platform_data/video-mx3fb.h>
 
+#include <video/of_display_timing.h>
+
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
@@ -757,11 +759,13 @@ static int __set_par(struct fb_info *fbi, bool lock)
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
@@ -1351,21 +1355,69 @@ static struct fb_info *mx3fb_init_fbinfo(struct device *dev, struct fb_ops *ops)
 	return fbi;
 }
 
+static int match_dt_disp_data(const char *property)
+{
+	if (!strcmp("rgb666", property))
+		return IPU_DISP_DATA_MAPPING_RGB666;
+	else if (!strcmp("rgb565", property))
+		return IPU_DISP_DATA_MAPPING_RGB565;
+	else if (!strcmp("rgb24", property))
+		return IPU_DISP_DATA_MAPPING_RGB888;
+	else
+		return -EINVAL;
+}
+
 static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 {
 	struct device *dev = mx3fb->dev;
 	struct mx3fb_platform_data *mx3fb_pdata = dev->platform_data;
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
+	struct device_node *display_np;
+
+	if (np) {
+		display_np = of_parse_phandle(np, "display", 0);
+		if (!display_np) {
+			dev_err(dev, "Can't get the display device node.\n");
+			return -EINVAL;
+		}
+
+		of_property_read_string(display_np, "interface-pix-fmt",
+					&ipu_disp_format);
+		if (!ipu_disp_format) {
+			mx3fb->disp_data_fmt = IPU_DISP_DATA_MAPPING_RGB666;
+			dev_warn(dev,
+				"ipu display data mapping was not defined, using the default rgb666.\n");
+		} else {
+			mx3fb->disp_data_fmt =
+				match_dt_disp_data(ipu_disp_format);
+		}
+
+		if (mx3fb->disp_data_fmt == -EINVAL) {
+			dev_err(dev, "Illegal display data format \"%s\"\n",
+				ipu_disp_format);
+			return -EINVAL;
+		}
 
-	if (mx3fb_pdata->disp_data_fmt >= ARRAY_SIZE(di_mappings)) {
-		dev_err(dev, "Illegal display data format %d\n",
+		ret = of_property_read_string(display_np, "model", &name);
+		if (ret) {
+			dev_err(dev, "Missing display model name\n");
+			return -EINVAL;
+		}
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
@@ -1386,12 +1438,24 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 		goto emode;
 	}
 
-	if (mx3fb_pdata->mode && mx3fb_pdata->num_modes) {
-		mode = mx3fb_pdata->mode;
-		num_modes = mx3fb_pdata->num_modes;
+	if (np) {
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
@@ -1421,7 +1485,8 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 	mx3fbi->mx3fb		= mx3fb;
 	mx3fbi->blank		= FB_BLANK_NORMAL;
 
-	mx3fb->disp_data_fmt	= mx3fb_pdata->disp_data_fmt;
+	if (!np)
+		mx3fb->disp_data_fmt = mx3fb_pdata->disp_data_fmt;
 
 	init_completion(&mx3fbi->flip_cmpl);
 	disable_irq(ichan->eof_irq);
@@ -1449,13 +1514,26 @@ emode:
 	return ret;
 }
 
+static int imx_dma_is_dt_ipu(struct dma_chan *chan)
+{
+	/* Example: 53fc0000.ipu */
+	if (chan && chan->device && chan->device->dev) {
+		const char *name = dev_name(chan->device->dev);
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
@@ -1464,8 +1542,12 @@ static bool chan_filter(struct dma_chan *chan, void *arg)
 	dev = rq->mx3fb->dev;
 	mx3fb_pdata = dev->platform_data;
 
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
@@ -1565,9 +1647,16 @@ static int mx3fb_remove(struct platform_device *dev)
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
