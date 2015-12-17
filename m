From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 17 Dec 2015 11:37:01 +0800
Subject: [PATCH 1/6] drm/rockchip: vop: merge vop cfg_done into vop_data
In-Reply-To: <1450323426-32109-1-git-send-email-mark.yao@rock-chips.com>
References: <1450323426-32109-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1450323426-32109-2-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move cfg_done register into vop_data, so it can use at multi-vop driver

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 6ded4cc..dcb1396 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -164,6 +164,8 @@ struct vop_ctrl {
 	struct vop_reg vact_st_end;
 	struct vop_reg hpost_st_end;
 	struct vop_reg vpost_st_end;
+
+	struct vop_reg cfg_done;
 };
 
 struct vop_scl_regs {
@@ -333,6 +335,7 @@ static const struct vop_ctrl ctrl_data = {
 	.vact_st_end = VOP_REG(DSP_VACT_ST_END, 0x1fff1fff, 0),
 	.hpost_st_end = VOP_REG(POST_DSP_HACT_INFO, 0x1fff1fff, 0),
 	.vpost_st_end = VOP_REG(POST_DSP_VACT_INFO, 0x1fff1fff, 0),
+	.cfg_done = VOP_REG(REG_CFG_DONE, 0x1, 0),
 };
 
 static const struct vop_reg_data vop_init_reg_table[] = {
@@ -393,11 +396,6 @@ static inline uint32_t vop_read_reg(struct vop *vop, uint32_t base,
 	return (vop_readl(vop, base + reg->offset) >> reg->shift) & reg->mask;
 }
 
-static inline void vop_cfg_done(struct vop *vop)
-{
-	writel(0x01, vop->regs + REG_CFG_DONE);
-}
-
 static inline void vop_mask_write(struct vop *vop, uint32_t offset,
 				  uint32_t mask, uint32_t v)
 {
@@ -422,6 +420,11 @@ static inline void vop_mask_write_relaxed(struct vop *vop, uint32_t offset,
 	}
 }
 
+static inline void vop_cfg_done(struct vop *vop)
+{
+	VOP_CTRL_SET(vop, cfg_done, 1);
+}
+
 static bool has_rb_swapped(uint32_t format)
 {
 	switch (format) {
-- 
1.7.9.5
