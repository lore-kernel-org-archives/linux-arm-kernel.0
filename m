From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 16 Feb 2011 15:10:45 +0100
Subject: [PATCH v3] Add i.MX51/53 IPU framebuffer support
Message-ID: <1297865452-32181-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following is the third version of the series adding ipu support
for the i.MX51/53.

Changes since last version:

- The IPU core driver now sits in drivers/video instead of drivers/mfd.
  It still needs mfd support, so it has a select on MFD_SUPPORT and
  MFD_CORE.
- The fb driver does not reallocate memory anymore. This is broken since
  there is a risk that some userspace process still has the memory mapped
  while we reallocate it which leads to bad results.

Sascha Hauer (7):
      Add a mfd IPUv3 driver
      fb: export fb mode db table
      Add i.MX5 framebuffer driver
      ARM i.MX51: Add IPU device support
      ARM i.MX5: Allow to increase max zone order
      ARM i.MX5: increase dma consistent size for IPU support
      ARM i.MX51 babbage: Add framebuffer support

 arch/arm/Kconfig                                |    4 +-
 arch/arm/mach-mx5/Kconfig                       |    1 +
 arch/arm/mach-mx5/board-mx51_babbage.c          |   74 ++
 arch/arm/mach-mx5/devices-imx51.h               |    4 +
 arch/arm/plat-mxc/devices/Kconfig               |    4 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-imx_ipuv3.c  |   47 ++
 arch/arm/plat-mxc/include/mach/devices-common.h |   10 +
 arch/arm/plat-mxc/include/mach/ipu-v3.h         |   49 ++
 arch/arm/plat-mxc/include/mach/memory.h         |    3 +-
 drivers/video/Kconfig                           |   13 +
 drivers/video/Makefile                          |    2 +
 drivers/video/imx-ipu-v3/Makefile               |    3 +
 drivers/video/imx-ipu-v3/ipu-common.c           |  708 +++++++++++++++++
 drivers/video/imx-ipu-v3/ipu-cpmem.c            |  612 +++++++++++++++
 drivers/video/imx-ipu-v3/ipu-dc.c               |  364 +++++++++
 drivers/video/imx-ipu-v3/ipu-di.c               |  550 ++++++++++++++
 drivers/video/imx-ipu-v3/ipu-dmfc.c             |  355 +++++++++
 drivers/video/imx-ipu-v3/ipu-dp.c               |  476 ++++++++++++
 drivers/video/imx-ipu-v3/ipu-prv.h              |  216 ++++++
 drivers/video/modedb.c                          |    8 +-
 drivers/video/mx5fb.c                           |  925 +++++++++++++++++++++++
 include/linux/fb.h                              |    3 +
 include/linux/mfd/imx-ipu-v3.h                  |  219 ++++++
 24 files changed, 4646 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx_ipuv3.c
 create mode 100644 arch/arm/plat-mxc/include/mach/ipu-v3.h
 create mode 100644 drivers/video/imx-ipu-v3/Makefile
 create mode 100644 drivers/video/imx-ipu-v3/ipu-common.c
 create mode 100644 drivers/video/imx-ipu-v3/ipu-cpmem.c
 create mode 100644 drivers/video/imx-ipu-v3/ipu-dc.c
 create mode 100644 drivers/video/imx-ipu-v3/ipu-di.c
 create mode 100644 drivers/video/imx-ipu-v3/ipu-dmfc.c
 create mode 100644 drivers/video/imx-ipu-v3/ipu-dp.c
 create mode 100644 drivers/video/imx-ipu-v3/ipu-prv.h
 create mode 100644 drivers/video/mx5fb.c
 create mode 100644 include/linux/mfd/imx-ipu-v3.h
