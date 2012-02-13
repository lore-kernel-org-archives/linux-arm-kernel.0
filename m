From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 15:43:13 -0600
Subject: [PATCH 00/15] mach/io.h cleanup and removal
Message-ID: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series cleans-up mach/io.h and removes it for most platforms that have
the same definitions of __io() and __mem_pci(). This mainly leaves platforms
with PCI that need an io.h. Most of those can be converted once we have a
fixed IO space mapping. OMAP io.h also remains as moving all the extra io.h
stuff leaves it quite broken, so I'm leaving it to the OMAP folks to convert.

I've compiled all defconfigs and I think I've fixed all the new breakage.
There's still a few platforms broken in rc3.

These are the remaining mach/io.h files:

arch/arm/mach-dove/include/mach/io.h
arch/arm/mach-ebsa110/include/mach/io.h
arch/arm/mach-footbridge/include/mach/io.h
arch/arm/mach-integrator/include/mach/io.h
arch/arm/mach-iop13xx/include/mach/io.h
arch/arm/mach-iop32x/include/mach/io.h
arch/arm/mach-iop33x/include/mach/io.h
arch/arm/mach-ixp2000/include/mach/io.h
arch/arm/mach-ixp23xx/include/mach/io.h
arch/arm/mach-ixp4xx/include/mach/io.h
arch/arm/mach-kirkwood/include/mach/io.h
arch/arm/mach-mv78xx0/include/mach/io.h
arch/arm/mach-omap1/include/mach/io.h
arch/arm/mach-omap2/include/mach/io.h
arch/arm/mach-rpc/include/mach/io.h
arch/arm/mach-s3c2410/include/mach/io.h
arch/arm/mach-shark/include/mach/io.h
arch/arm/mach-tegra/include/mach/io.h
arch/arm/mach-vt8500/include/mach/io.h
arch/arm/plat-omap/include/plat/io.h

Rob

Rob Herring (15):
  usb: ohci-pxa27x: add explicit include of hardware.h
  ARM: add explicit include of system.h to processor.h
  ARM: provide runtime hook for ioremap
  ARM: imx: convert to common runtime ioremap hook
  ARM: msm: use runtime ioremap hook
  ARM: msm: clean-up mach/io.h
  ARM: at91: clean-up mach/io.h
  ARM: davinci: remove unneeded mach/io.h include
  ARM: orion5x: clean-up mach/io.h
  ARM: tegra: clean-up mach/io.h
  ARM: ep93xx: clean-up mach/io.h
  ARM: clps711x: remove unneeded include of mach/io.h
  ARM: make mach/io.h include optional
  ARM: remove bunch of now unused mach/io.h files
  ARM: kill off __mem_pci

 arch/arm/Kconfig                                  |   21 ++++++++
 arch/arm/include/asm/io.h                         |   54 ++++++++++-----------
 arch/arm/include/asm/processor.h                  |    1 +
 arch/arm/mach-at91/at91cap9.c                     |    1 +
 arch/arm/mach-at91/at91cap9_devices.c             |    1 +
 arch/arm/mach-at91/at91rm9200.c                   |    1 +
 arch/arm/mach-at91/at91rm9200_devices.c           |    1 +
 arch/arm/mach-at91/at91rm9200_time.c              |    1 +
 arch/arm/mach-at91/at91sam9260.c                  |    1 +
 arch/arm/mach-at91/at91sam9260_devices.c          |    1 +
 arch/arm/mach-at91/at91sam9261.c                  |    1 +
 arch/arm/mach-at91/at91sam9261_devices.c          |    1 +
 arch/arm/mach-at91/at91sam9263.c                  |    1 +
 arch/arm/mach-at91/at91sam9263_devices.c          |    1 +
 arch/arm/mach-at91/at91sam9g45.c                  |    1 +
 arch/arm/mach-at91/at91sam9g45_devices.c          |    1 +
 arch/arm/mach-at91/at91sam9rl.c                   |    1 +
 arch/arm/mach-at91/at91sam9rl_devices.c           |    1 +
 arch/arm/mach-at91/at91x40.c                      |    1 +
 arch/arm/mach-at91/at91x40_time.c                 |    1 +
 arch/arm/mach-at91/board-cap9adk.c                |    1 +
 arch/arm/mach-at91/board-cpu9krea.c               |    1 +
 arch/arm/mach-at91/board-eco920.c                 |    1 +
 arch/arm/mach-at91/board-yl-9200.c                |    1 +
 arch/arm/mach-at91/clock.c                        |    1 +
 arch/arm/mach-at91/include/mach/at91_io.h         |   44 +++++++++++++++++
 arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h |    2 +
 arch/arm/mach-at91/include/mach/at91sam9_sdramc.h |    2 +
 arch/arm/mach-at91/include/mach/io.h              |   49 -------------------
 arch/arm/mach-at91/include/mach/uncompress.h      |    1 +
 arch/arm/mach-at91/pm.c                           |    1 +
 arch/arm/mach-at91/pm.h                           |    2 +
 arch/arm/mach-at91/setup.c                        |    1 +
 arch/arm/mach-bcmring/include/mach/io.h           |   33 -------------
 arch/arm/mach-clps711x/include/mach/io.h          |   36 --------------
 arch/arm/mach-clps711x/include/mach/uncompress.h  |    1 -
 arch/arm/mach-cns3xxx/include/mach/io.h           |   17 -------
 arch/arm/mach-davinci/include/mach/entry-macro.S  |    1 -
 arch/arm/mach-davinci/include/mach/io.h           |   24 ---------
 arch/arm/mach-dove/include/mach/io.h              |    1 -
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h   |    6 ++
 arch/arm/mach-ep93xx/include/mach/io.h            |   22 --------
 arch/arm/mach-exynos/include/mach/io.h            |   26 ----------
 arch/arm/mach-footbridge/include/mach/io.h        |   13 -----
 arch/arm/mach-gemini/include/mach/io.h            |   18 -------
 arch/arm/mach-h720x/include/mach/io.h             |   22 --------
 arch/arm/mach-highbank/include/mach/io.h          |    7 ---
 arch/arm/mach-imx/mm-imx3.c                       |    4 +-
 arch/arm/mach-integrator/include/mach/io.h        |    1 -
 arch/arm/mach-iop13xx/include/mach/io.h           |    2 -
 arch/arm/mach-iop32x/include/mach/io.h            |    1 -
 arch/arm/mach-iop33x/include/mach/io.h            |    1 -
 arch/arm/mach-ixp2000/include/mach/io.h           |    1 -
 arch/arm/mach-ixp23xx/include/mach/io.h           |    1 -
 arch/arm/mach-ixp4xx/include/mach/io.h            |    6 +--
 arch/arm/mach-kirkwood/include/mach/io.h          |    2 -
 arch/arm/mach-ks8695/include/mach/io.h            |   19 -------
 arch/arm/mach-lpc32xx/include/mach/io.h           |   27 ----------
 arch/arm/mach-mmp/include/mach/io.h               |   21 --------
 arch/arm/mach-msm/board-halibut.c                 |    6 ++
 arch/arm/mach-msm/board-trout.c                   |    6 ++
 arch/arm/mach-msm/include/mach/io.h               |   36 --------------
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h   |    6 ++
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h   |    4 ++
 arch/arm/mach-msm/include/mach/msm_iomap-8960.h   |    4 ++
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h   |    4 ++
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h   |    4 ++
 arch/arm/mach-msm/io.c                            |    1 -
 arch/arm/mach-mv78xx0/include/mach/io.h           |    2 -
 arch/arm/mach-mxs/include/mach/io.h               |   22 --------
 arch/arm/mach-netx/include/mach/io.h              |   28 -----------
 arch/arm/mach-nomadik/include/mach/io.h           |   22 --------
 arch/arm/mach-orion5x/common.h                    |    9 ++++
 arch/arm/mach-orion5x/include/mach/io.h           |   33 -------------
 arch/arm/mach-orion5x/pci.c                       |    1 +
 arch/arm/mach-orion5x/tsx09-common.c              |    1 +
 arch/arm/mach-picoxcell/include/mach/io.h         |   22 --------
 arch/arm/mach-pnx4008/include/mach/io.h           |   21 --------
 arch/arm/mach-prima2/include/mach/io.h            |   16 ------
 arch/arm/mach-pxa/include/mach/io.h               |   20 --------
 arch/arm/mach-realview/include/mach/io.h          |   28 -----------
 arch/arm/mach-rpc/include/mach/io.h               |    5 --
 arch/arm/mach-s3c2410/include/mach/io.h           |    5 --
 arch/arm/mach-s3c64xx/include/mach/io.h           |   18 -------
 arch/arm/mach-s5p64x0/include/mach/io.h           |   25 ----------
 arch/arm/mach-s5pc100/include/mach/io.h           |   18 -------
 arch/arm/mach-s5pv210/include/mach/io.h           |   26 ----------
 arch/arm/mach-sa1100/include/mach/io.h            |   20 --------
 arch/arm/mach-shark/include/mach/io.h             |    2 -
 arch/arm/mach-shmobile/include/mach/io.h          |    9 ----
 arch/arm/mach-spear3xx/include/mach/io.h          |   19 -------
 arch/arm/mach-spear6xx/include/mach/io.h          |   20 --------
 arch/arm/mach-tegra/include/mach/io.h             |   49 -------------------
 arch/arm/mach-tegra/include/mach/iomap.h          |   48 ++++++++++++++++++
 arch/arm/mach-tegra/io.c                          |    1 +
 arch/arm/mach-u300/include/mach/io.h              |   20 --------
 arch/arm/mach-ux500/include/mach/io.h             |   22 --------
 arch/arm/mach-versatile/include/mach/io.h         |   28 -----------
 arch/arm/mach-vexpress/include/mach/io.h          |   26 ----------
 arch/arm/mach-vt8500/include/mach/io.h            |    1 -
 arch/arm/mach-w90x900/include/mach/io.h           |   30 -----------
 arch/arm/mach-zynq/include/mach/io.h              |   33 -------------
 arch/arm/mm/ioremap.c                             |    3 +
 arch/arm/plat-mxc/include/mach/hardware.h         |    3 +
 arch/arm/plat-mxc/include/mach/io.h               |   39 ---------------
 arch/arm/plat-spear/include/plat/io.h             |   22 --------
 drivers/pcmcia/at91_cf.c                          |    1 +
 drivers/rtc/rtc-at91sam9.c                        |    2 +-
 drivers/usb/gadget/at91_udc.c                     |    1 +
 drivers/usb/host/ohci-pxa27x.c                    |    1 +
 drivers/watchdog/at91rm9200_wdt.c                 |    1 +
 drivers/watchdog/at91sam9_wdt.c                   |    1 +
 112 files changed, 237 insertions(+), 1071 deletions(-)
 create mode 100644 arch/arm/mach-at91/include/mach/at91_io.h
 delete mode 100644 arch/arm/mach-at91/include/mach/io.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/io.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/io.h
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/io.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/io.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-exynos/include/mach/io.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/io.h
 delete mode 100644 arch/arm/mach-h720x/include/mach/io.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/io.h
 delete mode 100644 arch/arm/mach-ks8695/include/mach/io.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/io.h
 delete mode 100644 arch/arm/mach-msm/include/mach/io.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/io.h
 delete mode 100644 arch/arm/mach-netx/include/mach/io.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/io.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/io.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/io.h
 delete mode 100644 arch/arm/mach-pnx4008/include/mach/io.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/io.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/io.h
 delete mode 100644 arch/arm/mach-realview/include/mach/io.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/io.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/io.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/io.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/io.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/io.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-u300/include/mach/io.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/io.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/io.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/io.h
 delete mode 100644 arch/arm/mach-w90x900/include/mach/io.h
 delete mode 100644 arch/arm/mach-zynq/include/mach/io.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/io.h
 delete mode 100644 arch/arm/plat-spear/include/plat/io.h

-- 
1.7.5.4
