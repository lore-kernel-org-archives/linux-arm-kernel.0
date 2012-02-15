From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Feb 2012 10:47:41 -0800
Subject: [PATCH v2 0/7] irq_domain for imx tzic and gpio
Message-ID: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
 * Drop the change on generic-irq, which was naked by Rob
 * Separate DT initializtion flow from non-DT for tzic
 * Use legacy domain for non-DT and linear for DT

Shawn Guo (7):
      dt: add empty of_find_compatible_node function
      ARM: imx5: adopt generic_chip irq_domain support for tzic
      ARM: imx: eliminate macro IMX_GPIO_TO_IRQ()
      ARM: imx: eliminate macro IOMUX_TO_IRQ()
      ARM: imx: eliminate macro IRQ_GPIOx()
      gpio/mxc: adopt irq_domain for gpio interrupt support
      ARM: imx: remove macro MXC_GPIO_IRQ_START

 arch/arm/boot/dts/imx51.dtsi                 |    6 +++
 arch/arm/boot/dts/imx53.dtsi                 |    6 +++
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    3 +-
 arch/arm/mach-imx/mach-apf9328.c             |    6 ++-
 arch/arm/mach-imx/mach-armadillo5x0.c        |   12 ++++--
 arch/arm/mach-imx/mach-cpuimx27.c            |   12 ++++--
 arch/arm/mach-imx/mach-cpuimx35.c            |    3 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c  |    8 ++--
 arch/arm/mach-imx/mach-imx6q.c               |   14 ------
 arch/arm/mach-imx/mach-kzm_arm11_01.c        |   20 +++++++--
 arch/arm/mach-imx/mach-mx21ads.c             |    5 +-
 arch/arm/mach-imx/mach-mx27_3ds.c            |    3 +-
 arch/arm/mach-imx/mach-mx27ads.c             |   12 +++---
 arch/arm/mach-imx/mach-mx31_3ds.c            |   13 +++---
 arch/arm/mach-imx/mach-mx31ads.c             |   14 ++++--
 arch/arm/mach-imx/mach-mx31lilly.c           |   10 +++-
 arch/arm/mach-imx/mach-mx31lite.c            |   10 +++-
 arch/arm/mach-imx/mach-mx31moboard.c         |    4 +-
 arch/arm/mach-imx/mach-mxt_td60.c            |    6 +-
 arch/arm/mach-imx/mach-pca100.c              |    4 +-
 arch/arm/mach-imx/mach-pcm037.c              |   18 +++++---
 arch/arm/mach-imx/mach-pcm038.c              |    4 +-
 arch/arm/mach-imx/mach-qong.c                |    9 ++--
 arch/arm/mach-imx/mach-scb9328.c             |    6 ++-
 arch/arm/mach-imx/mach-vpr200.c              |    3 +-
 arch/arm/mach-imx/mx31lilly-db.c             |    5 +-
 arch/arm/mach-imx/mx31lite-db.c              |    5 +-
 arch/arm/mach-imx/pcm970-baseboard.c         |   13 +++---
 arch/arm/mach-mx5/board-cpuimx51.c           |   12 ++++--
 arch/arm/mach-mx5/board-cpuimx51sd.c         |    6 ++-
 arch/arm/mach-mx5/board-mx53_ard.c           |    5 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c          |   47 +++++++++++++++++++--
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |    3 +-
 arch/arm/mach-mx5/imx51-dt.c                 |   30 ++++++-------
 arch/arm/mach-mx5/imx53-dt.c                 |   30 ++++++-------
 arch/arm/mach-mx5/mm.c                       |    6 +-
 arch/arm/mach-mx5/mx51_efika.c               |    3 +-
 arch/arm/plat-mxc/include/mach/common.h      |    3 +-
 arch/arm/plat-mxc/include/mach/hardware.h    |    2 -
 arch/arm/plat-mxc/include/mach/iomux-mx3.h   |    3 -
 arch/arm/plat-mxc/include/mach/iomux-v1.h    |   12 +++---
 arch/arm/plat-mxc/include/mach/irqs.h        |    2 -
 arch/arm/plat-mxc/tzic.c                     |   32 +++++++-------
 drivers/gpio/gpio-mxc.c                      |   59 ++++++++++---------------
 include/linux/of.h                           |    8 ++++
 45 files changed, 287 insertions(+), 210 deletions(-)
