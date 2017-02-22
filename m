From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Feb 2017 16:28:21 +0000
Subject: [GIT PULL] arm64: updates for 4.11
Message-ID: <20170222162821.GM27510@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

Please pull the following arm64 updates for 4.11. The summary is in the
tag below.

The diffstat strays outside of arch/arm64 in a few places:

  - The core changes required for DEBUG_VIRTUAL (Acked, also merged by rmk)
  - Qualcomm SMCCC quirk (Olof suggested I take this)
  - ACPI/IORT changes (Rafael has asked for arm64 ACPI stuff to go via arm64)
  - Perf/PMU drivers (arm64-specific and maintained by me)

There were a few features that didn't make the pull (kdump, ACPI PMU,
RAS/APEI) but hopefully they'll be ready for 4.12.

Cheers,

Will

--->8

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to ffe7afd1713558d73483834c2e2d03a1e39a4062:

  arm64/kprobes: consistently handle MRS/MSR with XZR (2017-02-15 12:20:29 +0000)

----------------------------------------------------------------
arm64 updates for 4.11:

- Errata workarounds for Qualcomm's Falkor CPU
- Qualcomm L2 Cache PMU driver
- Qualcomm SMCCC firmware quirk
- Support for DEBUG_VIRTUAL
- CPU feature detection for userspace via MRS emulation
- Preliminary work for the Statistical Profiling Extension
- Misc cleanups and non-critical fixes

----------------------------------------------------------------
Andy Gross (2):
      arm: kernel: Add SMC structure parameter
      firmware: qcom: scm: Fix interrupted SCM calls

Ard Biesheuvel (3):
      arm64: kernel: do not mark reserved memory regions as IORESOURCE_BUSY
      efi: arm64: Add vmlinux debug link to the Image binary
      arm64: mm: enable CONFIG_HOLES_IN_ZONE for NUMA

Arnd Bergmann (2):
      arm64: fix warning about swapper_pg_dir overflow
      arm64: include asm/assembler.h in entry-ftrace.S

Catalin Marinas (1):
      arm64: Improve detection of user/non-user mappings in set_pte(_at)

Christopher Covington (3):
      arm64: Use __tlbi() macros in KVM code
      arm64: Work around Falkor erratum 1009
      arm64: Work around Falkor erratum 1003

Dan Carpenter (1):
      ACPI/IORT: Fix the error return code in iort_add_smmu_platform_device()

Ding Tianhong (1):
      arm64: arch_timer: document Hisilicon erratum 161010101

Dmitry Torokhov (1):
      arm64: make use of for_each_node_by_type()

Geert Uytterhoeven (2):
      arm64: Use __pa_symbol for empty_zero_page
      drivers: firmware: psci: Use __pa_symbol for cpu_resume

Geliang Tang (1):
      arm: perf: use builtin_platform_driver

James Morse (1):
      arm64: Remove useless UAO IPI and describe how this gets enabled

Joel Fernandes (1):
      arm64: Don't trace __switch_to if function graph tracer is enabled

Juri Lelli (1):
      arm64: remove wrong CONFIG_PROC_SYSCTL ifdef

Kefeng Wang (1):
      arm64: Kconfig: select COMPAT_BINFMT_ELF only when BINFMT_ELF is set

Laura Abbott (11):
      lib/Kconfig.debug: Add ARCH_HAS_DEBUG_VIRTUAL
      mm/cma: Cleanup highmem check
      mm: Introduce lm_alias
      kexec: Switch to __pa_symbol
      mm/kasan: Switch to using __pa_symbol and lm_alias
      mm/usercopy: Switch to using lm_alias
      drivers: firmware: psci: Use __pa_symbol for kernel symbol
      arm64: Move some macros under #ifndef __ASSEMBLY__
      arm64: Add cast for virt_to_pfn
      arm64: Use __pa_symbol for kernel symbols
      arm64: Add support for CONFIG_DEBUG_VIRTUAL

Lorenzo Pieralisi (1):
      ACPI/IORT: Fix iort_node_get_id() mapping entries indexing

Mark Rutland (15):
      arm64: add missing printk newlines
      arm64: head.S: fix up stale comments
      arm64: cpufeature: treat unknown fields as RES0
      arm64: cpufeature: remove explicit RAZ fields
      arm64: head.S: avoid open-coded adr_l
      arm64: efi-entry.S: avoid open-coded adr_l
      arm64: entry-ftrace.S: avoid open-coded {adr,ldr}_l
      arm64: handle sys and undef traps consistently
      arm64: fix erroneous __raw_read_system_reg() cases
      arm64: ensure __raw_read_system_reg() is self-consistent
      arm64: uaccess: consistently check object sizes
      arm64: ptrace: add XZR-safe regs accessors
      arm64: traps: correctly handle MRS/MSR with XZR
      arm64: cpufeature: correctly handle MRS to XZR
      arm64/kprobes: consistently handle MRS/MSR with XZR

Miles Chen (3):
      arm64: mm: use phys_addr_t instead of unsigned long in __map_memblock
      arm64: use linux/sizes.h for constants
      arm64: use is_vmalloc_addr

Neil Leeder (1):
      perf: add qcom l2 cache perf events driver

Pratyush Anand (1):
      arm64: do not trace atomic operations

Robert Richter (1):
      arm64: errata: Provide macro for major and minor cpu revisions

Robin Murphy (1):
      arm64: dma-mapping: Fix dma_mapping_error() when bypassing SWIOTLB

Shanker Donthineni (1):
      arm64: Define Falkor v1 CPU

Stephen Boyd (1):
      perf: xgene: Include module.h

Sudeep Holla (2):
      of: base: add support to find the level of the last cache
      arm64: cacheinfo: add support to override cache levels via device tree

Suzuki K Poulose (8):
      arm64: cpufeature: Cleanup feature bit tables
      arm64: cpufeature: Document the rules of safe value for features
      arm64: cpufeature: Define helpers for sys_reg id
      arm64: Add helper to decode register from instruction
      arm64: cpufeature: Track user visible fields
      arm64: cpufeature: Expose CPUID registers by emulation
      arm64: Documentation - Expose CPU feature registers
      arm64: Advertise support for Rounding double multiply instructions

Takeshi Kihara (1):
      arm64: Add support for DMA_ATTR_SKIP_CPU_SYNC attribute to swiotlb

Will Deacon (7):
      arm64: cpufeature: allow for version discrepancy in PMU implementations
      arm64: cpufeature: Don't enforce system-wide SPE capability
      Merge branch 'aarch64/for-next/debug-virtual' into aarch64/for-next/core
      arm64: dma-mapping: Only swizzle DMA ops for IOMMU_DOMAIN_DMA
      arm64: KVM: Save/restore the host SPE state when entering/leaving a VM
      ARM: smccc: Update HVC comment to describe new quirk parameter
      arm64: head.S: Enable EL1 (host) access to SPE when entered at EL2

 Documentation/arm64/cpu-feature-registers.txt |  240 ++++++
 Documentation/arm64/silicon-errata.txt        |   47 +-
 Documentation/perf/qcom_l2_pmu.txt            |   38 +
 arch/arm/kernel/armksyms.c                    |    4 +-
 arch/arm/kernel/perf_event_v6.c               |    6 +-
 arch/arm/kernel/perf_event_v7.c               |    6 +-
 arch/arm/kernel/perf_event_xscale.c           |    6 +-
 arch/arm/kernel/smccc-call.S                  |   14 +-
 arch/arm64/Kconfig                            |   35 +-
 arch/arm64/Kconfig.debug                      |    8 +
 arch/arm64/include/asm/assembler.h            |   23 +
 arch/arm64/include/asm/cpucaps.h              |    4 +-
 arch/arm64/include/asm/cpufeature.h           |   26 +-
 arch/arm64/include/asm/cputype.h              |    7 +
 arch/arm64/include/asm/insn.h                 |    2 +
 arch/arm64/include/asm/kvm_arm.h              |    3 +
 arch/arm64/include/asm/kvm_host.h             |    7 +-
 arch/arm64/include/asm/kvm_mmu.h              |    4 +-
 arch/arm64/include/asm/lse.h                  |    2 +-
 arch/arm64/include/asm/memory.h               |   66 +-
 arch/arm64/include/asm/mmu_context.h          |   14 +-
 arch/arm64/include/asm/pgtable.h              |   17 +-
 arch/arm64/include/asm/processor.h            |    1 -
 arch/arm64/include/asm/ptrace.h               |   20 +
 arch/arm64/include/asm/sysreg.h               |   26 +-
 arch/arm64/include/asm/tlbflush.h             |   18 +-
 arch/arm64/include/asm/uaccess.h              |    4 +-
 arch/arm64/include/uapi/asm/hwcap.h           |    2 +
 arch/arm64/kernel/Makefile                    |    4 +
 arch/arm64/kernel/acpi_parking_protocol.c     |    3 +-
 arch/arm64/kernel/arm64ksyms.c                |    4 +-
 arch/arm64/kernel/armv8_deprecated.c          |    2 +-
 arch/arm64/kernel/asm-offsets.c               |    7 +-
 arch/arm64/kernel/cacheinfo.c                 |   13 +-
 arch/arm64/kernel/cpu-reset.h                 |    2 +-
 arch/arm64/kernel/cpu_errata.c                |   33 +-
 arch/arm64/kernel/cpufeature.c                |  426 +++++++----
 arch/arm64/kernel/cpuinfo.c                   |    2 +
 arch/arm64/kernel/efi-entry.S                 |    9 +-
 arch/arm64/kernel/entry-ftrace.S              |   13 +-
 arch/arm64/kernel/head.S                      |   73 +-
 arch/arm64/kernel/hibernate.c                 |   26 +-
 arch/arm64/kernel/insn.c                      |   31 +-
 arch/arm64/kernel/probes/simulate-insn.c      |   18 +-
 arch/arm64/kernel/process.c                   |    6 +-
 arch/arm64/kernel/psci.c                      |    3 +-
 arch/arm64/kernel/setup.c                     |   13 +-
 arch/arm64/kernel/smccc-call.S                |   23 +-
 arch/arm64/kernel/smp.c                       |    4 +-
 arch/arm64/kernel/smp_spin_table.c            |    3 +-
 arch/arm64/kernel/topology.c                  |    2 -
 arch/arm64/kernel/traps.c                     |   13 +-
 arch/arm64/kernel/vdso.c                      |    8 +-
 arch/arm64/kvm/debug.c                        |    6 +
 arch/arm64/kvm/hyp/debug-sr.c                 |   66 +-
 arch/arm64/kvm/hyp/switch.c                   |   17 +-
 arch/arm64/kvm/hyp/tlb.c                      |   13 +-
 arch/arm64/mm/Makefile                        |    2 +
 arch/arm64/mm/context.c                       |   11 +
 arch/arm64/mm/dma-mapping.c                   |   38 +-
 arch/arm64/mm/fault.c                         |   14 -
 arch/arm64/mm/init.c                          |   12 +-
 arch/arm64/mm/ioremap.c                       |    2 +-
 arch/arm64/mm/kasan_init.c                    |   22 +-
 arch/arm64/mm/mmu.c                           |   35 +-
 arch/arm64/mm/physaddr.c                      |   30 +
 arch/arm64/mm/proc.S                          |    1 +
 arch/x86/Kconfig                              |    1 +
 drivers/acpi/arm64/iort.c                     |    8 +-
 drivers/firmware/psci.c                       |    4 +-
 drivers/firmware/qcom_scm-64.c                |   13 +-
 drivers/of/base.c                             |   26 +
 drivers/perf/Kconfig                          |    9 +
 drivers/perf/Makefile                         |    1 +
 drivers/perf/qcom_l2_pmu.c                    | 1013 +++++++++++++++++++++++++
 drivers/perf/xgene_pmu.c                      |    1 +
 include/linux/arm-smccc.h                     |   52 +-
 include/linux/cpuhotplug.h                    |    1 +
 include/linux/mm.h                            |    4 +
 include/linux/of.h                            |    1 +
 kernel/kexec_core.c                           |    2 +-
 lib/Kconfig.debug                             |    5 +-
 mm/cma.c                                      |   15 +-
 mm/kasan/kasan_init.c                         |   15 +-
 mm/usercopy.c                                 |    4 +-
 85 files changed, 2396 insertions(+), 439 deletions(-)
 create mode 100644 Documentation/arm64/cpu-feature-registers.txt
 create mode 100644 Documentation/perf/qcom_l2_pmu.txt
 create mode 100644 arch/arm64/mm/physaddr.c
 create mode 100644 drivers/perf/qcom_l2_pmu.c
