From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Apr 2012 17:33:41 +0200
Subject: [RFC] DRM helpers for embedded systems
Message-ID: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

The following series adds support for a new set of drm helpers called
sdrm. It is targeted to ease the implementation of drivers for embedded
systems. The basic idea is that instead of handling a comlete drm device
in each driver we introduce helpers which take care of the drm device
and most of the interfacing with the drm core. Users of these helpers
can register crtcs, encoders and connectors as separate devices which
reflects the hardware of embedded systems better than a monolithic drm
device. The patches are mostly based on the exynos driver. While writing
a driver for my devices I realized that I had to duplicate the bulk of
this driver, mostly replacing the exynos_ prefixes with imx_ prefixes,
hence the idea of creating a common infrastructure for this.

As a testbed driver a i.MX LCDC driver and a Intel (Marvell) PXA2xx
driver is included. Both are very simple last-decade-embedded-lcd-controllers.
The drivers have been tested with the xf86 modesetting driver, some libdrm
tests and a custom kms testing tool. Currently only the base framebuffers
are supported, but KMS plane support is definitely on my todo list.  The
drivers posted here are mostly created for demonstration purpose and to
give a template for other drivers, but the motivation for creating this
layer was the i.MX5/6 IPU (Image Processing Unit) which has two crts (four
on i.MX6), several on-SoC encoders and overlay possibilities. So this layer
should not be limited to the real 'simple' cases.

The sdrm patches currently have some limitations, but they should be
enough for being useful and to present it to a wider audience. Currently
no custom ioctls are supported, basically because I didn't need them
yet.  Also the pitch for the framebuffers are hardcoded by the sdrm
layer, this should be done in the crtc drivers instead.  Another thing
is that I currently have no idea what might be needed to support IOMMUs,
but maybe Thierry can help me out with his Tegra patches ;)

For a more complete branch including board support for a PXA27x based
Phytec board see this branch:

git://git.pengutronix.de/git/imx/linux-2.6.git gpu/sdrm-full

Comments very appreciated.

Sascha



The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git gpu/sdrm

for you to fetch changes up to fc3d0ff4825de998f1fd902184f7df040248d0de:

  DRM: add PXA kms simple driver (2012-04-11 17:10:46 +0200)

----------------------------------------------------------------
Philipp Zabel (1):
      DRM: add PXA kms simple driver

Sascha Hauer (6):
      drm: remove legacy mode_group handling
      drm: make gamma_set optional
      DRM: add sdrm layer for general embedded system support
      DRM: Add sdrm 1:1 encoder - connector helper
      DRM: add i.MX kms simple driver
      ARM i.MX27 pcm038: Add sdrm support

 arch/arm/mach-imx/pcm970-baseboard.c      |   78 ++-
 arch/arm/mach-pxa/include/mach/regs-lcd.h |    2 +
 arch/arm/plat-mxc/include/mach/imxfb.h    |    8 +-
 drivers/gpu/drm/Kconfig                   |    6 +
 drivers/gpu/drm/Makefile                  |    3 +
 drivers/gpu/drm/drm_crtc.c                |  163 ++----
 drivers/gpu/drm/drm_pci.c                 |    8 -
 drivers/gpu/drm/drm_platform.c            |    8 -
 drivers/gpu/drm/drm_usb.c                 |    6 -
 drivers/gpu/drm/imx/Kconfig               |    8 +
 drivers/gpu/drm/imx/Makefile              |    1 +
 drivers/gpu/drm/imx/imx-lcdc-crtc.c       |  506 ++++++++++++++++
 drivers/gpu/drm/pxa/Kconfig               |   12 +
 drivers/gpu/drm/pxa/Makefile              |    1 +
 drivers/gpu/drm/pxa/pxa-lcdc-crtc.c       |  845 +++++++++++++++++++++++++++
 drivers/gpu/drm/sdrm/Kconfig              |   11 +
 drivers/gpu/drm/sdrm/Makefile             |    5 +
 drivers/gpu/drm/sdrm/sdrm.c               |  904 +++++++++++++++++++++++++++++
 drivers/gpu/drm/sdrm/sdrm.h               |   57 ++
 drivers/gpu/drm/sdrm/sdrm_encon.c         |  211 +++++++
 drivers/gpu/drm/sdrm/sdrm_encon_dummy.c   |  193 ++++++
 drivers/gpu/drm/sdrm/sdrm_fb.c            |  191 ++++++
 drivers/gpu/drm/sdrm/sdrm_fbdev.c         |  238 ++++++++
 drivers/gpu/drm/sdrm/sdrm_gem.c           |  342 +++++++++++
 include/drm/drmP.h                        |    1 -
 include/drm/drm_crtc.h                    |   24 +-
 include/drm/sdrm.h                        |  102 ++++
 include/drm/sdrm_encon.h                  |   69 +++
 28 files changed, 3831 insertions(+), 172 deletions(-)
 create mode 100644 drivers/gpu/drm/imx/Kconfig
 create mode 100644 drivers/gpu/drm/imx/Makefile
 create mode 100644 drivers/gpu/drm/imx/imx-lcdc-crtc.c
 create mode 100644 drivers/gpu/drm/pxa/Kconfig
 create mode 100644 drivers/gpu/drm/pxa/Makefile
 create mode 100644 drivers/gpu/drm/pxa/pxa-lcdc-crtc.c
 create mode 100644 drivers/gpu/drm/sdrm/Kconfig
 create mode 100644 drivers/gpu/drm/sdrm/Makefile
 create mode 100644 drivers/gpu/drm/sdrm/sdrm.c
 create mode 100644 drivers/gpu/drm/sdrm/sdrm.h
 create mode 100644 drivers/gpu/drm/sdrm/sdrm_encon.c
 create mode 100644 drivers/gpu/drm/sdrm/sdrm_encon_dummy.c
 create mode 100644 drivers/gpu/drm/sdrm/sdrm_fb.c
 create mode 100644 drivers/gpu/drm/sdrm/sdrm_fbdev.c
 create mode 100644 drivers/gpu/drm/sdrm/sdrm_gem.c
 create mode 100644 include/drm/sdrm.h
 create mode 100644 include/drm/sdrm_encon.h
