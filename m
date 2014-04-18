From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 18 Apr 2014 14:05:43 +0800
Subject: [PATCH v3 00/13] enable Hisilicon HiP04 SoC
Message-ID: <1397801156-25682-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v3:
  * Replace CONFIG_ARCH_MULTI_V7 by CONFIG_ARCH_MULTI_V7_LPAE in some SoC.
  * Update MCPM code based on Dave's patch.
  * Remove MCPM node in DTS file. Use sysctrl & fabric node instead.
  * Move hardcoding on bootwrapper into DTS file.
  * Append the CONFIG_MCPM_QUAD_CLUSTER for HiP04.
  * Fix the return value from gic_get_cpumask() if it's used in standard gic.
  * Add the vgic support on HiP04 GIC.
  * Add virtualization support in HiP04 defconfig.

v2:
  * Append ARCH_MULTI_V7_LPAE configuration. Define ARCH_MULTI_V7 to only
    support non-LPAE platform.
  * Append document of DT supporting.
  * Append ARCH_HISI in hi3xxx_defconfig.
  * Enable errata 798181 for HiP04 SoC.
  * Add PMU support.

Haojian Zhuang (11):
  ARM: debug: add HiP04 debug uart
  ARM: append ARCH_MULTI_V7_LPAE
  ARM: hisi: add ARCH_HISI
  irq: gic: use mask field in GICC_IAR
  irq: gic: support hip04 gic
  ARM: mcpm: support 4 clusters in HiP04
  ARM: hisi: add hip04 SoC support
  ARM: dts: add hip04-d01 dts file
  ARM: config: append hip04_defconfig
  ARM: config: select ARCH_HISI in hi3xxx_defconfig
  virt: arm: support hip04 gic

Kefeng Wang (2):
  ARM: hisi: enable erratum 798181 of A15 on HiP04
  ARM: dts: Add PMU support in HiP04

 Documentation/devicetree/bindings/arm/gic.txt      |   1 +
 .../bindings/arm/hisilicon/hisilicon.txt           |  10 +
 .../devicetree/bindings/clock/hip04-clock.txt      |  20 ++
 arch/arm/Kconfig                                   |  19 +-
 arch/arm/Kconfig.debug                             |  10 +
 arch/arm/Makefile                                  |   2 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/hip04-d01.dts                    |  74 +++++
 arch/arm/boot/dts/hip04.dtsi                       | 259 ++++++++++++++++
 arch/arm/configs/hi3xxx_defconfig                  |   1 +
 arch/arm/configs/hip04_defconfig                   |  74 +++++
 arch/arm/include/asm/mcpm.h                        |   5 +
 arch/arm/kvm/interrupts_head.S                     |  23 +-
 arch/arm/mach-berlin/Kconfig                       |   2 +-
 arch/arm/mach-highbank/Kconfig                     |   2 +-
 arch/arm/mach-hisi/Kconfig                         |  26 +-
 arch/arm/mach-hisi/Makefile                        |   1 +
 arch/arm/mach-hisi/core.h                          |   2 +
 arch/arm/mach-hisi/hisilicon.c                     |  12 +
 arch/arm/mach-hisi/platmcpm.c                      | 334 +++++++++++++++++++++
 arch/arm/mach-mvebu/Kconfig                        |   6 +-
 arch/arm/mach-omap2/Kconfig                        |   4 +-
 arch/arm/mach-qcom/Kconfig                         |   2 +-
 arch/arm/mach-shmobile/Kconfig                     |   2 +-
 arch/arm/mach-tegra/Kconfig                        |   2 +-
 arch/arm/mach-vexpress/Kconfig                     |   2 +-
 drivers/irqchip/irq-gic.c                          | 155 +++++++---
 include/linux/irqchip/arm-gic.h                    |   5 +
 virt/kvm/arm/vgic.c                                |  10 +-
 29 files changed, 998 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hip04-clock.txt
 create mode 100644 arch/arm/boot/dts/hip04-d01.dts
 create mode 100644 arch/arm/boot/dts/hip04.dtsi
 create mode 100644 arch/arm/configs/hip04_defconfig
 create mode 100644 arch/arm/mach-hisi/platmcpm.c

-- 
1.8.3.2
