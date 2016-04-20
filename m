From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 20 Apr 2016 14:18:15 +0800
Subject: [PATCH v2 3/5] drm/rockchip: vop: introduce VOP_REG_MASK
In-Reply-To: <1461133097-1478-1-git-send-email-mark.yao@rock-chips.com>
References: <1461133097-1478-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1461133097-1478-4-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some new vop register support mask, bit[16-31] is mask,
bit[0-15] is value, the mask is correspond to the value.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   45 ++++++++++++++-------------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |    1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |    9 +++++-
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 28596e7..59f24cd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -36,15 +36,18 @@
 #include "rockchip_drm_fb.h"
 #include "rockchip_drm_vop.h"
 
-#define __REG_SET_RELAXED(x, off, mask, shift, v) \
-		vop_mask_write_relaxed(x, off, (mask) << shift, (v) << shift)
-#define __REG_SET_NORMAL(x, off, mask, shift, v) \
-		vop_mask_write(x, off, (mask) << shift, (v) << shift)
+#define __REG_SET_RELAXED(x, off, mask, shift, v, write_mask) \
+		vop_mask_write(x, off, mask, shift, v, write_mask, true)
+
+#define __REG_SET_NORMAL(x, off, mask, shift, v, write_mask) \
+		vop_mask_write(x, off, mask, shift, v, write_mask, false)
 
 #define REG_SET(x, base, reg, v, mode) \
-		__REG_SET_##mode(x, base + reg.offset, reg.mask, reg.shift, v)
+		__REG_SET_##mode(x, base + reg.offset, \
+				 reg.mask, reg.shift, v, reg.write_mask)
 #define REG_SET_MASK(x, base, reg, mask, v, mode) \
-		__REG_SET_##mode(x, base + reg.offset, mask, reg.shift, v)
+		__REG_SET_##mode(x, base + reg.offset, \
+				 mask, reg.shift, v, reg.write_mask)
 
 #define VOP_WIN_SET(x, win, name, v) \
 		REG_SET(x, win->base, win->phy->name, v, RELAXED)
@@ -160,27 +163,25 @@ static inline uint32_t vop_read_reg(struct vop *vop, uint32_t base,
 }
 
 static inline void vop_mask_write(struct vop *vop, uint32_t offset,
-				  uint32_t mask, uint32_t v)
+				  uint32_t mask, uint32_t shift, uint32_t v,
+				  bool write_mask, bool relaxed)
 {
-	if (mask) {
-		uint32_t cached_val = vop->regsbak[offset >> 2];
-
-		cached_val = (cached_val & ~mask) | v;
-		writel(cached_val, vop->regs + offset);
-		vop->regsbak[offset >> 2] = cached_val;
-	}
-}
+	if (!mask)
+		return;
 
-static inline void vop_mask_write_relaxed(struct vop *vop, uint32_t offset,
-					  uint32_t mask, uint32_t v)
-{
-	if (mask) {
+	if (write_mask) {
+		v = (v << shift) | (mask << (shift + 16));
+	} else {
 		uint32_t cached_val = vop->regsbak[offset >> 2];
 
-		cached_val = (cached_val & ~mask) | v;
-		writel_relaxed(cached_val, vop->regs + offset);
-		vop->regsbak[offset >> 2] = cached_val;
+		v = (cached_val & ~(mask << shift)) | (v << shift);
+		vop->regsbak[offset >> 2] = v;
 	}
+
+	if (relaxed)
+		writel_relaxed(v, vop->regs + offset);
+	else
+		writel(v, vop->regs + offset);
 }
 
 static inline uint32_t vop_get_intr_type(struct vop *vop,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 071ff0b..28dafb6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -33,6 +33,7 @@ struct vop_reg {
 	uint32_t offset;
 	uint32_t shift;
 	uint32_t mask;
+	bool write_mask;
 };
 
 struct vop_ctrl {
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index e75b2b8..6846868 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -23,7 +23,14 @@
 #define VOP_REG(off, _mask, s) \
 		{.offset = off, \
 		 .mask = _mask, \
-		 .shift = s,}
+		 .shift = s, \
+		 .write_mask = false,}
+
+#define VOP_REG_MASK(off, _mask, s) \
+		{.offset = off, \
+		 .mask = _mask, \
+		 .shift = s, \
+		 .write_mask = true,}
 
 static const uint32_t formats_win_full[] = {
 	DRM_FORMAT_XRGB8888,
-- 
1.7.9.5
