From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 24 Jul 2017 12:26:19 +0100
Subject: [PATCH 0/4] arm64: unwind: fix broken exception stack dump
Message-ID: <20170724112623.26109-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes an issue in the code that dumps the exception stack. As it
turns out, it doesn't display what we think it does. Please refer to
patch #3 for the details.

Patches #1 and #2 are preparatory patches. Patch #4 removes the sp
member from struct stackframe because it is broken and no longer
needed after patch #3.

Mark and I ran into this issue while working on the vmapped stacks code,
and so these changes are now prerequisites for it, especially given how
dealing with multiple stacks is simplified by these changes.

Ard Biesheuvel (3):
  arm64: unwind: disregard frame.sp when validating frame pointer
  arm64: unwind: reference pt_regs via embedded stack frame
  arm64: unwind: remove sp from struct stackframe

Mark Rutland (1):
  arm64: avoid percpu indirection for irq stack ops

 arch/arm64/include/asm/irq.h        | 39 +++++----------
 arch/arm64/include/asm/ptrace.h     |  1 +
 arch/arm64/include/asm/stacktrace.h |  1 -
 arch/arm64/kernel/asm-offsets.c     |  1 +
 arch/arm64/kernel/entry.S           | 16 +++---
 arch/arm64/kernel/perf_callchain.c  |  1 -
 arch/arm64/kernel/process.c         |  5 +-
 arch/arm64/kernel/ptrace.c          |  2 +-
 arch/arm64/kernel/return_address.c  |  1 -
 arch/arm64/kernel/stacktrace.c      | 51 ++------------------
 arch/arm64/kernel/time.c            |  1 -
 arch/arm64/kernel/traps.c           | 29 ++---------
 12 files changed, 33 insertions(+), 115 deletions(-)

-- 
2.9.3
