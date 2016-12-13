From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 13 Dec 2016 19:21:59 +0000
Subject: [GIT PULL] arm64 updates for 4.10
Message-ID: <20161213192156.GA12471@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 updates for 4.10 below.

The patches touch the generic include/linux/thread_info.h to factor out
struct restart_block into a separate include/linux/restart_block.h file
(needed for arm64 moving thread_info off stack; acked by Andy
Lutomirski).

There is also a small refactoring touching drivers/irqchip/irq-gic-v3.c
and additional watchpoint lengths added to
include/uapi/linux/hw_breakpoint.h.

Thanks.


The following changes since commit bc33b0ca11e3df467777a4fa7639ba488c9d4911:

  Linux 4.9-rc4 (2016-11-05 16:23:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 75037120e62b58c536999eb23d70cfcb6d6c0bcc:

  arm64: Disable PAN on uaccess_enable() (2016-12-12 17:52:27 +0000)

----------------------------------------------------------------
arm64 updates for 4.10:

- struct thread_info moved off-stack (also touching
  include/linux/thread_info.h and include/linux/restart_block.h)

- cpus_have_cap() reworked to avoid __builtin_constant_p() for static
  key use (also touching drivers/irqchip/irq-gic-v3.c)

- Uprobes support (currently only for native 64-bit tasks)

- Emulation of kernel Privileged Access Never (PAN) using TTBR0_EL1
  switching to a reserved page table

- CPU capacity information passing via DT or sysfs (used by the
  scheduler)

- Support for systems without FP/SIMD (IOW, kernel avoids touching these
  registers; there is no soft-float ABI, nor kernel emulation for
  AArch64 FP/SIMD)

- Handling of hardware watchpoint with unaligned addresses, varied
  lengths and offsets from base

- Use of the page table contiguous hint for kernel mappings

- Hugetlb fixes for sizes involving the contiguous hint

- Remove unnecessary I-cache invalidation in flush_cache_range()

- CNTHCTL_EL2 access fix for CPUs with VHE support (ARMv8.1)

- Boot-time checks for writable+executable kernel mappings

- Simplify asm/opcodes.h and avoid including the 32-bit ARM counterpart
  and make the arm64 kernel headers self-consistent (Xen headers patch
  merged separately)

- Workaround for broken .inst support in certain binutils versions

----------------------------------------------------------------
Ard Biesheuvel (3):
      arm64: mm: BUG on unsupported manipulations of live kernel mappings
      arm64: mm: replace 'block_mappings_allowed' with 'page_mappings_only'
      arm64: mm: set the contiguous bit for kernel mappings where appropriate

Catalin Marinas (12):
      arm64: Fix typo in add_default_hugepagesz() for 64K pages
      arm64: Update the synchronous external abort fault description
      arm64: Factor out PAN enabling/disabling into separate uaccess_* macros
      arm64: Factor out TTBR0_EL1 post-update workaround into a specific asm macro
      arm64: Introduce uaccess_{disable,enable} functionality based on TTBR0_EL1
      arm64: Disable TTBR0_EL1 during normal kernel execution
      arm64: Handle faults caused by inadvertent user access with PAN enabled
      arm64: xen: Enable user access before a privcmd hvc call
      arm64: Enable CONFIG_ARM64_SW_TTBR0_PAN
      arm64: Enable HIBERNATION in defconfig
      arm64: Remove I-cache invalidation from flush_cache_range()
      Merge Will Deacon's for-next/perf branch into for-next/core

Huang Shijie (2):
      arm64: hugetlb: remove the wrong pmd check in find_num_contig()
      arm64: hugetlb: fix the wrong address for several functions

Jintack (1):
      arm64: head.S: Fix CNTHCTL_EL2 access on VHE system

Juri Lelli (3):
      Documentation: arm: define DT cpu capacity-dmips-mhz bindings
      arm64: parse cpu capacity-dmips-mhz from DT
      arm64: add sysfs cpu_capacity attribute

Laura Abbott (4):
      arm64: dump: Make ptdump debugfs a separate option
      arm64: dump: Make the page table dumping seq_file optional
      arm64: dump: Remove max_addr
      arm64: dump: Add checking for writable and exectuable pages

Marc Zyngier (5):
      arm64: Get rid of asm/opcodes.h
      arm64: Remove reference to asm/opcodes.h
      arm64: Add detection code for broken .inst support in binutils
      arm64: Work around broken .inst when defective gas is detected
      arm64: Disable PAN on uaccess_enable()

Mark Rutland (14):
      arm64: percpu: kill off final ACCESS_ONCE() uses
      thread_info: factor out restart_block
      thread_info: include <current.h> for THREAD_INFO_IN_TASK
      arm64: thread_info remove stale items
      arm64: asm-offsets: remove unused definitions
      arm64: factor out current_stack_pointer
      arm64: traps: simplify die() and __die()
      arm64: unexport walk_stackframe
      arm64: prep stack walkers for THREAD_INFO_IN_TASK
      arm64: move sp_el0 and tpidr_el1 into cpu_suspend_ctx
      arm64: smp: prepare for smp_processor_id() rework
      arm64: make cpu number a percpu variable
      arm64: assembler: introduce ldr_this_cpu
      arm64: split thread_info from task stack

Pavel Labath (1):
      arm64: hw_breakpoint: Handle inexact watchpoint addresses

Pratyush Anand (11):
      arm64: kprobe: protect/rename few definitions to be reused by uprobe
      arm64: kgdb_step_brk_fn: ignore other's exception
      arm64: Handle TRAP_TRACE for user mode as well
      arm64: Handle TRAP_BRKPT for user mode as well
      arm64: introduce mm context flag to keep 32 bit task information
      arm64: Add uprobe support
      arm64: fix error: conflicting types for 'kprobe_fault_handler'
      hw_breakpoint: Allow watchpoint of length 3,5,6 and 7
      arm64: Allow hw watchpoint at varied offset from base address
      arm64: Allow hw watchpoint of length 3,5,6 and 7
      selftests: arm64: add test for unaligned/inexact watchpoint handling

Robin Murphy (3):
      arm64/kprobes: Tidy up sign-extension usage
      arm64: Remove pointless WARN_ON in DMA teardown
      arm64: smp: Prevent raw_smp_processor_id() recursion

Suzuki K Poulose (2):
      arm64: Add hypervisor safe helper for checking constant capabilities
      arm64: Support systems without FP/ASIMD

 .../devicetree/bindings/arm/cpu-capacity.txt       | 236 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/cpus.txt     |  10 +
 arch/arm64/Kconfig                                 |  12 ++
 arch/arm64/Kconfig.debug                           |  35 ++-
 arch/arm64/Makefile                                |  10 +-
 arch/arm64/configs/defconfig                       |   1 +
 arch/arm64/include/asm/Kbuild                      |   1 -
 arch/arm64/include/asm/assembler.h                 |  48 ++++-
 arch/arm64/include/asm/cacheflush.h                |   7 +-
 arch/arm64/include/asm/cpufeature.h                |  37 +++-
 arch/arm64/include/asm/current.h                   |  22 ++
 arch/arm64/include/asm/debug-monitors.h            |   3 +
 arch/arm64/include/asm/efi.h                       |  26 ++-
 arch/arm64/include/asm/elf.h                       |  12 +-
 arch/arm64/include/asm/futex.h                     |  17 +-
 arch/arm64/include/asm/hw_breakpoint.h             |   6 +-
 arch/arm64/include/asm/kernel-pgtable.h            |   7 +
 arch/arm64/include/asm/mmu.h                       |   3 +-
 arch/arm64/include/asm/mmu_context.h               |  53 +++--
 arch/arm64/include/asm/neon.h                      |   3 +-
 arch/arm64/include/asm/opcodes.h                   |   5 -
 arch/arm64/include/asm/percpu.h                    |  18 +-
 arch/arm64/include/asm/perf_event.h                |   2 +
 arch/arm64/include/asm/probes.h                    |  21 +-
 arch/arm64/include/asm/ptdump.h                    |  22 +-
 arch/arm64/include/asm/ptrace.h                    |   8 +
 arch/arm64/include/asm/smp.h                       |  14 +-
 arch/arm64/include/asm/stack_pointer.h             |   9 +
 arch/arm64/include/asm/suspend.h                   |   2 +-
 arch/arm64/include/asm/sysreg.h                    |  45 +++-
 arch/arm64/include/asm/thread_info.h               |  40 +---
 arch/arm64/include/asm/uaccess.h                   | 175 ++++++++++++++-
 arch/arm64/include/asm/uprobes.h                   |  36 ++++
 arch/arm64/kernel/armv8_deprecated.c               |  16 +-
 arch/arm64/kernel/asm-offsets.c                    |  13 +-
 arch/arm64/kernel/cpufeature.c                     |  18 +-
 arch/arm64/kernel/debug-monitors.c                 |  40 ++--
 arch/arm64/kernel/efi.c                            |   8 +-
 arch/arm64/kernel/entry.S                          | 110 +++++++---
 arch/arm64/kernel/fpsimd.c                         |  14 ++
 arch/arm64/kernel/head.S                           |  30 ++-
 arch/arm64/kernel/hw_breakpoint.c                  | 153 +++++++++----
 arch/arm64/kernel/insn.c                           |   1 -
 arch/arm64/kernel/kgdb.c                           |   3 +
 arch/arm64/kernel/probes/Makefile                  |   2 +
 arch/arm64/kernel/probes/decode-insn.c             |  33 +--
 arch/arm64/kernel/probes/decode-insn.h             |   8 +-
 arch/arm64/kernel/probes/kprobes.c                 |  36 ++--
 arch/arm64/kernel/probes/simulate-insn.c           |  16 +-
 arch/arm64/kernel/probes/uprobes.c                 | 216 +++++++++++++++++++
 arch/arm64/kernel/process.c                        |  38 +++-
 arch/arm64/kernel/ptrace.c                         |   7 +-
 arch/arm64/kernel/return_address.c                 |   1 +
 arch/arm64/kernel/setup.c                          |   9 +
 arch/arm64/kernel/signal.c                         |   3 +
 arch/arm64/kernel/sleep.S                          |   3 -
 arch/arm64/kernel/smp.c                            |  14 +-
 arch/arm64/kernel/stacktrace.c                     |   7 +-
 arch/arm64/kernel/suspend.c                        |   6 -
 arch/arm64/kernel/topology.c                       | 223 ++++++++++++++++++-
 arch/arm64/kernel/traps.c                          |  28 ++-
 arch/arm64/kernel/vmlinux.lds.S                    |   5 +
 arch/arm64/kvm/handle_exit.c                       |  11 +
 arch/arm64/kvm/hyp/hyp-entry.S                     |   9 +-
 arch/arm64/kvm/hyp/switch.c                        |   5 +-
 arch/arm64/lib/clear_user.S                        |  11 +-
 arch/arm64/lib/copy_from_user.S                    |  11 +-
 arch/arm64/lib/copy_in_user.S                      |  11 +-
 arch/arm64/lib/copy_to_user.S                      |  11 +-
 arch/arm64/mm/Makefile                             |   3 +-
 arch/arm64/mm/cache.S                              |   6 +-
 arch/arm64/mm/context.c                            |   7 +-
 arch/arm64/mm/dma-mapping.c                        |   5 -
 arch/arm64/mm/dump.c                               | 106 ++++++---
 arch/arm64/mm/fault.c                              |  22 +-
 arch/arm64/mm/flush.c                              |   9 +-
 arch/arm64/mm/hugetlbpage.c                        |  22 +-
 arch/arm64/mm/mmu.c                                | 137 ++++++++----
 arch/arm64/mm/proc.S                               |  12 +-
 arch/arm64/mm/ptdump_debugfs.c                     |  31 +++
 arch/arm64/xen/hypercall.S                         |  15 ++
 drivers/firmware/efi/arm-runtime.c                 |   4 +-
 drivers/irqchip/irq-gic-v3.c                       |  13 +-
 include/linux/restart_block.h                      |  51 +++++
 include/linux/thread_info.h                        |  45 +---
 include/uapi/linux/hw_breakpoint.h                 |   4 +
 tools/include/uapi/linux/hw_breakpoint.h           |   4 +
 tools/testing/selftests/breakpoints/Makefile       |   5 +-
 .../selftests/breakpoints/breakpoint_test_arm64.c  | 236 +++++++++++++++++++++
 89 files changed, 2288 insertions(+), 525 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt
 create mode 100644 arch/arm64/include/asm/current.h
 delete mode 100644 arch/arm64/include/asm/opcodes.h
 create mode 100644 arch/arm64/include/asm/stack_pointer.h
 create mode 100644 arch/arm64/include/asm/uprobes.h
 create mode 100644 arch/arm64/kernel/probes/uprobes.c
 create mode 100644 arch/arm64/mm/ptdump_debugfs.c
 create mode 100644 include/linux/restart_block.h
 create mode 100644 tools/testing/selftests/breakpoints/breakpoint_test_arm64.c

-- 
Catalin
