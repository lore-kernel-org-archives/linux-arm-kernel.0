From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Jul 2017 15:01:15 +0200
Subject: [PATCH v2 0/4] drm/sun4i: Fix a register access bug
Message-ID: <cover.204b8c1b76558ee33ecf147e51c2b6a04d302d55.1500555652.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner backend has a commit bit in order to push the new
configuration to the actual hardware. We've always been using that bit.

However, we also should poll for that bit to clear, which we don't.
Accessing any register while a commit is pending is forbidden, and will for
example show a symptom of reading another, random, register.

If you get this during a read/modify/write cycle, this will result in
random register corruption, which are pretty bad.

This can be shown using the following program (while the backend is
active):
http://code.bulix.org/gdl44p-161437?raw

Fortunately for us, this is not really likely to happen. The window where
it can happen is quite thin, and it only happens during a modeset, since
it's the only time we commit some new configuration.

Unfortunately for us, QT does a ridiculous amount of modeset, and will just
hit that window after a while, creating a distorded (since the register we
read/modify/write also has scaling attributes) or with weird colors (since
it also has a invertion of red and blue components). And might fix itself
later on by reading another random register with proper values for these
fields.

Let me know what you think,
Maxime

Changes from v1:
  - Renamed the function drm_atomic_helper_commit_tail_rpm
  - Dropped the changes in the rcar-du driver
  - Enhanced the documentation based on Daniel's comments

Maxime Ripard (4):
  drm/atomic: implement drm_atomic_helper_commit_tail for runtime_pm users
  drm/sun4i: Use the runtime_pm commit_tail variant
  drm/sun4i: engine: Add commit_poll function
  drm/sun4i: make sure we don't have a commit pending

 drivers/gpu/drm/drm_atomic_helper.c        | 49 +++++++++++++++--------
 drivers/gpu/drm/exynos/exynos_drm_fb.c     | 27 +-------------
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 21 +----------
 drivers/gpu/drm/sun4i/sun4i_backend.c      | 14 +++++++-
 drivers/gpu/drm/sun4i/sun4i_crtc.c         |  3 +-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c  |  6 +++-
 drivers/gpu/drm/sun4i/sunxi_engine.h       | 14 +++++++-
 include/drm/drm_atomic_helper.h            |  1 +-
 8 files changed, 74 insertions(+), 61 deletions(-)

base-commit: 5771a8c08880cdca3bfb4a3fc6d309d6bba20877
-- 
git-series 0.9.1
