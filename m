From: dave.long@linaro.org (David Long)
Date: Mon, 20 Apr 2015 16:19:41 -0400
Subject: [PATCH v6 0/6] arm64: Add kernel probes (kprobes) support
Message-ID: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

This patchset is heavily based on Sandeepa Prabhu's ARM v8 kprobes patches,
first seen in October 2013. This version attempts to address concerns raised by
reviewers and also fixes problems discovered during testing.

This patchset adds support for kernel probes(kprobes), jump probes(jprobes)
and return probes(kretprobes) support for ARM64.

The kprobes mechanism makes use of software breakpoint and single stepping
support available in the ARM v8 kernel.

Changes since v2 include:

1) Removal of NOP padding in kprobe XOL slots. Slots are now exactly one
instruction long.
2) Disabling of interrupts during execution in single-step mode.
3) Fixing of numerous problems in instruction simulation code (mostly
thanks to Will Cohen).
4) Support for the HAVE_REGS_AND_STACK_ACCESS_API feature is added, to allow
access to kprobes through debugfs.
5) kprobes is *not* enabled in defconfig.
6) Numerous complaints from checkpatch have been cleaned up, although a couple
remain as removing the function pointer typedefs results in ugly code.

Changes since v3 include:

1) Remove table-driven instruction parsing and replace with an if statement
calling out to old and new instruction test functions in insn.c.
2) I removed the addition of orig_x0 to ptrace.h.
3) Reorder the patches.
4) Replace the previous interrupt disabling (from Will Cohen) with
an improved solution (from Steve Capper).

Changes since v4 include:

1) Added insn.c functions to detect exception instructions and DAIF
   read/write instructions, and use them to reject probing same.
2) Changed adr detect function to also recognize adrp. Reject both.
3) Added missing __kprobes for some new functions.
4) Added call to kprobes_fault_handler from mm do_page_fault.
5) Reject all non-simulated branch/ret instructions, not just those
   that use an immediate offset.
6) Moved software breakpoint definitions into debug-monitors.h.
7) Removed "!XIP_KERNEL" from Kconfig.
8) changed kprobes_condition_check_t and kprobes_prepare_t to probes_*,
   for future sharing with uprobes.
9) Removed bogus call to kprobes_restore_local_irqflag() from 
   trampoline_probe_handler().

Changes since v5 include:

1) Replaced installation of breakpoint hook with direct call from the
handlers in debug-monitors.c, as requested.
2) Reject probing of instructions that read the interrupt mask, in
addition to instructions that set it.
3) Cleaned up comments describing usage of Debug Mask.
4) Added KPROBE_REENTER case in reenter_kprobe.
5) Corrected the ifdef'd definitions for notify_page_fault() to be
consistent when KPROBES is not configed.
6) Changed "cpsr" to "pstate" for HAVE_REGS_AND_STACK_ACCESS_API feature.
7) Added back in missing new files in previous patch.
8) Changed two instances of pr_warning() to pr_warn().

Note that there seems to be at least a potential issue with kprobes
on multiple (possibly all) platforms having to do with use of kfree
inside of the kretprobes trampoline handler.  This has manifested
occasionally in systemtap testing on arm64.  There does not appear to
be an simple solution to the problem.

David A. Long (2):
  arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
  arm64: Add more test functions to insn.c

Sandeepa Prabhu (4):
  arm64: Kprobes with single stepping support
  arm64: kprobes instruction simulation support
  arm64: Add kernel return probes support (kretprobes)
  kprobes: Add arm64 case in kprobe example module

 arch/arm64/Kconfig                       |   3 +
 arch/arm64/include/asm/debug-monitors.h  |   5 +
 arch/arm64/include/asm/insn.h            |  18 +
 arch/arm64/include/asm/kprobes.h         |  63 +++
 arch/arm64/include/asm/probes.h          |  50 +++
 arch/arm64/include/asm/ptrace.h          |  32 +-
 arch/arm64/include/uapi/asm/ptrace.h     |  36 ++
 arch/arm64/kernel/Makefile               |   3 +
 arch/arm64/kernel/debug-monitors.c       |  35 +-
 arch/arm64/kernel/insn.c                 |  28 ++
 arch/arm64/kernel/kprobes-arm64.c        | 166 ++++++++
 arch/arm64/kernel/kprobes-arm64.h        |  30 ++
 arch/arm64/kernel/kprobes.c              | 676 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/kprobes.h              |  24 ++
 arch/arm64/kernel/probes-condn-check.c   | 122 ++++++
 arch/arm64/kernel/probes-simulate-insn.c | 174 ++++++++
 arch/arm64/kernel/probes-simulate-insn.h |  33 ++
 arch/arm64/kernel/ptrace.c               | 116 ++++++
 arch/arm64/kernel/vmlinux.lds.S          |   1 +
 arch/arm64/mm/fault.c                    |  25 ++
 samples/kprobes/kprobe_example.c         |   8 +
 21 files changed, 1637 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/kprobes.h
 create mode 100644 arch/arm64/include/asm/probes.h
 create mode 100644 arch/arm64/kernel/kprobes-arm64.c
 create mode 100644 arch/arm64/kernel/kprobes-arm64.h
 create mode 100644 arch/arm64/kernel/kprobes.c
 create mode 100644 arch/arm64/kernel/kprobes.h
 create mode 100644 arch/arm64/kernel/probes-condn-check.c
 create mode 100644 arch/arm64/kernel/probes-simulate-insn.c
 create mode 100644 arch/arm64/kernel/probes-simulate-insn.h

-- 
1.8.1.2
