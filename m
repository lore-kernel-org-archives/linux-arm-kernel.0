From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  7 Dec 2012 21:06:25 +0000
Subject: [PATCH 0/7] arm64: Initial SoC support (ARMv8 RTSM model)
Message-ID: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support for the ARMv8 RTSM model. It is based on
linux-next (it requires Pawel's patches for vexpress) and does not yet
use GIC (waiting for the GICv2 move from arch/arm to drivers/irqchip to
complete).

The aim is to have minimal or no SoC support at all. On vexpress, because the
clocks must be initialised before populating the AMBA devices, I added an
arch_initcall(). Platforms that rely solely on device driver probing don't
need any platform code.

Still to be done is Documentation/arm64/soc.txt with requirements for SoC
support on AArch64.

Comments welcome. Thanks.


Catalin Marinas (6):
  arm: Move sp810.h to include/linux/amba/
  arm64: Add dtbs target for building all the enabled dtb files
  arm64: SoC infrastructure preparation
  arm64: Populate the platform devices
  arm64: ARMv8 RTSM model (SoC) support
  arm64: Add simple earlyprintk support

Pawel Moll (1):
  arm64: Add dts files for the ARMv8 RTSM model

 Documentation/arm64/memory.txt                     |   2 +
 arch/arm/plat-spear/restart.c                      |   2 +-
 arch/arm64/Kconfig                                 |   7 +-
 arch/arm64/Kconfig.debug                           |   9 +
 arch/arm64/Makefile                                |  20 +-
 arch/arm64/boot/.gitignore                         |   1 +
 arch/arm64/boot/Makefile                           |   8 +-
 arch/arm64/boot/dts/Makefile                       |   1 +
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
 arch/arm64/platforms/Kconfig                       |  11 +
 arch/arm64/platforms/Makefile                      |   1 +
 arch/arm64/platforms/vexpress.c                    |  38 ++++
 drivers/clk/versatile/clk-vexpress.c               |   3 +-
 drivers/net/ethernet/smsc/Kconfig                  |   4 +-
 .../asm/hardware => include/linux/amba}/sp810.h    |   0
 26 files changed, 768 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/boot/dts/Makefile
 create mode 100644 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
 create mode 100644 arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
 create mode 100644 arch/arm64/boot/dts/skeleton.dtsi
 create mode 100644 arch/arm64/configs/vexpress_defconfig
 create mode 100644 arch/arm64/kernel/early_printk.c
 create mode 100644 arch/arm64/platforms/Kconfig
 create mode 100644 arch/arm64/platforms/Makefile
 create mode 100644 arch/arm64/platforms/vexpress.c
 rename {arch/arm/include/asm/hardware => include/linux/amba}/sp810.h (100%)
