From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 18 Jul 2017 10:28:25 +0800
Subject: [PATCH v3 2/7] drm/rockchip: vop: move write_relaxed flags to vop
 register
In-Reply-To: <1500344888-28165-1-git-send-email-mark.yao@rock-chips.com>
References: <1500344888-28165-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1500344906-28263-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the drm atomic framework, only a small part of the vop
register needs sync write, Currently seems only following registers
need sync write:
   cfg_done, standby and interrupt related register.

All ctrl registers are using the sync write method that is
inefficient, hardcode the write_relaxed flags to vop registers,
then can only do synchronize write for those actual needed register.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 14 +++-------
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 42 ++++++++++++++++-------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 7a5f809..101f3db 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -42,18 +42,12 @@
 #include "rockchip_drm_psr.h"
 #include "rockchip_drm_vop.h"
 
-#define __REG_SET_RELAXED(x, off, mask, shift, v, write_mask) \
-		vop_mask_write(x, off, mask, shift, v, write_mask, true)
-
-#define __REG_SET_NORMAL(x, off, mask, shift, v, write_mask) \
-		vop_mask_write(x, off, mask, shift, v, write_mask, false)
-
 #define REG_SET(x, base, reg, v, mode) \
-		__REG_SET_##mode(x, base + reg.offset, \
-				 reg.mask, reg.shift, v, reg.write_mask)
+		vop_mask_write(x, base + reg.offset, reg.mask, reg.shift, \
+			       v, reg.write_mask, reg.relaxed)
 #define REG_SET_MASK(x, base, reg, mask, v, mode) \
-		__REG_SET_##mode(x, base + reg.offset, \
-				 mask, reg.shift, v, reg.write_mask)
+		vop_mask_write(x, base + reg.offset, \
+			       mask, reg.shift, v, reg.write_mask, reg.relaxed)
 
 #define VOP_WIN_SET(x, win, name, v) \
 		REG_SET(x, win->base, win->phy->name, v, RELAXED)
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 00e9d79..691dd42 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -20,17 +20,23 @@
 #include "rockchip_drm_vop.h"
 #include "rockchip_vop_reg.h"
 
-#define VOP_REG(off, _mask, s) \
-		{.offset = off, \
+#define _VOP_REG(off, _mask, _shift, _write_mask, _relaxed) \
+		{ \
+		 .offset = off, \
 		 .mask = _mask, \
-		 .shift = s, \
-		 .write_mask = false,}
+		 .shift = _shift, \
+		 .write_mask = _write_mask, \
+		 .relaxed = _relaxed, \
+		}
 
-#define VOP_REG_MASK(off, _mask, s) \
-		{.offset = off, \
-		 .mask = _mask, \
-		 .shift = s, \
-		 .write_mask = true,}
+#define VOP_REG(off, _mask, _shift) \
+		_VOP_REG(off, _mask, _shift, false, true)
+
+#define VOP_REG_SYNC(off, _mask, _shift) \
+		_VOP_REG(off, _mask, _shift, false, false)
+
+#define VOP_REG_MASK_SYNC(off, _mask, _shift) \
+		_VOP_REG(off, _mask, _shift, true, false)
 
 static const uint32_t formats_win_full[] = {
 	DRM_FORMAT_XRGB8888,
@@ -116,7 +122,7 @@
 };
 
 static const struct vop_ctrl rk3036_ctrl_data = {
-	.standby = VOP_REG(RK3036_SYS_CTRL, 0x1, 30),
+	.standby = VOP_REG_SYNC(RK3036_SYS_CTRL, 0x1, 30),
 	.out_mode = VOP_REG(RK3036_DSP_CTRL0, 0xf, 0),
 	.pin_pol = VOP_REG(RK3036_DSP_CTRL0, 0xf, 4),
 	.htotal_pw = VOP_REG(RK3036_DSP_HTOTAL_HS_END, 0x1fff1fff, 0),
@@ -124,7 +130,7 @@
 	.vtotal_pw = VOP_REG(RK3036_DSP_VTOTAL_VS_END, 0x1fff1fff, 0),
 	.vact_st_end = VOP_REG(RK3036_DSP_VACT_ST_END, 0x1fff1fff, 0),
 	.line_flag_num[0] = VOP_REG(RK3036_INT_STATUS, 0xfff, 12),
-	.cfg_done = VOP_REG(RK3036_REG_CFG_DONE, 0x1, 0),
+	.cfg_done = VOP_REG_SYNC(RK3036_REG_CFG_DONE, 0x1, 0),
 };
 
 static const struct vop_data rk3036_vop = {
@@ -200,7 +206,7 @@
 };
 
 static const struct vop_ctrl rk3288_ctrl_data = {
-	.standby = VOP_REG(RK3288_SYS_CTRL, 0x1, 22),
+	.standby = VOP_REG_SYNC(RK3288_SYS_CTRL, 0x1, 22),
 	.gate_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 23),
 	.mmu_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 20),
 	.rgb_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 12),
@@ -221,7 +227,7 @@
 	.vpost_st_end = VOP_REG(RK3288_POST_DSP_VACT_INFO, 0x1fff1fff, 0),
 	.line_flag_num[0] = VOP_REG(RK3288_INTR_CTRL0, 0x1fff, 12),
 	.global_regdone_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 11),
-	.cfg_done = VOP_REG(RK3288_REG_CFG_DONE, 0x1, 0),
+	.cfg_done = VOP_REG_SYNC(RK3288_REG_CFG_DONE, 0x1, 0),
 };
 
 /*
@@ -265,7 +271,7 @@
 };
 
 static const struct vop_ctrl rk3399_ctrl_data = {
-	.standby = VOP_REG(RK3399_SYS_CTRL, 0x1, 22),
+	.standby = VOP_REG_SYNC(RK3399_SYS_CTRL, 0x1, 22),
 	.gate_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 23),
 	.dp_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 11),
 	.rgb_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 12),
@@ -289,7 +295,7 @@
 	.vpost_st_end = VOP_REG(RK3399_POST_DSP_VACT_INFO, 0x1fff1fff, 0),
 	.line_flag_num[0] = VOP_REG(RK3399_LINE_FLAG, 0xffff, 0),
 	.line_flag_num[1] = VOP_REG(RK3399_LINE_FLAG, 0xffff, 16),
-	.cfg_done = VOP_REG_MASK(RK3399_REG_CFG_DONE, 0x1, 0),
+	.cfg_done = VOP_REG_MASK_SYNC(RK3399_REG_CFG_DONE, 0x1, 0),
 };
 
 static const int rk3399_vop_intrs[] = {
@@ -305,9 +311,9 @@
 static const struct vop_intr rk3399_vop_intr = {
 	.intrs = rk3399_vop_intrs,
 	.nintrs = ARRAY_SIZE(rk3399_vop_intrs),
-	.status = VOP_REG_MASK(RK3399_INTR_STATUS0, 0xffff, 0),
-	.enable = VOP_REG_MASK(RK3399_INTR_EN0, 0xffff, 0),
-	.clear = VOP_REG_MASK(RK3399_INTR_CLEAR0, 0xffff, 0),
+	.status = VOP_REG_MASK_SYNC(RK3399_INTR_STATUS0, 0xffff, 0),
+	.enable = VOP_REG_MASK_SYNC(RK3399_INTR_EN0, 0xffff, 0),
+	.clear = VOP_REG_MASK_SYNC(RK3399_INTR_CLEAR0, 0xffff, 0),
 };
 
 static const struct vop_data rk3399_vop_big = {
-- 
1.9.1
