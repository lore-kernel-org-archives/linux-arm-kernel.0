From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Sat, 28 Nov 2015 18:38:59 +0800
Subject: [PATCH v2 04/10] drm/hisilicon: Add crtc funcs for ADE
In-Reply-To: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
References: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
Message-ID: <1448707145-69348-5-git-send-email-xinliang.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add crtc funcs and helper funcs for ADE.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 drivers/gpu/drm/hisilicon/Makefile       |   3 +-
 drivers/gpu/drm/hisilicon/hisi_ade_reg.h | 490 +++++++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_ade.c | 511 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_drv.c |  15 +
 drivers/gpu/drm/hisilicon/hisi_drm_drv.h |  16 +
 5 files changed, 1034 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_ade_reg.h
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_ade.c
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_drv.h

diff --git a/drivers/gpu/drm/hisilicon/Makefile b/drivers/gpu/drm/hisilicon/Makefile
index 7375456..3433c8b 100644
--- a/drivers/gpu/drm/hisilicon/Makefile
+++ b/drivers/gpu/drm/hisilicon/Makefile
@@ -1,3 +1,4 @@
-hisi-drm-y := hisi_drm_drv.o 
+hisi-drm-y := hisi_drm_drv.o \
+	      hisi_drm_ade.o
 
 obj-$(CONFIG_DRM_HISI)	+= hisi-drm.o
diff --git a/drivers/gpu/drm/hisilicon/hisi_ade_reg.h b/drivers/gpu/drm/hisilicon/hisi_ade_reg.h
new file mode 100644
index 0000000..6a7bc46
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_ade_reg.h
@@ -0,0 +1,490 @@
+/*
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __HISI_ADE_REG_H__
+#define __HISI_ADE_REG_H__
+
+/*
+ * ADE Registers Offset
+ */
+#define ADE_CTRL			(0x4)
+#define ADE_CTRL1			(0x8C)
+#define ADE_ROT_SRC_CFG			(0x10)
+#define ADE_DISP_SRC_CFG		(0x18)
+#define ADE_WDMA2_SRC_CFG		(0x1C)
+#define ADE_SEC_OVLY_SRC_CFG		(0x20)
+#define ADE_WDMA3_SRC_CFG		(0x24)
+#define ADE_OVLY1_TRANS_CFG		(0x2C)
+#define ADE_EN				(0x100)
+#define INTR_MASK_CPU_0			(0xC10)
+#define INTR_MASK_CPU_1			(0xC14)
+#define ADE_FRM_DISGARD_CTRL		(0xA4)
+/* reset and reload regs */
+#define ADE_SOFT_RST_SEL0		(0x78)
+#define ADE_SOFT_RST_SEL1		(0x7C)
+#define ADE_RELOAD_DIS0			(0xAC)
+#define ADE_RELOAD_DIS1			(0xB0)
+#define ADE_CH_RDMA_BIT_OFST		(0)
+#define ADE_CLIP_BIT_OFST		(15)
+#define ADE_SCL_BIT_OFST		(21)
+#define ADE_CTRAN_BIT_OFST		(24)
+#define ADE_OVLY_BIT_OFST		(37) /* 32+5 */
+/* channel regs */
+#define RD_CH_PE(x)			(0x1000 + (x) * 0x80)
+#define RD_CH_CTRL(x)			(0x1004 + (x) * 0x80)
+#define RD_CH_ADDR(x)			(0x1008 + (x) * 0x80)
+#define RD_CH_SIZE(x)			(0x100C + (x) * 0x80)
+#define RD_CH_STRIDE(x)			(0x1010 + (x) * 0x80)
+#define RD_CH_SPACE(x)			(0x1014 + (x) * 0x80)
+#define RD_CH_PARTIAL_SIZE(x)		(0x1018 + (x) * 0x80)
+#define RD_CH_PARTIAL_SPACE(x)		(0x101C + (x) * 0x80)
+#define RD_CH_EN(x)			(0x1020 + (x) * 0x80)
+#define RD_CH_STATUS(x)			(0x1024 + (x) * 0x80)
+#define RD_CH_DISP_CTRL			(0x1404)
+#define RD_CH_DISP_ADDR			(0x1408)
+#define RD_CH_DISP_SIZE			(0x140C)
+#define RD_CH_DISP_STRIDE		(0x1410)
+#define RD_CH_DISP_SPACE		(0x1414)
+#define RD_CH_DISP_EN			(0x142C)
+/* clip regs */
+#define ADE_CLIP_DISABLE(x)		(0x6800 + (x) * 0x100)
+#define ADE_CLIP_SIZE0(x)		(0x6804 + (x) * 0x100)
+#define ADE_CLIP_SIZE1(x)		(0x6808 + (x) * 0x100)
+#define ADE_CLIP_SIZE2(x)		(0x680C + (x) * 0x100)
+#define ADE_CLIP_CFG_OK(x)		(0x6810 + (x) * 0x100)
+/* scale regs */
+#define ADE_SCL1_MUX_CFG		(0xC)
+#define ADE_SCL2_SRC_CFG		(0x14)
+#define ADE_SCL3_MUX_CFG		(0x8)
+#define ADE_SCL_CTRL(x)			(0x3000 + (x) * 0x800)
+#define ADE_SCL_HSP(x)			(0x3004 + (x) * 0x800)
+#define ADE_SCL_UV_HSP(x)		(0x3008 + (x) * 0x800)
+#define ADE_SCL_VSP(x)			(0x300C + (x) * 0x800)
+#define ADE_SCL_UV_VSP(x)		(0x3010 + (x) * 0x800)
+#define ADE_SCL_ORES(x)			(0x3014 + (x) * 0x800)
+#define ADE_SCL_IRES(x)			(0x3018 + (x) * 0x800)
+#define ADE_SCL_START(x)		(0x301C + (x) * 0x800)
+#define ADE_SCL_ERR(x)			(0x3020 + (x) * 0x800)
+#define ADE_SCL_PIX_OFST(x)		(0x3024 + (x) * 0x800)
+#define ADE_SCL_UV_PIX_OFST(x)		(0x3028 + (x) * 0x800)
+#define ADE_SCL_COEF_CLR(x)		(0x3030 + (x) * 0x800)
+#define ADE_SCL_HCOEF(x, m, n)		(0x3100 + (x) * 0x800 + \
+					12 * (m) + 4 * (n))
+#define ADE_SCL_VCOEF(x, i, j)		(0x340C + (x) * 0x800 + \
+					12 * (i) + 4 * (j))
+/* ctran regs */
+#define ADE_CTRAN5_TRANS_CFG		(0x40)
+#define ADE_CTRAN_DIS(x)		(0x5004 + (x) * 0x100)
+#define ADE_CTRAN_MODE_CHOOSE(x)	(0x5008 + (x) * 0x100)
+#define ADE_CTRAN_STAT(x)		(0x500C + (x) * 0x100)
+#define ADE_CTRAN_CHDC0(x)		(0x5010 + (x) * 0x100)
+#define ADE_CTRAN_CHDC1(x)		(0x5014 + (x) * 0x100)
+#define ADE_CTRAN_CHDC2(x)		(0x5018 + (x) * 0x100)
+#define ADE_CTRAN_CHDC3(x)		(0x501C + (x) * 0x100)
+#define ADE_CTRAN_CHDC4(x)		(0x5020 + (x) * 0x100)
+#define ADE_CTRAN_CHDC5(x)		(0x5024 + (x) * 0x100)
+#define ADE_CTRAN_CSC0(x)		(0x5028 + (x) * 0x100)
+#define ADE_CTRAN_CSC1(x)		(0x502C + (x) * 0x100)
+#define ADE_CTRAN_CSC2(x)		(0x5030 + (x) * 0x100)
+#define ADE_CTRAN_CSC3(x)		(0x5034 + (x) * 0x100)
+#define ADE_CTRAN_CSC4(x)		(0x5038 + (x) * 0x100)
+#define ADE_CTRAN_IMAGE_SIZE(x)		(0x503C + (x) * 0x100)
+#define ADE_CTRAN_CFG_OK(x)		(0x5040 + (x) * 0x100)
+/* overlay regs */
+#define ADE_OVLY_ALPHA_ST		(0x2000)
+#define ADE_OVLY_CH_XY0(x)		(0x2004 + (x) * 4)
+#define ADE_OVLY_CH_XY1(x)		(0x2024 + (x) * 4)
+#define ADE_OVLY_CH_CTL(x)		(0x204C + (x) * 4)
+#define ADE_OVLY_OUTPUT_SIZE(x)		(0x2070 + (x) * 8)
+#define ADE_OVLY_BASE_COLOR(x)		(0x2074 + (x) * 8)
+#define ADE_OVLYX_CTL(x)		(0x209C + (x) * 4)
+#define ADE_OVLY_CTL			(0x98)
+#define ADE_OVLY_CH_ALP_MODE_OFST	(0)
+#define ADE_OVLY_CH_ALP_SEL_OFST	(2)
+#define ADE_OVLY_CH_UNDER_ALP_SEL_OFST	(4)
+#define ADE_OVLY_CH_EN_OFST		(6)
+#define ADE_OVLY_CH_ALP_GBL_OFST	(15)
+#define ADE_OVLY_CH_SEL_OFST		(28)
+
+/*
+ * media regs
+ */
+#define SC_MEDIA_RSTDIS			(0x530)
+#define SC_MEDIA_RSTEN			(0x52C)
+
+/*
+ * regs relevant enum
+ */
+enum {
+	LDI_TEST = 0,
+	LDI_WORK
+};
+
+enum {
+	LDI_ISR_FRAME_END_INT = 0x2,
+	LDI_ISR_UNDER_FLOW_INT = 0x4
+};
+
+enum {
+	ADE_ISR1_RES_SWITCH_CMPL = 0x80000000
+};
+
+enum {
+	LDI_DISP_MODE_NOT_3D_FBF = 0,
+	LDI_DISP_MODE_3D_FBF
+};
+
+enum {
+	ADE_RGB = 0,
+	ADE_BGR
+};
+
+enum {
+	ADE_DISABLE = 0,
+	ADE_ENABLE
+};
+
+enum {
+	ADE_OUT_RGB_565 = 0,
+	ADE_OUT_RGB_666,
+	ADE_OUT_RGB_888
+};
+
+/*
+ * ADE read as big-endian, so revert the
+ * rgb order described in the SoC datasheet
+ */
+enum ADE_FORMAT {
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
+	ADE_FORMAT_NOT_SUPPORT = 800
+};
+
+/* ldi src cfg */
+enum {
+	TOP_DISP_SRC_NONE = 0,
+	TOP_DISP_SRC_OVLY2,
+	TOP_DISP_SRC_DISP,
+	TOP_DISP_SRC_ROT,
+	TOP_DISP_SRC_SCL2
+};
+
+enum {
+	ADE_ISR_DMA_ERROR = 0x2000000
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
+enum {
+	ADE_ALP_GLOBAL = 0,
+	ADE_ALP_PIXEL,
+	ADE_ALP_PIXEL_AND_GLB
+};
+
+enum {
+	ADE_ALP_MUL_COEFF_0 = 0,	/* alpha */
+	ADE_ALP_MUL_COEFF_1,		/* 1-alpha */
+	ADE_ALP_MUL_COEFF_2,		/* 0 */
+	ADE_ALP_MUL_COEFF_3		/* 1 */
+};
+
+/*
+ * ADE Register Union Struct
+ */
+union U_ADE_CTRL1 {
+struct {
+	unsigned int	auto_clk_gate_en	:1;
+	unsigned int	rot_buf_shr_out		:1;
+	unsigned int	reserved_44		:30;
+	} bits;
+	unsigned int	u32;
+};
+
+union U_ADE_SOFT_RST_SEL0 {
+struct {
+	unsigned int    ch1_rdma_srst_sel     :1;
+	unsigned int    ch2_rdma_srst_sel     :1;
+	unsigned int    ch3_rdma_srst_sel     :1;
+	unsigned int    ch4_rdma_srst_sel     :1;
+	unsigned int    ch5_rdma_srst_sel     :1;
+	unsigned int    ch6_rdma_srst_sel     :1;
+	unsigned int    disp_rdma_srst_sel    :1;
+	unsigned int    cmdq1_rdma_srst_sel   :1;
+	unsigned int    cmdq2_rdma_srst_sel   :1;
+	unsigned int    reserved_29           :1;
+	unsigned int    ch1_wdma_srst_sel     :1;
+	unsigned int    ch2_wdma_srst_sel     :1;
+	unsigned int    ch3_wdma_srst_sel     :1;
+	unsigned int    reserved_28           :1;
+	unsigned int    cmdq_wdma_srst_sel    :1;
+	unsigned int    clip1_srst_sel        :1;
+	unsigned int    clip2_srst_sel        :1;
+	unsigned int    clip3_srst_sel        :1;
+	unsigned int    clip4_srst_sel        :1;
+	unsigned int    clip5_srst_sel        :1;
+	unsigned int    clip6_srst_sel        :1;
+	unsigned int    scl1_srst_sel         :1;
+	unsigned int    scl2_srst_sel         :1;
+	unsigned int    scl3_srst_sel         :1;
+	unsigned int    ctran1_srst_sel       :1;
+	unsigned int    ctran2_srst_sel       :1;
+	unsigned int    ctran3_srst_sel       :1;
+	unsigned int    ctran4_srst_sel       :1;
+	unsigned int    ctran5_srst_sel       :1;
+	unsigned int    ctran6_srst_sel       :1;
+	unsigned int    rot_srst_sel          :1;
+	unsigned int    reserved_27           :1;
+	} bits;
+	unsigned int	u32;
+};
+
+union U_ADE_CTRL {
+struct {
+	unsigned int    frm_end_start         :2;
+	unsigned int    dfs_buf_cfg           :1;
+	unsigned int    rot_buf_cfg           :3;
+	unsigned int    rd_ch5_nv             :1;
+	unsigned int    rd_ch6_nv             :1;
+	unsigned int    dfs_buf_unflow_lev1   :13;
+	unsigned int    dfs_buf_unflow_lev2   :11;
+	} bits;
+	unsigned int	u32;
+};
+
+/*
+ * ADE Register Write/Read functions
+ */
+static inline void set_TOP_CTL_clk_gate_en(u8 *base, u32 val)
+{
+	union U_ADE_CTRL1   ade_ctrl1;
+	u8 *reg_addr = base + ADE_CTRL1;
+
+	ade_ctrl1.u32 = readl(reg_addr);
+	ade_ctrl1.bits.auto_clk_gate_en = val;
+	writel(ade_ctrl1.u32, reg_addr);
+}
+
+static inline void set_TOP_SOFT_RST_SEL0_disp_rdma(u8 *base, u32 val)
+{
+	union U_ADE_SOFT_RST_SEL0 ade_soft_rst;
+	u8 *addr = base + ADE_SOFT_RST_SEL0;
+
+	ade_soft_rst.u32 = readl(addr);
+	ade_soft_rst.bits.disp_rdma_srst_sel = val;
+	writel(ade_soft_rst.u32, addr);
+}
+
+static inline void set_TOP_SOFT_RST_SEL0_ctran5(u8 *base, u32 val)
+{
+	union U_ADE_SOFT_RST_SEL0 ade_soft_rst;
+	u8 *addr = base + ADE_SOFT_RST_SEL0;
+
+	ade_soft_rst.u32 = readl(addr);
+	ade_soft_rst.bits.ctran5_srst_sel = val;
+	writel(ade_soft_rst.u32, addr);
+}
+
+static inline void set_TOP_SOFT_RST_SEL0_ctran6(u8 *base, u32 val)
+{
+	union U_ADE_SOFT_RST_SEL0 ade_soft_rst;
+	u8 *addr = base + ADE_SOFT_RST_SEL0;
+
+	ade_soft_rst.u32 = readl(addr);
+	ade_soft_rst.bits.ctran6_srst_sel = val;
+	writel(ade_soft_rst.u32, addr);
+}
+
+static inline void set_TOP_CTL_frm_end_start(u8 *base, u32 val)
+{
+	union U_ADE_CTRL  ade_ctrl;
+	u8 *reg_addr = base + ADE_CTRL;
+
+	ade_ctrl.u32 = readl(reg_addr);
+	ade_ctrl.bits.frm_end_start = val;
+	writel(ade_ctrl.u32, reg_addr);
+}
+
+/*
+ * LDI Registers Offset
+ */
+#define LDI_HRZ_CTRL0		(0x7400)
+#define LDI_HRZ_CTRL1		(0x7404)
+#define LDI_VRT_CTRL0		(0x7408)
+#define LDI_VRT_CTRL1		(0x740C)
+#define LDI_PLR_CTRL		(0x7410)
+#define LDI_DSP_SIZE		(0x7414)
+#define LDI_INT_EN		(0x741C)
+#define LDI_CTRL		(0x7420)
+#define LDI_ORG_INT		(0x7424)
+#define LDI_MSK_INT		(0x7428)
+#define LDI_INT_CLR		(0x742C)
+#define LDI_WORK_MODE		(0x7430)
+#define LDI_DE_SPACE_LOW	(0x7438)
+#define LDI_MCU_INTS		(0x7450)
+#define LDI_MCU_INTE		(0x7454)
+#define LDI_MCU_INTC		(0x7458)
+#define LDI_HDMI_DSI_GT		(0x7434)
+
+/*
+ * LDI Timing Polarity defines
+ */
+#define HISI_LDI_FLAG_NVSYNC	BIT(0)
+#define HISI_LDI_FLAG_NHSYNC	BIT(1)
+#define HISI_LDI_FLAG_NPIXCLK	BIT(2)
+#define HISI_LDI_FLAG_NDE	BIT(3)
+
+/*
+ * LDI Register Union Struct
+ */
+union U_LDI_CTRL {
+struct {
+	unsigned int    ldi_en                :1;
+	unsigned int    disp_mode_buf         :1;
+	unsigned int    date_gate_en          :1;
+	unsigned int    bpp                   :2;
+	unsigned int    wait_vsync_en         :1;
+	unsigned int    corlorbar_width       :7;
+	unsigned int    bgr                   :1;
+	unsigned int    color_mode            :1;
+	unsigned int    shutdown              :1;
+	unsigned int    vactive_line          :12;
+	unsigned int    ldi_en_self_clr       :1;
+	unsigned int    reserved_573          :3;
+	} bits;
+	unsigned int    u32;
+};
+
+union U_LDI_WORK_MODE {
+struct {
+	unsigned int    work_mode             :1;
+	unsigned int    wback_en              :1;
+	unsigned int    colorbar_en           :1;
+	unsigned int    reserved_577          :29;
+	} bits;
+	unsigned int    u32;
+};
+
+/*
+ * LDI Register Write/Read Helper functions
+ */
+static inline void set_reg(u8 *addr, u32 val, u32 bw, u32 bs)
+{
+	u32 mask = (1 << bw) - 1;
+	u32 tmp = readl(addr);
+
+	tmp &= ~(mask << bs);
+	writel(tmp | ((val & mask) << bs), addr);
+}
+
+static inline void set_LDI_CTRL_ldi_en(u8 *base, u32 val)
+{
+	union U_LDI_CTRL ldi_ctrl;
+	u8 *addr = base + LDI_CTRL;
+
+	ldi_ctrl.u32 = readl(addr);
+	ldi_ctrl.bits.ldi_en = val;
+	writel(ldi_ctrl.u32, addr);
+}
+
+static inline void set_LDI_CTRL_disp_mode(u8 *base, u32 val)
+{
+	union U_LDI_CTRL ldi_ctrl;
+	u8 *addr = base + LDI_CTRL;
+
+	ldi_ctrl.u32 = readl(addr);
+	ldi_ctrl.bits.disp_mode_buf = val;
+	writel(ldi_ctrl.u32, addr);
+}
+
+static inline void set_LDI_CTRL_bpp(u8 *base, u32 val)
+{
+	union U_LDI_CTRL ldi_ctrl;
+	u8 *addr = base + LDI_CTRL;
+
+	ldi_ctrl.u32 = readl(addr);
+	ldi_ctrl.bits.bpp = val;
+	writel(ldi_ctrl.u32, addr);
+}
+
+static inline void set_LDI_CTRL_corlorbar_width(u8 *base, u32 val)
+{
+	union U_LDI_CTRL ldi_ctrl;
+	u8 *addr = base + LDI_CTRL;
+
+	ldi_ctrl.u32 = readl(addr);
+	ldi_ctrl.bits.corlorbar_width = (val > 0) ? val - 1 : 0;
+	writel(ldi_ctrl.u32, addr);
+}
+
+static inline void set_LDI_CTRL_bgr(u8 *base, u32 val)
+{
+	union U_LDI_CTRL ldi_ctrl;
+	u8 *addr = base + LDI_CTRL;
+
+	ldi_ctrl.u32 = readl(addr);
+	ldi_ctrl.bits.bgr = val;
+	writel(ldi_ctrl.u32, addr);
+}
+
+static inline void set_LDI_WORK_MODE_work_mode(u8 *base, u32 val)
+{
+	union U_LDI_WORK_MODE ldi_work_mode;
+	u8 *addr = base + LDI_WORK_MODE;
+
+	ldi_work_mode.u32 = readl(addr);
+	ldi_work_mode.bits.work_mode = val;
+	writel(ldi_work_mode.u32, addr);
+}
+
+static inline void set_LDI_WORK_MODE_colorbar_en(u8 *base, u32 val)
+{
+	union U_LDI_WORK_MODE ldi_work_mode;
+	u8 *addr = base + LDI_WORK_MODE;
+
+	ldi_work_mode.u32 = readl(addr);
+	ldi_work_mode.bits.colorbar_en = val;
+	writel(ldi_work_mode.u32, addr);
+}
+
+#endif
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_ade.c b/drivers/gpu/drm/hisilicon/hisi_drm_ade.c
new file mode 100644
index 0000000..d157879
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_ade.c
@@ -0,0 +1,511 @@
+/*
+ * Hisilicon Hi6220 SoC ADE(Advanced Display Engine)'s crtc&plane driver
+ *
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Author:
+ *	Xinliang Liu <xinliang.liu@linaro.org>
+ *	Xinliang Liu <z.liuxinliang@hisilicon.com>
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
+#include <linux/component.h>
+#include <video/display_timing.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+
+#include "hisi_drm_drv.h"
+#include "hisi_ade_reg.h"
+
+#define FORCE_PIXEL_CLOCK_SAME_OR_HIGHER 0
+
+#define to_ade_crtc(crtc) \
+	container_of(crtc, struct ade_crtc, base)
+
+struct ade_hw_ctx {
+	void __iomem  *base;
+	void __iomem  *media_base;
+
+	int irq;
+	u32 ade_core_rate;
+	u32 media_noc_rate;
+
+	struct clk *ade_core_clk;
+	struct clk *media_noc_clk;
+	struct clk *ade_pix_clk;
+	bool power_on;
+};
+
+struct ade_crtc {
+	struct drm_crtc base;
+	struct ade_hw_ctx *ctx;
+	bool enable;
+	u64 use_mask;
+};
+
+struct ade_data {
+	struct ade_crtc acrtc;
+	struct ade_hw_ctx ctx;
+};
+
+static void ade_init(struct ade_hw_ctx *ctx)
+{
+	void __iomem *base = ctx->base;
+
+	/* enable clk gate */
+	set_TOP_CTL_clk_gate_en(base, 1);
+	/* clear overlay */
+	writel(0, base + ADE_OVLY1_TRANS_CFG);
+	writel(0, base + ADE_OVLY_CTL);
+	writel(0, base + ADE_OVLYX_CTL(ADE_OVLY2));
+	/* clear reset and reload regs */
+	writel(0, base + ADE_SOFT_RST_SEL0);
+	writel(0, base + ADE_SOFT_RST_SEL1);
+	writel(0xFFFFFFFF, base + ADE_RELOAD_DIS0);
+	writel(0xFFFFFFFF, base + ADE_RELOAD_DIS1);
+	/* for video set to 1, means that ade registers
+	 * became effective at frame end
+	 */
+	set_TOP_CTL_frm_end_start(base, 1);
+}
+
+static void ade_ldi_set_mode(struct ade_crtc *acrtc,
+			     struct drm_display_mode *mode,
+			     struct drm_display_mode *adj_mode)
+{
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	void __iomem *base = ctx->base;
+	u32 out_w = mode->hdisplay;
+	u32 out_h = mode->vdisplay;
+	u32 hfp, hbp, hsw, vfp, vbp, vsw;
+	u32 plr_flags;
+	int ret;
+
+	plr_flags = (mode->flags & DRM_MODE_FLAG_NVSYNC)
+			? HISI_LDI_FLAG_NVSYNC : 0;
+	plr_flags |= (mode->flags & DRM_MODE_FLAG_NHSYNC)
+			? HISI_LDI_FLAG_NHSYNC : 0;
+	hfp = mode->hsync_start - mode->hdisplay;
+	hbp = mode->htotal - mode->hsync_end;
+	hsw = mode->hsync_end - mode->hsync_start;
+	vfp = mode->vsync_start - mode->vdisplay;
+	vbp = mode->vtotal - mode->vsync_end;
+	vsw = mode->vsync_end - mode->vsync_start;
+	if (vsw > 15) {
+		DRM_INFO("vsw exceeded 15\n");
+		vsw = 15;
+	}
+
+	writel((hbp << 20) | (hfp << 0), base + LDI_HRZ_CTRL0);
+	/* p3-73 6220V100 pdf:
+	 *  "The configured value is the actual width - 1"
+	 */
+	writel(hsw - 1, base + LDI_HRZ_CTRL1);
+	writel((vbp << 20) | (vfp << 0), base + LDI_VRT_CTRL0);
+	/* p3-74 6220V100 pdf:
+	 *  "The configured value is the actual width - 1"
+	 */
+	writel(vsw - 1, base + LDI_VRT_CTRL1);
+
+	/* p3-75 6220V100 pdf:
+	 *  "The configured value is the actual width - 1"
+	 */
+	writel(((out_h - 1) << 20) | ((out_w - 1) << 0),
+	       base + LDI_DSP_SIZE);
+	writel(plr_flags, base + LDI_PLR_CTRL);
+
+	ret = clk_set_rate(ctx->ade_pix_clk, mode->clock * 1000);
+	/* Success should be guaranteed in aotomic_check
+	 * failer shouldn't happen here
+	 */
+	if (ret)
+		DRM_ERROR("set ade_pixel_clk_rate fail\n");
+	adj_mode->clock = clk_get_rate(ctx->ade_pix_clk) / 1000;
+
+	/* ctran6 setting */
+	writel(1, base + ADE_CTRAN_DIS(ADE_CTRAN6));
+	writel(out_w * out_h - 1, base + ADE_CTRAN_IMAGE_SIZE(ADE_CTRAN6));
+	acrtc->use_mask |= BIT(ADE_CTRAN_BIT_OFST + ADE_CTRAN6);
+	DRM_INFO("set mode: %dx%d\n", out_w, out_h);
+
+	/*
+	 * other parameters setting
+	 */
+	writel(BIT(0), base + LDI_WORK_MODE);
+	writel((0x3c << 6) | (ADE_OUT_RGB_888 << 3) | BIT(2) | BIT(0),
+	       base + LDI_CTRL);
+	set_reg(base + LDI_DE_SPACE_LOW, 0x1, 1, 1);
+}
+
+static int ade_power_up(struct ade_hw_ctx *ctx)
+{
+	void __iomem *media_base = ctx->media_base;
+	int ret;
+
+	ret = clk_set_rate(ctx->ade_core_clk, ctx->ade_core_rate);
+	if (ret) {
+		DRM_ERROR("clk_set_rate ade_core_rate error\n");
+		return ret;
+	}
+	ret = clk_set_rate(ctx->media_noc_clk, ctx->media_noc_rate);
+	if (ret) {
+		DRM_ERROR("media_noc_clk media_noc_rate error\n");
+		return ret;
+	}
+	ret = clk_prepare_enable(ctx->media_noc_clk);
+	if (ret) {
+		DRM_ERROR("fail to clk_prepare_enable media_noc_clk\n");
+		return ret;
+	}
+
+	writel(0x20, media_base + SC_MEDIA_RSTDIS);
+
+	ret = clk_prepare_enable(ctx->ade_core_clk);
+	if (ret) {
+		DRM_ERROR("fail to clk_prepare_enable ade_core_clk\n");
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
+	void __iomem *media_base = ctx->media_base;
+
+	set_LDI_CTRL_ldi_en(base, ADE_DISABLE);
+	/* dsi pixel off */
+	set_reg(base + LDI_HDMI_DSI_GT, 0x1, 1, 0);
+
+	clk_disable_unprepare(ctx->ade_core_clk);
+	writel(0x20, media_base + SC_MEDIA_RSTEN);
+	clk_disable_unprepare(ctx->media_noc_clk);
+	ctx->power_on = false;
+}
+
+
+
+/*
+ * set modules' reset mode: by software or hardware
+ * set modules' reload enable/disable
+ */
+static void ade_set_reset_and_reload(struct ade_crtc *acrtc)
+{
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	void __iomem *base = ctx->base;
+	u32 mask0 = (u32)acrtc->use_mask;
+	u32 mask1 = (u32)(acrtc->use_mask >> 32);
+
+	DRM_DEBUG_DRIVER("mask=0x%llX, mask0=0x%X, mask1=0x%X\n",
+			 acrtc->use_mask, mask0, mask1);
+
+	writel(mask0, base + ADE_SOFT_RST_SEL0);
+	writel(mask1, base + ADE_SOFT_RST_SEL1);
+	writel(~mask0, base + ADE_RELOAD_DIS0);
+	writel(~mask1, base + ADE_RELOAD_DIS1);
+}
+
+/*
+ * commit to ldi to display
+ */
+static void ade_display_commit(struct ade_crtc *acrtc)
+{
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	void __iomem *base = ctx->base;
+
+	/* TODO: set rotator after overlay */
+
+	/* TODO: set scale after overlay */
+
+	/* display source setting */
+	writel(TOP_DISP_SRC_OVLY2, base + ADE_DISP_SRC_CFG);
+
+	/* set reset mode:soft or hw, and reload modules */
+	ade_set_reset_and_reload(acrtc);
+
+	DRM_INFO("ADE GO\n");
+	/* enable ade */
+	wmb();
+	writel(ADE_ENABLE, base + ADE_EN);
+	/* enable ldi */
+	wmb();
+	set_LDI_CTRL_ldi_en(base, ADE_ENABLE);
+	/* dsi pixel on */
+	set_reg(base + LDI_HDMI_DSI_GT, 0x0, 1, 0);
+}
+
+static void ade_crtc_enable(struct drm_crtc *crtc)
+{
+	struct ade_crtc *acrtc = to_ade_crtc(crtc);
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+	int ret;
+
+	DRM_DEBUG_DRIVER("enter.\n");
+	if (acrtc->enable)
+		return;
+
+	if (!ctx->power_on) {
+		ret = ade_power_up(ctx);
+		if (ret) {
+			DRM_ERROR("failed to initialize ade clk\n");
+			return;
+		}
+	}
+
+	ade_display_commit(acrtc);
+	acrtc->enable = true;
+
+	DRM_DEBUG_DRIVER("exit success.\n");
+}
+
+static void ade_crtc_disable(struct drm_crtc *crtc)
+{
+	struct ade_crtc *acrtc = to_ade_crtc(crtc);
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+
+	DRM_DEBUG_DRIVER("enter.\n");
+
+	if (!acrtc->enable)
+		return;
+
+	ade_power_down(ctx);
+	acrtc->use_mask = 0;
+	acrtc->enable = false;
+	DRM_DEBUG_DRIVER("exit success.\n");
+}
+
+int ade_crtc_atomic_check(struct drm_crtc *crtc, struct drm_crtc_state *state)
+{
+	DRM_DEBUG_DRIVER("enter.\n");
+	DRM_DEBUG_DRIVER("exit success.\n");
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
+	DRM_DEBUG_DRIVER("enter.\n");
+	if (!ctx->power_on)
+		(void)ade_power_up(ctx);
+	ade_ldi_set_mode(acrtc, mode, adj_mode);
+	DRM_DEBUG_DRIVER("exit success.\n");
+}
+
+static void ade_crtc_atomic_begin(struct drm_crtc *crtc,
+				  struct drm_crtc_state *old_state)
+{
+	struct ade_crtc *acrtc = to_ade_crtc(crtc);
+	struct ade_hw_ctx *ctx = acrtc->ctx;
+
+	DRM_DEBUG_DRIVER("enter.\n");
+	if (!ctx->power_on)
+		(void)ade_power_up(ctx);
+	DRM_DEBUG_DRIVER("exit success.\n");
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
+	DRM_DEBUG_DRIVER("enter.\n");
+	/* commit to  display: LDI input setting */
+	if (acrtc->enable) {
+		/* set reset and reload */
+		ade_set_reset_and_reload(acrtc);
+		/* flush ade regitsters */
+		wmb();
+		writel(ADE_ENABLE, base + ADE_EN);
+	}
+	DRM_DEBUG_DRIVER("exit success.\n");
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
+	int ret;
+
+	ret = drm_crtc_init_with_planes(dev, crtc, plane,
+					NULL, &ade_crtc_funcs);
+	if (ret) {
+		DRM_ERROR("failed to init crtc.\n");
+		return ret;
+	}
+
+	drm_crtc_helper_add(crtc, &ade_crtc_helper_funcs);
+
+	return 0;
+}
+
+static int ade_bind(struct device *dev, struct device *master, void *data)
+{
+	return 0;
+}
+
+static void ade_unbind(struct device *dev, struct device *master, void *data)
+{
+	/* do nothing */
+}
+
+static const struct component_ops ade_ops = {
+	.bind	= ade_bind,
+	.unbind	= ade_unbind,
+};
+
+static int ade_dts_parse(struct platform_device *pdev, struct ade_hw_ctx *ctx)
+{
+	struct resource *res;
+	struct device *dev;
+	struct device_node *np;
+	int ret;
+
+	dev = &pdev->dev;
+	np  = dev->of_node;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ade_base");
+	ctx->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctx->base)) {
+		DRM_ERROR("failed to remap ade io base\n");
+		return  PTR_ERR(ctx->base);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "media_base");
+	ctx->media_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctx->media_base)) {
+		DRM_ERROR("failed to remap media io base\n");
+		return PTR_ERR(ctx->media_base);
+	}
+
+	ctx->irq = platform_get_irq(pdev, 0);
+	if (ctx->irq < 0) {
+		DRM_ERROR("failed to parse the irq\n");
+		return -ENODEV;
+	}
+
+	ctx->ade_core_clk = devm_clk_get(&pdev->dev, "clk_ade_core");
+	if (!ctx->ade_core_clk) {
+		DRM_ERROR("failed to parse the ADE_CORE\n");
+		return -ENODEV;
+	}
+	ctx->media_noc_clk = devm_clk_get(&pdev->dev,
+					"aclk_codec_jpeg_src");
+	if (!ctx->media_noc_clk) {
+		DRM_ERROR("failed to parse the CODEC_JPEG\n");
+	    return -ENODEV;
+	}
+	ctx->ade_pix_clk = devm_clk_get(&pdev->dev, "clk_ade_pix");
+	if (!ctx->ade_pix_clk) {
+		DRM_ERROR("failed to parse the ADE_PIX_SRC\n");
+	    return -ENODEV;
+	}
+
+	ret = of_property_read_u32(np, "ade_core_clk_rate",
+				   &ctx->ade_core_rate);
+	if (ret) {
+		DRM_ERROR("failed to parse the ade_core_clk_rate\n");
+	    return -ENODEV;
+	}
+	ret = of_property_read_u32(np, "media_noc_clk_rate",
+				   &ctx->media_noc_rate);
+	if (ret) {
+		DRM_ERROR("failed to parse the media_noc_clk_rate\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int ade_probe(struct platform_device *pdev)
+{
+	struct ade_data *ade;
+	int ret;
+
+	DRM_DEBUG_DRIVER("enter.\n");
+
+	ade = devm_kzalloc(&pdev->dev, sizeof(*ade), GFP_KERNEL);
+	if (!ade) {
+		DRM_ERROR("failed to alloc ade_data\n");
+		return -ENOMEM;
+	}
+
+	ret = ade_dts_parse(pdev, &ade->ctx);
+	if (ret) {
+		DRM_ERROR("failed to parse dts!!\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, ade);
+
+	return component_add(&pdev->dev, &ade_ops);
+}
+
+static int ade_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &ade_ops);
+
+	return 0;
+}
+
+static const struct of_device_id ade_of_match[] = {
+	{ .compatible = "hisilicon,hi6220-ade" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ade_of_match);
+
+static struct platform_driver ade_driver = {
+	.probe = ade_probe,
+	.remove = ade_remove,
+	.driver = {
+		   .name = "hisi-ade",
+		   .owner = THIS_MODULE,
+		   .of_match_table = ade_of_match,
+	},
+};
+
+module_platform_driver(ade_driver);
+
+MODULE_AUTHOR("Xinliang Liu <xinliang.liu@linaro.org>");
+MODULE_AUTHOR("Xinliang Liu <z.liuxinliang@hisilicon.com>");
+MODULE_AUTHOR("Xinwei Kong <kong.kongxinwei@hisilicon.com>");
+MODULE_DESCRIPTION("Hisilicon DRM ADE(crtc/plane) Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_drv.c b/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
index 445e2ec..d0eca80 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_drv.c
@@ -21,11 +21,18 @@
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_atomic_helper.h>
 
+#include "hisi_drm_drv.h"
+
 #define DRIVER_NAME	"hisi-drm"
 
 static int hisi_drm_unload(struct drm_device *dev)
 {
+	struct hisi_drm_private *priv = dev->dev_private;
+
 	drm_mode_config_cleanup(dev);
+	devm_kfree(dev->dev, priv);
+	dev->dev_private = NULL;
+
 	return 0;
 }
 
@@ -48,8 +55,14 @@ static void hisi_drm_mode_config_init(struct drm_device *dev)
 
 static int hisi_drm_load(struct drm_device *dev, unsigned long flags)
 {
+	struct hisi_drm_private *priv;
 	int ret;
 
+	priv = devm_kzalloc(dev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev->dev_private = priv;
 	dev_set_drvdata(dev->dev, dev);
 
 	/* dev->mode_config initialization */
@@ -70,6 +83,8 @@ static int hisi_drm_load(struct drm_device *dev, unsigned long flags)
 
 err_mode_config_cleanup:
 	drm_mode_config_cleanup(dev);
+	devm_kfree(dev->dev, priv);
+	dev->dev_private = NULL;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_drv.h b/drivers/gpu/drm/hisilicon/hisi_drm_drv.h
new file mode 100644
index 0000000..a10229e
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_drv.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (c) 2014-2015 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __HISI_DRM_DRV_H__
+#define __HISI_DRM_DRV_H__
+
+struct hisi_drm_private {
+};
+
+#endif /* __HISI_DRM_DRV_H__ */
-- 
1.9.1
