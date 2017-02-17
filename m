From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Feb 2017 11:13:23 +0800
Subject: [PATCH 0/7] drm/sun4i: Various fixes and cleanups part 1
Message-ID: <20170217031330.14087-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This is the first bunch of fixes for the sun4i drm driver. This is part
of the cleanup I am doing towards making the driver support multiple
display pipelines.

Patch 1 moves the drm_mode_config_cleanup call from sun4i_framebuffer_free
to be called directly in sun4i_drv_unbind. This is needed for patch 2, so
it doesn't get called twice.

Patch 2 adds proper clean up to the error return path in sun4i_drv_bind.

Patch 3 adds a check for drm_vblank_init's return value. It can fail if
no memory is available.

Patch 4 fixes the element size passed to kcalloc. Previously we were
allocating too much memory.

Patch 5 drops a useless assignment.

Patch 6 makes sun4i_layers_init actually store the created layers in the
list that it returns. This one was particularly nasty.

Patch 7 makes sun4i_crtc_init pass back error codes.

We probably don't need to tag stable for these. Patch 1 and 2 fix up
possible memory and object leakage, but unless the user keeps unloading
and loading the modules, it won't leak past a few times.

Regards
ChenYu


Chen-Yu Tsai (7):
  drm/sun4i: Move drm_mode_config_cleanup call to main driver
  drm/sun4i: Fix up error path cleanup for master bind function
  drm/sun4i: Check return value of drm_vblank_init
  drm/sun4i: Fix kcalloc element size in sun4i_layers_init
  drm/sun4i: Drop useless assignment in sun4i_layers_init
  drm/sun4i: Save newly created layer in layers array in
    sun4i_layers_init
  drm/sun4i: Make sun4i_crtc_init return ERR_PTR style error codes

 drivers/gpu/drm/sun4i/sun4i_crtc.c        |  4 ++--
 drivers/gpu/drm/sun4i/sun4i_drv.c         | 27 +++++++++++++++++++--------
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c |  1 -
 drivers/gpu/drm/sun4i/sun4i_layer.c       |  5 +++--
 4 files changed, 24 insertions(+), 13 deletions(-)

-- 
2.11.0
