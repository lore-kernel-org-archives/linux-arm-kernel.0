From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 5 Sep 2017 16:01:07 +0100
Subject: [GIT PULL] arm64 updates for 4.14
Message-ID: <20170905150104.ihs6uo4sh54gjvnf@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 updates for 4.14 below. There is a minor conflict
in arch/arm64/kernel/fpsimd.c, resolved to the changes introduced in
this pull request (use local_bh_* instead of preempt_*). Thanks.


The following changes since commit aae4e7a8bc44722fe70d58920a36916b1043195e:

  Linux 4.13-rc4 (2017-08-06 18:44:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to d1be5c99a0341249bf6f74eb1cbc3d5fc4ef2be7:

  arm64: cleanup {COMPAT_,}SET_PERSONALITY() macro (2017-08-22 18:41:47 +0100)

----------------------------------------------------------------
arm64 updates for 4.14:

- VMAP_STACK support, allowing the kernel stacks to be allocated in
  the vmalloc space with a guard page for trapping stack overflows. One
  of the patches introduces THREAD_ALIGN and changes the generic
  alloc_thread_stack_node() to use this instead of THREAD_SIZE (no
  functional change for other architectures)

- Contiguous PTE hugetlb support re-enabled (after being reverted a
  couple of times). We now have the semantics agreed in the generic mm
  layer together with API improvements so that the architecture code can
  detect between contiguous and non-contiguous huge PTEs

- Initial support for persistent memory on ARM: DC CVAP instruction
  exposed to user space (HWCAP) and the in-kernel pmem API implemented

- raid6 improvements for arm64: faster algorithm for the delta syndrome
  and implementation of the recovery routines using Neon

- FP/SIMD refactoring and removal of support for Neon in interrupt
  context. This is in preparation for full SVE support

- PTE accessors converted from inline asm to cmpxchg so that we can
  use LSE atomics if available (ARMv8.1)

- Perf support for Cortex-A35 and A73

- Non-urgent fixes and cleanups

----------------------------------------------------------------
Ard Biesheuvel (8):
      arm64: neon: replace generic definition of may_use_simd()
      arm64: unwind: disregard frame.sp when validating frame pointer
      arm64: unwind: reference pt_regs via embedded stack frame
      arm64: unwind: remove sp from struct stackframe
      md/raid6: use faster multiplication for ARM NEON delta syndrome
      md/raid6: implement recovery using ARM NEON intrinsics
      arm64: kernel: remove {THREAD,IRQ_STACK}_START_SP
      arm64: assembler: allow adr_this_cpu to use the stack pointer

Arnd Bergmann (2):
      arm64: fix pmem interface definition
      ACPI/IORT: Fix build regression without IOMMU

Catalin Marinas (12):
      arm64: neon: Temporarily add a kernel_mode_begin_partial() definition
      arm64: neon: Export kernel_neon_busy to loadable modules
      Merge branch 'arm64/exception-stack' of git://git.kernel.org/.../mark/linux into for-next/core
      Merge tag 'arm64-iort-for-v4.14' of git://git.kernel.org/.../lpieralisi/linux into for-next/core
      Merge branch 'arm64/vmap-stack' of git://git.kernel.org/.../mark/linux into for-next/core
      Merge branch 'for-next/perf' of git://git.kernel.org/.../will/linux into for-next/core
      Merge branch 'for-next/kernel-mode-neon' into for-next/core
      arm64: Convert pte handling from inline asm to using (cmp)xchg
      kvm: arm64: Convert kvm_set_s2pte_readonly() from inline asm to cmpxchg()
      arm64: Move PTE_RDONLY bit handling out of set_pte_at()
      arm64: Ignore hardware dirty bit updates in ptep_set_wrprotect()
      arm64: Remove the !CONFIG_ARM64_HW_AFDBM alternative code paths

Dave Martin (8):
      arm64: neon: Add missing header guard in <asm/neon.h>
      arm64: fpsimd: Consistently use __this_cpu_ ops where appropriate
      arm64: neon: Allow EFI runtime services to use FPSIMD in irq context
      arm64: neon: Remove support for nested or hardirq kernel-mode NEON
      arm64: syscallno is secretly an int, make it official
      arm64: Abstract syscallno manipulation
      arm64: neon: Forbid when irqs are disabled
      arm64: neon/efi: Make EFI fpsimd save/restore variables static

Dmitry Safonov (1):
      arm64/vdso: Support mremap() for vDSO

Dou Liyang (1):
      arm64: numa: Remove the unused parent_node() macro

Ganapatrao Kulkarni (1):
      ACPI/IORT: numa: Add numa node mapping for smmuv3 devices

Hoeun Ryu (1):
      arm64: kexec: have own crash_smp_send_stop() for crash dump for nonpanic cores

Julien Thierry (4):
      arm64: Decode information from ESR upon mem faults
      arm64: perf: Connect additional events to pmu counters
      arm64: perf: add support for Cortex-A73
      arm64: perf: add support for Cortex-A35

Kevin Brodsky (1):
      arm64: compat: Remove leftover variable declaration

Mark Rutland (16):
      arm64: Add ASM_BUG()
      arm64: consistently use bl for C exception entry
      arm64: move non-entry code out of .entry.text
      arm64: unwind: avoid percpu indirection for irq stack
      arm64: remove __die()'s stack dump
      fork: allow arch-override of VMAP stack alignment
      arm64: factor out PAGE_* and CONT_* definitions
      arm64: clean up THREAD_* definitions
      arm64: clean up irq stack definitions
      arm64: move SEGMENT_ALIGN to <asm/memory.h>
      efi/arm64: add EFI_KIMG_ALIGN
      arm64: factor out entry stack manipulation
      arm64: use an irq stack pointer
      arm64: add basic VMAP_STACK support
      arm64: add on_accessible_stack()
      arm64: add VMAP_STACK overflow detection

Pratyush Anand (1):
      arm64: perf: Allow more than one cycle counter to be used

Punit Agrawal (4):
      arm64: hugetlb: Handle swap entries in huge_pte_offset() for contiguous hugepages
      arm64: hugetlb: Override huge_pte_clear() to support contiguous hugepages
      arm64: hugetlb: Override set_huge_swap_pte_at() to support contiguous hugepages
      arm64: Re-enable support for contiguous hugepages

Robin Murphy (8):
      ACPI/IORT: Handle PCI aliases properly for IOMMUs
      arm64: mm: Fix set_memory_valid() declaration
      arm64: Convert __inval_cache_range() to area-based
      arm64: Expose DC CVAP to userspace
      arm64: Handle trapped DC CVAP
      arm64: Implement pmem API support
      arm64: uaccess: Implement *_flushcache variants
      arm64: uaccess: Add the uaccess_flushcache.c file

Steve Capper (5):
      arm64: hugetlb: set_huge_pte_at Add WARN_ON on !pte_present
      arm64: hugetlb: Introduce pte_pgprot helper
      arm64: hugetlb: Spring clean huge pte accessors
      arm64: hugetlb: Add break-before-make logic for contiguous entries
      arm64: hugetlb: Cleanup setup_hugepagesz

Tai Nguyen (1):
      perf: xgene: Remove unnecessary managed resources cleanup

Vladimir Murzin (2):
      arm64: dma-mapping: Do not pass data to gen_pool_set_algo()
      arm64: dma-mapping: Mark atomic_pool as __ro_after_init

Will Deacon (2):
      arm64: perf: Allow standard PMUv3 events to be extended by the CPU type
      arm64: perf: Remove redundant entries from CPU-specific event maps

Yury Norov (2):
      arm64: introduce separated bits for mm_context_t flags
      arm64: cleanup {COMPAT_,}SET_PERSONALITY() macro

 Documentation/arm64/cpu-feature-registers.txt |   2 +
 Documentation/devicetree/bindings/arm/pmu.txt |   2 +
 arch/arm64/Kconfig                            |  13 ++
 arch/arm64/include/asm/Kbuild                 |   1 -
 arch/arm64/include/asm/asm-bug.h              |  54 +++++
 arch/arm64/include/asm/assembler.h            |  25 +-
 arch/arm64/include/asm/bug.h                  |  35 +--
 arch/arm64/include/asm/cacheflush.h           |   4 +-
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/efi.h                  |  13 +-
 arch/arm64/include/asm/elf.h                  |   2 -
 arch/arm64/include/asm/esr.h                  |  42 +++-
 arch/arm64/include/asm/fpsimd.h               |  16 +-
 arch/arm64/include/asm/fpsimdmacros.h         |  56 -----
 arch/arm64/include/asm/hugetlb.h              |   9 +-
 arch/arm64/include/asm/irq.h                  |  42 ----
 arch/arm64/include/asm/kvm_mmu.h              |  21 +-
 arch/arm64/include/asm/memory.h               |  53 +++++
 arch/arm64/include/asm/mmu.h                  |   2 +
 arch/arm64/include/asm/neon.h                 |  16 +-
 arch/arm64/include/asm/numa.h                 |   3 -
 arch/arm64/include/asm/page-def.h             |  34 +++
 arch/arm64/include/asm/page.h                 |  12 +-
 arch/arm64/include/asm/pgtable-prot.h         |  18 +-
 arch/arm64/include/asm/pgtable.h              | 103 ++++-----
 arch/arm64/include/asm/processor.h            |   4 +-
 arch/arm64/include/asm/ptrace.h               |  31 ++-
 arch/arm64/include/asm/signal32.h             |   2 -
 arch/arm64/include/asm/simd.h                 |  56 +++++
 arch/arm64/include/asm/smp.h                  |   2 +-
 arch/arm64/include/asm/stacktrace.h           |  61 ++++-
 arch/arm64/include/asm/string.h               |   4 +
 arch/arm64/include/asm/sysreg.h               |   1 +
 arch/arm64/include/asm/thread_info.h          |  13 +-
 arch/arm64/include/asm/traps.h                |   5 +
 arch/arm64/include/asm/uaccess.h              |  12 +
 arch/arm64/include/uapi/asm/hwcap.h           |   1 +
 arch/arm64/kernel/asm-offsets.c               |   1 +
 arch/arm64/kernel/cpufeature.c                |  13 ++
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/entry-fpsimd.S              |  24 --
 arch/arm64/kernel/entry.S                     | 283 +++++++++++++++--------
 arch/arm64/kernel/fpsimd.c                    | 170 ++++++++++----
 arch/arm64/kernel/head.S                      |  22 +-
 arch/arm64/kernel/hibernate.c                 |   4 +-
 arch/arm64/kernel/irq.c                       |  40 +++-
 arch/arm64/kernel/machine_kexec.c             |   2 +-
 arch/arm64/kernel/perf_callchain.c            |   1 -
 arch/arm64/kernel/perf_event.c                | 208 +++++++----------
 arch/arm64/kernel/probes/uprobes.c            |   2 +-
 arch/arm64/kernel/process.c                   |  13 +-
 arch/arm64/kernel/ptrace.c                    |   5 +-
 arch/arm64/kernel/return_address.c            |   1 -
 arch/arm64/kernel/signal.c                    |  10 +-
 arch/arm64/kernel/signal32.c                  |   2 +-
 arch/arm64/kernel/smp.c                       |  14 +-
 arch/arm64/kernel/stacktrace.c                |  60 +----
 arch/arm64/kernel/time.c                      |   1 -
 arch/arm64/kernel/traps.c                     |  79 ++++---
 arch/arm64/kernel/vdso.c                      |  15 ++
 arch/arm64/kernel/vmlinux.lds.S               |  18 +-
 arch/arm64/kvm/hyp/s2-setup.c                 |   2 +-
 arch/arm64/lib/Makefile                       |   2 +
 arch/arm64/lib/uaccess_flushcache.c           |  47 ++++
 arch/arm64/mm/cache.S                         |  37 ++-
 arch/arm64/mm/dma-mapping.c                   |   4 +-
 arch/arm64/mm/fault.c                         |  77 +++++--
 arch/arm64/mm/flush.c                         |  16 ++
 arch/arm64/mm/hugetlbpage.c                   | 314 +++++++++++++++++++-------
 drivers/acpi/arm64/iort.c                     | 140 +++++++-----
 drivers/firmware/efi/libstub/arm64-stub.c     |   6 +-
 drivers/perf/arm_pmu.c                        |   6 +
 drivers/perf/xgene_pmu.c                      |  74 ++----
 include/linux/raid/pq.h                       |   1 +
 include/linux/thread_info.h                   |   4 +
 kernel/fork.c                                 |   3 +-
 lib/raid6/Makefile                            |   4 +-
 lib/raid6/algos.c                             |   3 +
 lib/raid6/neon.uc                             |  33 ++-
 lib/raid6/recov_neon.c                        | 110 +++++++++
 lib/raid6/recov_neon_inner.c                  | 117 ++++++++++
 81 files changed, 1840 insertions(+), 922 deletions(-)
 create mode 100644 arch/arm64/include/asm/asm-bug.h
 create mode 100644 arch/arm64/include/asm/page-def.h
 create mode 100644 arch/arm64/include/asm/simd.h
 create mode 100644 arch/arm64/lib/uaccess_flushcache.c
 create mode 100644 lib/raid6/recov_neon.c
 create mode 100644 lib/raid6/recov_neon_inner.c

-- 
Catalin
