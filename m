From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 12 Jul 2017 10:03:38 +0800
Subject: [PATCH v2 2/5] drm/rockchip: vop: support verify registers with vop
 version
In-Reply-To: <1499824991-7391-1-git-send-email-mark.yao@rock-chips.com>
References: <1499824991-7391-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1499825019-7503-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 66 +++++++++++++++++++++--------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 18 ++++++--
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 20 ++++++---
 3 files changed, 77 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 7a5f809..a9180fd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -42,33 +42,60 @@
 #include "rockchip_drm_psr.h"
 #include "rockchip_drm_vop.h"
 
-#define __REG_SET_RELAXED(x, off, mask, shift, v, write_mask) \
-		vop_mask_write(x, off, mask, shift, v, write_mask, true)
+#define VOP_REG_SUPPORT(vop, reg) \
+		(!reg.major || (reg.major == VOP_MAJOR(vop->data->version) && \
+		reg.begin_minor <= VOP_MINOR(vop->data->version) && \
+		reg.end_minor >= VOP_MINOR(vop->data->version) && \
+		reg.mask))
 
-#define __REG_SET_NORMAL(x, off, mask, shift, v, write_mask) \
-		vop_mask_write(x, off, mask, shift, v, write_mask, false)
+#define VOP_WIN_SUPPORT(vop, win, name) \
+		VOP_REG_SUPPORT(vop, win->phy->name)
 
-#define REG_SET(x, base, reg, v, mode) \
-		__REG_SET_##mode(x, base + reg.offset, \
-				 reg.mask, reg.shift, v, reg.write_mask)
-#define REG_SET_MASK(x, base, reg, mask, v, mode) \
-		__REG_SET_##mode(x, base + reg.offset, \
-				 mask, reg.shift, v, reg.write_mask)
+#define VOP_CTRL_SUPPORT(vop, name) \
+		VOP_REG_SUPPORT(vop, vop->data->ctrl->name)
+
+#define VOP_INTR_SUPPORT(vop, name) \
+		VOP_REG_SUPPORT(vop, vop->data->intr->name)
+
+#define __REG_SET(x, off, mask, shift, v, write_mask, relaxed) \
+		vop_mask_write(x, off, mask, shift, v, write_mask, relaxed)
+
+#define _REG_SET(vop, name, off, reg, mask, v, relaxed) \
+	do { \
+		if (VOP_REG_SUPPORT(vop, reg)) \
+			__REG_SET(vop, off + reg.offset, mask, reg.shift, \
+				  v, reg.write_mask, relaxed); \
+		else \
+			dev_dbg(vop->dev, "Warning: not support "#name"\n"); \
+	} while (0)
+
+#define REG_SET(x, name, off, reg, v, relaxed) \
+		_REG_SET(x, name, off, reg, reg.mask, v, relaxed)
+#define REG_SET_MASK(x, name, off, reg, mask, v, relaxed) \
+		_REG_SET(x, name, off, reg, reg.mask & mask, v, relaxed)
 
 #define VOP_WIN_SET(x, win, name, v) \
-		REG_SET(x, win->base, win->phy->name, v, RELAXED)
+		REG_SET(x, name, win->base, win->phy->name, v, true)
+#define VOP_WIN_SET_EXT(x, win, ext, name, v) \
+		REG_SET(x, name, 0, win->ext->name, v, true)
 #define VOP_SCL_SET(x, win, name, v) \
-		REG_SET(x, win->base, win->phy->scl->name, v, RELAXED)
+		REG_SET(x, name, win->base, win->phy->scl->name, v, true)
 #define VOP_SCL_SET_EXT(x, win, name, v) \
-		REG_SET(x, win->base, win->phy->scl->ext->name, v, RELAXED)
+		REG_SET(x, name, win->base, win->phy->scl->ext->name, v, true)
+
 #define VOP_CTRL_SET(x, name, v) \
-		REG_SET(x, 0, (x)->data->ctrl->name, v, NORMAL)
+		REG_SET(x, name, 0, (x)->data->ctrl->name, v, false)
 
 #define VOP_INTR_GET(vop, name) \
 		vop_read_reg(vop, 0, &vop->data->ctrl->name)
 
-#define VOP_INTR_SET(vop, name, mask, v) \
-		REG_SET_MASK(vop, 0, vop->data->intr->name, mask, v, NORMAL)
+#define VOP_INTR_SET(vop, name, v) \
+		REG_SET(vop, name, 0, vop->data->intr->name, \
+			v, false)
+#define VOP_INTR_SET_MASK(vop, name, mask, v) \
+		REG_SET_MASK(vop, name, 0, vop->data->intr->name, \
+			     mask, v, false)
+
 #define VOP_INTR_SET_TYPE(vop, name, type, v) \
 	do { \
 		int i, reg = 0, mask = 0; \
@@ -78,13 +105,16 @@
 				mask |= 1 << i; \
 			} \
 		} \
-		VOP_INTR_SET(vop, name, mask, reg); \
+		VOP_INTR_SET_MASK(vop, name, mask, reg); \
 	} while (0)
 #define VOP_INTR_GET_TYPE(vop, name, type) \
 		vop_get_intr_type(vop, &vop->data->intr->name, type)
 
+#define VOP_CTRL_GET(x, name) \
+		vop_read_reg(x, 0, &vop->data->ctrl->name)
+
 #define VOP_WIN_GET(x, win, name) \
-		vop_read_reg(x, win->base, &win->phy->name)
+		vop_read_reg(x, win->offset, win->phy->name)
 
 #define VOP_WIN_GET_YRGBADDR(vop, win) \
 		vop_readl(vop, win->base + win->phy->yrgb_mst.offset)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 084d3b2..e4de890 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -15,6 +15,14 @@
 #ifndef _ROCKCHIP_DRM_VOP_H
 #define _ROCKCHIP_DRM_VOP_H
 
+/*
+ * major: IP major vertion, used for IP structure
+ * minor: big feature change under same structure
+ */
+#define VOP_VERSION(major, minor)	((major) << 8 | (minor))
+#define VOP_MAJOR(version)		((version) >> 8)
+#define VOP_MINOR(version)		((version) & 0xff)
+
 enum vop_data_format {
 	VOP_FMT_ARGB8888 = 0,
 	VOP_FMT_RGB888,
@@ -25,10 +33,13 @@ enum vop_data_format {
 };
 
 struct vop_reg {
-	uint32_t offset;
-	uint32_t shift;
 	uint32_t mask;
-	bool write_mask;
+	uint32_t offset:12;
+	uint32_t shift:5;
+	uint32_t begin_minor:4;
+	uint32_t end_minor:4;
+	uint32_t major:3;
+	uint32_t write_mask:1;
 };
 
 struct vop_ctrl {
@@ -134,6 +145,7 @@ struct vop_win_data {
 };
 
 struct vop_data {
+	uint32_t version;
 	const struct vop_ctrl *ctrl;
 	const struct vop_intr *intr;
 	const struct vop_win_data *win;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 00e9d79..7744603 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -20,17 +20,25 @@
 #include "rockchip_drm_vop.h"
 #include "rockchip_vop_reg.h"
 
-#define VOP_REG(off, _mask, s) \
+#define VOP_REG_VER_MASK(off, _mask, s, _write_mask, _major, \
+			 _begin_minor, _end_minor) \
 		{.offset = off, \
 		 .mask = _mask, \
 		 .shift = s, \
-		 .write_mask = false,}
+		 .write_mask = _write_mask, \
+		 .major = _major, \
+		 .begin_minor = _begin_minor, \
+		 .end_minor = _end_minor,}
+
+#define VOP_REG_VER(off, _mask, s, _major, _begin_minor, _end_minor) \
+		VOP_REG_VER_MASK(off, _mask, s, false, \
+				 _major, _begin_minor, _end_minor)
+
+#define VOP_REG(off, _mask, s) \
+		VOP_REG_VER(off, _mask, s, 0, 0, -1)
 
 #define VOP_REG_MASK(off, _mask, s) \
-		{.offset = off, \
-		 .mask = _mask, \
-		 .shift = s, \
-		 .write_mask = true,}
+		VOP_REG_VER_MASK(off, _mask, s, true, 0, 0, -1)
 
 static const uint32_t formats_win_full[] = {
 	DRM_FORMAT_XRGB8888,
-- 
1.9.1
