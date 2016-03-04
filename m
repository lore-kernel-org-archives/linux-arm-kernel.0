From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Fri,  4 Mar 2016 18:54:29 +0800
Subject: [PATCH v7 03/11] drm/hisilicon: Add crtc driver for ADE
In-Reply-To: <1457088877-131022-1-git-send-email-xinliang.liu@linaro.org>
References: <1457088877-131022-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1457088877-131022-4-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add crtc funcs and helper funcs for ADE.

v7:
- A few Regs define clean up and typo fixs.
v6:
- Cleanup reg-names dt parsing.
v5:
- Use syscon to access ADE media NOC QoS registers instead of directly
  writing registers.
- Use reset controller to reset ADE instead of directly writing registers.
v4: None.
v3:
- Make ade as the master driver.
- Use port to connect with encoder.
- A few cleanup.
v2:
- Remove abtraction layer.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
---
 drivers/gpu/drm/hisilicon/kirin/Makefile        |   3 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h | 230 ++++++++++++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 462 ++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c |  12 +
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |   8 +
 5 files changed, 714 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
 create mode 100644 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c

diff --git a/drivers/gpu/drm/hisilicon/kirin/Makefile b/drivers/gpu/drm/hisilicon/kirin/Makefile
index cb346de47d48..2a61ab006ddb 100644
--- a/drivers/gpu/drm/hisilicon/kirin/Makefile
+++ b/drivers/gpu/drm/hisilicon/kirin/Makefile
@@ -1,3 +1,4 @@
-kirin-drm-y := kirin_drm_drv.o
+kirin-drm-y := kirin_drm_drv.o \
+	       kirin_drm_ade.o
 
 obj-$(CONFIG_DRM_HISI_KIRIN) += kirin-drm.o
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
new file mode 100644
index 000000000000..4cf281b7ed63
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
@@ -0,0 +1,230 @@
+/*
+ * Copyright (c) 2016 Linaro Limited.
+ * Copyright (c) 2014-2016 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __KIRIN_ADE_REG_H__
+#define __KIRIN_ADE_REG_H__
+
+/*
+ * ADE Registers
+ */
+#define MASK(x)				(BIT(x) - 1)
+
+#define ADE_CTRL			0x0004
+#define FRM_END_START_OFST		0
+#define FRM_END_START_MASK		MASK(2)
+#define AUTO_CLK_GATE_EN_OFST		0
+#define AUTO_CLK_GATE_EN		BIT(0)
+#define ADE_DISP_SRC_CFG		0x0018
+#define ADE_CTRL1			0x008C
+#define ADE_EN				0x0100
+#define ADE_DISABLE			0
+#define ADE_ENABLE			1
+/* reset and reload regs */
+#define ADE_SOFT_RST_SEL(x)		(0x0078 + (x) * 0x4)
+#define ADE_RELOAD_DIS(x)		(0x00AC + (x) * 0x4)
+#define RDMA_OFST			0
+#define CLIP_OFST			15
+#define SCL_OFST			21
+#define CTRAN_OFST			24
+#define OVLY_OFST			37 /* 32+5 */
+/* channel regs */
+#define RD_CH_CTRL(x)			(0x1004 + (x) * 0x80)
+#define RD_CH_ADDR(x)			(0x1008 + (x) * 0x80)
+#define RD_CH_SIZE(x)			(0x100C + (x) * 0x80)
+#define RD_CH_STRIDE(x)			(0x1010 + (x) * 0x80)
+#define RD_CH_SPACE(x)			(0x1014 + (x) * 0x80)
+#define RD_CH_EN(x)			(0x1020 + (x) * 0x80)
+/* overlay regs */
+#define ADE_OVLY1_TRANS_CFG		0x002C
+#define ADE_OVLY_CTL			0x0098
+#define ADE_OVLY_CH_XY0(x)		(0x2004 + (x) * 4)
+#define ADE_OVLY_CH_XY1(x)		(0x2024 + (x) * 4)
+#define ADE_OVLY_CH_CTL(x)		(0x204C + (x) * 4)
+#define ADE_OVLY_OUTPUT_SIZE(x)		(0x2070 + (x) * 8)
+#define OUTPUT_XSIZE_OFST		16
+#define ADE_OVLYX_CTL(x)		(0x209C + (x) * 4)
+#define CH_OVLY_SEL_OFST(x)		((x) * 4)
+#define CH_OVLY_SEL_MASK		MASK(2)
+#define CH_OVLY_SEL_VAL(x)		((x) + 1)
+#define CH_ALP_MODE_OFST		0
+#define CH_ALP_SEL_OFST			2
+#define CH_UNDER_ALP_SEL_OFST		4
+#define CH_EN_OFST			6
+#define CH_ALP_GBL_OFST			15
+#define CH_SEL_OFST			28
+/* ctran regs */
+#define ADE_CTRAN_DIS(x)		(0x5004 + (x) * 0x100)
+#define CTRAN_BYPASS_ON			1
+#define CTRAN_BYPASS_OFF		0
+#define ADE_CTRAN_IMAGE_SIZE(x)		(0x503C + (x) * 0x100)
+/* clip regs */
+#define ADE_CLIP_DISABLE(x)		(0x6800 + (x) * 0x100)
+#define ADE_CLIP_SIZE0(x)		(0x6804 + (x) * 0x100)
+#define ADE_CLIP_SIZE1(x)		(0x6808 + (x) * 0x100)
+
+/*
+ * LDI Registers
+ */
+#define LDI_HRZ_CTRL0			0x7400
+#define HBP_OFST			20
+#define LDI_HRZ_CTRL1			0x7404
+#define LDI_VRT_CTRL0			0x7408
+#define VBP_OFST			20
+#define LDI_VRT_CTRL1			0x740C
+#define LDI_PLR_CTRL			0x7410
+#define FLAG_NVSYNC			BIT(0)
+#define FLAG_NHSYNC			BIT(1)
+#define FLAG_NPIXCLK			BIT(2)
+#define FLAG_NDE			BIT(3)
+#define LDI_DSP_SIZE			0x7414
+#define VSIZE_OFST			20
+#define LDI_INT_EN			0x741C
+#define FRAME_END_INT_EN_OFST		1
+#define LDI_CTRL			0x7420
+#define BPP_OFST			3
+#define DATA_GATE_EN			BIT(2)
+#define LDI_EN				BIT(0)
+#define LDI_MSK_INT			0x7428
+#define LDI_INT_CLR			0x742C
+#define LDI_WORK_MODE			0x7430
+#define LDI_HDMI_DSI_GT			0x7434
+
+/*
+ * ADE media bus service regs
+ */
+#define ADE0_QOSGENERATOR_MODE		0x010C
+#define QOSGENERATOR_MODE_MASK		MASK(2)
+#define ADE0_QOSGENERATOR_EXTCONTROL	0x0118
+#define SOCKET_QOS_EN			BIT(0)
+#define ADE1_QOSGENERATOR_MODE		0x020C
+#define ADE1_QOSGENERATOR_EXTCONTROL	0x0218
+
+/*
+ * ADE regs relevant enums
+ */
+enum frame_end_start {
+	/* regs take effect in every vsync */
+	REG_EFFECTIVE_IN_VSYNC = 0,
+	/* regs take effect in fist ade en and every frame end */
+	REG_EFFECTIVE_IN_ADEEN_FRMEND,
+	/* regs take effect in ade en immediately */
+	REG_EFFECTIVE_IN_ADEEN,
+	/* regs take effect in first vsync and every frame end */
+	REG_EFFECTIVE_IN_VSYNC_FRMEND
+};
+
+enum ade_fb_format {
+	ADE_RGB_565 = 0,
+	ADE_BGR_565,
+	ADE_XRGB_8888,
+	ADE_XBGR_8888,
+	ADE_ARGB_8888,
+	ADE_ABGR_8888,
+	ADE_RGBA_8888,
+	ADE_BGRA_8888,
+	ADE_RGB_888,
+	ADE_BGR_888 = 9,
+	ADE_FORMAT_UNSUPPORT = 800
+};
+
+enum ade_channel {
+	ADE_CH1 = 0,	/* channel 1 for primary plane */
+	ADE_CH_NUM
+};
+
+enum ade_scale {
+	ADE_SCL1 = 0,
+	ADE_SCL2,
+	ADE_SCL3,
+	ADE_SCL_NUM
+};
+
+enum ade_ctran {
+	ADE_CTRAN1 = 0,
+	ADE_CTRAN2,
+	ADE_CTRAN3,
+	ADE_CTRAN4,
+	ADE_CTRAN5,
+	ADE_CTRAN6,
+	ADE_CTRAN_NUM
+};
+
+enum ade_overlay {
+	ADE_OVLY1 = 0,
+	ADE_OVLY2,
+	ADE_OVLY3,
+	ADE_OVLY_NUM
+};
+
+enum ade_alpha_mode {
+	ADE_ALP_GLOBAL = 0,
+	ADE_ALP_PIXEL,
+	ADE_ALP_PIXEL_AND_GLB
+};
+
+enum ade_alpha_blending_mode {
+	ADE_ALP_MUL_COEFF_0 = 0,	/* alpha */
+	ADE_ALP_MUL_COEFF_1,		/* 1-alpha */
+	ADE_ALP_MUL_COEFF_2,		/* 0 */
+	ADE_ALP_MUL_COEFF_3		/* 1 */
+};
+
+/*
+ * LDI regs relevant enums
+ */
+enum dsi_pclk_en {
+	DSI_PCLK_ON = 0,
+	DSI_PCLK_OFF
+};
+
+enum ldi_output_format {
+	LDI_OUT_RGB_565 = 0,
+	LDI_OUT_RGB_666,
+	LDI_OUT_RGB_888
+};
+
+enum ldi_work_mode {
+	TEST_MODE = 0,
+	NORMAL_MODE
+};
+
+enum ldi_input_source {
+	DISP_SRC_NONE = 0,
+	DISP_SRC_OVLY2,
+	DISP_SRC_DISP,
+	DISP_SRC_ROT,
+	DISP_SRC_SCL2
+};
+
+/*
+ * ADE media bus service relevant enums
+ */
+enum qos_generator_mode {
+	FIXED_MODE = 0,
+	LIMITER_MODE,
+	BYPASS_MODE,
+	REGULATOR_MODE
+};
+
+/*
+ * Register Write/Read Helper functions
+ */
+static inline void ade_update_bits(void __iomem *addr, u32 bit_start,
+				   u32 mask, u32 val)
+{
+	u32 tmp, orig;
+
+	orig = readl(addr);
+	tmp = orig & ~(mask << bit_start);
+	tmp |= (val & mask) << bit_start;
+	writel(tmp, addr);
+}
+
+#endif
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
new file mode 100644
index 000000000000..cfbea957297b
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -0,0 +1,462 @@
+/*
+ * Hisilicon Hi6220 SoC ADE(Advanced Display Engine)'s crtc&plane driver
+ *
+ * Copyright (c) 2016 Linaro Limited.
+ * Copyright (c) 2014-2016 Hisilicon Limited.
+ *
+ * Author:
+ *	Xinliang Liu <z.liuxinliang@hisilicon.com>
+ *	Xinliang Liu <xinliang.liu@linaro.org>
+ *	Xinwei Kong <kong.kongxinwei@hisilicon.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <video/display_timing.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+
+#include "kirin_drm_drv.h"
+#include "kirin_ade_reg.h"
+
+#define to_ade_crtc(crtc) \
+	container_of(crtc, struct ade_crtc, base)
+
+struct ade_hw_ctx {
+	void __iomem  *base;
+	struct regmap *noc_regmap;
+	struct clk *ade_core_clk;
+	struct clk *media_noc_clk;
+	struct clk *ade_pix_clk;
+	struct reset_control *reset;
+	bool power_on;
+	int irq;
+};
+
+struct ade_crtc {
+	struct drm_crtc base;
+	struct ade_hw_ctx *ctx;
+	bool enable;
+	u32 out_format;
+};
+
+struct ade_data {
+	struct ade_crtc acrtc;
+	struct ade_hw_ctx ctx;
+};
+
+static void ade_update_reload_bit(void __iomem *base, u32 bit_num, u32 val)
+{
+	u32 bit_ofst, reg_num;
+
+	bit_ofst = bit_num % 32;
+	reg_num = bit_num / 32;
+
+	ade_update_bits(base + ADE_RELOAD_DIS(reg_num), bit_ofst,
+			MASK(1), !!val);
+}
+
+static u32 ade_read_reload_bit(void __iomem *base, u32 bit_num)
+{
+	u32 tmp, bit_ofst, reg_num;
+
+	bit_ofst = bit_num % 32;
+	reg_num = bit_num / 32;
+
+	tmp = readl(base + ADE_RELOAD_DIS(reg_num));
+	return !!(BIT(bit_ofst) & tmp);
+}
+
+static void ade_init(struct ade_hw_ctx *ctx)
+{
+	void __iomem *base = ctx->base;
+
+	/* enable clk gate */
+	ade_update_bits(base + ADE_CTRL1, AUTO_CLK_GATE_EN_OFST,
+			AUTO_CLK_GATE_EN, ADE_ENABLE);
+	/* clear overlay */
+	writel(0, base + ADE_OVLY1_TRANS_CFG);
+	writel(0, base + ADE_OVLY_CTL);
+	writel(0, base + ADE_OVLYX_CTL(ADE_OVLY2));
+	/* clear reset and reload regs */
+	writel(MASK(32), base + ADE_SOFT_RST_SEL(0));
+	writel(MASK(32), base + ADE_SOFT_RST_SEL(1));
+	writel(MASK(32), base + ADE_RELOAD_DIS(0));
+	writel(MASK(32), base + ADE_RELOAD_DIS(1));
+	/*
+	 * for video mode, all the ade registers should
+	 * become effective at frame end.
+	 */
+	ade_update_bits(base + ADE_CTRL, FRM_END_START_OFST,
+			FRM_END_START_MASK, REG_EFFECTIVE_IN_ADEEN_FRMEND);
+}
+
+static void ade_set_pix_clk(struct ade_hw_ctx *ctx,
+			    struct drm_display_mode *mode,
+			    struct drm_display_mode *adj_mode)
+{
+	u32 clk_Hz = mode->clock * 1000;
+	int ret;
+
+	/*
+	 * Success should be guaranteed in mode_valid call back,
+	 * so failure shouldn't happen here
+	 */
+	ret = clk_set_rate(ctx->ade_pix_clk, clk_Hz);
+	if (ret)
+		DRM_ERROR("failed to set pixel clk %dHz (%d)\n", clk_Hz, ret);
+	adj_mode->clock = clk_get_rate(ctx->ade_pix_clk) / 1000;
+}
+
+static void ade_ldi_set_mode(struct ade_crtc *acrtc,
+			     struct drm_display_mode *mode,
+			     struct drm_display_mode *adj_mode)
+{
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	void __iomem *base = ctx->base;
+	u32 width = mode->hdisplay;
+	u32 height = mode->vdisplay;
+	u32 hfp, hbp, hsw, vfp, vbp, vsw;
+	u32 plr_flags;
+
+	plr_flags = (mode->flags & DRM_MODE_FLAG_NVSYNC) ? FLAG_NVSYNC : 0;
+	plr_flags |= (mode->flags & DRM_MODE_FLAG_NHSYNC) ? FLAG_NHSYNC : 0;
+	hfp = mode->hsync_start - mode->hdisplay;
+	hbp = mode->htotal - mode->hsync_end;
+	hsw = mode->hsync_end - mode->hsync_start;
+	vfp = mode->vsync_start - mode->vdisplay;
+	vbp = mode->vtotal - mode->vsync_end;
+	vsw = mode->vsync_end - mode->vsync_start;
+	if (vsw > 15) {
+		DRM_DEBUG_DRIVER("vsw exceeded 15\n");
+		vsw = 15;
+	}
+
+	writel((hbp << HBP_OFST) | hfp, base + LDI_HRZ_CTRL0);
+	 /* the configured value is actual value - 1 */
+	writel(hsw - 1, base + LDI_HRZ_CTRL1);
+	writel((vbp << VBP_OFST) | vfp, base + LDI_VRT_CTRL0);
+	 /* the configured value is actual value - 1 */
+	writel(vsw - 1, base + LDI_VRT_CTRL1);
+	 /* the configured value is actual value - 1 */
+	writel(((height - 1) << VSIZE_OFST) | (width - 1),
+	       base + LDI_DSP_SIZE);
+	writel(plr_flags, base + LDI_PLR_CTRL);
+
+	/* ctran6 setting */
+	writel(CTRAN_BYPASS_ON, base + ADE_CTRAN_DIS(ADE_CTRAN6));
+	 /* the configured value is actual value - 1 */
+	writel(width * height - 1, base + ADE_CTRAN_IMAGE_SIZE(ADE_CTRAN6));
+	ade_update_reload_bit(base, CTRAN_OFST + ADE_CTRAN6, 0);
+
+	ade_set_pix_clk(ctx, mode, adj_mode);
+
+	DRM_DEBUG_DRIVER("set mode: %dx%d\n", width, height);
+}
+
+static int ade_power_up(struct ade_hw_ctx *ctx)
+{
+	int ret;
+
+	ret = clk_prepare_enable(ctx->media_noc_clk);
+	if (ret) {
+		DRM_ERROR("failed to enable media_noc_clk (%d)\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_deassert(ctx->reset);
+	if (ret) {
+		DRM_ERROR("failed to deassert reset\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(ctx->ade_core_clk);
+	if (ret) {
+		DRM_ERROR("failed to enable ade_core_clk (%d)\n", ret);
+		return ret;
+	}
+
+	ade_init(ctx);
+	ctx->power_on = true;
+	return 0;
+}
+
+static void ade_power_down(struct ade_hw_ctx *ctx)
+{
+	void __iomem *base = ctx->base;
+
+	writel(ADE_DISABLE, base + LDI_CTRL);
+	/* dsi pixel off */
+	writel(DSI_PCLK_OFF, base + LDI_HDMI_DSI_GT);
+
+	clk_disable_unprepare(ctx->ade_core_clk);
+	reset_control_assert(ctx->reset);
+	clk_disable_unprepare(ctx->media_noc_clk);
+	ctx->power_on = false;
+}
+
+static void ade_set_medianoc_qos(struct ade_crtc *acrtc)
+{
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	struct regmap *map = ctx->noc_regmap;
+
+	regmap_update_bits(map, ADE0_QOSGENERATOR_MODE,
+			   QOSGENERATOR_MODE_MASK, BYPASS_MODE);
+	regmap_update_bits(map, ADE0_QOSGENERATOR_EXTCONTROL,
+			   SOCKET_QOS_EN, SOCKET_QOS_EN);
+
+	regmap_update_bits(map, ADE1_QOSGENERATOR_MODE,
+			   QOSGENERATOR_MODE_MASK, BYPASS_MODE);
+	regmap_update_bits(map, ADE1_QOSGENERATOR_EXTCONTROL,
+			   SOCKET_QOS_EN, SOCKET_QOS_EN);
+}
+
+static void ade_display_enable(struct ade_crtc *acrtc)
+{
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	void __iomem *base = ctx->base;
+	u32 out_fmt = acrtc->out_format;
+
+	/* display source setting */
+	writel(DISP_SRC_OVLY2, base + ADE_DISP_SRC_CFG);
+
+	/* enable ade */
+	writel(ADE_ENABLE, base + ADE_EN);
+	/* enable ldi */
+	writel(NORMAL_MODE, base + LDI_WORK_MODE);
+	writel((out_fmt << BPP_OFST) | DATA_GATE_EN | LDI_EN,
+	       base + LDI_CTRL);
+	/* dsi pixel on */
+	writel(DSI_PCLK_ON, base + LDI_HDMI_DSI_GT);
+}
+
+static void ade_crtc_enable(struct drm_crtc *crtc)
+{
+	struct ade_crtc *acrtc = to_ade_crtc(crtc);
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	int ret;
+
+	if (acrtc->enable)
+		return;
+
+	if (!ctx->power_on) {
+		ret = ade_power_up(ctx);
+		if (ret)
+			return;
+	}
+
+	ade_set_medianoc_qos(acrtc);
+	ade_display_enable(acrtc);
+	acrtc->enable = true;
+}
+
+static void ade_crtc_disable(struct drm_crtc *crtc)
+{
+	struct ade_crtc *acrtc = to_ade_crtc(crtc);
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+
+	if (!acrtc->enable)
+		return;
+
+	ade_power_down(ctx);
+	acrtc->enable = false;
+}
+
+static int ade_crtc_atomic_check(struct drm_crtc *crtc,
+				 struct drm_crtc_state *state)
+{
+	/* do nothing */
+	return 0;
+}
+
+static void ade_crtc_mode_set_nofb(struct drm_crtc *crtc)
+{
+	struct ade_crtc *acrtc = to_ade_crtc(crtc);
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	struct drm_display_mode *mode = &crtc->state->mode;
+	struct drm_display_mode *adj_mode = &crtc->state->adjusted_mode;
+
+	if (!ctx->power_on)
+		(void)ade_power_up(ctx);
+	ade_ldi_set_mode(acrtc, mode, adj_mode);
+}
+
+static void ade_crtc_atomic_begin(struct drm_crtc *crtc,
+				  struct drm_crtc_state *old_state)
+{
+	struct ade_crtc *acrtc = to_ade_crtc(crtc);
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+
+	if (!ctx->power_on)
+		(void)ade_power_up(ctx);
+}
+
+static void ade_crtc_atomic_flush(struct drm_crtc *crtc,
+				  struct drm_crtc_state *old_state)
+
+{
+	struct ade_crtc *acrtc = to_ade_crtc(crtc);
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	void __iomem *base = ctx->base;
+
+	/* only crtc is enabled regs take effect */
+	if (acrtc->enable) {
+		/* flush ade registers */
+		writel(ADE_ENABLE, base + ADE_EN);
+	}
+}
+
+static const struct drm_crtc_helper_funcs ade_crtc_helper_funcs = {
+	.enable		= ade_crtc_enable,
+	.disable	= ade_crtc_disable,
+	.atomic_check	= ade_crtc_atomic_check,
+	.mode_set_nofb	= ade_crtc_mode_set_nofb,
+	.atomic_begin	= ade_crtc_atomic_begin,
+	.atomic_flush	= ade_crtc_atomic_flush,
+};
+
+static const struct drm_crtc_funcs ade_crtc_funcs = {
+	.destroy	= drm_crtc_cleanup,
+	.set_config	= drm_atomic_helper_set_config,
+	.page_flip	= drm_atomic_helper_page_flip,
+	.reset		= drm_atomic_helper_crtc_reset,
+	.set_property = drm_atomic_helper_crtc_set_property,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+};
+
+static int ade_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
+			 struct drm_plane *plane)
+{
+	struct kirin_drm_private *priv = dev->dev_private;
+	struct device_node *port;
+	int ret;
+
+	/* set crtc port so that
+	 * drm_of_find_possible_crtcs call works
+	 */
+	port = of_get_child_by_name(dev->dev->of_node, "port");
+	if (!port) {
+		DRM_ERROR("no port node found in %s\n",
+			  dev->dev->of_node->full_name);
+		return -EINVAL;
+	}
+	of_node_put(port);
+	crtc->port = port;
+
+	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
+					&ade_crtc_funcs, NULL);
+	if (ret) {
+		DRM_ERROR("failed to init crtc.\n");
+		return ret;
+	}
+
+	drm_crtc_helper_add(crtc, &ade_crtc_helper_funcs);
+	priv->crtc[drm_crtc_index(crtc)] = crtc;
+
+	return 0;
+}
+
+static int ade_dts_parse(struct platform_device *pdev, struct ade_hw_ctx *ctx)
+{
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctx->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ctx->base)) {
+		DRM_ERROR("failed to remap ade io base\n");
+		return  PTR_ERR(ctx->base);
+	}
+
+	ctx->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(ctx->reset))
+		return PTR_ERR(ctx->reset);
+
+	ctx->noc_regmap =
+		syscon_regmap_lookup_by_phandle(np, "hisilicon,noc-syscon");
+	if (IS_ERR(ctx->noc_regmap)) {
+		DRM_ERROR("failed to get noc regmap\n");
+		return PTR_ERR(ctx->noc_regmap);
+	}
+
+	ctx->irq = platform_get_irq(pdev, 0);
+	if (ctx->irq < 0) {
+		DRM_ERROR("failed to get irq\n");
+		return -ENODEV;
+	}
+
+	ctx->ade_core_clk = devm_clk_get(dev, "clk_ade_core");
+	if (!ctx->ade_core_clk) {
+		DRM_ERROR("failed to parse clk ADE_CORE\n");
+		return -ENODEV;
+	}
+
+	ctx->media_noc_clk = devm_clk_get(dev, "clk_codec_jpeg");
+	if (!ctx->media_noc_clk) {
+		DRM_ERROR("failed to parse clk CODEC_JPEG\n");
+	    return -ENODEV;
+	}
+
+	ctx->ade_pix_clk = devm_clk_get(dev, "clk_ade_pix");
+	if (!ctx->ade_pix_clk) {
+		DRM_ERROR("failed to parse clk ADE_PIX\n");
+	    return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int ade_drm_init(struct drm_device *dev)
+{
+	struct platform_device *pdev = dev->platformdev;
+	struct ade_data *ade;
+	struct ade_hw_ctx *ctx;
+	struct ade_crtc *acrtc;
+	int ret;
+
+	ade = devm_kzalloc(dev->dev, sizeof(*ade), GFP_KERNEL);
+	if (!ade) {
+		DRM_ERROR("failed to alloc ade_data\n");
+		return -ENOMEM;
+	}
+	platform_set_drvdata(pdev, ade);
+
+	ctx = &ade->ctx;
+	acrtc = &ade->acrtc;
+	acrtc->ctx = ctx;
+	acrtc->out_format = LDI_OUT_RGB_888;
+
+	ret = ade_dts_parse(pdev, ctx);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void ade_drm_cleanup(struct drm_device *dev)
+{
+	struct platform_device *pdev = dev->platformdev;
+	struct ade_data *ade = platform_get_drvdata(pdev);
+	struct drm_crtc *crtc = &ade->acrtc.base;
+
+	drm_crtc_cleanup(crtc);
+}
+
+const struct kirin_dc_ops ade_dc_ops = {
+	.init = ade_drm_init,
+	.cleanup = ade_drm_cleanup
+};
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 976c9b1a3fd3..578a1eb94517 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -30,8 +30,12 @@ static struct kirin_dc_ops *dc_ops;
 
 static int kirin_drm_kms_cleanup(struct drm_device *dev)
 {
+	struct kirin_drm_private *priv = dev->dev_private;
+
 	dc_ops->cleanup(dev);
 	drm_mode_config_cleanup(dev);
+	devm_kfree(dev->dev, priv);
+	dev->dev_private = NULL;
 
 	return 0;
 }
@@ -55,8 +59,14 @@ static void kirin_drm_mode_config_init(struct drm_device *dev)
 
 static int kirin_drm_kms_init(struct drm_device *dev)
 {
+	struct kirin_drm_private *priv;
 	int ret;
 
+	priv = devm_kzalloc(dev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev->dev_private = priv;
 	dev_set_drvdata(dev->dev, dev);
 
 	/* dev->mode_config initialization */
@@ -84,6 +94,8 @@ err_dc_cleanup:
 	dc_ops->cleanup(dev);
 err_mode_config_cleanup:
 	drm_mode_config_cleanup(dev);
+	devm_kfree(dev->dev, priv);
+	dev->dev_private = NULL;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index 75e9d82356d4..5a05ad6a81db 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -11,10 +11,18 @@
 #ifndef __KIRIN_DRM_DRV_H__
 #define __KIRIN_DRM_DRV_H__
 
+#define MAX_CRTC	2
+
 /* display controller init/cleanup ops */
 struct kirin_dc_ops {
 	int (*init)(struct drm_device *dev);
 	void (*cleanup)(struct drm_device *dev);
 };
 
+struct kirin_drm_private {
+	struct drm_crtc *crtc[MAX_CRTC];
+};
+
+extern const struct kirin_dc_ops ade_dc_ops;
+
 #endif /* __KIRIN_DRM_DRV_H__ */
-- 
2.7.1
