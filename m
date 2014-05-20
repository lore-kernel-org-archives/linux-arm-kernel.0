From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 May 2014 16:45:18 +0800
Subject: [PATCH v2 00/20] ARM: imx: clean up i.MX5 support
Message-ID: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX51 becomes a DT only platform, so a lot of legacy code which are
needed only by non-DT boot can be cleaned up now.  At the end of the
day, all the static mapping and defines are removed except of a couple
which were not defined in device tree in the first place.

Changes since v1:
 - Address review comments from Alexander Shiyan
 - Add more patches for a further cleanup

Shawn Guo (20):
  ARM: imx: move EHCI platform defines out of platform_data header
  ARM: imx5: move SOC_IMX5 and SOC_IMX51 into 'Device tree only'
  ARM: imx5: drop option MACH_IMX51_DT
  ARM: imx5: remove imx51 non-DT support files
  ARM: imx5: remove i.MX5 non-DT device registration helpers
  ARM: imx5: make mx51_clocks_init() a DT call
  ARM: imx5: drop arguments from mx5_clocks_common_init()
  ARM: imx5: tzic_init_irq() can directly be .init_irq hook
  ARM: imx5: remove function imx51_soc_init()
  ARM: imx5: call mxc_timer_init_dt() on imx51
  ARM: imx5: retrieve iim base from device tree
  ARM: imx5: remove header crm-regs-imx5.h
  ARM: imx5: use dynamic mapping for CCM block
  ARM: imx5: use dynamic mapping for DPLL block
  ARM: imx5: reuse clock CCM mapping in pm code
  ARM: imx5: use dynamic mapping for Cortex and GPC block
  ARM: imx5: move init hooks into mach-imx5x.c
  ARM: imx5: remove file mm-imx5.c
  ARM: imx5: clean function declarations in mx51.h
  ARM: imx5: remove mx51.h and mx53.h

 arch/arm/configs/imx_v6_v7_defconfig               |   2 +-
 arch/arm/configs/multi_v7_defconfig                |   2 +-
 arch/arm/mach-imx/Kconfig                          |  25 +-
 arch/arm/mach-imx/Makefile                         |   4 +-
 arch/arm/mach-imx/clk-imx51-imx53.c                | 144 +++-
 arch/arm/mach-imx/common.h                         |  22 +-
 arch/arm/mach-imx/cpu-imx5.c                       |  25 +-
 arch/arm/mach-imx/crm-regs-imx5.h                  | 600 ---------------
 arch/arm/mach-imx/devices-imx51.h                  |  66 --
 arch/arm/mach-imx/devices/platform-fec.c           |  12 -
 arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c  |   5 -
 arch/arm/mach-imx/devices/platform-imx-i2c.c       |  26 -
 arch/arm/mach-imx/devices/platform-imx-keypad.c    |  10 -
 arch/arm/mach-imx/devices/platform-imx-ssi.c       |  20 -
 arch/arm/mach-imx/devices/platform-imx-uart.c      |  22 -
 arch/arm/mach-imx/devices/platform-imx2-wdt.c      |  18 -
 arch/arm/mach-imx/devices/platform-mxc-ehci.c      |   9 -
 arch/arm/mach-imx/devices/platform-mxc_nand.c      |   5 -
 arch/arm/mach-imx/devices/platform-pata_imx.c      |  10 -
 .../mach-imx/devices/platform-sdhci-esdhc-imx.c    |  24 -
 arch/arm/mach-imx/devices/platform-spi_imx.c       |  27 -
 arch/arm/mach-imx/ehci-imx25.c                     |   1 +
 arch/arm/mach-imx/ehci-imx27.c                     |   1 +
 arch/arm/mach-imx/ehci-imx31.c                     |   1 +
 arch/arm/mach-imx/ehci-imx35.c                     |   1 +
 arch/arm/mach-imx/ehci-imx5.c                      | 171 -----
 arch/arm/mach-imx/ehci.h                           |  43 ++
 arch/arm/mach-imx/hardware.h                       |   2 -
 arch/arm/mach-imx/iomux-mx51.h                     | 827 ---------------------
 arch/arm/mach-imx/mach-armadillo5x0.c              |   1 +
 arch/arm/mach-imx/mach-cpuimx27.c                  |   1 +
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c           |   1 +
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |   1 +
 arch/arm/mach-imx/mach-imx50.c                     |   3 +-
 arch/arm/mach-imx/{imx51-dt.c => mach-imx51.c}     |  43 +-
 arch/arm/mach-imx/mach-imx53.c                     |  15 +-
 arch/arm/mach-imx/mach-mx25_3ds.c                  |   1 +
 arch/arm/mach-imx/mach-mx27_3ds.c                  |   1 +
 arch/arm/mach-imx/mach-mx31_3ds.c                  |   1 +
 arch/arm/mach-imx/mach-mx31lilly.c                 |   1 +
 arch/arm/mach-imx/mach-mx31lite.c                  |   1 +
 arch/arm/mach-imx/mach-mx31moboard.c               |   1 +
 arch/arm/mach-imx/mach-mx35_3ds.c                  |   1 +
 arch/arm/mach-imx/mach-pca100.c                    |   1 +
 arch/arm/mach-imx/mach-pcm037.c                    |   1 +
 arch/arm/mach-imx/mach-pcm038.c                    |   1 +
 arch/arm/mach-imx/mach-pcm043.c                    |   1 +
 arch/arm/mach-imx/mach-vpr200.c                    |   1 +
 arch/arm/mach-imx/mm-imx5.c                        | 155 ----
 arch/arm/mach-imx/mx31moboard-devboard.c           |   1 +
 arch/arm/mach-imx/mx31moboard-marxbot.c            |   1 +
 arch/arm/mach-imx/mx31moboard-smartbot.c           |   1 +
 arch/arm/mach-imx/mx51.h                           | 313 --------
 arch/arm/mach-imx/mx53.h                           | 342 ---------
 arch/arm/mach-imx/pm-imx5.c                        |  98 ++-
 arch/arm/mach-imx/tzic.c                           |   9 +-
 include/linux/platform_data/usb-ehci-mxc.h         |  46 --
 57 files changed, 356 insertions(+), 2812 deletions(-)
 delete mode 100644 arch/arm/mach-imx/crm-regs-imx5.h
 delete mode 100644 arch/arm/mach-imx/devices-imx51.h
 delete mode 100644 arch/arm/mach-imx/ehci-imx5.c
 create mode 100644 arch/arm/mach-imx/ehci.h
 delete mode 100644 arch/arm/mach-imx/iomux-mx51.h
 rename arch/arm/mach-imx/{imx51-dt.c => mach-imx51.c} (54%)
 delete mode 100644 arch/arm/mach-imx/mm-imx5.c
 delete mode 100644 arch/arm/mach-imx/mx51.h
 delete mode 100644 arch/arm/mach-imx/mx53.h

-- 
1.8.3.2
