From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2018 19:45:00 +0000
Subject: [PATCH 0/2] arm64: Only call into preempt_schedule() if need_resched()
Message-ID: <1543347902-21170-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This pair of patches improves our preempt_enable() implementation slightly
on arm64 by making the resulting call to preempt_schedule() conditional
on need_resched(), which is tracked in bit 32 of the preempt count. The
logic is inverted so that we can detect the preempt count going to zero
and need_resched being set with a single CBZ instruction.

Consequently, our preempt_enable() code (including prologue/epilogue)
goes from:

  40:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
  44:   910003fd        mov     x29, sp
  48:   d5384101        mrs     x1, sp_el0
  4c:   b9401020        ldr     w0, [x1, #16]
  50:   51000400        sub     w0, w0, #0x1
  54:   b9001020        str     w0, [x1, #16]
  58:   350000a0        cbnz    w0, 6c
  5c:   f9400020        ldr     x0, [x1]
  60:   721f001f        tst     w0, #0x2
  64:   54000040        b.eq    6c // b.none
  68:   94000000        bl      0 <preempt_schedule>
  6c:   a8c17bfd        ldp     x29, x30, [sp], #16
  70:   d65f03c0        ret

to:

  40:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
  44:   910003fd        mov     x29, sp
  48:   d5384101        mrs     x1, sp_el0
  4c:   f9400820        ldr     x0, [x1, #16]
  50:   d1000400        sub     x0, x0, #0x1
  54:   b9001020        str     w0, [x1, #16]
  58:   b4000060        cbz     x0, 64 <will+0x24>
  5c:   a8c17bfd        ldp     x29, x30, [sp], #16
  60:   d65f03c0        ret
  64:   94000000        bl      0 <preempt_schedule>
  68:   a8c17bfd        ldp     x29, x30, [sp], #16
  6c:   d65f03c0        ret

Will

--->8

Will Deacon (2):
  preempt: Move PREEMPT_NEED_RESCHED definition into arch code
  arm64: preempt: Provide our own implementation of asm/preempt.h

 arch/arm64/include/asm/Kbuild        |  1 -
 arch/arm64/include/asm/preempt.h     | 78 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/thread_info.h | 13 +++++-
 arch/s390/include/asm/preempt.h      |  2 +
 arch/x86/include/asm/preempt.h       |  3 ++
 include/linux/preempt.h              |  3 --
 6 files changed, 95 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/include/asm/preempt.h

-- 
2.1.4
