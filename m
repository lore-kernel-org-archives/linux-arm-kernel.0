From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Oct 2016 10:29:33 +0200
Subject: [PATCH 0/5] drm/sun4i: Handle TV overscan
Message-ID: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The Allwinner display engine doesn't have any kind of hardware help to deal
with TV overscan.

This means that if we use the only mode the hardware provides (either PAL
or NTSC, or something else), most of the screens will crop the borders of
the image, which is bad.

We can however use somekind of a hack, to instead reduce the mode exposed
to the userspace, and center it in the final image. We would expose
different overscan ratio to be able to deal with most of the screens, each
reducing more the displayable area.

The first patches are rework for the command line parser in order to be
able to use named modes. This is going to be helpful for us, since
different modes might have the same timings but only differ on a few
settings not exposed in the modes, but it might eventually be used for the
*VGA modes for example.

The last patches extend the current driver to deal with the changes used
to introduce the overscan.

Let me know what you think,
Maxime

Maxime Ripard (5):
  drm/modes: Rewrite the command line parser
  drm/modes: Support modes names on the command line
  drm/sun4i: Add custom crtc state
  drm/sun4i: Compute TCON1 mode from tv mode
  drm/sun4i: Add support for the overscan profiles

 drivers/gpu/drm/drm_connector.c       |   3 +-
 drivers/gpu/drm/drm_fb_helper.c       |   4 +-
 drivers/gpu/drm/drm_modes.c           | 324 +++++++++++++++++----------
 drivers/gpu/drm/sun4i/sun4i_backend.c |  18 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c    |  37 ++-
 drivers/gpu/drm/sun4i/sun4i_crtc.h    |  16 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c     |  10 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c      |  75 ++++--
 include/drm/drm_connector.h           |   1 +-
 9 files changed, 342 insertions(+), 146 deletions(-)

-- 
git-series 0.8.10
