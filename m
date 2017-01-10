From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 10 Jan 2017 09:29:31 +0800
Subject: [PATCH v5 0/3] Add overlay plane support for ZTE drm driver
Message-ID: <1484011774-18900-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Changes for v5:
 - Use crtc->state->plane_mask to check which planes are active for a
   given CRTC, so that we can save vou->overlays pointer array.
 - Use plane->state->crtc to determine if a plane is enabled or not,
   so that 'enabled' flag in zx_plane can be eliminated.

Changes for v4:
 - Instead of using val, return value directly for zx_vl_get_fmt() and
   zx_vl_rsz_get_fmt().
 - Fix typo of 'heigth'
 - Add 'enabled' in struct zx_plane to track layer enabling state, and
   check the state in zx_plane_set_update(), so that we can call
   zx_plane_set_update() unconditionally in the vou irq handler.

Changes for v3:
 - Let zx_plane be accessible from zx_vou driver, and so we can easily
   access all the data encoded in zx_plane with a drm_plane pointer.
   Thus, function zx_overlay_find_vl_idx() can be saved completely.
 - Refine the existing zx_plane driver a bit to support disable graphic
   layer, and make the support of overlay plane a bit easier, by sharing
   VOU layer setup and teardown functions between graphic and video
   layers.

Changes for v2:
 - Use clipped coordinates for overlay position calculation

Shawn Guo (3):
  drm: zte: make zx_plane accessible from zx_vou driver
  drm: zte: add .atomic_disable hook to disable graphic layer
  drm: zte: add overlay plane support

 drivers/gpu/drm/zte/zx_plane.c      | 328 +++++++++++++++++++++++++++++++-----
 drivers/gpu/drm/zte/zx_plane.h      |  12 +-
 drivers/gpu/drm/zte/zx_plane_regs.h |  51 ++++++
 drivers/gpu/drm/zte/zx_vou.c        | 173 ++++++++++++++-----
 drivers/gpu/drm/zte/zx_vou.h        |   3 +
 drivers/gpu/drm/zte/zx_vou_regs.h   |  18 ++
 6 files changed, 503 insertions(+), 82 deletions(-)

-- 
1.9.1
