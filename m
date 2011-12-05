From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  5 Dec 2011 12:15:42 +0800
Subject: [PATCH 0/6] arm/imx: kill macro MXC_GPIO_IRQ_START
Message-ID: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Sascha,

The imx gpio interrupt controller is currently broken for DT users.
I have sent the following two patches to fix them.

 - arm/imx: fix return type of callback passed to of_irq_init()
   http://www.spinics.net/lists/arm-kernel/msg149891.html

 - arm/imx: fix irq_base for gpio
   http://www.spinics.net/lists/arm-kernel/msg149892.html

Inspired by the patches/discussion from Stephen Warren and Rob Herring,
I decided to send this series to fix the problem in a cleaner way,
which will kill the macro MXC_GPIO_IRQ_START and let the gpio and irq
numbers be dynamically allocated for both DT and non-DT users, rather
than the statically defining currently used in non-DT case.

Please let me know if you would send the series through -rc.  If you
do, that's great.  If you do not, that's fine, since it touches many
files and looks more like a cleanup work, and I will send your the
above quick/temporary fixing for -rc, and then rebase this series on
top of it and send for v3.3.

Regards,
Shawn

Jamie Iles (1):
      irqdomain: export irq_domain_simple_ops for !CONFIG_OF

Shawn Guo (5):
      arm/imx: eliminate macro IMX_GPIO_TO_IRQ()
      arm/imx: eliminate macro IOMUX_TO_IRQ()
      arm/imx: eliminate macro IRQ_GPIOx()
      gpio/mxc: adopt irq_domain in gpio driver
      arm/imx: remove macro MXC_GPIO_IRQ_START

 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    3 +-
 arch/arm/mach-imx/mach-apf9328.c             |    6 ++-
 arch/arm/mach-imx/mach-armadillo5x0.c        |   12 ++++--
 arch/arm/mach-imx/mach-cpuimx27.c            |   12 ++++--
 arch/arm/mach-imx/mach-cpuimx35.c            |    3 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c  |    8 ++--
 arch/arm/mach-imx/mach-imx6q.c               |   12 -----
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
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |    3 +-
 arch/arm/mach-mx5/imx51-dt.c                 |   11 -----
 arch/arm/mach-mx5/imx53-dt.c                 |   11 -----
 arch/arm/mach-mx5/mx51_efika.c               |    3 +-
 arch/arm/plat-mxc/include/mach/hardware.h    |    2 -
 arch/arm/plat-mxc/include/mach/iomux-mx3.h   |    3 -
 arch/arm/plat-mxc/include/mach/iomux-v1.h    |   12 +++---
 arch/arm/plat-mxc/include/mach/irqs.h        |    2 -
 drivers/gpio/Kconfig                         |    1 +
 drivers/gpio/gpio-mxc.c                      |   57 ++++++++++++++------------
 include/linux/irqdomain.h                    |    3 +-
 kernel/irq/irqdomain.c                       |   12 +++--
 41 files changed, 195 insertions(+), 168 deletions(-)
