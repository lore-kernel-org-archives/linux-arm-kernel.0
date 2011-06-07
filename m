From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  7 Jun 2011 12:45:45 +0200
Subject: [RFC PATCH] KMS support for i.MX51/53
Message-ID: <1307443550-25549-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

The following adds a KMS driver for the Freescale i.MX51/53 SoCs.

It is far from being ready but I think it is enough to send it
out and get the first comments on it and to show that there's
something going on.

Currently I don't use any sophisticated memory allocater like GEM
or similar. I helped myself with simple dma_alloc where needed. At
the current state I don't need any more sophisticated allocator
as I only focused on the KMS part. Many dumb framebuffers on embedded
systems could use a simple allocator at least until something
better usable for these kind of systems shows up. The driver currently
does its allocations in the DRM_IOCTL_MODE_ADDFB ioctl, which of course
is not very standard conform.

I tested this driver on the i.MX51 with a DVI and VGA display connected
in different clone and dual head modes. Also tested is the i.MX53 LOCO
board with the optional HDMI adapter (I didn't get the TV encoder for
VGA to work though).

First part of the series is the IPU base driver which has been posted
several times before, this time with generic interrupt support and
fully multi instance safe. Also several smaller improvements have been
made. For the DRM people probably only the last three patches are of
interest.

The series depends on several other patches not posted here. So for
those who want to test this please pull the following branch:

git://git.pengutronix.de/git/imx/linux-2.6.git imx-ipu-kms

As said the driver is not fully standard conform and libkms currently
is not suitable for this driver, so the only test utility (apart
from the legacy framebuffer) is a little selfmade tool you can
get here:

git://git.pengutronix.de/git/sha/kmstest.git

It is basically a KMS wrapper around the well known fbtest utility.
Different mode settings can be supplied on the command line. A README
is included.

Sascha


Sascha Hauer (5):
      DRM: add i.MX IPUv3 base driver
      DRM i.MX IPU: Add support for IPU submodules
      DRM: Add drm encoder/connector helper
      DRM: Add support for the sii902x HDMI/DVI encoder
      DRM: Add i.MX IPUv3 support

 arch/arm/plat-mxc/include/mach/ipu-v3.h |   22 +
 drivers/gpu/drm/Kconfig                 |   28 +
 drivers/gpu/drm/Makefile                |    2 +
 drivers/gpu/drm/drm_encon.c             |  302 ++++++++++
 drivers/gpu/drm/i2c/Makefile            |    3 +
 drivers/gpu/drm/i2c/sii902x.c           |  334 +++++++++++
 drivers/gpu/drm/imx/Makefile            |    3 +
 drivers/gpu/drm/imx/imx-drm.c           |  936 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/imx-priv.h          |    9 +
 drivers/gpu/drm/imx/ipu-v3/Makefile     |    3 +
 drivers/gpu/drm/imx/ipu-v3/ipu-common.c |  799 ++++++++++++++++++++++++++
 drivers/gpu/drm/imx/ipu-v3/ipu-dc.c     |  440 +++++++++++++++
 drivers/gpu/drm/imx/ipu-v3/ipu-di.c     |  665 ++++++++++++++++++++++
 drivers/gpu/drm/imx/ipu-v3/ipu-dmfc.c   |  393 +++++++++++++
 drivers/gpu/drm/imx/ipu-v3/ipu-dp.c     |  342 +++++++++++
 drivers/gpu/drm/imx/ipu-v3/ipu-prv.h    |  218 +++++++
 include/drm/drm_encon.h                 |   46 ++
 include/drm/imx-ipu-v3.h                |  308 ++++++++++
 18 files changed, 4853 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/ipu-v3.h
 create mode 100644 drivers/gpu/drm/drm_encon.c
 create mode 100644 drivers/gpu/drm/i2c/sii902x.c
 create mode 100644 drivers/gpu/drm/imx/Makefile
 create mode 100644 drivers/gpu/drm/imx/imx-drm.c
 create mode 100644 drivers/gpu/drm/imx/imx-priv.h
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/Makefile
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-common.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-dc.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-di.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-dmfc.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-dp.c
 create mode 100644 drivers/gpu/drm/imx/ipu-v3/ipu-prv.h
 create mode 100644 include/drm/drm_encon.h
 create mode 100644 include/drm/imx-ipu-v3.h
