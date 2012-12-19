From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Dec 2012 17:54:39 +0000
Subject: [PATCH v2 0/7] arm64: ARMv8 RTSM model SoC support
Message-ID: <1355939686-23728-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Following feedback from Arnd, I moved the vexpress clocks initialisation
in clk-vexpress.c and removed the arch/arm64/platorms directory
entirely. We still have an ARCH_VEXPRESS Kconfig entry since the related
code under drivers/ requires it but otherwise the SoC support is much
simplified.

The 2nd patch is trickier as it relies on the clocks order in the DT
(more comments in the patch log)


Catalin Marinas (6):
  arm: Move sp810.h to include/linux/amba/
  vexpress: Match the "arm,sp810" DT entry for clock initialisation
  arm64: Always select ARM_AMBA and GENERIC_GPIO
  arm64: Populate the platform devices
  arm64: Enable ARMv8 RTSM model (SoC) support
  arm64: Add simple earlyprintk support

Pawel Moll (1):
  arm64: Add dts files for the ARMv8 RTSM model

 Documentation/arm64/memory.txt                     |   2 +
 arch/arm/plat-spear/restart.c                      |   2 +-
 arch/arm64/Kconfig                                 |  16 +-
 arch/arm64/Kconfig.debug                           |   9 +
 arch/arm64/boot/dts/Makefile                       |   2 +
 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts             | 154 ++++++++++++++
 arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi       | 234 +++++++++++++++++++++
 arch/arm64/boot/dts/skeleton.dtsi                  |  13 ++
 arch/arm64/configs/vexpress_defconfig              |  90 ++++++++
 arch/arm64/include/asm/io.h                        |   3 +
 arch/arm64/include/asm/memory.h                    |   1 +
 arch/arm64/include/asm/mmu.h                       |   1 +
 arch/arm64/kernel/Makefile                         |   1 +
 arch/arm64/kernel/early_printk.c                   | 118 +++++++++++
 arch/arm64/kernel/head.S                           |  12 +-
 arch/arm64/kernel/setup.c                          |   8 +
 arch/arm64/mm/mmu.c                                |  42 ++++
 drivers/clk/versatile/clk-vexpress.c               |  31 +--
 drivers/net/ethernet/smsc/Kconfig                  |   4 +-
 .../asm/hardware => include/linux/amba}/sp810.h    |   0
 include/linux/vexpress.h                           |   2 +-
 21 files changed, 725 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
 create mode 100644 arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
 create mode 100644 arch/arm64/boot/dts/skeleton.dtsi
 create mode 100644 arch/arm64/configs/vexpress_defconfig
 create mode 100644 arch/arm64/kernel/early_printk.c
 rename {arch/arm/include/asm/hardware => include/linux/amba}/sp810.h (100%)
