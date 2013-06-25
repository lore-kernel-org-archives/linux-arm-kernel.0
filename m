From: dsd@laptop.org (Daniel Drake)
Date: Tue, 25 Jun 2013 16:47:26 -0400 (EDT)
Subject: Armada DRM driver on OLPC XO
Message-ID: <20130625204726.BF65C12647A@dev.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks a lot for writing the Armada DRM driver.

I have tested it on OLPC XO-1.75 (MMP2 aka Armada610) and OLPC XO-4 (MMP3
aka PXA2128). After a bit of fighting, I have it running. Could you share your
X driver, or your methodology for testing hardware cursors? I'd like to test
your work there too.

It's probably easiest to get your cubox driver merged before adding MMP2/MMP3
complications into the mix. At that point, I will hopefully have time to
follow up developing MMP2/MMP3 support, which will involve the points
mentioned below.

A hacky patch is also included below, which makes the driver run on this
platform. I'm prepared to do the heavy lifting in implementing these changes
properly, but any high level guidance would be appreciated, especially as I
am new to the world of graphics.

Ordered roughly from highest to lowest importance:


1. Device tree support
The OLPC XO boots entirely from the device tree, all clocks and things are
defined there. Your current display controller driver is close to
DT-compatibility, the only tricky bit is:
?? ?? ?? ?? ?? ?? ?? ??clk = clk_get_sys("dovefb.0", "extclk");

Not sure how that would translate to DT, or if we can transform that into
something that works for both DT and platform devices. The norm in DT is
that a clock is associated to a specific device, so we could just pull it
off the platform device itself.


2. Panel support.
>From my reading of your patches, on the cubox you drive the hardware as if it
is connected to a panel, but actually it is connected to an encoder chip which
outputs a HDMI signal?
In the OLPC case, we actually have a dumb panel connected to the panel
interface, so we need some driver support there.

The panel definition should come from the device tree, but I already hit a
small headache there. The display controller driver (armada_drv) gets probed
before my panel driver, and armada_drm_load() is not happy if it completes
without a connector/encoder registered. We will either have to force a probe
order somehow, or make the driver be happy to be loaded without a
connector/encoder which would then appear later.


3. Register space conflicts
Already found a couple of register conflicts between your dove and the MMP
platforms. Your LCD_SPU_ADV_REG is something completely different here.

The high bits of the DMA_CTRL0 register is used to select a clock. ??In the
dove and MMP2 case these bits are 31:30 but on MMP3 this is 31:29. Also, OLPC
uses this field to select the LCD clock as a clock source, but your driver
chooses another clock for cubox. So we need ways to represent all of these
differences.


4. Video memory
The driver at the moment requires an area of RAM as video memory, but this
must actually be memory that Linux does not regard as normal available RAM,
since ioremap() is called on it. I guess in your platform code you look at
how much RAM is available and cut out a chunk for graphics memory. Then when
communicating to the MM core how much RAM is available, you do not tell it
about the graphics memory?

I realise I'm talking to the ARM MM guru here, but... can we do better? The
decision to have to "cut out" the memory as above would have to be made during
early boot, before we know if we even have a graphics driver to come along and
make use of that memory. In my case I have similarly hacked our firmware to do
the "cut out" operation when finalizing the DT before booting the kernel.

I would have hoped in a world with CMA and things like that we could now do a
bit better. I tried creating a coherent DMA allocation in armada_drm_load() to
be used as video memory, but this failed later when armada_gem_linear_back()
tried to ioremap it (you probably don't need reminding that ioremap on memory
otherwise available as RAM fails, http://lwn.net/Articles/409689/).

I realise that I can avoid that particular ioremap since we already have the
virtual address available, but I am left wondering how this memory is
accessed by DRM/GEM in other contexts (e.g. when it wants to write image data
in there). If that uses ioremap() as well, then we are in trouble.



5. Output paths

This is something we'll have to address for HDMI output support on OLPC, which
is the lowest priority item on this list, lets get the inbuilt panel going
first!

The way I read your code is that up to 2 CRTC addresses can be defined in
platform data. Each one then gets passed to armada_drm_crtc_create() and the
address is used as a base for register accesses.

Does that mean that the register list in the big armada_hw.h enum is
essentially duplicated exactly? Almost as if the system has 2 separate display
controllers?

Your register list essentially starts at offset 0xc0. What can be found at
offsets below that address?

On MMP2/MMP3 the situation is a bit different. 3 output paths are supported
- two panel paths, and one TV path (which is HDMI - direct output from the
SoC, no separate encoder chip necessary).

These paths are closely related, probably not as far separated as your
"dual CRTC" dove model. ??For example, up to 9 overlays are supported, but if
you have 6 of them running on the TV path then you only have 3 available for
use on the panel path. If you only activate one path then you can use all 9
there. etc.

The intertwiny-ness is also reflected in the register space.
0x00 to 0xC0 is a set of registers for the TV path.
0xC0 to 0x180 is a set of registers for the panel path (used by your driver).
0x180 to 0x200 appears that someone placed some panel1, panel2 and TV
registers in a bag and shook it around a bit.
0x200 is the start of a set of registers for the TV path.
And at 0x280 another register pick-n-mix begins.

The paths are not even as separated as it might sound. Your driver was
coincidentally setting a bit somewhere that caused the panel1 path output to
be redirected to the TV path.

So we may have some fun ahead, making this driver support the nicely-separated
dual output of the dove, plus the twisty output paths of MMP2/MMP3.

You can look at drivers/video/mmp (particularly hw/mmp_ctrl.*) for an example
of how to work with paths and the associated messy register space. However,
I am optimistic that we could find a nicer way to code this for armada_drm.



I will work on getting you an XO in case you are interested in testing the
driver there from time to time or even helping to develop support. But first I
need to get it bootable on mainline kernels (patches posted, waiting for
review).

Thanks!
Daniel


diff --git a/drivers/gpu/drm/armada/Makefile b/drivers/gpu/drm/armada/Makefile
index 430f025..aff908f 100644
--- a/drivers/gpu/drm/armada/Makefile
+++ b/drivers/gpu/drm/armada/Makefile
@@ -1,6 +1,6 @@
 armada-y	:= armada_crtc.o armada_drv.o armada_fb.o armada_fbdev.o \
 		   armada_gem.o armada_output.o armada_overlay.o \
-		   armada_slave.o
+		   armada_slave.o dumb_panel.o
 armada-$(CONFIG_DEBUG_FS) += armada_debugfs.o
 
 obj-$(CONFIG_DRM_ARMADA) := armada.o
diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index e5ab4cb..85f4d34 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -493,8 +493,16 @@ static int armada_drm_crtc_mode_set(struct drm_crtc *crtc,
 	armada_reg_queue_set(regs, i, dcrtc->v[0].spu_v_porch, LCD_SPU_V_PORCH);
 	armada_reg_queue_set(regs, i, dcrtc->v[0].spu_v_h_total,
 			   LCD_SPUT_V_H_TOTAL);
-	armada_reg_queue_mod(regs, i, dcrtc->v[0].spu_adv_reg | ADV_VSYNCOFFEN,
-			   (0xfff << 20 | 0xfff), LCD_SPU_ADV_REG);
+	// FIXME this reg doesnt correspond to MMP2/MMP3
+	// on MMP2/MMP3 it is a TV path register and one of the bits set below
+	// causes LCD output to be sent to the TV - oops!
+	//armada_reg_queue_mod(regs, i, dcrtc->v[0].spu_adv_reg | ADV_VSYNCOFFEN,
+	//		   (0xfff << 20 | 0xfff), LCD_SPU_ADV_REG);
+
+	// FIXME doesnt seem to be a requirement, but it would be a good idea
+	// to write to reg 13c here, LCD_PN_SEPXLCNT
+	// Panel VSYNC Pulse Pixel Edge Control Register
+	// like drivers/video/mmp
 
 	val = dcrtc->cfg_dma_ctrl0;
 
@@ -734,9 +742,16 @@ int armada_drm_crtc_create(struct drm_device *dev, unsigned num,
 	dcrtc->base = base;
 	dcrtc->num = num;
 	dcrtc->clk = clk;
-	dcrtc->cfg_sclk = 0xc0000000;
+
+	// on MMP3 bits 31:29 select the clock, OLPC wants 0x1 here, LCD clock 1
+	// on MMP2 bits 31:30 select the clock, OLPC wants 0x1 here, LCD clock 1
+	dcrtc->cfg_sclk = 0x20001100; // FIXME hardcoded mmp3 value
 	dcrtc->cfg_dma_ctrl0 = CFG_GRA_ENA | CFG_GRA_HSMOOTH;
-	dcrtc->cfg_dumb_ctrl = DUMB24_RGB888_0;
+
+	// OLPC panel is 18 bit RGB666
+	// FIXME: should be selected by panel driver?
+	dcrtc->cfg_dumb_ctrl = DUMB18_RGB666_0;
+
 	spin_lock_init(&dcrtc->irq_lock);
 	dcrtc->irq_ena = CLEAN_SPU_IRQ_ISR;
 	INIT_LIST_HEAD(&dcrtc->vbl_list);
@@ -752,7 +767,8 @@ int armada_drm_crtc_create(struct drm_device *dev, unsigned num,
 	writel_relaxed(0x00000000, dcrtc->base + LCD_SPU_GRA_OVSA_HPXL_VLN);
 
 	/* Lower the watermark so to eliminate jitter at higher bandwidths */
-	armada_updatel(0x20, (1 << 11) | 0xff, dcrtc->base + LCD_CFG_RDREG4F);
+	// FIXME this reg seems totally different on MMP, its LCD_PN_SEPXLCNT Panel VSYNC Pulse Pixel Edge Control Register
+	//armada_updatel(0x20, (1 << 11) | 0xff, dcrtc->base + LCD_CFG_RDREG4F);
 
 	/* Ensure AXI pipeline is enabled */
 	armada_updatel(CFG_ARBFAST_ENA, 0, dcrtc->base + LCD_SPU_DMA_CTRL0);
diff --git a/drivers/gpu/drm/armada/armada_drm.h b/drivers/gpu/drm/armada/armada_drm.h
index c73e29b..0417231 100644
--- a/drivers/gpu/drm/armada/armada_drm.h
+++ b/drivers/gpu/drm/armada/armada_drm.h
@@ -7,6 +7,8 @@
  */
 #ifndef ARMADA_DRM_H
 #define ARMADA_DRM_H
+#include <drm/drm_mm.h>
+#include <drm/drmP.h>
 
 struct armada_crtc;
 struct armada_gem_object;
@@ -56,6 +58,8 @@ int armada_overlay_create(struct drm_device *);
 void armada_overlay_destroy(struct drm_device *);
 void armada_drm_overlay_off(struct drm_device *, struct armada_overlay *);
 
+struct drm_connector *armada_dumb_panel_create(struct drm_device *dev);
+
 int armada_drm_debugfs_init(struct drm_minor *);
 void armada_drm_debugfs_cleanup(struct drm_minor *);
 
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index bb70cf5..03f59d5 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -72,7 +72,7 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 		if (!res[n])
 			break;
 
-		clk = clk_get_sys("dovefb.0", "extclk");
+		clk = clk_get(&dev->platformdev->dev, NULL);
 		if (IS_ERR(clk)) {
 			DRM_ERROR("failed to get clock\n");
 			ret = PTR_ERR(clk);
@@ -88,6 +88,8 @@ static int armada_drm_load(struct drm_device *dev, unsigned long flags)
 		}
 	}
 
+	armada_dumb_panel_create(dev);
+
 	ret = drm_vblank_init(dev, n);
 	if (ret)
 		goto err_kms;
@@ -298,12 +300,19 @@ static int armada_drm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id mmp_disp_of_match[] = {
+	{ .compatible = "marvell,mmp-display", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mmp_disp_of_match);
+
 static struct platform_driver armada_drm_platform_driver = {
 	.probe	= armada_drm_probe,
 	.remove	= armada_drm_remove,
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "armada-drm",
+		.of_match_table = mmp_disp_of_match,
 	},
 };
 
diff --git a/drivers/gpu/drm/armada/armada_output.h b/drivers/gpu/drm/armada/armada_output.h
index d655655..7bc406a 100644
--- a/drivers/gpu/drm/armada/armada_output.h
+++ b/drivers/gpu/drm/armada/armada_output.h
@@ -7,6 +7,8 @@
  */
 #ifndef ARMADA_CONNETOR_H
 #define ARMADA_CONNETOR_H
+#include <linux/types.h>
+#include <drm/drm_crtc.h>
 
 #define encoder_helper_funcs(encoder) \
 	((struct drm_encoder_helper_funcs *)encoder->helper_private)
diff --git a/drivers/gpu/drm/armada/dumb_panel.c b/drivers/gpu/drm/armada/dumb_panel.c
new file mode 100644
index 0000000..f100505
--- /dev/null
+++ b/drivers/gpu/drm/armada/dumb_panel.c
@@ -0,0 +1,163 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *  Rewritten from the dovefb driver, and Armada510 manuals.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "armada_output.h"
+#include "armada_drm.h"
+#include <linux/platform_device.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_crtc.h>
+
+struct dove_drm_dumb_panel_encoder {
+	struct drm_encoder base;
+	struct drm_encoder_helper_funcs encoder_helpers;
+};
+#define to_dumb_panel_encoder(enc) container_of(enc, struct dove_drm_dumb_panel_encoder, base)
+
+static int dove_drm_connector_dumb_panel_mode_valid(struct drm_connector *conn,
+	struct drm_display_mode *mode)
+{
+	return 0;
+}
+
+static int dove_drm_connector_dumb_panel_get_modes(struct drm_connector *conn)
+{
+	struct drm_display_mode *mode;
+	struct drm_encoder *enc = conn->encoder;
+
+	mode = drm_mode_create(conn->dev);
+	mode->type = DRM_MODE_TYPE_DRIVER;
+	mode->clock = 57143;
+	mode->vrefresh = 50;
+	mode->hdisplay = 1200;
+	mode->hsync_start = mode->hdisplay + 26; // add right margin
+	mode->hsync_end = mode->hsync_start + 6; // add hsync len
+	mode->htotal = mode->hsync_end + 24; // add left margin
+	mode->vdisplay = 900;
+	mode->vsync_start = mode->vdisplay + 4; // add lower margin
+	mode->vsync_end = mode->vsync_start + 3; // add vsync len
+	mode->vtotal = mode->vsync_end + 5; // add top margin
+	mode->flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC;
+
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(conn, mode);
+	return 1;
+}
+
+static bool dove_drm_dumb_panel_enc_mode_fixup(struct drm_encoder *encoder,
+	const struct drm_display_mode *mode, struct drm_display_mode *adjusted)
+{
+	return true;
+}
+
+static void dove_drm_dumb_panel_enc_destroy(struct drm_encoder *enc)
+{
+	struct dove_drm_dumb_panel_encoder *tenc = to_dumb_panel_encoder(enc);
+
+	drm_encoder_cleanup(&tenc->base);
+	kfree(tenc);
+}
+
+static const struct drm_encoder_funcs dove_drm_dumb_panel_enc_funcs = {
+	.destroy	= dove_drm_dumb_panel_enc_destroy,
+};
+
+static const struct drm_connector_helper_funcs dove_drm_conn_dumb_panel_helper_funcs = {
+	.get_modes	= dove_drm_connector_dumb_panel_get_modes,
+	.mode_valid	= dove_drm_connector_dumb_panel_mode_valid,
+	.best_encoder	= armada_drm_connector_encoder,
+};
+
+static enum drm_connector_status dove_drm_conn_dumb_panel_detect(
+	struct drm_connector *conn, bool force)
+{
+	return connector_status_connected;
+}
+
+static void panel_encoder_dpms(struct drm_encoder *encoder, int mode)
+{
+}
+
+static void panel_encoder_mode_set(struct drm_encoder *encoder,
+		struct drm_display_mode *mode,
+		struct drm_display_mode *adjusted_mode)
+{
+}
+
+static int dove_drm_conn_dumb_panel_create(struct drm_connector *conn,
+	struct drm_encoder **enc_ret)
+{
+	struct dove_drm_dumb_panel_encoder *tenc;
+	int ret;
+	drm_connector_helper_add(conn, &dove_drm_conn_dumb_panel_helper_funcs);
+
+	tenc = kzalloc(sizeof(*tenc), GFP_KERNEL);
+	if (!tenc)
+		return -ENOMEM;
+
+	tenc->base.possible_crtcs = 1 << 0;
+	ret = drm_encoder_init(conn->dev, &tenc->base,
+			       &dove_drm_dumb_panel_enc_funcs,
+			       DRM_MODE_ENCODER_DAC); // FIXME DAC correct?
+	if (ret) {
+		DRM_ERROR("unable to init encoder\n");
+		kfree(tenc);
+		return ret;
+	}
+	tenc->encoder_helpers.dpms = panel_encoder_dpms;
+	tenc->encoder_helpers.mode_fixup = dove_drm_dumb_panel_enc_mode_fixup;
+	tenc->encoder_helpers.prepare = armada_drm_encoder_prepare;
+	tenc->encoder_helpers.commit = armada_drm_encoder_commit;
+	tenc->encoder_helpers.mode_set = panel_encoder_mode_set;
+	drm_encoder_helper_add(&tenc->base, &tenc->encoder_helpers);
+
+	conn->encoder = &tenc->base;
+	if (enc_ret)
+		*enc_ret = &tenc->base;
+
+	return ret;
+}
+
+static int dove_drm_conn_dumb_panel_set_property(struct drm_connector *conn,
+	struct drm_property *property, uint64_t value)
+{
+	return 0;
+}
+
+static const struct armada_output_type armada_drm_conn_dumb_panel = {
+	.connector_type	= DRM_MODE_CONNECTOR_VGA, // FIXME correct?
+	.detect		= dove_drm_conn_dumb_panel_detect,
+	.create		= dove_drm_conn_dumb_panel_create,
+	.set_property	= dove_drm_conn_dumb_panel_set_property,
+};
+
+struct drm_connector *armada_dumb_panel_create(struct drm_device *dev)
+{
+	return armada_output_create(dev, &armada_drm_conn_dumb_panel, NULL);
+}
+
+static int dumb_probe(struct platform_device *pdev)
+{
+	// FIXME... create panel instance from DT data
+	return 0;
+}
+
+static const struct of_device_id dumb_of_match[] = {
+	{ .compatible = "marvell,dumb-panel", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dumb_of_match);
+
+static struct platform_driver dumb_driver = {
+	.driver = {
+		.name = "dumb-panel",
+		.owner = THIS_MODULE,
+		.of_match_table = dumb_of_match,
+	},
+	.probe		= dumb_probe,
+};
+module_platform_driver(dumb_driver);
-- 
1.8.1.4
