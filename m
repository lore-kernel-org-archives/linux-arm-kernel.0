From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 Sep 2015 11:26:57 +0100
Subject: [GIT PULL] arm64: updates for 4.3
Message-ID: <20150904102656.GC4818@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here is the arm64 queue for 4.3. There's quite a lot here and the
diffstat looks pretty alarming at first glance, so let me walk you
through it:

  - There are a bunch of new arm64 features and these are summarised in
    the tag (see below).

  - One of these features (LSE) involves a pretty hefty rework of our
    atomic operations, which interacts badly with the
    atomic_{or,xor,and} rework from PeterZ in tip. To solve this, tglx
    made a stable branch (tip/locking/arch-atomic) which is included
    here and accounts for most of the surprising diffstat (it touches
    all users of atomic_{set,clear}_mask). You've already pulled this
    from tip.

  - We move our PSCI (a firmware interface for CPU power management)
    implementation out into drivers/firmware/ so that it can be shared
    with arch/arm/, rather than each architecture having a carbon copy
    of the code. This was merged as a separate branch so that RMK can
    include the changes in his tree too and subsequently move arch/arm/
    over to the common code (again, you've already pulled this).

  - There is a single patch to drivers/of/fdt.c, but that has been
    Acked-by Rob and is included here due to a dependency from the
    memblock linear-mapping restriction change.

Note that there is a conflict in arch/arm64/include/asm/barrier.h
between 76695af20c01 ("locking, arch: use WRITE_ONCE()/READ_ONCE() in
smp_store_release()/smp_load_acquire()") and 4b3dc9679cf7 ("arm64: force
CONFIG_SMP=y and remove redundant #ifdefs"). The correct resolution is
to take the version here (i.e. remove the #ifndef CONFIG_SMP block
altogether).

Please pull.

Thanks,

Will

--->8

The following changes since commit cbfe8fa6cd672011c755c3cd85c9ffd4e2d10a6f:

  Linux 4.2-rc4 (2015-07-26 12:26:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 674c242c9323d3c293fc4f9a3a3a619fe3063290:

  arm64: flush FP/SIMD state correctly after execve() (2015-08-27 09:55:26 +0100)

----------------------------------------------------------------
arm64 updates for 4.3:

- Support for new architectural features introduced in ARMv8.1:
  * Privileged Access Never (PAN) to catch user pointer dereferences in
    the kernel
  * Large System Extension (LSE) for building scalable atomics and locks
    (depends on locking/arch-atomic from tip, which is included here)
  * Hardware Dirty Bit Management (DBM) for updating clean PTEs
    automatically

- Move our PSCI implementation out into drivers/firmware/, where it can
  be shared with arch/arm/. RMK has also pulled this component branch
  and has additional patches moving arch/arm/ over. MAINTAINERS is
  updated accordingly.

- Better BUG implementation based on the BRK instruction for trapping

- Leaf TLB invalidation for unmapping user pages

- Support for PROBE_ONLY PCI configurations

- Various cleanups and non-critical fixes, including:
  * Always flush FP/SIMD state over exec()
  * Restrict memblock additions based on range of linear mapping
  * Ensure *(LIST_POISON) generates a fatal fault
  * Context-tracking syscall return no longer corrupts return value when
    not forced on.
  * Alternatives patching synchronisation/stability improvements
  * Signed sub-word cmpxchg compare fix (tickled by HAVE_CMPXCHG_LOCAL)
  * Force SMP=y
  * Hide direct DCC access from userspace
  * Fix EFI stub memory allocation when DRAM starts at 0x0

----------------------------------------------------------------
Alexander Kuleshov (1):
      arm64: Fix source code file path in comments

Ard Biesheuvel (5):
      arm64: efi: prefer AllocatePages() over efi_low_alloc() for vmlinux
      arm64/Documentation: clarify wording regarding memory below the Image
      of/fdt: make memblock maximum physical address arch configurable
      arm64: set MAX_MEMBLOCK_ADDR according to linear region size
      arm64: flush FP/SIMD state correctly after execve()

Catalin Marinas (4):
      arm64: Add support for hardware updates of the access and dirty pte bits
      arm64: Better native ptrace support for compat tasks
      arm64: Clean up __flush_tlb(_kernel)_range functions
      arm64: Use last level TLBI for user pte changes

Chris Metcalf (1):
      tile: Provide atomic_{or,xor,and}

Daniel Thompson (5):
      arm64: Remove unused macros from assembler.h
      arm64: alternative: Provide if/else/endif assembler macros
      arm64: mm: Adopt new alternative assembler macros
      arm64: kernel: Adopt new alternative assembler macros
      arm64: kvm: Adopt new alternative assembler macros

Dave P Martin (9):
      arm64/debug: Eliminate magic number for size of BRK instruction
      arm64/debug: Mask off all reserved bits from generated ESR values
      arm64/debug: Eliminate magic number from ESR template definition
      arm64/debug: More consistent naming for the BRK ESR template macro
      arm64/debug: Move BRK ESR template macro into <asm/esr.h>
      arm64/debug: Simplify BRK insn opcode declarations
      arm64/debug: Add missing #includes
      arm64/BUG: Use BRK instruction for generic BUG traps
      arm64/BUG: Show explicit backtrace for WARNs

James Morse (6):
      arm64: kernel: Add cpuid_feature_extract_field() for 4bit sign extension
      arm64: kernel: Move config_sctlr_el1
      arm64: kernel: Add cpufeature 'enable' callback
      arm64: kernel: Add min_field_value and use '>=' for feature detection
      arm64: kernel: Add optional CONFIG_ parameter to ALTERNATIVE()
      arm64: kernel: Add support for Privileged Access Never

Jeff Vander Stoep (1):
      arm64: kconfig: Move LIST_POISON to a safe value

Jisheng Zhang (1):
      arm64: hugetlb: remove paragraph about writing to FSF

Jonas Rabenstein (2):
      arm64: remove dead-code depending on CONFIG_UP_LATE_INIT
      arm64: remove redundant object file list

Jungseok Lee (1):
      arm64: Add __exception_irq_entry definition for function graph

Lorenzo Pieralisi (1):
      ARM64: PCI: do not enable resources on PROBE_ONLY systems

Mark Rutland (7):
      arm64: perf: factor out callchain code
      arm64: perf: condense event number maps
      arm64: mm: mark create_mapping as __init
      arm64: psci: factor invocation code to drivers
      drivers: psci: support native SMC{32,64} calls
      MAINTAINERS: add PSCI entry
      arm64: make ll/sc __cmpxchg_case_##name asm consistent

Mark Salter (1):
      arm64: remove dead code

Olof Johansson (1):
      arm64: enable more compressed Image formats

Peter Zijlstra (27):
      atomic: Prepare generic atomic implementation for logic ops
      alpha: Provide atomic_{or,xor,and}
      arc: Provide atomic_{or,xor,and}
      arm: Provide atomic_{or,xor,and}
      arm64: Provide atomic_{or,xor,and}
      avr32: Provide atomic_{or,xor,and}
      blackfin: Provide atomic_{or,xor,and}
      hexagon: Provide atomic_{or,xor,and}
      ia64: Provide atomic_{or,xor,and}
      m32r: Provide atomic_{or,xor,and}
      m68k: Provide atomic_{or,xor,and}
      metag: Provide atomic_{or,xor,and}
      mips: Provide atomic_{or,xor,and}
      mn10300: Provide atomic_{or,xor,and}
      parisc: Provide atomic_{or,xor,and}
      powerpc: Provide atomic_{or,xor,and}
      sh: Provide atomic_{or,xor,and}
      sparc: Provide atomic_{or,xor,and}
      xtensa: Provide atomic_{or,xor,and}
      s390: Provide atomic_{or,xor,and}
      x86: Provide atomic_{or,xor,and}
      frv: Rewrite atomic implementation
      h8300: Provide atomic_{or,xor,and}
      atomic: Provide atomic_{or,xor,and}
      atomic: Collapse all atomic_{set,clear}_mask definitions
      atomic: Replace atomic_{set,clear}_mask() usage
      atomic: Add simple atomic_t tests

Robin Murphy (3):
      arm64: consolidate __swiotlb_mmap
      arm64: dma-mapping: implement dma_get_sgtable()
      arm64: dma-mapping: Simplify pgprot handling

Rohit Thapliyal (1):
      arm64: modify the dump mem for 64 bit addresses

Sudeep Holla (3):
      arm64: perf: replace arch_find_n_match_cpu_physical_id with of_cpu_device_node_get
      arm64: kernel: remove non-legit DT warnings when booting using ACPI
      arm64: restore cpu suspend/resume functionality

Suzuki K. Poulose (2):
      arm64: perf: Remove unnecessary printk
      arm64: Generalise msr_s/mrs_s operations

Wang Long (1):
      arm64: mm: add __init section marker to free_initrd_mem

Will Deacon (41):
      arm64: move update_mmu_cache() into asm/pgtable.h
      arm64: lib: use pair accessors for copy_*_user routines
      arm64: force CONFIG_SMP=y and remove redundant #ifdefs
      arm64: alternatives: add enable parameter to conditional asm macros
      arm64: include linux/types.h in asm/spinlock_types.h
      Merge branch 'locking/arch-atomic' of git://git.kernel.org/.../tip/tip into aarch64/for-next/core
      arm64: rwlocks: don't fail trylock purely due to contention
      arm64: cpufeature.h: add missing #include of kernel.h
      arm64: atomics: move ll/sc atomics into separate header file
      arm64: elf: advertise 8.1 atomic instructions as new hwcap
      arm64: alternatives: add cpu feature for lse atomics
      arm64: introduce CONFIG_ARM64_LSE_ATOMICS as fallback to ll/sc atomics
      arm64: atomics: patch in lse instructions when supported by the CPU
      arm64: locks: patch in lse instructions when supported by the CPU
      arm64: bitops: patch in lse instructions when supported by the CPU
      arm64: xchg: patch in lse instructions when supported by the CPU
      arm64: cmpxchg: patch in lse instructions when supported by the CPU
      arm64: cmpxchg_dbl: patch in lse instructions when supported by the CPU
      arm64: cmpxchg: avoid "cc" clobber in ll/sc routines
      arm64: cmpxchg: avoid memory barrier on comparison failure
      arm64: atomics: tidy up common atomic{,64}_* macros
      arm64: atomics: prefetch the destination word for write prior to stxr
      arm64: atomics: implement atomic{,64}_cmpxchg using cmpxchg
      arm64: atomic64_dec_if_positive: fix incorrect branch condition
      arm64: kconfig: select HAVE_CMPXCHG_LOCAL
      arm64: lse: rename ARM64_CPU_FEAT_LSE_ATOMICS for consistency
      arm64: kconfig: group the v8.1 features together
      arm64: lse: use generic cpufeature detection for LSE atomics
      arm64: elf: use cpuid_feature_extract_field for hwcap detection
      arm64: debug: rename enum debug_el to avoid symbol collision
      arm64: spinlock: fix ll/sc unlock on big-endian systems
      arm64: pgtable: fix definition of pte_valid
      arm64: lse: fix lse cmpxchg code indentation
      arm64: alternative: put secondary CPUs into polling loop during patch
      arm64: cmpxchg: truncate sub-word signed types before comparison
      arm64: alternatives: ensure secondary CPUs execute ISB after patching
      arm64: mm: ensure patched kernel text is fetched from PoU
      Merge branch 'aarch64/psci/drivers' into aarch64/for-next/core
      arm64: mdscr_el1: avoid exposing DCC to userspace
      arm64: entry: always restore x0 from the stack on syscall return
      arm64: makefile: fix perf_callchain.o kconfig dependency

yalin wang (1):
      arm64: insn: use set_fixmap_offset to make it more clear

 Documentation/arm64/booting.txt         |  11 +-
 MAINTAINERS                             |   9 +
 arch/alpha/include/asm/atomic.h         |  42 ++--
 arch/arc/include/asm/atomic.h           |   8 +-
 arch/arm/include/asm/atomic.h           |  14 ++
 arch/arm64/Kconfig                      |  87 +++++--
 arch/arm64/Makefile                     |  18 +-
 arch/arm64/boot/Makefile                |  12 +
 arch/arm64/include/asm/acpi.h           |   4 +-
 arch/arm64/include/asm/alternative.h    |  78 ++++++-
 arch/arm64/include/asm/assembler.h      |  14 --
 arch/arm64/include/asm/atomic.h         | 265 +++++-----------------
 arch/arm64/include/asm/atomic_ll_sc.h   | 247 ++++++++++++++++++++
 arch/arm64/include/asm/atomic_lse.h     | 391 ++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/barrier.h        |  24 --
 arch/arm64/include/asm/bug.h            |  64 ++++++
 arch/arm64/include/asm/cmpxchg.h        | 192 ++++++----------
 arch/arm64/include/asm/cpufeature.h     |  18 +-
 arch/arm64/include/asm/cputype.h        |   3 -
 arch/arm64/include/asm/debug-monitors.h |  44 ++--
 arch/arm64/include/asm/esr.h            |   9 +
 arch/arm64/include/asm/exception.h      |   6 +
 arch/arm64/include/asm/fixmap.h         |   2 +-
 arch/arm64/include/asm/futex.h          |  10 +
 arch/arm64/include/asm/hardirq.h        |   4 -
 arch/arm64/include/asm/hugetlb.h        |   4 -
 arch/arm64/include/asm/irq_work.h       |  11 -
 arch/arm64/include/asm/lse.h            |  53 +++++
 arch/arm64/include/asm/memory.h         |   8 +
 arch/arm64/include/asm/mmu.h            |   1 -
 arch/arm64/include/asm/percpu.h         |   8 -
 arch/arm64/include/asm/perf_event.h     |   2 +-
 arch/arm64/include/asm/pgtable-hwdef.h  |   3 +
 arch/arm64/include/asm/pgtable.h        | 167 +++++++++++++-
 arch/arm64/include/asm/processor.h      |   2 +
 arch/arm64/include/asm/psci.h           |  28 ---
 arch/arm64/include/asm/ptrace.h         |   4 -
 arch/arm64/include/asm/smp.h            |   4 -
 arch/arm64/include/asm/smp_plat.h       |   2 -
 arch/arm64/include/asm/spinlock.h       | 147 +++++++++---
 arch/arm64/include/asm/spinlock_types.h |   2 +
 arch/arm64/include/asm/sysreg.h         |  40 +++-
 arch/arm64/include/asm/tlb.h            |   7 +-
 arch/arm64/include/asm/tlbflush.h       |  76 +++----
 arch/arm64/include/asm/topology.h       |   9 -
 arch/arm64/include/asm/traps.h          |  23 +-
 arch/arm64/include/asm/uaccess.h        |  11 +
 arch/arm64/include/uapi/asm/hwcap.h     |   1 +
 arch/arm64/include/uapi/asm/ptrace.h    |   1 +
 arch/arm64/kernel/Makefile              |   6 +-
 arch/arm64/kernel/alternative.c         |  30 ++-
 arch/arm64/kernel/armv8_deprecated.c    |  19 +-
 arch/arm64/kernel/cpu_ops.c             |   2 -
 arch/arm64/kernel/cpufeature.c          |  53 ++++-
 arch/arm64/kernel/debug-monitors.c      |   4 +-
 arch/arm64/kernel/efi-stub.c            |  41 +++-
 arch/arm64/kernel/entry.S               |  46 ++--
 arch/arm64/kernel/fpsimd.c              |   1 +
 arch/arm64/kernel/head.S                |  15 +-
 arch/arm64/kernel/hw_breakpoint.c       |   6 +-
 arch/arm64/kernel/insn.c                |   5 +-
 arch/arm64/kernel/irq.c                 |   2 -
 arch/arm64/kernel/kgdb.c                |  12 +-
 arch/arm64/kernel/pci.c                 |  13 ++
 arch/arm64/kernel/perf_callchain.c      | 196 ++++++++++++++++
 arch/arm64/kernel/perf_event.c          | 310 ++-----------------------
 arch/arm64/kernel/psci.c                | 366 +-----------------------------
 arch/arm64/kernel/ptrace.c              |  92 +++++++-
 arch/arm64/kernel/setup.c               |  87 +++----
 arch/arm64/kernel/sleep.S               |  14 +-
 arch/arm64/kernel/smp.c                 |  15 +-
 arch/arm64/kernel/time.c                |   2 -
 arch/arm64/kernel/topology.c            |   2 +-
 arch/arm64/kernel/traps.c               |  94 ++++++--
 arch/arm64/kvm/hyp.S                    |  12 +-
 arch/arm64/lib/Makefile                 |  13 ++
 arch/arm64/lib/atomic_ll_sc.c           |   3 +
 arch/arm64/lib/bitops.S                 |  45 ++--
 arch/arm64/lib/clear_user.S             |   8 +
 arch/arm64/lib/copy_from_user.S         |  25 +-
 arch/arm64/lib/copy_in_user.S           |  25 +-
 arch/arm64/lib/copy_to_user.S           |  25 +-
 arch/arm64/mm/cache.S                   |   7 +-
 arch/arm64/mm/context.c                 |  16 --
 arch/arm64/mm/dma-mapping.c             |  33 +--
 arch/arm64/mm/fault.c                   |  28 ++-
 arch/arm64/mm/flush.c                   |   4 -
 arch/arm64/mm/hugetlbpage.c             |   4 -
 arch/arm64/mm/init.c                    |   4 +-
 arch/arm64/mm/mmu.c                     |  13 +-
 arch/arm64/mm/proc.S                    |  21 +-
 arch/avr32/include/asm/atomic.h         |  12 +
 arch/blackfin/include/asm/atomic.h      |  16 +-
 arch/blackfin/kernel/bfin_ksyms.c       |   7 +-
 arch/blackfin/mach-bf561/atomic.S       |  30 +--
 arch/blackfin/mach-common/smp.c         |   2 +-
 arch/frv/include/asm/atomic.h           | 107 ++++-----
 arch/frv/include/asm/atomic_defs.h      | 172 ++++++++++++++
 arch/frv/include/asm/bitops.h           |  99 +-------
 arch/frv/kernel/dma.c                   |   6 +-
 arch/frv/kernel/frv_ksyms.c             |   5 -
 arch/frv/lib/Makefile                   |   2 +-
 arch/frv/lib/atomic-lib.c               |   7 +
 arch/frv/lib/atomic-ops.S               | 110 ---------
 arch/frv/lib/atomic64-ops.S             |  94 --------
 arch/h8300/include/asm/atomic.h         | 137 +++--------
 arch/hexagon/include/asm/atomic.h       |   4 +
 arch/ia64/include/asm/atomic.h          |  24 +-
 arch/m32r/include/asm/atomic.h          |  45 +---
 arch/m32r/kernel/smp.c                  |   4 +-
 arch/m68k/include/asm/atomic.h          |  14 +-
 arch/metag/include/asm/atomic_lnkget.h  |  38 +---
 arch/metag/include/asm/atomic_lock1.h   |  23 +-
 arch/mips/include/asm/atomic.h          |   7 +
 arch/mn10300/include/asm/atomic.h       |  71 +-----
 arch/mn10300/mm/tlb-smp.c               |   2 +-
 arch/parisc/include/asm/atomic.h        |   7 +
 arch/powerpc/include/asm/atomic.h       |   7 +
 arch/powerpc/kernel/misc_32.S           |  19 --
 arch/s390/include/asm/atomic.h          |  41 ++--
 arch/s390/kernel/time.c                 |   4 +-
 arch/s390/kvm/interrupt.c               |  30 +--
 arch/s390/kvm/kvm-s390.c                |  32 +--
 arch/sh/include/asm/atomic-grb.h        |  43 +---
 arch/sh/include/asm/atomic-irq.h        |  21 +-
 arch/sh/include/asm/atomic-llsc.h       |  31 +--
 arch/sparc/include/asm/atomic_32.h      |   4 +-
 arch/sparc/include/asm/atomic_64.h      |   4 +
 arch/sparc/lib/atomic32.c               |  22 +-
 arch/sparc/lib/atomic_64.S              |   6 +
 arch/sparc/lib/ksyms.c                  |   3 +
 arch/tile/include/asm/atomic_32.h       |  28 +++
 arch/tile/include/asm/atomic_64.h       |  40 ++++
 arch/tile/lib/atomic_32.c               |  23 ++
 arch/tile/lib/atomic_asm_32.S           |   4 +
 arch/x86/include/asm/atomic.h           |  25 +-
 arch/x86/include/asm/atomic64_32.h      |  14 ++
 arch/x86/include/asm/atomic64_64.h      |  15 ++
 arch/xtensa/include/asm/atomic.h        |  73 +-----
 drivers/firmware/Kconfig                |   3 +
 drivers/firmware/Makefile               |   1 +
 drivers/firmware/psci.c                 | 382 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/i915_drv.c         |   2 +-
 drivers/gpu/drm/i915/i915_gem.c         |   2 +-
 drivers/gpu/drm/i915/i915_irq.c         |   4 +-
 drivers/of/fdt.c                        |  12 +-
 drivers/s390/scsi/zfcp_aux.c            |   2 +-
 drivers/s390/scsi/zfcp_erp.c            |  62 ++---
 drivers/s390/scsi/zfcp_fc.c             |   8 +-
 drivers/s390/scsi/zfcp_fsf.c            |  26 +--
 drivers/s390/scsi/zfcp_qdio.c           |  14 +-
 include/asm-generic/atomic.h            |  11 +-
 include/asm-generic/atomic64.h          |   4 +
 include/linux/atomic.h                  |  38 ++--
 include/linux/psci.h                    |  52 +++++
 lib/atomic64.c                          |   3 +
 lib/atomic64_test.c                     |  68 ++++--
 157 files changed, 3601 insertions(+), 2536 deletions(-)
 create mode 100644 arch/arm64/include/asm/atomic_ll_sc.h
 create mode 100644 arch/arm64/include/asm/atomic_lse.h
 create mode 100644 arch/arm64/include/asm/bug.h
 create mode 100644 arch/arm64/include/asm/lse.h
 delete mode 100644 arch/arm64/include/asm/psci.h
 create mode 100644 arch/arm64/kernel/perf_callchain.c
 create mode 100644 arch/arm64/lib/atomic_ll_sc.c
 create mode 100644 arch/frv/include/asm/atomic_defs.h
 create mode 100644 arch/frv/lib/atomic-lib.c
 create mode 100644 drivers/firmware/psci.c
 create mode 100644 include/linux/psci.h
