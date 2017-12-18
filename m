From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Dec 2017 15:57:47 +0100
Subject: [PATCH v2 00/12] drm/sun4i: Support the Display Engine frontend
Message-ID: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
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

Maxime Ripard (12):
  drm/sun4i: backend: Move line stride setup to buffer setup function
  sun4i/drm: backend: Document the engine operations
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
 drivers/gpu/drm/sun4i/sun4i_drv.c         |  16 +-
 drivers/gpu/drm/sun4i/sun4i_drv.h         |   1 +-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c |   6 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.c    | 392 +++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_frontend.h    |  96 ++++++-
 drivers/gpu/drm/sun4i/sun4i_layer.c       |  83 ++++-
 drivers/gpu/drm/sun4i/sun4i_layer.h       |  11 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c        |   4 +-
 drivers/gpu/drm/sun4i/sunxi_engine.h      |  93 ++++-
 14 files changed, 897 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_frontend.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_frontend.h

base-commit: 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323
-- 
git-series 0.9.1
