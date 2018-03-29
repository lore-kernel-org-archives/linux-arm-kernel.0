From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Mar 2018 15:13:21 +0200
Subject: [PATCH resend v2 0/2] preparatory arm64 asm patches for yielding the
 NEON
Message-ID: <20180329131323.15881-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RT people reported that the arm64 crypto NEON code behaves poorly in RT
context, because it disables preemption (to avoid having to context switch
the NEON registers) and usually processes the entire input in one go. When we
introduced this code, this was not unreasonable given the overhead of eager
preserve/restore, but today, there isn't that much overhead anymore, and so
we can consider approaches that have much better worst case scheduling latency.

Simply refactoring the code to only call into the core NEON transform one
block at a time results in a non-negligible performance impact, especially
on low end cores such as Cortex-A53 where memory accesses are relatively
costly. So instead, let's introduce some infrastructure to allow assembler
routines to do a conditional yield, i.e., check the TIF_NEED_RESCHED flag
after processing each block of input, and yield if it is set, in which case
some context may need to be preserved and restored, and or constant tables
reloaded.

Changes since v1:
- incorporate Dave's review feedback and add his Reviewed-bys
  . enhance non-nesting check in frame_push/_pop (#1)
  . describe cond_yield_neon convenience macro (#2)
  . discard yield sequence if CONFIG_PREEMPT=n (#2)
  . add missing include of linux/preempt.h (#2)

Patch #1 adds helper macros to create standard AAPCS stack frames. This is
needed because the assembler code will be modified to call into schedule()
[essentially], and so a stack frame is needed to preserve state.

Patch #2 adds helper macros to create the yielding code: check whether a
yield should be done, and preserve/restore the algorithm specific pieces
that will not be preserved across the yield in the NEON registers.

These patches have been broken out from the arm64/crypto series and resent
since they require careful review from the arm64 maintainers, rather than
pulled silently via the crypto tree (which already happened by accident and
got reverted)

Ard Biesheuvel (2):
  arm64: assembler: add utility macros to push/pop stack frames
  arm64: assembler: add macros to conditionally yield the NEON under
    PREEMPT

 arch/arm64/include/asm/assembler.h | 136 ++++++++++++++++++++
 arch/arm64/kernel/asm-offsets.c    |   3 +
 2 files changed, 139 insertions(+)

-- 
2.11.0
