From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Jul 2017 19:18:23 +0100
Subject: [PATCHv2 0/7] arm64: unwind: fix broken exception stack dump
Message-ID: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches correct our exception stack dumping code to correctly identify
frames associated with exceptions, for which there is a corresponding pt_regs.

Ard and I ran into these issues while working on vmap'd stacks, and these
patches will be a pre-requisite for overflow handling to function correctly.

This is a follow up to Ard's v1 [1]. I've pushed this out to my
arm64/exception-stack branch [2].

Since v1:
* Identify exception frames based on .entry.text
* Add ASM_BUG()
* Use BL to ensure all exception frames can be identified
* Minor fixups

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-July/520705.html
[2] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/exception-stack

Ard Biesheuvel (3):
  arm64: unwind: disregard frame.sp when validating frame pointer
  arm64: unwind: reference pt_regs via embedded stack frame
  arm64: unwind: remove sp from struct stackframe

Mark Rutland (4):
  arm64: Add ASM_BUG()
  arm64: consistently use bl for C exception entry
  arm64: move non-entry code out of .entry.text
  arm64: unwind: avoid percpu indirection for irq stack

 arch/arm64/include/asm/asm-bug.h    |  54 +++++++++++++++++
 arch/arm64/include/asm/assembler.h  |  11 ++++
 arch/arm64/include/asm/bug.h        |  35 +----------
 arch/arm64/include/asm/irq.h        |  39 ++++--------
 arch/arm64/include/asm/ptrace.h     |   1 +
 arch/arm64/include/asm/stacktrace.h |   1 -
 arch/arm64/include/asm/traps.h      |   5 ++
 arch/arm64/kernel/asm-offsets.c     |   1 +
 arch/arm64/kernel/entry.S           | 118 +++++++++++++++++++-----------------
 arch/arm64/kernel/perf_callchain.c  |   1 -
 arch/arm64/kernel/process.c         |   5 +-
 arch/arm64/kernel/ptrace.c          |   2 +-
 arch/arm64/kernel/return_address.c  |   1 -
 arch/arm64/kernel/stacktrace.c      |  54 ++---------------
 arch/arm64/kernel/time.c            |   1 -
 arch/arm64/kernel/traps.c           |  34 +++--------
 16 files changed, 162 insertions(+), 201 deletions(-)
 create mode 100644 arch/arm64/include/asm/asm-bug.h

-- 
1.9.1
