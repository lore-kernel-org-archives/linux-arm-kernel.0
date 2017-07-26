From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 26 Jul 2017 14:19:19 +0800
Subject: [PATCH v6 3/7] drm/rockchip: vop: move line_flag_num to interrupt
 registers
In-Reply-To: <1501049930-5794-1-git-send-email-mark.yao@rock-chips.com>
References: <1501049930-5794-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1501049960-6006-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the hardware design process, the design of line flags
register is associated with the interrupt register,
placing the line flags in the interrupt definition is
more reasonable, and it would make multi-vop define easilier.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
Changes in v6:
- fixes complie error

Changes in v3:
- Explain more in details, introduce why we need this patch

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 10 +++++++---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  4 ++--
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  8 ++++----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a792ea3..fd47da5 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -61,8 +61,12 @@
 #define VOP_INTR_GET(vop, name) \
 		vop_read_reg(vop, 0, &vop->data->ctrl->name)
 
-#define VOP_INTR_SET(vop, name, mask, v) \
+#define VOP_INTR_SET(vop, name, v) \
+		REG_SET(vop, 0, vop->data->intr->name, v)
+
+#define VOP_INTR_SET_MASK(vop, name, mask, v) \
 		REG_SET_MASK(vop, 0, vop->data->intr->name, mask, v)
+
 #define VOP_INTR_SET_TYPE(vop, name, type, v) \
 	do { \
 		int i, reg = 0, mask = 0; \
@@ -72,7 +76,7 @@
 				mask |= 1 << i; \
 			} \
 		} \
-		VOP_INTR_SET(vop, name, mask, reg); \
+		VOP_INTR_SET_MASK(vop, name, mask, reg); \
 	} while (0)
 #define VOP_INTR_GET_TYPE(vop, name, type) \
 		vop_get_intr_type(vop, &vop->data->intr->name, type)
@@ -982,7 +986,7 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 	VOP_CTRL_SET(vop, vact_st_end, val);
 	VOP_CTRL_SET(vop, vpost_st_end, val);
 
-	VOP_CTRL_SET(vop, line_flag_num[0], vact_end);
+	VOP_INTR_SET(vop, line_flag_num[0], vact_end);
 
 	clk_set_rate(vop->dclk, adjusted_mode->clock * 1000);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 056b974..850f8e4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -60,8 +60,6 @@ struct vop_ctrl {
 	struct vop_reg hpost_st_end;
 	struct vop_reg vpost_st_end;
 
-	struct vop_reg line_flag_num[2];
-
 	struct vop_reg global_regdone_en;
 	struct vop_reg cfg_done;
 };
@@ -69,6 +67,8 @@ struct vop_ctrl {
 struct vop_intr {
 	const int *intrs;
 	uint32_t nintrs;
+
+	struct vop_reg line_flag_num[2];
 	struct vop_reg enable;
 	struct vop_reg clear;
 	struct vop_reg status;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index d7974da..0a5f0d2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -116,6 +116,7 @@
 static const struct vop_intr rk3036_intr = {
 	.intrs = rk3036_vop_intrs,
 	.nintrs = ARRAY_SIZE(rk3036_vop_intrs),
+	.line_flag_num[0] = VOP_REG(RK3036_INT_STATUS, 0xfff, 12),
 	.status = VOP_REG(RK3036_INT_STATUS, 0xf, 0),
 	.enable = VOP_REG(RK3036_INT_STATUS, 0xf, 4),
 	.clear = VOP_REG(RK3036_INT_STATUS, 0xf, 8),
@@ -130,7 +131,6 @@
 	.hact_st_end = VOP_REG(RK3036_DSP_HACT_ST_END, 0x1fff1fff, 0),
 	.vtotal_pw = VOP_REG(RK3036_DSP_VTOTAL_VS_END, 0x1fff1fff, 0),
 	.vact_st_end = VOP_REG(RK3036_DSP_VACT_ST_END, 0x1fff1fff, 0),
-	.line_flag_num[0] = VOP_REG(RK3036_INT_STATUS, 0xfff, 12),
 	.cfg_done = VOP_REG_SYNC(RK3036_REG_CFG_DONE, 0x1, 0),
 };
 
@@ -226,7 +226,6 @@
 	.vact_st_end = VOP_REG(RK3288_DSP_VACT_ST_END, 0x1fff1fff, 0),
 	.hpost_st_end = VOP_REG(RK3288_POST_DSP_HACT_INFO, 0x1fff1fff, 0),
 	.vpost_st_end = VOP_REG(RK3288_POST_DSP_VACT_INFO, 0x1fff1fff, 0),
-	.line_flag_num[0] = VOP_REG(RK3288_INTR_CTRL0, 0x1fff, 12),
 	.global_regdone_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 11),
 	.cfg_done = VOP_REG_SYNC(RK3288_REG_CFG_DONE, 0x1, 0),
 };
@@ -258,6 +257,7 @@
 static const struct vop_intr rk3288_vop_intr = {
 	.intrs = rk3288_vop_intrs,
 	.nintrs = ARRAY_SIZE(rk3288_vop_intrs),
+	.line_flag_num[0] = VOP_REG(RK3288_INTR_CTRL0, 0x1fff, 12),
 	.status = VOP_REG(RK3288_INTR_CTRL0, 0xf, 0),
 	.enable = VOP_REG(RK3288_INTR_CTRL0, 0xf, 4),
 	.clear = VOP_REG(RK3288_INTR_CTRL0, 0xf, 8),
@@ -294,8 +294,6 @@
 	.vact_st_end = VOP_REG(RK3399_DSP_VACT_ST_END, 0x1fff1fff, 0),
 	.hpost_st_end = VOP_REG(RK3399_POST_DSP_HACT_INFO, 0x1fff1fff, 0),
 	.vpost_st_end = VOP_REG(RK3399_POST_DSP_VACT_INFO, 0x1fff1fff, 0),
-	.line_flag_num[0] = VOP_REG(RK3399_LINE_FLAG, 0xffff, 0),
-	.line_flag_num[1] = VOP_REG(RK3399_LINE_FLAG, 0xffff, 16),
 	.cfg_done = VOP_REG_MASK_SYNC(RK3399_REG_CFG_DONE, 0x1, 0),
 };
 
@@ -312,6 +310,8 @@
 static const struct vop_intr rk3399_vop_intr = {
 	.intrs = rk3399_vop_intrs,
 	.nintrs = ARRAY_SIZE(rk3399_vop_intrs),
+	.line_flag_num[0] = VOP_REG(RK3399_LINE_FLAG, 0xffff, 0),
+	.line_flag_num[1] = VOP_REG(RK3399_LINE_FLAG, 0xffff, 16),
 	.status = VOP_REG_MASK_SYNC(RK3399_INTR_STATUS0, 0xffff, 0),
 	.enable = VOP_REG_MASK_SYNC(RK3399_INTR_EN0, 0xffff, 0),
 	.clear = VOP_REG_MASK_SYNC(RK3399_INTR_CLEAR0, 0xffff, 0),
-- 
1.9.1
