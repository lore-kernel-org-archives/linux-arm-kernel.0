From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Aug 2010 11:05:35 +0200
Subject: [RFC] SDMA support for i.MX
Message-ID: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Ever wondered what's hidden behind the tons of SDMA/iapi stuff in the
Freescale kernel? It's a nice and convenient to use DMA engine. The
following patches add support for it.

First of all a wrapper for the current i.MX DMA support is implemented
to allow the drivers to compile in DMA support without ifdefs. Then the
SDMA support itself is implemented and users are switched to support
the new DMA API.

The SDMA engine needs additional firmware support. Since fsl does
not use the standard request_firmware mechanism but compiles in the
firmware as static arrays, I had to invent a firmware layout.
You can get the program for generating the firmware images from
the static arrays here:

git://git.pengutronix.de/git/imx/sdma-firmware.git

As the layout of the firmware is not given by fsl but by me it should
be part of the review.

The SDMA code has currently been tested on i.MX31/35 with sound and
on i.MX31 with SD/MMC. i.MX25/51 are untested, but should work aswell.

Sascha

The following changes since commit fc1caf6eafb30ea185720e29f7f5eccca61ecd60:

  Merge branch 'drm-core-next' of git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6 (2010-08-05 16:02:01 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git sdma

Sascha Hauer (8):
      ARM i.MX dma: implement wrapper for dma functions
      ARM i.MX dma-mx1-mx2: use wrapper
      mxcmmc: use new dma api
      ARM i.MX: add SDMA driver
      ARM i.MX3: Add sdma device
      ARM i.MX3: add dma request defines
      ARM i.MX3: add dma request resources to ssi/sdhc devices
      ASoC i.MX: switch to new DMA api

 arch/arm/mach-imx/dma-v1.c                   |  142 +++-
 arch/arm/mach-imx/include/mach/dma-mx1-mx2.h |    2 +-
 arch/arm/mach-imx/include/mach/dma-v1.h      |    8 +-
 arch/arm/mach-mx3/Kconfig                    |    2 +
 arch/arm/mach-mx3/clock-imx31.c              |    4 +-
 arch/arm/mach-mx3/clock-imx35.c              |    2 +-
 arch/arm/mach-mx3/devices.c                  |   80 ++
 arch/arm/plat-mxc/Kconfig                    |   10 +
 arch/arm/plat-mxc/Makefile                   |    3 +-
 arch/arm/plat-mxc/dma.c                      |  112 +++
 arch/arm/plat-mxc/include/mach/dma.h         |   92 ++
 arch/arm/plat-mxc/include/mach/mx31.h        |   14 +
 arch/arm/plat-mxc/include/mach/mx35.h        |   26 +
 arch/arm/plat-mxc/include/mach/mx3x.h        |   29 +
 arch/arm/plat-mxc/include/mach/sdma.h        |    8 +
 arch/arm/plat-mxc/sdma.c                     | 1181 ++++++++++++++++++++++++++
 drivers/mmc/host/mxcmmc.c                    |  129 ++--
 sound/soc/imx/Makefile                       |    2 -
 sound/soc/imx/imx-pcm-dma-mx2.c              |  177 ++---
 sound/soc/imx/imx-ssi.c                      |    8 +-
 20 files changed, 1826 insertions(+), 205 deletions(-)
 create mode 100644 arch/arm/plat-mxc/dma.c
 create mode 100644 arch/arm/plat-mxc/include/mach/dma.h
 create mode 100644 arch/arm/plat-mxc/include/mach/sdma.h
 create mode 100644 arch/arm/plat-mxc/sdma.c
