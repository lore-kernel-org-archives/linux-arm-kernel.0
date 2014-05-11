From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 11 May 2014 16:05:56 +0800
Subject: [PATCH v6 00/15] enable HiP04 SoC
Message-ID: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v6:
  * Split HiP04 enabling patch into patches on document, mcpm & hiP04.
  * Move reset operation in HiP04 MCPM implementation.
  * Remove ARCH_MULTI_V7_NONLPAE & ARCH_MULTI_V7_LPAE according to olof's
    comment.

v5:
  * Add ARCH_MULTI_V7_NONLPAE to avoid change too much things in Kconfig.
  * Use memreserve in DTS.
  * Remove L2 reset operation in mcpm implementation.
  * Re-use nr_lr field to cover HIP04 GICH_APR implementation.
  * Add more comments.

v4:
  * Add multi_v7_lpae_defconfig.
  * Select CONFIG_ARCH_MULTI_V7_LPAE if CONFIG_ARCH_MULTI_V7 is selected.
  * Only ARMADA_XP is ARCH_MULTI_V7_LPAE, other ARMADA chips are ARCH_MULTI_V7.
  * Remove gich_lr0 variable since we can calculate offset of GICH_LR0 from
    GICH_APR.
  * Cleanup GIC driver to support HiP04 GIC.
  * Cleanup HiP04 mcpm implementation.

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

Haojian Zhuang (14):
  ARM: debug: add HiP04 debug uart
  irq: gic: use mask field in GICC_IAR
  irq: gic: support hip04 gic
  ARM: mcpm: support 4 clusters
  ARM: hisi: add ARCH_HISI
  ARM: hisi: enable MCPM implementation
  ARM: hisi: enable HiP04
  document: dt: add the binding on HiP04
  document: dt: add the binding on HiP04 clock
  ARM: dts: append hip04 dts
  ARM: config: append lpae configuration
  ARM: config: append hip04_defconfig
  ARM: config: select ARCH_HISI in hi3xxx_defconfig
  virt: arm: support hip04 gic

Kefeng Wang (1):
  ARM: hisi: enable erratum 798181 of A15 on HiP04

 Documentation/devicetree/bindings/arm/gic.txt      |   1 +
 .../bindings/arm/hisilicon/hisilicon.txt           |  21 ++
 .../devicetree/bindings/clock/hip04-clock.txt      |  20 ++
 arch/arm/Kconfig                                   |   9 +
 arch/arm/Kconfig.debug                             |  10 +
 arch/arm/Makefile                                  |   2 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/hip04-d01.dts                    |  39 +++
 arch/arm/boot/dts/hip04.dtsi                       | 260 +++++++++++++++
 arch/arm/configs/hi3xxx_defconfig                  |   2 +
 arch/arm/configs/hip04_defconfig                   |  74 +++++
 arch/arm/configs/multi_v7_lpae_defconfig           | 351 +++++++++++++++++++++
 arch/arm/include/asm/mcpm.h                        |   5 +
 arch/arm/kvm/interrupts_head.S                     |  32 +-
 arch/arm/mach-hisi/Kconfig                         |  27 +-
 arch/arm/mach-hisi/Makefile                        |   1 +
 arch/arm/mach-hisi/core.h                          |   2 +
 arch/arm/mach-hisi/hisilicon.c                     |  12 +
 arch/arm/mach-hisi/platmcpm.c                      | 309 ++++++++++++++++++
 drivers/irqchip/irq-gic.c                          | 162 ++++++++--
 include/kvm/arm_vgic.h                             |   5 +-
 include/linux/irqchip/arm-gic.h                    |   8 +
 virt/kvm/arm/vgic.c                                |  47 ++-
 23 files changed, 1342 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hip04-clock.txt
 create mode 100644 arch/arm/boot/dts/hip04-d01.dts
 create mode 100644 arch/arm/boot/dts/hip04.dtsi
 create mode 100644 arch/arm/configs/hip04_defconfig
 create mode 100644 arch/arm/configs/multi_v7_lpae_defconfig
 create mode 100644 arch/arm/mach-hisi/platmcpm.c

-- 
1.9.1
