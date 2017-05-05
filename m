From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 May 2017 17:13:48 +0100
Subject: [GIT PULL] arm64 updates for 4.12
Message-ID: <20170505161345.GA23336@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 updates for 4.12 below. There is a minor conflict
in arch/arm64/include/asm/bug.h, resolved as in current mainline but
with __BUG_FLAGS taking two underscores rather than one:

------------8<---------------------------
diff --cc arch/arm64/include/asm/bug.h
index a9be1072933c,0bfe1df12b19..000000000000
--- a/arch/arm64/include/asm/bug.h
+++ b/arch/arm64/include/asm/bug.h
@@@ -56,7 -60,8 +60,7 @@@ _BUGVERBOSE_LOCATION(__FILE__, __LINE__
  } while (0)
  
- #define __WARN_FLAGS(flags) _BUG_FLAGS(BUGFLAG_WARNING|(flags))
 -#define __WARN_TAINT(taint) 				\
 -	__BUG_FLAGS(BUGFLAG_TAINT(taint))
++#define __WARN_FLAGS(flags) __BUG_FLAGS(BUGFLAG_WARNING|(flags))
  
- #endif /* ! CONFIG_GENERIC_BUG */
+ #define HAVE_ARCH_BUG
  
  #include <asm-generic/bug.h>
------------8<---------------------------

Thanks.

The following changes since commit eeb1efbcb83c0cfe6d567abbacd675bbddf3d658:

  arm64: cpu_errata: Add capability to advertise Cortex-A73 erratum 858921 (2017-04-07 11:22:08 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 92f66f84d9695d07adf9bc987bbcce4bf9b8e87c:

  arm64: Fix the DMA mmap and get_sgtable API with DMA_ATTR_FORCE_CONTIGUOUS (2017-05-05 11:41:35 +0100)

----------------------------------------------------------------
arm64 updates for 4.12:

- kdump support, including two necessary memblock additions:
  memblock_clear_nomap() and memblock_cap_memory_range()

- ARMv8.3 HWCAP bits for JavaScript conversion instructions, complex
  numbers and weaker release consistency

- arm64 ACPI platform MSI support

- arm perf updates: ACPI PMU support, L3 cache PMU in some Qualcomm
  SoCs, Cortex-A53 L2 cache events and DTLB refills, MAINTAINERS update
  for DT perf bindings

- architected timer errata framework (the arch/arm64 changes only)

- support for DMA_ATTR_FORCE_CONTIGUOUS in the arm64 iommu DMA API

- arm64 KVM refactoring to use common system register definitions

- remove support for ASID-tagged VIVT I-cache (no ARMv8 implementation
  using it and deprecated in the architecture) together with some
  I-cache handling clean-up

- PE/COFF EFI header clean-up/hardening

- define BUG() instruction without CONFIG_BUG

----------------------------------------------------------------
AKASHI Takahiro (11):
      memblock: add memblock_clear_nomap()
      memblock: add memblock_cap_memory_range()
      arm64: limit memory regions based on DT property, usable-memory-range
      arm64: kdump: reserve memory for crash dump kernel
      arm64: mm: add set_memory_valid()
      arm64: hibernate: preserve kdump image around hibernation
      arm64: kdump: implement machine_crash_shutdown()
      arm64: kdump: add VMCOREINFO's for user-space tools
      arm64: kdump: provide /proc/vmcore file
      arm64: kdump: enable kdump in defconfig
      Documentation: kdump: describe arm64 port

Agustin Vega-Frias (1):
      perf: qcom: Add L3 cache PMU driver

Ard Biesheuvel (20):
      arm64: Revert "arm64: kaslr: fix breakage with CONFIG_MODVERSIONS=y"
      arm: kvm: move kvm_vgic_global_state out of .text section
      arm64: mmu: move TLB maintenance from callers to create_mapping_late()
      arm64: alternatives: apply boot time fixups via the linear mapping
      arm64: mmu: map .text as read-only from the outset
      arm64: mmu: apply strict permissions to .init.text and .init.data
      arm64/mmu: align alloc_init_pte prototype with pmd/pud versions
      arm64/mmu: ignore debug_pagealloc for kernel segments
      arm64/mmu: add contiguous bit to sanity bug check
      arm64/mmu: replace 'page_mappings_only' parameter with flags argument
      arm64/mm: remove pointless map/unmap sequences when creating page tables
      arm64: mm: set the contiguous bit for kernel mappings where appropriate
      arm64: relocation testing module
      arm64: efi: move EFI header and related data to a separate .S file
      arm64: efi: clean up Image header after PE header has been split off
      arm64: efi: remove forbidden values from the PE/COFF header
      arm64: efi: remove pointless dummy .reloc section
      arm64: efi: replace open coded constants with symbolic ones
      arm64: efi: split Image code and data into separate PE/COFF sections
      arm64: module: split core and init PLT sections

Arnd Bergmann (1):
      arm64: define BUG() instruction without CONFIG_BUG

Catalin Marinas (5):
      Merge tag 'acpi-arm64-for-v4.12' of git://git.kernel.org/.../lpieralisi/linux into for-next/core
      Merge branch 'arm64/common-sysreg' of git://git.kernel.org/.../mark/linux into for-next/core
      Merge tag 'arch-timer-errata-prereq' of git://git.kernel.org/.../maz/arm-platforms into for-next/core
      Merge branch 'will/for-next/perf' into for-next/core
      arm64: Fix the DMA mmap and get_sgtable API with DMA_ATTR_FORCE_CONTIGUOUS

Chris Redmon (1):
      arm64: struct debug_info: Check CONFIG_HAVE_HW_BREAKPOINT

Dave Martin (1):
      arm64: cpufeature: Make ID reg accessor naming less counterintuitive

Florian Fainelli (1):
      arm64: pmu: Wire-up Cortex A53 L2 cache events and DTLB refills

Geert Uytterhoeven (3):
      arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU
      MAINTAINERS: Add file patterns for perf device tree bindings
      arm64: Print DT machine model in setup_machine_fdt()

Hanjun Guo (7):
      ACPI/IORT: Fix the indentation in iort_scan_node()
      ACPI/IORT: Add missing comment for iort_dev_find_its_id()
      ACPI/IORT: Rework iort_match_node_callback() return value handling
      ACPI/IORT: Rename iort_node_map_rid() to make it generic
      ACPI/IORT: Introduce iort_node_map_platform_id() to retrieve dev id
      ACPI: platform-msi: retrieve devid from IORT
      ACPI: platform: setup MSI domain for ACPI based platform device

James Morse (1):
      Documentation: dt: chosen properties for arm64 kdump

Kefeng Wang (1):
      arm64: drop unnecessary newlines in show_regs()

Marc Zyngier (2):
      arm64: Silence spurious kbuild warning on menuconfig
      arm64: Add CNTFRQ_EL0 trap handler

Mark Rutland (29):
      arm64: sysreg: sort by encoding
      arm64: sysreg: add debug system registers
      arm64: sysreg: add performance monitor registers
      arm64: sysreg: subsume GICv3 sysreg definitions
      arm64: sysreg: add physical timer registers
      arm64: sysreg: add register encodings used by KVM
      arm64: sysreg: add Set/Way sys encodings
      arm64: reduce el2_setup branching
      arm64: move !VHE work to end of el2_setup
      drivers/perf: arm_pmu: rework per-cpu allocation
      drivers/perf: arm_pmu: manage interrupts per-cpu
      drivers/perf: arm_pmu: split irq request from enable
      include: pe.h: allow for use in assembly
      include: pe.h: add some missing definitions
      drivers/perf: arm_pmu: remove pointless PMU disabling
      drivers/perf: arm_pmu: define armpmu_init_fn
      drivers/perf: arm_pmu: fold init into alloc
      drivers/perf: arm_pmu: factor out pmu registration
      drivers/perf: arm_pmu: simplify cpu_pmu_request_irqs()
      drivers/perf: arm_pmu: handle no platform_device
      drivers/perf: arm_pmu: rename irq request/free functions
      drivers/perf: arm_pmu: split cpu-local irq request/free
      drivers/perf: arm_pmu: move irq request/free into probe
      drivers/perf: arm_pmu: split out platform device probe logic
      arm64: add function to get a cpu's MADT GICC table
      drivers/perf: arm_pmu: add ACPI framework
      arm64: pmuv3: handle !PMUv3 when probing
      arm64: pmuv3: use arm_pmu ACPI framework
      arm64: pmuv3: handle pmuv3+

Sameer Goel (1):
      efi/libstub/arm*: Set default address and size cells values for an empty dtb

Stephen Boyd (1):
      arm64: print a fault message when attempting to write RO memory

Suzuki K Poulose (3):
      arm64: v8.3: Support for Javascript conversion instruction
      arm64: v8.3: Support for complex number instructions
      arm64: v8.3: Support for weaker release consistency

Takahiro Akashi (1):
      arm64: kdump: protect crash dump kernel memory

Will Deacon (6):
      arm64: cpuinfo: remove I-cache VIPT aliasing detection
      arm64: cacheinfo: Remove CCSIDR-based cache information probing
      arm64: cache: Remove support for ASID-tagged VIVT I-caches
      arm64: cache: Merge cachetype.h into cache.h
      arm64: cache: Identify VPIPT I-caches
      arm64: KVM: Add support for VPIPT I-caches

 Documentation/arm64/cpu-feature-registers.txt |  12 +
 Documentation/devicetree/bindings/chosen.txt  |  45 ++
 Documentation/kdump/kdump.txt                 |  16 +-
 Documentation/perf/qcom_l3_pmu.txt            |  25 +
 MAINTAINERS                                   |   1 +
 arch/arm64/Kconfig                            |  11 +
 arch/arm64/Kconfig.debug                      |   4 +
 arch/arm64/Makefile                           |   4 +-
 arch/arm64/configs/defconfig                  |   1 +
 arch/arm64/include/asm/acpi.h                 |   2 +
 arch/arm64/include/asm/arch_gicv3.h           |  81 +--
 arch/arm64/include/asm/bug.h                  |  33 +-
 arch/arm64/include/asm/cache.h                |  38 +-
 arch/arm64/include/asm/cacheflush.h           |   1 +
 arch/arm64/include/asm/cachetype.h            | 100 ---
 arch/arm64/include/asm/cpufeature.h           |   4 +-
 arch/arm64/include/asm/esr.h                  |   4 +
 arch/arm64/include/asm/hardirq.h              |   2 +-
 arch/arm64/include/asm/hw_breakpoint.h        |   4 +-
 arch/arm64/include/asm/kexec.h                |  52 +-
 arch/arm64/include/asm/kvm_mmu.h              |  13 +-
 arch/arm64/include/asm/mmu.h                  |   1 +
 arch/arm64/include/asm/module.h               |  14 +-
 arch/arm64/include/asm/pgtable.h              |  10 +
 arch/arm64/include/asm/processor.h            |   2 +
 arch/arm64/include/asm/sections.h             |   2 +
 arch/arm64/include/asm/smp.h                  |   3 +
 arch/arm64/include/asm/sysreg.h               | 167 ++++-
 arch/arm64/include/uapi/asm/hwcap.h           |   3 +
 arch/arm64/kernel/Makefile                    |   3 +
 arch/arm64/kernel/alternative.c               |  11 +-
 arch/arm64/kernel/cacheinfo.c                 |  38 --
 arch/arm64/kernel/cpufeature.c                |  30 +-
 arch/arm64/kernel/cpuinfo.c                   |  37 +-
 arch/arm64/kernel/crash_dump.c                |  71 +++
 arch/arm64/kernel/debug-monitors.c            |   2 +-
 arch/arm64/kernel/efi-header.S                | 155 +++++
 arch/arm64/kernel/head.S                      | 222 ++-----
 arch/arm64/kernel/hibernate.c                 |  10 +-
 arch/arm64/kernel/machine_kexec.c             | 170 +++++-
 arch/arm64/kernel/module-plts.c               | 108 ++--
 arch/arm64/kernel/module.c                    |   2 +-
 arch/arm64/kernel/module.lds                  |   1 +
 arch/arm64/kernel/perf_event.c                | 120 +++-
 arch/arm64/kernel/process.c                   |   2 -
 arch/arm64/kernel/reloc_test_core.c           |  81 +++
 arch/arm64/kernel/reloc_test_syms.S           |  83 +++
 arch/arm64/kernel/setup.c                     |  12 +-
 arch/arm64/kernel/smp.c                       |  79 +++
 arch/arm64/kernel/traps.c                     |  14 +
 arch/arm64/kernel/vmlinux.lds.S               |  27 +-
 arch/arm64/kvm/hyp/tlb.c                      |  22 +
 arch/arm64/kvm/reset.c                        |   2 +-
 arch/arm64/kvm/sys_regs.c                     |   4 +-
 arch/arm64/mm/context.c                       |   3 -
 arch/arm64/mm/dma-mapping.c                   | 128 +++-
 arch/arm64/mm/fault.c                         |  55 +-
 arch/arm64/mm/flush.c                         |   4 +-
 arch/arm64/mm/init.c                          | 181 ++++++
 arch/arm64/mm/mmu.c                           | 311 ++++++----
 arch/arm64/mm/pageattr.c                      |  15 +-
 drivers/acpi/arm64/iort.c                     | 158 ++++-
 drivers/acpi/glue.c                           |   6 +
 drivers/firmware/efi/libstub/fdt.c            |  28 +-
 drivers/perf/Kconfig                          |  14 +
 drivers/perf/Makefile                         |   4 +-
 drivers/perf/arm_pmu.c                        | 530 +++++-----------
 drivers/perf/arm_pmu_acpi.c                   | 256 ++++++++
 drivers/perf/arm_pmu_platform.c               | 235 +++++++
 drivers/perf/qcom_l3_pmu.c                    | 849 ++++++++++++++++++++++++++
 include/linux/acpi_iort.h                     |   3 +
 include/linux/cpuhotplug.h                    |   2 +
 include/linux/memblock.h                      |   2 +
 include/linux/pe.h                            | 177 +++---
 include/linux/perf/arm_pmu.h                  |  29 +-
 mm/memblock.c                                 |  56 +-
 virt/kvm/arm/vgic/vgic.c                      |   4 +-
 77 files changed, 3755 insertions(+), 1256 deletions(-)
 create mode 100644 Documentation/perf/qcom_l3_pmu.txt
 delete mode 100644 arch/arm64/include/asm/cachetype.h
 create mode 100644 arch/arm64/kernel/crash_dump.c
 create mode 100644 arch/arm64/kernel/efi-header.S
 create mode 100644 arch/arm64/kernel/reloc_test_core.c
 create mode 100644 arch/arm64/kernel/reloc_test_syms.S
 create mode 100644 drivers/perf/arm_pmu_acpi.c
 create mode 100644 drivers/perf/arm_pmu_platform.c
 create mode 100644 drivers/perf/qcom_l3_pmu.c

-- 
Catalin
