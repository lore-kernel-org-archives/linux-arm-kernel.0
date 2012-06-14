From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Jun 2012 15:43:22 +0200
Subject: [PATCH, RFC] i.MX DRM support
Message-ID: <1339681407-28721-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

The following is the state-of-the-art i.MX IPU (Image Processing Unit)
DRM support.

This code is around for quite some time now and has been posted several
times with different APIs, first with plain old framebuffer support, now
DRM, first platform device binding, now devicetree. Unfortunately there's
quite much code needed to get something useful out of the IPU, so these
patches haven't received a lot of attention from people not involved in
i.MX. I think we have now come to a point where this code needs more public
exposure and where it's easier to talk in incremental changes instead of
blobs. Therefore I request this to go to staging for some cycles. This
would allow us to have something in mainline as a base for further discussion
while still being able to change bigger amounts of the driver without breaking
officially supported features. What do you think about this?

The IPU driver generally works on i.MX51, i.MX53 and i.MX6. The latter has
two IPUs, the driver is able to handle them both.

This series only contains the IPU driver. There are some additional glue
code patches necessary. Also necessary are two drm CMA/GEM helper patches
currently waiting for review on dri-devel. For testing the driver please
use this branch:

git://git.pengutronix.de/git/imx/linux-2.6.git work/gpu/imx-drm-ipu-complete

The branch contains board support for the i.MX51 babbage (both digital and
analog DVI outputs are supported) and i.MX6q armadillo2 (HDMI). Compile
with imx_v6_v7_defconfig.

For discussion of the devicetree binding please refer to the seperate mail
I sent.

As usual, all comments/suggestions welcome

Sascha


The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git work/gpu/imx-drm-ipu

for you to fetch changes up to 6c25e018285a93053daa69786faa8b3fe43597be:

  DRM i.MX: Add devicetree binding documentation (2012-06-14 14:30:52 +0200)

----------------------------------------------------------------
Philipp Zabel (1):
      DRM i.MX: Add devicetree binding documentation

Sascha Hauer (5):
      DRM: Add i.MX drm core support
      DRM i.MX: Add parallel display support
      DRM i.MX: Add LCDC support
      DRM: add i.MX IPUv3 base driver
      DRM: Add i.MX IPUv3 crtc support

 .../devicetree/bindings/drm/fsl-imx-drm.txt        |  126 +++
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/imx/Kconfig                        |   40 +
 drivers/gpu/drm/imx/Makefile                       |   10 +
 drivers/gpu/drm/imx/imx-drm-core.c                 |  891 ++++++++++++++++
 drivers/gpu/drm/imx/imx-drm.h                      |   58 +
 drivers/gpu/drm/imx/imx-fb.c                       |   47 +
 drivers/gpu/drm/imx/imx-fbdev.c                    |   65 ++
 drivers/gpu/drm/imx/imx-ipuv3-crtc.c               |  579 ++++++++++
 drivers/gpu/drm/imx/imx-lcdc-crtc.c                |  523 +++++++++
 drivers/gpu/drm/imx/imx-parallel-display.c         |  255 +++++
 drivers/gpu/drm/imx/ipu-v3/Makefile                |    3 +
 drivers/gpu/drm/imx/ipu-v3/ipu-common.c            | 1111 ++++++++++++++++++++
 drivers/gpu/drm/imx/ipu-v3/ipu-dc.c                |  384 +++++++
 drivers/gpu/drm/imx/ipu-v3/ipu-di.c                |  695 ++++++++++++
 drivers/gpu/drm/imx/ipu-v3/ipu-dmfc.c              |  410 ++++++++
 drivers/gpu/drm/imx/ipu-v3/ipu-dp.c                |  336 ++++++
 drivers/gpu/drm/imx/ipu-v3/ipu-prv.h               |  211 ++++
 include/drm/imx-ipu-v3.h                           |  320 ++++++
 20 files changed, 6067 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/fsl-imx-drm.txt
 create mode 100644 drivers/gpu/drm/imx/Kconfig
 create mode 100644 drivers/gpu/drm/imx/Makefile
 create mode 100644 drivers/gpu/drm/imx/imx-drm-core.c
 create mode 100644 drivers/gpu/drm/imx/imx-drm.h
 create mode 100644 drivers/gpu/drm/imx/imx-fb.c
 create mode 100644 drivers/gpu/drm/imx/imx-fbdev.c
 create mode 100644 drivers/gpu/drm/imx/imx-ipuv3-crtc.c
 create mode 100644 drivers/gpu/drm/imx/imx-lcdc-crtc.c
 create mode 100644 drivers/gpu/drm/imx/imx-parallel-display.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/Makefile
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-common.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-dc.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-di.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-dmfc.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-dp.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-prv.h
 create mode 100644 include/drm/imx-ipu-v3.h
