From: seanpaul@chromium.org (Sean Paul)
Date: Wed, 17 Aug 2016 10:23:00 -0700
Subject: [PATCH v3 3/5] drm/rockchip: vop: introduce VOP_REG_MASK
In-Reply-To: <loom.20160602T090257-641@post.gmane.org>
References: <loom.20160602T090257-641@post.gmane.org>
Message-ID: <1471454580-2286-1-git-send-email-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Yao <mark.yao@rock-chips.com>

Some new vop register support mask, bit[16-31] is mask,
bit[0-15] is value, the mask is correspond to the value.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
[seanpaul masked 'v' per tfiga's review comments]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---

Changes in v3:
	- Masked v in vop_mask_write to avoid stomping other bits (Tomasz)

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 45 +++++++++++++++--------------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  9 +++++-
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 91305eb..5047507 100644
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
@@ -164,27 +167,25 @@ static inline uint32_t vop_read_reg(struct vop *vop, uint32_t base,
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
+		v = ((v << shift) & 0xffff) | (mask << (shift + 16));
+	} else {
 		uint32_t cached_val = vop->regsbak[offset >> 2];
 
-		cached_val = (cached_val & ~mask) | v;
-		writel_relaxed(cached_val, vop->regs + offset);
-		vop->regsbak[offset >> 2] = cached_val;
+		v = (cached_val & ~(mask << shift)) | ((v & mask) << shift);
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
index 44caf14..e3f72ba 100644
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
2.8.0.rc3.226.g39d4020
