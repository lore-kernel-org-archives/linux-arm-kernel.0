From: dave.long@linaro.org (David Long)
Date: Sat, 10 Jan 2015 23:03:15 -0500
Subject: [PATCH v4 0/6] arm64: Add kernel probes (kprobes) support
Message-ID: <1420949002-3726-1-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

This patchset is heavily based on Sandeepa Prabhu's ARM v8 kprobes patches, first
seen in October 2013. This version attempts to address concerns raised by
reviewers and also fixes problems discovered during testing, particularly during
SMP testing.

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

David A. Long (2):
  arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
  arm64: Add more test functions to insn.c

Sandeepa Prabhu (4):
  arm64: Kprobes with single stepping support
  arm64: Kprobes instruction simulation support
  arm64: Add kernel return probes support(kretprobes)
  kprobes: Add arm64 case in kprobe example module

 arch/arm64/Kconfig                       |   3 +
 arch/arm64/include/asm/insn.h            |  21 +-
 arch/arm64/include/asm/kprobes.h         |  61 +++
 arch/arm64/include/asm/probes.h          |  50 +++
 arch/arm64/include/asm/ptrace.h          |  32 +-
 arch/arm64/include/uapi/asm/ptrace.h     |  36 ++
 arch/arm64/kernel/Makefile               |   3 +
 arch/arm64/kernel/insn.c                 |  18 +
 arch/arm64/kernel/kprobes-arm64.c        | 161 +++++++
 arch/arm64/kernel/kprobes-arm64.h        |  30 ++
 arch/arm64/kernel/kprobes.c              | 692 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/kprobes.h              |  30 ++
 arch/arm64/kernel/probes-condn-check.c   | 122 ++++++
 arch/arm64/kernel/probes-simulate-insn.c | 174 ++++++++
 arch/arm64/kernel/probes-simulate-insn.h |  33 ++
 arch/arm64/kernel/ptrace.c               | 119 ++++++
 arch/arm64/kernel/vmlinux.lds.S          |   1 +
 samples/kprobes/kprobe_example.c         |   8 +
 18 files changed, 1591 insertions(+), 3 deletions(-)
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
