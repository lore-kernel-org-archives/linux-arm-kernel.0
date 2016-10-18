From: zourongrong@gmail.com (Rongrong Zou)
Date: Tue, 18 Oct 2016 12:01:20 +0800
Subject: [PATCH v4 5/9] drm/hisilicon/hibmc: Add crtc for DE
In-Reply-To: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
References: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
Message-ID: <1476763284-100508-6-git-send-email-zourongrong@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add crtc funcs and helper funcs for DE.

Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c  | 318 ++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c |   6 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |   2 +
 3 files changed, 326 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 36c4d24..2c9aef0 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -23,6 +23,7 @@
 
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
+#include "hibmc_drm_de.h"
 #include "hibmc_drm_power.h"
 
 /* ---------------------------------------------------------------------- */
@@ -169,3 +170,320 @@ int hibmc_plane_init(struct hibmc_drm_device *hidev)
 	return 0;
 }
 
+static void hibmc_crtc_enable(struct drm_crtc *crtc)
+{
+	unsigned int reg;
+	/* power mode 0 is default. */
+	struct hibmc_drm_device *hidev = crtc->dev->dev_private;
+
+	hibmc_set_power_mode(hidev, HIBMC_PW_MODE_CTL_MODE_MODE0);
+
+	/* Enable display power gate & LOCALMEM power gate*/
+	reg = readl(hidev->mmio + HIBMC_CURRENT_GATE);
+	reg &= ~HIBMC_CURR_GATE_LOCALMEM_MASK;
+	reg &= ~HIBMC_CURR_GATE_DISPLAY_MASK;
+	reg |= HIBMC_CURR_GATE_LOCALMEM(ON);
+	reg |= HIBMC_CURR_GATE_DISPLAY(ON);
+	hibmc_set_current_gate(hidev, reg);
+	drm_crtc_vblank_on(crtc);
+}
+
+static void hibmc_crtc_disable(struct drm_crtc *crtc)
+{
+	unsigned int reg;
+	struct hibmc_drm_device *hidev = crtc->dev->dev_private;
+
+	drm_crtc_vblank_off(crtc);
+
+	hibmc_set_power_mode(hidev, HIBMC_PW_MODE_CTL_MODE_SLEEP);
+
+	/* Enable display power gate & LOCALMEM power gate*/
+	reg = readl(hidev->mmio + HIBMC_CURRENT_GATE);
+	reg &= ~HIBMC_CURR_GATE_LOCALMEM_MASK;
+	reg &= ~HIBMC_CURR_GATE_DISPLAY_MASK;
+	reg |= HIBMC_CURR_GATE_LOCALMEM(OFF);
+	reg |= HIBMC_CURR_GATE_DISPLAY(OFF);
+	hibmc_set_current_gate(hidev, reg);
+}
+
+static int hibmc_crtc_atomic_check(struct drm_crtc *crtc,
+				   struct drm_crtc_state *state)
+{
+	return 0;
+}
+
+static unsigned int format_pll_reg(void)
+{
+	unsigned int pllreg = 0;
+	struct panel_pll pll = {0};
+
+	/* Note that all PLL's have the same format. Here,
+	 * we just use Panel PLL parameter to work out the bit
+	 * fields in the register.On returning a 32 bit number, the value can
+	 * be applied to any PLL in the calling function.
+	 */
+	pllreg |= HIBMC_PLL_CTRL_BYPASS(OFF) & HIBMC_PLL_CTRL_BYPASS_MASK;
+	pllreg |= HIBMC_PLL_CTRL_POWER(ON) & HIBMC_PLL_CTRL_POWER_MASK;
+	pllreg |= HIBMC_PLL_CTRL_INPUT(OSC) & HIBMC_PLL_CTRL_INPUT_MASK;
+	pllreg |= HIBMC_PLL_CTRL_POD(pll.POD) & HIBMC_PLL_CTRL_POD_MASK;
+	pllreg |= HIBMC_PLL_CTRL_OD(pll.OD) & HIBMC_PLL_CTRL_OD_MASK;
+	pllreg |= HIBMC_PLL_CTRL_N(pll.N) & HIBMC_PLL_CTRL_N_MASK;
+	pllreg |= HIBMC_PLL_CTRL_M(pll.M) & HIBMC_PLL_CTRL_M_MASK;
+
+	return pllreg;
+}
+
+static void set_vclock_hisilicon(struct drm_device *dev, unsigned long pll)
+{
+	unsigned long tmp0, tmp1;
+	struct hibmc_drm_device *hidev = dev->dev_private;
+
+	/* 1. outer_bypass_n=0 */
+	tmp0 = readl(hidev->mmio + CRT_PLL1_HS);
+	tmp0 &= 0xBFFFFFFF;
+	writel(tmp0, hidev->mmio + CRT_PLL1_HS);
+
+	/* 2. pll_pd=1?inter_bypass=1 */
+	writel(0x21000000, hidev->mmio + CRT_PLL1_HS);
+
+	/* 3. config pll */
+	writel(pll, hidev->mmio + CRT_PLL1_HS);
+
+	/* 4. delay  */
+	mdelay(1);
+
+	/* 5. pll_pd =0 */
+	tmp1 = pll & ~0x01000000;
+	writel(tmp1, hidev->mmio + CRT_PLL1_HS);
+
+	/* 6. delay  */
+	mdelay(1);
+
+	/* 7. inter_bypass=0 */
+	tmp1 &= ~0x20000000;
+	writel(tmp1, hidev->mmio + CRT_PLL1_HS);
+
+	/* 8. delay  */
+	mdelay(1);
+
+	/* 9. outer_bypass_n=1 */
+	tmp1 |= 0x40000000;
+	writel(tmp1, hidev->mmio + CRT_PLL1_HS);
+}
+
+/* This function takes care the extra registers and bit fields required to
+ *setup a mode in board.
+ *Explanation about Display Control register:
+ *FPGA only supports 7 predefined pixel clocks, and clock select is
+ *in bit 4:0 of new register 0x802a8.
+ */
+static unsigned int display_ctrl_adjust(struct drm_device *dev,
+					struct drm_display_mode *mode,
+					unsigned int ctrl)
+{
+	unsigned long x, y;
+	unsigned long pll1; /* bit[31:0] of PLL */
+	unsigned long pll2; /* bit[63:32] of PLL */
+	struct hibmc_drm_device *hidev = dev->dev_private;
+
+	x = mode->hdisplay;
+	y = mode->vdisplay;
+
+	/* Hisilicon has to set up a new register for PLL control
+	 *(CRT_PLL1_HS & CRT_PLL2_HS).
+	 */
+	if (x == 800 && y == 600) {
+		pll1 = CRT_PLL1_HS_40MHZ;
+		pll2 = CRT_PLL2_HS_40MHZ;
+	} else if (x == 1024 && y == 768) {
+		pll1 = CRT_PLL1_HS_65MHZ;
+		pll2 = CRT_PLL2_HS_65MHZ;
+	} else if (x == 1152 && y == 864) {
+		pll1 = CRT_PLL1_HS_80MHZ_1152;
+		pll2 = CRT_PLL2_HS_80MHZ;
+	} else if (x == 1280 && y == 768) {
+		pll1 = CRT_PLL1_HS_80MHZ;
+		pll2 = CRT_PLL2_HS_80MHZ;
+	} else if (x == 1280 && y == 720) {
+		pll1 = CRT_PLL1_HS_74MHZ;
+		pll2 = CRT_PLL2_HS_74MHZ;
+	} else if (x == 1280 && y == 960) {
+		pll1 = CRT_PLL1_HS_108MHZ;
+		pll2 = CRT_PLL2_HS_108MHZ;
+	} else if (x == 1280 && y == 1024) {
+		pll1 = CRT_PLL1_HS_108MHZ;
+		pll2 = CRT_PLL2_HS_108MHZ;
+	} else if (x == 1600 && y == 1200) {
+		pll1 = CRT_PLL1_HS_162MHZ;
+		pll2 = CRT_PLL2_HS_162MHZ;
+	} else if (x == 1920 && y == 1080) {
+		pll1 = CRT_PLL1_HS_148MHZ;
+		pll2 = CRT_PLL2_HS_148MHZ;
+	} else if (x == 1920 && y == 1200) {
+		pll1 = CRT_PLL1_HS_193MHZ;
+		pll2 = CRT_PLL2_HS_193MHZ;
+	} else /* default to VGA clock */ {
+		pll1 = CRT_PLL1_HS_25MHZ;
+		pll2 = CRT_PLL2_HS_25MHZ;
+	}
+
+	writel(pll2, hidev->mmio + CRT_PLL2_HS);
+	set_vclock_hisilicon(dev, pll1);
+
+	/* Hisilicon has to set up the top-left and bottom-right
+	 * registers as well.
+	 * Note that normal chip only use those two register for
+	 * auto-centering mode.
+	 */
+	writel((HIBMC_CRT_AUTO_CENTERING_TL_TOP(0) &
+		HIBMC_CRT_AUTO_CENTERING_TL_TOP_MSK) |
+	       (HIBMC_CRT_AUTO_CENTERING_TL_LEFT(0) &
+		HIBMC_CRT_AUTO_CENTERING_TL_LEFT_MSK),
+	       hidev->mmio + HIBMC_CRT_AUTO_CENTERING_TL);
+
+	writel((HIBMC_CRT_AUTO_CENTERING_BR_BOTTOM(y - 1) &
+		HIBMC_CRT_AUTO_CENTERING_BR_BOTTOM_MASK) |
+	       (HIBMC_CRT_AUTO_CENTERING_BR_RIGHT(x - 1) &
+		HIBMC_CRT_AUTO_CENTERING_BR_RIGHT_MASK),
+		hidev->mmio + HIBMC_CRT_AUTO_CENTERING_BR);
+
+	/* Assume common fields in ctrl have been properly set before
+	 * calling this function.
+	 * This function only sets the extra fields in ctrl.
+	 */
+
+	/* Set bit 25 of display controller: Select CRT or VGA clock */
+	ctrl &= ~HIBMC_CRT_DISP_CTL_CRTSELECT_MASK;
+	ctrl &= ~HIBMC_CRT_DISP_CTL_CLOCK_PHASE_MASK;
+
+	ctrl |= HIBMC_CRT_DISP_CTL_CRTSELECT(CRTSELECT_CRT);
+
+	/*ctrl = FIELD_SET(ctrl, HIBMC_CRT_DISP_CTL, CRTSELECT, CRT);*/
+
+	/* Set bit 14 of display controller */
+	/*ctrl &= FIELD_CLEAR(HIBMC_CRT_DISP_CTL, CLOCK_PHASE);*/
+
+	/* clock_phase_polarity is 0 */
+	ctrl |= HIBMC_CRT_DISP_CTL_CLOCK_PHASE(PHASE_ACTIVE_HIGH);
+	/*ctrl = FIELD_SET(ctrl, HIBMC_CRT_DISP_CTL,*/
+	/*CLOCK_PHASE, ACTIVE_HIGH);*/
+
+	writel(ctrl, hidev->mmio + HIBMC_CRT_DISP_CTL);
+
+	return ctrl;
+}
+
+static void hibmc_crtc_mode_set_nofb(struct drm_crtc *crtc)
+{
+	unsigned int val;
+	struct drm_display_mode *mode = &crtc->state->mode;
+	struct drm_device *dev = crtc->dev;
+	struct hibmc_drm_device *hidev = dev->dev_private;
+
+	writel(format_pll_reg(), hidev->mmio + HIBMC_CRT_PLL_CTRL);
+	writel((HIBMC_CRT_HORZ_TOTAL_TOTAL(mode->htotal - 1) &
+		HIBMC_CRT_HORZ_TOTAL_TOTAL_MASK) |
+		(HIBMC_CRT_HORZ_TOTAL_DISPLAY_END(mode->hdisplay - 1) &
+		HIBMC_CRT_HORZ_TOTAL_DISPLAY_END_MASK),
+		hidev->mmio + HIBMC_CRT_HORZ_TOTAL);
+
+	writel((HIBMC_CRT_HORZ_SYNC_WIDTH(mode->hsync_end - mode->hsync_start)
+		& HIBMC_CRT_HORZ_SYNC_WIDTH_MASK) |
+		(HIBMC_CRT_HORZ_SYNC_START(mode->hsync_start - 1)
+		& HIBMC_CRT_HORZ_SYNC_START_MASK),
+		hidev->mmio + HIBMC_CRT_HORZ_SYNC);
+
+	writel((HIBMC_CRT_VERT_TOTAL_TOTAL(mode->vtotal - 1) &
+		HIBMC_CRT_VERT_TOTAL_TOTAL_MASK) |
+		(HIBMC_CRT_VERT_TOTAL_DISPLAY_END(mode->vdisplay - 1) &
+		HIBMC_CRT_VERT_TOTAL_DISPLAY_END_MASK),
+		hidev->mmio + HIBMC_CRT_VERT_TOTAL);
+
+	writel((HIBMC_CRT_VERT_SYNC_HEIGHT(mode->vsync_end - mode->vsync_start)
+		& HIBMC_CRT_VERT_SYNC_HEIGHT_MASK) |
+	       (HIBMC_CRT_VERT_SYNC_START(mode->vsync_start - 1) &
+		HIBMC_CRT_VERT_SYNC_START_MASK),
+		hidev->mmio + HIBMC_CRT_VERT_SYNC);
+
+	val = HIBMC_CRT_DISP_CTL_VSYNC_PHASE(0) &
+	      HIBMC_CRT_DISP_CTL_VSYNC_PHASE_MASK;
+	val |= HIBMC_CRT_DISP_CTL_HSYNC_PHASE(0) &
+	       HIBMC_CRT_DISP_CTL_HSYNC_PHASE_MASK;
+	val |= HIBMC_CRT_DISP_CTL_TIMING(ENABLE);
+	val |= HIBMC_CRT_DISP_CTL_PLANE(ENABLE);
+
+	display_ctrl_adjust(dev, mode, val);
+}
+
+static void hibmc_crtc_atomic_begin(struct drm_crtc *crtc,
+				    struct drm_crtc_state *old_state)
+{
+	unsigned int reg;
+	struct drm_device *dev = crtc->dev;
+	struct hibmc_drm_device *hidev = dev->dev_private;
+
+	hibmc_set_power_mode(hidev, HIBMC_PW_MODE_CTL_MODE_MODE0);
+
+	/* Enable display power gate & LOCALMEM power gate*/
+	reg = readl(hidev->mmio + HIBMC_CURRENT_GATE);
+	reg &= ~HIBMC_CURR_GATE_DISPLAY_MASK;
+	reg &= ~HIBMC_CURR_GATE_LOCALMEM_MASK;
+	reg |= HIBMC_CURR_GATE_DISPLAY(ON);
+	reg |= HIBMC_CURR_GATE_LOCALMEM(ON);
+	hibmc_set_current_gate(hidev, reg);
+
+	/* We can add more initialization as needed. */
+}
+
+static void hibmc_crtc_atomic_flush(struct drm_crtc *crtc,
+				    struct drm_crtc_state *old_state)
+
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&crtc->dev->event_lock, flags);
+	if (crtc->state->event)
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+	crtc->state->event = NULL;
+
+	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+}
+
+/* These provide the minimum set of functions required to handle a CRTC */
+static const struct drm_crtc_funcs hibmc_crtc_funcs = {
+	.page_flip = drm_atomic_helper_page_flip,
+	.set_config = drm_atomic_helper_set_config,
+	.destroy = drm_crtc_cleanup,
+	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_duplicate_state =  drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_crtc_helper_funcs hibmc_crtc_helper_funcs = {
+	.enable		= hibmc_crtc_enable,
+	.disable	= hibmc_crtc_disable,
+	.mode_set_nofb	= hibmc_crtc_mode_set_nofb,
+	.atomic_check	= hibmc_crtc_atomic_check,
+	.atomic_begin	= hibmc_crtc_atomic_begin,
+	.atomic_flush	= hibmc_crtc_atomic_flush,
+};
+
+int hibmc_crtc_init(struct hibmc_drm_device *hidev)
+{
+	struct drm_device *dev = hidev->dev;
+	struct drm_crtc *crtc = &hidev->crtc;
+	struct drm_plane *plane = &hidev->plane;
+	int ret;
+
+	ret = drm_crtc_init_with_planes(dev, crtc, plane,
+					NULL, &hibmc_crtc_funcs, NULL);
+	if (ret) {
+		DRM_ERROR("failed to init crtc.\n");
+		return ret;
+	}
+
+	drm_mode_crtc_set_gamma_size(crtc, 256);
+	drm_crtc_helper_add(crtc, &hibmc_crtc_helper_funcs);
+	return 0;
+}
+
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index e90e6e9..748f6b1 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -130,6 +130,12 @@ static int hibmc_kms_init(struct hibmc_drm_device *hidev)
 		return ret;
 	}
 
+	ret = hibmc_crtc_init(hidev);
+	if (ret) {
+		DRM_ERROR("failed to init crtc.\n");
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 6148f7f..9b83201 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -47,6 +47,7 @@ struct hibmc_drm_device {
 	/* drm */
 	struct drm_device  *dev;
 	struct drm_plane plane;
+	struct drm_crtc crtc;
 	bool mode_config_initialized;
 
 	/* ttm */
@@ -86,6 +87,7 @@ static inline struct hibmc_bo *gem_to_hibmc_bo(struct drm_gem_object *gem)
 #define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
 
 int hibmc_plane_init(struct hibmc_drm_device *hidev);
+int hibmc_crtc_init(struct hibmc_drm_device *hidev);
 int hibmc_fbdev_init(struct hibmc_drm_device *hidev);
 void hibmc_fbdev_fini(struct hibmc_drm_device *hidev);
 
-- 
1.9.1
