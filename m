From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 17 Dec 2015 11:37:02 +0800
Subject: [PATCH 2/6] drm/rockchip: vop: move interrupt registers into vop_data
In-Reply-To: <1450323426-32109-1-git-send-email-mark.yao@rock-chips.com>
References: <1450323426-32109-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1450323426-32109-3-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move interrupt registers into vop_data, so it can use at multi-vop driver

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   81 +++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index dcb1396..7674bdc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -48,6 +48,8 @@
 
 #define REG_SET(x, base, reg, v, mode) \
 		__REG_SET_##mode(x, base + reg.offset, reg.mask, reg.shift, v)
+#define REG_SET_MASK(x, base, reg, v, mode) \
+		__REG_SET_##mode(x, base + reg.offset, reg.mask, reg.shift, v)
 
 #define VOP_WIN_SET(x, win, name, v) \
 		REG_SET(x, win->base, win->phy->name, v, RELAXED)
@@ -56,6 +58,23 @@
 #define VOP_CTRL_SET(x, name, v) \
 		REG_SET(x, 0, (x)->data->ctrl->name, v, NORMAL)
 
+#define VOP_INTR_GET(vop, name) \
+		vop_read_reg(vop, 0, &vop->data->ctrl->name)
+
+#define VOP_INTR_SET(vop, name, v) \
+		REG_SET(vop, 0, vop->data->intr->name, v, NORMAL)
+#define VOP_INTR_SET_TYPE(vop, name, type, v) \
+	do { \
+		int i, reg = 0; \
+		for (i = 0; i < vop->data->intr->nintrs; i++) { \
+			if (vop->data->intr->intrs[i] & type) \
+				reg |= (v) << i; \
+		} \
+		VOP_INTR_SET(vop, name, reg); \
+	} while (0)
+#define VOP_INTR_GET_TYPE(vop, name, type) \
+		vop_get_intr_type(vop, &vop->data->intr->name, type)
+
 #define VOP_WIN_GET(x, win, name) \
 		vop_read_reg(x, win->base, &win->phy->name)
 
@@ -168,6 +187,13 @@ struct vop_ctrl {
 	struct vop_reg cfg_done;
 };
 
+struct vop_intr {
+	const int *intrs;
+	uint32_t nintrs;
+	struct vop_reg enable;
+	struct vop_reg clear;
+	struct vop_reg status;
+};
 struct vop_scl_regs {
 	struct vop_reg cbcr_vsd_mode;
 	struct vop_reg cbcr_vsu_mode;
@@ -227,6 +253,7 @@ struct vop_data {
 	const struct vop_reg_data *init_table;
 	unsigned int table_size;
 	const struct vop_ctrl *ctrl;
+	const struct vop_intr *intr;
 	const struct vop_win_data *win;
 	unsigned int win_size;
 };
@@ -364,8 +391,24 @@ static const struct vop_win_data rk3288_vop_win_data[] = {
 	{ .base = 0x50, .phy = &win23_data, .type = DRM_PLANE_TYPE_CURSOR },
 };
 
+static const int rk3288_vop_intrs[] = {
+	DSP_HOLD_VALID_INTR,
+	FS_INTR,
+	LINE_FLAG_INTR,
+	BUS_ERROR_INTR,
+};
+
+static const struct vop_intr rk3288_vop_intr = {
+	.intrs = rk3288_vop_intrs,
+	.nintrs = ARRAY_SIZE(rk3288_vop_intrs),
+	.status = VOP_REG(INTR_CTRL0, 0xf, 0),
+	.enable = VOP_REG(INTR_CTRL0, 0xf, 4),
+	.clear = VOP_REG(INTR_CTRL0, 0xf, 8),
+};
+
 static const struct vop_data rk3288_vop = {
 	.init_table = vop_init_reg_table,
+	.intr = &rk3288_vop_intr,
 	.table_size = ARRAY_SIZE(vop_init_reg_table),
 	.ctrl = &ctrl_data,
 	.win = rk3288_vop_win_data,
@@ -420,6 +463,20 @@ static inline void vop_mask_write_relaxed(struct vop *vop, uint32_t offset,
 	}
 }
 
+static inline uint32_t vop_get_intr_type(struct vop *vop,
+					 const struct vop_reg *reg, int type)
+{
+	uint32_t i, ret = 0;
+	uint32_t regs = vop_read_reg(vop, 0, reg);
+
+	for (i = 0; i < vop->data->intr->nintrs; i++) {
+		if ((type & vop->data->intr->intrs[i]) && (regs & 1 << i))
+			ret |= vop->data->intr->intrs[i];
+	}
+
+	return ret;
+}
+
 static inline void vop_cfg_done(struct vop *vop)
 {
 	VOP_CTRL_SET(vop, cfg_done, 1);
@@ -616,8 +673,7 @@ static void vop_dsp_hold_valid_irq_enable(struct vop *vop)
 
 	spin_lock_irqsave(&vop->irq_lock, flags);
 
-	vop_mask_write(vop, INTR_CTRL0, DSP_HOLD_VALID_INTR_MASK,
-		       DSP_HOLD_VALID_INTR_EN(1));
+	VOP_INTR_SET_TYPE(vop, enable, DSP_HOLD_VALID_INTR, 1);
 
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
 }
@@ -631,8 +687,7 @@ static void vop_dsp_hold_valid_irq_disable(struct vop *vop)
 
 	spin_lock_irqsave(&vop->irq_lock, flags);
 
-	vop_mask_write(vop, INTR_CTRL0, DSP_HOLD_VALID_INTR_MASK,
-		       DSP_HOLD_VALID_INTR_EN(0));
+	VOP_INTR_SET_TYPE(vop, enable, DSP_HOLD_VALID_INTR, 0);
 
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
 }
@@ -1051,7 +1106,7 @@ static int vop_crtc_enable_vblank(struct drm_crtc *crtc)
 
 	spin_lock_irqsave(&vop->irq_lock, flags);
 
-	vop_mask_write(vop, INTR_CTRL0, FS_INTR_MASK, FS_INTR_EN(1));
+	VOP_INTR_SET_TYPE(vop, enable, FS_INTR, 1);
 
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
 
@@ -1067,7 +1122,9 @@ static void vop_crtc_disable_vblank(struct drm_crtc *crtc)
 		return;
 
 	spin_lock_irqsave(&vop->irq_lock, flags);
-	vop_mask_write(vop, INTR_CTRL0, FS_INTR_MASK, FS_INTR_EN(0));
+
+	VOP_INTR_SET_TYPE(vop, enable, FS_INTR, 0);
+
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
 }
 
@@ -1263,21 +1320,21 @@ static irqreturn_t vop_isr(int irq, void *data)
 {
 	struct vop *vop = data;
 	struct drm_crtc *crtc = &vop->crtc;
-	uint32_t intr0_reg, active_irqs;
+	uint32_t active_irqs;
 	unsigned long flags;
 	int ret = IRQ_NONE;
 
 	/*
-	 * INTR_CTRL0 register has interrupt status, enable and clear bits, we
+	 * interrupt register has interrupt status, enable and clear bits, we
 	 * must hold irq_lock to avoid a race with enable/disable_vblank().
 	*/
 	spin_lock_irqsave(&vop->irq_lock, flags);
-	intr0_reg = vop_readl(vop, INTR_CTRL0);
-	active_irqs = intr0_reg & INTR_MASK;
+
+	active_irqs = VOP_INTR_GET_TYPE(vop, status, INTR_MASK);
 	/* Clear all active interrupt sources */
 	if (active_irqs)
-		vop_writel(vop, INTR_CTRL0,
-			   intr0_reg | (active_irqs << INTR_CLR_SHIFT));
+		VOP_INTR_SET_TYPE(vop, clear, active_irqs, 1);
+
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
 
 	/* This is expected for vop iommu irqs, since the irq is shared */
-- 
1.7.9.5
