From: panand@redhat.com (Pratyush Anand)
Date: Tue, 27 Sep 2016 13:13:34 +0530
Subject: [PATCH V2 0/6] ARM64: Uprobe support added
Message-ID: <cover.1474960629.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
* Exposed sync_icache_aliases() and used that in stead of flush_uprobe_xol_access()
* Assigned 0x0005 to BRK64_ESR_UPROBES in stead of 0x0008
* moved uprobe_opcode_t from probes.h to uprobes.h
* Assigned 4 to TIF_UPROBE instead of 5
* Assigned AARCH64_INSN_SIZE to UPROBE_SWBP_INSN_SIZE instead of hard code 4.
* Removed saved_fault_code from struct arch_uprobe_task
* Removed preempt_dis(en)able() from arch_uprobe_copy_ixol()
* Removed case INSN_GOOD from arch_uprobe_analyze_insn()
* Now we do check that probe point is not for a 32 bit task.
* Return a false positive from is_tarp_insn()
* Changes for rebase conflict resolution

V1 was here: https://lkml.org/lkml/2016/8/2/29
Patches have been rebased on next-20160927, so that there would be no
conflicts with other arm64/for-next/core patches.

Patches have been tested for following:
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
 arch/arm64/kernel/probes/uprobes.c      | 221 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal.c              |   3 +
 arch/arm64/mm/flush.c                   |   2 +-
 18 files changed, 371 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm64/include/asm/uprobes.h
 create mode 100644 arch/arm64/kernel/probes/uprobes.c

-- 
2.7.4
