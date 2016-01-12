From: john@metanate.com (John Keeping)
Date: Tue, 12 Jan 2016 18:05:18 +0000
Subject: [PATCH] drm/rockchip: vop: fix mask when updating interrupts
Message-ID: <1452621918-32239-1-git-send-email-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit dbb3d94 (drm/rockchip: vop: move interrupt registers into
vop_data) introduced new macros for updating the interrupt control
registers but these always use the mask from the register definition
without refining it for the particular bits that are being changed.

This means that whenever we enable/disable a particular interrupt we end
up disabling all of the others as a side effect.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 46c2a8d..fd37054 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -43,8 +43,8 @@
 
 #define REG_SET(x, base, reg, v, mode) \
 		__REG_SET_##mode(x, base + reg.offset, reg.mask, reg.shift, v)
-#define REG_SET_MASK(x, base, reg, v, mode) \
-		__REG_SET_##mode(x, base + reg.offset, reg.mask, reg.shift, v)
+#define REG_SET_MASK(x, base, reg, mask, v, mode) \
+		__REG_SET_##mode(x, base + reg.offset, mask, reg.shift, v)
 
 #define VOP_WIN_SET(x, win, name, v) \
 		REG_SET(x, win->base, win->phy->name, v, RELAXED)
@@ -58,16 +58,18 @@
 #define VOP_INTR_GET(vop, name) \
 		vop_read_reg(vop, 0, &vop->data->ctrl->name)
 
-#define VOP_INTR_SET(vop, name, v) \
-		REG_SET(vop, 0, vop->data->intr->name, v, NORMAL)
+#define VOP_INTR_SET(vop, name, mask, v) \
+		REG_SET_MASK(vop, 0, vop->data->intr->name, mask, v, NORMAL)
 #define VOP_INTR_SET_TYPE(vop, name, type, v) \
 	do { \
-		int i, reg = 0; \
+		int i, reg = 0, mask = 0; \
 		for (i = 0; i < vop->data->intr->nintrs; i++) { \
-			if (vop->data->intr->intrs[i] & type) \
+			if (vop->data->intr->intrs[i] & type) { \
 				reg |= (v) << i; \
+				mask |= 1 << i; \
+			} \
 		} \
-		VOP_INTR_SET(vop, name, reg); \
+		VOP_INTR_SET(vop, name, mask, reg); \
 	} while (0)
 #define VOP_INTR_GET_TYPE(vop, name, type) \
 		vop_get_intr_type(vop, &vop->data->intr->name, type)
-- 
2.7.0.rc3.140.g520a093
