From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:55:03 +0000
Subject: [PATCH v4 20/23] drm/rockchip: vop: test for P{H,V}SYNC
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-21-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When connected to the MIPI DSI output, we need to use N{H,V}SYNC for the
internal connection but these flags are meaningless for DSI panels.
Switch the test so that we do not set the P{H,V}SYNC bits unless the
mode requires it.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Mark Yao <mark.yao@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v4:
- Add Sean's Reviewed-by
v3:
- Add Mark's Reviewed-by
Unchanged in v2
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index c7eba305c488..67aefc6d4e9a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -933,8 +933,8 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 	}
 
 	pin_pol = 0x8;
-	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC) ? 0 : 1;
-	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC) ? 0 : (1 << 1);
+	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_PHSYNC) ? 1 : 0;
+	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_PVSYNC) ? (1 << 1) : 0;
 	VOP_CTRL_SET(vop, pin_pol, pin_pol);
 
 	switch (s->output_type) {
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
