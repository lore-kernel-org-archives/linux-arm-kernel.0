From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 10:31:55 +0530
Subject: [PATCH 00/16] Provide support of generic function for SCU enable
Message-ID: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During consolidation work on Exynos platform for SCU, it has been found
that across many ARM platforms Cortex-A9 boards, SCU enabling code is
duplicated. 

Subsequently it felt that [1] by introducing generic API support in arm/smp_scu.c
file will help in removing all these duplicate work from all such platforms. 
This patch series introduces support for parsting SCU device node to enable SCU
and get SCU base address. If a platform does not support SCU device node in DT, the
API will fallback to scu_a9_get_base to obtain SCU base address.

[1]: https://www.spinics.net/lists/arm-kernel/msg541830.html

Arnd helped in consolidating various ARM platforms duplicating SCU code as below:

a) of_iomap: berlin, exynos, mvebu, realview, rockchip, socfpga, sti, ux500, vexpress
b) ioremap(scu_a9_get_base()): bcm63xx, bcm, hisi, zx
c) iotable_init, scu_a9_get_base(): imx, omap4, tegra, zynq
d) ioremap(constant): shmobile, spear13xx

Based on his suggestion on how to move all these platform to use generic API
I have modified EXYNOS, berlin, realview, socfpga, STi, ux500, vexpress, BCM,
tegra, rockchip, imx, zynq, hisi, mvebu and ZX platform files to adopt generic API for
SCU enabling to obtaining SCU base address.

Only fourth case shmobile and spear13xx will be left to adopt to this new API after this,
which I felt some details information about these platforms and I leave it to the maintainers
of these platforms.

NOTE: This patch series has been tested on EXYNOS platform using Exynos4210 based Origen board
for SMP boot.

Rest platforms are *ONLY* Compiled Tested.

I request maintainers/developers having h/w of these platforms to test this series on their
platforms.

Pankaj Dubey (16):
  ARM: scu: Provide support for parsing SCU device node to enable SCU
  ARM: EXYNOS: use generic API to enable SCU
  ARM: berlin: use generic API for enabling SCU
  ARM: realview: use generic API for enabling SCU
  ARM: socfpga: use generic API for enabling SCU
  ARM: STi: use generic API for enabling SCU
  ARM: ux500: use generic API for enabling SCU
  ARM: vexpress: use generic API for enabling SCU
  ARM: BCM: use generic API for enabling SCU
  ARM: tegra: use generic API for enabling SCU
  ARM: rockchip: use generic API for enabling SCU
  ARM: imx: use generic API for enabling SCU
  ARM: zynq: use generic API for enabling SCU
  ARM: hisi: use generic API for enabling SCU
  ARM: mvebu: use generic API for enabling SCU
  ARM: zx: use generic API for enabling SCU

 arch/arm/include/asm/smp_scu.h      |  4 +++
 arch/arm/kernel/smp_scu.c           | 56 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-bcm/bcm63xx_smp.c     | 18 ++----------
 arch/arm/mach-bcm/platsmp.c         | 46 +-----------------------------
 arch/arm/mach-berlin/platsmp.c      | 17 ++++-------
 arch/arm/mach-exynos/common.h       |  1 -
 arch/arm/mach-exynos/platsmp.c      | 30 +++-----------------
 arch/arm/mach-exynos/pm.c           |  4 +--
 arch/arm/mach-exynos/suspend.c      | 14 +++-------
 arch/arm/mach-hisi/platsmp.c        | 24 ++++------------
 arch/arm/mach-imx/common.h          |  5 ----
 arch/arm/mach-imx/mach-imx6q.c      |  8 +-----
 arch/arm/mach-imx/platsmp.c         | 32 ++++-----------------
 arch/arm/mach-imx/pm-imx6.c         |  3 +-
 arch/arm/mach-mvebu/board-v7.c      |  8 ++----
 arch/arm/mach-realview/platsmp-dt.c | 29 ++++++-------------
 arch/arm/mach-rockchip/platsmp.c    | 12 ++------
 arch/arm/mach-socfpga/platsmp.c     | 11 +-------
 arch/arm/mach-sti/platsmp.c         |  9 +-----
 arch/arm/mach-tegra/platsmp.c       |  2 +-
 arch/arm/mach-ux500/platsmp.c       | 20 +------------
 arch/arm/mach-vexpress/platsmp.c    | 13 +--------
 arch/arm/mach-zx/platsmp.c          |  6 ++--
 arch/arm/mach-zynq/common.c         | 32 +--------------------
 arch/arm/mach-zynq/common.h         |  2 --
 arch/arm/mach-zynq/platsmp.c        |  2 ++
 26 files changed, 115 insertions(+), 293 deletions(-)

-- 
2.7.4
