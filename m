From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu,  7 Aug 2014 18:51:26 +0800
Subject: [PATCH v17 0/9] enable HiP04 SoC
Message-ID: <1407408695-19626-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v17:
  * Parse bootwrapper parameter from DTS file again.
  * Fix using msleep() in spinlock region.

v16:
  * Create new hip04 interrupt controller driver.
  * Drop both hip04_defconfig & multi_v7_lpae_defconfig. Use hisi_defconfig
    & multi_v7_defconfig instead.
  * Rename hi3xxx_defconfig to hisi_defconfig. Since we need follow the rule of
    each vendor only using one defconfig.
  * Fix parsing memory issue in FDT when 64-bit address is enabled without
    CONFIG_ARM_LPAE.
  * Drop bootwrapper parameters from DTS file. Use command line instead.
  * Declare clock node in DTS file since all these clocks are only fixed rate
    clocks.
  * Drop vgic patch.

v15:
  * Add p04 debug uart back.
  * Refresh since hix5hd2 code updated.

v14:
  * Mount function pointers to different implementation on standard
    GICv2 and Hisilicon HiP04 GIC.

v13:
  * Restore power down operation in MCPM.
  * Fix disabling snoop filter issue in MCPM.

v12:
  * Use wfi as power down state in MCPM.
  * Remove wait_for_powerdown() in MCPM because wfi is used now.

v11:
  * Fix the protection issue on mcpm power down.
  * Clean assembly code in mcpm power up.

v10:
  * Move snoop filter code to be executed on secondary cores. And change
    it to assembly code since MMU isn't enabled at that time.
  * Rebase irq gic patch on latest gic patch.
  * Use global variable in irq gic patch.
  * Use global variable in vgic patch.
  * Drop debug uart patch since it's in another patch set.
  * Remove some ARCHs from multi_v7_lpae_defconfig.

v9:
  * Remove delay workaround in mcpm implementation.
  * Clean in gic.
  * Rename vgic_cpu_nr_lr to vgic_cpu_hw_cfg in vgic driver.
  * Always use high word of vgic_cpu_hw_cfg for GICH_APR offset. So the
    implementation of arm64 is also updated.
  * Drop "irq: gic: use mask field in GICC_IAR" patch since it's merged.

v7:
  * Remove hip04_smp_init_ops().
  * Remove CONFIG_ARCH_HIP04 in hisilicn.c since hip04_smp_init_ops() is
    removed.

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

Haojian Zhuang (9):
  ARM: mcpm: support 4 clusters
  ARM: hisi: enable MCPM implementation
  ARM: hisi: enable HiP04
  document: dt: add the binding on HiP04
  ARM: dts: add hip04 dts
  ARM: config: enable hisilicon hip04
  ARM: debug: add HiP04 debug uart
  irq: enable hip04 irq chip
  of: fdt: fix memory address be truncated

 .../bindings/arm/hisilicon/hisilicon.txt           |  23 ++
 arch/arm/Kconfig                                   |   9 +
 arch/arm/Kconfig.debug                             |  10 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/hip04-d01.dts                    |  32 ++
 arch/arm/boot/dts/hip04.dtsi                       | 267 +++++++++++++
 arch/arm/configs/hi3xxx_defconfig                  |  58 ---
 arch/arm/configs/hisi_defconfig                    |  72 ++++
 arch/arm/configs/multi_v7_defconfig                |   2 +
 arch/arm/include/asm/mcpm.h                        |   5 +
 arch/arm/mach-hisi/Kconfig                         |   9 +
 arch/arm/mach-hisi/Makefile                        |   1 +
 arch/arm/mach-hisi/hisilicon.c                     |   9 +
 arch/arm/mach-hisi/platmcpm.c                      | 362 ++++++++++++++++++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-hip04.c                        | 424 +++++++++++++++++++++
 drivers/of/fdt.c                                   |  10 +
 17 files changed, 1237 insertions(+), 58 deletions(-)
 create mode 100644 arch/arm/boot/dts/hip04-d01.dts
 create mode 100644 arch/arm/boot/dts/hip04.dtsi
 delete mode 100644 arch/arm/configs/hi3xxx_defconfig
 create mode 100644 arch/arm/configs/hisi_defconfig
 create mode 100644 arch/arm/mach-hisi/platmcpm.c
 create mode 100644 drivers/irqchip/irq-hip04.c

-- 
1.9.1
