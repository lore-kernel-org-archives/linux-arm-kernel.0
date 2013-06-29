From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 29 Jun 2013 22:56:00 -0000
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130629225210.GF3353@n2100.arm.linux.org.uk>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
Message-ID: <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the pair of LCD controllers on the Marvell
Armada 510 SoCs.  This driver supports:
- multiple contiguous scanout buffers for video and graphics
- shm backed cacheable buffer objects for X pixmaps for Vivante GPU
  acceleration
- dual lcd0 and lcd1 crt operation
- video overlay on each LCD crt
- page flipping of the main scanout buffers

Included in this commit is the core driver with no output support; output
support is platform and encoder driver dependent.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/Kconfig                 |    2 +
 drivers/gpu/drm/Makefile                |    1 +
 drivers/gpu/drm/armada/Kconfig          |   15 +
 drivers/gpu/drm/armada/Makefile         |    7 +
 drivers/gpu/drm/armada/armada_510.c     |   86 +++
 drivers/gpu/drm/armada/armada_crtc.c    |  861 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/armada/armada_crtc.h    |   74 +++
 drivers/gpu/drm/armada/armada_debugfs.c |  187 +++++++
 drivers/gpu/drm/armada/armada_drm.h     |  112 ++++
 drivers/gpu/drm/armada/armada_drv.c     |  381 ++++++++++++++
 drivers/gpu/drm/armada/armada_fb.c      |  155 ++++++
 drivers/gpu/drm/armada/armada_fb.h      |   24 +
 drivers/gpu/drm/armada/armada_fbdev.c   |  206 ++++++++
 drivers/gpu/drm/armada/armada_gem.c     |  541 +++++++++++++++++++
 drivers/gpu/drm/armada/armada_gem.h     |   48 ++
 drivers/gpu/drm/armada/armada_hw.h      |  316 +++++++++++
 drivers/gpu/drm/armada/armada_ioctl.h   |   45 ++
 drivers/gpu/drm/armada/armada_ioctlP.h  |   18 +
 drivers/gpu/drm/armada/armada_output.c  |  159 ++++++
 drivers/gpu/drm/armada/armada_output.h  |   39 ++
 drivers/gpu/drm/armada/armada_overlay.c |  478 +++++++++++++++++
 drivers/gpu/drm/armada/armada_slave.c   |  139 +++++
 drivers/gpu/drm/armada/armada_slave.h   |   26 +
 drivers/gpu/drm/armada/drm_helper.h     |   31 ++
 24 files changed, 3951 insertions(+), 0 deletions(-)
 create mode 100644 drivers/gpu/drm/armada/Kconfig
 create mode 100644 drivers/gpu/drm/armada/Makefile
 create mode 100644 drivers/gpu/drm/armada/armada_510.c
 create mode 100644 drivers/gpu/drm/armada/armada_crtc.c
 create mode 100644 drivers/gpu/drm/armada/armada_crtc.h
 create mode 100644 drivers/gpu/drm/armada/armada_debugfs.c
 create mode 100644 drivers/gpu/drm/armada/armada_drm.h
 create mode 100644 drivers/gpu/drm/armada/armada_drv.c
 create mode 100644 drivers/gpu/drm/armada/armada_fb.c
 create mode 100644 drivers/gpu/drm/armada/armada_fb.h
 create mode 100644 drivers/gpu/drm/armada/armada_fbdev.c
 create mode 100644 drivers/gpu/drm/armada/armada_gem.c
 create mode 100644 drivers/gpu/drm/armada/armada_gem.h
 create mode 100644 drivers/gpu/drm/armada/armada_hw.h
 create mode 100644 drivers/gpu/drm/armada/armada_ioctl.h
 create mode 100644 drivers/gpu/drm/armada/armada_ioctlP.h
 create mode 100644 drivers/gpu/drm/armada/armada_output.c
 create mode 100644 drivers/gpu/drm/armada/armada_output.h
 create mode 100644 drivers/gpu/drm/armada/armada_overlay.c
 create mode 100644 drivers/gpu/drm/armada/armada_slave.c
 create mode 100644 drivers/gpu/drm/armada/armada_slave.h
 create mode 100644 drivers/gpu/drm/armada/drm_helper.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 1e82882..ae8a57f 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -213,6 +213,8 @@ source "drivers/gpu/drm/mgag200/Kconfig"
 
 source "drivers/gpu/drm/cirrus/Kconfig"
 
+source "drivers/gpu/drm/armada/Kconfig"
+
 source "drivers/gpu/drm/shmobile/Kconfig"
 
 source "drivers/gpu/drm/tegra/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 0d59b24..b458168 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_DRM_EXYNOS) +=exynos/
 obj-$(CONFIG_DRM_GMA500) += gma500/
 obj-$(CONFIG_DRM_UDL) += udl/
 obj-$(CONFIG_DRM_AST) += ast/
+obj-$(CONFIG_DRM_ARMADA) += armada/
 obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
 obj-$(CONFIG_DRM_TEGRA) += tegra/
 obj-$(CONFIG_DRM_OMAP)	+= omapdrm/
diff --git a/drivers/gpu/drm/armada/Kconfig b/drivers/gpu/drm/armada/Kconfig
new file mode 100644
index 0000000..c7a0a94
--- /dev/null
+++ b/drivers/gpu/drm/armada/Kconfig
@@ -0,0 +1,15 @@
+config DRM_ARMADA
+	tristate "DRM support for Marvell Armada SoCs"
+	depends on DRM && HAVE_CLK
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select DRM_KMS_HELPER
+	help
+	  Support the "LCD" controllers found on the Marvell Armada 510
+	  devices.  There are two controllers on the device, each controller
+	  supports graphics and video overlays.
+
+	  This driver provides no built-in acceleration; acceleration is
+	  performed by other IP found on the SoC.  This driver provides
+	  kernel mode setting and buffer management to userspace.
diff --git a/drivers/gpu/drm/armada/Makefile b/drivers/gpu/drm/armada/Makefile
new file mode 100644
index 0000000..d6f43e0
--- /dev/null
+++ b/drivers/gpu/drm/armada/Makefile
@@ -0,0 +1,7 @@
+armada-y	:= armada_crtc.o armada_drv.o armada_fb.o armada_fbdev.o \
+		   armada_gem.o armada_output.o armada_overlay.o \
+		   armada_slave.o
+armada-y	+= armada_510.o
+armada-$(CONFIG_DEBUG_FS) += armada_debugfs.o
+
+obj-$(CONFIG_DRM_ARMADA) := armada.o
diff --git a/drivers/gpu/drm/armada/armada_510.c b/drivers/gpu/drm/armada/armada_510.c
new file mode 100644
index 0000000..a016888
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_510.c
@@ -0,0 +1,86 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Armada 510 (aka Dove) variant support
+ */
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include "armada_crtc.h"
+#include "armada_drm.h"
+#include "armada_hw.h"
+
+static int armada510_init(struct armada_private *priv, struct device *dev)
+{
+	priv->extclk[0] = devm_clk_get(dev, "ext_ref_clk_1");
+
+	if (IS_ERR(priv->extclk[0]) && PTR_ERR(priv->extclk[0]) == -ENOENT)
+		priv->extclk[0] = ERR_PTR(-EPROBE_DEFER);
+
+	return PTR_RET(priv->extclk[0]);
+}
+
+static int armada510_crtc_init(struct armada_crtc *dcrtc)
+{
+	/* Lower the watermark so to eliminate jitter at higher bandwidths */
+	armada_updatel(0x20, (1 << 11) | 0xff, dcrtc->base + LCD_CFG_RDREG4F);
+	return 0;
+}
+
+/*
+ * Armada510 specific SCLK register selection.
+ * This gets called with sclk = NULL to test whether the mode is
+ * supportable, and again with sclk != NULL to set the clocks up for
+ * that.  The former can return an error, but the latter is expected
+ * not to.
+ *
+ * We currently are pretty rudimentary here, always selecting
+ * EXT_REF_CLK_1 for LCD0 and erroring LCD1.  This needs improvement!
+ */
+static int armada510_crtc_compute_clock(struct armada_crtc *dcrtc,
+	const struct drm_display_mode *mode, uint32_t *sclk)
+{
+	struct armada_private *priv = dcrtc->crtc.dev->dev_private;
+	struct clk *clk = priv->extclk[0];
+	int ret;
+
+	if (dcrtc->num == 1)
+		return -EINVAL;
+
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (dcrtc->clk != clk) {
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			return ret;
+		dcrtc->clk = clk;
+	}
+
+	if (sclk) {
+		uint32_t rate, ref, div;
+
+		rate = mode->clock * 1000;
+		ref = clk_round_rate(clk, rate);
+		div = DIV_ROUND_UP(ref, rate);
+		if (div < 1)
+			div = 1;
+
+		clk_set_rate(clk, ref);
+		*sclk = div | SCLK_510_EXTCLK1;
+	}
+
+	return 0;
+}
+
+const struct armada_variant armada510_ops = {
+	.has_spu_adv_reg = true,
+	.init = armada510_init,
+	.crtc_init = armada510_crtc_init,
+	.crtc_compute_clock = armada510_crtc_compute_clock,
+};
diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
new file mode 100644
index 0000000..f489157
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -0,0 +1,861 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *  Rewritten from the dovefb driver, and Armada510 manuals.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/clk.h>
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include "armada_crtc.h"
+#include "armada_drm.h"
+#include "armada_fb.h"
+#include "armada_gem.h"
+#include "armada_hw.h"
+
+struct armada_frame_work {
+	struct drm_pending_vblank_event *event;
+	struct armada_regs regs[4];
+	struct drm_framebuffer *old_fb;
+};
+
+enum csc_mode {
+	CSC_AUTO = 0,
+	CSC_YUV_CCIR601 = 1,
+	CSC_YUV_CCIR709 = 2,
+	CSC_RGB_COMPUTER = 1,
+	CSC_RGB_STUDIO = 2,
+};
+
+/*
+ * A note about interlacing.  Let's consider HDMI 1920x1080i.
+ * The timing parameters we have from X are:
+ *  Hact HsyA HsyI Htot  Vact VsyA VsyI Vtot
+ *  1920 2448 2492 2640  1080 1084 1094 1125
+ * Which get translated to:
+ *  Hact HsyA HsyI Htot  Vact VsyA VsyI Vtot
+ *  1920 2448 2492 2640   540  542  547  562
+ *
+ * This is how it is defined by CEA-861-D - line and pixel numbers are
+ * referenced to the rising edge of VSYNC and HSYNC.  Total clocks per
+ * line: 2640.  The odd frame, the first active line is at line 21, and
+ * the even frame, the first active line is 584.
+ *
+ * LN:    560     561     562     563             567     568    569
+ * DE:    ~~~|____________________________//__________________________
+ * HSYNC: ____|~|_____|~|_____|~|_____|~|_//__|~|_____|~|_____|~|_____
+ * VSYNC: _________________________|~~~~~~//~~~~~~~~~~~~~~~|__________
+ *  22 blanking lines.  VSYNC at 1320 (referenced to the HSYNC rising edge).
+ *
+ * LN:    1123   1124    1125      1               5       6      7
+ * DE:    ~~~|____________________________//__________________________
+ * HSYNC: ____|~|_____|~|_____|~|_____|~|_//__|~|_____|~|_____|~|_____
+ * VSYNC: ____________________|~~~~~~~~~~~//~~~~~~~~~~|_______________
+ *  23 blanking lines
+ *
+ * The Armada LCD Controller line and pixel numbers are, like X timings,
+ * referenced to the top left of the active frame.
+ *
+ * So, translating these to our LCD controller:
+ *  Odd frame, 563 total lines, VSYNC at line 543-548, pixel 1128.
+ *  Even frame, 562 total lines, VSYNC at line 542-547, pixel 2448.
+ * Note: Vsync front porch remains constant!
+ *
+ * if (odd_frame) {
+ *   vtotal = mode->crtc_vtotal + 1;
+ *   vbackporch = mode->crtc_vsync_start - mode->crtc_vdisplay + 1;
+ *   vhorizpos = mode->crtc_hsync_start - mode->crtc_htotal / 2
+ * } else {
+ *   vtotal = mode->crtc_vtotal;
+ *   vbackporch = mode->crtc_vsync_start - mode->crtc_vdisplay;
+ *   vhorizpos = mode->crtc_hsync_start;
+ * }
+ * vfrontporch = mode->crtc_vtotal - mode->crtc_vsync_end;
+ *
+ * So, we need to reprogram these registers on each vsync event:
+ *  LCD_SPU_V_PORCH, LCD_SPU_ADV_REG, LCD_SPUT_V_H_TOTAL
+ *
+ * Note: we do not use the frame done interrupts because these appear
+ * to happen too early, and lead to jitter on the display (presumably
+ * they occur at the end of the last active line, before the vsync back
+ * porch, which we're reprogramming.)
+ */
+
+void
+armada_drm_crtc_update_regs(struct armada_crtc *dcrtc, struct armada_regs *regs)
+{
+	while (regs->offset != ~0) {
+		void __iomem *reg = dcrtc->base + regs->offset;
+		uint32_t val;
+
+		val = regs->mask;
+		if (val != 0)
+			val &= readl_relaxed(reg);
+		writel_relaxed(val | regs->val, reg);
+		++regs;
+	}
+}
+
+#define dpms_blanked(dpms)	((dpms) != DRM_MODE_DPMS_ON)
+
+static void armada_drm_crtc_update(struct armada_crtc *dcrtc)
+{
+	uint32_t dumb_ctrl;
+
+	dumb_ctrl = dcrtc->cfg_dumb_ctrl;
+
+	if (!dpms_blanked(dcrtc->dpms))
+		dumb_ctrl |= CFG_DUMB_ENA;
+
+	/*
+	 * When the dumb interface isn't in DUMB24_RGB888_0 mode, it might
+	 * be using SPI or GPIO.  If we set this to DUMB_BLANK, we will
+	 * force LCD_D[23:0] to output blank color, overriding the GPIO or
+	 * SPI usage.  So leave it as-is unless in DUMB24_RGB888_0 mode.
+	 */
+	if (dpms_blanked(dcrtc->dpms) &&
+	    (dumb_ctrl & DUMB_MASK) == DUMB24_RGB888_0) {
+		dumb_ctrl &= ~DUMB_MASK;
+		dumb_ctrl |= DUMB_BLANK;
+	}
+
+	/*
+	 * The documentation doesn't indicate what the normal state of
+	 * the sync signals are.  Sebastian Hesselbart kindly probed
+	 * these signals on his board to determine their state.
+	 *
+	 * The non-inverted state of the sync signals is active high.
+	 * Setting these bits makes the appropriate signal active low.
+	 */
+	if (dcrtc->crtc.mode.flags & DRM_MODE_FLAG_NCSYNC)
+		dumb_ctrl |= CFG_INV_CSYNC;
+	if (dcrtc->crtc.mode.flags & DRM_MODE_FLAG_NHSYNC)
+		dumb_ctrl |= CFG_INV_HSYNC;
+	if (dcrtc->crtc.mode.flags & DRM_MODE_FLAG_NVSYNC)
+		dumb_ctrl |= CFG_INV_VSYNC;
+
+	if (dcrtc->dumb_ctrl != dumb_ctrl) {
+		dcrtc->dumb_ctrl = dumb_ctrl;
+		writel_relaxed(dumb_ctrl, dcrtc->base + LCD_SPU_DUMB_CTRL);
+	}
+}
+
+static unsigned armada_drm_crtc_calc_fb(struct drm_framebuffer *fb,
+	int x, int y, struct armada_regs *regs, bool interlaced)
+{
+	struct armada_gem_object *obj = drm_fb_obj(fb);
+	unsigned pitch = fb->pitches[0];
+	unsigned offset = y * pitch + x * fb->bits_per_pixel / 8;
+	uint32_t addr_odd, addr_even;
+	unsigned i = 0;
+
+	DRM_DEBUG_DRIVER("pitch %u x %d y %d bpp %d\n",
+		pitch, x, y, fb->bits_per_pixel);
+
+	addr_odd = addr_even = obj->dev_addr + offset;
+
+	if (interlaced) {
+		addr_even += pitch;
+		pitch *= 2;
+	}
+
+	/* write offset, base, and pitch */
+	armada_reg_queue_set(regs, i, addr_odd, LCD_CFG_GRA_START_ADDR0);
+	armada_reg_queue_set(regs, i, addr_even, LCD_CFG_GRA_START_ADDR1);
+	armada_reg_queue_mod(regs, i, pitch, 0xffff, LCD_CFG_GRA_PITCH);
+
+	return i;
+}
+
+static int armada_drm_crtc_queue_frame_work(struct armada_crtc *dcrtc,
+	struct armada_frame_work *work)
+{
+	struct drm_device *dev = dcrtc->crtc.dev;
+	unsigned long flags;
+	int ret;
+
+	ret = drm_vblank_get(dev, dcrtc->num);
+	if (ret) {
+		DRM_ERROR("failed to acquire vblank counter\n");
+		return ret;
+	}
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	if (!dcrtc->frame_work)
+		dcrtc->frame_work = work;
+	else
+		ret = -EBUSY;
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+
+	if (ret)
+		drm_vblank_put(dev, dcrtc->num);
+
+	return ret;
+}
+
+static void armada_drm_crtc_complete_frame_work(struct armada_crtc *dcrtc)
+{
+	struct drm_device *dev = dcrtc->crtc.dev;
+	struct armada_frame_work *work = dcrtc->frame_work;
+
+	dcrtc->frame_work = NULL;
+
+	armada_drm_crtc_update_regs(dcrtc, work->regs);
+
+	if (work->event)
+		drm_send_vblank_event(dev, dcrtc->num, work->event);
+
+	drm_vblank_put(dev, dcrtc->num);
+
+	/* Finally, queue the process-half of the cleanup. */
+	__armada_drm_queue_unref_work(dcrtc->crtc.dev, work->old_fb);
+	kfree(work);
+}
+
+static void armada_drm_crtc_finish_fb(struct armada_crtc *dcrtc,
+	struct drm_framebuffer *fb, bool force)
+{
+	struct armada_frame_work *work;
+
+	if (!fb)
+		return;
+
+	if (force) {
+		/* Display is disabled, so just drop the old fb */
+		drm_framebuffer_unreference(fb);
+		return;
+	}
+
+	work = kmalloc(sizeof(*work), GFP_KERNEL);
+	if (work) {
+		int i = 0;
+		work->event = NULL;
+		work->old_fb = fb;
+		armada_reg_queue_end(work->regs, i);
+
+		if (armada_drm_crtc_queue_frame_work(dcrtc, work) == 0)
+			return;
+
+		kfree(work);
+	}
+
+	/*
+	 * Oops - just drop the reference immediately and hope for
+	 * the best.  The worst that will happen is the buffer gets
+	 * reused before it has finished being displayed.
+	 */
+	drm_framebuffer_unreference(fb);
+}
+
+static void armada_drm_vblank_off(struct armada_crtc *dcrtc)
+{
+	struct drm_device *dev = dcrtc->crtc.dev;
+
+	/*
+	 * Tell the DRM core that vblank IRQs aren't going to happen for
+	 * a while.  This cleans up any pending vblank events for us.
+	 */
+	drm_vblank_off(dev, dcrtc->num);
+
+	/* Handle any pending flip event. */
+	spin_lock_irq(&dev->event_lock);
+	if (dcrtc->frame_work)
+		armada_drm_crtc_complete_frame_work(dcrtc);
+	spin_unlock_irq(&dev->event_lock);
+}
+
+void armada_drm_crtc_gamma_set(struct drm_crtc *crtc, u16 r, u16 g, u16 b,
+	int idx)
+{
+}
+
+void armada_drm_crtc_gamma_get(struct drm_crtc *crtc, u16 *r, u16 *g, u16 *b,
+	int idx)
+{
+}
+
+/* The mode_config.mutex will be held for this call */
+static void armada_drm_crtc_dpms(struct drm_crtc *crtc, int dpms)
+{
+	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+
+	if (dcrtc->dpms != dpms) {
+		dcrtc->dpms = dpms;
+		armada_drm_crtc_update(dcrtc);
+		if (dpms_blanked(dpms))
+			armada_drm_vblank_off(dcrtc);
+	}
+}
+
+/*
+ * Prepare for a mode set.  Turn off overlay to ensure that we don't end
+ * up with the overlay size being bigger than the active screen size.
+ * We rely upon X refreshing this state after the mode set has completed.
+ *
+ * The mode_config.mutex will be held for this call
+ */
+static void armada_drm_crtc_prepare(struct drm_crtc *crtc)
+{
+	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+	struct drm_plane *plane;
+
+	/*
+	 * If we have an overlay plane associated with this CRTC, disable
+	 * it before the modeset to avoid its coordinates being outside
+	 * the new mode parameters.  DRM doesn't provide help with this.
+	 */
+	plane = dcrtc->plane;
+	if (plane) {
+		struct drm_framebuffer *fb = plane->fb;
+
+		plane->funcs->disable_plane(plane);
+		plane->fb = NULL;
+		plane->crtc = NULL;
+		drm_framebuffer_unreference(fb);
+	}
+}
+
+/* The mode_config.mutex will be held for this call */
+static void armada_drm_crtc_commit(struct drm_crtc *crtc)
+{
+	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+
+	if (dcrtc->dpms != DRM_MODE_DPMS_ON) {
+		dcrtc->dpms = DRM_MODE_DPMS_ON;
+		armada_drm_crtc_update(dcrtc);
+	}
+}
+
+/* The mode_config.mutex will be held for this call */
+static bool armada_drm_crtc_mode_fixup(struct drm_crtc *crtc,
+	const struct drm_display_mode *mode, struct drm_display_mode *adj)
+{
+	struct armada_private *priv = crtc->dev->dev_private;
+	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+	int ret;
+
+	/* We can't do interlaced modes if we don't have the SPU_ADV_REG */
+	if (!priv->variant->has_spu_adv_reg &&
+	    adj->flags & DRM_MODE_FLAG_INTERLACE)
+		return false;
+
+	/* Check whether the display mode is possible */
+	ret = priv->variant->crtc_compute_clock(dcrtc, adj, NULL);
+	if (ret)
+		return false;
+
+	return true;
+}
+
+void armada_drm_crtc_irq(struct armada_crtc *dcrtc, u32 stat)
+{
+	struct armada_vbl_event *e, *n;
+	void __iomem *base = dcrtc->base;
+
+	if (stat & DMA_FF_UNDERFLOW)
+		DRM_ERROR("video underflow on crtc %u\n", dcrtc->num);
+	if (stat & GRA_FF_UNDERFLOW)
+		DRM_ERROR("graphics underflow on crtc %u\n", dcrtc->num);
+
+	if (stat & VSYNC_IRQ)
+		drm_handle_vblank(dcrtc->crtc.dev, dcrtc->num);
+
+	spin_lock(&dcrtc->irq_lock);
+
+	list_for_each_entry_safe(e, n, &dcrtc->vbl_list, node) {
+		list_del_init(&e->node);
+		drm_vblank_put(dcrtc->crtc.dev, dcrtc->num);
+		e->fn(dcrtc, e->data);
+	}
+
+	if (stat & GRA_FRAME_IRQ && dcrtc->interlaced) {
+		int i = stat & GRA_FRAME_IRQ0 ? 0 : 1;
+		uint32_t val;
+
+		writel_relaxed(dcrtc->v[i].spu_v_porch, base + LCD_SPU_V_PORCH);
+		writel_relaxed(dcrtc->v[i].spu_v_h_total,
+			       base + LCD_SPUT_V_H_TOTAL);
+
+		val = readl_relaxed(base + LCD_SPU_ADV_REG);
+		val &= ~(ADV_VSYNC_L_OFF | ADV_VSYNC_H_OFF | ADV_VSYNCOFFEN);
+		val |= dcrtc->v[i].spu_adv_reg;
+		writel_relaxed(val, dcrtc->base + LCD_SPU_ADV_REG);
+	}
+	spin_unlock(&dcrtc->irq_lock);
+
+	if (stat & GRA_FRAME_IRQ) {
+		struct drm_device *dev = dcrtc->crtc.dev;
+
+		spin_lock(&dev->event_lock);
+		if (dcrtc->frame_work)
+			armada_drm_crtc_complete_frame_work(dcrtc);
+		spin_unlock(&dev->event_lock);
+
+		wake_up(&dcrtc->frame_wait);
+	}
+}
+
+/* These are locked by dev->vbl_lock */
+void armada_drm_crtc_disable_irq(struct armada_crtc *dcrtc, u32 mask)
+{
+	if (dcrtc->irq_ena & mask) {
+		dcrtc->irq_ena &= ~mask;
+		writel(dcrtc->irq_ena, dcrtc->base + LCD_SPU_IRQ_ENA);
+	}
+}
+
+void armada_drm_crtc_enable_irq(struct armada_crtc *dcrtc, u32 mask)
+{
+	if ((dcrtc->irq_ena & mask) != mask) {
+		dcrtc->irq_ena |= mask;
+		writel(dcrtc->irq_ena, dcrtc->base + LCD_SPU_IRQ_ENA);
+		if (readl_relaxed(dcrtc->base + LCD_SPU_IRQ_ISR) & mask)
+			writel(0, dcrtc->base + LCD_SPU_IRQ_ISR);
+	}
+}
+
+static uint32_t armada_drm_crtc_calculate_csc(struct armada_crtc *dcrtc)
+{
+	struct drm_display_mode *adj = &dcrtc->crtc.mode;
+	uint32_t val = 0;
+
+	if (dcrtc->csc_yuv_mode == CSC_YUV_CCIR709)
+		val |= CFG_CSC_YUV_CCIR709;
+	if (dcrtc->csc_rgb_mode == CSC_RGB_STUDIO)
+		val |= CFG_CSC_RGB_STUDIO;
+
+	/*
+	 * In auto mode, set the colorimetry, based upon the HDMI spec.
+	 * 1280x720p, 1920x1080p and 1920x1080i use ITU709, others use
+	 * ITU601.  It may be more appropriate to set this depending on
+	 * the source - but what if the graphic frame is YUV and the
+	 * video frame is RGB?
+	 */
+	if ((adj->hdisplay == 1280 && adj->vdisplay == 720 &&
+	     !(adj->flags & DRM_MODE_FLAG_INTERLACE)) ||
+	    (adj->hdisplay == 1920 && adj->vdisplay == 1080)) {
+		if (dcrtc->csc_yuv_mode == CSC_AUTO)
+			val |= CFG_CSC_YUV_CCIR709;
+	}
+
+	/*
+	 * We assume we're connected to a TV-like device, so the YUV->RGB
+	 * conversion should produce a limited range.  We should set this
+	 * depending on the connectors attached to this CRTC, and what
+	 * kind of device they report being connected.
+	 */
+	if (dcrtc->csc_rgb_mode == CSC_AUTO)
+		val |= CFG_CSC_RGB_STUDIO;
+
+	return val;
+}
+
+/* The mode_config.mutex will be held for this call */
+static int armada_drm_crtc_mode_set(struct drm_crtc *crtc,
+	struct drm_display_mode *mode, struct drm_display_mode *adj,
+	int x, int y, struct drm_framebuffer *old_fb)
+{
+	struct armada_private *priv = crtc->dev->dev_private;
+	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+	struct armada_regs regs[17];
+	uint32_t lm, rm, tm, bm, val, sclk;
+	unsigned long flags;
+	unsigned i;
+	bool interlaced;
+
+	drm_framebuffer_reference(crtc->fb);
+
+	interlaced = !!(adj->flags & DRM_MODE_FLAG_INTERLACE);
+
+	i = armada_drm_crtc_calc_fb(dcrtc->crtc.fb, x, y, regs, interlaced);
+
+	rm = adj->crtc_hsync_start - adj->crtc_hdisplay;
+	lm = adj->crtc_htotal - adj->crtc_hsync_end;
+	bm = adj->crtc_vsync_start - adj->crtc_vdisplay;
+	tm = adj->crtc_vtotal - adj->crtc_vsync_end;
+
+	DRM_DEBUG_DRIVER("H: %d %d %d %d lm %d rm %d\n",
+		adj->crtc_hdisplay,
+		adj->crtc_hsync_start,
+		adj->crtc_hsync_end,
+		adj->crtc_htotal, lm, rm);
+	DRM_DEBUG_DRIVER("V: %d %d %d %d tm %d bm %d\n",
+		adj->crtc_vdisplay,
+		adj->crtc_vsync_start,
+		adj->crtc_vsync_end,
+		adj->crtc_vtotal, tm, bm);
+
+	/* Wait for pending flips to complete */
+	wait_event(dcrtc->frame_wait, !dcrtc->frame_work);
+
+	drm_vblank_pre_modeset(crtc->dev, dcrtc->num);
+
+	crtc->mode = *adj;
+
+	val = dcrtc->dumb_ctrl & ~CFG_DUMB_ENA;
+	if (val != dcrtc->dumb_ctrl) {
+		dcrtc->dumb_ctrl = val;
+		writel_relaxed(val, dcrtc->base + LCD_SPU_DUMB_CTRL);
+	}
+
+	/* Now compute the divider for real */
+	priv->variant->crtc_compute_clock(dcrtc, adj, &sclk);
+
+	/* Ensure graphic fifo is enabled */
+	armada_reg_queue_mod(regs, i, 0, CFG_PDWN64x66, LCD_SPU_SRAM_PARA1);
+	armada_reg_queue_set(regs, i, sclk, LCD_CFG_SCLK_DIV);
+
+	if (interlaced ^ dcrtc->interlaced) {
+		if (adj->flags & DRM_MODE_FLAG_INTERLACE)
+			drm_vblank_get(dcrtc->crtc.dev, dcrtc->num);
+		else
+			drm_vblank_put(dcrtc->crtc.dev, dcrtc->num);
+		dcrtc->interlaced = interlaced;
+	}
+
+	spin_lock_irqsave(&dcrtc->irq_lock, flags);
+
+	/* Even interlaced/progressive frame */
+	dcrtc->v[1].spu_v_h_total = adj->crtc_vtotal << 16 |
+				    adj->crtc_htotal;
+	dcrtc->v[1].spu_v_porch = tm << 16 | bm;
+	val = adj->crtc_hsync_start;
+	dcrtc->v[1].spu_adv_reg = val << 20 | val | ADV_VSYNCOFFEN;
+
+	if (interlaced) {
+		/* Odd interlaced frame */
+		dcrtc->v[0].spu_v_h_total = dcrtc->v[1].spu_v_h_total +
+						(1 << 16);
+		dcrtc->v[0].spu_v_porch = dcrtc->v[1].spu_v_porch + 1;
+		val = adj->crtc_hsync_start - adj->crtc_htotal / 2;
+		dcrtc->v[0].spu_adv_reg = val << 20 | val | ADV_VSYNCOFFEN;
+	} else {
+		dcrtc->v[0] = dcrtc->v[1];
+	}
+
+	val = adj->crtc_vdisplay << 16 | adj->crtc_hdisplay;
+
+	armada_reg_queue_set(regs, i, val, LCD_SPU_V_H_ACTIVE);
+	armada_reg_queue_set(regs, i, val, LCD_SPU_GRA_HPXL_VLN);
+	armada_reg_queue_set(regs, i, val, LCD_SPU_GZM_HPXL_VLN);
+	armada_reg_queue_set(regs, i, (lm << 16) | rm, LCD_SPU_H_PORCH);
+	armada_reg_queue_set(regs, i, dcrtc->v[0].spu_v_porch, LCD_SPU_V_PORCH);
+	armada_reg_queue_set(regs, i, dcrtc->v[0].spu_v_h_total,
+			   LCD_SPUT_V_H_TOTAL);
+
+	if (priv->variant->has_spu_adv_reg)
+		armada_reg_queue_mod(regs, i, dcrtc->v[0].spu_adv_reg,
+				     ADV_VSYNC_L_OFF | ADV_VSYNC_H_OFF |
+				     ADV_VSYNCOFFEN, LCD_SPU_ADV_REG);
+
+	val = CFG_GRA_ENA | CFG_GRA_HSMOOTH;
+	val |= CFG_GRA_FMT(drm_fb_to_armada_fb(dcrtc->crtc.fb)->fmt);
+	val |= CFG_GRA_MOD(drm_fb_to_armada_fb(dcrtc->crtc.fb)->mod);
+
+	if (drm_fb_to_armada_fb(dcrtc->crtc.fb)->fmt > CFG_420)
+		val |= CFG_PALETTE_ENA;
+
+	if (interlaced)
+		val |= CFG_GRA_FTOGGLE;
+
+	armada_reg_queue_mod(regs, i, val, CFG_GRAFORMAT |
+			     CFG_GRA_MOD(CFG_SWAPRB | CFG_SWAPUV |
+					 CFG_SWAPYU | CFG_YUV2RGB) |
+			     CFG_PALETTE_ENA | CFG_GRA_FTOGGLE,
+			     LCD_SPU_DMA_CTRL0);
+
+	val = adj->flags & DRM_MODE_FLAG_NVSYNC ? CFG_VSYNC_INV : 0;
+	armada_reg_queue_mod(regs, i, val, CFG_VSYNC_INV, LCD_SPU_DMA_CTRL1);
+
+	val = dcrtc->spu_iopad_ctrl | armada_drm_crtc_calculate_csc(dcrtc);
+	armada_reg_queue_set(regs, i, val, LCD_SPU_IOPAD_CONTROL);
+	armada_reg_queue_end(regs, i);
+
+	armada_drm_crtc_update_regs(dcrtc, regs);
+	spin_unlock_irqrestore(&dcrtc->irq_lock, flags);
+
+	armada_drm_crtc_update(dcrtc);
+
+	drm_vblank_post_modeset(crtc->dev, dcrtc->num);
+	armada_drm_crtc_finish_fb(dcrtc, old_fb, dpms_blanked(dcrtc->dpms));
+
+	return 0;
+}
+
+/* The mode_config.mutex will be held for this call */
+static int armada_drm_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
+	struct drm_framebuffer *old_fb)
+{
+	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+	struct armada_regs regs[4];
+	unsigned i;
+
+	i = armada_drm_crtc_calc_fb(crtc->fb, crtc->x, crtc->y, regs,
+				    dcrtc->interlaced);
+	armada_reg_queue_end(regs, i);
+
+	/* Wait for pending flips to complete */
+	wait_event(dcrtc->frame_wait, !dcrtc->frame_work);
+
+	/* Take a reference to the new fb as we're using it */
+	drm_framebuffer_reference(crtc->fb);
+
+	/* Update the base in the CRTC */
+	armada_drm_crtc_update_regs(dcrtc, regs);
+
+	/* Drop our previously held reference */
+	armada_drm_crtc_finish_fb(dcrtc, old_fb, dpms_blanked(dcrtc->dpms));
+
+	return 0;
+}
+
+static void armada_drm_crtc_load_lut(struct drm_crtc *crtc)
+{
+}
+
+/* The mode_config.mutex will be held for this call */
+static void armada_drm_crtc_disable(struct drm_crtc *crtc)
+{
+	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+
+	armada_drm_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
+	armada_drm_crtc_finish_fb(dcrtc, crtc->fb, true);
+
+	/* Power down most RAMs and FIFOs */
+	writel_relaxed(CFG_PDWN256x32 | CFG_PDWN256x24 | CFG_PDWN256x8 |
+		       CFG_PDWN32x32 | CFG_PDWN16x66 | CFG_PDWN32x66 |
+		       CFG_PDWN64x66, dcrtc->base + LCD_SPU_SRAM_PARA1);
+}
+
+static const struct drm_crtc_helper_funcs armada_crtc_helper_funcs = {
+	.dpms		= armada_drm_crtc_dpms,
+	.prepare	= armada_drm_crtc_prepare,
+	.commit		= armada_drm_crtc_commit,
+	.mode_fixup	= armada_drm_crtc_mode_fixup,
+	.mode_set	= armada_drm_crtc_mode_set,
+	.mode_set_base	= armada_drm_crtc_mode_set_base,
+	.load_lut	= armada_drm_crtc_load_lut,
+	.disable	= armada_drm_crtc_disable,
+};
+
+static void armada_drm_crtc_destroy(struct drm_crtc *crtc)
+{
+	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+	struct armada_private *priv = crtc->dev->dev_private;
+
+	priv->dcrtc[dcrtc->num] = NULL;
+	drm_crtc_cleanup(&dcrtc->crtc);
+
+	if (!IS_ERR(dcrtc->clk))
+		clk_disable_unprepare(dcrtc->clk);
+
+	kfree(dcrtc);
+}
+
+/*
+ * The mode_config lock is held here, to prevent races between this
+ * and a mode_set.
+ */
+static int armada_drm_crtc_page_flip(struct drm_crtc *crtc,
+	struct drm_framebuffer *fb, struct drm_pending_vblank_event *event)
+{
+	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+	struct armada_frame_work *work;
+	struct drm_device *dev = crtc->dev;
+	unsigned long flags;
+	unsigned i;
+	int ret;
+
+	/* We don't support changing the pixel format */
+	if (fb->pixel_format != crtc->fb->pixel_format)
+		return -EINVAL;
+
+	work = kmalloc(sizeof(*work), GFP_KERNEL);
+	if (!work)
+		return -ENOMEM;
+
+	work->event = event;
+	work->old_fb = dcrtc->crtc.fb;
+
+	i = armada_drm_crtc_calc_fb(fb, crtc->x, crtc->y, work->regs,
+				    dcrtc->interlaced);
+	armada_reg_queue_end(work->regs, i);
+
+	/*
+	 * Hold the old framebuffer for the work - DRM appears to drop our
+	 * reference to the old framebuffer in drm_mode_page_flip_ioctl().
+	 */
+	drm_framebuffer_reference(work->old_fb);
+
+	ret = armada_drm_crtc_queue_frame_work(dcrtc, work);
+	if (ret) {
+		/*
+		 * Undo our reference above; DRM does not drop the reference
+		 * to this object on error, so that's okay.
+		 */
+		drm_framebuffer_unreference(work->old_fb);
+		kfree(work);
+		return ret;
+	}
+
+	/*
+	 * Don't take a reference on the new framebuffer;
+	 * drm_mode_page_flip_ioctl() has already grabbed a reference and
+	 * will _not_ drop that reference on successful return from this
+	 * function.  Simply mark this new framebuffer as the current one.
+	 */
+	dcrtc->crtc.fb = fb;
+
+	/*
+	 * Finally, if the display is blanked, we won't receive an
+	 * interrupt, so complete it now.
+	 */
+	if (dpms_blanked(dcrtc->dpms)) {
+		spin_lock_irqsave(&dev->event_lock, flags);
+		if (dcrtc->frame_work)
+			armada_drm_crtc_complete_frame_work(dcrtc);
+		spin_unlock_irqrestore(&dev->event_lock, flags);
+	}
+
+	return 0;
+}
+
+static int
+armada_drm_crtc_set_property(struct drm_crtc *crtc,
+	struct drm_property *property, uint64_t val)
+{
+	struct armada_private *priv = crtc->dev->dev_private;
+	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+	bool update_csc = false;
+
+	if (property == priv->csc_yuv_prop) {
+		dcrtc->csc_yuv_mode = val;
+		update_csc = true;
+	} else if (property == priv->csc_rgb_prop) {
+		dcrtc->csc_rgb_mode = val;
+		update_csc = true;
+	}
+
+	if (update_csc) {
+		uint32_t val;
+
+		val = dcrtc->spu_iopad_ctrl |
+		      armada_drm_crtc_calculate_csc(dcrtc);
+		writel_relaxed(val, dcrtc->base + LCD_SPU_IOPAD_CONTROL);
+	}
+
+	return 0;
+}
+
+static struct drm_crtc_funcs armada_crtc_funcs = {
+	.destroy	= armada_drm_crtc_destroy,
+	.set_config	= drm_crtc_helper_set_config,
+	.page_flip	= armada_drm_crtc_page_flip,
+	.set_property	= armada_drm_crtc_set_property,
+};
+
+static struct drm_prop_enum_list armada_drm_csc_yuv_enum_list[] = {
+	{ CSC_AUTO,        "Auto" },
+	{ CSC_YUV_CCIR601, "CCIR601" },
+	{ CSC_YUV_CCIR709, "CCIR709" },
+};
+
+static struct drm_prop_enum_list armada_drm_csc_rgb_enum_list[] = {
+	{ CSC_AUTO,         "Auto" },
+	{ CSC_RGB_COMPUTER, "Computer system" },
+	{ CSC_RGB_STUDIO,   "Studio" },
+};
+
+static int armada_drm_crtc_create_properties(struct drm_device *dev)
+{
+	struct armada_private *priv = dev->dev_private;
+
+	if (priv->csc_yuv_prop)
+		return 0;
+
+	priv->csc_yuv_prop = drm_property_create_enum(dev, 0,
+				"CSC_YUV", armada_drm_csc_yuv_enum_list,
+				ARRAY_SIZE(armada_drm_csc_yuv_enum_list));
+	priv->csc_rgb_prop = drm_property_create_enum(dev, 0,
+				"CSC_RGB", armada_drm_csc_rgb_enum_list,
+				ARRAY_SIZE(armada_drm_csc_rgb_enum_list));
+
+	if (!priv->csc_yuv_prop || !priv->csc_rgb_prop)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int armada_drm_crtc_create(struct drm_device *dev, unsigned num,
+	struct resource *res)
+{
+	struct armada_private *priv = dev->dev_private;
+	struct armada_crtc *dcrtc;
+	void __iomem *base;
+	int ret;
+
+	ret = armada_drm_crtc_create_properties(dev);
+	if (ret)
+		return ret;
+
+	base = devm_request_and_ioremap(dev->dev, res);
+	if (!base) {
+		DRM_ERROR("failed to ioremap register\n");
+		return -ENOMEM;
+	}
+
+	dcrtc = kzalloc(sizeof(*dcrtc), GFP_KERNEL);
+	if (!dcrtc) {
+		DRM_ERROR("failed to allocate Armada crtc\n");
+		return -ENOMEM;
+	}
+
+	dcrtc->base = base;
+	dcrtc->num = num;
+	dcrtc->clk = ERR_PTR(-EINVAL);
+	dcrtc->csc_yuv_mode = CSC_AUTO;
+	dcrtc->csc_rgb_mode = CSC_AUTO;
+	dcrtc->cfg_dumb_ctrl = DUMB24_RGB888_0;
+	dcrtc->spu_iopad_ctrl = CFG_IOPAD_DUMB24;
+	spin_lock_init(&dcrtc->irq_lock);
+	dcrtc->irq_ena = CLEAN_SPU_IRQ_ISR;
+	INIT_LIST_HEAD(&dcrtc->vbl_list);
+	init_waitqueue_head(&dcrtc->frame_wait);
+
+	/* Initialize some registers which we don't otherwise set */
+	writel_relaxed(0x00000001, dcrtc->base + LCD_CFG_SCLK_DIV);
+	writel_relaxed(0x00000000, dcrtc->base + LCD_SPU_BLANKCOLOR);
+	writel_relaxed(dcrtc->spu_iopad_ctrl,
+		       dcrtc->base + LCD_SPU_IOPAD_CONTROL);
+	writel_relaxed(0x00000000, dcrtc->base + LCD_SPU_SRAM_PARA0);
+	writel_relaxed(CFG_PDWN256x32 | CFG_PDWN256x24 | CFG_PDWN256x8 |
+		       CFG_PDWN32x32 | CFG_PDWN16x66 | CFG_PDWN32x66 |
+		       CFG_PDWN64x66, dcrtc->base + LCD_SPU_SRAM_PARA1);
+	writel_relaxed(0x2032ff81, dcrtc->base + LCD_SPU_DMA_CTRL1);
+	writel_relaxed(0x00000000, dcrtc->base + LCD_SPU_GRA_OVSA_HPXL_VLN);
+
+	if (priv->variant->crtc_init) {
+		ret = priv->variant->crtc_init(dcrtc);
+		if (ret) {
+			kfree(dcrtc);
+			return ret;
+		}
+	}
+
+	/* Ensure AXI pipeline is enabled */
+	armada_updatel(CFG_ARBFAST_ENA, 0, dcrtc->base + LCD_SPU_DMA_CTRL0);
+
+	priv->dcrtc[dcrtc->num] = dcrtc;
+
+	drm_crtc_init(dev, &dcrtc->crtc, &armada_crtc_funcs);
+	drm_crtc_helper_add(&dcrtc->crtc, &armada_crtc_helper_funcs);
+
+	drm_object_attach_property(&dcrtc->crtc.base, priv->csc_yuv_prop,
+				   dcrtc->csc_yuv_mode);
+	drm_object_attach_property(&dcrtc->crtc.base, priv->csc_rgb_prop,
+				   dcrtc->csc_rgb_mode);
+
+	return armada_overlay_plane_create(dev, 1 << dcrtc->num);
+}
diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
new file mode 100644
index 0000000..972da53
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_crtc.h
@@ -0,0 +1,74 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ARMADA_CRTC_H
+#define ARMADA_CRTC_H
+
+struct armada_gem_object;
+
+struct armada_regs {
+	uint32_t offset;
+	uint32_t mask;
+	uint32_t val;
+};
+
+#define armada_reg_queue_mod(_r, _i, _v, _m, _o)	\
+	do {					\
+		struct armada_regs *__reg = _r;	\
+		__reg[_i].offset = _o;		\
+		__reg[_i].mask = ~(_m);		\
+		__reg[_i].val = _v;		\
+		_i++;				\
+	} while (0)
+
+#define armada_reg_queue_set(_r, _i, _v, _o)	\
+	armada_reg_queue_mod(_r, _i, _v, ~0, _o)
+
+#define armada_reg_queue_end(_r, _i)		\
+	armada_reg_queue_mod(_r, _i, 0, 0, ~0)
+
+struct armada_frame_work;
+
+struct armada_crtc {
+	struct drm_crtc		crtc;
+	unsigned		num;
+	void __iomem		*base;
+	struct clk		*clk;
+	struct {
+		uint32_t	spu_v_h_total;
+		uint32_t	spu_v_porch;
+		uint32_t	spu_adv_reg;
+	} v[2];
+	bool			interlaced;
+	uint8_t			csc_yuv_mode;
+	uint8_t			csc_rgb_mode;
+
+	struct drm_plane	*plane;
+
+	int			dpms;
+	uint32_t		cfg_dumb_ctrl;
+	uint32_t		dumb_ctrl;
+	uint32_t		spu_iopad_ctrl;
+
+	wait_queue_head_t	frame_wait;
+	struct armada_frame_work *frame_work;
+
+	spinlock_t		irq_lock;
+	uint32_t		irq_ena;
+	struct list_head	vbl_list;
+};
+#define drm_to_armada_crtc(c) container_of(c, struct armada_crtc, crtc)
+
+int armada_drm_crtc_create(struct drm_device *, unsigned, struct resource *);
+void armada_drm_crtc_gamma_set(struct drm_crtc *, u16, u16, u16, int);
+void armada_drm_crtc_gamma_get(struct drm_crtc *, u16 *, u16 *, u16 *, int);
+void armada_drm_crtc_irq(struct armada_crtc *, u32);
+void armada_drm_crtc_disable_irq(struct armada_crtc *, u32);
+void armada_drm_crtc_enable_irq(struct armada_crtc *, u32);
+void armada_drm_crtc_update_regs(struct armada_crtc *, struct armada_regs *);
+
+#endif
diff --git a/drivers/gpu/drm/armada/armada_debugfs.c b/drivers/gpu/drm/armada/armada_debugfs.c
new file mode 100644
index 0000000..ea72d5e
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_debugfs.c
@@ -0,0 +1,187 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *  Rewritten from the dovefb driver, and Armada510 manuals.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/ctype.h>
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <drm/drmP.h>
+#include "armada_crtc.h"
+#include "armada_drm.h"
+
+static int armada_debugfs_gem_offs_show(struct seq_file *m, void *data)
+{
+	struct drm_info_node *node = m->private;
+	struct drm_device *dev = node->minor->dev;
+	struct drm_gem_mm *mm = dev->mm_private;
+
+	return drm_mm_dump_table(m, &mm->offset_manager);
+}
+
+static int armada_debugfs_gem_linear_show(struct seq_file *m, void *data)
+{
+	struct drm_info_node *node = m->private;
+	struct armada_private *priv = node->minor->dev->dev_private;
+
+	return drm_mm_dump_table(m, &priv->linear);
+}
+
+static int armada_debugfs_reg_show(struct seq_file *m, void *data)
+{
+	struct drm_device *dev = m->private;
+	struct armada_private *priv = dev->dev_private;
+	int n, i;
+
+	if (priv) {
+		for (n = 0; n < ARRAY_SIZE(priv->dcrtc); n++) {
+			struct armada_crtc *dcrtc = priv->dcrtc[n];
+			if (!dcrtc)
+				continue;
+
+			for (i = 0x84; i <= 0x1c4; i += 4) {
+				uint32_t v = readl_relaxed(dcrtc->base + i);
+				seq_printf(m, "%u: 0x%04x: 0x%08x\n", n, i, v);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int armada_debugfs_reg_r_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, armada_debugfs_reg_show, inode->i_private);
+}
+
+static const struct file_operations fops_reg_r = {
+	.owner = THIS_MODULE,
+	.open = armada_debugfs_reg_r_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int armada_debugfs_write(struct file *file, const char __user *ptr,
+	size_t len, loff_t *off)
+{
+	struct drm_device *dev = file->private_data;
+	struct armada_private *priv = dev->dev_private;
+	struct armada_crtc *dcrtc = priv->dcrtc[0];
+	char buf[32], *p;
+	uint32_t reg, val;
+	int ret;
+
+	if (*off != 0)
+		return 0;
+
+	if (len > sizeof(buf) - 1)
+		len = sizeof(buf) - 1;
+
+	ret = strncpy_from_user(buf, ptr, len);
+	if (ret < 0)
+		return ret;
+	buf[len] = '\0';
+
+	reg = simple_strtoul(buf, &p, 16);
+	if (!isspace(*p))
+		return -EINVAL;
+	val = simple_strtoul(p + 1, NULL, 16);
+
+	if (reg >= 0x84 && reg <= 0x1c4)
+		writel(val, dcrtc->base + reg);
+
+	return len;
+}
+
+static int armada_debugfs_reg_w_open(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+static const struct file_operations fops_reg_w = {
+	.owner = THIS_MODULE,
+	.open = armada_debugfs_reg_w_open,
+	.write = armada_debugfs_write,
+	.llseek = noop_llseek,
+};
+
+static struct drm_info_list armada_debugfs_list[] = {
+	{ "gem_linear", armada_debugfs_gem_linear_show, 0 },
+	{ "gem_offset", armada_debugfs_gem_offs_show, 0 },
+};
+#define ARMADA_DEBUGFS_ENTRIES ARRAY_SIZE(armada_debugfs_list)
+
+static int drm_add_fake_info_node(struct drm_minor *minor, struct dentry *ent,
+	const void *key)
+{
+	struct drm_info_node *node;
+
+	node = kmalloc(sizeof(struct drm_info_node), GFP_KERNEL);
+	if (node == NULL) {
+		debugfs_remove(ent);
+		return -ENOMEM;
+	}
+
+	node->minor = minor;
+	node->dent = ent;
+	node->info_ent = (void *) key;
+
+	mutex_lock(&minor->debugfs_lock);
+	list_add(&node->list, &minor->debugfs_list);
+	mutex_unlock(&minor->debugfs_lock);
+
+	return 0;
+}
+
+static int armada_debugfs_create(struct dentry *root, struct drm_minor *minor,
+	const char *name, umode_t mode, const struct file_operations *fops)
+{
+	struct dentry *de;
+
+	de = debugfs_create_file(name, mode, root, minor->dev, fops);
+
+	return drm_add_fake_info_node(minor, de, fops);
+}
+
+int armada_drm_debugfs_init(struct drm_minor *minor)
+{
+	int ret;
+
+	ret = drm_debugfs_create_files(armada_debugfs_list,
+				       ARMADA_DEBUGFS_ENTRIES,
+				       minor->debugfs_root, minor);
+	if (ret)
+		return ret;
+
+	ret = armada_debugfs_create(minor->debugfs_root, minor,
+				   "reg", S_IFREG | S_IRUSR, &fops_reg_r);
+	if (ret)
+		goto err_1;
+
+	ret = armada_debugfs_create(minor->debugfs_root, minor,
+				"reg_wr", S_IFREG | S_IWUSR, &fops_reg_w);
+	if (ret)
+		goto err_2;
+	return ret;
+
+ err_2:
+	drm_debugfs_remove_files((struct drm_info_list *)&fops_reg_r, 1, minor);
+ err_1:
+	drm_debugfs_remove_files(armada_debugfs_list, ARMADA_DEBUGFS_ENTRIES,
+				 minor);
+	return ret;
+}
+
+void armada_drm_debugfs_cleanup(struct drm_minor *minor)
+{
+	drm_debugfs_remove_files((struct drm_info_list *)&fops_reg_w, 1, minor);
+	drm_debugfs_remove_files((struct drm_info_list *)&fops_reg_r, 1, minor);
+	drm_debugfs_remove_files(armada_debugfs_list, ARMADA_DEBUGFS_ENTRIES,
+				 minor);
+}
diff --git a/drivers/gpu/drm/armada/armada_drm.h b/drivers/gpu/drm/armada/armada_drm.h
new file mode 100644
index 0000000..e8c4f80
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_drm.h
@@ -0,0 +1,112 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ARMADA_DRM_H
+#define ARMADA_DRM_H
+
+#include <linux/kfifo.h>
+#include <linux/io.h>
+#include <linux/workqueue.h>
+#include <drm/drmP.h>
+
+struct armada_crtc;
+struct armada_gem_object;
+struct clk;
+struct drm_fb_helper;
+
+static inline void
+armada_updatel(uint32_t val, uint32_t mask, void __iomem *ptr)
+{
+	uint32_t ov, v;
+
+	ov = v = readl_relaxed(ptr);
+	v = (v & ~mask) | val;
+	if (ov != v)
+		writel_relaxed(v, ptr);
+}
+
+static inline uint32_t armada_pitch(uint32_t width, uint32_t bpp)
+{
+	uint32_t pitch = bpp != 4 ? width * ((bpp + 7) / 8) : width / 2;
+
+	/* 88AP510 spec recommends pitch be a multiple of 128 */
+	return ALIGN(pitch, 128);
+}
+
+struct armada_vbl_event {
+	struct list_head	node;
+	void			*data;
+	void			(*fn)(struct armada_crtc *, void *);
+};
+void armada_drm_vbl_event_add(struct armada_crtc *,
+	struct armada_vbl_event *);
+void armada_drm_vbl_event_remove(struct armada_crtc *,
+	struct armada_vbl_event *);
+void armada_drm_vbl_event_remove_unlocked(struct armada_crtc *,
+	struct armada_vbl_event *);
+#define armada_drm_vbl_event_init(_e, _f, _d) do {	\
+	struct armada_vbl_event *__e = _e;		\
+	INIT_LIST_HEAD(&__e->node);			\
+	__e->data = _d;					\
+	__e->fn = _f;					\
+} while (0)
+
+
+struct armada_private;
+
+struct armada_variant {
+	bool	has_spu_adv_reg;
+	int (*init)(struct armada_private *, struct device *);
+	int (*crtc_init)(struct armada_crtc *);
+	int (*crtc_compute_clock)(struct armada_crtc *,
+				  const struct drm_display_mode *,
+				  uint32_t *);
+};
+
+/* Variant ops */
+extern const struct armada_variant armada510_ops;
+
+struct armada_private {
+	const struct armada_variant *variant;
+	struct work_struct	fb_unref_work;
+	DECLARE_KFIFO(fb_unref, struct drm_framebuffer *, 8);
+	struct drm_fb_helper	*fbdev;
+	struct armada_crtc	*dcrtc[2];
+	struct drm_mm		linear;
+	struct clk		*extclk[2];
+	struct drm_property	*csc_yuv_prop;
+	struct drm_property	*csc_rgb_prop;
+	struct drm_property	*colorkey_prop;
+	struct drm_property	*colorkey_min_prop;
+	struct drm_property	*colorkey_max_prop;
+	struct drm_property	*colorkey_val_prop;
+	struct drm_property	*colorkey_alpha_prop;
+	struct drm_property	*colorkey_mode_prop;
+	struct drm_property	*brightness_prop;
+	struct drm_property	*contrast_prop;
+	struct drm_property	*saturation_prop;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry		*de;
+#endif
+};
+
+void __armada_drm_queue_unref_work(struct drm_device *,
+	struct drm_framebuffer *);
+void armada_drm_queue_unref_work(struct drm_device *,
+	struct drm_framebuffer *);
+
+extern const struct drm_mode_config_funcs armada_drm_mode_config_funcs;
+
+int armada_fbdev_init(struct drm_device *);
+void armada_fbdev_fini(struct drm_device *);
+
+int armada_overlay_plane_create(struct drm_device *, unsigned long);
+
+int armada_drm_debugfs_init(struct drm_minor *);
+void armada_drm_debugfs_cleanup(struct drm_minor *);
+
+#endif
diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
new file mode 100644
index 0000000..e0a08e9
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -0,0 +1,381 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include "armada_crtc.h"
+#include "armada_drm.h"
+#include "armada_gem.h"
+#include "armada_hw.h"
+#include "armada_ioctl.h"
+#include "armada_ioctlP.h"
+
+static void armada_drm_unref_work(struct work_struct *work)
+{
+	struct armada_private *priv =
+		container_of(work, struct armada_private, fb_unref_work);
+	struct drm_framebuffer *fb;
+
+	while (kfifo_get(&priv->fb_unref, &fb))
+		drm_framebuffer_unreference(fb);
+}
+
+/* Must be called with dev->event_lock held */
+void __armada_drm_queue_unref_work(struct drm_device *dev,
+	struct drm_framebuffer *fb)
+{
+	struct armada_private *priv = dev->dev_private;
+
+	/*
+	 * Yes, we really must jump through these hoops just to store a
+	 * _pointer_ to something into the kfifo.  This is utterly insane
+	 * and idiotic, because it kfifo requires the _data_ pointed to by
+	 * the pointer const, not the pointer itself.  Not only that, but
+	 * you have to pass a pointer _to_ the pointer you want stored.
+	 */
+	const struct drm_framebuffer *silly_api_alert = fb;
+	WARN_ON(!kfifo_put(&priv->fb_unref, &silly_api_alert));
+	schedule_work(&priv->fb_unref_work);
+}
+
+void armada_drm_queue_unref_work(struct drm_device *dev,
+	struct drm_framebuffer *fb)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	__armada_drm_queue_unref_work(dev, fb);
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+}
+
+static int armada_drm_load(struct drm_device *dev, unsigned long flags)
+{
+	const struct platform_device_id *id;
+	struct armada_private *priv;
+	struct resource *res[ARRAY_SIZE(priv->dcrtc)];
+	struct resource *mem = NULL;
+	int ret, n, i;
+
+	memset(res, 0, sizeof(res));
+
+	for (n = i = 0; ; n++) {
+		struct resource *r = platform_get_resource(dev->platformdev,
+							   IORESOURCE_MEM, n);
+		if (!r)
+			break;
+
+		/* Resources above 64K are graphics memory */
+		if (resource_size(r) > SZ_64K)
+			mem = r;
+		else if (i < ARRAY_SIZE(priv->dcrtc))
+			res[i++] = r;
+		else
+			return -EINVAL;
+	}
+
+	if (!res[0] || !mem)
+		return -ENXIO;
+
+	if (!devm_request_mem_region(dev->dev, mem->start,
+			resource_size(mem), "armada-drm"))
+		return -EBUSY;
+
+	priv = devm_kzalloc(dev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		DRM_ERROR("failed to allocate private\n");
+		return -ENOMEM;
+	}
+
+	dev->dev_private = priv;
+
+	/* Get the implementation specific driver data. */
+	id = platform_get_device_id(dev->platformdev);
+	if (!id)
+		return -ENXIO;
+
+	priv->variant = (struct armada_variant *)id->driver_data;
+
+	ret = priv->variant->init(priv, dev->dev);
+	if (ret)
+		return ret;
+
+	INIT_WORK(&priv->fb_unref_work, armada_drm_unref_work);
+	INIT_KFIFO(priv->fb_unref);
+
+	/* Mode setting support */
+	drm_mode_config_init(dev);
+	dev->mode_config.min_width = 320;
+	dev->mode_config.min_height = 200;
+
+	/*
+	 * With vscale enabled, the maximum width is 1920 due to the
+	 * 1920 by 3 lines RAM
+	 */
+	dev->mode_config.max_width = 1920;
+	dev->mode_config.max_height = 2048;
+
+	dev->mode_config.preferred_depth = 24;
+	dev->mode_config.funcs = &armada_drm_mode_config_funcs;
+	drm_mm_init(&priv->linear, mem->start, resource_size(mem));
+
+	/* Create all LCD controllers */
+	for (n = 0; n < ARRAY_SIZE(priv->dcrtc); n++) {
+		if (!res[n])
+			break;
+
+		ret = armada_drm_crtc_create(dev, n, res[n]);
+		if (ret)
+			goto err_kms;
+	}
+
+	ret = drm_vblank_init(dev, n);
+	if (ret)
+		goto err_kms;
+
+	ret = drm_irq_install(dev);
+	if (ret)
+		goto err_kms;
+
+	dev->vblank_disable_allowed = 1;
+
+	ret = armada_fbdev_init(dev);
+	if (ret)
+		goto err_irq;
+
+	drm_kms_helper_poll_init(dev);
+
+	return 0;
+
+ err_irq:
+	drm_irq_uninstall(dev);
+ err_kms:
+	drm_mode_config_cleanup(dev);
+	drm_mm_takedown(&priv->linear);
+	flush_work(&priv->fb_unref_work);
+
+	return ret;
+}
+
+static int armada_drm_unload(struct drm_device *dev)
+{
+	struct armada_private *priv = dev->dev_private;
+
+	drm_kms_helper_poll_fini(dev);
+	armada_fbdev_fini(dev);
+	drm_irq_uninstall(dev);
+	drm_mode_config_cleanup(dev);
+	drm_mm_takedown(&priv->linear);
+	flush_work(&priv->fb_unref_work);
+	dev->dev_private = NULL;
+
+	return 0;
+}
+
+void armada_drm_vbl_event_add(struct armada_crtc *dcrtc,
+	struct armada_vbl_event *evt)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dcrtc->irq_lock, flags);
+	if (list_empty(&evt->node)) {
+		list_add_tail(&evt->node, &dcrtc->vbl_list);
+
+		drm_vblank_get(dcrtc->crtc.dev, dcrtc->num);
+	}
+	spin_unlock_irqrestore(&dcrtc->irq_lock, flags);
+}
+
+void armada_drm_vbl_event_remove(struct armada_crtc *dcrtc,
+	struct armada_vbl_event *evt)
+{
+	if (!list_empty(&evt->node)) {
+		list_del_init(&evt->node);
+		drm_vblank_put(dcrtc->crtc.dev, dcrtc->num);
+	}
+}
+
+void armada_drm_vbl_event_remove_unlocked(struct armada_crtc *dcrtc,
+	struct armada_vbl_event *evt)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dcrtc->irq_lock, flags);
+	armada_drm_vbl_event_remove(dcrtc, evt);
+	spin_unlock_irqrestore(&dcrtc->irq_lock, flags);
+}
+
+/* These are called under the vbl_lock. */
+static int armada_drm_enable_vblank(struct drm_device *dev, int crtc)
+{
+	struct armada_private *priv = dev->dev_private;
+	armada_drm_crtc_enable_irq(priv->dcrtc[crtc], VSYNC_IRQ_ENA);
+	return 0;
+}
+
+static void armada_drm_disable_vblank(struct drm_device *dev, int crtc)
+{
+	struct armada_private *priv = dev->dev_private;
+	armada_drm_crtc_disable_irq(priv->dcrtc[crtc], VSYNC_IRQ_ENA);
+}
+
+static irqreturn_t armada_drm_irq_handler(int irq, void *arg)
+{
+	struct drm_device *dev = arg;
+	struct armada_private *priv = dev->dev_private;
+	struct armada_crtc *dcrtc = priv->dcrtc[0];
+	uint32_t v, stat = readl_relaxed(dcrtc->base + LCD_SPU_IRQ_ISR);
+	irqreturn_t handled = IRQ_NONE;
+
+	/*
+	 * This is rediculous - rather than writing bits to clear, we
+	 * have to set the actual status register value.  This is racy.
+	 */
+	writel_relaxed(0, dcrtc->base + LCD_SPU_IRQ_ISR);
+
+	/* Mask out those interrupts we haven't enabled */
+	v = stat & dcrtc->irq_ena;
+
+	if (v & (VSYNC_IRQ|GRA_FRAME_IRQ|DUMB_FRAMEDONE)) {
+		armada_drm_crtc_irq(dcrtc, stat);
+		handled = IRQ_HANDLED;
+	}
+
+	return handled;
+}
+
+static int armada_drm_irq_postinstall(struct drm_device *dev)
+{
+	struct armada_private *priv = dev->dev_private;
+	struct armada_crtc *dcrtc = priv->dcrtc[0];
+
+	spin_lock_irq(&dev->vbl_lock);
+	writel_relaxed(dcrtc->irq_ena, dcrtc->base + LCD_SPU_IRQ_ENA);
+	writel(0, dcrtc->base + LCD_SPU_IRQ_ISR);
+	spin_unlock_irq(&dev->vbl_lock);
+
+	return 0;
+}
+
+static void armada_drm_irq_uninstall(struct drm_device *dev)
+{
+	struct armada_private *priv = dev->dev_private;
+	struct armada_crtc *dcrtc = priv->dcrtc[0];
+
+	writel(0, dcrtc->base + LCD_SPU_IRQ_ENA);
+}
+
+static struct drm_ioctl_desc armada_ioctls[] = {
+	DRM_IOCTL_DEF_DRV(ARMADA_GEM_CREATE, armada_gem_create_ioctl,
+		DRM_UNLOCKED),
+	DRM_IOCTL_DEF_DRV(ARMADA_GEM_MMAP, armada_gem_mmap_ioctl,
+		DRM_UNLOCKED),
+	DRM_IOCTL_DEF_DRV(ARMADA_GEM_PWRITE, armada_gem_pwrite_ioctl,
+		DRM_UNLOCKED),
+};
+
+static const struct file_operations armada_drm_fops = {
+	.owner			= THIS_MODULE,
+	.llseek			= no_llseek,
+	.read			= drm_read,
+	.poll			= drm_poll,
+	.unlocked_ioctl		= drm_ioctl,
+	.mmap			= drm_gem_mmap,
+	.open			= drm_open,
+	.release		= drm_release,
+	.fasync			= drm_fasync,
+};
+
+static struct drm_driver armada_drm_driver = {
+	.load			= armada_drm_load,
+	.open			= NULL,
+	.preclose		= NULL,
+	.postclose		= NULL,
+	.lastclose		= NULL,
+	.unload			= armada_drm_unload,
+	.get_vblank_counter	= drm_vblank_count,
+	.enable_vblank		= armada_drm_enable_vblank,
+	.disable_vblank		= armada_drm_disable_vblank,
+	.irq_handler		= armada_drm_irq_handler,
+	.irq_postinstall	= armada_drm_irq_postinstall,
+	.irq_uninstall		= armada_drm_irq_uninstall,
+#ifdef CONFIG_DEBUG_FS
+	.debugfs_init		= armada_drm_debugfs_init,
+	.debugfs_cleanup	= armada_drm_debugfs_cleanup,
+#endif
+	.gem_init_object	= NULL,
+	.gem_free_object	= armada_gem_free_object,
+	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle	= NULL,
+	.gem_prime_export	= armada_gem_prime_export,
+	.gem_prime_import	= NULL,
+	.dumb_create		= armada_gem_dumb_create,
+	.dumb_map_offset	= armada_gem_dumb_map_offset,
+	.dumb_destroy		= armada_gem_dumb_destroy,
+	.gem_vm_ops		= &armada_gem_vm_ops,
+	.major			= 1,
+	.minor			= 0,
+	.name			= "armada-drm",
+	.desc			= "Armada SoC DRM",
+	.date			= "20120730",
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET |
+				  DRIVER_HAVE_IRQ | DRIVER_PRIME,
+	.ioctls			= armada_ioctls,
+	.fops			= &armada_drm_fops,
+};
+
+static int armada_drm_probe(struct platform_device *pdev)
+{
+	return drm_platform_init(&armada_drm_driver, pdev);
+}
+
+static int armada_drm_remove(struct platform_device *pdev)
+{
+	drm_platform_exit(&armada_drm_driver, pdev);
+	return 0;
+}
+
+static const struct platform_device_id armada_drm_platform_ids[] = {
+	{
+		.name		= "armada-drm",
+		.driver_data	= (unsigned long)&armada510_ops,
+	}, {
+		.name		= "armada-510-drm",
+		.driver_data	= (unsigned long)&armada510_ops,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, armada_drm_platform_ids);
+
+static struct platform_driver armada_drm_platform_driver = {
+	.probe	= armada_drm_probe,
+	.remove	= armada_drm_remove,
+	.driver	= {
+		.name	= "armada-drm",
+		.owner	= THIS_MODULE,
+	},
+	.id_table = armada_drm_platform_ids,
+};
+
+static int __init armada_drm_init(void)
+{
+	armada_drm_driver.num_ioctls = DRM_ARRAY_SIZE(armada_ioctls);
+	return platform_driver_register(&armada_drm_platform_driver);
+}
+module_init(armada_drm_init);
+
+static void __exit armada_drm_exit(void)
+{
+	platform_driver_unregister(&armada_drm_platform_driver);
+}
+module_exit(armada_drm_exit);
+
+MODULE_AUTHOR("Russell King <rmk+kernel@arm.linux.org.uk>");
+MODULE_DESCRIPTION("Armada DRM Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:armada-drm");
diff --git a/drivers/gpu/drm/armada/armada_fb.c b/drivers/gpu/drm/armada/armada_fb.c
new file mode 100644
index 0000000..5154f04
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_fb.c
@@ -0,0 +1,155 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_helper.h>
+#include "armada_drm.h"
+#include "armada_fb.h"
+#include "armada_gem.h"
+#include "armada_hw.h"
+
+static void armada_fb_destroy(struct drm_framebuffer *fb)
+{
+	struct armada_framebuffer *dfb = drm_fb_to_armada_fb(fb);
+
+	drm_framebuffer_cleanup(&dfb->fb);
+	drm_gem_object_unreference_unlocked(&dfb->obj->obj);
+	kfree(dfb);
+}
+
+static int armada_fb_create_handle(struct drm_framebuffer *fb,
+	struct drm_file *dfile, unsigned int *handle)
+{
+	struct armada_framebuffer *dfb = drm_fb_to_armada_fb(fb);
+	return drm_gem_handle_create(dfile, &dfb->obj->obj, handle);
+}
+
+static const struct drm_framebuffer_funcs armada_fb_funcs = {
+	.destroy	= armada_fb_destroy,
+	.create_handle	= armada_fb_create_handle,
+};
+
+struct armada_framebuffer *armada_framebuffer_create(struct drm_device *dev,
+	struct drm_mode_fb_cmd2 *mode, struct armada_gem_object *obj)
+{
+	struct armada_framebuffer *dfb;
+	uint8_t format, config;
+	int ret;
+
+	switch (mode->pixel_format) {
+#define FMT(drm, fmt, mod)		\
+	case DRM_FORMAT_##drm:		\
+		format = CFG_##fmt;	\
+		config = mod;		\
+		break
+	FMT(RGB565,	565,		CFG_SWAPRB);
+	FMT(BGR565,	565,		0);
+	FMT(ARGB1555,	1555,		CFG_SWAPRB);
+	FMT(ABGR1555,	1555,		0);
+	FMT(RGB888,	888PACK,	CFG_SWAPRB);
+	FMT(BGR888,	888PACK,	0);
+	FMT(XRGB8888,	X888,		CFG_SWAPRB);
+	FMT(XBGR8888,	X888,		0);
+	FMT(ARGB8888,	8888,		CFG_SWAPRB);
+	FMT(ABGR8888,	8888,		0);
+	FMT(YUYV,	422PACK,	CFG_YUV2RGB | CFG_SWAPYU | CFG_SWAPUV);
+	FMT(UYVY,	422PACK,	CFG_YUV2RGB);
+	FMT(VYUY,	422PACK,	CFG_YUV2RGB | CFG_SWAPUV);
+	FMT(YVYU,	422PACK,	CFG_YUV2RGB | CFG_SWAPYU);
+	FMT(YUV422,	422,		CFG_YUV2RGB | CFG_SWAPUV);
+	FMT(YVU422,	422,		CFG_YUV2RGB);
+	FMT(YUV420,	420,		CFG_YUV2RGB | CFG_SWAPUV);
+	FMT(YVU420,	420,		CFG_YUV2RGB);
+	FMT(C8,		PSEUDO8,	0);
+#undef FMT
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	dfb = kzalloc(sizeof(*dfb), GFP_KERNEL);
+	if (!dfb) {
+		DRM_ERROR("failed to allocate Armada fb object\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	dfb->fmt = format;
+	dfb->mod = config;
+
+	ret = drm_framebuffer_init(dev, &dfb->fb, &armada_fb_funcs);
+	if (ret) {
+		kfree(dfb);
+		return ERR_PTR(ret);
+	}
+
+	drm_helper_mode_fill_fb_struct(&dfb->fb, mode);
+
+	/*
+	 * Take a reference on our object - the caller is expected
+	 * to drop their reference to it.
+	 */
+	drm_gem_object_reference(&obj->obj);
+	dfb->obj = obj;
+
+	return dfb;
+}
+
+static struct drm_framebuffer *armada_fb_create(struct drm_device *dev,
+	struct drm_file *dfile, struct drm_mode_fb_cmd2 *mode)
+{
+	struct armada_gem_object *obj;
+	struct armada_framebuffer *dfb;
+	int ret;
+
+	DRM_DEBUG_DRIVER("w%u h%u pf%08x f%u p%u,%u,%u\n",
+		mode->width, mode->height, mode->pixel_format,
+		mode->flags, mode->pitches[0], mode->pitches[1],
+		mode->pitches[2]);
+
+	/* We can only handle a single plane at the moment */
+	if (drm_format_num_planes(mode->pixel_format) > 1)
+		return ERR_PTR(-EINVAL);
+
+	obj = armada_gem_object_lookup(dev, dfile, mode->handles[0]);
+	if (!obj) {
+		DRM_ERROR("failed to lookup gem object\n");
+		return ERR_PTR(-ENOENT);
+	}
+
+	/* Framebuffer objects must have a valid device address for scanout */
+	if (obj->dev_addr == DMA_ERROR_CODE) {
+		ret = -EINVAL;
+		goto unref;
+	}
+
+	dfb = armada_framebuffer_create(dev, mode, obj);
+	ret = IS_ERR(dfb) ? PTR_ERR(dfb) : 0;
+
+unref:
+	drm_gem_object_unreference_unlocked(&obj->obj);
+
+	if (ret) {
+		DRM_ERROR("failed to initialize framebuffer: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	return &dfb->fb;
+}
+
+static void armada_output_poll_changed(struct drm_device *dev)
+{
+	struct armada_private *priv = dev->dev_private;
+	struct drm_fb_helper *fbh = priv->fbdev;
+
+	if (fbh)
+		drm_fb_helper_hotplug_event(fbh);
+}
+
+const struct drm_mode_config_funcs armada_drm_mode_config_funcs = {
+	.fb_create		= armada_fb_create,
+	.output_poll_changed	= armada_output_poll_changed,
+};
diff --git a/drivers/gpu/drm/armada/armada_fb.h b/drivers/gpu/drm/armada/armada_fb.h
new file mode 100644
index 0000000..ce3f12e
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_fb.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ARMADA_FB_H
+#define ARMADA_FB_H
+
+struct armada_framebuffer {
+	struct drm_framebuffer	fb;
+	struct armada_gem_object *obj;
+	uint8_t			fmt;
+	uint8_t			mod;
+};
+#define drm_fb_to_armada_fb(dfb) \
+	container_of(dfb, struct armada_framebuffer, fb)
+#define drm_fb_obj(fb) drm_fb_to_armada_fb(fb)->obj
+
+struct armada_framebuffer *armada_framebuffer_create(struct drm_device *,
+	struct drm_mode_fb_cmd2 *, struct armada_gem_object *);
+
+#endif
diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/armada/armada_fbdev.c
new file mode 100644
index 0000000..840e322
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_fbdev.c
@@ -0,0 +1,206 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *  Written from the i915 driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/errno.h>
+#include <linux/fb.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_fb_helper.h>
+#include "armada_crtc.h"
+#include "armada_drm.h"
+#include "armada_fb.h"
+#include "armada_gem.h"
+
+static /*const*/ struct fb_ops armada_fb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_check_var	= drm_fb_helper_check_var,
+	.fb_set_par	= drm_fb_helper_set_par,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+	.fb_pan_display	= drm_fb_helper_pan_display,
+	.fb_blank	= drm_fb_helper_blank,
+	.fb_setcmap	= drm_fb_helper_setcmap,
+	.fb_debug_enter	= drm_fb_helper_debug_enter,
+	.fb_debug_leave	= drm_fb_helper_debug_leave,
+};
+
+static int armada_fb_create(struct drm_fb_helper *fbh,
+	struct drm_fb_helper_surface_size *sizes)
+{
+	struct drm_device *dev = fbh->dev;
+	struct drm_mode_fb_cmd2 mode;
+	struct armada_framebuffer *dfb;
+	struct armada_gem_object *obj;
+	struct fb_info *info;
+	int size, ret;
+	void *ptr;
+
+	memset(&mode, 0, sizeof(mode));
+	mode.width = sizes->surface_width;
+	mode.height = sizes->surface_height;
+	mode.pitches[0] = armada_pitch(mode.width, sizes->surface_bpp);
+	mode.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
+					sizes->surface_depth);
+
+	size = mode.pitches[0] * mode.height;
+	obj = armada_gem_alloc_private_object(dev, size);
+	if (!obj) {
+		DRM_ERROR("failed to allocate fb memory\n");
+		return -ENOMEM;
+	}
+
+	ret = armada_gem_linear_back(dev, obj);
+	if (ret) {
+		drm_gem_object_unreference_unlocked(&obj->obj);
+		return ret;
+	}
+
+	ptr = armada_gem_map_object(dev, obj);
+	if (!ptr) {
+		drm_gem_object_unreference_unlocked(&obj->obj);
+		return -ENOMEM;
+	}
+
+	dfb = armada_framebuffer_create(dev, &mode, obj);
+	if (IS_ERR(dfb)) {
+		ret = PTR_ERR(dfb);
+		goto err_fbcreate;
+	}
+
+	mutex_lock(&dev->struct_mutex);
+
+	info = framebuffer_alloc(0, dev->dev);
+	if (!info) {
+		ret = -ENOMEM;
+		goto err_fballoc;
+	}
+
+	ret = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (ret) {
+		ret = -ENOMEM;
+		goto err_fbcmap;
+	}
+
+	strlcpy(info->fix.id, "armada-drmfb", sizeof(info->fix.id));
+	info->par = fbh;
+	info->flags = FBINFO_DEFAULT | FBINFO_CAN_FORCE_OUTPUT;
+	info->fbops = &armada_fb_ops;
+	info->fix.smem_start = obj->phys_addr;
+	info->fix.smem_len = obj->obj.size;
+	info->screen_size = obj->obj.size;
+	info->screen_base = ptr;
+	fbh->fb = &dfb->fb;
+	fbh->fbdev = info;
+	drm_fb_helper_fill_fix(info, dfb->fb.pitches[0], dfb->fb.depth);
+	drm_fb_helper_fill_var(info, fbh, sizes->fb_width, sizes->fb_height);
+
+	DRM_DEBUG_KMS("allocated %dx%d %dbpp fb: 0x%08x\n",
+		dfb->fb.width, dfb->fb.height,
+		dfb->fb.bits_per_pixel, obj->phys_addr);
+
+	/* Reference is now held by the framebuffer object */
+	drm_gem_object_unreference(&obj->obj);
+	mutex_unlock(&dev->struct_mutex);
+
+	return 0;
+
+ err_fbcmap:
+	framebuffer_release(info);
+ err_fballoc:
+	mutex_unlock(&dev->struct_mutex);
+	dfb->fb.funcs->destroy(&dfb->fb);
+ err_fbcreate:
+	drm_gem_object_unreference_unlocked(&obj->obj);
+	return ret;
+}
+
+static int armada_fb_probe(struct drm_fb_helper *fbh,
+	struct drm_fb_helper_surface_size *sizes)
+{
+	int ret = 0;
+
+	if (!fbh->fb) {
+		ret = armada_fb_create(fbh, sizes);
+		if (ret == 0)
+			ret = 1;
+	}
+	return ret;
+}
+
+static struct drm_fb_helper_funcs armada_fb_helper_funcs = {
+	.gamma_set	= armada_drm_crtc_gamma_set,
+	.gamma_get	= armada_drm_crtc_gamma_get,
+	.fb_probe	= armada_fb_probe,
+};
+
+int armada_fbdev_init(struct drm_device *dev)
+{
+	struct armada_private *priv = dev->dev_private;
+	struct drm_fb_helper *fbh;
+	int ret;
+
+	fbh = devm_kzalloc(dev->dev, sizeof(*fbh), GFP_KERNEL);
+	if (!fbh)
+		return -ENOMEM;
+
+	priv->fbdev = fbh;
+
+	fbh->funcs = &armada_fb_helper_funcs;
+
+	ret = drm_fb_helper_init(dev, fbh, 1, 1);
+	if (ret) {
+		DRM_ERROR("failed to initialize drm fb helper\n");
+		goto err_fb_helper;
+	}
+
+	ret = drm_fb_helper_single_add_all_connectors(fbh);
+	if (ret) {
+		DRM_ERROR("failed to add fb connectors\n");
+		goto err_fb_setup;
+	}
+
+	ret = drm_fb_helper_initial_config(fbh, 32);
+	if (ret) {
+		DRM_ERROR("failed to set initial config\n");
+		goto err_fb_setup;
+	}
+
+	return 0;
+ err_fb_setup:
+	drm_fb_helper_fini(fbh);
+ err_fb_helper:
+	priv->fbdev = NULL;
+	return ret;
+}
+
+void armada_fbdev_fini(struct drm_device *dev)
+{
+	struct armada_private *priv = dev->dev_private;
+	struct drm_fb_helper *fbh = priv->fbdev;
+
+	if (fbh) {
+		struct fb_info *info = fbh->fbdev;
+
+		if (info) {
+			unregister_framebuffer(info);
+			if (info->cmap.len)
+				fb_dealloc_cmap(&info->cmap);
+			framebuffer_release(info);
+		}
+
+		if (fbh->fb)
+			fbh->fb->funcs->destroy(fbh->fb);
+
+		drm_fb_helper_fini(fbh);
+
+		priv->fbdev = NULL;
+	}
+}
diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
new file mode 100644
index 0000000..d09fa14
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -0,0 +1,541 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/dma-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/shmem_fs.h>
+#include <drm/drmP.h>
+#include "armada_drm.h"
+#include "armada_gem.h"
+#include "armada_ioctl.h"
+#include "armada_ioctlP.h"
+
+static int armada_gem_vm_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct armada_gem_object *obj = drm_to_armada_gem(vma->vm_private_data);
+	unsigned long addr = (unsigned long)vmf->virtual_address;
+	unsigned long pfn = obj->phys_addr >> PAGE_SHIFT;
+	int ret;
+
+	pfn += (addr - vma->vm_start) >> PAGE_SHIFT;
+	ret = vm_insert_pfn(vma, addr, pfn);
+
+	switch (ret) {
+	case -EIO:
+	case -EAGAIN:
+		set_need_resched();
+	case 0:
+	case -ERESTARTSYS:
+	case -EINTR:
+		return VM_FAULT_NOPAGE;
+	case -ENOMEM:
+		return VM_FAULT_OOM;
+	default:
+		return VM_FAULT_SIGBUS;
+	}
+}
+
+const struct vm_operations_struct armada_gem_vm_ops = {
+	.fault	= armada_gem_vm_fault,
+	.open	= drm_gem_vm_open,
+	.close	= drm_gem_vm_close,
+};
+
+static size_t roundup_gem_size(size_t size)
+{
+	return roundup(size, PAGE_SIZE);
+}
+
+void armada_gem_free_object(struct drm_gem_object *obj)
+{
+	struct armada_gem_object *dobj = drm_to_armada_gem(obj);
+
+	DRM_DEBUG_DRIVER("release obj %p\n", dobj);
+
+	if (dobj->obj.map_list.map)
+		drm_gem_free_mmap_offset(&dobj->obj);
+
+	if (dobj->page) {
+		/* page backed memory */
+		unsigned int order = get_order(dobj->obj.size);
+		__free_pages(dobj->page, order);
+	} else if (dobj->linear) {
+		/* linear backed memory */
+		drm_mm_put_block(dobj->linear);
+		if (dobj->addr)
+			iounmap(dobj->addr);
+	}
+
+
+	drm_gem_object_release(&dobj->obj);
+
+	kfree(dobj);
+}
+
+int
+armada_gem_linear_back(struct drm_device *dev, struct armada_gem_object *obj)
+{
+	struct armada_private *priv = dev->dev_private;
+	size_t size = obj->obj.size;
+
+	if (obj->page || obj->linear)
+		return 0;
+
+	/*
+	 * If it is a small allocation (typically cursor, which will
+	 * be 32x64 or 64x32 ARGB pixels) try to get it from the system.
+	 * Framebuffers will never be this small (our minimum size for
+	 * framebuffers is larger than this anyway.)  Such objects are
+	 * only accessed by the CPU so we don't need any special handing
+	 * here.
+	 */
+	if (size <= 8192) {
+		unsigned int order = get_order(size);
+		struct page *p = alloc_pages(GFP_KERNEL, order);
+
+		if (p) {
+			obj->addr = page_address(p);
+			obj->phys_addr = page_to_phys(p);
+			obj->page = p;
+
+			memset(obj->addr, 0, PAGE_ALIGN(size));
+		}
+	}
+
+	/*
+	 * We could grab something from CMA if it's enabled, but that
+	 * involves building in a problem:
+	 *
+	 * CMA's interface uses dma_alloc_coherent(), which provides us
+	 * with an CPU virtual address and a device address.
+	 *
+	 * The CPU virtual address may be either an address in the kernel
+	 * direct mapped region (for example, as it would be on x86) or
+	 * it may be remapped into another part of kernel memory space
+	 * (eg, as it would be on ARM.)  This means virt_to_phys() on the
+	 * returned virtual address is invalid depending on the architecture
+	 * implementation.
+	 *
+	 * The device address may also not be a physical address; it may
+	 * be that there is some kind of remapping between the device and
+	 * system RAM, which makes the use of the device address also
+	 * unsafe to re-use as a physical address.
+	 *
+	 * This makes DRM usage of dma_alloc_coherent() in a generic way
+	 * at best very questionable and unsafe.
+	 */
+
+	/* Otherwise, grab it from our linear allocation */
+	if (!obj->page) {
+		struct drm_mm_node *free;
+		unsigned align = min_t(unsigned, size, SZ_2M);
+		void __iomem *ptr;
+
+		mutex_lock(&dev->struct_mutex);
+		free = drm_mm_search_free(&priv->linear, size, align, 0);
+		if (free)
+			obj->linear = drm_mm_get_block(free, size, align);
+		mutex_unlock(&dev->struct_mutex);
+		if (!obj->linear)
+			return -ENOSPC;
+
+		/* Ensure that the memory we're returning is cleared. */
+		ptr = ioremap_wc(obj->linear->start, size);
+		if (!ptr) {
+			drm_mm_put_block(obj->linear);
+			obj->linear = NULL;
+			return -ENOMEM;
+		}
+
+		memset_io(ptr, 0, size);
+		iounmap(ptr);
+
+		obj->phys_addr = obj->linear->start;
+		obj->dev_addr = obj->linear->start;
+	}
+
+	DRM_DEBUG_DRIVER("obj %p phys %#x dev %#x\n",
+			 obj, obj->phys_addr, obj->dev_addr);
+
+	return 0;
+}
+
+void *
+armada_gem_map_object(struct drm_device *dev, struct armada_gem_object *dobj)
+{
+	/* only linear objects need to be ioremap'd */
+	if (!dobj->addr && dobj->linear)
+		dobj->addr = ioremap_wc(dobj->phys_addr, dobj->obj.size);
+	return dobj->addr;
+}
+
+struct armada_gem_object *
+armada_gem_alloc_private_object(struct drm_device *dev, size_t size)
+{
+	struct armada_gem_object *obj;
+
+	size = roundup_gem_size(size);
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return NULL;
+
+	if (drm_gem_private_object_init(dev, &obj->obj, size)) {
+		kfree(obj);
+		return NULL;
+	}
+
+	obj->dev_addr = DMA_ERROR_CODE;
+
+	DRM_DEBUG_DRIVER("alloc private obj %p size %zu\n", obj, size);
+
+	return obj;
+}
+
+struct armada_gem_object *armada_gem_alloc_object(struct drm_device *dev,
+	size_t size)
+{
+	struct armada_gem_object *obj;
+	struct address_space *mapping;
+
+	size = roundup_gem_size(size);
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return NULL;
+
+	if (drm_gem_object_init(dev, &obj->obj, size)) {
+		kfree(obj);
+		return NULL;
+	}
+
+	obj->dev_addr = DMA_ERROR_CODE;
+
+	mapping = obj->obj.filp->f_path.dentry->d_inode->i_mapping;
+	mapping_set_gfp_mask(mapping, GFP_HIGHUSER | __GFP_RECLAIMABLE);
+
+	DRM_DEBUG_DRIVER("alloc obj %p size %zu\n", obj, size);
+
+	return obj;
+}
+
+/* Dumb alloc support */
+int armada_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
+	struct drm_mode_create_dumb *args)
+{
+	struct armada_gem_object *dobj;
+	u32 handle;
+	size_t size;
+	int ret;
+
+	args->pitch = armada_pitch(args->width, args->bpp);
+	args->size = size = args->pitch * args->height;
+
+	dobj = armada_gem_alloc_private_object(dev, size);
+	if (dobj == NULL)
+		return -ENOMEM;
+
+	ret = armada_gem_linear_back(dev, dobj);
+	if (ret)
+		goto err;
+
+	ret = drm_gem_handle_create(file, &dobj->obj, &handle);
+	if (ret)
+		goto err;
+
+	args->handle = handle;
+
+	/* drop reference from allocate - handle holds it now */
+	DRM_DEBUG_DRIVER("obj %p size %zu handle %#x\n", dobj, size, handle);
+ err:
+	drm_gem_object_unreference_unlocked(&dobj->obj);
+	return ret;
+}
+
+int armada_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
+	uint32_t handle, uint64_t *offset)
+{
+	struct armada_gem_object *obj;
+	int ret = 0;
+
+	mutex_lock(&dev->struct_mutex);
+	obj = armada_gem_object_lookup(dev, file, handle);
+	if (!obj) {
+		DRM_ERROR("failed to lookup gem object\n");
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
+	if (!obj->obj.map_list.map)
+		ret = drm_gem_create_mmap_offset(&obj->obj);
+
+	if (ret == 0) {
+		*offset = (u64)obj->obj.map_list.hash.key << PAGE_SHIFT;
+		DRM_DEBUG_DRIVER("handle %#x offset %llx\n", handle, *offset);
+	}
+
+	drm_gem_object_unreference(&obj->obj);
+ err_unlock:
+	mutex_unlock(&dev->struct_mutex);
+
+	return ret;
+}
+
+int armada_gem_dumb_destroy(struct drm_file *file, struct drm_device *dev,
+	uint32_t handle)
+{
+	return drm_gem_handle_delete(file, handle);
+}
+
+/* Private driver gem ioctls */
+int armada_gem_create_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *file)
+{
+	struct drm_armada_gem_create *args = data;
+	struct armada_gem_object *dobj;
+	size_t size;
+	u32 handle;
+	int ret;
+
+	if (args->size == 0)
+		return -ENOMEM;
+
+	size = args->size;
+
+	dobj = armada_gem_alloc_object(dev, size);
+	if (dobj == NULL)
+		return -ENOMEM;
+
+	ret = drm_gem_handle_create(file, &dobj->obj, &handle);
+	if (ret)
+		goto err;
+
+	args->handle = handle;
+
+	/* drop reference from allocate - handle holds it now */
+	DRM_DEBUG_DRIVER("obj %p size %zu handle %#x\n", dobj, size, handle);
+ err:
+	drm_gem_object_unreference_unlocked(&dobj->obj);
+	return ret;
+}
+
+/* Map a shmem-backed object into process memory space */
+int armada_gem_mmap_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *file)
+{
+	struct drm_armada_gem_mmap *args = data;
+	struct armada_gem_object *dobj;
+	unsigned long addr;
+
+	dobj = armada_gem_object_lookup(dev, file, args->handle);
+	if (dobj == NULL)
+		return -ENOENT;
+
+	if (!dobj->obj.filp) {
+		drm_gem_object_unreference(&dobj->obj);
+		return -EINVAL;
+	}
+
+	addr = vm_mmap(dobj->obj.filp, 0, args->size, PROT_READ | PROT_WRITE,
+		       MAP_SHARED, args->offset);
+	drm_gem_object_unreference(&dobj->obj);
+	if (IS_ERR_VALUE(addr))
+		return addr;
+
+	args->addr = addr;
+
+	return 0;
+}
+
+int armada_gem_pwrite_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *file)
+{
+	struct drm_armada_gem_pwrite *args = data;
+	struct armada_gem_object *dobj;
+	char __user *ptr;
+	int ret;
+
+	DRM_DEBUG_DRIVER("handle %u off %u size %u ptr 0x%llx\n",
+		args->handle, args->offset, args->size, args->ptr);
+
+	if (args->size == 0)
+		return 0;
+
+	ptr = (char __user *)(uintptr_t)args->ptr;
+
+	if (!access_ok(VERIFY_READ, ptr, args->size))
+		return -EFAULT;
+
+	ret = fault_in_multipages_readable(ptr, args->size);
+	if (ret)
+		return ret;
+
+	dobj = armada_gem_object_lookup(dev, file, args->handle);
+	if (dobj == NULL)
+		return -ENOENT;
+
+	/* Must be a kernel-mapped object */
+	if (!dobj->addr)
+		return -EINVAL;
+
+	if (args->offset > dobj->obj.size ||
+	    args->size > dobj->obj.size - args->offset) {
+		DRM_ERROR("invalid size: object size %u\n", dobj->obj.size);
+		ret = -EINVAL;
+		goto unref;
+	}
+
+	if (copy_from_user(dobj->addr + args->offset, ptr, args->size)) {
+		ret = -EFAULT;
+	} else if (dobj->update) {
+		dobj->update(dobj->update_data);
+		ret = 0;
+	}
+
+ unref:
+	drm_gem_object_unreference_unlocked(&dobj->obj);
+	return ret;
+}
+
+/* Prime support */
+struct sg_table *
+armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
+	enum dma_data_direction dir)
+{
+	struct drm_gem_object *obj = attach->dmabuf->priv;
+	struct armada_gem_object *dobj = drm_to_armada_gem(obj);
+	struct scatterlist *sg;
+	struct sg_table *sgt;
+	int i, num;
+
+	sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
+	if (!sgt)
+		return NULL;
+
+	if (dobj->obj.filp) {
+		struct address_space *mapping;
+		gfp_t gfp;
+		int count;
+
+		count = dobj->obj.size / PAGE_SIZE;
+		if (sg_alloc_table(sgt, count, GFP_KERNEL))
+			goto free_sgt;
+
+		mapping = file_inode(dobj->obj.filp)->i_mapping;
+		gfp = mapping_gfp_mask(mapping);
+
+		for_each_sg(sgt->sgl, sg, count, i) {
+			struct page *page;
+
+			page = shmem_read_mapping_page_gfp(mapping, i, gfp);
+			if (IS_ERR(page)) {
+				num = i;
+				goto release;
+			}
+
+			sg_set_page(sg, page, PAGE_SIZE, 0);
+		}
+
+		if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0) {
+			num = sgt->nents;
+			goto release;
+		}
+	} else if (dobj->page) {
+		/* Single contiguous page */
+		if (sg_alloc_table(sgt, 1, GFP_KERNEL))
+			goto free_sgt;
+
+		sg_set_page(sgt->sgl, dobj->page, dobj->obj.size, 0);
+
+		if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0)
+			goto free_table;
+	} else if (dobj->linear) {
+		/* Single contiguous physical region - no struct page */
+		if (sg_alloc_table(sgt, 1, GFP_KERNEL))
+			goto free_sgt;
+		sg_dma_address(sgt->sgl) = dobj->dev_addr;
+		sg_dma_len(sgt->sgl) = dobj->obj.size;
+	} else {
+		goto free_sgt;
+	}
+	return sgt;
+
+ release:
+	for_each_sg(sgt->sgl, sg, num, i)
+		page_cache_release(sg_page(sg));
+ free_table:
+	sg_free_table(sgt);
+ free_sgt:
+	kfree(sgt);
+	return NULL;
+}
+
+static void armada_gem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
+	struct sg_table *sgt, enum dma_data_direction dir)
+{
+	struct drm_gem_object *obj = attach->dmabuf->priv;
+	struct armada_gem_object *dobj = drm_to_armada_gem(obj);
+	int i;
+
+	if (!dobj->linear)
+		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
+
+	if (dobj->obj.filp) {
+		struct scatterlist *sg;
+		for_each_sg(sgt->sgl, sg, sgt->nents, i)
+			page_cache_release(sg_page(sg));
+	}
+
+	sg_free_table(sgt);
+	kfree(sgt);
+}
+
+static void armada_gem_prime_release(struct dma_buf *buf)
+{
+	struct drm_gem_object *obj = buf->priv;
+
+	if (obj->export_dma_buf == buf) {
+		/* drop the reference on the export fd holds */
+		obj->export_dma_buf = NULL;
+		drm_gem_object_unreference_unlocked(obj);
+	}
+}
+
+static void *armada_gem_dmabuf_no_kmap(struct dma_buf *buf, unsigned long n)
+{
+	return NULL;
+}
+
+static void
+armada_gem_dmabuf_no_kunmap(struct dma_buf *buf, unsigned long n, void *addr)
+{
+}
+
+static int
+armada_gem_dmabuf_mmap(struct dma_buf *buf, struct vm_area_struct *vma)
+{
+	return -EINVAL;
+}
+
+static const struct dma_buf_ops armada_gem_prime_dmabuf_ops = {
+	.map_dma_buf	= armada_gem_prime_map_dma_buf,
+	.unmap_dma_buf	= armada_gem_prime_unmap_dma_buf,
+	.release	= armada_gem_prime_release,
+	.kmap_atomic	= armada_gem_dmabuf_no_kmap,
+	.kunmap_atomic	= armada_gem_dmabuf_no_kunmap,
+	.kmap		= armada_gem_dmabuf_no_kmap,
+	.kunmap		= armada_gem_dmabuf_no_kunmap,
+	.mmap		= armada_gem_dmabuf_mmap,
+};
+
+struct dma_buf *
+armada_gem_prime_export(struct drm_device *dev, struct drm_gem_object *obj,
+	int flags)
+{
+	return dma_buf_export(obj, &armada_gem_prime_dmabuf_ops, obj->size,
+			      flags);
+}
diff --git a/drivers/gpu/drm/armada/armada_gem.h b/drivers/gpu/drm/armada/armada_gem.h
new file mode 100644
index 0000000..e3bce9f
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_gem.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ARMADA_GEM_H
+#define ARMADA_GEM_H
+
+/* GEM */
+struct armada_gem_object {
+	struct drm_gem_object	obj;
+	void			*addr;
+	phys_addr_t		phys_addr;
+	resource_size_t		dev_addr;
+	struct drm_mm_node	*linear;	/* for linear backed */
+	struct page		*page;		/* for page backed */
+	void			(*update)(void *);
+	void			*update_data;
+};
+
+extern const struct vm_operations_struct armada_gem_vm_ops;
+
+#define drm_to_armada_gem(o) container_of(o, struct armada_gem_object, obj)
+
+void armada_gem_free_object(struct drm_gem_object *);
+int armada_gem_linear_back(struct drm_device *, struct armada_gem_object *);
+void *armada_gem_map_object(struct drm_device *, struct armada_gem_object *);
+struct armada_gem_object *armada_gem_alloc_private_object(struct drm_device *,
+	size_t);
+int armada_gem_dumb_create(struct drm_file *, struct drm_device *,
+	struct drm_mode_create_dumb *);
+int armada_gem_dumb_map_offset(struct drm_file *, struct drm_device *,
+	uint32_t, uint64_t *);
+int armada_gem_dumb_destroy(struct drm_file *, struct drm_device *,
+	uint32_t);
+struct dma_buf *armada_gem_prime_export(struct drm_device *dev,
+	struct drm_gem_object *obj, int flags);
+
+static inline struct armada_gem_object *armada_gem_object_lookup(
+	struct drm_device *dev, struct drm_file *dfile, unsigned handle)
+{
+	struct drm_gem_object *obj = drm_gem_object_lookup(dev, dfile, handle);
+
+	return obj ? drm_to_armada_gem(obj) : NULL;
+}
+#endif
diff --git a/drivers/gpu/drm/armada/armada_hw.h b/drivers/gpu/drm/armada/armada_hw.h
new file mode 100644
index 0000000..216a4b5
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_hw.h
@@ -0,0 +1,316 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *  Rewritten from the dovefb driver, and Armada510 manuals.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ARMADA_HW_H
+#define ARMADA_HW_H
+
+/*
+ * Note: the following registers are written from IRQ context:
+ *  LCD_SPU_V_PORCH, LCD_SPU_ADV_REG, LCD_SPUT_V_H_TOTAL
+ *  LCD_SPU_DMA_START_ADDR_[YUV][01], LCD_SPU_DMA_PITCH_YC,
+ *  LCD_SPU_DMA_PITCH_UV, LCD_SPU_DMA_OVSA_HPXL_VLN,
+ *  LCD_SPU_DMA_HPXL_VLN, LCD_SPU_DZM_HPXL_VLN, LCD_SPU_DMA_CTRL0
+ */
+enum {
+	LCD_SPU_ADV_REG			= 0x0084,	/* Armada 510 */
+	LCD_SPU_DMA_START_ADDR_Y0	= 0x00c0,
+	LCD_SPU_DMA_START_ADDR_U0	= 0x00c4,
+	LCD_SPU_DMA_START_ADDR_V0	= 0x00c8,
+	LCD_CFG_DMA_START_ADDR_0	= 0x00cc,
+	LCD_SPU_DMA_START_ADDR_Y1	= 0x00d0,
+	LCD_SPU_DMA_START_ADDR_U1	= 0x00d4,
+	LCD_SPU_DMA_START_ADDR_V1	= 0x00d8,
+	LCD_CFG_DMA_START_ADDR_1	= 0x00dc,
+	LCD_SPU_DMA_PITCH_YC		= 0x00e0,
+	LCD_SPU_DMA_PITCH_UV		= 0x00e4,
+	LCD_SPU_DMA_OVSA_HPXL_VLN	= 0x00e8,
+	LCD_SPU_DMA_HPXL_VLN		= 0x00ec,
+	LCD_SPU_DZM_HPXL_VLN		= 0x00f0,
+	LCD_CFG_GRA_START_ADDR0		= 0x00f4,
+	LCD_CFG_GRA_START_ADDR1		= 0x00f8,
+	LCD_CFG_GRA_PITCH		= 0x00fc,
+	LCD_SPU_GRA_OVSA_HPXL_VLN	= 0x0100,
+	LCD_SPU_GRA_HPXL_VLN		= 0x0104,
+	LCD_SPU_GZM_HPXL_VLN		= 0x0108,
+	LCD_SPU_HWC_OVSA_HPXL_VLN	= 0x010c,
+	LCD_SPU_HWC_HPXL_VLN		= 0x0110,
+	LCD_SPUT_V_H_TOTAL		= 0x0114,
+	LCD_SPU_V_H_ACTIVE		= 0x0118,
+	LCD_SPU_H_PORCH			= 0x011c,
+	LCD_SPU_V_PORCH			= 0x0120,
+	LCD_SPU_BLANKCOLOR		= 0x0124,
+	LCD_SPU_ALPHA_COLOR1		= 0x0128,
+	LCD_SPU_ALPHA_COLOR2		= 0x012c,
+	LCD_SPU_COLORKEY_Y		= 0x0130,
+	LCD_SPU_COLORKEY_U		= 0x0134,
+	LCD_SPU_COLORKEY_V		= 0x0138,
+	LCD_CFG_RDREG4F			= 0x013c,	/* Armada 510 */
+	LCD_SPU_SPI_RXDATA		= 0x0140,
+	LCD_SPU_ISA_RXDATA		= 0x0144,
+	LCD_SPU_HWC_RDDAT		= 0x0158,
+	LCD_SPU_GAMMA_RDDAT		= 0x015c,
+	LCD_SPU_PALETTE_RDDAT		= 0x0160,
+	LCD_SPU_IOPAD_IN		= 0x0178,
+	LCD_CFG_RDREG5F			= 0x017c,
+	LCD_SPU_SPI_CTRL		= 0x0180,
+	LCD_SPU_SPI_TXDATA		= 0x0184,
+	LCD_SPU_SMPN_CTRL		= 0x0188,
+	LCD_SPU_DMA_CTRL0		= 0x0190,
+	LCD_SPU_DMA_CTRL1		= 0x0194,
+	LCD_SPU_SRAM_CTRL		= 0x0198,
+	LCD_SPU_SRAM_WRDAT		= 0x019c,
+	LCD_SPU_SRAM_PARA0		= 0x01a0,	/* Armada 510 */
+	LCD_SPU_SRAM_PARA1		= 0x01a4,
+	LCD_CFG_SCLK_DIV		= 0x01a8,
+	LCD_SPU_CONTRAST		= 0x01ac,
+	LCD_SPU_SATURATION		= 0x01b0,
+	LCD_SPU_CBSH_HUE		= 0x01b4,
+	LCD_SPU_DUMB_CTRL		= 0x01b8,
+	LCD_SPU_IOPAD_CONTROL		= 0x01bc,
+	LCD_SPU_IRQ_ENA			= 0x01c0,
+	LCD_SPU_IRQ_ISR			= 0x01c4,
+};
+
+/* For LCD_SPU_ADV_REG */
+enum {
+	ADV_VSYNC_L_OFF	= 0xfff << 20,
+	ADV_GRACOLORKEY	= 1 << 19,
+	ADV_VIDCOLORKEY	= 1 << 18,
+	ADV_HWC32BLEND	= 1 << 15,
+	ADV_HWC32ARGB	= 1 << 14,
+	ADV_HWC32ENABLE	= 1 << 13,
+	ADV_VSYNCOFFEN	= 1 << 12,
+	ADV_VSYNC_H_OFF	= 0xfff << 0,
+};
+
+enum {
+	CFG_565		= 0,
+	CFG_1555	= 1,
+	CFG_888PACK	= 2,
+	CFG_X888	= 3,
+	CFG_8888	= 4,
+	CFG_422PACK	= 5,
+	CFG_422		= 6,
+	CFG_420		= 7,
+	CFG_PSEUDO4	= 9,
+	CFG_PSEUDO8	= 10,
+	CFG_SWAPRB	= 1 << 4,
+	CFG_SWAPUV	= 1 << 3,
+	CFG_SWAPYU	= 1 << 2,
+	CFG_YUV2RGB	= 1 << 1,
+};
+
+/* For LCD_SPU_DMA_CTRL0 */
+enum {
+	CFG_NOBLENDING	= 1 << 31,
+	CFG_GAMMA_ENA	= 1 << 30,
+	CFG_CBSH_ENA	= 1 << 29,
+	CFG_PALETTE_ENA	= 1 << 28,
+	CFG_ARBFAST_ENA	= 1 << 27,
+	CFG_HWC_1BITMOD	= 1 << 26,
+	CFG_HWC_1BITENA	= 1 << 25,
+	CFG_HWC_ENA	= 1 << 24,
+	CFG_DMAFORMAT	= 0xf << 20,
+#define	CFG_DMA_FMT(x)	((x) << 20)
+	CFG_GRAFORMAT	= 0xf << 16,
+#define	CFG_GRA_FMT(x)	((x) << 16)
+#define CFG_GRA_MOD(x)	((x) << 8)
+	CFG_GRA_FTOGGLE	= 1 << 15,
+	CFG_GRA_HSMOOTH	= 1 << 14,
+	CFG_GRA_TSTMODE	= 1 << 13,
+	CFG_GRA_ENA	= 1 << 8,
+#define CFG_DMA_MOD(x)	((x) << 0)
+	CFG_DMA_FTOGGLE	= 1 << 7,
+	CFG_DMA_HSMOOTH	= 1 << 6,
+	CFG_DMA_TSTMODE	= 1 << 5,
+	CFG_DMA_ENA	= 1 << 0,
+};
+
+enum {
+	CKMODE_DISABLE	= 0,
+	CKMODE_Y	= 1,
+	CKMODE_U	= 2,
+	CKMODE_RGB	= 3,
+	CKMODE_V	= 4,
+	CKMODE_R	= 5,
+	CKMODE_G	= 6,
+	CKMODE_B	= 7,
+};
+
+/* For LCD_SPU_DMA_CTRL1 */
+enum {
+	CFG_FRAME_TRIG		= 1 << 31,
+	CFG_VSYNC_INV		= 1 << 27,
+	CFG_CKMODE_MASK		= 0x7 << 24,
+#define CFG_CKMODE(x)		((x) << 24)
+	CFG_CARRY		= 1 << 23,
+	CFG_GATED_CLK		= 1 << 21,
+	CFG_PWRDN_ENA		= 1 << 20,
+	CFG_DSCALE_MASK		= 0x3 << 18,
+	CFG_DSCALE_NONE		= 0x0 << 18,
+	CFG_DSCALE_HALF		= 0x1 << 18,
+	CFG_DSCALE_QUAR		= 0x2 << 18,
+	CFG_ALPHAM_MASK		= 0x3 << 16,
+	CFG_ALPHAM_VIDEO	= 0x0 << 16,
+	CFG_ALPHAM_GRA		= 0x1 << 16,
+	CFG_ALPHAM_CFG		= 0x2 << 16,
+	CFG_ALPHA_MASK		= 0xff << 8,
+	CFG_PIXCMD_MASK		= 0xff,
+};
+
+/* For LCD_SPU_SRAM_CTRL */
+enum {
+	SRAM_READ	= 0 << 14,
+	SRAM_WRITE	= 2 << 14,
+	SRAM_INIT	= 3 << 14,
+	SRAM_HWC32_RAMR	= 0xc << 8,
+	SRAM_HWC32_RAMG	= 0xd << 8,
+	SRAM_HWC32_RAMB	= 0xe << 8,
+	SRAM_HWC32_TRAN	= 0xf << 8,
+	SRAM_HWC	= 0xf << 8,
+};
+
+/* For LCD_SPU_SRAM_PARA1 */
+enum {
+	CFG_CSB_256x32	= 1 << 15,	/* cursor */
+	CFG_CSB_256x24	= 1 << 14,	/* palette */
+	CFG_CSB_256x8	= 1 << 13,	/* gamma */
+	CFG_PDWN1920x32	= 1 << 8,	/* Armada 510: power down vscale ram */
+	CFG_PDWN256x32	= 1 << 7,	/* power down cursor */
+	CFG_PDWN256x24	= 1 << 6,	/* power down palette */
+	CFG_PDWN256x8	= 1 << 5,	/* power down gamma */
+	CFG_PDWNHWC	= 1 << 4,	/* Armada 510: power down all hwc ram */
+	CFG_PDWN32x32	= 1 << 3,	/* power down slave->smart ram */
+	CFG_PDWN16x66	= 1 << 2,	/* power down UV fifo */
+	CFG_PDWN32x66	= 1 << 1,	/* power down Y fifo */
+	CFG_PDWN64x66	= 1 << 0,	/* power down graphic fifo */
+};
+
+/* For LCD_CFG_SCLK_DIV */
+enum {
+	/* Armada 510 */
+	SCLK_510_AXI		= 0x0 << 30,
+	SCLK_510_EXTCLK0	= 0x1 << 30,
+	SCLK_510_PLL		= 0x2 << 30,
+	SCLK_510_EXTCLK1	= 0x3 << 30,
+	SCLK_510_DIV_CHANGE	= 1 << 29,
+	SCLK_510_FRAC_DIV_MASK	= 0xfff << 16,
+	SCLK_510_INT_DIV_MASK	= 0xffff << 0,
+
+	/* Armada 16x */
+	SCLK_16X_AHB		= 0x0 << 28,
+	SCLK_16X_PCLK		= 0x1 << 28,
+	SCLK_16X_AXI		= 0x4 << 28,
+	SCLK_16X_PLL		= 0x8 << 28,
+	SCLK_16X_FRAC_DIV_MASK	= 0xfff << 16,
+	SCLK_16X_INT_DIV_MASK	= 0xffff << 0,
+};
+
+/* For LCD_SPU_DUMB_CTRL */
+enum {
+	DUMB16_RGB565_0	= 0x0 << 28,
+	DUMB16_RGB565_1	= 0x1 << 28,
+	DUMB18_RGB666_0	= 0x2 << 28,
+	DUMB18_RGB666_1	= 0x3 << 28,
+	DUMB12_RGB444_0	= 0x4 << 28,
+	DUMB12_RGB444_1	= 0x5 << 28,
+	DUMB24_RGB888_0	= 0x6 << 28,
+	DUMB_BLANK	= 0x7 << 28,
+	DUMB_MASK	= 0xf << 28,
+	CFG_BIAS_OUT	= 1 << 8,
+	CFG_REV_RGB	= 1 << 7,
+	CFG_INV_CBLANK	= 1 << 6,
+	CFG_INV_CSYNC	= 1 << 5,	/* Normally active high */
+	CFG_INV_HENA	= 1 << 4,
+	CFG_INV_VSYNC	= 1 << 3,	/* Normally active high */
+	CFG_INV_HSYNC	= 1 << 2,	/* Normally active high */
+	CFG_INV_PCLK	= 1 << 1,
+	CFG_DUMB_ENA	= 1 << 0,
+};
+
+/* For LCD_SPU_IOPAD_CONTROL */
+enum {
+	CFG_VSCALE_LN_EN	= 3 << 18,
+	CFG_GRA_VM_ENA		= 1 << 15,
+	CFG_DMA_VM_ENA		= 1 << 13,
+	CFG_CMD_VM_ENA		= 1 << 11,
+	CFG_CSC_MASK		= 3 << 8,
+	CFG_CSC_YUV_CCIR709	= 1 << 9,
+	CFG_CSC_YUV_CCIR601	= 0 << 9,
+	CFG_CSC_RGB_STUDIO	= 1 << 8,
+	CFG_CSC_RGB_COMPUTER	= 0 << 8,
+	CFG_IOPAD_MASK		= 0xf << 0,
+	CFG_IOPAD_DUMB24	= 0x0 << 0,
+	CFG_IOPAD_DUMB18SPI	= 0x1 << 0,
+	CFG_IOPAD_DUMB18GPIO	= 0x2 << 0,
+	CFG_IOPAD_DUMB16SPI	= 0x3 << 0,
+	CFG_IOPAD_DUMB16GPIO	= 0x4 << 0,
+	CFG_IOPAD_DUMB12GPIO	= 0x5 << 0,
+	CFG_IOPAD_SMART18	= 0x6 << 0,
+	CFG_IOPAD_SMART16	= 0x7 << 0,
+	CFG_IOPAD_SMART8	= 0x8 << 0,
+};
+
+#define IOPAD_DUMB24                0x0
+
+/* For LCD_SPU_IRQ_ENA */
+enum {
+	DMA_FRAME_IRQ0_ENA	= 1 << 31,
+	DMA_FRAME_IRQ1_ENA	= 1 << 30,
+	DMA_FRAME_IRQ_ENA	= DMA_FRAME_IRQ0_ENA | DMA_FRAME_IRQ1_ENA,
+	DMA_FF_UNDERFLOW_ENA	= 1 << 29,
+	GRA_FRAME_IRQ0_ENA	= 1 << 27,
+	GRA_FRAME_IRQ1_ENA	= 1 << 26,
+	GRA_FRAME_IRQ_ENA	= GRA_FRAME_IRQ0_ENA | GRA_FRAME_IRQ1_ENA,
+	GRA_FF_UNDERFLOW_ENA	= 1 << 25,
+	VSYNC_IRQ_ENA		= 1 << 23,
+	DUMB_FRAMEDONE_ENA	= 1 << 22,
+	TWC_FRAMEDONE_ENA	= 1 << 21,
+	HWC_FRAMEDONE_ENA	= 1 << 20,
+	SLV_IRQ_ENA		= 1 << 19,
+	SPI_IRQ_ENA		= 1 << 18,
+	PWRDN_IRQ_ENA		= 1 << 17,
+	ERR_IRQ_ENA		= 1 << 16,
+	CLEAN_SPU_IRQ_ISR	= 0xffff,
+};
+
+/* For LCD_SPU_IRQ_ISR */
+enum {
+	DMA_FRAME_IRQ0		= 1 << 31,
+	DMA_FRAME_IRQ1		= 1 << 30,
+	DMA_FRAME_IRQ		= DMA_FRAME_IRQ0 | DMA_FRAME_IRQ1,
+	DMA_FF_UNDERFLOW	= 1 << 29,
+	GRA_FRAME_IRQ0		= 1 << 27,
+	GRA_FRAME_IRQ1		= 1 << 26,
+	GRA_FRAME_IRQ		= GRA_FRAME_IRQ0 | GRA_FRAME_IRQ1,
+	GRA_FF_UNDERFLOW	= 1 << 25,
+	VSYNC_IRQ		= 1 << 23,
+	DUMB_FRAMEDONE		= 1 << 22,
+	TWC_FRAMEDONE		= 1 << 21,
+	HWC_FRAMEDONE		= 1 << 20,
+	SLV_IRQ			= 1 << 19,
+	SPI_IRQ			= 1 << 18,
+	PWRDN_IRQ		= 1 << 17,
+	ERR_IRQ			= 1 << 16,
+	DMA_FRAME_IRQ0_LEVEL	= 1 << 15,
+	DMA_FRAME_IRQ1_LEVEL	= 1 << 14,
+	DMA_FRAME_CNT_ISR	= 3 << 12,
+	GRA_FRAME_IRQ0_LEVEL	= 1 << 11,
+	GRA_FRAME_IRQ1_LEVEL	= 1 << 10,
+	GRA_FRAME_CNT_ISR	= 3 << 8,
+	VSYNC_IRQ_LEVEL		= 1 << 7,
+	DUMB_FRAMEDONE_LEVEL	= 1 << 6,
+	TWC_FRAMEDONE_LEVEL	= 1 << 5,
+	HWC_FRAMEDONE_LEVEL	= 1 << 4,
+	SLV_FF_EMPTY		= 1 << 3,
+	DMA_FF_ALLEMPTY		= 1 << 2,
+	GRA_FF_ALLEMPTY		= 1 << 1,
+	PWRDN_IRQ_LEVEL		= 1 << 0,
+};
+
+#endif
diff --git a/drivers/gpu/drm/armada/armada_ioctl.h b/drivers/gpu/drm/armada/armada_ioctl.h
new file mode 100644
index 0000000..8dec3fd
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_ioctl.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *  With inspiration from the i915 driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef DRM_ARMADA_IOCTL_H
+#define DRM_ARMADA_IOCTL_H
+
+#define DRM_ARMADA_GEM_CREATE		0x00
+#define DRM_ARMADA_GEM_MMAP		0x02
+#define DRM_ARMADA_GEM_PWRITE		0x03
+
+#define ARMADA_IOCTL(dir, name, str) \
+	DRM_##dir(DRM_COMMAND_BASE + DRM_ARMADA_##name, struct drm_armada_##str)
+
+struct drm_armada_gem_create {
+	uint32_t handle;
+	uint32_t size;
+};
+#define DRM_IOCTL_ARMADA_GEM_CREATE \
+	ARMADA_IOCTL(IOWR, GEM_CREATE, gem_create)
+
+struct drm_armada_gem_mmap {
+	uint32_t handle;
+	uint32_t pad;
+	uint64_t offset;
+	uint64_t size;
+	uint64_t addr;
+};
+#define DRM_IOCTL_ARMADA_GEM_MMAP \
+	ARMADA_IOCTL(IOWR, GEM_MMAP, gem_mmap)
+
+struct drm_armada_gem_pwrite {
+	uint64_t ptr;
+	uint32_t handle;
+	uint32_t offset;
+	uint32_t size;
+};
+#define DRM_IOCTL_ARMADA_GEM_PWRITE \
+	ARMADA_IOCTL(IOW, GEM_PWRITE, gem_pwrite)
+
+#endif
diff --git a/drivers/gpu/drm/armada/armada_ioctlP.h b/drivers/gpu/drm/armada/armada_ioctlP.h
new file mode 100644
index 0000000..bd8c456
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_ioctlP.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ARMADA_IOCTLP_H
+#define ARMADA_IOCTLP_H
+
+#define ARMADA_IOCTL_PROTO(name)\
+extern int armada_##name##_ioctl(struct drm_device *, void *, struct drm_file *)
+
+ARMADA_IOCTL_PROTO(gem_create);
+ARMADA_IOCTL_PROTO(gem_mmap);
+ARMADA_IOCTL_PROTO(gem_pwrite);
+
+#endif
diff --git a/drivers/gpu/drm/armada/armada_output.c b/drivers/gpu/drm/armada/armada_output.c
new file mode 100644
index 0000000..3b95f0c
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_output.c
@@ -0,0 +1,159 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_encoder_slave.h>
+#include "drm_helper.h"
+#include "armada_output.h"
+#include "armada_drm.h"
+
+struct armada_connector {
+	struct drm_connector conn;
+	const struct armada_output_type *type;
+};
+
+#define drm_to_armada_conn(c) container_of(c, struct armada_connector, conn)
+
+struct drm_encoder *armada_drm_connector_encoder(struct drm_connector *conn)
+{
+	struct drm_encoder *enc = conn->encoder;
+
+	return enc ? enc : drm_encoder_find(conn->dev, conn->encoder_ids[0]);
+}
+
+static enum drm_connector_status armada_drm_connector_detect(
+	struct drm_connector *conn, bool force)
+{
+	struct armada_connector *dconn = drm_to_armada_conn(conn);
+	enum drm_connector_status status = connector_status_disconnected;
+
+	if (dconn->type->detect) {
+		status = dconn->type->detect(conn, force);
+	} else {
+		struct drm_encoder *enc = armada_drm_connector_encoder(conn);
+
+		if (enc)
+			status = encoder_helper_funcs(enc)->detect(enc, conn);
+	}
+
+	return status;
+}
+
+static void armada_drm_connector_destroy(struct drm_connector *conn)
+{
+	struct armada_connector *dconn = drm_to_armada_conn(conn);
+
+	drm_sysfs_connector_remove(conn);
+	drm_connector_cleanup(conn);
+	kfree(dconn);
+}
+
+static int armada_drm_connector_set_property(struct drm_connector *conn,
+	struct drm_property *property, uint64_t value)
+{
+	struct armada_connector *dconn = drm_to_armada_conn(conn);
+
+	if (!dconn->type->set_property)
+		return -EINVAL;
+
+	return dconn->type->set_property(conn, property, value);
+}
+
+static const struct drm_connector_funcs armada_drm_conn_funcs = {
+	.dpms		= drm_helper_connector_dpms,
+	.fill_modes	= drm_helper_probe_single_connector_modes,
+	.detect		= armada_drm_connector_detect,
+	.destroy	= armada_drm_connector_destroy,
+	.set_property	= armada_drm_connector_set_property,
+};
+
+void armada_drm_encoder_prepare(struct drm_encoder *encoder)
+{
+	encoder_helper_funcs(encoder)->dpms(encoder, DRM_MODE_DPMS_OFF);
+}
+
+void armada_drm_encoder_commit(struct drm_encoder *encoder)
+{
+	encoder_helper_funcs(encoder)->dpms(encoder, DRM_MODE_DPMS_ON);
+}
+
+bool armada_drm_encoder_mode_fixup(struct drm_encoder *encoder,
+	const struct drm_display_mode *mode, struct drm_display_mode *adjusted)
+{
+	return true;
+}
+
+/* Shouldn't this be a generic helper function? */
+int armada_drm_slave_encoder_mode_valid(struct drm_connector *conn,
+	struct drm_display_mode *mode)
+{
+	struct drm_encoder *encoder = armada_drm_connector_encoder(conn);
+	int valid = MODE_BAD;
+
+	if (encoder) {
+		struct drm_encoder_slave *slave = to_encoder_slave(encoder);
+
+		valid = slave->slave_funcs->mode_valid(encoder, mode);
+	}
+	return valid;
+}
+
+int armada_drm_slave_encoder_set_property(struct drm_connector *conn,
+	struct drm_property *property, uint64_t value)
+{
+	struct drm_encoder *encoder = armada_drm_connector_encoder(conn);
+	int rc = -EINVAL;
+
+	if (encoder) {
+		struct drm_encoder_slave *slave = to_encoder_slave(encoder);
+
+		rc = slave->slave_funcs->set_property(encoder, conn, property,
+						      value);
+	}
+	return rc;
+}
+
+int armada_output_create(struct drm_device *dev,
+	const struct armada_output_type *type, const void *data)
+{
+	struct armada_connector *dconn;
+	int ret;
+
+	dconn = kzalloc(sizeof(*dconn), GFP_KERNEL);
+	if (!dconn)
+		return -ENOMEM;
+
+	dconn->type = type;
+
+	ret = drm_connector_init(dev, &dconn->conn, &armada_drm_conn_funcs,
+				 type->connector_type);
+	if (ret) {
+		DRM_ERROR("unable to init connector\n");
+		goto err_destroy_dconn;
+	}
+
+	ret = type->create(&dconn->conn, data);
+	if (ret)
+		goto err_conn;
+
+	ret = drm_sysfs_connector_add(&dconn->conn);
+	if (ret)
+		goto err_sysfs;
+
+	return 0;
+
+ err_sysfs:
+	if (dconn->conn.encoder)
+		dconn->conn.encoder->funcs->destroy(dconn->conn.encoder);
+ err_conn:
+	drm_connector_cleanup(&dconn->conn);
+ err_destroy_dconn:
+	kfree(dconn);
+	return ret;
+}
diff --git a/drivers/gpu/drm/armada/armada_output.h b/drivers/gpu/drm/armada/armada_output.h
new file mode 100644
index 0000000..4126d43
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_output.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ARMADA_CONNETOR_H
+#define ARMADA_CONNETOR_H
+
+#define encoder_helper_funcs(encoder) \
+	((struct drm_encoder_helper_funcs *)encoder->helper_private)
+
+struct armada_output_type {
+	int connector_type;
+	enum drm_connector_status (*detect)(struct drm_connector *, bool);
+	int (*create)(struct drm_connector *, const void *);
+	int (*set_property)(struct drm_connector *, struct drm_property *,
+			    uint64_t);
+};
+
+struct drm_encoder *armada_drm_connector_encoder(struct drm_connector *conn);
+
+void armada_drm_encoder_prepare(struct drm_encoder *encoder);
+void armada_drm_encoder_commit(struct drm_encoder *encoder);
+
+bool armada_drm_encoder_mode_fixup(struct drm_encoder *encoder,
+	const struct drm_display_mode *mode, struct drm_display_mode *adj);
+
+int armada_drm_slave_encoder_mode_valid(struct drm_connector *conn,
+	struct drm_display_mode *mode);
+
+int armada_drm_slave_encoder_set_property(struct drm_connector *conn,
+	struct drm_property *property, uint64_t value);
+
+int armada_output_create(struct drm_device *dev,
+	const struct armada_output_type *type, const void *data);
+
+#endif
diff --git a/drivers/gpu/drm/armada/armada_overlay.c b/drivers/gpu/drm/armada/armada_overlay.c
new file mode 100644
index 0000000..4f0ead9
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_overlay.c
@@ -0,0 +1,478 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *  Rewritten from the dovefb driver, and Armada510 manuals.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <drm/drmP.h>
+#include "drm_helper.h"
+#include "armada_crtc.h"
+#include "armada_drm.h"
+#include "armada_fb.h"
+#include "armada_gem.h"
+#include "armada_hw.h"
+#include "armada_ioctl.h"
+#include "armada_ioctlP.h"
+
+struct armada_plane_properties {
+	uint32_t colorkey_yr;
+	uint32_t colorkey_ug;
+	uint32_t colorkey_vb;
+#define K2R(val) (((val) >> 0) & 0xff)
+#define K2G(val) (((val) >> 8) & 0xff)
+#define K2B(val) (((val) >> 16) & 0xff)
+	int16_t  brightness;
+	uint16_t contrast;
+	uint16_t saturation;
+	uint32_t colorkey_mode;
+};
+
+struct armada_plane {
+	struct drm_plane base;
+	spinlock_t lock;
+	struct drm_framebuffer *old_fb;
+	uint32_t src_hw;
+	uint32_t dst_hw;
+	uint32_t dst_yx;
+	uint32_t ctrl0;
+	struct {
+		struct armada_vbl_event update;
+		struct armada_regs regs[13];
+		wait_queue_head_t wait;
+	} vbl;
+	struct armada_plane_properties prop;
+};
+#define drm_to_armada_plane(p) container_of(p, struct armada_plane, base)
+
+
+static void
+armada_ovl_update_attr(struct armada_plane_properties *prop,
+	struct armada_crtc *dcrtc)
+{
+	writel_relaxed(prop->colorkey_yr, dcrtc->base + LCD_SPU_COLORKEY_Y);
+	writel_relaxed(prop->colorkey_ug, dcrtc->base + LCD_SPU_COLORKEY_U);
+	writel_relaxed(prop->colorkey_vb, dcrtc->base + LCD_SPU_COLORKEY_V);
+
+	writel_relaxed(prop->brightness << 16 | prop->contrast,
+		       dcrtc->base + LCD_SPU_CONTRAST);
+	/* Docs say 15:0, but it seems to actually be 31:16 on Armada 510 */
+	writel_relaxed(prop->saturation << 16,
+		       dcrtc->base + LCD_SPU_SATURATION);
+	writel_relaxed(0x00002000, dcrtc->base + LCD_SPU_CBSH_HUE);
+
+	spin_lock_irq(&dcrtc->irq_lock);
+	armada_updatel(prop->colorkey_mode | CFG_ALPHAM_GRA,
+		     CFG_CKMODE_MASK | CFG_ALPHAM_MASK | CFG_ALPHA_MASK,
+		     dcrtc->base + LCD_SPU_DMA_CTRL1);
+
+	armada_updatel(ADV_GRACOLORKEY, 0, dcrtc->base + LCD_SPU_ADV_REG);
+	spin_unlock_irq(&dcrtc->irq_lock);
+}
+
+/* === Plane support === */
+static void armada_plane_vbl(struct armada_crtc *dcrtc, void *data)
+{
+	struct armada_plane *dplane = data;
+	struct drm_framebuffer *fb;
+
+	armada_drm_crtc_update_regs(dcrtc, dplane->vbl.regs);
+
+	spin_lock(&dplane->lock);
+	fb = dplane->old_fb;
+	dplane->old_fb = NULL;
+	spin_unlock(&dplane->lock);
+
+	if (fb)
+		armada_drm_queue_unref_work(dcrtc->crtc.dev, fb);
+}
+
+static unsigned armada_limit(int start, unsigned size, unsigned max)
+{
+	int end = start + size;
+	if (end < 0)
+		return 0;
+	if (start < 0)
+		start = 0;
+	return (unsigned)end > max ? max - start : end - start;
+}
+
+static int
+armada_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
+	struct drm_framebuffer *fb,
+	int crtc_x, int crtc_y, unsigned crtc_w, unsigned crtc_h,
+	uint32_t src_x, uint32_t src_y, uint32_t src_w, uint32_t src_h)
+{
+	struct armada_plane *dplane = drm_to_armada_plane(plane);
+	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
+	uint32_t val, ctrl0;
+	unsigned idx = 0;
+	int ret;
+
+	crtc_w = armada_limit(crtc_x, crtc_w, dcrtc->crtc.mode.hdisplay);
+	crtc_h = armada_limit(crtc_y, crtc_h, dcrtc->crtc.mode.vdisplay);
+	ctrl0 = CFG_DMA_FMT(drm_fb_to_armada_fb(fb)->fmt) |
+		CFG_DMA_MOD(drm_fb_to_armada_fb(fb)->mod) |
+		CFG_CBSH_ENA | CFG_DMA_HSMOOTH | CFG_DMA_ENA;
+
+	/* Does the position/size result in nothing to display? */
+	if (crtc_w == 0 || crtc_h == 0) {
+		ctrl0 &= ~CFG_DMA_ENA;
+	}
+
+	/*
+	 * FIXME: if the starting point is off screen, we need to
+	 * adjust src_x, src_y, src_w, src_h appropriately, and
+	 * according to the scale.
+	 */
+
+	if (!dcrtc->plane) {
+		dcrtc->plane = plane;
+		armada_ovl_update_attr(&dplane->prop, dcrtc);
+	}
+
+	/* FIXME: overlay on an interlaced display */
+	/* Just updating the position/size? */
+	if (plane->fb == fb && dplane->ctrl0 == ctrl0) {
+		val = (src_h & 0xffff0000) | src_w >> 16;
+		dplane->src_hw = val;
+		writel_relaxed(val, dcrtc->base + LCD_SPU_DMA_HPXL_VLN);
+		val = crtc_h << 16 | crtc_w;
+		dplane->dst_hw = val;
+		writel_relaxed(val, dcrtc->base + LCD_SPU_DZM_HPXL_VLN);
+		val = crtc_y << 16 | crtc_x;
+		dplane->dst_yx = val;
+		writel_relaxed(val, dcrtc->base + LCD_SPU_DMA_OVSA_HPXL_VLN);
+		return 0;
+	} else if (~dplane->ctrl0 & ctrl0 & CFG_DMA_ENA) {
+		/* Power up the Y/U/V FIFOs on ENA 0->1 transitions */
+		armada_updatel(0, CFG_PDWN16x66 | CFG_PDWN32x66,
+			       dcrtc->base + LCD_SPU_SRAM_PARA1);
+	}
+
+	ret = wait_event_timeout(dplane->vbl.wait,
+				 list_empty(&dplane->vbl.update.node),
+				 HZ/25);
+	if (ret < 0)
+		return ret;
+
+	if (plane->fb != fb) {
+		struct armada_gem_object *obj = drm_fb_obj(fb);
+		uint32_t sy, su, sv;
+
+		/*
+		 * Take a reference on the new framebuffer - we want to
+		 * hold on to it while the hardware is displaying it.
+		 */
+		drm_framebuffer_reference(fb);
+
+		if (plane->fb) {
+			struct drm_framebuffer *older_fb;
+
+			spin_lock_irq(&dplane->lock);
+			older_fb = dplane->old_fb;
+			dplane->old_fb = plane->fb;
+			spin_unlock_irq(&dplane->lock);
+			if (older_fb)
+				armada_drm_queue_unref_work(dcrtc->crtc.dev,
+							    older_fb);
+		}
+
+		src_y >>= 16;
+		src_x >>= 16;
+		sy = obj->dev_addr + fb->offsets[0] + src_y * fb->pitches[0] +
+			src_x * fb->bits_per_pixel / 8;
+		su = obj->dev_addr + fb->offsets[1] + src_y * fb->pitches[1] +
+			src_x;
+		sv = obj->dev_addr + fb->offsets[2] + src_y * fb->pitches[2] +
+			src_x;
+
+		armada_reg_queue_set(dplane->vbl.regs, idx, sy,
+				     LCD_SPU_DMA_START_ADDR_Y0);
+		armada_reg_queue_set(dplane->vbl.regs, idx, su,
+				     LCD_SPU_DMA_START_ADDR_U0);
+		armada_reg_queue_set(dplane->vbl.regs, idx, sv,
+				     LCD_SPU_DMA_START_ADDR_V0);
+		armada_reg_queue_set(dplane->vbl.regs, idx, sy,
+				     LCD_SPU_DMA_START_ADDR_Y1);
+		armada_reg_queue_set(dplane->vbl.regs, idx, su,
+				     LCD_SPU_DMA_START_ADDR_U1);
+		armada_reg_queue_set(dplane->vbl.regs, idx, sv,
+				     LCD_SPU_DMA_START_ADDR_V1);
+
+		val = fb->pitches[0] << 16 | fb->pitches[0];
+		armada_reg_queue_set(dplane->vbl.regs, idx, val,
+				     LCD_SPU_DMA_PITCH_YC);
+		val = fb->pitches[1] << 16 | fb->pitches[2];
+		armada_reg_queue_set(dplane->vbl.regs, idx, val,
+				     LCD_SPU_DMA_PITCH_UV);
+	}
+
+	val = (src_h & 0xffff0000) | src_w >> 16;
+	if (dplane->src_hw != val) {
+		dplane->src_hw = val;
+		armada_reg_queue_set(dplane->vbl.regs, idx, val,
+				     LCD_SPU_DMA_HPXL_VLN);
+	}
+	val = crtc_h << 16 | crtc_w;
+	if (dplane->dst_hw != val) {
+		dplane->dst_hw = val;
+		armada_reg_queue_set(dplane->vbl.regs, idx, val,
+				     LCD_SPU_DZM_HPXL_VLN);
+	}
+	val = crtc_y << 16 | crtc_x;
+	if (dplane->dst_yx != val) {
+		dplane->dst_yx = val;
+		armada_reg_queue_set(dplane->vbl.regs, idx, val,
+				     LCD_SPU_DMA_OVSA_HPXL_VLN);
+	}
+	if (dplane->ctrl0 != ctrl0) {
+		dplane->ctrl0 = ctrl0;
+		armada_reg_queue_mod(dplane->vbl.regs, idx, ctrl0,
+			CFG_CBSH_ENA | CFG_DMAFORMAT | CFG_DMA_FTOGGLE |
+			CFG_DMA_HSMOOTH | CFG_DMA_TSTMODE |
+			CFG_DMA_MOD(CFG_SWAPRB | CFG_SWAPUV | CFG_SWAPYU |
+			CFG_YUV2RGB) | CFG_DMA_ENA,
+			LCD_SPU_DMA_CTRL0);
+	}
+	if (idx) {
+		armada_reg_queue_end(dplane->vbl.regs, idx);
+		armada_drm_vbl_event_add(dcrtc, &dplane->vbl.update);
+	}
+	return 0;
+}
+
+static int armada_plane_disable(struct drm_plane *plane)
+{
+	struct armada_plane *dplane = drm_to_armada_plane(plane);
+	struct drm_framebuffer *fb;
+	struct armada_crtc *dcrtc;
+
+	if (!dplane->base.crtc)
+		return 0;
+
+	dcrtc = drm_to_armada_crtc(dplane->base.crtc);
+	dcrtc->plane = NULL;
+
+	spin_lock_irq(&dcrtc->irq_lock);
+	armada_drm_vbl_event_remove(dcrtc, &dplane->vbl.update);
+	armada_updatel(0, CFG_DMA_ENA, dcrtc->base + LCD_SPU_DMA_CTRL0);
+	dplane->ctrl0 = 0;
+	spin_unlock_irq(&dcrtc->irq_lock);
+
+	/* Power down the Y/U/V FIFOs */
+	armada_updatel(CFG_PDWN16x66 | CFG_PDWN32x66, 0,
+		       dcrtc->base + LCD_SPU_SRAM_PARA1);
+
+	if (plane->fb)
+		drm_framebuffer_unreference(plane->fb);
+
+	spin_lock_irq(&dplane->lock);
+	fb = dplane->old_fb;
+	dplane->old_fb = NULL;
+	spin_unlock_irq(&dplane->lock);
+	if (fb)
+		drm_framebuffer_unreference(fb);
+
+	return 0;
+}
+
+static void armada_plane_destroy(struct drm_plane *plane)
+{
+	kfree(plane);
+}
+
+static int armada_plane_set_property(struct drm_plane *plane,
+	struct drm_property *property, uint64_t val)
+{
+	struct armada_private *priv = plane->dev->dev_private;
+	struct armada_plane *dplane = drm_to_armada_plane(plane);
+	bool update_attr = false;
+
+	if (property == priv->colorkey_prop) {
+#define CCC(v) ((v) << 24 | (v) << 16 | (v) << 8)
+		dplane->prop.colorkey_yr = CCC(K2R(val));
+		dplane->prop.colorkey_ug = CCC(K2G(val));
+		dplane->prop.colorkey_vb = CCC(K2B(val));
+#undef CCC
+		update_attr = true;
+	} else if (property == priv->colorkey_min_prop) {
+		dplane->prop.colorkey_yr &= ~0x00ff0000;
+		dplane->prop.colorkey_yr |= K2R(val) << 16;
+		dplane->prop.colorkey_ug &= ~0x00ff0000;
+		dplane->prop.colorkey_ug |= K2G(val) << 16;
+		dplane->prop.colorkey_vb &= ~0x00ff0000;
+		dplane->prop.colorkey_vb |= K2B(val) << 16;
+		update_attr = true;
+	} else if (property == priv->colorkey_max_prop) {
+		dplane->prop.colorkey_yr &= ~0xff000000;
+		dplane->prop.colorkey_yr |= K2R(val) << 24;
+		dplane->prop.colorkey_ug &= ~0xff000000;
+		dplane->prop.colorkey_ug |= K2G(val) << 24;
+		dplane->prop.colorkey_vb &= ~0xff000000;
+		dplane->prop.colorkey_vb |= K2B(val) << 24;
+		update_attr = true;
+	} else if (property == priv->colorkey_val_prop) {
+		dplane->prop.colorkey_yr &= ~0x0000ff00;
+		dplane->prop.colorkey_yr |= K2R(val) << 8;
+		dplane->prop.colorkey_ug &= ~0x0000ff00;
+		dplane->prop.colorkey_ug |= K2G(val) << 8;
+		dplane->prop.colorkey_vb &= ~0x0000ff00;
+		dplane->prop.colorkey_vb |= K2B(val) << 8;
+		update_attr = true;
+	} else if (property == priv->colorkey_alpha_prop) {
+		dplane->prop.colorkey_yr &= ~0x000000ff;
+		dplane->prop.colorkey_yr |= K2R(val);
+		dplane->prop.colorkey_ug &= ~0x000000ff;
+		dplane->prop.colorkey_ug |= K2G(val);
+		dplane->prop.colorkey_vb &= ~0x000000ff;
+		dplane->prop.colorkey_vb |= K2B(val);
+		update_attr = true;
+	} else if (property == priv->colorkey_mode_prop) {
+		dplane->prop.colorkey_mode &= ~CFG_CKMODE_MASK;
+		dplane->prop.colorkey_mode |= CFG_CKMODE(val);
+		update_attr = true;
+	} else if (property == priv->brightness_prop) {
+		dplane->prop.brightness = val - 256;
+		update_attr = true;
+	} else if (property == priv->contrast_prop) {
+		dplane->prop.contrast = val;
+		update_attr = true;
+	} else if (property == priv->saturation_prop) {
+		dplane->prop.saturation = val;
+		update_attr = true;
+	}
+
+	if (update_attr && dplane->base.crtc)
+		armada_ovl_update_attr(&dplane->prop,
+				       drm_to_armada_crtc(dplane->base.crtc));
+
+	return 0;
+}
+
+static const struct drm_plane_funcs armada_plane_funcs = {
+	.update_plane	= armada_plane_update,
+	.disable_plane	= armada_plane_disable,
+	.destroy	= armada_plane_destroy,
+	.set_property	= armada_plane_set_property,
+};
+
+static const uint32_t armada_formats[] = {
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YUV420,
+	DRM_FORMAT_YVU420,
+	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YVU422,
+	DRM_FORMAT_VYUY,
+	DRM_FORMAT_YVYU,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
+};
+
+static struct drm_prop_enum_list armada_drm_colorkey_enum_list[] = {
+	{ CKMODE_DISABLE, "disabled" },
+	{ CKMODE_Y,       "Y component" },
+	{ CKMODE_U,       "U component" },
+	{ CKMODE_V,       "V component" },
+	{ CKMODE_RGB,     "RGB" },
+	{ CKMODE_R,       "R component" },
+	{ CKMODE_G,       "G component" },
+	{ CKMODE_B,       "B component" },
+};
+
+static int armada_overlay_create_properties(struct drm_device *dev)
+{
+	struct armada_private *priv = dev->dev_private;
+
+	if (priv->colorkey_prop)
+		return 0;
+
+	priv->colorkey_prop = drm_property_create_range(dev, 0,
+				"colorkey", 0, 0xffffff);
+	priv->colorkey_min_prop = drm_property_create_range(dev, 0,
+				"colorkey_min", 0, 0xffffff);
+	priv->colorkey_max_prop = drm_property_create_range(dev, 0,
+				"colorkey_max", 0, 0xffffff);
+	priv->colorkey_val_prop = drm_property_create_range(dev, 0,
+				"colorkey_val", 0, 0xffffff);
+	priv->colorkey_alpha_prop = drm_property_create_range(dev, 0,
+				"colorkey_alpha", 0, 0xffffff);
+	priv->colorkey_mode_prop = drm_property_create_enum(dev, 0,
+				"colorkey_mode",
+				armada_drm_colorkey_enum_list,
+				ARRAY_SIZE(armada_drm_colorkey_enum_list));
+	priv->brightness_prop = drm_property_create_range(dev, 0,
+				"brightness", 0, 256 + 255);
+	priv->contrast_prop = drm_property_create_range(dev, 0,
+				"contrast", 0, 0x7fff);
+	priv->saturation_prop = drm_property_create_range(dev, 0,
+				"saturation", 0, 0x7fff);
+
+	if (!priv->colorkey_prop)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int armada_overlay_plane_create(struct drm_device *dev, unsigned long crtcs)
+{
+	struct armada_private *priv = dev->dev_private;
+	struct drm_mode_object *mobj;
+	struct armada_plane *dplane;
+	int ret;
+
+	ret = armada_overlay_create_properties(dev);
+	if (ret)
+		return ret;
+
+	dplane = kzalloc(sizeof(*dplane), GFP_KERNEL);
+	if (!dplane)
+		return -ENOMEM;
+
+	spin_lock_init(&dplane->lock);
+	init_waitqueue_head(&dplane->vbl.wait);
+	armada_drm_vbl_event_init(&dplane->vbl.update, armada_plane_vbl,
+				  dplane);
+
+	drm_plane_init(dev, &dplane->base, crtcs, &armada_plane_funcs,
+		       armada_formats, ARRAY_SIZE(armada_formats), false);
+
+	dplane->prop.colorkey_yr = 0xfefefe00;
+	dplane->prop.colorkey_ug = 0x01010100;
+	dplane->prop.colorkey_vb = 0x01010100;
+	dplane->prop.colorkey_mode = CFG_CKMODE(CKMODE_RGB);
+	dplane->prop.brightness = 0;
+	dplane->prop.contrast = 0x4000;
+	dplane->prop.saturation = 0x4000;
+
+	mobj = &dplane->base.base;
+	drm_object_attach_property(mobj, priv->colorkey_prop,
+				   0x0101fe);
+	drm_object_attach_property(mobj, priv->colorkey_min_prop,
+				   0x0101fe);
+	drm_object_attach_property(mobj, priv->colorkey_max_prop,
+				   0x0101fe);
+	drm_object_attach_property(mobj, priv->colorkey_val_prop,
+				   0x0101fe);
+	drm_object_attach_property(mobj, priv->colorkey_alpha_prop,
+				   0x000000);
+	drm_object_attach_property(mobj, priv->colorkey_mode_prop,
+				   CKMODE_RGB);
+	drm_object_attach_property(mobj, priv->brightness_prop, 256);
+	drm_object_attach_property(mobj, priv->contrast_prop,
+				   dplane->prop.contrast);
+	drm_object_attach_property(mobj, priv->saturation_prop,
+				   dplane->prop.saturation);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/armada/armada_slave.c b/drivers/gpu/drm/armada/armada_slave.c
new file mode 100644
index 0000000..00d0fac
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_slave.c
@@ -0,0 +1,139 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *  Rewritten from the dovefb driver, and Armada510 manuals.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_encoder_slave.h>
+#include "armada_drm.h"
+#include "armada_output.h"
+#include "armada_slave.h"
+
+static int armada_drm_slave_get_modes(struct drm_connector *conn)
+{
+	struct drm_encoder *enc = armada_drm_connector_encoder(conn);
+	int count = 0;
+
+	if (enc) {
+		struct drm_encoder_slave *slave = to_encoder_slave(enc);
+
+		count = slave->slave_funcs->get_modes(enc, conn);
+	}
+
+	return count;
+}
+
+static void armada_drm_slave_destroy(struct drm_encoder *enc)
+{
+	struct drm_encoder_slave *slave = to_encoder_slave(enc);
+	struct i2c_client *client = drm_i2c_encoder_get_client(enc);
+
+	if (slave->slave_funcs)
+		slave->slave_funcs->destroy(enc);
+	if (client)
+		i2c_put_adapter(client->adapter);
+
+	drm_encoder_cleanup(&slave->base);
+	kfree(slave);
+}
+
+static const struct drm_encoder_funcs armada_drm_slave_encoder_funcs = {
+	.destroy	= armada_drm_slave_destroy,
+};
+
+static const struct drm_connector_helper_funcs armada_drm_slave_helper_funcs = {
+	.get_modes	= armada_drm_slave_get_modes,
+	.mode_valid	= armada_drm_slave_encoder_mode_valid,
+	.best_encoder	= armada_drm_connector_encoder,
+};
+
+static const struct drm_encoder_helper_funcs drm_slave_encoder_helpers = {
+	.dpms = drm_i2c_encoder_dpms,
+	.save = drm_i2c_encoder_save,
+	.restore = drm_i2c_encoder_restore,
+	.mode_fixup = drm_i2c_encoder_mode_fixup,
+	.prepare = drm_i2c_encoder_prepare,
+	.commit = drm_i2c_encoder_commit,
+	.mode_set = drm_i2c_encoder_mode_set,
+	.detect = drm_i2c_encoder_detect,
+};
+
+static int
+armada_drm_conn_slave_create(struct drm_connector *conn, const void *data)
+{
+	const struct armada_drm_slave_config *config = data;
+	struct drm_encoder_slave *slave;
+	struct i2c_adapter *adap;
+	int ret;
+
+	conn->interlace_allowed = config->interlace_allowed;
+	conn->doublescan_allowed = config->doublescan_allowed;
+	conn->polled = config->polled;
+
+	drm_connector_helper_add(conn, &armada_drm_slave_helper_funcs);
+
+	slave = kzalloc(sizeof(*slave), GFP_KERNEL);
+	if (!slave)
+		return -ENOMEM;
+
+	slave->base.possible_crtcs = config->crtcs;
+
+	adap = i2c_get_adapter(config->i2c_adapter_id);
+	if (!adap) {
+		kfree(slave);
+		return -EPROBE_DEFER;
+	}
+
+	ret = drm_encoder_init(conn->dev, &slave->base,
+			       &armada_drm_slave_encoder_funcs,
+			       DRM_MODE_ENCODER_TMDS);
+	if (ret) {
+		DRM_ERROR("unable to init encoder\n");
+		i2c_put_adapter(adap);
+		kfree(slave);
+		return ret;
+	}
+
+	ret = drm_i2c_encoder_init(conn->dev, slave, adap, &config->info);
+	i2c_put_adapter(adap);
+	if (ret) {
+		DRM_ERROR("unable to init encoder slave\n");
+		armada_drm_slave_destroy(&slave->base);
+		return ret;
+	}
+
+	drm_encoder_helper_add(&slave->base, &drm_slave_encoder_helpers);
+
+	ret = slave->slave_funcs->create_resources(&slave->base, conn);
+	if (ret) {
+		armada_drm_slave_destroy(&slave->base);
+		return ret;
+	}
+
+	ret = drm_mode_connector_attach_encoder(conn, &slave->base);
+	if (ret) {
+		armada_drm_slave_destroy(&slave->base);
+		return ret;
+	}
+
+	conn->encoder = &slave->base;
+
+	return ret;
+}
+
+static const struct armada_output_type armada_drm_conn_slave = {
+	.connector_type	= DRM_MODE_CONNECTOR_HDMIA,
+	.create		= armada_drm_conn_slave_create,
+	.set_property	= armada_drm_slave_encoder_set_property,
+};
+
+int armada_drm_connector_slave_create(struct drm_device *dev,
+	const struct armada_drm_slave_config *config)
+{
+	return armada_output_create(dev, &armada_drm_conn_slave, config);
+}
diff --git a/drivers/gpu/drm/armada/armada_slave.h b/drivers/gpu/drm/armada/armada_slave.h
new file mode 100644
index 0000000..bf2374c
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_slave.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ARMADA_SLAVE_H
+#define ARMADA_SLAVE_H
+
+#include <linux/i2c.h>
+#include <drm/drmP.h>
+
+struct armada_drm_slave_config {
+	int i2c_adapter_id;
+	uint32_t crtcs;
+	uint8_t polled;
+	bool interlace_allowed;
+	bool doublescan_allowed;
+	struct i2c_board_info info;
+};
+
+int armada_drm_connector_slave_create(struct drm_device *dev,
+	const struct armada_drm_slave_config *);
+
+#endif
diff --git a/drivers/gpu/drm/armada/drm_helper.h b/drivers/gpu/drm/armada/drm_helper.h
new file mode 100644
index 0000000..d9f2e8d
--- /dev/null
+++ b/drivers/gpu/drm/armada/drm_helper.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef DRM_HELPER_H
+#define DRM_HELPER_H
+
+/* Useful helpers I wish the DRM core would provide */
+
+#include <drm/drmP.h>
+
+static inline struct drm_crtc *drm_crtc_find(struct drm_device *dev,
+	uint32_t id)
+{
+	struct drm_mode_object *mo;
+	mo = drm_mode_object_find(dev, id, DRM_MODE_OBJECT_CRTC);
+	return mo ? obj_to_crtc(mo) : NULL;
+}
+
+static inline struct drm_encoder *drm_encoder_find(struct drm_device *dev,
+	uint32_t id)
+{
+	struct drm_mode_object *mo;
+	mo = drm_mode_object_find(dev, id, DRM_MODE_OBJECT_ENCODER);
+	return mo ? obj_to_encoder(mo) : NULL;
+}
+
+#endif
-- 
1.7.4.4
