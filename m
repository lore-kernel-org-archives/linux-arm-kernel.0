From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  1 Feb 2011 12:18:34 +0100
Subject: i.MX ehci phy init cleanup
Message-ID: <1296559119-7723-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following series moves the i.MX usb phy setup from plat-mxc
to their corresponding mach directories. Also, it moves the call
to setup the phys from the ehci driver to the boards. With this
we will be able to change the i.MX51/53 phy setup to reflect the
additional flags for the phy in a later series.
Also, it removes the calls to cpu_is_* in the ehci driver which
allows us to use it on i.MX23/28 later.

Sascha

Sascha Hauer (5):
      ARM i.MX ehci: factor out soc specific functions
      ARM i.MX ehci: do ehci init in board specific functions
      USB ehci-mxc: make ahb clock optional on all i.MX SoCs
      ARM i.MX51/53: register usb phy clock as usb_phy
      USB ehci-mxc: make phy clock optional on all i.MX SoCs

 arch/arm/mach-imx/Makefile                  |    4 +-
 arch/arm/mach-imx/ehci-imx25.c              |   80 ++++++
 arch/arm/mach-imx/ehci-imx27.c              |   82 ++++++
 arch/arm/mach-imx/mach-cpuimx27.c           |   14 +-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c    |   16 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    7 +-
 arch/arm/mach-imx/mach-mx25_3ds.c           |    7 +-
 arch/arm/mach-imx/mach-mx27_3ds.c           |    6 +-
 arch/arm/mach-imx/mach-pca100.c             |   12 +-
 arch/arm/mach-imx/mach-pcm038.c             |    8 +-
 arch/arm/mach-mx3/Makefile                  |    4 +-
 arch/arm/mach-mx3/ehci-imx31.c              |   83 ++++++
 arch/arm/mach-mx3/ehci-imx35.c              |   80 ++++++
 arch/arm/mach-mx3/mach-armadillo5x0.c       |   10 +-
 arch/arm/mach-mx3/mach-cpuimx35.c           |   16 +-
 arch/arm/mach-mx3/mach-mx31_3ds.c           |   15 +-
 arch/arm/mach-mx3/mach-mx31lilly.c          |   17 +-
 arch/arm/mach-mx3/mach-mx31lite.c           |    6 +-
 arch/arm/mach-mx3/mach-mx31moboard.c        |    6 +-
 arch/arm/mach-mx3/mach-mx35_3ds.c           |   16 +-
 arch/arm/mach-mx3/mach-pcm037.c             |   14 +-
 arch/arm/mach-mx3/mach-pcm043.c             |   16 +-
 arch/arm/mach-mx3/mx31moboard-devboard.c    |    7 +-
 arch/arm/mach-mx3/mx31moboard-marxbot.c     |    6 +-
 arch/arm/mach-mx3/mx31moboard-smartbot.c    |    7 +-
 arch/arm/mach-mx5/Makefile                  |    2 +-
 arch/arm/mach-mx5/board-cpuimx51.c          |   13 +-
 arch/arm/mach-mx5/board-cpuimx51sd.c        |   13 +-
 arch/arm/mach-mx5/board-mx51_babbage.c      |   13 +-
 arch/arm/mach-mx5/board-mx51_efikamx.c      |    6 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c         |    2 +-
 arch/arm/mach-mx5/ehci.c                    |  156 +++++++++++
 arch/arm/plat-mxc/Makefile                  |    1 -
 arch/arm/plat-mxc/ehci.c                    |  369 ---------------------------
 arch/arm/plat-mxc/include/mach/mxc_ehci.h   |    7 +-
 drivers/usb/host/ehci-mxc.c                 |   48 +---
 36 files changed, 697 insertions(+), 472 deletions(-)
 create mode 100644 arch/arm/mach-imx/ehci-imx25.c
 create mode 100644 arch/arm/mach-imx/ehci-imx27.c
 create mode 100644 arch/arm/mach-mx3/ehci-imx31.c
 create mode 100644 arch/arm/mach-mx3/ehci-imx35.c
 create mode 100644 arch/arm/mach-mx5/ehci.c
 delete mode 100644 arch/arm/plat-mxc/ehci.c
