From: eric@anholt.net (Eric Anholt)
Date: Wed, 12 Aug 2015 17:56:16 -0700
Subject: [PATCH 3/7] drm/vc4: Add KMS support for Raspberry Pi.
In-Reply-To: <1439427380-2436-1-git-send-email-eric@anholt.net>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
Message-ID: <1439427380-2436-4-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the start of a full VC4 driver.  Right now this just supports
configuring the display using a pre-existing video mode (because
changing the pixel clock isn't available yet, and doesn't work when it
is).  However, this is enough for fbcon and bringing up X using
xf86-video-modesetting.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/Kconfig           |   2 +
 drivers/gpu/drm/Makefile          |   1 +
 drivers/gpu/drm/vc4/Kconfig       |  14 +
 drivers/gpu/drm/vc4/Makefile      |  18 ++
 drivers/gpu/drm/vc4/vc4_bo.c      |  54 ++++
 drivers/gpu/drm/vc4/vc4_crtc.c    | 583 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_debugfs.c |  38 +++
 drivers/gpu/drm/vc4/vc4_drv.c     | 249 +++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.h     | 123 +++++++
 drivers/gpu/drm/vc4/vc4_hdmi.c    | 651 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_hvs.c     | 172 ++++++++++
 drivers/gpu/drm/vc4/vc4_kms.c     |  84 +++++
 drivers/gpu/drm/vc4/vc4_plane.c   | 320 +++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_regs.h    | 562 ++++++++++++++++++++++++++++++++
 14 files changed, 2871 insertions(+)
 create mode 100644 drivers/gpu/drm/vc4/Kconfig
 create mode 100644 drivers/gpu/drm/vc4/Makefile
 create mode 100644 drivers/gpu/drm/vc4/vc4_bo.c
 create mode 100644 drivers/gpu/drm/vc4/vc4_crtc.c
 create mode 100644 drivers/gpu/drm/vc4/vc4_debugfs.c
 create mode 100644 drivers/gpu/drm/vc4/vc4_drv.c
 create mode 100644 drivers/gpu/drm/vc4/vc4_drv.h
 create mode 100644 drivers/gpu/drm/vc4/vc4_hdmi.c
 create mode 100644 drivers/gpu/drm/vc4/vc4_hvs.c
 create mode 100644 drivers/gpu/drm/vc4/vc4_kms.c
 create mode 100644 drivers/gpu/drm/vc4/vc4_plane.c
 create mode 100644 drivers/gpu/drm/vc4/vc4_regs.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index c46ca31..1730a76 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -240,3 +240,5 @@ source "drivers/gpu/drm/sti/Kconfig"
 source "drivers/gpu/drm/amd/amdkfd/Kconfig"
 
 source "drivers/gpu/drm/imx/Kconfig"
+
+source "drivers/gpu/drm/vc4/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 5713d05..b991ac5 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_DRM_MGA)	+= mga/
 obj-$(CONFIG_DRM_I810)	+= i810/
 obj-$(CONFIG_DRM_I915)  += i915/
 obj-$(CONFIG_DRM_MGAG200) += mgag200/
+obj-$(CONFIG_DRM_VC4)  += vc4/
 obj-$(CONFIG_DRM_CIRRUS_QEMU) += cirrus/
 obj-$(CONFIG_DRM_SIS)   += sis/
 obj-$(CONFIG_DRM_SAVAGE)+= savage/
diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
new file mode 100644
index 0000000..130cc94
--- /dev/null
+++ b/drivers/gpu/drm/vc4/Kconfig
@@ -0,0 +1,14 @@
+config DRM_VC4
+	tristate "Broadcom VC4 Graphics"
+	depends on ARCH_BCM2835
+	depends on DRM
+	select DRM_KMS_HELPER
+	select DRM_KMS_FB_HELPER
+	select DRM_KMS_CMA_HELPER
+	help
+	  Choose this option if you have a system that has a Broadcom
+	  VC4 GPU, such as the Raspberry Pi or other BCM2708/BCM2835.
+
+	  This driver requires that "avoid_warnings=2" be present in
+	  the config.txt for the firmware, to keep it from smashing
+	  our display setup.
diff --git a/drivers/gpu/drm/vc4/Makefile b/drivers/gpu/drm/vc4/Makefile
new file mode 100644
index 0000000..4aa07ca
--- /dev/null
+++ b/drivers/gpu/drm/vc4/Makefile
@@ -0,0 +1,18 @@
+ccflags-y := -Iinclude/drm
+
+# Please keep these build lists sorted!
+
+# core driver code
+vc4-y := \
+	vc4_bo.o \
+	vc4_crtc.o \
+	vc4_drv.o \
+	vc4_kms.o \
+	vc4_hdmi.o \
+	vc4_hvs.o \
+	vc4_plane.o \
+	$()
+
+vc4-$(CONFIG_DEBUG_FS) += vc4_debugfs.o
+
+obj-$(CONFIG_DRM_VC4)  += vc4.o
diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
new file mode 100644
index 0000000..fee8cac
--- /dev/null
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -0,0 +1,54 @@
+/*
+ *  Copyright ? 2015 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* DOC: VC4 GEM BO management support.
+ *
+ * The VC4 GPU architecture (both scanout and rendering) has direct
+ * access to system memory with no MMU in between.  To support it, we
+ * use the GEM CMA helper functions to allocate contiguous ranges of
+ * physical memory for our BOs.
+ */
+
+#include "vc4_drv.h"
+
+struct vc4_bo *vc4_bo_create(struct drm_device *dev, size_t size)
+{
+	struct drm_gem_cma_object *cma_obj;
+
+	cma_obj = drm_gem_cma_create(dev, size);
+	if (IS_ERR(cma_obj))
+		return NULL;
+	else
+		return to_vc4_bo(&cma_obj->base);
+}
+
+int vc4_dumb_create(struct drm_file *file_priv,
+		    struct drm_device *dev,
+		    struct drm_mode_create_dumb *args)
+{
+	int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
+	struct vc4_bo *bo = NULL;
+	int ret;
+
+	if (args->pitch < min_pitch)
+		args->pitch = min_pitch;
+
+	if (args->size < args->pitch * args->height)
+		args->size = args->pitch * args->height;
+
+	mutex_lock(&dev->struct_mutex);
+	bo = vc4_bo_create(dev, roundup(args->size, PAGE_SIZE));
+	mutex_unlock(&dev->struct_mutex);
+	if (!bo)
+		return -ENOMEM;
+
+	ret = drm_gem_handle_create(file_priv, &bo->base.base, &args->handle);
+	drm_gem_object_unreference_unlocked(&bo->base.base);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
new file mode 100644
index 0000000..6f127f0
--- /dev/null
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -0,0 +1,583 @@
+/*
+ * Copyright (C) 2015 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/**
+ * DOC: VC4 CRTC module
+ *
+ * In VC4, the Pixel Valve is what most closely corresponds to the
+ * DRM's concept of a CRTC.  The PV generates video timings from the
+ * pixel clock and its configuration.
+ *
+ * However, the DRM CRTC also collects the configuration of all the
+ * DRM planes attached to it.  As a result, this file also manages
+ * setup of the VC4 HVS's display elements on the CRTC.
+ */
+
+#include "drm_atomic_helper.h"
+#include "drm_crtc_helper.h"
+#include "linux/clk.h"
+#include "linux/component.h"
+#include "vc4_drv.h"
+#include "vc4_regs.h"
+
+#define CRTC_WRITE(offset, val) writel(val, vc4_crtc->regs + (offset))
+#define CRTC_READ(offset) readl(vc4_crtc->regs + (offset))
+
+#define CRTC_REG(reg) { reg, #reg }
+static const struct {
+	u32 reg;
+	const char *name;
+} crtc_regs[] = {
+	CRTC_REG(PV_CONTROL),
+	CRTC_REG(PV_V_CONTROL),
+	CRTC_REG(PV_VSYNCD),
+	CRTC_REG(PV_HORZA),
+	CRTC_REG(PV_HORZB),
+	CRTC_REG(PV_VERTA),
+	CRTC_REG(PV_VERTB),
+	CRTC_REG(PV_VERTA_EVEN),
+	CRTC_REG(PV_VERTB_EVEN),
+	CRTC_REG(PV_INTEN),
+	CRTC_REG(PV_INTSTAT),
+	CRTC_REG(PV_STAT),
+	CRTC_REG(PV_HACT_ACT),
+};
+
+static void vc4_crtc_dump_regs(struct vc4_crtc *vc4_crtc)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(crtc_regs); i++) {
+		DRM_INFO("0x%04x (%s): 0x%08x\n",
+			 crtc_regs[i].reg, crtc_regs[i].name,
+			 CRTC_READ(crtc_regs[i].reg));
+	}
+}
+
+#ifdef CONFIG_DEBUG_FS
+int vc4_crtc_debugfs_regs(struct seq_file *m, void *unused)
+{
+	struct drm_info_node *node = (struct drm_info_node *) m->private;
+	struct drm_device *dev = node->minor->dev;
+	int crtc_index = (uintptr_t)node->info_ent->data;
+	struct drm_crtc *crtc;
+	struct vc4_crtc *vc4_crtc;
+	int i;
+
+	i = 0;
+	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
+		if (i == crtc_index)
+			break;
+		i++;
+	}
+	if (!crtc)
+		return 0;
+	vc4_crtc = to_vc4_crtc(crtc);
+
+	for (i = 0; i < ARRAY_SIZE(crtc_regs); i++) {
+		seq_printf(m, "%s (0x%04x): 0x%08x\n",
+			   crtc_regs[i].name, crtc_regs[i].reg,
+			   CRTC_READ(crtc_regs[i].reg));
+	}
+
+	return 0;
+}
+#endif
+
+static void vc4_crtc_destroy(struct drm_crtc *crtc)
+{
+	drm_crtc_cleanup(crtc);
+}
+
+static bool vc4_crtc_mode_fixup(struct drm_crtc *crtc,
+				const struct drm_display_mode *mode,
+				struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+
+static u32 vc4_get_fifo_full_level(u32 format)
+{
+	static const u32 fifo_len_bytes = 64;
+	static const u32 hvs_latency_pix = 6;
+
+	switch (format) {
+	case PV_CONTROL_FORMAT_DSIV_16:
+	case PV_CONTROL_FORMAT_DSIC_16:
+		return fifo_len_bytes - 2 * hvs_latency_pix;
+	case PV_CONTROL_FORMAT_DSIV_18:
+		return fifo_len_bytes - 14;
+	case PV_CONTROL_FORMAT_24:
+	case PV_CONTROL_FORMAT_DSIV_24:
+	default:
+		return fifo_len_bytes - 3 * hvs_latency_pix;
+	}
+}
+
+static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
+{
+	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	struct drm_crtc_state *state = crtc->state;
+	struct drm_display_mode *mode = &state->adjusted_mode;
+	u32 vactive = (mode->vdisplay >>
+		       ((mode->flags & DRM_MODE_FLAG_INTERLACE) ? 1 : 0));
+	u32 format = PV_CONTROL_FORMAT_24;
+	bool debug_dump_regs = false;
+
+	if (debug_dump_regs) {
+		DRM_INFO("CRTC %d regs before:\n", drm_crtc_index(crtc));
+		vc4_crtc_dump_regs(vc4_crtc);
+	}
+
+	/* This is where we would set the pixel clock. */
+
+	/* Reset the PV fifo. */
+	CRTC_WRITE(PV_CONTROL, 0);
+	CRTC_WRITE(PV_CONTROL, PV_CONTROL_FIFO_CLR | PV_CONTROL_EN);
+	CRTC_WRITE(PV_CONTROL, 0);
+
+	CRTC_WRITE(PV_HORZA,
+		   VC4_SET_FIELD(mode->htotal - mode->hsync_end,
+				 PV_HORZA_HBP) |
+		   VC4_SET_FIELD(mode->hsync_end - mode->hsync_start,
+				 PV_HORZA_HSYNC));
+	CRTC_WRITE(PV_HORZB,
+		   VC4_SET_FIELD(mode->hsync_start - mode->hdisplay,
+				 PV_HORZB_HFP) |
+		   VC4_SET_FIELD(mode->hdisplay, PV_HORZB_HACTIVE));
+
+	CRTC_WRITE(PV_VERTA,
+		   VC4_SET_FIELD(mode->vtotal - mode->vsync_end,
+				 PV_VERTA_VBP) |
+		   VC4_SET_FIELD(mode->vsync_end - mode->vsync_start,
+				 PV_VERTA_VSYNC));
+	CRTC_WRITE(PV_VERTB,
+		   VC4_SET_FIELD(mode->vsync_start - mode->vdisplay,
+				 PV_VERTB_VFP) |
+		   VC4_SET_FIELD(vactive, PV_VERTB_VACTIVE));
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE) {
+		/* Write PV_VERTA_EVEN/VERTB_EVEN */
+	}
+
+	CRTC_WRITE(PV_HACT_ACT, mode->hdisplay);
+
+	CRTC_WRITE(PV_V_CONTROL,
+		   PV_VCONTROL_CONTINUOUS);
+
+	CRTC_WRITE(PV_CONTROL,
+		   VC4_SET_FIELD(format, PV_CONTROL_FORMAT) |
+		   VC4_SET_FIELD(vc4_get_fifo_full_level(format),
+				 PV_CONTROL_FIFO_LEVEL) |
+		   PV_CONTROL_CLR_AT_START |
+		   PV_CONTROL_TRIGGER_UNDERFLOW |
+		   PV_CONTROL_WAIT_HSTART |
+		   VC4_SET_FIELD(PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI,
+				 PV_CONTROL_CLK_SELECT) |
+		   PV_CONTROL_FIFO_CLR |
+		   PV_CONTROL_EN);
+
+	if (debug_dump_regs) {
+		DRM_INFO("CRTC %d regs after:\n", drm_crtc_index(crtc));
+		vc4_crtc_dump_regs(vc4_crtc);
+	}
+}
+
+static void
+require_hvs_enabled(struct drm_device *dev)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+
+	WARN_ON_ONCE((HVS_READ(SCALER_DISPCTRL) & SCALER_DISPCTRL_ENABLE) !=
+		     SCALER_DISPCTRL_ENABLE);
+}
+
+static void vc4_crtc_disable(struct drm_crtc *crtc)
+{
+	struct drm_device *dev = crtc->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+
+	require_hvs_enabled(dev);
+
+	CRTC_WRITE(PV_V_CONTROL,
+		   CRTC_READ(PV_V_CONTROL) & ~PV_VCONTROL_VIDEN);
+	while (CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN)
+		cpu_relax();
+
+	/* Without a wait here, we end up with a black screen. */
+	msleep(30);
+
+	if (HVS_READ(SCALER_DISPCTRLX(vc4_crtc->channel)) &
+	    SCALER_DISPCTRLX_ENABLE) {
+		HVS_WRITE(SCALER_DISPCTRLX(vc4_crtc->channel),
+			  SCALER_DISPCTRLX_RESET);
+
+		/* While the docs say that reset is self-clearing, it
+		 * seems it doesn't actually.
+		 */
+		HVS_WRITE(SCALER_DISPCTRLX(vc4_crtc->channel), 0);
+	}
+
+	/* Once we leave, the scaler should be disabled and its fifo empty. */
+
+	WARN_ON_ONCE(HVS_READ(SCALER_DISPCTRLX(vc4_crtc->channel)) &
+		     SCALER_DISPCTRLX_RESET);
+
+	WARN_ON_ONCE(VC4_GET_FIELD(HVS_READ(SCALER_DISPSTATX(vc4_crtc->channel)),
+				   SCALER_DISPSTATX_MODE) !=
+		     SCALER_DISPSTATX_MODE_DISABLED);
+
+	WARN_ON_ONCE((HVS_READ(SCALER_DISPSTATX(vc4_crtc->channel)) &
+		      (SCALER_DISPSTATX_FULL | SCALER_DISPSTATX_EMPTY)) !=
+		     SCALER_DISPSTATX_EMPTY);
+}
+
+static void vc4_crtc_enable(struct drm_crtc *crtc)
+{
+	struct drm_device *dev = crtc->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	struct drm_crtc_state *state = crtc->state;
+	struct drm_display_mode *mode = &state->adjusted_mode;
+
+	require_hvs_enabled(dev);
+
+	/* Turn on the scaler, which will wait for vstart to start
+	 * compositing.
+	 */
+	HVS_WRITE(SCALER_DISPCTRLX(vc4_crtc->channel),
+		  VC4_SET_FIELD(mode->hdisplay, SCALER_DISPCTRLX_WIDTH) |
+		  VC4_SET_FIELD(mode->vdisplay, SCALER_DISPCTRLX_HEIGHT) |
+		  SCALER_DISPCTRLX_ENABLE);
+
+	/* Turn on the pixel valve, which will emit the vstart signal. */
+	CRTC_WRITE(PV_V_CONTROL,
+		   CRTC_READ(PV_V_CONTROL) | PV_VCONTROL_VIDEN);
+}
+
+static int vc4_crtc_atomic_check(struct drm_crtc *crtc,
+				 struct drm_crtc_state *state)
+{
+	struct drm_device *dev = crtc->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct drm_plane *plane;
+	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	u32 dlist_count = 0;
+
+	drm_atomic_crtc_state_for_each_plane(plane, state) {
+		struct drm_plane_state *plane_state =
+			state->state->plane_states[drm_plane_index(plane)];
+
+		/* plane might not have changed, in which case take
+		 * current state:
+		 */
+		if (!plane_state)
+			plane_state = plane->state;
+
+		dlist_count += vc4_plane_dlist_size(plane_state);
+	}
+
+	dlist_count++; /* Account for SCALER_CTL0_END. */
+
+	if (!vc4_crtc->dlist || dlist_count > vc4_crtc->dlist_size) {
+		vc4_crtc->dlist = ((u32 __iomem *)vc4->hvs->dlist +
+				   HVS_BOOTLOADER_DLIST_END);
+		vc4_crtc->dlist_size = ((SCALER_DLIST_SIZE >> 2) -
+					HVS_BOOTLOADER_DLIST_END);
+
+		if (dlist_count > vc4_crtc->dlist_size) {
+			DRM_DEBUG_KMS("dlist too large for CRTC (%d > %d).\n",
+				      dlist_count, vc4_crtc->dlist_size);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static void vc4_crtc_atomic_begin(struct drm_crtc *crtc)
+{
+}
+
+static void vc4_crtc_atomic_flush(struct drm_crtc *crtc)
+{
+	struct drm_device *dev = crtc->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	struct drm_plane *plane;
+	bool debug_dump_regs = false;
+	u32 __iomem *dlist_next = vc4_crtc->dlist;
+
+	if (debug_dump_regs) {
+		DRM_INFO("CRTC %d HVS before:\n", drm_crtc_index(crtc));
+		vc4_hvs_dump_state(dev);
+	}
+
+	/* Copy all the active planes' dlist contents to the hardware dlist.
+	 *
+	 * XXX: If the new display list was large enough that it
+	 * overlapped a currently-read display list, we need to do
+	 * something like disable scanout before putting in the new
+	 * list.  For now, we're safe because we only have the two
+	 * planes.
+	 */
+	drm_atomic_crtc_for_each_plane(plane, crtc) {
+		dlist_next += vc4_plane_write_dlist(plane, dlist_next);
+	}
+
+	if (dlist_next == vc4_crtc->dlist) {
+		/* If no planes were enabled, use the SCALER_CTL0_END
+		 * at the start of the display list memory (in the
+		 * bootloader section).  We'll rewrite that
+		 * SCALER_CTL0_END, just in case, though.
+		 */
+		writel(SCALER_CTL0_END, vc4->hvs->dlist);
+		HVS_WRITE(SCALER_DISPLISTX(vc4_crtc->channel), 0);
+	} else {
+		writel(SCALER_CTL0_END, dlist_next);
+		dlist_next++;
+
+		HVS_WRITE(SCALER_DISPLISTX(vc4_crtc->channel),
+			  (u32 *)vc4_crtc->dlist - (u32 *)vc4->hvs->dlist);
+
+		/* Make the next display list start after ours. */
+		vc4_crtc->dlist_size -= (dlist_next - vc4_crtc->dlist);
+		vc4_crtc->dlist = dlist_next;
+	}
+
+	if (debug_dump_regs) {
+		DRM_INFO("CRTC %d HVS after:\n", drm_crtc_index(crtc));
+		vc4_hvs_dump_state(dev);
+	}
+
+	if (crtc->state->event) {
+		unsigned long flags;
+
+		crtc->state->event->pipe = drm_crtc_index(crtc);
+
+		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
+
+		spin_lock_irqsave(&dev->event_lock, flags);
+		vc4_crtc->event = crtc->state->event;
+		spin_unlock_irqrestore(&dev->event_lock, flags);
+		crtc->state->event = NULL;
+	}
+}
+
+int vc4_enable_vblank(struct drm_device *dev, int crtc_id)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct vc4_crtc *vc4_crtc = vc4->crtc[crtc_id];
+
+	CRTC_WRITE(PV_INTEN, PV_INT_VFP_START);
+
+	return 0;
+}
+
+void vc4_disable_vblank(struct drm_device *dev, int crtc_id)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct vc4_crtc *vc4_crtc = vc4->crtc[crtc_id];
+
+	CRTC_WRITE(PV_INTEN, 0);
+}
+
+static void
+vc4_crtc_handle_page_flip(struct vc4_crtc *vc4_crtc)
+{
+	struct drm_crtc *crtc = &vc4_crtc->base;
+	struct drm_device *dev = crtc->dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	if (vc4_crtc->event) {
+		drm_crtc_send_vblank_event(crtc, vc4_crtc->event);
+		vc4_crtc->event = NULL;
+	}
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+}
+
+static irqreturn_t vc4_crtc_irq_handler(int irq, void *data)
+{
+	struct vc4_crtc *vc4_crtc = data;
+	u32 stat = CRTC_READ(PV_INTSTAT);
+	irqreturn_t ret = IRQ_NONE;
+
+	if (stat & PV_INT_VFP_START) {
+		CRTC_WRITE(PV_INTSTAT, PV_INT_VFP_START);
+		drm_crtc_handle_vblank(&vc4_crtc->base);
+		vc4_crtc_handle_page_flip(vc4_crtc);
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static const struct drm_crtc_funcs vc4_crtc_funcs = {
+	.set_config = drm_atomic_helper_set_config,
+	.destroy = vc4_crtc_destroy,
+	.page_flip = drm_atomic_helper_page_flip,
+	.set_property = NULL,
+	.cursor_set = NULL, /* handled by drm_mode_cursor_universal */
+	.cursor_move = NULL, /* handled by drm_mode_cursor_universal */
+	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
+	.mode_fixup = vc4_crtc_mode_fixup,
+	.mode_set_nofb = vc4_crtc_mode_set_nofb,
+	.disable = vc4_crtc_disable,
+	.enable = vc4_crtc_enable,
+	.atomic_check = vc4_crtc_atomic_check,
+	.atomic_begin = vc4_crtc_atomic_begin,
+	.atomic_flush = vc4_crtc_atomic_flush,
+};
+
+/* Frees the page flip event when the DRM device is closed with the
+ * event still outstanding.
+ */
+void vc4_cancel_page_flip(struct drm_crtc *crtc, struct drm_file *file)
+{
+	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+
+	if (vc4_crtc->event && vc4_crtc->event->base.file_priv == file) {
+		vc4_crtc->event->base.destroy(&vc4_crtc->event->base);
+		drm_crtc_vblank_put(crtc);
+		vc4_crtc->event = NULL;
+	}
+
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+}
+
+static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_device *drm = dev_get_drvdata(master);
+	struct vc4_dev *vc4 = to_vc4_dev(drm);
+	struct vc4_crtc *vc4_crtc;
+	struct drm_crtc *crtc;
+	struct drm_plane *primary_plane, *cursor_plane;
+	int ret;
+
+	primary_plane = vc4_plane_init(drm, DRM_PLANE_TYPE_PRIMARY);
+	if (!primary_plane) {
+		dev_err(dev, "failed to construct primary plane\n");
+		ret = PTR_ERR(primary_plane);
+		goto fail;
+	}
+
+	cursor_plane = vc4_plane_init(drm, DRM_PLANE_TYPE_CURSOR);
+	if (!cursor_plane) {
+		dev_err(dev, "failed to construct cursor plane\n");
+		ret = PTR_ERR(cursor_plane);
+		goto fail;
+	}
+
+	vc4_crtc = devm_kzalloc(dev, sizeof(*vc4_crtc), GFP_KERNEL);
+	if (!vc4_crtc)
+		return -ENOMEM;
+	crtc = &vc4_crtc->base;
+
+	vc4_crtc->regs = vc4_ioremap_regs(pdev, 0);
+	if (IS_ERR(vc4_crtc->regs))
+		return PTR_ERR(vc4_crtc->regs);
+
+	drm_crtc_init_with_planes(drm, crtc, primary_plane, cursor_plane,
+				  &vc4_crtc_funcs);
+	drm_crtc_helper_add(crtc, &vc4_crtc_helper_funcs);
+	primary_plane->crtc = crtc;
+	cursor_plane->crtc = crtc;
+	vc4->crtc[drm_crtc_index(crtc)] = vc4_crtc;
+
+	/* Until we have full scanout setup to route things through to
+	 * encoders, line things up like the firmware did.
+	 */
+	switch (drm_crtc_index(crtc)) {
+	case 0:
+		vc4_crtc->channel = 0;
+		break;
+	case 1:
+		vc4_crtc->channel = 2;
+		break;
+	default:
+	case 2:
+		vc4_crtc->channel = 1;
+		break;
+	}
+
+	CRTC_WRITE(PV_INTEN, 0);
+	CRTC_WRITE(PV_INTSTAT, PV_INT_VFP_START);
+	ret = devm_request_irq(dev, platform_get_irq(pdev, 0),
+			       vc4_crtc_irq_handler, 0, "vc4 crtc", vc4_crtc);
+
+	platform_set_drvdata(pdev, vc4_crtc);
+
+	return 0;
+
+fail:
+	return ret;
+}
+
+static void vc4_crtc_unbind(struct device *dev, struct device *master,
+			    void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct vc4_crtc *vc4_crtc = dev_get_drvdata(dev);
+
+	vc4_crtc_destroy(&vc4_crtc->base);
+
+	CRTC_WRITE(PV_INTEN, 0);
+
+	platform_set_drvdata(pdev, NULL);
+}
+
+static const struct component_ops vc4_crtc_ops = {
+	.bind   = vc4_crtc_bind,
+	.unbind = vc4_crtc_unbind,
+};
+
+static int vc4_crtc_dev_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &vc4_crtc_ops);
+}
+
+static int vc4_crtc_dev_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &vc4_crtc_ops);
+	return 0;
+}
+
+static const struct of_device_id vc4_crtc_dt_match[] = {
+	{ .compatible = "brcm,vc4-pixelvalve" },
+	{}
+};
+
+static struct platform_driver vc4_crtc_driver = {
+	.probe = vc4_crtc_dev_probe,
+	.remove = vc4_crtc_dev_remove,
+	.driver = {
+		.name = "vc4_crtc",
+		.of_match_table = vc4_crtc_dt_match,
+	},
+};
+
+void __init vc4_crtc_register(void)
+{
+	platform_driver_register(&vc4_crtc_driver);
+}
+
+void __exit vc4_crtc_unregister(void)
+{
+	platform_driver_unregister(&vc4_crtc_driver);
+}
diff --git a/drivers/gpu/drm/vc4/vc4_debugfs.c b/drivers/gpu/drm/vc4/vc4_debugfs.c
new file mode 100644
index 0000000..c557039
--- /dev/null
+++ b/drivers/gpu/drm/vc4/vc4_debugfs.c
@@ -0,0 +1,38 @@
+/*
+ *  Copyright ? 2014 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/seq_file.h>
+#include <linux/circ_buf.h>
+#include <linux/ctype.h>
+#include <linux/debugfs.h>
+#include <drm/drmP.h>
+
+#include "vc4_drv.h"
+#include "vc4_regs.h"
+
+static const struct drm_info_list vc4_debugfs_list[] = {
+	{"hdmi_regs", vc4_hdmi_debugfs_regs, 0},
+	{"hvs_regs", vc4_hvs_debugfs_regs, 0},
+	{"crtc0_regs", vc4_crtc_debugfs_regs, 0, (void *)(uintptr_t)0},
+	{"crtc1_regs", vc4_crtc_debugfs_regs, 0, (void *)(uintptr_t)1},
+	{"crtc2_regs", vc4_crtc_debugfs_regs, 0, (void *)(uintptr_t)2},
+};
+#define VC4_DEBUGFS_ENTRIES ARRAY_SIZE(vc4_debugfs_list)
+
+int
+vc4_debugfs_init(struct drm_minor *minor)
+{
+	return drm_debugfs_create_files(vc4_debugfs_list, VC4_DEBUGFS_ENTRIES,
+					minor->debugfs_root, minor);
+}
+
+void
+vc4_debugfs_cleanup(struct drm_minor *minor)
+{
+	drm_debugfs_remove_files(vc4_debugfs_list, VC4_DEBUGFS_ENTRIES, minor);
+}
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
new file mode 100644
index 0000000..9ecf4b8b
--- /dev/null
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -0,0 +1,249 @@
+/*
+ * Copyright (C) 2014-2015 Broadcom
+ * Copyright (C) 2013 Red Hat
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include "vc4_drv.h"
+#include "vc4_regs.h"
+
+#define DRIVER_NAME "vc4"
+#define DRIVER_DESC "Broadcom VC4 graphics"
+#define DRIVER_DATE "20140616"
+#define DRIVER_MAJOR 0
+#define DRIVER_MINOR 0
+#define DRIVER_PATCHLEVEL 0
+
+/* Helper function for mapping the regs on a platform device.
+ *
+ * We assume only one register range per device, so we use index 0.
+ */
+void __iomem *vc4_ioremap_regs(struct platform_device *dev, int index)
+{
+	struct resource *res;
+	void __iomem *map;
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, index);
+	map = devm_ioremap_resource(&dev->dev, res);
+	if (IS_ERR(map)) {
+		DRM_ERROR("Failed to map registers: %ld\n", PTR_ERR(map));
+		return map;
+	}
+
+	return map;
+}
+
+static int vc4_drm_load(struct drm_device *dev, unsigned long flags)
+{
+	struct vc4_dev *vc4;
+	int ret;
+
+	vc4 = devm_kzalloc(dev->dev, sizeof(*vc4), GFP_KERNEL);
+	if (!vc4)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev->dev, dev);
+	vc4->dev = dev;
+	dev->dev_private = vc4;
+
+	drm_mode_config_init(dev);
+
+	ret = component_bind_all(dev->dev, dev);
+	if (ret)
+		return ret;
+
+	vc4_kms_load(dev);
+
+	return 0;
+}
+
+static int vc4_drm_unload(struct drm_device *dev)
+{
+	drm_mode_config_cleanup(dev);
+
+	component_unbind_all(dev->dev, dev);
+
+	return 0;
+}
+
+static void vc4_drm_preclose(struct drm_device *dev, struct drm_file *file)
+{
+	struct drm_crtc *crtc;
+
+	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head)
+		vc4_cancel_page_flip(crtc, file);
+}
+
+static const struct file_operations vc4_drm_fops = {
+	.owner = THIS_MODULE,
+	.open = drm_open,
+	.release = drm_release,
+	.unlocked_ioctl = drm_ioctl,
+	.mmap = drm_gem_cma_mmap,
+	.poll = drm_poll,
+	.read = drm_read,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = drm_compat_ioctl,
+#endif
+	.llseek = noop_llseek,
+};
+
+static const struct drm_ioctl_desc vc4_drm_ioctls[] = {
+};
+
+static struct drm_driver vc4_drm_driver = {
+	.driver_features = (DRIVER_MODESET |
+			    DRIVER_ATOMIC |
+			    DRIVER_GEM |
+			    DRIVER_PRIME),
+	.load = vc4_drm_load,
+	.unload = vc4_drm_unload,
+	.set_busid = drm_platform_set_busid,
+	.preclose = vc4_drm_preclose,
+
+	.enable_vblank = vc4_enable_vblank,
+	.disable_vblank = vc4_disable_vblank,
+	.get_vblank_counter = drm_vblank_count,
+
+#if defined(CONFIG_DEBUG_FS)
+	.debugfs_init = vc4_debugfs_init,
+	.debugfs_cleanup = vc4_debugfs_cleanup,
+#endif
+
+	.gem_free_object = drm_gem_cma_free_object,
+	.gem_vm_ops = &drm_gem_cma_vm_ops,
+
+	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
+	.gem_prime_import = drm_gem_prime_import,
+	.gem_prime_export = drm_gem_prime_export,
+	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
+	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
+	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
+	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
+	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
+
+	.dumb_create = vc4_dumb_create,
+	.dumb_map_offset = drm_gem_cma_dumb_map_offset,
+	.dumb_destroy = drm_gem_dumb_destroy,
+
+	.ioctls = vc4_drm_ioctls,
+	.num_ioctls = ARRAY_SIZE(vc4_drm_ioctls),
+	.fops = &vc4_drm_fops,
+
+	.name = DRIVER_NAME,
+	.desc = DRIVER_DESC,
+	.date = DRIVER_DATE,
+	.major = DRIVER_MAJOR,
+	.minor = DRIVER_MINOR,
+	.patchlevel = DRIVER_PATCHLEVEL,
+};
+
+static int vc4_drm_bind(struct device *dev)
+{
+	return drm_platform_init(&vc4_drm_driver, to_platform_device(dev));
+}
+
+static void vc4_drm_unbind(struct device *dev)
+{
+	drm_put_dev(platform_get_drvdata(to_platform_device(dev)));
+}
+
+static const struct component_master_ops vc4_drm_ops = {
+	.bind = vc4_drm_bind,
+	.unbind = vc4_drm_unbind,
+};
+
+static int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static int add_components(struct device *dev, struct component_match **matchptr,
+			  const char *name)
+{
+	struct device_node *np = dev->of_node;
+	unsigned i;
+
+	for (i = 0; ; i++) {
+		struct device_node *node;
+
+		node = of_parse_phandle(np, name, i);
+		if (!node)
+			break;
+
+		component_match_add(dev, matchptr, compare_of, node);
+	}
+
+	return 0;
+}
+
+static int vc4_platform_drm_probe(struct platform_device *pdev)
+{
+	struct component_match *match = NULL;
+
+	add_components(&pdev->dev, &match, "crtcs");
+	add_components(&pdev->dev, &match, "encoders");
+	add_components(&pdev->dev, &match, "hvss");
+
+	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	return component_master_add_with_match(&pdev->dev, &vc4_drm_ops, match);
+}
+
+static int vc4_platform_drm_remove(struct platform_device *pdev)
+{
+	drm_put_dev(platform_get_drvdata(pdev));
+
+	return 0;
+}
+
+static const struct of_device_id vc4_of_match[] = {
+	{ .compatible = "brcm,vc4", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, vc4_of_match);
+
+static struct platform_driver vc4_platform_driver = {
+	.probe		= vc4_platform_drm_probe,
+	.remove		= vc4_platform_drm_remove,
+	.driver		= {
+		.name	= "vc4-drm",
+		.owner	= THIS_MODULE,
+		.of_match_table = vc4_of_match,
+	},
+};
+
+static int __init vc4_drm_register(void)
+{
+	vc4_hdmi_register();
+	vc4_crtc_register();
+	vc4_hvs_register();
+	return platform_driver_register(&vc4_platform_driver);
+}
+
+static void __exit vc4_drm_unregister(void)
+{
+	platform_driver_unregister(&vc4_platform_driver);
+	vc4_hvs_unregister();
+	vc4_crtc_unregister();
+	vc4_hdmi_unregister();
+}
+
+module_init(vc4_drm_register);
+module_exit(vc4_drm_unregister);
+
+MODULE_ALIAS("platform:vc4-drm");
+MODULE_DESCRIPTION("Broadcom VC4 DRM Driver");
+MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
new file mode 100644
index 0000000..1b0a0b0
--- /dev/null
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -0,0 +1,123 @@
+/*
+ * Copyright (C) 2015 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "drmP.h"
+#include "drm_gem_cma_helper.h"
+
+struct vc4_dev {
+	struct drm_device *dev;
+
+	struct vc4_hdmi *hdmi;
+	struct vc4_hvs *hvs;
+	struct vc4_crtc *crtc[3];
+};
+
+static inline struct vc4_dev *
+to_vc4_dev(struct drm_device *dev)
+{
+	return (struct vc4_dev *)dev->dev_private;
+}
+
+struct vc4_bo {
+	struct drm_gem_cma_object base;
+};
+
+static inline struct vc4_bo *
+to_vc4_bo(struct drm_gem_object *bo)
+{
+	return (struct vc4_bo *)bo;
+}
+
+struct vc4_hvs {
+	struct platform_device *pdev;
+	void __iomem *regs;
+	void __iomem *dlist;
+};
+
+struct vc4_crtc {
+	struct drm_crtc base;
+	void __iomem *regs;
+
+	/* Which HVS channel we're using for our CRTC. */
+	int channel;
+
+	/* Pointer to the actual hardware display list memory for the
+	 * crtc.
+	 */
+	u32 __iomem *dlist;
+
+	u32 dlist_size; /* in dwords */
+
+	struct drm_pending_vblank_event *event;
+};
+
+static inline struct vc4_crtc *
+to_vc4_crtc(struct drm_crtc *crtc)
+{
+	return (struct vc4_crtc *)crtc;
+}
+
+struct vc4_plane {
+	struct drm_plane base;
+};
+
+static inline struct vc4_plane *
+to_vc4_plane(struct drm_plane *plane)
+{
+	return (struct vc4_plane *)plane;
+}
+
+#define HVS_READ(offset) readl(vc4->hvs->regs + offset)
+#define HVS_WRITE(offset, val) writel(val, vc4->hvs->regs + offset)
+
+/* vc4_bo.c */
+void vc4_free_object(struct drm_gem_object *gem_obj);
+struct vc4_bo *vc4_bo_create(struct drm_device *dev, size_t size);
+int vc4_dumb_create(struct drm_file *file_priv,
+		    struct drm_device *dev,
+		    struct drm_mode_create_dumb *args);
+struct dma_buf *vc4_prime_export(struct drm_device *dev,
+				 struct drm_gem_object *obj, int flags);
+
+/* vc4_crtc.c */
+void vc4_crtc_register(void);
+void vc4_crtc_unregister(void);
+int vc4_enable_vblank(struct drm_device *dev, int crtc_id);
+void vc4_disable_vblank(struct drm_device *dev, int crtc_id);
+void vc4_cancel_page_flip(struct drm_crtc *crtc, struct drm_file *file);
+int vc4_crtc_debugfs_regs(struct seq_file *m, void *arg);
+
+/* vc4_debugfs.c */
+int vc4_debugfs_init(struct drm_minor *minor);
+void vc4_debugfs_cleanup(struct drm_minor *minor);
+
+/* vc4_drv.c */
+void __iomem *vc4_ioremap_regs(struct platform_device *dev, int index);
+
+/* vc4_hdmi.c */
+void vc4_hdmi_register(void);
+void vc4_hdmi_unregister(void);
+struct drm_encoder *vc4_hdmi_encoder_init(struct drm_device *dev);
+struct drm_connector *vc4_hdmi_connector_init(struct drm_device *dev,
+					      struct drm_encoder *encoder);
+int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused);
+
+/* vc4_hvs.c */
+void vc4_hvs_register(void);
+void vc4_hvs_unregister(void);
+void vc4_hvs_dump_state(struct drm_device *dev);
+int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused);
+
+/* vc4_kms.c */
+int vc4_kms_load(struct drm_device *dev);
+
+/* vc4_plane.c */
+struct drm_plane *vc4_plane_init(struct drm_device *dev,
+				 enum drm_plane_type type);
+u32 vc4_plane_write_dlist(struct drm_plane *plane, u32 __iomem *dlist);
+u32 vc4_plane_dlist_size(struct drm_plane_state *state);
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
new file mode 100644
index 0000000..c1ac96e
--- /dev/null
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -0,0 +1,651 @@
+/*
+ * Copyright (c) 2014 The Linux Foundation. All rights reserved.
+ * Copyright (C) 2013 Red Hat
+ * Author: Rob Clark <robdclark@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "drm_atomic_helper.h"
+#include "drm_crtc_helper.h"
+#include "drm_edid.h"
+#include "linux/clk.h"
+#include "linux/component.h"
+#include "linux/of_gpio.h"
+#include "linux/of_platform.h"
+#include "vc4_drv.h"
+#include "vc4_regs.h"
+
+/* General HDMI hardware state. */
+struct vc4_hdmi {
+	struct platform_device *pdev;
+	struct i2c_adapter *ddc;
+	void __iomem *hdmicore_regs;
+	void __iomem *hd_regs;
+	int hpd_gpio;
+
+	/* Probed video mode at boot time, used to filter display
+	 * modes to only allow equivalent ones (since we can't set the
+	 * pixel clock yet).
+	 */
+	struct drm_display_mode boot_mode;
+};
+#define HDMI_READ(offset) readl(vc4->hdmi->hdmicore_regs + offset)
+#define HDMI_WRITE(offset, val) writel(val, vc4->hdmi->hdmicore_regs + offset)
+#define HD_READ(offset) readl(vc4->hdmi->hd_regs + offset)
+#define HD_WRITE(offset, val) writel(val, vc4->hdmi->hd_regs + offset)
+
+/* VC4 HDMI encoder KMS struct */
+struct vc4_hdmi_encoder {
+	struct drm_encoder base;
+	bool hdmi_monitor;
+};
+static inline struct vc4_hdmi_encoder *
+to_vc4_hdmi_encoder(struct drm_encoder *encoder)
+{
+	return container_of(encoder, struct vc4_hdmi_encoder, base);
+}
+
+/* VC4 HDMI connector KMS struct */
+struct vc4_hdmi_connector {
+	struct drm_connector base;
+
+	/* Since the connector is attached to just the one encoder,
+	 * this is the reference to it so we can do the best_encoder()
+	 * hook.
+	 */
+	struct drm_encoder *encoder;
+};
+static inline struct vc4_hdmi_connector *
+to_vc4_hdmi_connector(struct drm_connector *connector)
+{
+	return container_of(connector, struct vc4_hdmi_connector, base);
+}
+
+#define HDMI_REG(reg) { reg, #reg }
+static const struct {
+	u32 reg;
+	const char *name;
+} hdmi_regs[] = {
+	HDMI_REG(VC4_HDMI_CORE_REV),
+	HDMI_REG(VC4_HDMI_SW_RESET_CONTROL),
+	HDMI_REG(VC4_HDMI_HOTPLUG_INT),
+	HDMI_REG(VC4_HDMI_HOTPLUG),
+	HDMI_REG(VC4_HDMI_HORZA),
+	HDMI_REG(VC4_HDMI_HORZB),
+	HDMI_REG(VC4_HDMI_FIFO_CTL),
+	HDMI_REG(VC4_HDMI_SCHEDULER_CONTROL),
+	HDMI_REG(VC4_HDMI_VERTA0),
+	HDMI_REG(VC4_HDMI_VERTA1),
+	HDMI_REG(VC4_HDMI_VERTB0),
+	HDMI_REG(VC4_HDMI_VERTB1),
+	HDMI_REG(VC4_HDMI_TX_PHY_RESET_CTL),
+};
+static const struct {
+	u32 reg;
+	const char *name;
+} hd_regs[] = {
+	HDMI_REG(VC4_HD_M_CTL),
+	HDMI_REG(VC4_HD_MAI_CTL),
+	HDMI_REG(VC4_HD_VID_CTL),
+	HDMI_REG(VC4_HD_CSC_CTL),
+	HDMI_REG(VC4_HD_FRAME_COUNT),
+};
+
+#ifdef CONFIG_DEBUG_FS
+int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
+{
+	struct drm_info_node *node = (struct drm_info_node *) m->private;
+	struct drm_device *dev = node->minor->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hdmi_regs); i++) {
+		seq_printf(m, "%s (0x%04x): 0x%08x\n",
+			   hdmi_regs[i].name, hdmi_regs[i].reg,
+			   HDMI_READ(hdmi_regs[i].reg));
+	}
+
+	for (i = 0; i < ARRAY_SIZE(hd_regs); i++) {
+		seq_printf(m, "%s (0x%04x): 0x%08x\n",
+			   hd_regs[i].name, hd_regs[i].reg,
+			   HD_READ(hd_regs[i].reg));
+	}
+
+	return 0;
+}
+#endif /* CONFIG_DEBUG_FS */
+
+static void vc4_hdmi_dump_regs(struct drm_device *dev)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hdmi_regs); i++) {
+		DRM_INFO("0x%04x (%s): 0x%08x\n",
+			 hdmi_regs[i].reg, hdmi_regs[i].name,
+			 HDMI_READ(hdmi_regs[i].reg));
+	}
+	for (i = 0; i < ARRAY_SIZE(hd_regs); i++) {
+		DRM_INFO("0x%04x (%s): 0x%08x\n",
+			 hd_regs[i].reg, hd_regs[i].name,
+			 HD_READ(hd_regs[i].reg));
+	}
+}
+
+static enum drm_connector_status
+vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
+{
+	struct drm_device *dev = connector->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+
+	if (vc4->hdmi->hpd_gpio) {
+		if (gpio_get_value(vc4->hdmi->hpd_gpio))
+			return connector_status_connected;
+		else
+			return connector_status_disconnected;
+	}
+
+	if (HDMI_READ(VC4_HDMI_HOTPLUG) & VC4_HDMI_HOTPLUG_CONNECTED)
+		return connector_status_connected;
+	else
+		return connector_status_disconnected;
+}
+
+static void vc4_hdmi_connector_destroy(struct drm_connector *connector)
+{
+	drm_connector_unregister(connector);
+	drm_connector_cleanup(connector);
+}
+
+static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
+{
+	struct vc4_hdmi_connector *vc4_connector =
+		to_vc4_hdmi_connector(connector);
+	struct drm_encoder *encoder = vc4_connector->encoder;
+	struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
+	struct drm_device *dev = connector->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	int ret = 0;
+	struct edid *edid;
+
+	edid = drm_get_edid(connector, vc4->hdmi->ddc);
+	if (!edid)
+		return -ENODEV;
+
+	vc4_encoder->hdmi_monitor = drm_detect_hdmi_monitor(edid);
+	drm_mode_connector_update_edid_property(connector, edid);
+	ret = drm_add_edid_modes(connector, edid);
+
+	return ret;
+}
+
+/* Since we can't set the pixel clock yet, filter out all the EDID
+ * modes that don't match what was set up by the firmware.
+ */
+int vc4_hdmi_mode_valid(struct drm_connector *connector,
+			struct drm_display_mode *mode)
+{
+	struct drm_device *dev = connector->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct drm_display_mode *boot_mode = &vc4->hdmi->boot_mode;
+
+	if (mode->hdisplay != boot_mode->hdisplay ||
+	    mode->hsync_start != boot_mode->hsync_start ||
+	    mode->hsync_end != boot_mode->hsync_end ||
+	    mode->htotal != boot_mode->htotal) {
+		return MODE_ERROR;
+	}
+
+	return MODE_OK;
+}
+
+static struct drm_encoder *
+vc4_hdmi_connector_best_encoder(struct drm_connector *connector)
+{
+	struct vc4_hdmi_connector *hdmi_connector =
+		to_vc4_hdmi_connector(connector);
+	return hdmi_connector->encoder;
+}
+
+static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
+	.dpms = drm_atomic_helper_connector_dpms,
+	.detect = vc4_hdmi_connector_detect,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = vc4_hdmi_connector_destroy,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static const struct drm_connector_helper_funcs vc4_hdmi_connector_helper_funcs = {
+	.get_modes = vc4_hdmi_connector_get_modes,
+	.mode_valid = vc4_hdmi_mode_valid,
+	.best_encoder = vc4_hdmi_connector_best_encoder,
+};
+
+struct drm_connector *vc4_hdmi_connector_init(struct drm_device *dev,
+					      struct drm_encoder *encoder)
+{
+	struct drm_connector *connector = NULL;
+	struct vc4_hdmi_connector *hdmi_connector;
+	int ret = 0;
+
+	hdmi_connector = devm_kzalloc(dev->dev, sizeof(*hdmi_connector),
+				      GFP_KERNEL);
+	if (!hdmi_connector) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+	connector = &hdmi_connector->base;
+
+	hdmi_connector->encoder = encoder;
+
+	drm_connector_init(dev, connector, &vc4_hdmi_connector_funcs,
+			   DRM_MODE_CONNECTOR_HDMIA);
+	drm_connector_helper_add(connector, &vc4_hdmi_connector_helper_funcs);
+
+	connector->polled = (DRM_CONNECTOR_POLL_CONNECT |
+			     DRM_CONNECTOR_POLL_DISCONNECT);
+
+	connector->interlace_allowed = 0;
+	connector->doublescan_allowed = 0;
+
+	drm_connector_register(connector);
+
+	drm_mode_connector_attach_encoder(connector, encoder);
+
+	return connector;
+
+ fail:
+	if (connector)
+		vc4_hdmi_connector_destroy(connector);
+
+	return ERR_PTR(ret);
+}
+
+static void vc4_encoder_destroy(struct drm_encoder *encoder)
+{
+	drm_encoder_cleanup(encoder);
+}
+
+static const struct drm_encoder_funcs vc4_hdmi_encoder_funcs = {
+	.destroy = vc4_encoder_destroy,
+};
+
+static bool vc4_hdmi_encoder_mode_fixup(struct drm_encoder *encoder,
+					const struct drm_display_mode *mode,
+					struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+
+static void vc4_hdmi_encoder_mode_set(struct drm_encoder *encoder,
+				      struct drm_display_mode *unadjusted_mode,
+				      struct drm_display_mode *mode)
+{
+	struct drm_device *dev = encoder->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	bool debug_dump_regs = false;
+	bool hsync_pos = !(mode->flags & DRM_MODE_FLAG_NHSYNC);
+	bool vsync_pos = !(mode->flags & DRM_MODE_FLAG_NVSYNC);
+	u32 vactive = (mode->vdisplay >>
+		       ((mode->flags & DRM_MODE_FLAG_INTERLACE) ? 1 : 0));
+	u32 verta = (VC4_SET_FIELD(mode->vsync_end - mode->vsync_start,
+				   VC4_HDMI_VERTA_VSP) |
+		     VC4_SET_FIELD(mode->vsync_start - mode->vdisplay,
+				   VC4_HDMI_VERTA_VFP) |
+		     VC4_SET_FIELD(vactive, VC4_HDMI_VERTA_VAL));
+	u32 vertb = (VC4_SET_FIELD(0, VC4_HDMI_VERTB_VSPO) |
+		     VC4_SET_FIELD(mode->vtotal - mode->vsync_end,
+				   VC4_HDMI_VERTB_VBP));
+
+	if (debug_dump_regs) {
+		DRM_INFO("HDMI regs before:\n");
+		vc4_hdmi_dump_regs(dev);
+	}
+
+	HD_WRITE(VC4_HD_VID_CTL, 0);
+
+	/* XXX: This is where we would set the HDMI state machine
+	 * clock, if we had an interface for it.
+	 */
+
+	HDMI_WRITE(VC4_HDMI_SCHEDULER_CONTROL,
+		   HDMI_READ(VC4_HDMI_SCHEDULER_CONTROL) |
+		   VC4_HDMI_SCHEDULER_CONTROL_MANUAL_FORMAT |
+		   VC4_HDMI_SCHEDULER_CONTROL_IGNORE_VSYNC_PREDICTS);
+
+	HDMI_WRITE(VC4_HDMI_HORZA,
+		   (vsync_pos ? VC4_HDMI_HORZA_VPOS : 0) |
+		   (hsync_pos ? VC4_HDMI_HORZA_HPOS : 0) |
+		   VC4_SET_FIELD(mode->hdisplay, VC4_HDMI_HORZA_HAP));
+
+	HDMI_WRITE(VC4_HDMI_HORZB,
+		   VC4_SET_FIELD(mode->htotal - mode->hsync_end,
+				 VC4_HDMI_HORZB_HBP) |
+		   VC4_SET_FIELD(mode->hsync_end - mode->hsync_start,
+				 VC4_HDMI_HORZB_HSP) |
+		   VC4_SET_FIELD(mode->hsync_start - mode->hdisplay,
+				 VC4_HDMI_HORZB_HFP));
+
+	HDMI_WRITE(VC4_HDMI_VERTA0, verta);
+	HDMI_WRITE(VC4_HDMI_VERTA1, verta);
+
+	HDMI_WRITE(VC4_HDMI_VERTB0, vertb);
+	HDMI_WRITE(VC4_HDMI_VERTB1, vertb);
+
+	HD_WRITE(VC4_HD_VID_CTL,
+		 (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
+		 (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
+
+	/* The RGB order applies even when CSC is disabled. */
+	HD_WRITE(VC4_HD_CSC_CTL, VC4_SET_FIELD(VC4_HD_CSC_CTL_ORDER_BGR,
+					       VC4_HD_CSC_CTL_ORDER));
+
+	HDMI_WRITE(VC4_HDMI_FIFO_CTL, VC4_HDMI_FIFO_CTL_MASTER_SLAVE_N);
+
+	if (debug_dump_regs) {
+		DRM_INFO("HDMI regs after:\n");
+		vc4_hdmi_dump_regs(dev);
+	}
+}
+
+static void vc4_hdmi_encoder_disable(struct drm_encoder *encoder)
+{
+	struct drm_device *dev = encoder->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+
+	HDMI_WRITE(VC4_HDMI_TX_PHY_RESET_CTL, 0xf << 16);
+	HD_WRITE(VC4_HD_VID_CTL,
+		 HD_READ(VC4_HD_VID_CTL) & ~VC4_HD_VID_CTL_ENABLE);
+}
+
+static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
+{
+	struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
+	struct drm_device *dev = encoder->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+
+	HDMI_WRITE(VC4_HDMI_TX_PHY_RESET_CTL, 0);
+
+	HD_WRITE(VC4_HD_VID_CTL,
+		 HD_READ(VC4_HD_VID_CTL) |
+		 VC4_HD_VID_CTL_ENABLE |
+		 VC4_HD_VID_CTL_UNDERFLOW_ENABLE |
+		 VC4_HD_VID_CTL_FRAME_COUNTER_RESET);
+
+	if (vc4_encoder->hdmi_monitor) {
+		HDMI_WRITE(VC4_HDMI_SCHEDULER_CONTROL,
+			   HDMI_READ(VC4_HDMI_SCHEDULER_CONTROL) |
+			   VC4_HDMI_SCHEDULER_CONTROL_MODE_HDMI);
+
+		while (!(HDMI_READ(VC4_HDMI_SCHEDULER_CONTROL) &
+			 VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE)) {
+			cpu_relax();
+		}
+	} else {
+		HDMI_WRITE(VC4_HDMI_RAM_PACKET_CONFIG,
+			   HDMI_READ(VC4_HDMI_RAM_PACKET_CONFIG) &
+			   ~(VC4_HDMI_RAM_PACKET_ENABLE));
+		HDMI_WRITE(VC4_HDMI_SCHEDULER_CONTROL,
+			   HDMI_READ(VC4_HDMI_SCHEDULER_CONTROL) &
+			   ~VC4_HDMI_SCHEDULER_CONTROL_MODE_HDMI);
+
+		while (HDMI_READ(VC4_HDMI_SCHEDULER_CONTROL) &
+		       VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE) {
+			cpu_relax();
+		}
+	}
+
+	if (vc4_encoder->hdmi_monitor) {
+		u32 drift;
+
+		WARN_ON(!(HDMI_READ(VC4_HDMI_SCHEDULER_CONTROL) &
+			  VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE));
+		HDMI_WRITE(VC4_HDMI_SCHEDULER_CONTROL,
+			   HDMI_READ(VC4_HDMI_SCHEDULER_CONTROL) |
+			   VC4_HDMI_SCHEDULER_CONTROL_VERT_ALWAYS_KEEPOUT);
+
+		/* XXX: Set HDMI_RAM_PACKET_CONFIG (1 << 16) and set
+		 * up the infoframe.
+		 */
+
+		drift = HDMI_READ(VC4_HDMI_FIFO_CTL);
+		drift &= VC4_HDMI_FIFO_VALID_WRITE_MASK;
+
+		HDMI_WRITE(VC4_HDMI_FIFO_CTL,
+			   drift & ~VC4_HDMI_FIFO_CTL_RECENTER);
+		HDMI_WRITE(VC4_HDMI_FIFO_CTL,
+			   drift | VC4_HDMI_FIFO_CTL_RECENTER);
+		udelay(1000);
+		HDMI_WRITE(VC4_HDMI_FIFO_CTL,
+			   drift & ~VC4_HDMI_FIFO_CTL_RECENTER);
+		HDMI_WRITE(VC4_HDMI_FIFO_CTL,
+			   drift | VC4_HDMI_FIFO_CTL_RECENTER);
+
+		while ((HDMI_READ(VC4_HDMI_FIFO_CTL) &
+			VC4_HDMI_FIFO_CTL_RECENTER_DONE) == 0) {
+			cpu_relax();
+		}
+	}
+}
+
+static const struct drm_encoder_helper_funcs vc4_hdmi_encoder_helper_funcs = {
+	.mode_fixup = vc4_hdmi_encoder_mode_fixup,
+	.mode_set = vc4_hdmi_encoder_mode_set,
+	.disable = vc4_hdmi_encoder_disable,
+	.enable = vc4_hdmi_encoder_enable,
+};
+
+static struct drm_crtc *
+vc4_get_crtc_node(struct platform_device *pdev)
+{
+	struct device_node *crtc_node;
+	struct platform_device *crtc_pdev;
+
+	crtc_node = of_parse_phandle(pdev->dev.of_node, "crtc", 0);
+	if (!crtc_node) {
+		DRM_ERROR("No CRTC for hdmi in DT\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	crtc_pdev = of_find_device_by_node(crtc_node);
+	if (!crtc_pdev) {
+		DRM_ERROR("No CRTC device attached to OF node\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return platform_get_drvdata(crtc_pdev);
+}
+
+struct drm_encoder *vc4_hdmi_encoder_init(struct drm_device *dev)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct drm_encoder *encoder = NULL;
+	struct vc4_hdmi_encoder *vc4_hdmi_encoder;
+	struct drm_crtc *crtc;
+	int ret;
+
+	vc4_hdmi_encoder = devm_kzalloc(dev->dev, sizeof(*vc4_hdmi_encoder),
+					GFP_KERNEL);
+	if (!vc4_hdmi_encoder) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+	encoder = &vc4_hdmi_encoder->base;
+
+	crtc = vc4_get_crtc_node(vc4->hdmi->pdev);
+	if (IS_ERR(crtc)) {
+		ret = PTR_ERR(crtc);
+		goto fail;
+	}
+
+	drm_encoder_init(dev, encoder, &vc4_hdmi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS);
+	drm_encoder_helper_add(encoder, &vc4_hdmi_encoder_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+
+	return encoder;
+
+fail:
+	if (encoder)
+		vc4_encoder_destroy(encoder);
+
+	return ERR_PTR(ret);
+}
+
+/* Reads out the current HDMI mode progreamming at driver load time.
+ *
+ * This is currently used for later filtering out of the DDC-probed
+ * video modes, since we can't actually change modes due to not having
+ * control of the necessary clocks.  Later on, we may end up reusing
+ * this for skipping modesets at boot time.
+ */
+static void
+vc4_hdmi_get_boot_display_mode(struct vc4_dev *vc4)
+{
+	struct drm_display_mode *mode = &vc4->hdmi->boot_mode;
+	u32 horza = HDMI_READ(VC4_HDMI_HORZA);
+	u32 horzb = HDMI_READ(VC4_HDMI_HORZB);
+	u32 verta = HDMI_READ(VC4_HDMI_VERTA0);
+	u32 vertb = HDMI_READ(VC4_HDMI_VERTB0);
+
+	memset(mode, 0, sizeof(*mode));
+
+	if (!(horza & VC4_HDMI_HORZA_VPOS))
+		mode->flags |= DRM_MODE_FLAG_NVSYNC;
+	if (!(horza & VC4_HDMI_HORZA_HPOS))
+		mode->flags |= DRM_MODE_FLAG_NHSYNC;
+	mode->hdisplay = VC4_GET_FIELD(horza, VC4_HDMI_HORZA_HAP);
+	mode->hsync_start = (mode->hdisplay +
+			     VC4_GET_FIELD(horzb, VC4_HDMI_HORZB_HFP));
+	mode->hsync_end = (mode->hsync_start +
+			   VC4_GET_FIELD(horzb, VC4_HDMI_HORZB_HSP));
+	mode->htotal = (mode->hsync_end +
+			VC4_GET_FIELD(horzb, VC4_HDMI_HORZB_HBP));
+
+	mode->vdisplay = VC4_GET_FIELD(verta, VC4_HDMI_VERTA_VAL);
+	mode->vsync_start = (mode->vdisplay +
+			     VC4_GET_FIELD(verta, VC4_HDMI_VERTA_VFP));
+	mode->vsync_end = (mode->vsync_start +
+			   VC4_GET_FIELD(verta, VC4_HDMI_VERTA_VSP));
+	mode->vtotal = (mode->vsync_end +
+			VC4_GET_FIELD(vertb, VC4_HDMI_VERTB_VBP));
+}
+
+static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_device *drm = dev_get_drvdata(master);
+	struct vc4_dev *vc4 = drm->dev_private;
+	struct vc4_hdmi *hdmi;
+	struct device_node *ddc_node;
+	u32 value;
+
+	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
+	if (!hdmi)
+		return -ENOMEM;
+
+	hdmi->pdev = pdev;
+	hdmi->hdmicore_regs = vc4_ioremap_regs(pdev, 0);
+	if (IS_ERR(hdmi->hdmicore_regs))
+		return PTR_ERR(hdmi->hdmicore_regs);
+
+	hdmi->hd_regs = vc4_ioremap_regs(pdev, 1);
+	if (IS_ERR(hdmi->hd_regs))
+		return PTR_ERR(hdmi->hd_regs);
+
+	/* DDC i2c driver */
+	ddc_node = of_parse_phandle(dev->of_node, "ddc", 0);
+	if (!ddc_node) {
+		DRM_ERROR("Failed to find ddc node in device tree\n");
+		return -ENODEV;
+	}
+
+	hdmi->ddc = of_find_i2c_adapter_by_node(ddc_node);
+	if (!hdmi->ddc) {
+		DRM_ERROR("Failed to get ddc i2c adapter by node\n");
+		return -EPROBE_DEFER;
+	}
+
+	/* Only use the GPIO HPD pin if present in the DT, otherwise
+	 * we'll use the HDMI core's register.
+	 */
+	if (of_find_property(dev->of_node, "hpd-gpio", &value)) {
+		hdmi->hpd_gpio = of_get_named_gpio(dev->of_node, "hpd-gpio", 0);
+		if (hdmi->hpd_gpio < 0)
+			return hdmi->hpd_gpio;
+	}
+
+	vc4->hdmi = hdmi;
+
+	/* HDMI core must be enabled. */
+	WARN_ON_ONCE((HD_READ(VC4_HD_M_CTL) & VC4_HD_M_ENABLE) == 0);
+
+	vc4_hdmi_get_boot_display_mode(vc4);
+
+	return 0;
+}
+
+static void vc4_hdmi_unbind(struct device *dev, struct device *master,
+			    void *data)
+{
+	struct drm_device *drm = dev_get_drvdata(master);
+	struct vc4_dev *vc4 = drm->dev_private;
+
+	put_device(&vc4->hdmi->ddc->dev);
+
+	vc4->hdmi = NULL;
+}
+
+static const struct component_ops vc4_hdmi_ops = {
+	.bind   = vc4_hdmi_bind,
+	.unbind = vc4_hdmi_unbind,
+};
+
+static int vc4_hdmi_dev_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &vc4_hdmi_ops);
+}
+
+static int vc4_hdmi_dev_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &vc4_hdmi_ops);
+	return 0;
+}
+
+static const struct of_device_id vc4_hdmi_dt_match[] = {
+	{ .compatible = "brcm,vc4-hdmi" },
+	{}
+};
+
+static struct platform_driver vc4_hdmi_driver = {
+	.probe = vc4_hdmi_dev_probe,
+	.remove = vc4_hdmi_dev_remove,
+	.driver = {
+		.name = "vc4_hdmi",
+		.of_match_table = vc4_hdmi_dt_match,
+	},
+};
+
+void __init vc4_hdmi_register(void)
+{
+	platform_driver_register(&vc4_hdmi_driver);
+}
+
+void __exit vc4_hdmi_unregister(void)
+{
+	platform_driver_unregister(&vc4_hdmi_driver);
+}
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
new file mode 100644
index 0000000..dcf4f78
--- /dev/null
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -0,0 +1,172 @@
+/*
+ * Copyright (C) 2015 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/**
+ * DOC: VC4 HVS module.
+ *
+ * The HVS is the piece of hardware that does translation, scaling,
+ * colorspace conversion, and compositing of pixels stored in
+ * framebuffers into a FIFO of pixels going out to the Pixel Valve
+ * (CRTC).
+ *
+ * There is a single global HVS, with multiple output FIFOs that can
+ * be consumed by the PVs.  This file just manages the resources for
+ * the HVS, while the vc4_crtc.c code actually drives HVS setup for
+ * each CRTC.
+ */
+
+#include "linux/component.h"
+#include "vc4_drv.h"
+#include "vc4_regs.h"
+
+#define HVS_REG(reg) { reg, #reg }
+static const struct {
+	u32 reg;
+	const char *name;
+} hvs_regs[] = {
+	HVS_REG(SCALER_DISPCTRL),
+	HVS_REG(SCALER_DISPSTAT),
+	HVS_REG(SCALER_DISPID),
+	HVS_REG(SCALER_DISPECTRL),
+	HVS_REG(SCALER_DISPPROF),
+	HVS_REG(SCALER_DISPDITHER),
+	HVS_REG(SCALER_DISPEOLN),
+	HVS_REG(SCALER_DISPLIST0),
+	HVS_REG(SCALER_DISPLIST1),
+	HVS_REG(SCALER_DISPLIST2),
+	HVS_REG(SCALER_DISPLSTAT),
+	HVS_REG(SCALER_DISPLACT0),
+	HVS_REG(SCALER_DISPLACT1),
+	HVS_REG(SCALER_DISPLACT2),
+	HVS_REG(SCALER_DISPCTRL0),
+	HVS_REG(SCALER_DISPBKGND0),
+	HVS_REG(SCALER_DISPSTAT0),
+	HVS_REG(SCALER_DISPBASE0),
+	HVS_REG(SCALER_DISPCTRL1),
+	HVS_REG(SCALER_DISPBKGND1),
+	HVS_REG(SCALER_DISPSTAT1),
+	HVS_REG(SCALER_DISPBASE1),
+	HVS_REG(SCALER_DISPCTRL2),
+	HVS_REG(SCALER_DISPBKGND2),
+	HVS_REG(SCALER_DISPSTAT2),
+	HVS_REG(SCALER_DISPBASE2),
+	HVS_REG(SCALER_DISPALPHA2),
+};
+
+void
+vc4_hvs_dump_state(struct drm_device *dev)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hvs_regs); i++) {
+		DRM_INFO("0x%04x (%s): 0x%08x\n",
+			 hvs_regs[i].reg, hvs_regs[i].name,
+			 HVS_READ(hvs_regs[i].reg));
+	}
+
+	DRM_INFO("HVS ctx:\n");
+	for (i = 0; i < 64; i += 4) {
+		DRM_INFO("0x%08x (%s): 0x%08x 0x%08x 0x%08x 0x%08x\n",
+			 i * 4, i < HVS_BOOTLOADER_DLIST_END ? "B" : "D",
+			 ((uint32_t *)vc4->hvs->dlist)[i + 0],
+			 ((uint32_t *)vc4->hvs->dlist)[i + 1],
+			 ((uint32_t *)vc4->hvs->dlist)[i + 2],
+			 ((uint32_t *)vc4->hvs->dlist)[i + 3]);
+	}
+}
+
+#ifdef CONFIG_DEBUG_FS
+int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused)
+{
+	struct drm_info_node *node = (struct drm_info_node *) m->private;
+	struct drm_device *dev = node->minor->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hvs_regs); i++) {
+		seq_printf(m, "%s (0x%04x): 0x%08x\n",
+			   hvs_regs[i].name, hvs_regs[i].reg,
+			   HVS_READ(hvs_regs[i].reg));
+	}
+
+	return 0;
+}
+#endif
+
+static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_device *drm = dev_get_drvdata(master);
+	struct vc4_dev *vc4 = drm->dev_private;
+	struct vc4_hvs *hvs = NULL;
+
+	hvs = devm_kzalloc(&pdev->dev, sizeof(*hvs), GFP_KERNEL);
+	if (!hvs)
+		return -ENOMEM;
+
+	hvs->pdev = pdev;
+
+	hvs->regs = vc4_ioremap_regs(pdev, 0);
+	if (IS_ERR(hvs->regs))
+		return PTR_ERR(hvs->regs);
+
+	hvs->dlist = hvs->regs + SCALER_DLIST_START;
+
+	vc4->hvs = hvs;
+	return 0;
+}
+
+static void vc4_hvs_unbind(struct device *dev, struct device *master,
+			   void *data)
+{
+	struct drm_device *drm = dev_get_drvdata(master);
+	struct vc4_dev *vc4 = drm->dev_private;
+
+	vc4->hvs = NULL;
+}
+
+static const struct component_ops vc4_hvs_ops = {
+	.bind   = vc4_hvs_bind,
+	.unbind = vc4_hvs_unbind,
+};
+
+static int vc4_hvs_dev_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &vc4_hvs_ops);
+}
+
+static int vc4_hvs_dev_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &vc4_hvs_ops);
+	return 0;
+}
+
+static const struct of_device_id vc4_hvs_dt_match[] = {
+	{ .compatible = "brcm,vc4-hvs" },
+	{}
+};
+
+static struct platform_driver vc4_hvs_driver = {
+	.probe = vc4_hvs_dev_probe,
+	.remove = vc4_hvs_dev_remove,
+	.driver = {
+		.name = "vc4_hvs",
+		.of_match_table = vc4_hvs_dt_match,
+	},
+};
+
+void __init vc4_hvs_register(void)
+{
+	platform_driver_register(&vc4_hvs_driver);
+}
+
+void __exit vc4_hvs_unregister(void)
+{
+	platform_driver_unregister(&vc4_hvs_driver);
+}
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
new file mode 100644
index 0000000..e5e96bc
--- /dev/null
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 2015 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/**
+ * DOC: VC4 KMS
+ *
+ * This is the general code for implementing KMS mode setting that
+ * doesn't clearly associate with any of the other objects (plane,
+ * crtc, HDMI encoder).
+ */
+
+#include "drm_crtc.h"
+#include "drm_atomic_helper.h"
+#include "drm_crtc_helper.h"
+#include "drm_plane_helper.h"
+#include "drm_fb_cma_helper.h"
+#include "vc4_drv.h"
+
+static const struct drm_mode_config_funcs vc4_mode_funcs = {
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+	.fb_create = drm_fb_cma_create,
+};
+
+/* Calls out to initialize all of the VC4 KMS objects. */
+static int vc4_init_modeset_objects(struct drm_device *dev)
+{
+	struct drm_encoder *encoder;
+	struct drm_connector *connector;
+	int ret = 0;
+
+	encoder = vc4_hdmi_encoder_init(dev);
+	if (IS_ERR(encoder)) {
+		dev_err(dev->dev, "failed to construct HDMI encoder\n");
+		ret = PTR_ERR(encoder);
+		goto fail;
+	}
+
+	connector = vc4_hdmi_connector_init(dev, encoder);
+	if (IS_ERR(connector)) {
+		ret = PTR_ERR(connector);
+		dev_err(dev->dev, "failed to initialize HDMI connector\n");
+		goto fail;
+	}
+
+fail:
+	return ret;
+}
+
+int vc4_kms_load(struct drm_device *dev)
+{
+	int ret;
+
+	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
+	if (ret < 0) {
+		dev_err(dev->dev, "failed to initialize vblank\n");
+		return ret;
+	}
+
+	dev->mode_config.max_width = 2048;
+	dev->mode_config.max_height = 2048;
+	dev->mode_config.funcs = &vc4_mode_funcs;
+	dev->mode_config.preferred_depth = 24;
+
+	ret = vc4_init_modeset_objects(dev);
+	if (ret)
+		goto fail;
+
+	drm_mode_config_reset(dev);
+
+	drm_fbdev_cma_init(dev, 32,
+			   dev->mode_config.num_crtc,
+			   dev->mode_config.num_connector);
+
+	drm_kms_helper_poll_init(dev);
+
+fail:
+	return ret;
+}
diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
new file mode 100644
index 0000000..cdd8b10
--- /dev/null
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -0,0 +1,320 @@
+/*
+ * Copyright (C) 2015 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/**
+ * DOC: VC4 plane module
+ *
+ * Each DRM plane is a layer of pixels being scanned out by the HVS.
+ *
+ * At atomic modeset check time, we compute the HVS display element
+ * state that would be necessary for displaying the plane (giving us a
+ * chance to figure out if a plane configuration is invalid), then at
+ * atomic flush time the CRTC will ask us to write our element state
+ * into the region of the HVS that it has allocated for us.
+ */
+
+#include "vc4_drv.h"
+#include "vc4_regs.h"
+#include "drm_atomic_helper.h"
+#include "drm_fb_cma_helper.h"
+#include "drm_plane_helper.h"
+
+struct vc4_plane_state {
+	struct drm_plane_state base;
+	u32 *dlist;
+	u32 dlist_size; /* Number of dwords in allocated for the display list */
+	u32 dlist_count; /* Number of used dwords in the display list. */
+};
+
+static inline struct vc4_plane_state *
+to_vc4_plane_state(struct drm_plane_state *state)
+{
+	return (struct vc4_plane_state *)state;
+}
+
+static const struct hvs_format {
+	u32 drm; /* DRM_FORMAT_* */
+	u32 hvs; /* HVS_FORMAT_* */
+	u32 pixel_order;
+	bool has_alpha;
+} hvs_formats[] = {
+	{
+		.drm = DRM_FORMAT_XRGB8888, .hvs = HVS_PIXEL_FORMAT_RGBA8888,
+		.pixel_order = HVS_PIXEL_ORDER_ABGR, .has_alpha = false,
+	},
+	{
+		.drm = DRM_FORMAT_ARGB8888, .hvs = HVS_PIXEL_FORMAT_RGBA8888,
+		.pixel_order = HVS_PIXEL_ORDER_ABGR, .has_alpha = true,
+	},
+};
+
+static const struct hvs_format *vc4_get_hvs_format(u32 drm_format)
+{
+	unsigned i;
+
+	for (i = 0; i < ARRAY_SIZE(hvs_formats); i++) {
+		if (hvs_formats[i].drm == drm_format)
+			return &hvs_formats[i];
+	}
+
+	return NULL;
+}
+
+static bool plane_enabled(struct drm_plane_state *state)
+{
+	return state->fb && state->crtc;
+}
+
+struct drm_plane_state *vc4_plane_duplicate_state(struct drm_plane *plane)
+{
+	struct vc4_plane_state *vc4_state;
+
+	if (WARN_ON(!plane->state))
+		return NULL;
+
+	vc4_state = kmemdup(plane->state, sizeof(*vc4_state), GFP_KERNEL);
+	if (!vc4_state)
+		return NULL;
+
+	__drm_atomic_helper_plane_duplicate_state(plane, &vc4_state->base);
+
+	if (vc4_state->dlist) {
+		vc4_state->dlist = kmemdup(vc4_state->dlist,
+					   vc4_state->dlist_count * 4,
+					   GFP_KERNEL);
+		if (!vc4_state->dlist) {
+			kfree(vc4_state);
+			return NULL;
+		}
+		vc4_state->dlist_size = vc4_state->dlist_count;
+	}
+
+	return &vc4_state->base;
+}
+
+void vc4_plane_destroy_state(struct drm_plane *plane,
+			     struct drm_plane_state *state)
+{
+	struct vc4_plane_state *vc4_state = to_vc4_plane_state(state);
+
+	kfree(vc4_state->dlist);
+	__drm_atomic_helper_plane_destroy_state(plane, &vc4_state->base);
+	kfree(state);
+}
+
+/* Called during init to allocate the plane's atomic state. */
+void vc4_plane_reset(struct drm_plane *plane)
+{
+	struct vc4_plane_state *vc4_state;
+
+	WARN_ON(plane->state);
+
+	vc4_state = kzalloc(sizeof(*vc4_state), GFP_KERNEL);
+	if (!vc4_state)
+		return;
+
+	plane->state = &vc4_state->base;
+	vc4_state->base.plane = plane;
+}
+
+static void vc4_dlist_write(struct vc4_plane_state *vc4_state, u32 val)
+{
+	if (vc4_state->dlist_count == vc4_state->dlist_size) {
+		u32 new_size = max(4u, vc4_state->dlist_count * 2);
+		u32 *new_dlist = kmalloc(new_size * 4, GFP_KERNEL);
+
+		if (!new_dlist)
+			return;
+		memcpy(new_dlist, vc4_state->dlist, vc4_state->dlist_count * 4);
+
+		kfree(vc4_state->dlist);
+		vc4_state->dlist = new_dlist;
+		vc4_state->dlist_size = new_size;
+	}
+
+	vc4_state->dlist[vc4_state->dlist_count++] = val;
+}
+
+/* Writes out a full display list for an active plane to the plane's
+ * private dlist state.
+ */
+static int vc4_plane_mode_set(struct drm_plane *plane,
+			      struct drm_plane_state *state)
+{
+	struct vc4_plane_state *vc4_state = to_vc4_plane_state(state);
+	struct drm_framebuffer *fb = state->fb;
+	struct drm_gem_cma_object *bo = drm_fb_cma_get_gem_obj(fb, 0);
+	u32 ctl0_offset = vc4_state->dlist_count;
+	const struct hvs_format *format = vc4_get_hvs_format(fb->pixel_format);
+	uint32_t offset = fb->offsets[0];
+	int crtc_x = state->crtc_x;
+	int crtc_y = state->crtc_y;
+	int crtc_w = state->crtc_w;
+	int crtc_h = state->crtc_h;
+
+	if (crtc_x < 0) {
+		offset += drm_format_plane_cpp(fb->pixel_format, 0) * -crtc_x;
+		crtc_w += crtc_x;
+		crtc_x = 0;
+	}
+
+	if (crtc_y < 0) {
+		offset += fb->pitches[0] * -crtc_y;
+		crtc_h += crtc_y;
+		crtc_y = 0;
+	}
+
+	vc4_dlist_write(vc4_state,
+			SCALER_CTL0_VALID |
+			(format->pixel_order << SCALER_CTL0_ORDER_SHIFT) |
+			(format->hvs << SCALER_CTL0_PIXEL_FORMAT_SHIFT) |
+			SCALER_CTL0_UNITY);
+
+	/* Position Word 0: Image Positions and Alpha Value */
+	vc4_dlist_write(vc4_state,
+			VC4_SET_FIELD(0xff, SCALER_POS0_FIXED_ALPHA) |
+			VC4_SET_FIELD(crtc_x, SCALER_POS0_START_X) |
+			VC4_SET_FIELD(crtc_y, SCALER_POS0_START_Y));
+
+	/* Position Word 1: Scaled Image Dimensions.
+	 * Skipped due to SCALER_CTL0_UNITY scaling.
+	 */
+
+	/* Position Word 2: Source Image Size, Alpha Mode */
+	vc4_dlist_write(vc4_state,
+			VC4_SET_FIELD(format->has_alpha ?
+				      SCALER_POS2_ALPHA_MODE_PIPELINE :
+				      SCALER_POS2_ALPHA_MODE_FIXED,
+				      SCALER_POS2_ALPHA_MODE) |
+			VC4_SET_FIELD(crtc_w, SCALER_POS2_WIDTH) |
+			VC4_SET_FIELD(crtc_h, SCALER_POS2_HEIGHT));
+
+	/* Position Word 3: Context.  Written by the HVS. */
+	vc4_dlist_write(vc4_state, 0xc0c0c0c0);
+
+	/* Pointer Word 0: RGB / Y Pointer */
+	vc4_dlist_write(vc4_state, bo->paddr + offset);
+
+	/* Pointer Context Word 0: Written by the HVS */
+	vc4_dlist_write(vc4_state, 0xc0c0c0c0);
+
+	/* Pitch word 0: Pointer 0 Pitch */
+	vc4_dlist_write(vc4_state,
+			VC4_SET_FIELD(fb->pitches[0], SCALER_SRC_PITCH));
+
+	vc4_state->dlist[ctl0_offset] |=
+		VC4_SET_FIELD(vc4_state->dlist_count, SCALER_CTL0_SIZE);
+
+	return 0;
+}
+
+/* If a modeset involves changing the setup of a plane, the atomic
+ * infrastructure will call this to validate a proposed plane setup.
+ * However, if a plane isn't getting updated, this (and the
+ * corresponding vc4_plane_atomic_update) won't get called.  Thus, we
+ * compute the dlist here and have all active plane dlists get updated
+ * in the CRTC's flush.
+ */
+static int vc4_plane_atomic_check(struct drm_plane *plane,
+				  struct drm_plane_state *state)
+{
+	struct vc4_plane_state *vc4_state = to_vc4_plane_state(state);
+
+	vc4_state->dlist_count = 0;
+
+	if (plane_enabled(state))
+		return vc4_plane_mode_set(plane, state);
+	else
+		return 0;
+}
+
+static void vc4_plane_atomic_update(struct drm_plane *plane,
+				    struct drm_plane_state *old_state)
+{
+	/* No contents here.  Since we don't know where in the CRTC's
+	 * dlist we should be stored, our dlist is uploaded to the
+	 * hardware with vc4_plane_write_dlist() at CRTC atomic_flush
+	 * time.
+	 */
+}
+
+u32 vc4_plane_write_dlist(struct drm_plane *plane, u32 __iomem *dlist)
+{
+	struct vc4_plane_state *vc4_state = to_vc4_plane_state(plane->state);
+	int i;
+
+	/* Can't memcpy_toio() because it needs to be 32-bit writes. */
+	for (i = 0; i < vc4_state->dlist_count; i++)
+		writel(vc4_state->dlist[i], &dlist[i]);
+
+	return vc4_state->dlist_count;
+}
+
+u32 vc4_plane_dlist_size(struct drm_plane_state *state)
+{
+	struct vc4_plane_state *vc4_state = to_vc4_plane_state(state);
+
+	return vc4_state->dlist_count;
+}
+
+static const struct drm_plane_helper_funcs vc4_plane_helper_funcs = {
+	.prepare_fb = NULL,
+	.cleanup_fb = NULL,
+	.atomic_check = vc4_plane_atomic_check,
+	.atomic_update = vc4_plane_atomic_update,
+};
+
+static void vc4_plane_destroy(struct drm_plane *plane)
+{
+	drm_plane_helper_disable(plane);
+	drm_plane_cleanup(plane);
+}
+
+static const struct drm_plane_funcs vc4_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = vc4_plane_destroy,
+	.set_property = NULL,
+	.reset = vc4_plane_reset,
+	.atomic_duplicate_state = vc4_plane_duplicate_state,
+	.atomic_destroy_state = vc4_plane_destroy_state,
+};
+
+struct drm_plane *vc4_plane_init(struct drm_device *dev,
+				 enum drm_plane_type type)
+{
+	struct drm_plane *plane = NULL;
+	struct vc4_plane *vc4_plane;
+	u32 formats[ARRAY_SIZE(hvs_formats)];
+	int ret = 0;
+	unsigned i;
+
+	vc4_plane = devm_kzalloc(dev->dev, sizeof(*vc4_plane),
+				 GFP_KERNEL);
+	if (!vc4_plane) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(hvs_formats); i++)
+		formats[i] = hvs_formats[i].drm;
+	plane = &vc4_plane->base;
+	ret = drm_universal_plane_init(dev, plane, 0xff,
+				       &vc4_plane_funcs,
+				       formats, ARRAY_SIZE(formats),
+				       type);
+
+	drm_plane_helper_add(plane, &vc4_plane_helper_funcs);
+
+	return plane;
+fail:
+	if (plane)
+		vc4_plane_destroy(plane);
+
+	return ERR_PTR(ret);
+}
diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
new file mode 100644
index 0000000..0eff631
--- /dev/null
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -0,0 +1,562 @@
+/*
+ *  Copyright ? 2014-2015 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define VC4_MASK(high, low) (((1 << ((high) - (low) + 1)) - 1) << (low))
+/* Using the GNU statement expression extension */
+#define VC4_SET_FIELD(value, field)					\
+	({								\
+		uint32_t fieldval = (value) << field##_SHIFT;		\
+		WARN_ON((fieldval & ~field##_MASK) != 0);		\
+		fieldval & field##_MASK;				\
+	 })
+
+#define VC4_GET_FIELD(word, field) (((word) & field##_MASK) >>		\
+				    field##_SHIFT)
+
+#define V3D_IDENT0   0x00000
+# define V3D_EXPECTED_IDENT0 \
+	((2 << 24) | \
+	('V' << 0) | \
+	('3' << 8) | \
+	 ('D' << 16))
+
+#define V3D_IDENT1   0x00004
+/* Multiples of 1kb */
+# define V3D_IDENT1_VPM_SIZE_MASK                      VC4_MASK(31, 28)
+# define V3D_IDENT1_VPM_SIZE_SHIFT                     28
+# define V3D_IDENT1_NSEM_MASK                          VC4_MASK(23, 16)
+# define V3D_IDENT1_NSEM_SHIFT                         16
+# define V3D_IDENT1_TUPS_MASK                          VC4_MASK(15, 12)
+# define V3D_IDENT1_TUPS_SHIFT                         12
+# define V3D_IDENT1_QUPS_MASK                          VC4_MASK(11, 8)
+# define V3D_IDENT1_QUPS_SHIFT                         8
+# define V3D_IDENT1_NSLC_MASK                          VC4_MASK(7, 4)
+# define V3D_IDENT1_NSLC_SHIFT                         4
+# define V3D_IDENT1_REV_MASK                           VC4_MASK(3, 0)
+# define V3D_IDENT1_REV_SHIFT                          0
+
+#define V3D_IDENT2   0x00008
+#define V3D_SCRATCH  0x00010
+#define V3D_L2CACTL  0x00020
+# define V3D_L2CACTL_L2CCLR                            (1 << 2)
+# define V3D_L2CACTL_L2CDIS                            (1 << 1)
+# define V3D_L2CACTL_L2CENA                            (1 << 0)
+
+#define V3D_SLCACTL  0x00024
+# define V3D_SLCACTL_T1CC_MASK                         VC4_MASK(27, 24)
+# define V3D_SLCACTL_T1CC_SHIFT                        24
+# define V3D_SLCACTL_T0CC_MASK                         VC4_MASK(19, 16)
+# define V3D_SLCACTL_T0CC_SHIFT                        16
+# define V3D_SLCACTL_UCC_MASK                          VC4_MASK(11, 8)
+# define V3D_SLCACTL_UCC_SHIFT                         8
+# define V3D_SLCACTL_ICC_MASK                          VC4_MASK(3, 0)
+# define V3D_SLCACTL_ICC_SHIFT                         0
+
+#define V3D_INTCTL   0x00030
+#define V3D_INTENA   0x00034
+#define V3D_INTDIS   0x00038
+# define V3D_INT_SPILLUSE                              (1 << 3)
+# define V3D_INT_OUTOMEM                               (1 << 2)
+# define V3D_INT_FLDONE                                (1 << 1)
+# define V3D_INT_FRDONE                                (1 << 0)
+
+#define V3D_CT0CS    0x00100
+#define V3D_CT1CS    0x00104
+#define V3D_CTNCS(n) (V3D_CT0CS + 4 * n)
+# define V3D_CTRSTA      (1 << 15)
+# define V3D_CTSEMA      (1 << 12)
+# define V3D_CTRTSD      (1 << 8)
+# define V3D_CTRUN       (1 << 5)
+# define V3D_CTSUBS      (1 << 4)
+# define V3D_CTERR       (1 << 3)
+# define V3D_CTMODE      (1 << 0)
+
+#define V3D_CT0EA    0x00108
+#define V3D_CT1EA    0x0010c
+#define V3D_CTNEA(n) (V3D_CT0EA + 4 * (n))
+#define V3D_CT0CA    0x00110
+#define V3D_CT1CA    0x00114
+#define V3D_CTNCA(n) (V3D_CT0CA + 4 * (n))
+#define V3D_CT00RA0  0x00118
+#define V3D_CT01RA0  0x0011c
+#define V3D_CTNRA0(n) (V3D_CT00RA0 + 4 * (n))
+#define V3D_CT0LC    0x00120
+#define V3D_CT1LC    0x00124
+#define V3D_CTNLC(n) (V3D_CT0LC + 4 * (n))
+#define V3D_CT0PC    0x00128
+#define V3D_CT1PC    0x0012c
+#define V3D_CTNPC(n) (V3D_CT0PC + 4 * (n))
+
+#define V3D_PCS      0x00130
+# define V3D_BMOOM       (1 << 8)
+# define V3D_RMBUSY      (1 << 3)
+# define V3D_RMACTIVE    (1 << 2)
+# define V3D_BMBUSY      (1 << 1)
+# define V3D_BMACTIVE    (1 << 0)
+
+#define V3D_BFC      0x00134
+#define V3D_RFC      0x00138
+#define V3D_BPCA     0x00300
+#define V3D_BPCS     0x00304
+#define V3D_BPOA     0x00308
+#define V3D_BPOS     0x0030c
+#define V3D_BXCF     0x00310
+#define V3D_SQRSV0   0x00410
+#define V3D_SQRSV1   0x00414
+#define V3D_SQCNTL   0x00418
+#define V3D_SRQPC    0x00430
+#define V3D_SRQUA    0x00434
+#define V3D_SRQUL    0x00438
+#define V3D_SRQCS    0x0043c
+#define V3D_VPACNTL  0x00500
+#define V3D_VPMBASE  0x00504
+#define V3D_PCTRC    0x00670
+#define V3D_PCTRE    0x00674
+#define V3D_PCTR0    0x00680
+#define V3D_PCTRS0   0x00684
+#define V3D_PCTR1    0x00688
+#define V3D_PCTRS1   0x0068c
+#define V3D_PCTR2    0x00690
+#define V3D_PCTRS2   0x00694
+#define V3D_PCTR3    0x00698
+#define V3D_PCTRS3   0x0069c
+#define V3D_PCTR4    0x006a0
+#define V3D_PCTRS4   0x006a4
+#define V3D_PCTR5    0x006a8
+#define V3D_PCTRS5   0x006ac
+#define V3D_PCTR6    0x006b0
+#define V3D_PCTRS6   0x006b4
+#define V3D_PCTR7    0x006b8
+#define V3D_PCTRS7   0x006bc
+#define V3D_PCTR8    0x006c0
+#define V3D_PCTRS8   0x006c4
+#define V3D_PCTR9    0x006c8
+#define V3D_PCTRS9   0x006cc
+#define V3D_PCTR10   0x006d0
+#define V3D_PCTRS10  0x006d4
+#define V3D_PCTR11   0x006d8
+#define V3D_PCTRS11  0x006dc
+#define V3D_PCTR12   0x006e0
+#define V3D_PCTRS12  0x006e4
+#define V3D_PCTR13   0x006e8
+#define V3D_PCTRS13  0x006ec
+#define V3D_PCTR14   0x006f0
+#define V3D_PCTRS14  0x006f4
+#define V3D_PCTR15   0x006f8
+#define V3D_PCTRS15  0x006fc
+#define V3D_BGE      0x00f00
+#define V3D_FDBGO    0x00f04
+#define V3D_FDBGB    0x00f08
+#define V3D_FDBGR    0x00f0c
+#define V3D_FDBGS    0x00f10
+#define V3D_ERRSTAT  0x00f20
+
+#define PV_CONTROL				0x00
+# define PV_CONTROL_FORMAT_MASK			VC4_MASK(23, 21)
+# define PV_CONTROL_FORMAT_SHIFT		21
+# define PV_CONTROL_FORMAT_24			0
+# define PV_CONTROL_FORMAT_DSIV_16		1
+# define PV_CONTROL_FORMAT_DSIC_16		2
+# define PV_CONTROL_FORMAT_DSIV_18		3
+# define PV_CONTROL_FORMAT_DSIV_24		4
+
+# define PV_CONTROL_FIFO_LEVEL_MASK		VC4_MASK(20, 15)
+# define PV_CONTROL_FIFO_LEVEL_SHIFT		15
+# define PV_CONTROL_CLR_AT_START		(1 << 14)
+# define PV_CONTROL_TRIGGER_UNDERFLOW		(1 << 13)
+# define PV_CONTROL_WAIT_HSTART			(1 << 12)
+# define PV_CONTROL_CLK_SELECT_DSI		0
+# define PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI	1
+# define PV_CONTROL_CLK_SELECT_MASK		VC4_MASK(3, 2)
+# define PV_CONTROL_CLK_SELECT_SHIFT		2
+# define PV_CONTROL_FIFO_CLR			(1 << 1)
+# define PV_CONTROL_EN				(1 << 0)
+
+#define PV_V_CONTROL				0x04
+# define PV_VCONTROL_CONTINUOUS			(1 << 1)
+# define PV_VCONTROL_VIDEN			(1 << 0)
+
+#define PV_VSYNCD				0x08
+
+#define PV_HORZA				0x0c
+# define PV_HORZA_HBP_MASK			VC4_MASK(31, 16)
+# define PV_HORZA_HBP_SHIFT			16
+# define PV_HORZA_HSYNC_MASK			VC4_MASK(15, 0)
+# define PV_HORZA_HSYNC_SHIFT			0
+
+#define PV_HORZB				0x10
+# define PV_HORZB_HFP_MASK			VC4_MASK(31, 16)
+# define PV_HORZB_HFP_SHIFT			16
+# define PV_HORZB_HACTIVE_MASK			VC4_MASK(15, 0)
+# define PV_HORZB_HACTIVE_SHIFT			0
+
+#define PV_VERTA				0x14
+# define PV_VERTA_VBP_MASK			VC4_MASK(31, 16)
+# define PV_VERTA_VBP_SHIFT			16
+# define PV_VERTA_VSYNC_MASK			VC4_MASK(15, 0)
+# define PV_VERTA_VSYNC_SHIFT			0
+
+#define PV_VERTB				0x18
+# define PV_VERTB_VFP_MASK			VC4_MASK(31, 16)
+# define PV_VERTB_VFP_SHIFT			16
+# define PV_VERTB_VACTIVE_MASK			VC4_MASK(15, 0)
+# define PV_VERTB_VACTIVE_SHIFT			0
+
+#define PV_VERTA_EVEN				0x1c
+#define PV_VERTB_EVEN				0x20
+
+#define PV_INTEN				0x24
+#define PV_INTSTAT				0x28
+# define PV_INT_VID_IDLE			(1 << 9)
+# define PV_INT_VFP_END				(1 << 8)
+# define PV_INT_VFP_START			(1 << 7)
+# define PV_INT_VACT_START			(1 << 6)
+# define PV_INT_VBP_START			(1 << 5)
+# define PV_INT_VSYNC_START			(1 << 4)
+# define PV_INT_HFP_START			(1 << 3)
+# define PV_INT_HACT_START			(1 << 2)
+# define PV_INT_HBP_START			(1 << 1)
+# define PV_INT_HSYNC_START			(1 << 0)
+
+#define PV_STAT					0x2c
+
+#define PV_HACT_ACT				0x30
+
+#define SCALER_DISPCTRL                         0x00000000
+/* Global register for clock gating the HVS */
+# define SCALER_DISPCTRL_ENABLE			(1 << 31)
+# define SCALER_DISPCTRL_DSP2EISLUR		(1 << 15)
+# define SCALER_DISPCTRL_DSP1EISLUR		(1 << 14)
+/* Enables Display 0 short line and underrun contribution to
+ * SCALER_DISPSTAT_IRQDISP0.  Note that short frame contributions are
+ * always enabled.
+ */
+# define SCALER_DISPCTRL_DSP0EISLUR		(1 << 13)
+# define SCALER_DISPCTRL_DSP2EIEOLN		(1 << 12)
+# define SCALER_DISPCTRL_DSP2EIEOF		(1 << 11)
+# define SCALER_DISPCTRL_DSP1EIEOLN		(1 << 10)
+# define SCALER_DISPCTRL_DSP1EIEOF		(1 << 9)
+/* Enables Display 0 end-of-line-N contribution to
+ * SCALER_DISPSTAT_IRQDISP0
+ */
+# define SCALER_DISPCTRL_DSP0EIEOLN		(1 << 8)
+/* Enables Display 0 EOF contribution to SCALER_DISPSTAT_IRQDISP0 */
+# define SCALER_DISPCTRL_DSP0EIEOF		(1 << 7)
+
+# define SCALER_DISPCTRL_SLVRDEIRQ		(1 << 6)
+# define SCALER_DISPCTRL_SLVWREIRQ		(1 << 5)
+# define SCALER_DISPCTRL_DMAEIRQ		(1 << 4)
+# define SCALER_DISPCTRL_DISP2EIRQ		(1 << 3)
+# define SCALER_DISPCTRL_DISP1EIRQ		(1 << 2)
+/* Enables interrupt generation on the enabled EOF/EOLN/EISLUR
+ * bits and short frames..
+ */
+# define SCALER_DISPCTRL_DISP0EIRQ		(1 << 1)
+/* Enables interrupt generation on scaler profiler interrupt. */
+# define SCALER_DISPCTRL_SCLEIRQ		(1 << 0)
+
+#define SCALER_DISPSTAT                         0x00000004
+# define SCALER_DISPSTAT_COBLOW2		(1 << 29)
+# define SCALER_DISPSTAT_EOLN2			(1 << 28)
+# define SCALER_DISPSTAT_ESFRAME2		(1 << 27)
+# define SCALER_DISPSTAT_ESLINE2		(1 << 26)
+# define SCALER_DISPSTAT_EUFLOW2		(1 << 25)
+# define SCALER_DISPSTAT_EOF2			(1 << 24)
+
+# define SCALER_DISPSTAT_COBLOW1		(1 << 21)
+# define SCALER_DISPSTAT_EOLN1			(1 << 20)
+# define SCALER_DISPSTAT_ESFRAME1		(1 << 19)
+# define SCALER_DISPSTAT_ESLINE1		(1 << 18)
+# define SCALER_DISPSTAT_EUFLOW1		(1 << 17)
+# define SCALER_DISPSTAT_EOF1			(1 << 16)
+
+# define SCALER_DISPSTAT_RESP_MASK		VC4_MASK(15, 14)
+# define SCALER_DISPSTAT_RESP_SHIFT		14
+# define SCALER_DISPSTAT_RESP_OKAY		0
+# define SCALER_DISPSTAT_RESP_EXOKAY		1
+# define SCALER_DISPSTAT_RESP_SLVERR		2
+# define SCALER_DISPSTAT_RESP_DECERR		3
+
+# define SCALER_DISPSTAT_COBLOW0		(1 << 13)
+/* Set when the DISPEOLN line is done compositing. */
+# define SCALER_DISPSTAT_EOLN0			(1 << 12)
+/* Set when VSTART is seen but there are still pixels in the current
+ * output line.
+ */
+# define SCALER_DISPSTAT_ESFRAME0		(1 << 11)
+/* Set when HSTART is seen but there are still pixels in the current
+ * output line.
+ */
+# define SCALER_DISPSTAT_ESLINE0		(1 << 10)
+/* Set when the the downstream tries to read from the display FIFO
+ * while it's empty.
+ */
+# define SCALER_DISPSTAT_EUFLOW0		(1 << 9)
+/* Set when the display mode changes from RUN to EOF */
+# define SCALER_DISPSTAT_EOF0			(1 << 8)
+
+/* Set on AXI invalid DMA ID error. */
+# define SCALER_DISPSTAT_DMA_ERROR		(1 << 7)
+/* Set on AXI slave read decode error */
+# define SCALER_DISPSTAT_IRQSLVRD		(1 << 6)
+/* Set on AXI slave write decode error */
+# define SCALER_DISPSTAT_IRQSLVWR		(1 << 5)
+/* Set when SCALER_DISPSTAT_DMA_ERROR is set, or
+ * SCALER_DISPSTAT_RESP_ERROR is not SCALER_DISPSTAT_RESP_OKAY.
+ */
+# define SCALER_DISPSTAT_IRQDMA			(1 << 4)
+# define SCALER_DISPSTAT_IRQDISP2		(1 << 3)
+# define SCALER_DISPSTAT_IRQDISP1		(1 << 2)
+/* Set when any of the EOF/EOLN/ESFRAME/ESLINE bits are set and their
+ * corresponding interrupt bit is enabled in DISPCTRL.
+ */
+# define SCALER_DISPSTAT_IRQDISP0		(1 << 1)
+/* On read, the profiler interrupt.  On write, clear *all* interrupt bits. */
+# define SCALER_DISPSTAT_IRQSCL			(1 << 0)
+
+#define SCALER_DISPID                           0x00000008
+#define SCALER_DISPECTRL                        0x0000000c
+#define SCALER_DISPPROF                         0x00000010
+#define SCALER_DISPDITHER                       0x00000014
+#define SCALER_DISPEOLN                         0x00000018
+#define SCALER_DISPLIST0                        0x00000020
+#define SCALER_DISPLIST1                        0x00000024
+#define SCALER_DISPLIST2                        0x00000028
+#define SCALER_DISPLSTAT                        0x0000002c
+#define SCALER_DISPLISTX(x)			(SCALER_DISPLIST0 +	\
+						 (x) * (SCALER_DISPLIST1 - \
+							SCALER_DISPLIST0))
+
+#define SCALER_DISPLACT0                        0x00000030
+#define SCALER_DISPLACT1                        0x00000034
+#define SCALER_DISPLACT2                        0x00000038
+#define SCALER_DISPCTRL0                        0x00000040
+# define SCALER_DISPCTRLX_ENABLE		(1 << 31)
+# define SCALER_DISPCTRLX_RESET			(1 << 30)
+# define SCALER_DISPCTRLX_WIDTH_MASK		VC4_MASK(23, 12)
+# define SCALER_DISPCTRLX_WIDTH_SHIFT		12
+# define SCALER_DISPCTRLX_HEIGHT_MASK		VC4_MASK(11, 0)
+# define SCALER_DISPCTRLX_HEIGHT_SHIFT		0
+
+#define SCALER_DISPBKGND0                       0x00000044
+#define SCALER_DISPSTAT0                        0x00000048
+#define SCALER_DISPBASE0                        0x0000004c
+# define SCALER_DISPSTATX_MODE_MASK		VC4_MASK(31, 30)
+# define SCALER_DISPSTATX_MODE_SHIFT		30
+# define SCALER_DISPSTATX_MODE_DISABLED		0
+# define SCALER_DISPSTATX_MODE_INIT		1
+# define SCALER_DISPSTATX_MODE_RUN		2
+# define SCALER_DISPSTATX_MODE_EOF		3
+# define SCALER_DISPSTATX_FULL			(1 << 29)
+# define SCALER_DISPSTATX_EMPTY			(1 << 28)
+#define SCALER_DISPCTRL1                        0x00000050
+#define SCALER_DISPBKGND1                       0x00000054
+#define SCALER_DISPSTAT1                        0x00000058
+#define SCALER_DISPSTATX(x)			(SCALER_DISPSTAT0 +        \
+						 (x) * (SCALER_DISPSTAT1 - \
+							SCALER_DISPSTAT0))
+#define SCALER_DISPBASE1                        0x0000005c
+#define SCALER_DISPCTRL2                        0x00000060
+#define SCALER_DISPCTRLX(x)			(SCALER_DISPCTRL0 +        \
+						 (x) * (SCALER_DISPCTRL1 - \
+							SCALER_DISPCTRL0))
+#define SCALER_DISPBKGND2                       0x00000064
+#define SCALER_DISPSTAT2                        0x00000068
+#define SCALER_DISPBASE2                        0x0000006c
+#define SCALER_DISPALPHA2                       0x00000070
+#define SCALER_GAMADDR                          0x00000078
+#define SCALER_GAMDATA                          0x000000e0
+#define SCALER_DLIST_START                      0x00002000
+#define SCALER_DLIST_SIZE                       0x00004000
+
+#define VC4_HDMI_CORE_REV			0x000
+
+#define VC4_HDMI_SW_RESET_CONTROL		0x004
+# define VC4_HDMI_SW_RESET_FORMAT_DETECT	(1 << 1)
+# define VC4_HDMI_SW_RESET_HDMI			(1 << 0)
+
+#define VC4_HDMI_HOTPLUG_INT			0x008
+
+#define VC4_HDMI_HOTPLUG			0x00c
+# define VC4_HDMI_HOTPLUG_CONNECTED		(1 << 0)
+
+#define VC4_HDMI_RAM_PACKET_CONFIG		0x0a0
+# define VC4_HDMI_RAM_PACKET_ENABLE		(1 << 16)
+
+#define VC4_HDMI_HORZA				0x0c4
+# define VC4_HDMI_HORZA_VPOS			(1 << 14)
+# define VC4_HDMI_HORZA_HPOS			(1 << 13)
+/* Horizontal active pixels (hdisplay). */
+# define VC4_HDMI_HORZA_HAP_MASK		VC4_MASK(12, 0)
+# define VC4_HDMI_HORZA_HAP_SHIFT		0
+
+#define VC4_HDMI_HORZB				0x0c8
+/* Horizontal pack porch (htotal - hsync_end). */
+# define VC4_HDMI_HORZB_HBP_MASK		VC4_MASK(29, 20)
+# define VC4_HDMI_HORZB_HBP_SHIFT		20
+/* Horizontal sync pulse (hsync_end - hsync_start). */
+# define VC4_HDMI_HORZB_HSP_MASK		VC4_MASK(19, 10)
+# define VC4_HDMI_HORZB_HSP_SHIFT		10
+/* Horizontal front porch (hsync_start - hdisplay). */
+# define VC4_HDMI_HORZB_HFP_MASK		VC4_MASK(9, 0)
+# define VC4_HDMI_HORZB_HFP_SHIFT		0
+
+#define VC4_HDMI_FIFO_CTL			0x05c
+# define VC4_HDMI_FIFO_CTL_RECENTER_DONE	(1 << 14)
+# define VC4_HDMI_FIFO_CTL_USE_EMPTY		(1 << 13)
+# define VC4_HDMI_FIFO_CTL_ON_VB		(1 << 7)
+# define VC4_HDMI_FIFO_CTL_RECENTER		(1 << 6)
+# define VC4_HDMI_FIFO_CTL_FIFO_RESET		(1 << 5)
+# define VC4_HDMI_FIFO_CTL_USE_PLL_LOCK		(1 << 4)
+# define VC4_HDMI_FIFO_CTL_INV_CLK_XFR		(1 << 3)
+# define VC4_HDMI_FIFO_CTL_CAPTURE_PTR		(1 << 2)
+# define VC4_HDMI_FIFO_CTL_USE_FULL		(1 << 1)
+# define VC4_HDMI_FIFO_CTL_MASTER_SLAVE_N	(1 << 0)
+# define VC4_HDMI_FIFO_VALID_WRITE_MASK		0xefff
+
+#define VC4_HDMI_SCHEDULER_CONTROL		0x0c0
+# define VC4_HDMI_SCHEDULER_CONTROL_MANUAL_FORMAT (1 << 15)
+# define VC4_HDMI_SCHEDULER_CONTROL_IGNORE_VSYNC_PREDICTS (1 << 5)
+# define VC4_HDMI_SCHEDULER_CONTROL_VERT_ALWAYS_KEEPOUT	(1 << 3)
+# define VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE	(1 << 1)
+# define VC4_HDMI_SCHEDULER_CONTROL_MODE_HDMI	(1 << 0)
+
+#define VC4_HDMI_VERTA0				0x0cc
+#define VC4_HDMI_VERTA1				0x0d4
+/* Vertical sync pulse (vsync_end - vsync_start). */
+# define VC4_HDMI_VERTA_VSP_MASK		VC4_MASK(24, 20)
+# define VC4_HDMI_VERTA_VSP_SHIFT		20
+/* Vertical front porch (vsync_start - vdisplay). */
+# define VC4_HDMI_VERTA_VFP_MASK		VC4_MASK(19, 13)
+# define VC4_HDMI_VERTA_VFP_SHIFT		13
+/* Vertical active lines (vdisplay). */
+# define VC4_HDMI_VERTA_VAL_MASK		VC4_MASK(12, 0)
+# define VC4_HDMI_VERTA_VAL_SHIFT		0
+
+#define VC4_HDMI_VERTB0				0x0d0
+#define VC4_HDMI_VERTB1				0x0d8
+/* Vertical sync pulse offset (for interlaced) */
+# define VC4_HDMI_VERTB_VSPO_MASK		VC4_MASK(21, 9)
+# define VC4_HDMI_VERTB_VSPO_SHIFT		9
+/* Vertical pack porch (vtotal - vsync_end). */
+# define VC4_HDMI_VERTB_VBP_MASK		VC4_MASK(8, 0)
+# define VC4_HDMI_VERTB_VBP_SHIFT		0
+
+#define VC4_HDMI_TX_PHY_RESET_CTL		0x2c0
+
+#define VC4_HD_M_CTL				0x00c
+# define VC4_HD_M_SW_RST			(1 << 2)
+# define VC4_HD_M_ENABLE			(1 << 0)
+
+#define VC4_HD_MAI_CTL				0x014
+
+#define VC4_HD_VID_CTL				0x038
+# define VC4_HD_VID_CTL_ENABLE			(1 << 31)
+# define VC4_HD_VID_CTL_UNDERFLOW_ENABLE	(1 << 30)
+# define VC4_HD_VID_CTL_FRAME_COUNTER_RESET	(1 << 29)
+# define VC4_HD_VID_CTL_VSYNC_LOW		(1 << 28)
+# define VC4_HD_VID_CTL_HSYNC_LOW		(1 << 27)
+
+#define VC4_HD_CSC_CTL				0x040
+# define VC4_HD_CSC_CTL_ORDER_MASK		VC4_MASK(7, 5)
+# define VC4_HD_CSC_CTL_ORDER_SHIFT		5
+# define VC4_HD_CSC_CTL_ORDER_RGB		0
+# define VC4_HD_CSC_CTL_ORDER_BGR		1
+# define VC4_HD_CSC_CTL_ORDER_BRG		2
+# define VC4_HD_CSC_CTL_ORDER_GRB		3
+# define VC4_HD_CSC_CTL_ORDER_GBR		4
+# define VC4_HD_CSC_CTL_ORDER_RBG		5
+# define VC4_HD_CSC_CTL_PADMSB			(1 << 4)
+# define VC4_HD_CSC_CTL_MODE_MASK		VC4_MASK(3, 2)
+# define VC4_HD_CSC_CTL_MODE_SHIFT		2
+# define VC4_HD_CSC_CTL_MODE_RGB_TO_SD_YPRPB	0
+# define VC4_HD_CSC_CTL_MODE_RGB_TO_HD_YPRPB	1
+# define VC4_HD_CSC_CTL_MODE_CUSTOM		2
+# define VC4_HD_CSC_CTL_RGB2YCC			(1 << 1)
+# define VC4_HD_CSC_CTL_ENABLE			(1 << 0)
+
+#define VC4_HD_FRAME_COUNT			0x068
+
+/* HVS display list information. */
+#define HVS_BOOTLOADER_DLIST_END                32
+
+enum hvs_pixel_format {
+	/* 8bpp */
+	HVS_PIXEL_FORMAT_RGB332 = 0,
+	/* 16bpp */
+	HVS_PIXEL_FORMAT_RGBA4444 = 1,
+	HVS_PIXEL_FORMAT_RGB555 = 2,
+	HVS_PIXEL_FORMAT_RGBA5551 = 3,
+	HVS_PIXEL_FORMAT_RGB565 = 4,
+	/* 24bpp */
+	HVS_PIXEL_FORMAT_RGB888 = 5,
+	HVS_PIXEL_FORMAT_RGBA6666 = 6,
+	/* 32bpp */
+	HVS_PIXEL_FORMAT_RGBA8888 = 7
+};
+
+/* Note: the LSB is the rightmost character shown.  Only valid for
+ * HVS_PIXEL_FORMAT_RGB8888, not RGB888.
+ */
+#define HVS_PIXEL_ORDER_RGBA			0
+#define HVS_PIXEL_ORDER_BGRA			1
+#define HVS_PIXEL_ORDER_ARGB			2
+#define HVS_PIXEL_ORDER_ABGR			3
+
+#define HVS_PIXEL_ORDER_XBRG			0
+#define HVS_PIXEL_ORDER_XRBG			1
+#define HVS_PIXEL_ORDER_XRGB			2
+#define HVS_PIXEL_ORDER_XBGR			3
+
+#define HVS_PIXEL_ORDER_XYCBCR			0
+#define HVS_PIXEL_ORDER_XYCRCB			1
+#define HVS_PIXEL_ORDER_YXCBCR			2
+#define HVS_PIXEL_ORDER_YXCRCB			3
+
+#define SCALER_CTL0_END				(1 << 31)
+#define SCALER_CTL0_VALID			(1 << 30)
+
+#define SCALER_CTL0_SIZE_MASK			VC4_MASK(29, 24)
+#define SCALER_CTL0_SIZE_SHIFT			24
+
+#define SCALER_CTL0_HFLIP                       (1 << 16)
+#define SCALER_CTL0_VFLIP                       (1 << 15)
+
+#define SCALER_CTL0_ORDER_MASK			VC4_MASK(14, 13)
+#define SCALER_CTL0_ORDER_SHIFT			13
+
+/* Set to indicate no scaling. */
+#define SCALER_CTL0_UNITY			(1 << 4)
+
+#define SCALER_CTL0_PIXEL_FORMAT_MASK		VC4_MASK(3, 0)
+#define SCALER_CTL0_PIXEL_FORMAT_SHIFT		0
+
+#define SCALER_POS0_FIXED_ALPHA_MASK		VC4_MASK(31, 24)
+#define SCALER_POS0_FIXED_ALPHA_SHIFT		24
+
+#define SCALER_POS0_START_Y_MASK		VC4_MASK(23, 12)
+#define SCALER_POS0_START_Y_SHIFT		12
+
+#define SCALER_POS0_START_X_MASK		VC4_MASK(11, 0)
+#define SCALER_POS0_START_X_SHIFT		0
+
+#define SCALER_POS2_ALPHA_MODE_MASK		VC4_MASK(31, 30)
+#define SCALER_POS2_ALPHA_MODE_SHIFT		30
+#define SCALER_POS2_ALPHA_MODE_PIPELINE		0
+#define SCALER_POS2_ALPHA_MODE_FIXED		1
+#define SCALER_POS2_ALPHA_MODE_FIXED_NONZERO	2
+#define SCALER_POS2_ALPHA_MODE_FIXED_OVER_0x07	3
+
+#define SCALER_POS2_HEIGHT_MASK			VC4_MASK(27, 16)
+#define SCALER_POS2_HEIGHT_SHIFT		16
+
+#define SCALER_POS2_WIDTH_MASK			VC4_MASK(11, 0)
+#define SCALER_POS2_WIDTH_SHIFT			0
+
+#define SCALER_SRC_PITCH_MASK			VC4_MASK(15, 0)
+#define SCALER_SRC_PITCH_SHIFT			0
-- 
2.1.4
