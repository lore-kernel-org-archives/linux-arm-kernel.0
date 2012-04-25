From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 17:27:50 +0200
Subject: [PATCH v2] Convert i.MX architecture to generic clock framework
Message-ID: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is another round of patches to convert i.MX to the generic clock
framework. It is based on Mikes recently published for-next branch plus:

[PATCH V3 1/8] CLKDEV: Add helper routines to allocate and add clkdevs for given struct clk *
[PATCH V3 2/8] clk: add a fixed factor clock
clkdev: Implement managed clk_get()

The branch is tested on all SoCs I have available, but regressions are more
than likely, so please give it a test.

I didn't move the clock support to drivers/clk now as the clock control
module is shared with several other SoC specific stuff and I need a global
spinlock. Accessing this somewhere from drivers/ seems odd. Depending on
how things work out we can move it to drivers/ later.

The remaining cleanups like removing the old clock support posted in the
last series are not included here, I will respin them once it's clear that
a series goes in

For your convenience a complete series including dependencies (so not
meant for upstream) can be pulled here:

git://git.pengutronix.de/git/imx/linux-2.6.git work/v3.4-rc4-imx-clk

Thanks
 Sascha

----------------------------------------------------------------
Sascha Hauer (29):
      dmaengine i.MX SDMA: do not depend on grouped clocks
      spi i.MX: do not depend on grouped clocks
      video imxfb: do not depend on grouped clocks
      net fec: do not depend on grouped clocks
      mmc mxcmmc: do not depend on grouped clocks
      mmc sdhc i.MX: do not depend on grouped clocks
      serial i.MX: do not depend on grouped clocks
      mtd mxc_nand: prepare/unprepare clock
      USB ehci mxc: prepare/unprepare clock
      USB ehci mxc: sanitize clock handling
      w1 i.MX: prepare/unprepare clock
      watchdog imx2: prepare clk before enabling it
      media mx3 camera: prepare clk before enabling it
      dmaengine i.MX ipu: clk_prepare/unprepare clock
      rtc: imx dryice: Add missing clk_prepare
      ARM i.MX5: prepare gpc_dvfs_clk
      ARM i.MX timer: request correct clock
      ARM i.MX3: Make ccm base address a variable
      ARM i.MX: prepare for common clock framework
      ARM i.MX: Add common clock support for pllv1
      ARM i.MX: Add common clock support for pllv2
      ARM i.MX: Add common clock support for 2bit gate
      ARM i.MX25: implement clocks using common clock framework
      ARM i.MX1: implement clocks using common clock framework
      ARM i.MX21: implement clocks using common clock framework
      ARM i.MX27: implement clocks using common clock framework
      ARM i.MX31: implement clocks using common clock framework
      ARM i.MX5: implement clocks using common clock framework
      ARM i.MX35: implement clocks using common clock framework

Shawn Guo (4):
      ARM: imx: add common clock support for pllv3
      ARM: imx: add common clock support for pfd
      ARM: imx: add common clock support for clk busy
      ARM: i.MX6: implement clocks using common clock framework

 arch/arm/mach-imx/Kconfig              |    8 +
 arch/arm/mach-imx/Makefile             |   19 +-
 arch/arm/mach-imx/clk-busy.c           |  173 ++++++++++++
 arch/arm/mach-imx/clk-gate2.c          |  115 ++++++++
 arch/arm/mach-imx/clk-imx1.c           |  115 ++++++++
 arch/arm/mach-imx/clk-imx21.c          |  186 +++++++++++++
 arch/arm/mach-imx/clk-imx25.c          |  248 +++++++++++++++++
 arch/arm/mach-imx/clk-imx27.c          |  290 ++++++++++++++++++++
 arch/arm/mach-imx/clk-imx31.c          |  182 +++++++++++++
 arch/arm/mach-imx/clk-imx35.c          |  278 +++++++++++++++++++
 arch/arm/mach-imx/clk-imx51-imx53.c    |  466 ++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk-imx6q.c          |  439 ++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk-pfd.c            |  138 ++++++++++
 arch/arm/mach-imx/clk-pllv1.c          |   57 ++++
 arch/arm/mach-imx/clk-pllv2.c          |  239 ++++++++++++++++
 arch/arm/mach-imx/clk-pllv3.c          |  409 ++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk.h                |   83 ++++++
 arch/arm/mach-imx/crmregs-imx3.h       |   79 +++---
 arch/arm/mach-imx/mm-imx3.c            |    6 +
 arch/arm/mach-imx/mm-imx5.c            |    1 +
 arch/arm/mach-imx/pm-imx3.c            |    4 +-
 arch/arm/plat-mxc/clock.c              |   11 +
 arch/arm/plat-mxc/include/mach/clock.h |    4 +
 arch/arm/plat-mxc/time.c               |   14 +
 drivers/dma/imx-sdma.c                 |   40 ++-
 drivers/dma/ipu/ipu_idmac.c            |    6 +-
 drivers/media/video/mx3_camera.c       |    4 +-
 drivers/mmc/host/mxcmmc.c              |   39 ++-
 drivers/mmc/host/sdhci-esdhc-imx.c     |   42 ++-
 drivers/mtd/nand/mxc_nand.c            |    6 +-
 drivers/net/ethernet/freescale/fec.c   |   35 ++-
 drivers/rtc/rtc-imxdi.c                |    6 +-
 drivers/spi/spi-imx.c                  |   30 +-
 drivers/tty/serial/imx.c               |   38 ++-
 drivers/usb/host/ehci-mxc.c            |   62 ++---
 drivers/video/imxfb.c                  |   50 +++-
 drivers/w1/masters/mxc_w1.c            |    4 +-
 drivers/watchdog/imx2_wdt.c            |    2 +-
 38 files changed, 3739 insertions(+), 189 deletions(-)
 create mode 100644 arch/arm/mach-imx/clk-busy.c
 create mode 100644 arch/arm/mach-imx/clk-gate2.c
 create mode 100644 arch/arm/mach-imx/clk-imx1.c
 create mode 100644 arch/arm/mach-imx/clk-imx21.c
 create mode 100644 arch/arm/mach-imx/clk-imx25.c
 create mode 100644 arch/arm/mach-imx/clk-imx27.c
 create mode 100644 arch/arm/mach-imx/clk-imx31.c
 create mode 100644 arch/arm/mach-imx/clk-imx35.c
 create mode 100644 arch/arm/mach-imx/clk-imx51-imx53.c
 create mode 100644 arch/arm/mach-imx/clk-imx6q.c
 create mode 100644 arch/arm/mach-imx/clk-pfd.c
 create mode 100644 arch/arm/mach-imx/clk-pllv1.c
 create mode 100644 arch/arm/mach-imx/clk-pllv2.c
 create mode 100644 arch/arm/mach-imx/clk-pllv3.c
 create mode 100644 arch/arm/mach-imx/clk.h
