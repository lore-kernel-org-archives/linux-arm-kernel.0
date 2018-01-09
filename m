From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:09:13 +0100
Subject: [PATCH v3 00/13] drm/sun4i: Support the Display Engine frontend
Message-ID: <cover.8538fc1191390239557a21e2b0444c81eef1c581.1515492513.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a first serie to enable the display engine frontend.

This hardware block is found in the first generation Display Engine from
Allwinner. Its role is to implement more advanced features that the
associated backend, even though the backend alone can be used (and was used
so far) for basic composition.

Among those features, we will find hardware scaling, that is supported in
this serie, colorspace conversions, or more exotic formats support such as
the one output by the VPU.

Let me know what you think,
Maxime

Changes from v2:
  - Substracted PHYS_OFFSET to the buffer address
  - Make sure we only probe and add to the component list on frontends that
    are supported, and not simply the one enabled in the DTs
  - Reset the device at probe, and deassert the line after the clocks are
    enabled
  - Fixed the format value used
  - Used drm_fb_cma_get_gem_addr
  - Added a define for the COEF_ACCESS_CTRL bit
  - Fixed a wrong comment
  - Kept the ordering of the engine ops
  - Reapplied the NULL plane pointer patch that got squashed in v2 somehow
  - s/backend/engine/ in the engine_ops documentation

Changes from v1:
  - Fixed the unbind function to not disable the already disabled clocks,
    and to remove ourself from the frontend list
  - Changed the log level of the frontend disabled message
  - Added blank lines where suggested by Neil
  - Fixed an artifact that was happening when the plane using the frontend
    was disabled. This was happening because the frontend was disabled
    before the backend layer (that would be disabled at the next vblank).
    This led to a significant rework of the patches, so I didn't apply all
    the tags. I also had to take a few patches in.
  - Added engine ops documentation
  - Fixed a bug in our duplicate_state callback that wouldn't preserve the
    frontend state
  - Removed the hardcoded register values and used the real ones instead.
  - Fixed some compilation errors reported by the 0-day bot.

Maxime Ripard (13):
  drm/sun4i: backend: Move line stride setup to buffer setup function
  drm/sun4i: backend: Document the engine operations
  drm/sun4i: backend: Allow a NULL plane pointer to retrieve the format
  drm/sun4i: backend: Add a custom plane state
  drm/sun4i: engine: Add a custom crtc atomic_check
  drm/sun4i: engine: Add a VBLANK quirk callback
  drm/sun4i: engine: Create an atomic_begin callback
  drm/sun4i: Add a driver for the display frontend
  drm/sun4i: backend: Wire in the frontend
  drm/sun4i: backend: Add a custom atomic_check for the frontend
  drm/sun4i: backend: Use runtime_pm variant of atomic_commit_tail
  drm/sun4i: backend: Make sure we don't have a commit pending
  ARM: dts: sun8i: a33 Enable our display frontend

 arch/arm/boot/dts/sun8i-a33.dtsi          |   1 +-
 drivers/gpu/drm/sun4i/Makefile            |   3 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c     | 183 ++++++++++-
 drivers/gpu/drm/sun4i/sun4i_backend.h     |  10 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c        |  21 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c         |  27 +-
 drivers/gpu/drm/sun4i/sun4i_drv.h         |   1 +-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c |   6 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.c    | 384 +++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_frontend.h    |  99 ++++++-
 drivers/gpu/drm/sun4i/sun4i_layer.c       |  83 ++++-
 drivers/gpu/drm/sun4i/sun4i_layer.h       |  11 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c        |   4 +-
 drivers/gpu/drm/sun4i/sunxi_engine.h      |  89 +++++-
 14 files changed, 901 insertions(+), 21 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_frontend.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_frontend.h

base-commit: f2e323798ce2553a10ddc720879553642e05e619
-- 
git-series 0.9.1
