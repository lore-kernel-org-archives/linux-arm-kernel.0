From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:13 +0200
Subject: Convert i.MX architecture to generic clock framework
Message-ID: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

The following series is the first series converting the complete
i.MX architecture to the generic clock framework. I am currently
waiting for Mike posting his cleanup series to the clock framework
which will cause some adjustments to this series. However, this
series will only need some changes to the interface between i.MX
and the clock framework. The association between the devices and
the clocks (clk_lookup) and also the clocks themselves will stay
unchanged. Due to the huge amount of changes there *will* be
regressions, so now is the time to check if this works with your
favourite devices and boards. I'll happily integrate fixup patches
into this series.

As mentioned before my plan is to put this into the arm-soc staging
area soon (hopefully when Mikes series is posted and acked)

Thanks to Shawn for porting over the i.MX6.

Sascha

The following changes since commit b41c67c587c98eb2efb2a79d4b8122b04b519d4a:

  clkdev: Implement managed clk_get() (2012-04-10 09:35:09 +0200)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git work/v3.4-rc2-imx-clk

for you to fetch changes up to 3134a067ba4a66921acc8461165634abbae42e22:

  ARM i.MX: Remove now unused struct clk argument from mxc_timer_init (2012-04-10 09:35:54 +0200)

----------------------------------------------------------------
Sascha Hauer (35):
      clkdev: add clkname to struct clk_lookup
      clk: add a fixed factor clock
      dmaengine i.MX SDMA: do not depend on grouped clocks
      spi i.MX: do not depend on grouped clocks
      video imxfb: do not depend on grouped clocks
      net fec: do not depend on grouped clocks
      mmc mxcmmc: do not depend on grouped clocks
      mmc sdhc i.MX: do not depend on grouped clocks
      serial i.MX: do not depend on grouped clocks
      mtd mxc_nand: prepare/unprepare clock
      USB ehci mxc: prepare/unprepare clock
      w1 i.MX: prepare/unprepare clock
      watchdog imx2: prepare clk before enabling it
      media mx3 camera: prepare clk before enabling it
      dmaengine i.MX ipu: clk_prepare/unprepare clock
      ARM i.MX5: prepare gpc_dvfs_clk
      ARM i.MX: prepare for common clock framework
      ARM i.MX timer: request correct clock
      ARM i.MX: Add common clock support for pllv1
      ARM i.MX: Add common clock support for pllv2
      ARM i.MX: Add common clock support for 2bit gate
      ARM i.MX3: Make ccm base address a variable
      ARM i.MX25: implement clocks using common clock framework
      ARM i.MX1: implement clocks using common clock framework
      ARM i.MX21: implement clocks using common clock framework
      ARM i.MX27: implement clocks using common clock framework
      ARM i.MX31: implement clocks using common clock framework
      ARM i.MX5: implement clocks using common clock framework
      ARM i.MX35: implement clocks using common clock framework
      ARM i.MX: remove now unused old clock support
      ARM i.MX pllv1: move mxc_decode_pll to its only user
      ARM i.MX: remove unused legacy clock support
      USB gadget i.MX: fix clock handling
      USB ehci i.MX: Fix clock handling
      ARM i.MX: Remove now unused struct clk argument from mxc_timer_init

Shawn Guo (5):
      clk: declare clk_ops of basic clks in clk-provider.h
      ARM: imx: add common clock support for pllv3
      ARM: imx: add common clock support for pfd
      ARM: imx: add common clock support for clk busy
      ARM: imx6: implement clocks using common clock framework

 arch/arm/mach-imx/Kconfig               |    8 +
 arch/arm/mach-imx/Makefile              |   19 +-
 arch/arm/mach-imx/clk-busy.c            |  167 +++
 arch/arm/mach-imx/clk-gate2.c           |  125 ++
 arch/arm/mach-imx/clk-imx1.c            |  108 ++
 arch/arm/mach-imx/clk-imx21.c           |  173 +++
 arch/arm/mach-imx/clk-imx25.c           |  232 ++++
 arch/arm/mach-imx/clk-imx27.c           |  254 ++++
 arch/arm/mach-imx/clk-imx31.c           |  167 +++
 arch/arm/mach-imx/clk-imx35.c           |  258 ++++
 arch/arm/mach-imx/clk-imx51-imx53.c     |  412 ++++++
 arch/arm/mach-imx/clk-imx6q.c           |  407 ++++++
 arch/arm/mach-imx/clk-pfd.c             |  138 ++
 arch/arm/mach-imx/clk-pllv1.c           |  104 ++
 arch/arm/mach-imx/clk-pllv2.c           |  243 ++++
 arch/arm/mach-imx/clk-pllv3.c           |  408 ++++++
 arch/arm/mach-imx/clk.h                 |   83 ++
 arch/arm/mach-imx/clock-imx1.c          |  636 ----------
 arch/arm/mach-imx/clock-imx21.c         | 1239 ------------------
 arch/arm/mach-imx/clock-imx25.c         |  346 -----
 arch/arm/mach-imx/clock-imx27.c         |  785 ------------
 arch/arm/mach-imx/clock-imx31.c         |  630 ---------
 arch/arm/mach-imx/clock-imx35.c         |  536 --------
 arch/arm/mach-imx/clock-imx6q.c         | 2111 -------------------------------
 arch/arm/mach-imx/clock-mx51-mx53.c     | 1675 ------------------------
 arch/arm/mach-imx/crmregs-imx3.h        |   79 +-
 arch/arm/mach-imx/mm-imx3.c             |    6 +
 arch/arm/mach-imx/mm-imx5.c             |    1 +
 arch/arm/mach-imx/pm-imx3.c             |    4 +-
 arch/arm/plat-mxc/clock.c               |  228 +---
 arch/arm/plat-mxc/include/mach/clock.h  |   43 +-
 arch/arm/plat-mxc/include/mach/common.h |    2 +-
 arch/arm/plat-mxc/time.c                |   16 +-
 drivers/clk/Makefile                    |    2 +-
 drivers/clk/clk-fixed-factor.c          |   97 ++
 drivers/clk/clkdev.c                    |    8 +
 drivers/dma/imx-sdma.c                  |   40 +-
 drivers/dma/ipu/ipu_idmac.c             |    6 +-
 drivers/media/video/mx3_camera.c        |    4 +-
 drivers/mmc/host/mxcmmc.c               |   39 +-
 drivers/mmc/host/sdhci-esdhc-imx.c      |   42 +-
 drivers/mtd/nand/mxc_nand.c             |    6 +-
 drivers/net/ethernet/freescale/fec.c    |   35 +-
 drivers/spi/spi-imx.c                   |   30 +-
 drivers/tty/serial/imx.c                |   38 +-
 drivers/usb/gadget/fsl_mxc_udc.c        |   74 +-
 drivers/usb/host/ehci-mxc.c             |   58 +-
 drivers/video/imxfb.c                   |   50 +-
 drivers/w1/masters/mxc_w1.c             |    4 +-
 drivers/watchdog/imx2_wdt.c             |    2 +-
 include/linux/clk-private.h             |    8 -
 include/linux/clk-provider.h            |   12 +
 include/linux/clkdev.h                  |    3 +
 53 files changed, 3736 insertions(+), 8465 deletions(-)
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
 delete mode 100644 arch/arm/mach-imx/clock-imx1.c
 delete mode 100644 arch/arm/mach-imx/clock-imx21.c
 delete mode 100644 arch/arm/mach-imx/clock-imx25.c
 delete mode 100644 arch/arm/mach-imx/clock-imx27.c
 delete mode 100644 arch/arm/mach-imx/clock-imx31.c
 delete mode 100644 arch/arm/mach-imx/clock-imx35.c
 delete mode 100644 arch/arm/mach-imx/clock-imx6q.c
 delete mode 100644 arch/arm/mach-imx/clock-mx51-mx53.c
 create mode 100644 drivers/clk/clk-fixed-factor.c
