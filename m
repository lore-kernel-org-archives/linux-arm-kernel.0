From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Jul 2016 08:19:29 +0100
Subject: [GIT PULL] arm64 updates for 4.8
Message-ID: <20160727071926.GA18067@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 updates for 4.8 below. FYI, I'll be on holiday
from Friday for about 10 days, so missing the end of the merging window.
If there are any issues, Will is around to handle them.

There is a minor conflict with latest upstream caused by a function
renaming. My conflict resolution is:

diff --cc arch/arm64/mm/fault.c
index 031820d989a8,4ebda515a016..000000000000
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@@ -279,9 -307,8 +307,9 @@@ static int __kprobes do_page_fault(unsi
  		mm_flags |= FAULT_FLAG_WRITE;
  	}
  
- 	if (permission_fault(esr) && (addr < USER_DS)) {
+ 	if (is_permission_fault(esr) && (addr < USER_DS)) {
 -		if (get_fs() == KERNEL_DS)
 +		/* regs->orig_addr_limit may be 0 if we entered from EL0 */
 +		if (regs->orig_addr_limit == KERNEL_DS)
  			die("Accessing user space memory with fs=KERNEL_DS", regs, esr);
  
  		if (!search_exception_tables(regs->pc))

Thanks.


The following changes since commit 33688abb2802ff3a230bd2441f765477b94cc89e:

  Linux 4.7-rc4 (2016-06-19 21:30:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to fd6380b75065fd2ff51b5f7cbbe6be77d71ea9c7:

  arm64: arm: Fix-up the removal of the arm64 regs_query_register_name() prototype (2016-07-27 08:15:42 +0100)

----------------------------------------------------------------
arm64 updates for 4.8:

- Kexec support for arm64
- Kprobes support
- Expose MIDR_EL1 and REVIDR_EL1 CPU identification registers to sysfs
- Trapping of user space cache maintenance operations and emulation in
  the kernel (CPU errata workaround)
- Clean-up of the early page tables creation (kernel linear mapping, EFI
  run-time maps) to avoid splitting larger blocks (e.g. pmds) into
  smaller ones (e.g. ptes)
- VDSO support for CLOCK_MONOTONIC_RAW in clock_gettime()
- ARCH_HAS_KCOV enabled for arm64
- Optimise IP checksum helpers
- SWIOTLB optimisation to only allocate/initialise the buffer if the
  available RAM is beyond the 32-bit mask
- Properly handle the "nosmp" command line argument
- Fix for the initialisation of the CPU debug state during early boot
- vdso-offsets.h build dependency workaround
- Build fix when RANDOMIZE_BASE is enabled with MODULES off

----------------------------------------------------------------
Al Stone (1):
      ARM64: ACPI: Update documentation for latest specification version

Alexander Potapenko (1):
      arm64: allow building with kcov coverage on ARM64

Andre Przywara (6):
      Revert "arm64: alternatives: add enable parameter to conditional asm macros"
      arm64: fix "dc cvau" cache operation on errata-affected core
      arm64: include alternative handling in dcache_by_line_op
      arm64: errata: Calling enable functions for CPU errata too
      arm64: consolidate signal injection on emulation errors
      arm64: trap userspace "dc cvau" cache operation on errata-affected core

Ard Biesheuvel (7):
      arm64: mm: fix location of _etext
      arm64: mm: add param to force create_pgd_mapping() to use page mappings
      arm64: efi: always map runtime services code and data regions down to pages
      arm64: efi: avoid block mappings for unaligned UEFI memory regions
      arm64: mm: fold init_pgd() into __create_pgd_mapping()
      arm64: mm: make create_mapping_late() non-allocating
      arm64: mm: run pgtable_page_ctor() on non-swapper translation table pages

Catalin Marinas (8):
      Revert "arm64: Add support ARCH_SUPPORTS_INT128"
      arm64: mm: Remove split_p*d() functions
      arm64: Fix vdso-offsets.h dependency
      Revert "arm64: Fix vdso-offsets.h dependency"
      arm64: kprobes: Add KASAN instrumentation around stack accesses
      Merge branch 'for-next/kprobes' into for-next/core
      arm64: Only select ARM64_MODULE_PLTS if MODULES=y
      arm64: arm: Fix-up the removal of the arm64 regs_query_register_name() prototype

David A. Long (3):
      arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
      arm64: Add more test functions to insn.c
      arm64: add conditional instruction simulation support

Geoff Levand (4):
      arm64: Add back cpu reset routines
      arm64/kexec: Add core kexec support
      arm64/kexec: Enable kexec in the arm64 defconfig
      arm64/kexec: Add pr_debug output

James Morse (1):
      arm64: smp: Add function to determine if cpus are stuck in the kernel

Jisheng Zhang (1):
      arm64: mm: only initialize swiotlb when necessary

Kefeng Wang (2):
      arm64: Add support ARCH_SUPPORTS_INT128
      arm64: mm: remove unnecessary BUG_ON

Kevin Brodsky (3):
      arm64: fix vdso-offsets.h dependency
      arm64: Refactor vDSO time functions
      arm64: Add support for CLOCK_MONOTONIC_RAW in clock_gettime() vDSO

Lorenzo Pieralisi (1):
      arm64: mm: change IOMMU notifier action to attach DMA ops

Marc Zyngier (3):
      drivers/perf: arm-pmu: Handle per-interrupt affinity mask
      arm64: kprobes: Fix overflow when saving stack
      arm64: kprobes: Cleanup jprobe_return

Mark Rutland (7):
      arm64: mm: dump: make page table dumping reusable
      arm64: simplify dump_mem
      arm64: add macro to extract ESR_ELx.EC
      arm64/kvm: use ESR_ELx_EC to extract EC
      arm64: kill ESR_LNX_EXEC
      arm64: mm: simplify memblock numa node extraction
      arm64: localise Image objcopy flags

Pratyush Anand (2):
      arm64: Blacklist non-kprobe-able symbol
      arm64: Treat all entry code as non-kprobe-able

Robin Murphy (1):
      arm64: Implement optimised IP checksum helpers

Sandeepa Prabhu (4):
      arm64: Kprobes with single stepping support
      arm64: kprobes instruction simulation support
      arm64: Add kernel return probes support (kretprobes)
      kprobes: Add arm64 case in kprobe example module

Steve Capper (1):
      arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs

Suzuki K Poulose (2):
      arm64: Fix incorrect per-cpu usage for boot CPU
      arm64: Honor nosmp kernel command line option

Vladimir Murzin (1):
      arm64: ptrace: remove extra define for CPSR's E bit

Will Deacon (4):
      arm64: debug: unmask PSTATE.D earlier
      arm64: debug: remove redundant spsr manipulation
      arm64: debug: remove unused local_dbg_{enable, disable} macros
      arm64: kprobes: WARN if attempting to step with PSTATE.D=1

William Cohen (1):
      arm64: Add trampoline code for kretprobes

Yang Shi (1):
      arm64: kasan: instrument user memory access API

 Documentation/ABI/testing/sysfs-devices-system-cpu |  10 +
 Documentation/arm64/acpi_object_usage.txt          | 343 ++++++-----
 Documentation/arm64/arm-acpi.txt                   |  40 +-
 Documentation/devicetree/bindings/arm/pmu.txt      |   4 +-
 arch/arm64/Kconfig                                 |  16 +-
 arch/arm64/Makefile                                |  11 +-
 arch/arm64/boot/Makefile                           |   2 +
 arch/arm64/configs/defconfig                       |   1 +
 arch/arm64/include/asm/Kbuild                      |   1 -
 arch/arm64/include/asm/alternative.h               |  16 +-
 arch/arm64/include/asm/assembler.h                 |  12 +-
 arch/arm64/include/asm/checksum.h                  |  51 ++
 arch/arm64/include/asm/cpu.h                       |   2 +
 arch/arm64/include/asm/cpufeature.h                |   2 +
 arch/arm64/include/asm/debug-monitors.h            |   5 +
 arch/arm64/include/asm/efi.h                       |   3 +-
 arch/arm64/include/asm/esr.h                       |   1 +
 arch/arm64/include/asm/insn.h                      |  41 ++
 arch/arm64/include/asm/irqflags.h                  |   3 -
 arch/arm64/include/asm/kexec.h                     |  48 ++
 arch/arm64/include/asm/kprobes.h                   |  62 ++
 arch/arm64/include/asm/kvm_emulate.h               |   2 +-
 arch/arm64/include/asm/mmu.h                       |   2 +-
 arch/arm64/include/asm/probes.h                    |  35 ++
 arch/arm64/include/asm/processor.h                 |   1 +
 arch/arm64/include/asm/ptdump.h                    |  44 ++
 arch/arm64/include/asm/ptrace.h                    |  64 +-
 arch/arm64/include/asm/smp.h                       |  12 +
 arch/arm64/include/asm/sysreg.h                    |   2 +-
 arch/arm64/include/asm/traps.h                     |   2 +
 arch/arm64/include/asm/uaccess.h                   |  25 +-
 arch/arm64/include/asm/vdso_datapage.h             |   8 +-
 arch/arm64/include/asm/virt.h                      |   5 +
 arch/arm64/kernel/Makefile                         |  11 +-
 arch/arm64/kernel/arm64ksyms.c                     |   6 +-
 arch/arm64/kernel/armv8_deprecated.c               |  44 +-
 arch/arm64/kernel/asm-offsets.c                    |  17 +-
 arch/arm64/kernel/cpu-reset.S                      |  54 ++
 arch/arm64/kernel/cpu-reset.h                      |  34 +
 arch/arm64/kernel/cpu_errata.c                     |   7 +
 arch/arm64/kernel/cpufeature.c                     |   4 +-
 arch/arm64/kernel/cpuinfo.c                        | 120 ++++
 arch/arm64/kernel/debug-monitors.c                 |  47 +-
 arch/arm64/kernel/efi.c                            |  50 +-
 arch/arm64/kernel/entry.S                          |  17 +-
 arch/arm64/kernel/hw_breakpoint.c                  |   8 +
 arch/arm64/kernel/hyp-stub.S                       |  10 +-
 arch/arm64/kernel/insn.c                           | 133 ++++
 arch/arm64/kernel/kgdb.c                           |   4 +
 arch/arm64/kernel/machine_kexec.c                  | 212 +++++++
 arch/arm64/kernel/probes/Makefile                  |   3 +
 arch/arm64/kernel/probes/decode-insn.c             | 174 ++++++
 arch/arm64/kernel/probes/decode-insn.h             |  35 ++
 arch/arm64/kernel/probes/kprobes.c                 | 686 +++++++++++++++++++++
 arch/arm64/kernel/probes/kprobes_trampoline.S      |  81 +++
 arch/arm64/kernel/probes/simulate-insn.c           | 217 +++++++
 arch/arm64/kernel/probes/simulate-insn.h           |  28 +
 arch/arm64/kernel/ptrace.c                         | 101 +++
 arch/arm64/kernel/relocate_kernel.S                | 130 ++++
 arch/arm64/kernel/setup.c                          |   2 +-
 arch/arm64/kernel/smp.c                            |  28 +-
 arch/arm64/kernel/traps.c                          | 152 ++++-
 arch/arm64/kernel/vdso.c                           |   8 +-
 arch/arm64/kernel/vdso/Makefile                    |   7 +-
 arch/arm64/kernel/vdso/gettimeofday.S              | 331 ++++++----
 arch/arm64/kernel/vmlinux.lds.S                    |   9 +-
 arch/arm64/kvm/handle_exit.c                       |   4 +-
 arch/arm64/kvm/hyp/Makefile                        |   4 +
 arch/arm64/kvm/hyp/switch.c                        |   2 +-
 arch/arm64/lib/copy_from_user.S                    |   4 +-
 arch/arm64/lib/copy_to_user.S                      |   4 +-
 arch/arm64/mm/cache.S                              |   2 +-
 arch/arm64/mm/dma-mapping.c                        |  37 +-
 arch/arm64/mm/dump.c                               |  32 +-
 arch/arm64/mm/fault.c                              |  41 +-
 arch/arm64/mm/init.c                               |  13 +-
 arch/arm64/mm/mmu.c                                | 154 ++---
 arch/arm64/mm/proc.S                               |   2 +
 drivers/perf/arm_pmu.c                             |  27 +-
 include/uapi/linux/kexec.h                         |   1 +
 samples/kprobes/kprobe_example.c                   |   9 +
 81 files changed, 3394 insertions(+), 588 deletions(-)
 create mode 100644 arch/arm64/include/asm/checksum.h
 create mode 100644 arch/arm64/include/asm/kexec.h
 create mode 100644 arch/arm64/include/asm/kprobes.h
 create mode 100644 arch/arm64/include/asm/probes.h
 create mode 100644 arch/arm64/include/asm/ptdump.h
 create mode 100644 arch/arm64/kernel/cpu-reset.S
 create mode 100644 arch/arm64/kernel/cpu-reset.h
 create mode 100644 arch/arm64/kernel/machine_kexec.c
 create mode 100644 arch/arm64/kernel/probes/Makefile
 create mode 100644 arch/arm64/kernel/probes/decode-insn.c
 create mode 100644 arch/arm64/kernel/probes/decode-insn.h
 create mode 100644 arch/arm64/kernel/probes/kprobes.c
 create mode 100644 arch/arm64/kernel/probes/kprobes_trampoline.S
 create mode 100644 arch/arm64/kernel/probes/simulate-insn.c
 create mode 100644 arch/arm64/kernel/probes/simulate-insn.h
 create mode 100644 arch/arm64/kernel/relocate_kernel.S

-- 
Catalin
