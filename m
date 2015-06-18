From: panand@redhat.com (Pratyush Anand)
Date: Thu, 18 Jun 2015 09:28:47 +0530
Subject: [RFC PATCH V2 00/10] ARM64: Uprobe support added
Message-ID: <cover.1434598237.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches have been prepared on top of ARM64 kprobe v7 patches [1].
Keeping as RFC, because kprobe-v7 still need to be ACKed.

Unit test for following has been done so far and they have been found
working
    1. Step-able instructions, like sub, ldr, add etc.
    2. Simulation-able like ret.
    3. uretprobe
    4. Reject-able instructions like sev, wfe etc.
    5. trapped and abort xol path
    6. probe at unaligned user address.
    
    Currently it does not support aarch32 instruction probing.

RFC PATCH V1 is here [2].

Changes since V1:
===================
* Most of the part of V1-(1-2) have been merged into kprobe patches.
* V1 Patch-3 has been removed.
* Other patches have also been re-arranged.
* Patch-1 in this series does changes to make 'prepare' and 'handler'
function independent of 'struct kprobe', so that they can be reused for uprobe.
* Patch-2 fixes kgdb_step_brk_fn to ignore other's exception
* Patch3-8 are preparations for uprobe patch to work.
* Patch 9-10 is actual work for uprobe support

Other significant changes

* Now relying on uprobe_task->vaddr, and so removed saved_user_pc and
ss_ctx from struct arch_uprobe_task.
* irqs disabling around uprobe_pre/post_sstep_notifier removed.
* Now returning DBG_HOOK_HANDLED from breakpoint and step handler only
on success.
* Removed step_ctx logic.
* A comment for not supporting compat.
* unaligned address check in arch_uprobe_analyze_insn
* includes asm-generic/ptrace.h in asm/ptrace.h
* rename enum debug_el to enum debug_elx 

[1] http://marc.info/?l=linux-arm-kernel&m=143439540523827&w=2
[2] http://marc.info/?l=linux-arm-kernel&m=142003951103185&w=2

Pratyush Anand (9):
  arm64: kprobe: Make prepare and handler function independent of
    'struct kprobe'
  arm64: fix kgdb_step_brk_fn to ignore other's exception
  arm64: include asm-generic/ptrace.h in asm/ptrace.h
  arm64: Add helper for link pointer
  arm64: Re-factor flush_ptrace_access
  arm64: Handle TRAP_HWBRKPT for user mode as well
  arm64: Handle TRAP_BRKPT for user mode as well
  arm64: rename enum debug_el to enum debug_elx to fix "wrong kind of
    tag"
  arm64: Add uprobe support

Steve Capper (1):
  arm64: uprobes: check conditions before simulating instructions

 arch/arm64/Kconfig                       |   3 +
 arch/arm64/include/asm/debug-monitors.h  |   9 +-
 arch/arm64/include/asm/probes.h          |   6 +-
 arch/arm64/include/asm/ptrace.h          |  39 +++++-
 arch/arm64/include/asm/thread_info.h     |   5 +-
 arch/arm64/include/asm/uprobes.h         |  37 ++++++
 arch/arm64/kernel/Makefile               |   3 +
 arch/arm64/kernel/debug-monitors.c       |  59 +++++----
 arch/arm64/kernel/hw_breakpoint.c        |   6 +-
 arch/arm64/kernel/kgdb.c                 |   3 +
 arch/arm64/kernel/kprobes-arm64.c        |  33 ++---
 arch/arm64/kernel/kprobes.c              |  20 +--
 arch/arm64/kernel/probes-simulate-insn.c |  16 +--
 arch/arm64/kernel/signal.c               |   4 +-
 arch/arm64/kernel/uprobes.c              | 220 +++++++++++++++++++++++++++++++
 arch/arm64/mm/flush.c                    |  30 +++--
 16 files changed, 401 insertions(+), 92 deletions(-)
 create mode 100644 arch/arm64/include/asm/uprobes.h
 create mode 100644 arch/arm64/kernel/uprobes.c

-- 
2.1.0
