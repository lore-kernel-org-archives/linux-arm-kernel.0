From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 8 Jun 2018 17:40:08 +0100
Subject: [GIT PULL] arm64 patches for 4.18
Message-ID: <20180608164006.u3l334mc7plw4yei@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 updates for 4.18 below. Apart from the core arm64
and perf changes, the Spectre v4 mitigation touches the arm KVM code and
the ACPI PPTT support touches drivers/ (acpi and cacheinfo). I should
have the maintainers' acks in place.

Thanks.


The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 0fe42512b2f03f9e5a20b9f55ef1013a68b4cd48:

  arm64: Fix syscall restarting around signal suppressed by tracer (2018-06-08 13:21:39 +0100)

----------------------------------------------------------------
arm64 updates for 4.18:

- Spectre v4 mitigation (Speculative Store Bypass Disable) support for
  arm64 using SMC firmware call to set a hardware chicken bit

- ACPI PPTT (Processor Properties Topology Table) parsing support and
  enable the feature for arm64

- Report signal frame size to user via auxv (AT_MINSIGSTKSZ). The
  primary motivation is Scalable Vector Extensions which requires more
  space on the signal frame than the currently defined MINSIGSTKSZ

- ARM perf patches: allow building arm-cci as module, demote dev_warn()
  to dev_dbg() in arm-ccn event_init(), miscellaneous cleanups

- cmpwait() WFE optimisation to avoid some spurious wakeups

- L1_CACHE_BYTES reverted back to 64 (for performance reasons that have
  to do with some network allocations) while keeping ARCH_DMA_MINALIGN
  to 128. cache_line_size() returns the actual hardware Cache Writeback
  Granule

- Turn LSE atomics on by default in Kconfig

- Kernel fault reporting tidying

- Some #include and miscellaneous cleanups

----------------------------------------------------------------
Arnd Bergmann (3):
      drivers/bus: arm-cci: fix build warnings
      ARM: mcpm, perf/arm-cci: export mcpm_is_available
      arm64: cpu_errata: include required headers

Catalin Marinas (4):
      Revert "arm64: Increase the max granular size"
      arm64: Increase ARCH_DMA_MINALIGN to 128
      Merge branch 'for-next/perf' of git://git.kernel.org/.../will/linux
      arm64: KVM: Move VCPU_WORKAROUND_2_FLAG macros to the top of the file

Dave Martin (4):
      arm64/sve: Write ZCR_EL1 on context switch only if changed
      arm64/sve: Thin out initialisation sanity-checks for sve_max_vl
      arm64: signal: Report signal frame size to userspace via auxv
      arm64: Fix syscall restarting around signal suppressed by tracer

Jeremy Linton (13):
      drivers: base: cacheinfo: move cache_setup_of_node()
      drivers: base: cacheinfo: setup DT cache properties early
      cacheinfo: rename of_node to fw_token
      arm64/acpi: Create arch specific cpu to acpi id helper
      ACPI/PPTT: Add Processor Properties Topology Table parsing
      ACPI: Enable PPTT support on ARM64
      drivers: base cacheinfo: Add support for ACPI based firmware tables
      arm64: Add support for ACPI based firmware tables
      arm64: topology: rename cluster_id
      arm64: topology: enable ACPI/PPTT based CPU topology
      ACPI: Add PPTT to injectable table list
      arm64: topology: divorce MC scheduling domain from core_siblings
      arm64: topology: Avoid checking numa mask for scheduler MC selection

John Garry (1):
      drivers/perf: Remove ARM_SPE_PMU explicit PERF_EVENTS dependency

Marc Zyngier (14):
      arm/arm64: smccc: Add SMCCC-specific return codes
      arm64: Call ARCH_WORKAROUND_2 on transitions between EL0 and EL1
      arm64: Add per-cpu infrastructure to call ARCH_WORKAROUND_2
      arm64: Add ARCH_WORKAROUND_2 probing
      arm64: Add 'ssbd' command-line option
      arm64: ssbd: Add global mitigation state accessor
      arm64: ssbd: Skip apply_ssbd if not using dynamic mitigation
      arm64: ssbd: Restore mitigation status on CPU resume
      arm64: ssbd: Introduce thread flag to control userspace mitigation
      arm64: ssbd: Add prctl interface for per-thread mitigation
      arm64: KVM: Add HYP per-cpu accessors
      arm64: KVM: Add ARCH_WORKAROUND_2 support for guests
      arm64: KVM: Handle guest's ARCH_WORKAROUND_2 requests
      arm64: KVM: Add ARCH_WORKAROUND_2 discovery through ARCH_FEATURES_FUNC_ID

Mark Rutland (4):
      arm_pmu: simplify arm_pmu::handle_irq
      drivers/perf: arm-ccn: don't log to dmesg in event_init
      arm64: make is_permission_fault() name clearer
      arm64: Unify kernel fault reporting

Masahiro Yamada (1):
      arm64: remove no-op macro VMLINUX_SYMBOL()

Robin Murphy (5):
      arm64: Select ARCH_HAS_FAST_MULTIPLIER
      perf/arm-cci: Remove unnecessary period adjustment
      perf/arm-cc*: Fix MODULE_LICENSE() tags
      perf/arm-cci: Remove pointless PMU disabling
      perf/arm-cci: Allow building as a module

Sudeep Holla (1):
      ACPI / PPTT: fix build when CONFIG_ACPI_PPTT is not enabled

Vincenzo Frascino (1):
      arm64: Remove duplicate include

Will Deacon (2):
      arm64: cmpwait: Clear event register before arming exclusive monitor
      arm64: Kconfig: Enable LSE atomics by default

Wolfram Sang (1):
      perf: simplify getting .drvdata

 Documentation/admin-guide/kernel-parameters.txt |  17 +
 arch/arm/common/mcpm_entry.c                    |   2 +
 arch/arm/include/asm/kvm_host.h                 |  12 +
 arch/arm/include/asm/kvm_mmu.h                  |   5 +
 arch/arm/kernel/perf_event_v6.c                 |   4 +-
 arch/arm/kernel/perf_event_v7.c                 |   3 +-
 arch/arm/kernel/perf_event_xscale.c             |   6 +-
 arch/arm64/Kconfig                              |  15 +-
 arch/arm64/include/asm/acpi.h                   |   4 +
 arch/arm64/include/asm/cache.h                  |   6 +-
 arch/arm64/include/asm/cmpxchg.h                |   4 +-
 arch/arm64/include/asm/cpucaps.h                |   3 +-
 arch/arm64/include/asm/cpufeature.h             |  22 +
 arch/arm64/include/asm/elf.h                    |  13 +
 arch/arm64/include/asm/fpsimdmacros.h           |  12 +-
 arch/arm64/include/asm/kvm_asm.h                |  30 +-
 arch/arm64/include/asm/kvm_host.h               |  26 +
 arch/arm64/include/asm/kvm_mmu.h                |  25 +-
 arch/arm64/include/asm/processor.h              |   5 +
 arch/arm64/include/asm/thread_info.h            |   1 +
 arch/arm64/include/asm/topology.h               |   6 +-
 arch/arm64/include/uapi/asm/auxvec.h            |   3 +-
 arch/arm64/kernel/Makefile                      |   1 +
 arch/arm64/kernel/armv8_deprecated.c            |   3 +-
 arch/arm64/kernel/asm-offsets.c                 |   1 +
 arch/arm64/kernel/cacheinfo.c                   |  15 +-
 arch/arm64/kernel/cpu_errata.c                  | 182 +++++++
 arch/arm64/kernel/cpufeature.c                  |  10 +-
 arch/arm64/kernel/entry-fpsimd.S                |   2 +-
 arch/arm64/kernel/entry.S                       |  30 ++
 arch/arm64/kernel/fpsimd.c                      |  18 +-
 arch/arm64/kernel/hibernate.c                   |  11 +
 arch/arm64/kernel/perf_event.c                  |   3 +-
 arch/arm64/kernel/ptrace.c                      |   5 -
 arch/arm64/kernel/signal.c                      |  57 ++-
 arch/arm64/kernel/ssbd.c                        | 110 ++++
 arch/arm64/kernel/suspend.c                     |   8 +
 arch/arm64/kernel/topology.c                    | 104 +++-
 arch/arm64/kernel/vmlinux.lds.S                 |  20 +-
 arch/arm64/kvm/hyp/hyp-entry.S                  |  38 +-
 arch/arm64/kvm/hyp/switch.c                     |  42 ++
 arch/arm64/kvm/reset.c                          |   4 +
 arch/arm64/mm/dma-mapping.c                     |   5 +
 arch/arm64/mm/fault.c                           |  46 +-
 arch/riscv/kernel/cacheinfo.c                   |   1 -
 drivers/acpi/Kconfig                            |   3 +
 drivers/acpi/Makefile                           |   1 +
 drivers/acpi/pptt.c                             | 655 ++++++++++++++++++++++++
 drivers/acpi/tables.c                           |   2 +-
 drivers/base/cacheinfo.c                        | 157 +++---
 drivers/perf/Kconfig                            |  36 +-
 drivers/perf/arm-cci.c                          |  47 +-
 drivers/perf/arm-ccn.c                          |  22 +-
 drivers/perf/arm_pmu.c                          |   2 +-
 drivers/perf/arm_spe_pmu.c                      |   6 +-
 include/linux/acpi.h                            |  19 +
 include/linux/arm-smccc.h                       |  10 +
 include/linux/cacheinfo.h                       |  25 +-
 include/linux/perf/arm_pmu.h                    |   2 +-
 virt/kvm/arm/arm.c                              |   4 +
 virt/kvm/arm/psci.c                             |  18 +-
 61 files changed, 1689 insertions(+), 260 deletions(-)
 create mode 100644 arch/arm64/kernel/ssbd.c
 create mode 100644 drivers/acpi/pptt.c

-- 
Catalin
