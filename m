From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 13 Mar 2015 11:09:33 -0700
Subject: [PATCH 00/12] Remove mach-msm and associated code
Message-ID: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The maintainers for mach-msm no longer have any plans to support
or test the platforms supported by this architecture[1]. Most likely
there aren't any active users of this code anyway, so let's
delete it and the associated drivers/code. We should probably merge
this as one big series through arm-soc. Although some patches
should be fine to take through maintainers, some things like
mmc and usb have header file dependencies for platform_data.

[1] http://lkml.kernel.org/r/20150307031212.GA8434 at fifo99.com

Stephen Boyd (12):
  ARM: Remove mach-msm and associated ARM architecture code
  gpio: Remove gpio-msm-v1 driver
  tty: serial: Remove orphaned serial driver
  tty: serial: msm_serial: Remove dead code
  net: smc91x: Remove dead code
  mmc: Remove msm_sdcc driver
  clocksource: qcom: Remove dead code
  ehci-msm: Remove dead dependency
  usb: phy: msm: Remove dead code
  phy: qcom-ufs: Switch dependency to ARCH_QCOM
  ufs-qcom: Switch dependency to ARCH_QCOM
  msm: msm_fb: Remove dead code

 Documentation/arm/00-INDEX                      |    2 -
 Documentation/arm/msm/gpiomux.txt               |  176 ---
 MAINTAINERS                                     |   20 +-
 arch/arm/Kconfig                                |   14 -
 arch/arm/Kconfig.debug                          |   31 +-
 arch/arm/Makefile                               |    2 -
 arch/arm/configs/msm_defconfig                  |  121 --
 arch/arm/include/debug/msm.S                    |   14 -
 arch/arm/mach-msm/Kconfig                       |  109 --
 arch/arm/mach-msm/Makefile                      |   23 -
 arch/arm/mach-msm/Makefile.boot                 |    3 -
 arch/arm/mach-msm/board-halibut.c               |  104 --
 arch/arm/mach-msm/board-msm7x30.c               |  191 ---
 arch/arm/mach-msm/board-qsd8x50.c               |  248 ---
 arch/arm/mach-msm/board-sapphire.c              |  114 --
 arch/arm/mach-msm/board-trout-gpio.c            |  233 ---
 arch/arm/mach-msm/board-trout-mmc.c             |  185 ---
 arch/arm/mach-msm/board-trout-panel.c           |  292 ----
 arch/arm/mach-msm/board-trout.c                 |  111 --
 arch/arm/mach-msm/board-trout.h                 |  162 --
 arch/arm/mach-msm/clock-pcom.c                  |  176 ---
 arch/arm/mach-msm/clock-pcom.h                  |  145 --
 arch/arm/mach-msm/clock.c                       |   28 -
 arch/arm/mach-msm/clock.h                       |   43 -
 arch/arm/mach-msm/common.h                      |   41 -
 arch/arm/mach-msm/devices-msm7x00.c             |  480 ------
 arch/arm/mach-msm/devices-msm7x30.c             |  246 ---
 arch/arm/mach-msm/devices-qsd8x50.c             |  388 -----
 arch/arm/mach-msm/devices.h                     |   53 -
 arch/arm/mach-msm/dma.c                         |  298 ----
 arch/arm/mach-msm/gpiomux-8x50.c                |   51 -
 arch/arm/mach-msm/gpiomux-v1.h                  |   67 -
 arch/arm/mach-msm/gpiomux.c                     |  111 --
 arch/arm/mach-msm/gpiomux.h                     |   84 -
 arch/arm/mach-msm/include/mach/clk.h            |   31 -
 arch/arm/mach-msm/include/mach/dma.h            |  151 --
 arch/arm/mach-msm/include/mach/entry-macro.S    |   36 -
 arch/arm/mach-msm/include/mach/hardware.h       |   18 -
 arch/arm/mach-msm/include/mach/irqs-7x00.h      |   75 -
 arch/arm/mach-msm/include/mach/irqs-7x30.h      |  153 --
 arch/arm/mach-msm/include/mach/irqs-8x50.h      |   88 --
 arch/arm/mach-msm/include/mach/irqs.h           |   37 -
 arch/arm/mach-msm/include/mach/msm_gpiomux.h    |   38 -
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |  108 --
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h |  103 --
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |  125 --
 arch/arm/mach-msm/include/mach/msm_iomap.h      |   53 -
 arch/arm/mach-msm/include/mach/msm_smd.h        |  109 --
 arch/arm/mach-msm/include/mach/sirc.h           |   98 --
 arch/arm/mach-msm/include/mach/vreg.h           |   29 -
 arch/arm/mach-msm/io.c                          |  161 --
 arch/arm/mach-msm/irq-vic.c                     |  363 -----
 arch/arm/mach-msm/irq.c                         |  151 --
 arch/arm/mach-msm/last_radio_log.c              |   71 -
 arch/arm/mach-msm/proc_comm.c                   |  129 --
 arch/arm/mach-msm/proc_comm.h                   |  258 ----
 arch/arm/mach-msm/sirc.c                        |  172 ---
 arch/arm/mach-msm/smd.c                         | 1034 -------------
 arch/arm/mach-msm/smd_debug.c                   |  311 ----
 arch/arm/mach-msm/smd_private.h                 |  403 -----
 arch/arm/mach-msm/vreg.c                        |  220 ---
 drivers/clocksource/qcom-timer.c                |   59 -
 drivers/gpio/Kconfig                            |    8 -
 drivers/gpio/Makefile                           |    1 -
 drivers/gpio/gpio-msm-v1.c                      |  714 ---------
 drivers/mmc/host/Kconfig                        |    8 -
 drivers/mmc/host/Makefile                       |    1 -
 drivers/mmc/host/msm_sdcc.c                     | 1474 ------------------
 drivers/mmc/host/msm_sdcc.h                     |  256 ----
 drivers/net/ethernet/smsc/smc91x.h              |   14 -
 drivers/phy/Kconfig                             |    2 +-
 drivers/scsi/ufs/Kconfig                        |    2 +-
 drivers/tty/serial/Kconfig                      |   14 +-
 drivers/tty/serial/Makefile                     |    1 -
 drivers/tty/serial/msm_serial.h                 |    9 -
 drivers/tty/serial/msm_serial_hs.c              | 1874 -----------------------
 drivers/usb/host/Kconfig                        |    2 +-
 drivers/usb/phy/Kconfig                         |    2 +-
 drivers/usb/phy/phy-msm-usb.c                   |   18 +-
 drivers/video/fbdev/Kconfig                     |    7 -
 drivers/video/fbdev/Makefile                    |    1 -
 drivers/video/fbdev/msm/Makefile                |   19 -
 drivers/video/fbdev/msm/mddi.c                  |  821 ----------
 drivers/video/fbdev/msm/mddi_client_dummy.c     |   85 -
 drivers/video/fbdev/msm/mddi_client_nt35399.c   |  252 ---
 drivers/video/fbdev/msm/mddi_client_toshiba.c   |  280 ----
 drivers/video/fbdev/msm/mddi_hw.h               |  305 ----
 drivers/video/fbdev/msm/mdp.c                   |  520 -------
 drivers/video/fbdev/msm/mdp_csc_table.h         |  582 -------
 drivers/video/fbdev/msm/mdp_hw.h                |  627 --------
 drivers/video/fbdev/msm/mdp_ppp.c               |  731 ---------
 drivers/video/fbdev/msm/mdp_scale_tables.c      |  766 ---------
 drivers/video/fbdev/msm/mdp_scale_tables.h      |   38 -
 drivers/video/fbdev/msm/msm_fb.c                |  659 --------
 include/linux/platform_data/mmc-msm_sdcc.h      |   27 -
 include/linux/platform_data/msm_serial_hs.h     |   49 -
 include/linux/platform_data/video-msm_fb.h      |  146 --
 include/linux/usb/msm_hsusb.h                   |    4 -
 98 files changed, 16 insertions(+), 19253 deletions(-)
 delete mode 100644 Documentation/arm/msm/gpiomux.txt
 delete mode 100644 arch/arm/configs/msm_defconfig
 delete mode 100644 arch/arm/mach-msm/Kconfig
 delete mode 100644 arch/arm/mach-msm/Makefile
 delete mode 100644 arch/arm/mach-msm/Makefile.boot
 delete mode 100644 arch/arm/mach-msm/board-halibut.c
 delete mode 100644 arch/arm/mach-msm/board-msm7x30.c
 delete mode 100644 arch/arm/mach-msm/board-qsd8x50.c
 delete mode 100644 arch/arm/mach-msm/board-sapphire.c
 delete mode 100644 arch/arm/mach-msm/board-trout-gpio.c
 delete mode 100644 arch/arm/mach-msm/board-trout-mmc.c
 delete mode 100644 arch/arm/mach-msm/board-trout-panel.c
 delete mode 100644 arch/arm/mach-msm/board-trout.c
 delete mode 100644 arch/arm/mach-msm/board-trout.h
 delete mode 100644 arch/arm/mach-msm/clock-pcom.c
 delete mode 100644 arch/arm/mach-msm/clock-pcom.h
 delete mode 100644 arch/arm/mach-msm/clock.c
 delete mode 100644 arch/arm/mach-msm/clock.h
 delete mode 100644 arch/arm/mach-msm/common.h
 delete mode 100644 arch/arm/mach-msm/devices-msm7x00.c
 delete mode 100644 arch/arm/mach-msm/devices-msm7x30.c
 delete mode 100644 arch/arm/mach-msm/devices-qsd8x50.c
 delete mode 100644 arch/arm/mach-msm/devices.h
 delete mode 100644 arch/arm/mach-msm/dma.c
 delete mode 100644 arch/arm/mach-msm/gpiomux-8x50.c
 delete mode 100644 arch/arm/mach-msm/gpiomux-v1.h
 delete mode 100644 arch/arm/mach-msm/gpiomux.c
 delete mode 100644 arch/arm/mach-msm/gpiomux.h
 delete mode 100644 arch/arm/mach-msm/include/mach/clk.h
 delete mode 100644 arch/arm/mach-msm/include/mach/dma.h
 delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-msm/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-msm/include/mach/irqs-7x00.h
 delete mode 100644 arch/arm/mach-msm/include/mach/irqs-7x30.h
 delete mode 100644 arch/arm/mach-msm/include/mach/irqs-8x50.h
 delete mode 100644 arch/arm/mach-msm/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-msm/include/mach/msm_gpiomux.h
 delete mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
 delete mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h
 delete mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
 delete mode 100644 arch/arm/mach-msm/include/mach/msm_iomap.h
 delete mode 100644 arch/arm/mach-msm/include/mach/msm_smd.h
 delete mode 100644 arch/arm/mach-msm/include/mach/sirc.h
 delete mode 100644 arch/arm/mach-msm/include/mach/vreg.h
 delete mode 100644 arch/arm/mach-msm/io.c
 delete mode 100644 arch/arm/mach-msm/irq-vic.c
 delete mode 100644 arch/arm/mach-msm/irq.c
 delete mode 100644 arch/arm/mach-msm/last_radio_log.c
 delete mode 100644 arch/arm/mach-msm/proc_comm.c
 delete mode 100644 arch/arm/mach-msm/proc_comm.h
 delete mode 100644 arch/arm/mach-msm/sirc.c
 delete mode 100644 arch/arm/mach-msm/smd.c
 delete mode 100644 arch/arm/mach-msm/smd_debug.c
 delete mode 100644 arch/arm/mach-msm/smd_private.h
 delete mode 100644 arch/arm/mach-msm/vreg.c
 delete mode 100644 drivers/gpio/gpio-msm-v1.c
 delete mode 100644 drivers/mmc/host/msm_sdcc.c
 delete mode 100644 drivers/mmc/host/msm_sdcc.h
 delete mode 100644 drivers/tty/serial/msm_serial_hs.c
 delete mode 100644 drivers/video/fbdev/msm/Makefile
 delete mode 100644 drivers/video/fbdev/msm/mddi.c
 delete mode 100644 drivers/video/fbdev/msm/mddi_client_dummy.c
 delete mode 100644 drivers/video/fbdev/msm/mddi_client_nt35399.c
 delete mode 100644 drivers/video/fbdev/msm/mddi_client_toshiba.c
 delete mode 100644 drivers/video/fbdev/msm/mddi_hw.h
 delete mode 100644 drivers/video/fbdev/msm/mdp.c
 delete mode 100644 drivers/video/fbdev/msm/mdp_csc_table.h
 delete mode 100644 drivers/video/fbdev/msm/mdp_hw.h
 delete mode 100644 drivers/video/fbdev/msm/mdp_ppp.c
 delete mode 100644 drivers/video/fbdev/msm/mdp_scale_tables.c
 delete mode 100644 drivers/video/fbdev/msm/mdp_scale_tables.h
 delete mode 100644 drivers/video/fbdev/msm/msm_fb.c
 delete mode 100644 include/linux/platform_data/mmc-msm_sdcc.h
 delete mode 100644 include/linux/platform_data/msm_serial_hs.h
 delete mode 100644 include/linux/platform_data/video-msm_fb.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
