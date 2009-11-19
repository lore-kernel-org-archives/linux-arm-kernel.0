From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Nov 2009 16:48:14 +0100
Subject: i.MX audio support
Message-ID: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi All,

This series adds support for AOSC on i.MX platforms. It uses DMA where
available (i.MX27) and fiq otherwise. The driver works on all Phytec i.MX
platforms, so the i.MX27, i.MX31 and the i.MX35 are supported including
AC97 support.

There already is a driver for i.MX in the tree, this one is a nearly complete
rewrite. I haven't touched the in Kernel driver with these patches. The in
Kernel driver has several problems, it doesn't use ioremap, uses direct pointer
derefs instead of proper access functions and the only board supported so far is
itself not supported in mainline.

AC97 support is a problem on i.MX. I found no way to tell the SSI controller
which slots it should capture, so all slots the codec decides to send go into
one single FIFO. The WM9712 I worked with sends data in slot 12 which we have
to sort out manually from the FIFO, so I think there is no way to work around
the fiq handler using the DMA engine with AC97.

The devdma code is actually a copy of sound/arm/devdma.[ch]. It should probably
be selected somehow instead of duplicated.

I'm not very familiar with ALSA, so I expect some comments in this area. Let
me know what has to be done to get this into mainline.

This series depends on the SSI resources and audmux support being present. I posted
these patches on arm linux kernel recently and they are available here:

git://git.pengutronix.de/git/imx/linux-2.6.git mxc-master


Any comments welcome.

  Sascha

The following changes since commit 3f92a8bd5fb13e7e2505c65d1548910eaa843024:
  Uwe Kleine-K?nig (1):
        imx: copy constants from mx3x.h to mx35.h using the appropriate namespace

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git asoc

Sascha Hauer (12):
      mx3: Add SSI pins to iomux table
      mxc: iomux v3: remove resource handling
      add a mc13783 codec driver
      i.MX31 clock: rename SSI clocks to driver name
      mxc: mx1/mx2 DMA: add a possibility to create an endless DMA transfer
      imx-ssi sound driver
      add phycore sound support
      sound/soc/imx: Makefile/Kconfig changes for new driver
      pcm038: add sound support
      pcm043: add sound support
      pca100: add sound support
      pcm037: Add sound support

 arch/arm/mach-mx2/pca100.c                   |   52 +
 arch/arm/mach-mx2/pcm038.c                   |   23 +-
 arch/arm/mach-mx3/clock.c                    |    4 +-
 arch/arm/mach-mx3/pcm037.c                   |   72 ++
 arch/arm/mach-mx3/pcm043.c                   |  102 ++
 arch/arm/plat-mxc/Makefile                   |    1 +
 arch/arm/plat-mxc/dma-mx1-mx2.c              |    3 +-
 arch/arm/plat-mxc/include/mach/dma-mx1-mx2.h |    8 +
 arch/arm/plat-mxc/include/mach/iomux-mx3.h   |    8 +
 arch/arm/plat-mxc/include/mach/iomux-v3.h    |   17 +-
 arch/arm/plat-mxc/include/mach/ssi.h         |   17 +
 arch/arm/plat-mxc/iomux-v3.c                 |   36 +-
 arch/arm/plat-mxc/ssi-fiq.S                  |  134 +++
 sound/soc/codecs/Kconfig                     |    3 +
 sound/soc/codecs/Makefile                    |    2 +
 sound/soc/codecs/mc13783.c                   |  739 ++++++++++++++
 sound/soc/codecs/mc13783.h                   |   29 +
 sound/soc/imx/Kconfig                        |   15 +-
 sound/soc/imx/Makefile                       |    9 +-
 sound/soc/imx/devdma.c                       |   80 ++
 sound/soc/imx/devdma.h                       |    3 +
 sound/soc/imx/imx-ssi.c                      | 1349 ++++++++++++++++++++++++++
 sound/soc/imx/imx-ssi.h                      |   24 +
 sound/soc/imx/phycore.c                      |  181 ++++
 24 files changed, 2851 insertions(+), 60 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/ssi.h
 create mode 100644 arch/arm/plat-mxc/ssi-fiq.S
 create mode 100644 sound/soc/codecs/mc13783.c
 create mode 100644 sound/soc/codecs/mc13783.h
 create mode 100644 sound/soc/imx/devdma.c
 create mode 100644 sound/soc/imx/devdma.h
 create mode 100644 sound/soc/imx/imx-ssi.c
 create mode 100644 sound/soc/imx/imx-ssi.h
 create mode 100644 sound/soc/imx/phycore.c
