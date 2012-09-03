From: pawel.moll@arm.com (Pawel Moll)
Date: Mon,  3 Sep 2012 17:25:24 +0100
Subject: [PATCH 04/11] misc: Versatile Express display muxer driver
In-Reply-To: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1346689531-7212-5-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Versatile Express video output can be connected to one the three
sources - motherboard's CLCD controller or a video signal generated
by one of the daughterboards.

This driver configures the muxer FPGA so the output displays
content of one of the framebuffers in the system (0 by default,
can be changed by user writing to "fb" attribute of the muxfpga
device). The decision is based on an educated guess in case of
DT-less system or on the "arm,vexpress,site" property of the
display controller's DT node.

It will also set up the display formatter mode and keep it up
to date with mode changes requested by the user (eg. with fbset
tool).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 Documentation/devicetree/bindings/arm/vexpress.txt |   19 ++
 drivers/misc/vexpress/Makefile                     |    1 +
 drivers/misc/vexpress/display.c                    |  197 ++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 drivers/misc/vexpress/display.c

diff --git a/Documentation/devicetree/bindings/arm/vexpress.txt b/Documentation/devicetree/bindings/arm/vexpress.txt
index 8f69b6b..832a63a 100644
--- a/Documentation/devicetree/bindings/arm/vexpress.txt
+++ b/Documentation/devicetree/bindings/arm/vexpress.txt
@@ -232,6 +232,16 @@ device number.
   value, in two consecutive registers.
 
 
+Display controller nodes
+------------------------
+
+All nodes describing display controllers connected to the VE's
+multimedia bus (that is CLCD and HDLCD) should contain the
+"arm,vexpress,site" property (see the previous section for
+possible values) describing the controller's location in the
+system.
+
+
 Example of a VE tile description (simplified)
 ---------------------------------------------
 
@@ -279,6 +289,15 @@ Example of a VE tile description (simplified)
 		interrupt-map = <0 0 0 &gic 0 0 4>;
 	};
 
+	hdlcd at 2b000000 {
+		compatible = "arm,hdlcd";
+		reg = <0 0x2b000000 0 0x1000>;
+		interrupts = <0 85 4>;
+		arm,vexpress,site = <0xff>;
+		clocks = <&oscclk3>;
+		clock-names = "pxlclk";
+	};
+
 	dcc at 0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/drivers/misc/vexpress/Makefile b/drivers/misc/vexpress/Makefile
index af11749..d83d6b6 100644
--- a/drivers/misc/vexpress/Makefile
+++ b/drivers/misc/vexpress/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_VEXPRESS_CONFIG_BUS) += config_bus.o
+obj-$(CONFIG_VEXPRESS_CONFIG_BUS) += display.o
 obj-$(CONFIG_VEXPRESS_CONFIG_BUS) += reset.o
diff --git a/drivers/misc/vexpress/display.c b/drivers/misc/vexpress/display.c
new file mode 100644
index 0000000..c439925
--- /dev/null
+++ b/drivers/misc/vexpress/display.c
@@ -0,0 +1,197 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2012 ARM Limited
+ */
+
+#include <linux/fb.h>
+#include <linux/vexpress.h>
+
+
+static struct vexpress_config_device *vexpress_dvimode_device;
+
+static struct {
+	u32 xres, yres, mode;
+} vexpress_display_dvimodes[] = {
+	{ 640, 480, 0 }, /* VGA */
+	{ 800, 600, 1 }, /* SVGA */
+	{ 1024, 768, 2 }, /* XGA */
+	{ 1280, 1024, 3 }, /* SXGA */
+	{ 1600, 1200, 4 }, /* UXGA */
+	{ 1920, 1080, 5 }, /* HD1080 */
+};
+
+static void vexpress_display_mode_set(struct fb_info *info, u32 xres, u32 yres)
+{
+	int err = -ENOENT;
+	int i;
+
+	if (!vexpress_dvimode_device)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(vexpress_display_dvimodes); i++) {
+		if (vexpress_display_dvimodes[i].xres == xres &&
+				vexpress_display_dvimodes[i].yres == yres) {
+			dev_dbg(&vexpress_dvimode_device->dev,
+					"mode: %ux%u = %d\n", xres, yres,
+					vexpress_display_dvimodes[i].mode);
+			err = vexpress_config_write(vexpress_dvimode_device, 0,
+					vexpress_display_dvimodes[i].mode);
+			break;
+		}
+	}
+
+	if (err)
+		dev_warn(&vexpress_dvimode_device->dev,
+				"Failed to set %ux%u mode! (%d)\n",
+				xres, yres, err);
+}
+
+
+static struct vexpress_config_device *vexpress_muxfpga_device;
+static int vexpress_display_fb = -1;
+
+static int vexpress_display_fb_select(int fb)
+{
+	int err = 0;
+	struct fb_info *info = registered_fb[fb];
+	u32 site;
+	struct device *device;
+
+	if (!info || !lock_fb_info(info))
+		return -ENODEV;
+
+	device = info->device;
+
+	/* No DT means V2P-CA9, so assume master site if it's a CLCD */
+	if (!device->of_node) {
+		site = VEXPRESS_SITE_MASTER;
+		if (strcmp(device->driver->name, "clcd-pl11x") != 0)
+			err = -EINVAL;
+	} else {
+		err = of_property_read_u32(device->of_node,
+				"arm,vexpress,site", &site);
+		if (err)
+			dev_warn(&vexpress_muxfpga_device->dev,
+					"No site property found!");
+	}
+
+	if (!err) {
+		if (site == VEXPRESS_SITE_MASTER)
+			site = vexpress_config_get_master_site();
+
+		err = vexpress_config_write(vexpress_muxfpga_device, 0, site);
+		if (!err) {
+			dev_dbg(&vexpress_muxfpga_device->dev,
+					"Selected MUXFPGA input %d (fb%d)\n",
+					site, fb);
+			vexpress_display_fb = fb;
+			vexpress_display_mode_set(info, info->var.xres,
+					info->var.yres);
+		} else {
+			dev_warn(&vexpress_muxfpga_device->dev,
+					"Failed to select MUXFPGA input %d (fb%d)! (%d)\n",
+					site, fb, err);
+		}
+	}
+
+	unlock_fb_info(info);
+
+	return err;
+}
+
+static ssize_t vexpress_display_fb_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", vexpress_display_fb);
+}
+
+static ssize_t vexpress_display_fb_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	long value;
+	int err = kstrtol(buf, 0, &value);
+
+	if (!err)
+		err = vexpress_display_fb_select(value);
+
+	return err ? err : count;
+}
+
+DEVICE_ATTR(fb, S_IRUGO | S_IWUSR, vexpress_display_fb_show,
+		vexpress_display_fb_store);
+
+
+static int vexpress_display_fb_event_notify(struct notifier_block *self,
+			      unsigned long action, void *data)
+{
+	struct fb_event *event = data;
+	struct fb_info *info = event->info;
+	struct fb_videomode *mode = event->data;
+
+	switch (action) {
+	case FB_EVENT_FB_REGISTERED:
+		if (vexpress_display_fb < 0)
+			vexpress_display_fb_select(info->node);
+		break;
+	case FB_EVENT_MODE_CHANGE:
+	case FB_EVENT_MODE_CHANGE_ALL:
+		if (info->node == vexpress_display_fb)
+			vexpress_display_mode_set(info, mode->xres, mode->yres);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block vexpress_display_fb_notifier = {
+	.notifier_call = vexpress_display_fb_event_notify,
+};
+
+
+static int vexpress_display_probe(struct vexpress_config_device *vecdev)
+{
+
+	switch (vecdev->func) {
+	case VEXPRESS_CONFIG_FUNC_MUXFPGA:
+		vexpress_muxfpga_device = vecdev;
+		break;
+	case VEXPRESS_CONFIG_FUNC_DVIMODE:
+		vexpress_dvimode_device = vecdev;
+		break;
+	};
+
+	if (vexpress_muxfpga_device && vexpress_dvimode_device) {
+		device_create_file(&vexpress_muxfpga_device->dev,
+				&dev_attr_fb);
+		fb_register_client(&vexpress_display_fb_notifier);
+		vexpress_display_fb_select(0);
+	}
+
+	return 0;
+}
+
+static const unsigned vexpress_display_funcs[] = {
+	VEXPRESS_CONFIG_FUNC_MUXFPGA,
+	VEXPRESS_CONFIG_FUNC_DVIMODE,
+	0,
+};
+
+static struct vexpress_config_driver vexpress_display_driver = {
+	.funcs = vexpress_display_funcs,
+	.probe = vexpress_display_probe,
+	.driver.name = "vexpress-display",
+};
+
+static int __init vexpress_display_init(void)
+{
+	return vexpress_config_driver_register(&vexpress_display_driver);
+}
+device_initcall(vexpress_display_init);
-- 
1.7.9.5
