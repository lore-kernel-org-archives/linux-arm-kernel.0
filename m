From: panand@redhat.com (Pratyush Anand)
Date: Wed,  2 Nov 2016 14:40:40 +0530
Subject: [PATCH V3 0/6] ARM64: Uprobe support added
Message-ID: <cover.1478068479.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
* arm64 specific is_trap_insn() removed. Using default implementation.
* arch_uprobe_analyze_insn() returns -ENOTSUPP for 32bit task probe.

V2 was here: https://lkml.org/lkml/2016/9/27/58
Patches have been rebased on v4.9-rc3. They have been tested with mustang
and seattle platform for following test cases.

1. Step-able instructions, like sub, ldr, add etc.
2. Simulation-able like ret, cbnz, cbz etc.
3. uretprobe
4. Reject-able instructions like sev, wfe etc.
5. trapped and abort xol path
6. probe at unaligned user address.
7. longjump test cases

aarch32 task probing is not yet supported.

Pratyush Anand (6):
  arm64: kprobe: protect/rename few definitions to be reused by uprobe
  arm64: kgdb_step_brk_fn: ignore other's exception
  arm64: Handle TRAP_TRACE for user mode as well
  arm64: Handle TRAP_BRKPT for user mode as well
  arm64: introduce mm context flag to keep 32 bit task information
  arm64: Add uprobe support

 arch/arm64/Kconfig                      |   3 +
 arch/arm64/include/asm/cacheflush.h     |   1 +
 arch/arm64/include/asm/debug-monitors.h |   3 +
 arch/arm64/include/asm/elf.h            |  12 +-
 arch/arm64/include/asm/mmu.h            |   1 +
 arch/arm64/include/asm/probes.h         |  19 +--
 arch/arm64/include/asm/ptrace.h         |   8 ++
 arch/arm64/include/asm/thread_info.h    |   5 +-
 arch/arm64/include/asm/uprobes.h        |  36 ++++++
 arch/arm64/kernel/debug-monitors.c      |  40 +++---
 arch/arm64/kernel/kgdb.c                |   3 +
 arch/arm64/kernel/probes/Makefile       |   2 +
 arch/arm64/kernel/probes/decode-insn.c  |  32 ++---
 arch/arm64/kernel/probes/decode-insn.h  |   8 +-
 arch/arm64/kernel/probes/kprobes.c      |  36 +++---
 arch/arm64/kernel/probes/uprobes.c      | 216 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal.c              |   3 +
 arch/arm64/mm/flush.c                   |   2 +-
 18 files changed, 366 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm64/include/asm/uprobes.h
 create mode 100644 arch/arm64/kernel/probes/uprobes.c

-- 
2.7.4
