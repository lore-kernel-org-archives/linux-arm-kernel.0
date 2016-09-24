From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 24 Sep 2016 22:26:25 +0800
Subject: [PATCH v2 2/2] drm: zte: add initial vou drm driver
In-Reply-To: <1474727185-24180-1-git-send-email-shawn.guo@linaro.org>
References: <1474727185-24180-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1474727185-24180-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds the initial ZTE VOU display controller DRM driver.  There are
still some features to be added, like overlay plane, scaling, and more
output devices support.  But it's already useful with dual CRTCs and
HDMI monitor working.

It's been tested on Debian Jessie LXDE desktop with modesetting driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpu/drm/Kconfig          |   2 +
 drivers/gpu/drm/Makefile         |   1 +
 drivers/gpu/drm/zte/Kconfig      |   8 +
 drivers/gpu/drm/zte/Makefile     |   8 +
 drivers/gpu/drm/zte/zx_crtc.c    | 691 +++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/zte/zx_crtc.h    |  47 +++
 drivers/gpu/drm/zte/zx_drm_drv.c | 258 +++++++++++++++
 drivers/gpu/drm/zte/zx_drm_drv.h |  22 ++
 drivers/gpu/drm/zte/zx_hdmi.c    | 540 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/zte/zx_plane.c   | 362 ++++++++++++++++++++
 drivers/gpu/drm/zte/zx_plane.h   |  26 ++
 11 files changed, 1965 insertions(+)
 create mode 100644 drivers/gpu/drm/zte/Kconfig
 create mode 100644 drivers/gpu/drm/zte/Makefile
 create mode 100644 drivers/gpu/drm/zte/zx_crtc.c
 create mode 100644 drivers/gpu/drm/zte/zx_crtc.h
 create mode 100644 drivers/gpu/drm/zte/zx_drm_drv.c
 create mode 100644 drivers/gpu/drm/zte/zx_drm_drv.h
 create mode 100644 drivers/gpu/drm/zte/zx_hdmi.c
 create mode 100644 drivers/gpu/drm/zte/zx_plane.c
 create mode 100644 drivers/gpu/drm/zte/zx_plane.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 483059a22b1b..a91f8cecbe0f 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -223,6 +223,8 @@ source "drivers/gpu/drm/hisilicon/Kconfig"
 
 source "drivers/gpu/drm/mediatek/Kconfig"
 
+source "drivers/gpu/drm/zte/Kconfig"
+
 # Keep legacy drivers last
 
 menuconfig DRM_LEGACY
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 439d89b25ae0..fe461c94d266 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -85,3 +85,4 @@ obj-$(CONFIG_DRM_FSL_DCU) += fsl-dcu/
 obj-$(CONFIG_DRM_ETNAVIV) += etnaviv/
 obj-$(CONFIG_DRM_ARCPGU)+= arc/
 obj-y			+= hisilicon/
+obj-$(CONFIG_DRM_ZTE)	+= zte/
diff --git a/drivers/gpu/drm/zte/Kconfig b/drivers/gpu/drm/zte/Kconfig
new file mode 100644
index 000000000000..4065b2840f1c
--- /dev/null
+++ b/drivers/gpu/drm/zte/Kconfig
@@ -0,0 +1,8 @@
+config DRM_ZTE
+	tristate "DRM Support for ZTE SoCs"
+	depends on DRM && ARCH_ZX
+	select DRM_KMS_CMA_HELPER
+	select DRM_KMS_FB_HELPER
+	select DRM_KMS_HELPER
+	help
+	  Choose this option to enable DRM on ZTE ZX SoCs.
diff --git a/drivers/gpu/drm/zte/Makefile b/drivers/gpu/drm/zte/Makefile
new file mode 100644
index 000000000000..b40968dc749f
--- /dev/null
+++ b/drivers/gpu/drm/zte/Makefile
@@ -0,0 +1,8 @@
+zxdrm-y := \
+	zx_drm_drv.o \
+	zx_crtc.o \
+	zx_plane.o \
+	zx_hdmi.o
+
+obj-$(CONFIG_DRM_ZTE) += zxdrm.o
+
diff --git a/drivers/gpu/drm/zte/zx_crtc.c b/drivers/gpu/drm/zte/zx_crtc.c
new file mode 100644
index 000000000000..818bf9072573
--- /dev/null
+++ b/drivers/gpu/drm/zte/zx_crtc.c
@@ -0,0 +1,691 @@
+/*
+ * Copyright 2016 Linaro Ltd.
+ * Copyright 2016 ZTE Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_of.h>
+#include <drm/drm_plane_helper.h>
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/of_address.h>
+#include <video/videomode.h>
+
+#include "zx_drm_drv.h"
+#include "zx_crtc.h"
+#include "zx_plane.h"
+
+/* OSD (GPC_GLOBAL) registers */
+#define OSD_INT_STA			0x04
+#define OSD_INT_CLRSTA			0x08
+#define OSD_INT_MSK			0x0c
+#define OSD_INT_AUX_UPT			BIT(14)
+#define OSD_INT_MAIN_UPT		BIT(13)
+#define OSD_INT_GL1_LBW			BIT(10)
+#define OSD_INT_GL0_LBW			BIT(9)
+#define OSD_INT_VL2_LBW			BIT(8)
+#define OSD_INT_VL1_LBW			BIT(7)
+#define OSD_INT_VL0_LBW			BIT(6)
+#define OSD_INT_BUS_ERR			BIT(3)
+#define OSD_INT_CFG_ERR			BIT(2)
+#define OSD_INT_ERROR (\
+	OSD_INT_GL1_LBW | OSD_INT_GL0_LBW | \
+	OSD_INT_VL2_LBW | OSD_INT_VL1_LBW | OSD_INT_VL0_LBW | \
+	OSD_INT_BUS_ERR | OSD_INT_CFG_ERR \
+)
+#define OSD_INT_ENABLE (OSD_INT_ERROR | OSD_INT_AUX_UPT | OSD_INT_MAIN_UPT)
+#define OSD_CTRL0			0x10
+#define OSD_CTRL0_GL0_EN		BIT(7)
+#define OSD_CTRL0_GL0_SEL		BIT(6)
+#define OSD_CTRL0_GL1_EN		BIT(5)
+#define OSD_CTRL0_GL1_SEL		BIT(4)
+#define OSD_RST_CLR			0x1c
+#define RST_PER_FRAME			BIT(19)
+
+/* Main/Aux channel registers */
+#define OSD_MAIN_CHN			0x470
+#define OSD_AUX_CHN			0x4d0
+#define CHN_CTRL0			0x00
+#define CHN_ENABLE			BIT(0)
+#define CHN_CTRL1			0x04
+#define CHN_SCREEN_W_SHIFT		18
+#define CHN_SCREEN_W_MASK		(0x1fff << CHN_SCREEN_W_SHIFT)
+#define CHN_SCREEN_H_SHIFT		5
+#define CHN_SCREEN_H_MASK		(0x1fff << CHN_SCREEN_H_SHIFT)
+#define CHN_UPDATE			0x08
+
+/* TIMING_CTRL registers */
+#define TIMING_TC_ENABLE		0x04
+#define AUX_TC_EN			BIT(1)
+#define MAIN_TC_EN			BIT(0)
+#define FIR_MAIN_ACTIVE			0x08
+#define FIR_AUX_ACTIVE			0x0c
+#define FIR_MAIN_H_TIMING		0x10
+#define FIR_MAIN_V_TIMING		0x14
+#define FIR_AUX_H_TIMING		0x18
+#define FIR_AUX_V_TIMING		0x1c
+#define SYNC_WIDE_SHIFT			22
+#define SYNC_WIDE_MASK			(0x3ff << SYNC_WIDE_SHIFT)
+#define BACK_PORCH_SHIFT		11
+#define BACK_PORCH_MASK			(0x7ff << BACK_PORCH_SHIFT)
+#define FRONT_PORCH_SHIFT		0
+#define FRONT_PORCH_MASK		(0x7ff << FRONT_PORCH_SHIFT)
+#define TIMING_CTRL			0x20
+#define AUX_POL_SHIFT			3
+#define AUX_POL_MASK			(0x7 << AUX_POL_SHIFT)
+#define MAIN_POL_SHIFT			0
+#define MAIN_POL_MASK			(0x7 << MAIN_POL_SHIFT)
+#define POL_DE_SHIFT			2
+#define POL_VSYNC_SHIFT			1
+#define POL_HSYNC_SHIFT			0
+#define TIMING_INT_CTRL			0x24
+#define TIMING_INT_STATE		0x28
+#define TIMING_INT_AUX_FRAME		BIT(3)
+#define TIMING_INT_MAIN_FRAME		BIT(1)
+#define TIMING_INT_AUX_FRAME_SEL_VSW	(0x2 << 10)
+#define TIMING_INT_MAIN_FRAME_SEL_VSW	(0x2 << 6)
+#define TIMING_INT_ENABLE (\
+	TIMING_INT_MAIN_FRAME_SEL_VSW | TIMING_INT_AUX_FRAME_SEL_VSW | \
+	TIMING_INT_MAIN_FRAME | TIMING_INT_AUX_FRAME \
+)
+#define TIMING_MAIN_SHIFT		0x2c
+#define TIMING_AUX_SHIFT		0x30
+#define H_SHIFT_VAL			0x0048
+#define TIMING_MAIN_PI_SHIFT		0x68
+#define TIMING_AUX_PI_SHIFT		0x6c
+#define H_PI_SHIFT_VAL			0x000f
+
+/* DTRC registers */
+#define DTRC_F0_CTRL			0x2c
+#define DTRC_F1_CTRL			0x5c
+#define DTRC_DECOMPRESS_BYPASS		BIT(17)
+#define DTRC_DETILE_CTRL		0x68
+#define TILE2RASTESCAN_BYPASS_MODE	BIT(30)
+#define DETILE_ARIDR_MODE_MASK		(0x3 << 0)
+#define DETILE_ARID_ALL			0
+#define DETILE_ARID_IN_ARIDR		1
+#define DETILE_ARID_BYP_BUT_ARIDR	2
+#define DETILE_ARID_IN_ARIDR2		3
+#define DTRC_ARID			0x6c
+#define DTRC_DEC2DDR_ARID		0x70
+
+/* VOU_CTRL registers */
+#define VOU_INF_EN			0x00
+#define VOU_INF_CH_SEL			0x04
+#define VOU_INF_DATA_SEL		0x08
+#define VOU_SOFT_RST			0x14
+#define VOU_CLK_SEL			0x18
+#define VOU_CLK_GL1_SEL			BIT(5)
+#define VOU_CLK_GL0_SEL			BIT(4)
+#define VOU_CLK_REQEN			0x20
+#define VOU_CLK_EN			0x24
+
+/* OTFPPU_CTRL registers */
+#define OTFPPU_RSZ_DATA_SOURCE		0x04
+
+#define GL_NUM				2
+#define VL_NUM				3
+
+enum vou_chn_type {
+	VOU_CHN_MAIN,
+	VOU_CHN_AUX,
+};
+
+struct zx_crtc {
+	struct drm_crtc crtc;
+	struct drm_plane *primary;
+	struct device *dev;
+	void __iomem *chnreg;
+	enum vou_chn_type chn_type;
+	struct clk *pixclk;
+};
+
+#define to_zx_crtc(x)	container_of(crtc, struct zx_crtc, crtc)
+
+struct zx_vou_hw {
+	struct device *dev;
+	void __iomem *osd;
+	void __iomem *timing;
+	void __iomem *vouctl;
+	void __iomem *otfppu;
+	void __iomem *dtrc;
+	struct clk *axi_clk;
+	struct clk *ppu_clk;
+	struct clk *main_clk;
+	struct clk *aux_clk;
+	struct zx_crtc *main_crtc;
+	struct zx_crtc *aux_crtc;
+};
+
+static inline bool is_main_crtc(struct drm_crtc *crtc)
+{
+	struct zx_crtc *zcrtc = to_zx_crtc(crtc);
+
+	return zcrtc->chn_type == VOU_CHN_MAIN;
+}
+
+void vou_inf_enable(struct vou_inf *inf)
+{
+	struct drm_encoder *encoder = inf->encoder;
+	struct drm_device *drm = encoder->dev;
+	struct zx_drm_private *priv = drm->dev_private;
+	struct zx_vou_hw *vou = priv->vou;
+	bool is_main = is_main_crtc(encoder->crtc);
+	u32 data_sel_shift = inf->id << 1;
+	u32 val;
+
+	/* Select data format */
+	val = readl(vou->vouctl + VOU_INF_DATA_SEL);
+	val &= ~(0x3 << data_sel_shift);
+	val |= inf->data_sel << data_sel_shift;
+	writel(val, vou->vouctl + VOU_INF_DATA_SEL);
+
+	/* Select channel */
+	val = readl(vou->vouctl + VOU_INF_CH_SEL);
+	if (is_main)
+		val &= ~(1 << inf->id);
+	else
+		val |= 1 << inf->id;
+	writel(val, vou->vouctl + VOU_INF_CH_SEL);
+
+	/* Select interface clocks */
+	val = readl(vou->vouctl + VOU_CLK_SEL);
+	if (is_main)
+		val &= ~inf->clocks_sel_bits;
+	else
+		val |= inf->clocks_sel_bits;
+	writel(val, vou->vouctl + VOU_CLK_SEL);
+
+	/* Enable interface clocks */
+	val = readl(vou->vouctl + VOU_CLK_EN);
+	val |= inf->clocks_en_bits;
+	writel(val, vou->vouctl + VOU_CLK_EN);
+
+	/* Enable the device */
+	val = readl(vou->vouctl + VOU_INF_EN);
+	val |= 1 << inf->id;
+	writel(val, vou->vouctl + VOU_INF_EN);
+}
+
+void vou_inf_disable(struct vou_inf *inf)
+{
+	struct drm_encoder *encoder = inf->encoder;
+	struct drm_device *drm = encoder->dev;
+	struct zx_drm_private *priv = drm->dev_private;
+	struct zx_vou_hw *vou = priv->vou;
+	u32 val;
+
+	/* Disable the device */
+	val = readl(vou->vouctl + VOU_INF_EN);
+	val &= ~(1 << inf->id);
+	writel(val, vou->vouctl + VOU_INF_EN);
+
+	/* Disable interface clocks */
+	val = readl(vou->vouctl + VOU_CLK_EN);
+	val &= ~inf->clocks_en_bits;
+	writel(val, vou->vouctl + VOU_CLK_EN);
+}
+
+static inline void vou_chn_set_update(struct zx_crtc *zcrtc)
+{
+	writel(1, zcrtc->chnreg + CHN_UPDATE);
+}
+
+static void zx_crtc_enable(struct drm_crtc *crtc)
+{
+	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
+	struct zx_crtc *zcrtc = to_zx_crtc(crtc);
+	struct zx_vou_hw *vou = dev_get_drvdata(zcrtc->dev);
+	bool is_main = is_main_crtc(crtc);
+	struct videomode vm;
+	u32 pol = 0;
+	u32 val;
+
+	drm_display_mode_to_videomode(mode, &vm);
+
+	/* Set up timing parameters */
+	val = (vm.vactive - 1) << 16;
+	val |= (vm.hactive - 1) & 0xffff;
+	writel(val, vou->timing + (is_main ? FIR_MAIN_ACTIVE : FIR_AUX_ACTIVE));
+
+	val = ((vm.hsync_len - 1) << SYNC_WIDE_SHIFT) & SYNC_WIDE_MASK;
+	val |= ((vm.hback_porch - 1) << BACK_PORCH_SHIFT) & BACK_PORCH_MASK;
+	val |= ((vm.hfront_porch - 1) << FRONT_PORCH_SHIFT) & FRONT_PORCH_MASK;
+	writel(val, vou->timing + (is_main ? FIR_MAIN_H_TIMING :
+					     FIR_AUX_H_TIMING));
+
+	val = ((vm.vsync_len - 1) << SYNC_WIDE_SHIFT) & SYNC_WIDE_MASK;
+	val |= ((vm.vback_porch - 1) << BACK_PORCH_SHIFT) & BACK_PORCH_MASK;
+	val |= ((vm.vfront_porch - 1) << FRONT_PORCH_SHIFT) & FRONT_PORCH_MASK;
+	writel(val, vou->timing + (is_main ? FIR_MAIN_V_TIMING :
+					     FIR_AUX_V_TIMING));
+
+	/* Set up polarities */
+	if (vm.flags & DISPLAY_FLAGS_VSYNC_LOW)
+		pol |= 1 << POL_VSYNC_SHIFT;
+	if (vm.flags & DISPLAY_FLAGS_HSYNC_LOW)
+		pol |= 1 << POL_HSYNC_SHIFT;
+
+	val = readl(vou->timing + TIMING_CTRL);
+	val &= ~(is_main ? MAIN_POL_MASK : AUX_POL_MASK);
+	val |= pol << (is_main ? MAIN_POL_SHIFT : AUX_POL_SHIFT);
+	writel(val, vou->timing + TIMING_CTRL);
+
+	/* Setup SHIFT register by following what ZTE BSP does */
+	writel(H_SHIFT_VAL, vou->timing + (is_main ? TIMING_MAIN_SHIFT :
+						     TIMING_AUX_SHIFT));
+	writel(H_PI_SHIFT_VAL, vou->timing + (is_main ? TIMING_MAIN_PI_SHIFT :
+							TIMING_AUX_PI_SHIFT));
+
+	/* Enable TIMING_CTRL */
+	val = readl(vou->timing + TIMING_TC_ENABLE);
+	val |= is_main ? MAIN_TC_EN : AUX_TC_EN;
+	writel(val, vou->timing + TIMING_TC_ENABLE);
+
+	/* Configure channel screen size */
+	val = readl(zcrtc->chnreg + CHN_CTRL1);
+	val &= ~(CHN_SCREEN_W_MASK | CHN_SCREEN_H_MASK);
+	val |= (vm.hactive << CHN_SCREEN_W_SHIFT) & CHN_SCREEN_W_MASK;
+	val |= (vm.vactive << CHN_SCREEN_H_SHIFT) & CHN_SCREEN_H_MASK;
+	writel(val, zcrtc->chnreg + CHN_CTRL1);
+
+	/* Update channel */
+	vou_chn_set_update(zcrtc);
+
+	/* Enable channel */
+	val = readl(zcrtc->chnreg + CHN_CTRL0);
+	val |= CHN_ENABLE;
+	writel(val, zcrtc->chnreg + CHN_CTRL0);
+
+	/* Enable Graphic Layer */
+	val = readl(vou->osd + OSD_CTRL0);
+	val |= is_main ? OSD_CTRL0_GL0_EN : OSD_CTRL0_GL1_EN;
+	writel(val, vou->osd + OSD_CTRL0);
+
+	drm_crtc_vblank_on(crtc);
+
+	/* Enable pixel clock */
+	clk_set_rate(zcrtc->pixclk, mode->clock * 1000);
+	clk_prepare_enable(zcrtc->pixclk);
+}
+
+static void zx_crtc_disable(struct drm_crtc *crtc)
+{
+	struct zx_crtc *zcrtc = to_zx_crtc(crtc);
+	struct zx_vou_hw *vou = dev_get_drvdata(zcrtc->dev);
+	bool is_main = is_main_crtc(crtc);
+	u32 val;
+
+	clk_disable_unprepare(zcrtc->pixclk);
+
+	drm_crtc_vblank_off(crtc);
+
+	/* Disable Graphic Layer */
+	val = readl(vou->osd + OSD_CTRL0);
+	val &= ~(is_main ? OSD_CTRL0_GL0_EN : OSD_CTRL0_GL1_EN);
+	writel(val, vou->osd + OSD_CTRL0);
+
+	/* Disable channel */
+	val = readl(zcrtc->chnreg + CHN_CTRL0);
+	val &= ~CHN_ENABLE;
+	writel(val, zcrtc->chnreg + CHN_CTRL0);
+
+	/* Disable TIMING_CTRL */
+	val = readl(vou->timing + TIMING_TC_ENABLE);
+	val &= ~(is_main ? MAIN_TC_EN : AUX_TC_EN);
+	writel(val, vou->timing + TIMING_TC_ENABLE);
+}
+
+static void zx_crtc_atomic_begin(struct drm_crtc *crtc,
+				 struct drm_crtc_state *state)
+{
+	struct drm_pending_vblank_event *event = crtc->state->event;
+
+	if (event) {
+		crtc->state->event = NULL;
+
+		spin_lock_irq(&crtc->dev->event_lock);
+		if (drm_crtc_vblank_get(crtc) == 0)
+			drm_crtc_arm_vblank_event(crtc, event);
+		else
+			drm_crtc_send_vblank_event(crtc, event);
+		spin_unlock_irq(&crtc->dev->event_lock);
+	}
+}
+
+static const struct drm_crtc_helper_funcs zx_crtc_helper_funcs = {
+	.enable = zx_crtc_enable,
+	.disable = zx_crtc_disable,
+	.atomic_begin = zx_crtc_atomic_begin,
+};
+
+static const struct drm_crtc_funcs zx_crtc_funcs = {
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static struct zx_crtc *zx_crtc_init(struct drm_device *drm,
+				    enum vou_chn_type chn_type)
+{
+	struct zx_drm_private *priv = drm->dev_private;
+	struct zx_vou_hw *vou = priv->vou;
+	struct device *dev = vou->dev;
+	struct zx_layer_data data;
+	struct zx_crtc *zcrtc;
+	int ret;
+
+	zcrtc = devm_kzalloc(dev, sizeof(*zcrtc), GFP_KERNEL);
+	if (!zcrtc)
+		return ERR_PTR(-ENOMEM);
+
+	zcrtc->dev = dev;
+	zcrtc->chn_type = chn_type;
+
+	if (chn_type == VOU_CHN_MAIN) {
+		data.layer = vou->osd + 0x130;
+		data.csc = vou->osd + 0x580;
+		data.hbsc = vou->osd + 0x820;
+		data.rsz = vou->otfppu + 0x600;
+		zcrtc->chnreg = vou->osd + OSD_MAIN_CHN;
+	} else {
+		data.layer = vou->osd + 0x200;
+		data.csc = vou->osd + 0x5d0;
+		data.hbsc = vou->osd + 0x860;
+		data.rsz = vou->otfppu + 0x800;
+		zcrtc->chnreg = vou->osd + OSD_AUX_CHN;
+	}
+
+	zcrtc->pixclk = devm_clk_get(dev, (chn_type == VOU_CHN_MAIN) ?
+					  "main_wclk" : "aux_wclk");
+	if (IS_ERR(zcrtc->pixclk))
+		return ERR_PTR(PTR_ERR(zcrtc->pixclk));
+
+	zcrtc->primary = zx_plane_init(drm, dev, &data, DRM_PLANE_TYPE_PRIMARY);
+	if (IS_ERR(zcrtc->primary))
+		return ERR_PTR(PTR_ERR(zcrtc->primary));
+
+	ret = drm_crtc_init_with_planes(drm, &zcrtc->crtc, zcrtc->primary, NULL,
+					&zx_crtc_funcs, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	drm_crtc_helper_add(&zcrtc->crtc, &zx_crtc_helper_funcs);
+
+	return zcrtc;
+}
+
+int zx_crtc_enable_vblank(struct drm_device *drm, unsigned int pipe)
+{
+	struct zx_drm_private *priv = drm->dev_private;
+	struct zx_vou_hw *vou = priv->vou;
+	u32 intctl;
+
+	intctl = readl(vou->timing + TIMING_INT_CTRL);
+	if (pipe == 0)
+		intctl |= TIMING_INT_MAIN_FRAME;
+	else
+		intctl |= TIMING_INT_AUX_FRAME;
+	writel(intctl, vou->timing + TIMING_INT_CTRL);
+
+	return 0;
+}
+
+void zx_crtc_disable_vblank(struct drm_device *drm, unsigned int pipe)
+{
+	struct zx_drm_private *priv = drm->dev_private;
+	struct zx_vou_hw *vou = priv->vou;
+	u32 intctl;
+
+	intctl = readl(vou->timing + TIMING_INT_CTRL);
+	if (pipe == 0)
+		intctl &= ~TIMING_INT_MAIN_FRAME;
+	else
+		intctl &= ~TIMING_INT_AUX_FRAME;
+	writel(intctl, vou->timing + TIMING_INT_CTRL);
+}
+
+static irqreturn_t vou_irq_handler(int irq, void *dev_id)
+{
+	struct zx_vou_hw *vou = dev_id;
+	u32 state;
+
+	/* Handle TIMING_CTRL frame interrupts */
+	state = readl(vou->timing + TIMING_INT_STATE);
+	writel(state, vou->timing + TIMING_INT_STATE);
+
+	if (state & TIMING_INT_MAIN_FRAME)
+		drm_crtc_handle_vblank(&vou->main_crtc->crtc);
+
+	if (state & TIMING_INT_AUX_FRAME)
+		drm_crtc_handle_vblank(&vou->aux_crtc->crtc);
+
+	/* Handle OSD interrupts */
+	state = readl(vou->osd + OSD_INT_STA);
+	writel(state, vou->osd + OSD_INT_CLRSTA);
+
+	if (state & OSD_INT_MAIN_UPT) {
+		vou_chn_set_update(vou->main_crtc);
+		zx_plane_set_update(vou->main_crtc->primary);
+	}
+
+	if (state & OSD_INT_AUX_UPT) {
+		vou_chn_set_update(vou->aux_crtc);
+		zx_plane_set_update(vou->aux_crtc->primary);
+	}
+
+	if (state & OSD_INT_ERROR)
+		dev_err(vou->dev, "OSD ERROR: 0x%08x!\n", state);
+
+	return IRQ_HANDLED;
+}
+
+static void vou_dtrc_init(struct zx_vou_hw *vou)
+{
+	u32 val;
+
+	val = readl(vou->dtrc + DTRC_DETILE_CTRL);
+	/* Clear bit for bypass by ID */
+	val &= ~TILE2RASTESCAN_BYPASS_MODE;
+	/* Select ARIDR mode */
+	val &= ~DETILE_ARIDR_MODE_MASK;
+	val |= DETILE_ARID_IN_ARIDR;
+	writel(val, vou->dtrc + DTRC_DETILE_CTRL);
+
+	/* Bypass decompression for both frames */
+	val = readl(vou->dtrc + DTRC_F0_CTRL);
+	val |= DTRC_DECOMPRESS_BYPASS;
+	writel(val, vou->dtrc + DTRC_F0_CTRL);
+
+	val = readl(vou->dtrc + DTRC_F1_CTRL);
+	val |= DTRC_DECOMPRESS_BYPASS;
+	writel(val, vou->dtrc + DTRC_F1_CTRL);
+
+	/* Set up ARID register */
+	val = 0x0e;
+	val |= 0x0f << 8;
+	val |= 0x0e << 16;
+	val |= 0x0f << 24;
+	writel(val, vou->dtrc + DTRC_ARID);
+
+	/* Set up DEC2DDR_ARID register */
+	val = 0x0e;
+	val |= 0x0f << 8;
+	writel(val, vou->dtrc + DTRC_DEC2DDR_ARID);
+}
+
+static void vou_hw_init(struct zx_vou_hw *vou)
+{
+	u32 val;
+
+	/* Set GL0 to main channel and GL1 to aux channel */
+	val = readl(vou->osd + OSD_CTRL0);
+	val &= ~OSD_CTRL0_GL0_SEL;
+	val |= OSD_CTRL0_GL1_SEL;
+	writel(val, vou->osd + OSD_CTRL0);
+
+	/* Release reset for all VOU modules */
+	writel(~0, vou->vouctl + VOU_SOFT_RST);
+
+	/* Select main clock for GL0 and aux clock for GL1 module */
+	val = readl(vou->vouctl + VOU_CLK_SEL);
+	val &= ~VOU_CLK_GL0_SEL;
+	val |= VOU_CLK_GL1_SEL;
+	writel(val, vou->vouctl + VOU_CLK_SEL);
+
+	/* Enable clock auto-gating for all VOU modules */
+	writel(~0, vou->vouctl + VOU_CLK_REQEN);
+
+	/* Enable all VOU module clocks */
+	writel(~0, vou->vouctl + VOU_CLK_EN);
+
+	/* Clear both OSD and TIMING_CTRL interrupt state */
+	writel(~0, vou->osd + OSD_INT_CLRSTA);
+	writel(~0, vou->timing + TIMING_INT_STATE);
+
+	/* Enable OSD and TIMING_CTRL interrrupts */
+	writel(OSD_INT_ENABLE, vou->osd + OSD_INT_MSK);
+	writel(TIMING_INT_ENABLE, vou->timing + TIMING_INT_CTRL);
+
+	/* Select GPC as input to gl/vl scaler as a sane default setting */
+	writel(0x2a, vou->otfppu + OTFPPU_RSZ_DATA_SOURCE);
+
+	/*
+	 * Needs to reset channel and layer logic per frame when frame starts
+	 * to get VOU work properly.
+	 */
+	val = readl(vou->osd + OSD_RST_CLR);
+	val |= RST_PER_FRAME;
+	writel(val, vou->osd + OSD_RST_CLR);
+
+	vou_dtrc_init(vou);
+}
+
+static int zx_crtc_bind(struct device *dev, struct device *master, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_device *drm = data;
+	struct zx_drm_private *priv = drm->dev_private;
+	struct resource *res;
+	struct zx_vou_hw *vou;
+	int irq;
+	int ret;
+
+	vou = devm_kzalloc(dev, sizeof(*vou), GFP_KERNEL);
+	if (!vou)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "osd");
+	vou->osd = devm_ioremap_resource(dev, res);
+	if (IS_ERR(vou->osd))
+		return PTR_ERR(vou->osd);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "timing_ctrl");
+	vou->timing = devm_ioremap_resource(dev, res);
+	if (IS_ERR(vou->timing))
+		return PTR_ERR(vou->timing);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dtrc");
+	vou->dtrc = devm_ioremap_resource(dev, res);
+	if (IS_ERR(vou->dtrc))
+		return PTR_ERR(vou->dtrc);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "vou_ctrl");
+	vou->vouctl = devm_ioremap_resource(dev, res);
+	if (IS_ERR(vou->vouctl))
+		return PTR_ERR(vou->vouctl);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otfppu");
+	vou->otfppu = devm_ioremap_resource(dev, res);
+	if (IS_ERR(vou->otfppu))
+		return PTR_ERR(vou->otfppu);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	vou->axi_clk = devm_clk_get(dev, "aclk");
+	if (IS_ERR(vou->axi_clk))
+		return PTR_ERR(vou->axi_clk);
+
+	vou->ppu_clk = devm_clk_get(dev, "ppu_wclk");
+	if (IS_ERR(vou->ppu_clk))
+		return PTR_ERR(vou->ppu_clk);
+
+	clk_prepare_enable(vou->axi_clk);
+	clk_prepare_enable(vou->ppu_clk);
+
+	vou->dev = dev;
+	priv->vou = vou;
+	dev_set_drvdata(dev, vou);
+
+	vou_hw_init(vou);
+
+	ret = devm_request_irq(dev, irq, vou_irq_handler, 0, "zx_vou", vou);
+	if (ret < 0)
+		return ret;
+
+	vou->main_crtc = zx_crtc_init(drm, VOU_CHN_MAIN);
+	if (IS_ERR(vou->main_crtc))
+		return PTR_ERR(vou->main_crtc);
+
+	vou->aux_crtc = zx_crtc_init(drm, VOU_CHN_AUX);
+	if (IS_ERR(vou->aux_crtc))
+		return PTR_ERR(vou->aux_crtc);
+
+	return 0;
+}
+
+static void zx_crtc_unbind(struct device *dev, struct device *master,
+			   void *data)
+{
+	struct zx_vou_hw *vou = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(vou->axi_clk);
+	clk_disable_unprepare(vou->ppu_clk);
+}
+
+static const struct component_ops zx_crtc_component_ops = {
+	.bind = zx_crtc_bind,
+	.unbind = zx_crtc_unbind,
+};
+
+static int zx_crtc_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &zx_crtc_component_ops);
+}
+
+static int zx_crtc_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &zx_crtc_component_ops);
+	return 0;
+}
+
+static const struct of_device_id zx_crtc_of_match[] = {
+	{ .compatible = "zte,zx296718-dpc", },
+	{ /* end */ },
+};
+MODULE_DEVICE_TABLE(of, zx_crtc_of_match);
+
+struct platform_driver zx_crtc_driver = {
+	.probe = zx_crtc_probe,
+	.remove = zx_crtc_remove,
+	.driver	= {
+		.name = "zx-crtc",
+		.of_match_table	= zx_crtc_of_match,
+	},
+};
diff --git a/drivers/gpu/drm/zte/zx_crtc.h b/drivers/gpu/drm/zte/zx_crtc.h
new file mode 100644
index 000000000000..f889208054ce
--- /dev/null
+++ b/drivers/gpu/drm/zte/zx_crtc.h
@@ -0,0 +1,47 @@
+/*
+ * Copyright 2016 Linaro Ltd.
+ * Copyright 2016 ZTE Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ZX_CRTC_H__
+#define __ZX_CRTC_H__
+
+#define VOU_CRTC_MASK		0x3
+
+/* VOU output interfaces */
+enum vou_inf_id {
+	VOU_HDMI	= 0,
+	VOU_RGB_LCD	= 1,
+	VOU_TV_ENC	= 2,
+	VOU_MIPI_DSI	= 3,
+	VOU_LVDS	= 4,
+	VOU_VGA		= 5,
+};
+
+enum vou_inf_data_sel {
+	VOU_YUV444	= 0,
+	VOU_RGB_101010	= 1,
+	VOU_RGB_888	= 2,
+	VOU_RGB_666	= 3,
+};
+
+struct vou_inf {
+	struct drm_encoder *encoder;
+	enum vou_inf_id id;
+	enum vou_inf_data_sel data_sel;
+	u32 clocks_en_bits;
+	u32 clocks_sel_bits;
+};
+
+void vou_inf_enable(struct vou_inf *inf);
+void vou_inf_disable(struct vou_inf *inf);
+
+int zx_crtc_enable_vblank(struct drm_device *drm, unsigned int pipe);
+void zx_crtc_disable_vblank(struct drm_device *drm, unsigned int pipe);
+
+#endif /* __ZX_CRTC_H__ */
diff --git a/drivers/gpu/drm/zte/zx_drm_drv.c b/drivers/gpu/drm/zte/zx_drm_drv.c
new file mode 100644
index 000000000000..51fafb8e5f43
--- /dev/null
+++ b/drivers/gpu/drm/zte/zx_drm_drv.c
@@ -0,0 +1,258 @@
+/*
+ * Copyright 2016 Linaro Ltd.
+ * Copyright 2016 ZTE Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/list.h>
+#include <linux/of_graph.h>
+#include <linux/of_platform.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_of.h>
+
+#include "zx_drm_drv.h"
+#include "zx_crtc.h"
+
+static void zx_drm_fb_output_poll_changed(struct drm_device *drm)
+{
+	struct zx_drm_private *priv = drm->dev_private;
+
+	drm_fbdev_cma_hotplug_event(priv->fbdev);
+}
+
+static const struct drm_mode_config_funcs zx_drm_mode_config_funcs = {
+	.fb_create = drm_fb_cma_create,
+	.output_poll_changed = zx_drm_fb_output_poll_changed,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+static void zx_drm_lastclose(struct drm_device *drm)
+{
+	struct zx_drm_private *priv = drm->dev_private;
+
+	drm_fbdev_cma_restore_mode(priv->fbdev);
+}
+
+static const struct file_operations zx_drm_fops = {
+	.owner = THIS_MODULE,
+	.open = drm_open,
+	.release = drm_release,
+	.unlocked_ioctl = drm_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = drm_compat_ioctl,
+#endif
+	.poll = drm_poll,
+	.read = drm_read,
+	.llseek = noop_llseek,
+	.mmap = drm_gem_cma_mmap,
+};
+
+static struct drm_driver zx_drm_driver = {
+	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME |
+			   DRIVER_ATOMIC,
+	.lastclose = zx_drm_lastclose,
+	.get_vblank_counter = drm_vblank_no_hw_counter,
+	.enable_vblank = zx_crtc_enable_vblank,
+	.disable_vblank = zx_crtc_disable_vblank,
+	.gem_free_object = drm_gem_cma_free_object,
+	.gem_vm_ops = &drm_gem_cma_vm_ops,
+	.dumb_create = drm_gem_cma_dumb_create,
+	.dumb_map_offset = drm_gem_cma_dumb_map_offset,
+	.dumb_destroy = drm_gem_dumb_destroy,
+	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
+	.gem_prime_export = drm_gem_prime_export,
+	.gem_prime_import = drm_gem_prime_import,
+	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
+	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
+	.gem_prime_vmap = drm_gem_cma_prime_vmap,
+	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
+	.gem_prime_mmap = drm_gem_cma_prime_mmap,
+	.fops = &zx_drm_fops,
+	.name = "zx-vou",
+	.desc = "ZTE VOU Controller DRM",
+	.date = "20160811",
+	.major = 1,
+	.minor = 0,
+};
+
+static int zx_drm_bind(struct device *dev)
+{
+	struct drm_device *drm;
+	struct zx_drm_private *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	drm = drm_dev_alloc(&zx_drm_driver, dev);
+	if (!drm)
+		return -ENOMEM;
+
+	drm->dev_private = priv;
+	dev_set_drvdata(dev, drm);
+
+	drm_mode_config_init(drm);
+	drm->mode_config.min_width = 16;
+	drm->mode_config.min_height = 16;
+	drm->mode_config.max_width = 4096;
+	drm->mode_config.max_height = 4096;
+	drm->mode_config.funcs = &zx_drm_mode_config_funcs;
+
+	ret = drm_dev_register(drm, 0);
+	if (ret)
+		goto out_free;
+
+	ret = component_bind_all(dev, drm);
+	if (ret) {
+		DRM_ERROR("Failed to bind all components\n");
+		goto out_unregister;
+	}
+
+	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
+	if (ret < 0) {
+		DRM_ERROR("failed to initialise vblank\n");
+		goto out_unbind;
+	}
+
+	/*
+	 * We will manage irq handler on our own.  In this case, irq_enabled
+	 * need to be true for using vblank core support.
+	 */
+	drm->irq_enabled = true;
+
+	drm_mode_config_reset(drm);
+	drm_kms_helper_poll_init(drm);
+
+	priv->fbdev = drm_fbdev_cma_init(drm, 32, drm->mode_config.num_crtc,
+					 drm->mode_config.num_connector);
+	if (IS_ERR(priv->fbdev)) {
+		ret = PTR_ERR(priv->fbdev);
+		priv->fbdev = NULL;
+		goto out_fini;
+	}
+
+	return 0;
+
+out_fini:
+	drm_kms_helper_poll_fini(drm);
+	drm_mode_config_cleanup(drm);
+	drm_vblank_cleanup(drm);
+out_unbind:
+	component_unbind_all(dev, drm);
+out_unregister:
+	drm_dev_unregister(drm);
+out_free:
+	dev_set_drvdata(dev, NULL);
+	drm_dev_unref(drm);
+	return ret;
+}
+
+static void zx_drm_unbind(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct zx_drm_private *priv = drm->dev_private;
+
+	if (priv->fbdev) {
+		drm_fbdev_cma_fini(priv->fbdev);
+		priv->fbdev = NULL;
+	}
+	drm_kms_helper_poll_fini(drm);
+	component_unbind_all(dev, drm);
+	drm_vblank_cleanup(drm);
+	drm_mode_config_cleanup(drm);
+	drm_dev_unregister(drm);
+	drm_dev_unref(drm);
+	drm->dev_private = NULL;
+	dev_set_drvdata(dev, NULL);
+}
+
+static const struct component_master_ops zx_drm_master_ops = {
+	.bind = zx_drm_bind,
+	.unbind = zx_drm_unbind,
+};
+
+static int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static int zx_drm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *parent = dev->of_node;
+	struct device_node *child;
+	struct component_match *match = NULL;
+	int ret;
+
+	ret = of_platform_populate(parent, NULL, NULL, dev);
+	if (ret)
+		return ret;
+
+	for_each_available_child_of_node(parent, child) {
+		component_match_add(dev, &match, compare_of, child);
+		of_node_put(child);
+	}
+
+	return component_master_add_with_match(dev, &zx_drm_master_ops, match);
+}
+
+static int zx_drm_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &zx_drm_master_ops);
+	return 0;
+}
+
+static const struct of_device_id zx_drm_of_match[] = {
+	{ .compatible = "zte,zx296718-vou", },
+	{ /* end */ },
+};
+MODULE_DEVICE_TABLE(of, zx_drm_of_match);
+
+static struct platform_driver zx_drm_platform_driver = {
+	.probe = zx_drm_probe,
+	.remove = zx_drm_remove,
+	.driver	= {
+		.name = "zx-drm",
+		.of_match_table	= zx_drm_of_match,
+	},
+};
+
+static struct platform_driver *drivers[] = {
+	&zx_crtc_driver,
+	&zx_hdmi_driver,
+	&zx_drm_platform_driver,
+};
+
+static int zx_drm_init(void)
+{
+	return platform_register_drivers(drivers, ARRAY_SIZE(drivers));
+}
+module_init(zx_drm_init);
+
+static void zx_drm_exit(void)
+{
+	platform_unregister_drivers(drivers, ARRAY_SIZE(drivers));
+}
+module_exit(zx_drm_exit);
+
+MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
+MODULE_DESCRIPTION("ZTE ZX VOU DRM driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/zte/zx_drm_drv.h b/drivers/gpu/drm/zte/zx_drm_drv.h
new file mode 100644
index 000000000000..14c749949151
--- /dev/null
+++ b/drivers/gpu/drm/zte/zx_drm_drv.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright 2016 Linaro Ltd.
+ * Copyright 2016 ZTE Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ZX_DRM_DRV_H__
+#define __ZX_DRM_DRV_H__
+
+struct zx_drm_private {
+	struct drm_fbdev_cma *fbdev;
+	struct zx_vou_hw *vou;
+};
+
+extern struct platform_driver zx_crtc_driver;
+extern struct platform_driver zx_hdmi_driver;
+
+#endif /* __ZX_DRM_DRV_H__ */
diff --git a/drivers/gpu/drm/zte/zx_hdmi.c b/drivers/gpu/drm/zte/zx_hdmi.c
new file mode 100644
index 000000000000..5aaab8493b1b
--- /dev/null
+++ b/drivers/gpu/drm/zte/zx_hdmi.c
@@ -0,0 +1,540 @@
+/*
+ * Copyright 2016 Linaro Ltd.
+ * Copyright 2016 ZTE Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <drm/drm_of.h>
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_edid.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/hdmi.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/component.h>
+
+#include "zx_crtc.h"
+
+#define FUNC_SEL			0x000b
+#define FUNC_HDMI_EN			BIT(0)
+#define CLKPWD				0x000d
+#define CLKPWD_PDIDCK			BIT(2)
+#define PWD_SRST			0x0010
+#define P2T_CTRL			0x0066
+#define P2T_DC_PKT_EN			BIT(7)
+#define L1_INTR_STAT			0x007e
+#define L1_INTR_STAT_INTR1		BIT(0)
+#define INTR1_STAT			0x008f
+#define INTR1_MASK			0x0095
+#define INTR1_MONITOR_DETECT		(BIT(5) | BIT(6))
+#define ZX_DDC_ADDR			0x00ed
+#define ZX_DDC_SEGM			0x00ee
+#define ZX_DDC_OFFSET			0x00ef
+#define ZX_DDC_DIN_CNT1			0x00f0
+#define ZX_DDC_DIN_CNT2			0x00f1
+#define ZX_DDC_CMD			0x00f3
+#define DDC_CMD_MASK			0xf
+#define DDC_CMD_CLEAR_FIFO		0x9
+#define DDC_CMD_SEQUENTIAL_READ		0x2
+#define ZX_DDC_DATA			0x00f4
+#define ZX_DDC_DOUT_CNT			0x00f5
+#define DDC_DOUT_CNT_MASK		0x1f
+#define TEST_TXCTRL			0x00f7
+#define TEST_TXCTRL_HDMI_MODE		BIT(1)
+#define HDMICTL4			0x0235
+#define TPI_HPD_RSEN			0x063b
+#define TPI_HPD_CONNECTION		(BIT(1) | BIT(2))
+#define TPI_INFO_FSEL			0x06bf
+#define FSEL_AVI			0
+#define FSEL_GBD			1
+#define FSEL_AUDIO			2
+#define FSEL_SPD			3
+#define FSEL_MPEG			4
+#define FSEL_VSIF			5
+#define TPI_INFO_B0			0x06c0
+#define TPI_INFO_EN			0x06df
+#define TPI_INFO_TRANS_EN		BIT(7)
+#define TPI_INFO_TRANS_RPT		BIT(6)
+#define TPI_DDC_MASTER_EN		0x06f8
+#define HW_DDC_MASTER			BIT(7)
+
+#define ZX_HDMI_INFOFRAME_SIZE		31
+
+struct zx_hdmi {
+	struct drm_connector connector;
+	struct drm_encoder encoder;
+	struct device *dev;
+	struct drm_device *drm;
+	void __iomem *mmio;
+	struct clk *cec_clk;
+	struct clk *osc_clk;
+	struct clk *xclk;
+	bool sink_is_hdmi;
+	bool sink_has_audio;
+	struct vou_inf *inf;
+};
+
+#define to_zx_hdmi(x)	container_of(x, struct zx_hdmi, x)
+
+static struct vou_inf vou_inf_hdmi = {
+	.id = VOU_HDMI,
+	.data_sel = VOU_YUV444,
+	.clocks_en_bits = BIT(24) | BIT(18) | BIT(6),
+	.clocks_sel_bits = BIT(13) | BIT(2),
+};
+
+static inline u8 hdmi_readb(struct zx_hdmi *hdmi, u16 offset)
+{
+	return readl_relaxed(hdmi->mmio + offset * 4);
+}
+
+static inline void hdmi_writeb(struct zx_hdmi *hdmi, u16 offset, u8 val)
+{
+	writel_relaxed(val, hdmi->mmio + offset * 4);
+}
+
+static int zx_hdmi_infoframe_trans(struct zx_hdmi *hdmi,
+				   union hdmi_infoframe *frame, u8 fsel)
+{
+	u8 buffer[ZX_HDMI_INFOFRAME_SIZE];
+	u8 val;
+	ssize_t num;
+	int i;
+
+	hdmi_writeb(hdmi, TPI_INFO_FSEL, fsel);
+
+	num = hdmi_infoframe_pack(frame, buffer, ZX_HDMI_INFOFRAME_SIZE);
+	if (num < 0)
+		return num;
+
+	for (i = 0; i < num; i++)
+		hdmi_writeb(hdmi, TPI_INFO_B0 + i, buffer[i]);
+
+	val = hdmi_readb(hdmi, TPI_INFO_EN);
+	val |= TPI_INFO_TRANS_EN | TPI_INFO_TRANS_RPT;
+	hdmi_writeb(hdmi, TPI_INFO_EN, val);
+
+	return num;
+}
+
+static int zx_hdmi_config_video_vsi(struct zx_hdmi *hdmi,
+				    struct drm_display_mode *mode)
+{
+	union hdmi_infoframe frame;
+	int ret;
+
+	ret = drm_hdmi_vendor_infoframe_from_display_mode(&frame.vendor.hdmi,
+							  mode);
+	if (ret)
+		return ret;
+
+	return zx_hdmi_infoframe_trans(hdmi, &frame, FSEL_VSIF);
+}
+
+static int zx_hdmi_config_video_avi(struct zx_hdmi *hdmi,
+				    struct drm_display_mode *mode)
+{
+	union hdmi_infoframe frame;
+	int ret;
+
+	ret = drm_hdmi_avi_infoframe_from_display_mode(&frame.avi, mode);
+	if (ret)
+		return ret;
+
+	/* We always use YUV444 for HDMI output. */
+	frame.avi.colorspace = HDMI_COLORSPACE_YUV444;
+
+	return zx_hdmi_infoframe_trans(hdmi, &frame, FSEL_AVI);
+}
+
+static void zx_hdmi_encoder_mode_set(struct drm_encoder *encoder,
+				     struct drm_display_mode *mode,
+				     struct drm_display_mode *adj_mode)
+{
+	struct zx_hdmi *hdmi = to_zx_hdmi(encoder);
+
+	if (hdmi->sink_is_hdmi) {
+		zx_hdmi_config_video_avi(hdmi, mode);
+		zx_hdmi_config_video_vsi(hdmi, mode);
+	}
+}
+
+static void zx_hdmi_encoder_enable(struct drm_encoder *encoder)
+{
+	struct zx_hdmi *hdmi = to_zx_hdmi(encoder);
+
+	vou_inf_enable(hdmi->inf);
+}
+
+static void zx_hdmi_encoder_disable(struct drm_encoder *encoder)
+{
+	struct zx_hdmi *hdmi = to_zx_hdmi(encoder);
+
+	vou_inf_disable(hdmi->inf);
+}
+
+static const struct drm_encoder_helper_funcs zx_hdmi_encoder_helper_funcs = {
+	.enable	= zx_hdmi_encoder_enable,
+	.disable = zx_hdmi_encoder_disable,
+	.mode_set = zx_hdmi_encoder_mode_set,
+};
+
+static const struct drm_encoder_funcs zx_hdmi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static int zx_hdmi_get_edid_block(void *data, u8 *buf, unsigned int block,
+				  size_t len)
+{
+	struct zx_hdmi *hdmi = data;
+	int retry = 0;
+	int ret = 0;
+	int i = 0;
+	u8 val;
+
+	/* Enable DDC master access */
+	val = hdmi_readb(hdmi, TPI_DDC_MASTER_EN);
+	val |= HW_DDC_MASTER;
+	hdmi_writeb(hdmi, TPI_DDC_MASTER_EN, val);
+
+	hdmi_writeb(hdmi, ZX_DDC_ADDR, 0xa0);
+	hdmi_writeb(hdmi, ZX_DDC_OFFSET, block * EDID_LENGTH);
+	/* Bits [9:8] of bytes */
+	hdmi_writeb(hdmi, ZX_DDC_DIN_CNT2, (len >> 8) & 0xff);
+	/* Bits [7:0] of bytes */
+	hdmi_writeb(hdmi, ZX_DDC_DIN_CNT1, len & 0xff);
+
+	/* Clear FIFO */
+	val = hdmi_readb(hdmi, ZX_DDC_CMD);
+	val &= ~DDC_CMD_MASK;
+	val |= DDC_CMD_CLEAR_FIFO;
+	hdmi_writeb(hdmi, ZX_DDC_CMD, val);
+
+	/* Kick off the read */
+	val = hdmi_readb(hdmi, ZX_DDC_CMD);
+	val &= ~DDC_CMD_MASK;
+	val |= DDC_CMD_SEQUENTIAL_READ;
+	hdmi_writeb(hdmi, ZX_DDC_CMD, val);
+
+	while (len > 0) {
+		int cnt, j;
+
+		/* FIFO needs some time to get ready */
+		usleep_range(500, 1000);
+
+		cnt = hdmi_readb(hdmi, ZX_DDC_DOUT_CNT) & DDC_DOUT_CNT_MASK;
+		if (cnt == 0) {
+			if (++retry > 5) {
+				dev_err(hdmi->dev, "DDC read timed out!");
+				ret = -ETIMEDOUT;
+				break;
+			}
+			continue;
+		}
+
+		for (j = 0; j < cnt; j++)
+			buf[i++] = hdmi_readb(hdmi, ZX_DDC_DATA);
+		len -= cnt;
+	}
+
+	/* Disable DDC master access */
+	val = hdmi_readb(hdmi, TPI_DDC_MASTER_EN);
+	val &= ~HW_DDC_MASTER;
+	hdmi_writeb(hdmi, TPI_DDC_MASTER_EN, val);
+
+	return ret;
+}
+
+static int zx_hdmi_connector_get_modes(struct drm_connector *connector)
+{
+	struct zx_hdmi *hdmi = to_zx_hdmi(connector);
+	struct edid *edid;
+	int ret = 0;
+
+	edid = drm_do_get_edid(connector, zx_hdmi_get_edid_block, hdmi);
+	if (edid) {
+		hdmi->sink_is_hdmi = drm_detect_hdmi_monitor(edid);
+		hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
+		drm_mode_connector_update_edid_property(connector, edid);
+		ret = drm_add_edid_modes(connector, edid);
+		kfree(edid);
+	}
+
+	return ret;
+}
+
+static enum drm_mode_status
+zx_hdmi_connector_mode_valid(struct drm_connector *connector,
+			     struct drm_display_mode *mode)
+{
+	return MODE_OK;
+}
+
+static struct drm_connector_helper_funcs zx_hdmi_connector_helper_funcs = {
+	.get_modes = zx_hdmi_connector_get_modes,
+	.mode_valid = zx_hdmi_connector_mode_valid,
+};
+
+static enum drm_connector_status
+zx_hdmi_connector_detect(struct drm_connector *connector, bool force)
+{
+	struct zx_hdmi *hdmi = to_zx_hdmi(connector);
+
+	return (hdmi_readb(hdmi, TPI_HPD_RSEN) & TPI_HPD_CONNECTION) ?
+		connector_status_connected : connector_status_disconnected;
+}
+
+static void zx_hdmi_connector_destroy(struct drm_connector *connector)
+{
+	drm_connector_unregister(connector);
+	drm_connector_cleanup(connector);
+}
+
+static const struct drm_connector_funcs zx_hdmi_connector_funcs = {
+	.dpms = drm_atomic_helper_connector_dpms,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.detect = zx_hdmi_connector_detect,
+	.destroy = zx_hdmi_connector_destroy,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static int zx_hdmi_register(struct drm_device *drm, struct zx_hdmi *hdmi)
+{
+	struct drm_encoder *encoder = &hdmi->encoder;
+
+	encoder->possible_crtcs = VOU_CRTC_MASK;
+
+	drm_encoder_init(drm, encoder, &zx_hdmi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
+	drm_encoder_helper_add(encoder, &zx_hdmi_encoder_helper_funcs);
+
+	hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
+
+	drm_connector_init(drm, &hdmi->connector, &zx_hdmi_connector_funcs,
+			   DRM_MODE_CONNECTOR_HDMIA);
+	drm_connector_helper_add(&hdmi->connector,
+				 &zx_hdmi_connector_helper_funcs);
+
+	drm_mode_connector_attach_encoder(&hdmi->connector, encoder);
+	drm_connector_register(&hdmi->connector);
+
+	return 0;
+}
+
+static irqreturn_t zx_hdmi_irq_thread(int irq, void *dev_id)
+{
+	struct zx_hdmi *hdmi = dev_id;
+
+	drm_helper_hpd_irq_event(hdmi->connector.dev);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t zx_hdmi_irq_handler(int irq, void *dev_id)
+{
+	struct zx_hdmi *hdmi = dev_id;
+	u8 lstat;
+
+	lstat = hdmi_readb(hdmi, L1_INTR_STAT);
+
+	/* Monitor detect/HPD interrupt */
+	if (lstat & L1_INTR_STAT_INTR1) {
+		u8 stat = hdmi_readb(hdmi, INTR1_STAT);
+
+		hdmi_writeb(hdmi, INTR1_STAT, stat);
+		if (stat & INTR1_MONITOR_DETECT)
+			return IRQ_WAKE_THREAD;
+	}
+
+	return IRQ_NONE;
+}
+
+static void zx_hdmi_phy_start(struct zx_hdmi *hdmi)
+{
+	/* Copy from ZTE BSP code */
+	hdmi_writeb(hdmi, 0x222, 0x0);
+	hdmi_writeb(hdmi, 0x224, 0x4);
+	hdmi_writeb(hdmi, 0x909, 0x0);
+	hdmi_writeb(hdmi, 0x7b0, 0x90);
+	hdmi_writeb(hdmi, 0x7b1, 0x00);
+	hdmi_writeb(hdmi, 0x7b2, 0xa7);
+	hdmi_writeb(hdmi, 0x7b8, 0xaa);
+	hdmi_writeb(hdmi, 0x7b2, 0xa7);
+	hdmi_writeb(hdmi, 0x7b3, 0x0f);
+	hdmi_writeb(hdmi, 0x7b4, 0x0f);
+	hdmi_writeb(hdmi, 0x7b5, 0x55);
+	hdmi_writeb(hdmi, 0x7b7, 0x03);
+	hdmi_writeb(hdmi, 0x7b9, 0x12);
+	hdmi_writeb(hdmi, 0x7ba, 0x32);
+	hdmi_writeb(hdmi, 0x7bc, 0x68);
+	hdmi_writeb(hdmi, 0x7be, 0x40);
+	hdmi_writeb(hdmi, 0x7bf, 0x84);
+	hdmi_writeb(hdmi, 0x7c1, 0x0f);
+	hdmi_writeb(hdmi, 0x7c8, 0x02);
+	hdmi_writeb(hdmi, 0x7c9, 0x03);
+	hdmi_writeb(hdmi, 0x7ca, 0x40);
+	hdmi_writeb(hdmi, 0x7dc, 0x31);
+	hdmi_writeb(hdmi, 0x7e2, 0x04);
+	hdmi_writeb(hdmi, 0x7e0, 0x06);
+	hdmi_writeb(hdmi, 0x7cb, 0x68);
+	hdmi_writeb(hdmi, 0x7f9, 0x02);
+	hdmi_writeb(hdmi, 0x7b6, 0x02);
+	hdmi_writeb(hdmi, 0x7f3, 0x0);
+}
+
+static void zx_hdmi_hw_init(struct zx_hdmi *hdmi)
+{
+	u8 val;
+
+	/* Software reset */
+	hdmi_writeb(hdmi, PWD_SRST, 1);
+
+	/* Enable pclk */
+	val = hdmi_readb(hdmi, CLKPWD);
+	val |= CLKPWD_PDIDCK;
+	hdmi_writeb(hdmi, CLKPWD, val);
+
+	/* Enable HDMI for TX */
+	val = hdmi_readb(hdmi, FUNC_SEL);
+	val |= FUNC_HDMI_EN;
+	hdmi_writeb(hdmi, FUNC_SEL, val);
+
+	/* Enable deep color packet */
+	val = hdmi_readb(hdmi, P2T_CTRL);
+	val |= P2T_DC_PKT_EN;
+	hdmi_writeb(hdmi, P2T_CTRL, val);
+
+	/* Enable HDMI/MHL mode for output */
+	val = hdmi_readb(hdmi, TEST_TXCTRL);
+	val |= TEST_TXCTRL_HDMI_MODE;
+	hdmi_writeb(hdmi, TEST_TXCTRL, val);
+
+	/* Configure reg_qc_sel */
+	hdmi_writeb(hdmi, HDMICTL4, 0x3);
+
+	/* Enable interrupt */
+	val = hdmi_readb(hdmi, INTR1_MASK);
+	val |= INTR1_MONITOR_DETECT;
+	hdmi_writeb(hdmi, INTR1_MASK, val);
+
+	/* Clear reset for normal operation */
+	hdmi_writeb(hdmi, PWD_SRST, 0);
+
+	/* Start up phy */
+	zx_hdmi_phy_start(hdmi);
+}
+
+static int zx_hdmi_bind(struct device *dev, struct device *master, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_device *drm = data;
+	struct resource *res;
+	struct zx_hdmi *hdmi;
+	struct vou_inf *inf;
+	int irq;
+	int ret;
+
+	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
+	if (!hdmi)
+		return -ENOMEM;
+
+	hdmi->dev = dev;
+	hdmi->drm = drm;
+
+	inf = &vou_inf_hdmi;
+	inf->encoder = &hdmi->encoder;
+	hdmi->inf = inf;
+
+	dev_set_drvdata(dev, hdmi);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hdmi->mmio = devm_ioremap_resource(dev, res);
+	if (IS_ERR(hdmi->mmio))
+		return PTR_ERR(hdmi->mmio);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	hdmi->cec_clk = devm_clk_get(hdmi->dev, "osc_cec");
+	if (IS_ERR(hdmi->cec_clk))
+		return PTR_ERR(hdmi->cec_clk);
+
+	hdmi->osc_clk = devm_clk_get(hdmi->dev, "osc_clk");
+	if (IS_ERR(hdmi->osc_clk))
+		return PTR_ERR(hdmi->osc_clk);
+
+	hdmi->xclk = devm_clk_get(hdmi->dev, "xclk");
+	if (IS_ERR(hdmi->xclk))
+		return PTR_ERR(hdmi->xclk);
+
+	zx_hdmi_hw_init(hdmi);
+
+	clk_prepare_enable(hdmi->cec_clk);
+	clk_prepare_enable(hdmi->osc_clk);
+	clk_prepare_enable(hdmi->xclk);
+
+	ret = zx_hdmi_register(drm, hdmi);
+	if (ret)
+		return ret;
+
+	ret = devm_request_threaded_irq(dev, irq, zx_hdmi_irq_handler,
+					zx_hdmi_irq_thread, IRQF_SHARED,
+					dev_name(dev), hdmi);
+
+	return 0;
+}
+
+static void zx_hdmi_unbind(struct device *dev, struct device *master,
+			   void *data)
+{
+	struct zx_hdmi *hdmi = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(hdmi->cec_clk);
+	clk_disable_unprepare(hdmi->osc_clk);
+	clk_disable_unprepare(hdmi->xclk);
+}
+
+static const struct component_ops zx_hdmi_component_ops = {
+	.bind = zx_hdmi_bind,
+	.unbind = zx_hdmi_unbind,
+};
+
+static int zx_hdmi_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &zx_hdmi_component_ops);
+}
+
+static int zx_hdmi_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &zx_hdmi_component_ops);
+	return 0;
+}
+
+static const struct of_device_id zx_hdmi_of_match[] = {
+	{ .compatible = "zte,zx296718-hdmi", },
+	{ /* end */ },
+};
+MODULE_DEVICE_TABLE(of, zx_hdmi_of_match);
+
+struct platform_driver zx_hdmi_driver = {
+	.probe = zx_hdmi_probe,
+	.remove = zx_hdmi_remove,
+	.driver	= {
+		.name = "zx-hdmi",
+		.of_match_table	= zx_hdmi_of_match,
+	},
+};
diff --git a/drivers/gpu/drm/zte/zx_plane.c b/drivers/gpu/drm/zte/zx_plane.c
new file mode 100644
index 000000000000..326cc1ff7950
--- /dev/null
+++ b/drivers/gpu/drm/zte/zx_plane.c
@@ -0,0 +1,362 @@
+/*
+ * Copyright 2016 Linaro Ltd.
+ * Copyright 2016 ZTE Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_plane_helper.h>
+
+#include "zx_crtc.h"
+#include "zx_plane.h"
+
+/* GL registers */
+#define GL_CTRL0			0x00
+#define GL_UPDATE			BIT(5)
+#define GL_CTRL1			0x04
+#define GL_DATA_FMT_SHIFT		0
+#define GL_DATA_FMT_MASK		(0xf << GL_DATA_FMT_SHIFT)
+#define GL_FMT_ARGB8888			0
+#define GL_FMT_RGB888			1
+#define GL_FMT_RGB565			2
+#define GL_FMT_ARGB1555			3
+#define GL_FMT_ARGB4444			4
+#define GL_CTRL2			0x08
+#define GL_GLOBAL_ALPHA_SHIFT		8
+#define GL_GLOBAL_ALPHA_MASK		(0xff << GL_GLOBAL_ALPHA_SHIFT)
+#define GL_CTRL3			0x0c
+#define GL_SCALER_BYPASS_MODE		BIT(0)
+#define GL_STRIDE			0x18
+#define GL_ADDR				0x1c
+#define GL_SRC_SIZE			0x38
+#define GL_SRC_W_SHIFT			16
+#define GL_SRC_W_MASK			(0x3fff << GL_SRC_W_SHIFT)
+#define GL_SRC_H_SHIFT			0
+#define GL_SRC_H_MASK			(0x3fff << GL_SRC_H_SHIFT)
+#define GL_POS_START			0x9c
+#define GL_POS_END			0xa0
+#define GL_POS_X_SHIFT			16
+#define GL_POS_X_MASK			(0x1fff << GL_POS_X_SHIFT)
+#define GL_POS_Y_SHIFT			0
+#define GL_POS_Y_MASK			(0x1fff << GL_POS_Y_SHIFT)
+
+/* CSC registers */
+#define CSC_CTRL0			0x30
+#define CSC_COV_MODE_SHIFT		16
+#define CSC_COV_MODE_MASK		(0xffff << CSC_COV_MODE_SHIFT)
+#define CSC_BT601_IMAGE_RGB2YCBCR	0
+#define CSC_BT601_IMAGE_YCBCR2RGB	1
+#define CSC_BT601_VIDEO_RGB2YCBCR	2
+#define CSC_BT601_VIDEO_YCBCR2RGB	3
+#define CSC_BT709_IMAGE_RGB2YCBCR	4
+#define CSC_BT709_IMAGE_YCBCR2RGB	5
+#define CSC_BT709_VIDEO_RGB2YCBCR	6
+#define CSC_BT709_VIDEO_YCBCR2RGB	7
+#define CSC_BT2020_IMAGE_RGB2YCBCR	8
+#define CSC_BT2020_IMAGE_YCBCR2RGB	9
+#define CSC_BT2020_VIDEO_RGB2YCBCR	10
+#define CSC_BT2020_VIDEO_YCBCR2RGB	11
+#define CSC_WORK_ENABLE			BIT(0)
+
+/* RSZ registers */
+#define RSZ_SRC_CFG			0x00
+#define RSZ_DEST_CFG			0x04
+#define RSZ_ENABLE_CFG			0x14
+
+/* HBSC registers */
+#define HBSC_SATURATION			0x00
+#define HBSC_HUE			0x04
+#define HBSC_BRIGHT			0x08
+#define HBSC_CONTRAST			0x0c
+#define HBSC_THRESHOLD_COL1		0x10
+#define HBSC_THRESHOLD_COL2		0x14
+#define HBSC_THRESHOLD_COL3		0x18
+#define HBSC_CTRL0			0x28
+#define HBSC_CTRL_EN			BIT(2)
+
+struct zx_plane {
+	struct drm_plane plane;
+	void __iomem *layer;
+	void __iomem *csc;
+	void __iomem *hbsc;
+	void __iomem *rsz;
+};
+
+#define to_zx_plane(plane)	container_of(plane, struct zx_plane, plane)
+
+static const uint32_t gl_formats[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_ARGB4444,
+};
+
+static int zx_gl_plane_atomic_check(struct drm_plane *plane,
+				    struct drm_plane_state *state)
+{
+	u32 src_w, src_h;
+
+	src_w = state->src_w >> 16;
+	src_h = state->src_h >> 16;
+
+	/* TODO: support scaling of the plane source */
+	if ((src_w != state->crtc_w) || (src_h != state->crtc_h))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int zx_gl_get_fmt(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_ARGB8888:
+	case DRM_FORMAT_XRGB8888:
+		return GL_FMT_ARGB8888;
+	case DRM_FORMAT_RGB888:
+		return GL_FMT_RGB888;
+	case DRM_FORMAT_RGB565:
+		return GL_FMT_RGB565;
+	case DRM_FORMAT_ARGB1555:
+		return GL_FMT_ARGB1555;
+	case DRM_FORMAT_ARGB4444:
+		return GL_FMT_ARGB4444;
+	default:
+		WARN_ONCE(1, "invalid pixel format %d\n", format);
+		return -EINVAL;
+	}
+}
+
+static inline void zx_gl_set_update(struct zx_plane *zplane)
+{
+	void __iomem *layer = zplane->layer;
+	u32 val;
+
+	val = readl(layer + GL_CTRL0);
+	val |= GL_UPDATE;
+	writel(val, layer + GL_CTRL0);
+}
+
+static inline void zx_gl_rsz_set_update(struct zx_plane *zplane)
+{
+	writel(1, zplane->rsz + RSZ_ENABLE_CFG);
+}
+
+void zx_plane_set_update(struct drm_plane *plane)
+{
+	struct zx_plane *zplane = to_zx_plane(plane);
+
+	zx_gl_rsz_set_update(zplane);
+	zx_gl_set_update(zplane);
+}
+
+static void zx_gl_rsz_setup(struct zx_plane *zplane, u32 src_w, u32 src_h,
+			    u32 dst_w, u32 dst_h)
+{
+	void __iomem *rsz = zplane->rsz;
+	u32 val;
+
+	val = ((src_h - 1) & 0xffff) << 16;
+	val |= (src_w - 1) & 0xffff;
+	writel(val, rsz + RSZ_SRC_CFG);
+
+	val = ((dst_h - 1) & 0xffff) << 16;
+	val |= (dst_w - 1) & 0xffff;
+	writel(val, rsz + RSZ_DEST_CFG);
+
+	zx_gl_rsz_set_update(zplane);
+}
+
+static void zx_gl_plane_atomic_update(struct drm_plane *plane,
+				      struct drm_plane_state *old_state)
+{
+	struct zx_plane *zplane = to_zx_plane(plane);
+	struct drm_framebuffer *fb = plane->state->fb;
+	struct drm_gem_cma_object *cma_obj;
+	void __iomem *layer = zplane->layer;
+	void __iomem *csc = zplane->csc;
+	void __iomem *hbsc = zplane->hbsc;
+	u32 src_x, src_y, src_w, src_h;
+	u32 dst_x, dst_y, dst_w, dst_h;
+	unsigned int depth, bpp;
+	uint32_t format;
+	dma_addr_t paddr;
+	u32 stride;
+	int fmt;
+	u32 val;
+
+	if (!fb)
+		return;
+
+	format = fb->pixel_format;
+	stride = fb->pitches[0];
+
+	src_x = plane->state->src_x >> 16;
+	src_y = plane->state->src_y >> 16;
+	src_w = plane->state->src_w >> 16;
+	src_h = plane->state->src_h >> 16;
+
+	dst_x = plane->state->crtc_x;
+	dst_y = plane->state->crtc_y;
+	dst_w = plane->state->crtc_w;
+	dst_h = plane->state->crtc_h;
+
+	drm_fb_get_bpp_depth(format, &depth, &bpp);
+
+	cma_obj = drm_fb_cma_get_gem_obj(fb, 0);
+	paddr = cma_obj->paddr + fb->offsets[0];
+	paddr += src_y * stride + src_x * bpp / 8;
+	writel(paddr, layer + GL_ADDR);
+
+	/* Set up source height/width register */
+	val = (src_w << GL_SRC_W_SHIFT) & GL_SRC_W_MASK;
+	val |= (src_h << GL_SRC_H_SHIFT) & GL_SRC_H_MASK;
+	writel(val, layer + GL_SRC_SIZE);
+
+	/* Set up start position register */
+	val = (dst_x << GL_POS_X_SHIFT) & GL_POS_X_MASK;
+	val |= (dst_y << GL_POS_Y_SHIFT) & GL_POS_Y_MASK;
+	writel(val, layer + GL_POS_START);
+
+	/* Set up end position register */
+	val = ((dst_x + dst_w) << GL_POS_X_SHIFT) & GL_POS_X_MASK;
+	val |= ((dst_y + dst_h) << GL_POS_Y_SHIFT) & GL_POS_Y_MASK;
+	writel(val, layer + GL_POS_END);
+
+	/* Set up stride register */
+	writel(stride & 0xffff, layer + GL_STRIDE);
+
+	/* Set up graphic layer data format */
+	fmt = zx_gl_get_fmt(format);
+	if (fmt >= 0) {
+		val = readl(layer + GL_CTRL1);
+		val &= ~GL_DATA_FMT_MASK;
+		val |= fmt << GL_DATA_FMT_SHIFT;
+		writel(val, layer + GL_CTRL1);
+	}
+
+	/* Initialize global alpha with a sane value */
+	val = readl(layer + GL_CTRL2);
+	val &= ~GL_GLOBAL_ALPHA_MASK;
+	val |= 0xff << GL_GLOBAL_ALPHA_SHIFT;
+	writel(val, layer + GL_CTRL2);
+
+	/* Setup CSC for the GL */
+	val = readl(csc + CSC_CTRL0);
+	val &= ~CSC_COV_MODE_MASK;
+	if (dst_h > 720)
+		val |= CSC_BT709_IMAGE_RGB2YCBCR << CSC_COV_MODE_SHIFT;
+	else
+		val |= CSC_BT601_IMAGE_RGB2YCBCR << CSC_COV_MODE_SHIFT;
+	val |= CSC_WORK_ENABLE;
+	writel(val, csc + CSC_CTRL0);
+
+	/* Always use scaler since it exists */
+	val = readl(layer + GL_CTRL3);
+	val |= GL_SCALER_BYPASS_MODE;	/* set for not bypass */
+	writel(val, layer + GL_CTRL3);
+
+	zx_gl_rsz_setup(zplane, src_w, src_h, dst_w, dst_h);
+
+	/* Enable HBSC block */
+	val = readl(hbsc + HBSC_CTRL0);
+	val |= HBSC_CTRL_EN;
+	writel(val, hbsc + HBSC_CTRL0);
+
+	zx_gl_set_update(zplane);
+}
+
+static const struct drm_plane_helper_funcs zx_gl_plane_helper_funcs = {
+	.atomic_check = zx_gl_plane_atomic_check,
+	.atomic_update = zx_gl_plane_atomic_update,
+};
+
+static void zx_plane_destroy(struct drm_plane *plane)
+{
+	drm_plane_helper_disable(plane);
+	drm_plane_cleanup(plane);
+}
+
+static const struct drm_plane_funcs zx_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = zx_plane_destroy,
+	.reset = drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+};
+
+static void zx_plane_hbsc_init(struct zx_plane *zplane)
+{
+	void __iomem *hbsc = zplane->hbsc;
+
+	/*
+	 *  Initialize HBSC block with a sane configuration per recommedation
+	 *  from ZTE BSP code.
+	 */
+	writel(0x200, hbsc + HBSC_SATURATION);
+	writel(0x0, hbsc + HBSC_HUE);
+	writel(0x0, hbsc + HBSC_BRIGHT);
+	writel(0x200, hbsc + HBSC_CONTRAST);
+
+	writel((0x3ac << 16) | 0x40, hbsc + HBSC_THRESHOLD_COL1);
+	writel((0x3c0 << 16) | 0x40, hbsc + HBSC_THRESHOLD_COL2);
+	writel((0x3c0 << 16) | 0x40, hbsc + HBSC_THRESHOLD_COL3);
+}
+
+struct drm_plane *zx_plane_init(struct drm_device *drm, struct device *dev,
+				struct zx_layer_data *data,
+				enum drm_plane_type type)
+{
+	const struct drm_plane_helper_funcs *helper;
+	struct zx_plane *zplane;
+	struct drm_plane *plane;
+	const uint32_t *formats;
+	unsigned int format_count;
+	int ret;
+
+	zplane = devm_kzalloc(dev, sizeof(*zplane), GFP_KERNEL);
+	if (!zplane)
+		return ERR_PTR(-ENOMEM);
+
+	plane = &zplane->plane;
+
+	zplane->layer = data->layer;
+	zplane->hbsc = data->hbsc;
+	zplane->csc = data->csc;
+	zplane->rsz = data->rsz;
+
+	zx_plane_hbsc_init(zplane);
+
+	switch (type) {
+	case DRM_PLANE_TYPE_PRIMARY:
+		helper = &zx_gl_plane_helper_funcs;
+		formats = gl_formats;
+		format_count = ARRAY_SIZE(gl_formats);
+		break;
+	case DRM_PLANE_TYPE_OVERLAY:
+		/* TODO: add video layer (vl) support */
+		break;
+	default:
+		return ERR_PTR(-ENODEV);
+	}
+
+	ret = drm_universal_plane_init(drm, plane, VOU_CRTC_MASK,
+				       &zx_plane_funcs, formats, format_count,
+				       type, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	drm_plane_helper_add(plane, helper);
+
+	return plane;
+}
diff --git a/drivers/gpu/drm/zte/zx_plane.h b/drivers/gpu/drm/zte/zx_plane.h
new file mode 100644
index 000000000000..2b82cd558d9d
--- /dev/null
+++ b/drivers/gpu/drm/zte/zx_plane.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright 2016 Linaro Ltd.
+ * Copyright 2016 ZTE Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ZX_PLANE_H__
+#define __ZX_PLANE_H__
+
+struct zx_layer_data {
+	void __iomem *layer;
+	void __iomem *csc;
+	void __iomem *hbsc;
+	void __iomem *rsz;
+};
+
+struct drm_plane *zx_plane_init(struct drm_device *drm, struct device *dev,
+				struct zx_layer_data *data,
+				enum drm_plane_type type);
+void zx_plane_set_update(struct drm_plane *plane);
+
+#endif /* __ZX_PLANE_H__ */
-- 
1.9.1
