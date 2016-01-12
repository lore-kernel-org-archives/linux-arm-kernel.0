From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Jan 2016 12:27:55 +0000
Subject: [GIT PULL] arm64: updates for 4.5
Message-ID: <20160112122755.GE15737@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here is the core arm64 queue for 4.5. As you might expect, the Christmas
break resulted in a number of patches not making the final cut, so 4.6
is likely to be larger than usual. There's still some useful stuff here,
however, and it's detailed in the tag.

The EFI changes have been Reviewed-by Matt and the memblock change got
an "OK" from akpm [1].

Please pull,

Will

[1] http://lkml.kernel.org/r/20151208142341.b91ab5728f244a68231e3b87 at linux-foundation.org

--->8

The following changes since commit 31ade3b83e1821da5fbb2f11b5b3d4ab2ec39db8:

  Linux 4.4-rc3 (2015-11-29 18:58:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 2a803c4db615d85126c5c7afd5849a3cfde71422:

  arm64: head.S: use memset to clear BSS (2016-01-06 16:00:56 +0000)

----------------------------------------------------------------
arm64 updates for 4.5:

- Support for a separate IRQ stack, although we haven't reduced the size
  of our thread stack just yet since we don't have enough data to
  determine a safe value

- Refactoring of our EFI initialisation and runtime code into
  drivers/firmware/efi/ so that it can be reused by arch/arm/.

- Ftrace improvements when unwinding in the function graph tracer

- Document our silicon errata handling process

- Cache flushing optimisation when mapping executable pages

- Support for hugetlb mappings using the contiguous hint in the pte

----------------------------------------------------------------
AKASHI Takahiro (4):
      arm64: Modify stack trace and dump for use with irq_stack
      arm64: ftrace: modify a stack frame in a safe way
      arm64: pass a task parameter to unwind_frame()
      arm64: ftrace: fix a stack tracer's output under function graph tracer

Ard Biesheuvel (8):
      mm/memblock: add MEMBLOCK_NOMAP attribute to memblock memory table
      arm64: only consider memblocks with NOMAP cleared for linear mapping
      arm64/efi: mark UEFI reserved regions as MEMBLOCK_NOMAP
      arm64/efi: split off EFI init and runtime code for reuse by 32-bit ARM
      arm64/efi: refactor EFI init and runtime code for reuse by 32-bit ARM
      arm64: module: fix relocation of movz instruction with negative immediate
      arm64: module: avoid undefined shift behavior in reloc_data()
      efi: stub: define DISABLE_BRANCH_PROFILING for all architectures

Ashok Kumar (2):
      arm64: Defer dcache flush in __cpu_copy_user_page
      arm64: Use PoU cache instr for I/D coherency

Catalin Marinas (1):
      arm64: Add trace_hardirqs_off annotation in ret_to_user

David Woods (1):
      arm64: hugetlb: add support for PTE contiguous bit

James Morse (6):
      arm64: Add do_softirq_own_stack() and enable irq_stacks
      arm64: Add this_cpu_ptr() assembler macro for use in entry.S
      arm64: when walking onto the task stack, check sp & fp are in current->stack
      arm64: don't call C code with el0's fp register
      arm64: reduce stack use in irq_handler
      arm64: remove irq_count and do_softirq_own_stack()

Jisheng Zhang (1):
      arm64: add __init/__initdata section marker to some functions/variables

John Blackwood (1):
      arm64: Clear out any singlestep state on a ptrace detach operation

Jungseok Lee (1):
      arm64: Store struct thread_info in sp_el0

Li Bin (2):
      arm64: ftrace: stop using kstop_machine to enable/disable tracing
      arm64: ftrace: fix the comments for ftrace_modify_code

Mark Brown (1):
      arm64: cmpxchg: Don't incldue linux/mmdebug.h

Mark Rutland (8):
      arm64: mm: detect bad __create_mapping uses
      arm64: mm: allow sections for unaligned bases
      arm64: mm: remove pointless PAGE_MASKing
      arm64: Remove redundant padding from linker script
      arm64: mm: fold alternatives into .init
      arm64: mm: place __cpu_setup in .text
      arm64: entry: remove pointless SPSR mode check
      arm64: head.S: use memset to clear BSS

Will Deacon (9):
      arm64: pgtable: implement pte_accessible()
      arm64: enable HAVE_IRQ_TIME_ACCOUNTING
      arm64: spinlock: serialise spin_unlock_wait against concurrent lockers
      arm64: irq: fix walking from irq stack to task stack
      arm64: Documentation: add list of software workarounds for errata
      arm64: mm: ensure that the zero page is visible to the page table walker
      Merge branch 'aarch64/efi' into aarch64/for-next/core
      arm64: traps: address fallout from printk -> pr_* conversion
      arm64: mm: move pgd_cache initialisation to pgtable_cache_init

Yury Norov (1):
      arm64: fix COMPAT_SHMLBA definition for large pages

 Documentation/arm64/silicon-errata.txt             |  58 ++++
 .../features/time/irq-time-acct/arch-support.txt   |   2 +-
 arch/arm64/Kconfig                                 |   4 +-
 arch/arm64/include/asm/alternative.h               |   1 -
 arch/arm64/include/asm/assembler.h                 |  11 +
 arch/arm64/include/asm/cacheflush.h                |   1 +
 arch/arm64/include/asm/cmpxchg.h                   |   1 -
 arch/arm64/include/asm/efi.h                       |   9 +
 arch/arm64/include/asm/ftrace.h                    |   2 +
 arch/arm64/include/asm/hugetlb.h                   |  44 +--
 arch/arm64/include/asm/irq.h                       |  45 +++
 arch/arm64/include/asm/pgtable-hwdef.h             |  18 +-
 arch/arm64/include/asm/pgtable.h                   |  23 +-
 arch/arm64/include/asm/shmparam.h                  |   2 +-
 arch/arm64/include/asm/spinlock.h                  |  23 +-
 arch/arm64/include/asm/stacktrace.h                |   9 +-
 arch/arm64/include/asm/thread_info.h               |  10 +-
 arch/arm64/kernel/alternative.c                    |   6 -
 arch/arm64/kernel/armv8_deprecated.c               |   6 +-
 arch/arm64/kernel/cpufeature.c                     |   9 +-
 arch/arm64/kernel/efi.c                            | 334 ++-------------------
 arch/arm64/kernel/entry.S                          |  69 ++++-
 arch/arm64/kernel/fpsimd.c                         |   2 +-
 arch/arm64/kernel/ftrace.c                         |  27 +-
 arch/arm64/kernel/head.S                           |  20 +-
 arch/arm64/kernel/irq.c                            |   3 +
 arch/arm64/kernel/module.c                         |  71 ++---
 arch/arm64/kernel/perf_callchain.c                 |   5 +-
 arch/arm64/kernel/process.c                        |   5 +-
 arch/arm64/kernel/ptrace.c                         |   6 +
 arch/arm64/kernel/return_address.c                 |   5 +-
 arch/arm64/kernel/sleep.S                          |   3 +
 arch/arm64/kernel/stacktrace.c                     |  75 ++++-
 arch/arm64/kernel/time.c                           |   5 +-
 arch/arm64/kernel/traps.c                          |  52 +++-
 arch/arm64/kernel/vmlinux.lds.S                    |   7 +-
 arch/arm64/mm/cache.S                              |  28 +-
 arch/arm64/mm/copypage.c                           |   3 +-
 arch/arm64/mm/dma-mapping.c                        |   4 +-
 arch/arm64/mm/flush.c                              |  33 +-
 arch/arm64/mm/hugetlbpage.c                        | 274 ++++++++++++++++-
 arch/arm64/mm/init.c                               |   9 +-
 arch/arm64/mm/mmu.c                                |  17 +-
 arch/arm64/mm/pgd.c                                |  12 +-
 arch/arm64/mm/proc-macros.S                        |  22 ++
 arch/arm64/mm/proc.S                               |   2 -
 drivers/firmware/efi/Makefile                      |   3 +
 drivers/firmware/efi/arm-init.c                    | 209 +++++++++++++
 drivers/firmware/efi/arm-runtime.c                 | 135 +++++++++
 drivers/firmware/efi/efi.c                         |   2 +
 drivers/firmware/efi/libstub/Makefile              |   4 +-
 include/linux/hugetlb.h                            |   2 -
 include/linux/memblock.h                           |   8 +
 mm/memblock.c                                      |  28 ++
 54 files changed, 1234 insertions(+), 534 deletions(-)
 create mode 100644 Documentation/arm64/silicon-errata.txt
 create mode 100644 drivers/firmware/efi/arm-init.c
 create mode 100644 drivers/firmware/efi/arm-runtime.c
