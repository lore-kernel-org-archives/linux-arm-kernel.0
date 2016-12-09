From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  9 Dec 2016 15:36:24 -0800
Subject: [PATCH v3 0/4] ARM: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <20161208185933.13749-1-f.fainelli@gmail.com>
References: <20161208185933.13749-1-f.fainelli@gmail.com>
Message-ID: <20161209233628.6642-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series builds on top of Laura's [PATCHv5 00/10] CONFIG_DEBUG_VIRTUAL
for arm64 to add support for CONFIG_DEBUG_VIRTUAL for ARM.

This was tested on a Brahma B15 platform (ARMv7 + HIGHMEM + LPAE).

Note that the treewide changes would involve a huge CC list, which
is why it has been purposely trimmed to just focusing on the DEBUG_VIRTUAL
aspect.

Changes in v3:

- fix build failures reported by Kbuild test robot

Changes in v2:

- Modified MTD LART driver not to create symbol conflicts with
  KERNEL_START
- Fixed patch that defines and uses KERNEL_START/END
- Fixed __pa_symbol()'s definition
- Inline __pa_symbol() check wihtin the VIRTUAL_BUG_ON statement
- Simplified check for virtual addresses
- Added a tree-wide patch changing SMP/PM implementations to use
  __pa_symbol(), build tested against multi_v{5,7}_defconfig

Thanks!

Florian Fainelli (4):
  mtd: lart: Rename partition defines to be prefixed with PART_
  ARM: Define KERNEL_START and KERNEL_END
  ARM: Add support for CONFIG_DEBUG_VIRTUAL
  ARM: treewide: Replace uses of virt_to_phys with __pa_symbol

 arch/arm/Kconfig                          |   1 +
 arch/arm/boot/compressed/piggy.xzkern     | Bin 0 -> 2998584 bytes
 arch/arm/common/mcpm_entry.c              |  12 +++----
 arch/arm/include/asm/memory.h             |  23 ++++++++++++--
 arch/arm/mach-alpine/platsmp.c            |   2 +-
 arch/arm/mach-axxia/platsmp.c             |   2 +-
 arch/arm/mach-bcm/bcm63xx_smp.c           |   2 +-
 arch/arm/mach-bcm/platsmp-brcmstb.c       |   2 +-
 arch/arm/mach-bcm/platsmp.c               |   4 +--
 arch/arm/mach-berlin/platsmp.c            |   2 +-
 arch/arm/mach-exynos/firmware.c           |   4 +--
 arch/arm/mach-exynos/mcpm-exynos.c        |   2 +-
 arch/arm/mach-exynos/platsmp.c            |   4 +--
 arch/arm/mach-exynos/pm.c                 |   6 ++--
 arch/arm/mach-exynos/suspend.c            |   6 ++--
 arch/arm/mach-hisi/platmcpm.c             |   2 +-
 arch/arm/mach-hisi/platsmp.c              |   6 ++--
 arch/arm/mach-imx/platsmp.c               |   2 +-
 arch/arm/mach-imx/pm-imx6.c               |   2 +-
 arch/arm/mach-imx/src.c                   |   2 +-
 arch/arm/mach-mediatek/platsmp.c          |   2 +-
 arch/arm/mach-mvebu/pm.c                  |   2 +-
 arch/arm/mach-mvebu/pmsu.c                |   2 +-
 arch/arm/mach-mvebu/system-controller.c   |   2 +-
 arch/arm/mach-omap2/control.c             |   8 ++---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   8 ++---
 arch/arm/mach-omap2/omap-smp.c            |   4 +--
 arch/arm/mach-prima2/platsmp.c            |   2 +-
 arch/arm/mach-prima2/pm.c                 |   2 +-
 arch/arm/mach-pxa/palmz72.c               |   2 +-
 arch/arm/mach-pxa/pxa25x.c                |   2 +-
 arch/arm/mach-pxa/pxa27x.c                |   2 +-
 arch/arm/mach-pxa/pxa3xx.c                |   2 +-
 arch/arm/mach-realview/platsmp-dt.c       |   2 +-
 arch/arm/mach-rockchip/platsmp.c          |   4 +--
 arch/arm/mach-rockchip/pm.c               |   2 +-
 arch/arm/mach-s3c24xx/mach-jive.c         |   2 +-
 arch/arm/mach-s3c24xx/pm-s3c2410.c        |   2 +-
 arch/arm/mach-s3c24xx/pm-s3c2416.c        |   2 +-
 arch/arm/mach-s3c64xx/pm.c                |   2 +-
 arch/arm/mach-s5pv210/pm.c                |   2 +-
 arch/arm/mach-sa1100/pm.c                 |   2 +-
 arch/arm/mach-shmobile/platsmp-apmu.c     |   6 ++--
 arch/arm/mach-shmobile/platsmp-scu.c      |   4 +--
 arch/arm/mach-socfpga/platsmp.c           |   4 +--
 arch/arm/mach-spear/platsmp.c             |   2 +-
 arch/arm/mach-sti/platsmp.c               |   2 +-
 arch/arm/mach-sunxi/platsmp.c             |   4 +--
 arch/arm/mach-tango/platsmp.c             |   2 +-
 arch/arm/mach-tango/pm.c                  |   2 +-
 arch/arm/mach-tegra/reset.c               |   4 +--
 arch/arm/mach-ux500/platsmp.c             |   2 +-
 arch/arm/mach-vexpress/dcscb.c            |   2 +-
 arch/arm/mach-vexpress/platsmp.c          |   2 +-
 arch/arm/mach-vexpress/tc2_pm.c           |   4 +--
 arch/arm/mach-zx/platsmp.c                |   4 +--
 arch/arm/mach-zynq/platsmp.c              |   2 +-
 arch/arm/mm/Makefile                      |   1 +
 arch/arm/mm/init.c                        |   7 ++--
 arch/arm/mm/mmu.c                         |   6 +---
 arch/arm/mm/physaddr.c                    |  51 ++++++++++++++++++++++++++++++
 drivers/mtd/devices/lart.c                |  24 +++++++-------
 62 files changed, 173 insertions(+), 108 deletions(-)
 create mode 100644 arch/arm/boot/compressed/piggy.xzkern
 create mode 100644 arch/arm/mm/physaddr.c

-- 
2.9.3
