From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 Jun 2011 11:33:48 +0800
Subject: [PATCH v2 0/4] Move plat-mxc gpio driver into drivers/gpio
Message-ID: <1306985632-18820-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set moves plat-mxc gpio driver into drivers/gpio, and
migrates mach-imx and mach-mx5 to the new driver.

Changes since v1:
* Eliminate the use of port->id which is not needed yet.
* Move the call to mxc_register_gpio into per-soc-init function.
  As the result, all the board files get touched to plug in this
  hook which will benefit all the possible per-soc setup coming
  in the future.

Shawn Guo (4):
      gpio: gpio-mxc: add gpio driver for Freescale MXC architecture
      ARM: mxc: migrate mach-mx5 gpio driver to gpio-mxc
      ARM: mxc: migrate mach-imx gpio driver to gpio-mxc
      ARM: mxc: remove plat-mxc/gpio driver

 arch/arm/mach-imx/mach-apf9328.c                |    2 +
 arch/arm/mach-imx/mach-armadillo5x0.c           |    2 +
 arch/arm/mach-imx/mach-bug.c                    |    2 +
 arch/arm/mach-imx/mach-cpuimx27.c               |    2 +
 arch/arm/mach-imx/mach-cpuimx35.c               |    2 +
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c        |    2 +
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c     |    2 +
 arch/arm/mach-imx/mach-imx27ipcam.c             |    2 +
 arch/arm/mach-imx/mach-imx27lite.c              |    2 +
 arch/arm/mach-imx/mach-kzm_arm11_01.c           |    2 +
 arch/arm/mach-imx/mach-mx1ads.c                 |    2 +
 arch/arm/mach-imx/mach-mx21ads.c                |    2 +
 arch/arm/mach-imx/mach-mx25_3ds.c               |    2 +
 arch/arm/mach-imx/mach-mx27_3ds.c               |    2 +
 arch/arm/mach-imx/mach-mx27ads.c                |    2 +
 arch/arm/mach-imx/mach-mx31_3ds.c               |    2 +
 arch/arm/mach-imx/mach-mx31ads.c                |    2 +
 arch/arm/mach-imx/mach-mx31lilly.c              |    2 +
 arch/arm/mach-imx/mach-mx31lite.c               |    2 +
 arch/arm/mach-imx/mach-mx31moboard.c            |    2 +
 arch/arm/mach-imx/mach-mx35_3ds.c               |    2 +
 arch/arm/mach-imx/mach-mxt_td60.c               |    2 +
 arch/arm/mach-imx/mach-pca100.c                 |    2 +
 arch/arm/mach-imx/mach-pcm037.c                 |    2 +
 arch/arm/mach-imx/mach-pcm038.c                 |    2 +
 arch/arm/mach-imx/mach-pcm043.c                 |    2 +
 arch/arm/mach-imx/mach-qong.c                   |    2 +
 arch/arm/mach-imx/mach-scb9328.c                |    2 +
 arch/arm/mach-imx/mach-vpr200.c                 |    2 +
 arch/arm/mach-imx/mm-imx1.c                     |   17 +-
 arch/arm/mach-imx/mm-imx21.c                    |   21 +-
 arch/arm/mach-imx/mm-imx25.c                    |   16 +-
 arch/arm/mach-imx/mm-imx27.c                    |   21 +-
 arch/arm/mach-imx/mm-imx31.c                    |   15 +-
 arch/arm/mach-imx/mm-imx35.c                    |   15 +-
 arch/arm/mach-mx5/board-cpuimx51.c              |    2 +
 arch/arm/mach-mx5/board-cpuimx51sd.c            |    2 +
 arch/arm/mach-mx5/board-mx50_rdp.c              |    2 +
 arch/arm/mach-mx5/board-mx51_3ds.c              |    2 +
 arch/arm/mach-mx5/board-mx51_babbage.c          |    2 +
 arch/arm/mach-mx5/board-mx51_efikamx.c          |    2 +
 arch/arm/mach-mx5/board-mx51_efikasb.c          |    2 +
 arch/arm/mach-mx5/board-mx53_evk.c              |    2 +
 arch/arm/mach-mx5/board-mx53_loco.c             |    2 +
 arch/arm/mach-mx5/board-mx53_smd.c              |    2 +
 arch/arm/mach-mx5/devices.c                     |   64 ----
 arch/arm/mach-mx5/mm-mx50.c                     |   21 +-
 arch/arm/mach-mx5/mm.c                          |   25 +-
 arch/arm/plat-mxc/Makefile                      |    2 +-
 arch/arm/plat-mxc/devices.c                     |   11 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-gpio-mxc.c   |   32 ++
 arch/arm/plat-mxc/gpio.c                        |  361 -------------------
 arch/arm/plat-mxc/include/mach/common.h         |   12 +-
 arch/arm/plat-mxc/include/mach/devices-common.h |    2 +
 arch/arm/plat-mxc/include/mach/gpio.h           |   27 --
 drivers/gpio/Makefile                           |    1 +
 drivers/gpio/gpio-mxc.c                         |  433 +++++++++++++++++++++++
 58 files changed, 648 insertions(+), 527 deletions(-)
