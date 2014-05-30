From: nikolay.borisov@arm.com (Nikolay Borisov)
Date: Fri, 30 May 2014 17:59:44 +0100
Subject: [PATCH v2 0/7] Fix backtrace support in THUMB2 mode
Message-ID: <1401469191-29232-1-git-send-email-nikolay.borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nikolay Borisov <Nikolay.Borisov@arm.com>

Currently all the code which deals with backtrace support assumes that R11
is the frame-pointer. While this is the case for ARM mode and is explicitly
documented in the AAPCS, this is not the case for THUMB2 mode.

There is no official document requiring that R11 has to be the frame pointer
and GCC uses R7 as FP and given that R7's usage is so intertwined within GCC's
mechanics it is unlikely to change, so fixing backtrace in THUMB2 mode seems
in order.

This patch series rectifies the problem by first fixing the
thread_save_fp macro to reference the correct register. Furthermore, there
a lot of repetetive sequences of code such as :

stackframe.fp = pt_regs->ARM_fp
stackframe.lr = pt_regs->ARM_lr

so introducing a function arm_get_current_stack_frame which both
hides this repetition and also utilizes teh frame_pointer(regs) macro
to reference the correct register depending on the mode.

Finally, change all the call sites so that they utilize the new routine.

Changes since v1:
 * Nothing major, just made arg_get_current_stack frame an inline routine.

Nikolay Borisov (7):
  ARM: Make thread_save_fp macro aware of THUMB2 mode
  ARM: Introduce arm_get_current_stack_frame()
  ARM: perf: Make perf use arm_get_current_stackframe
  ARM: time: Make use of arm_get_current_stackframe
  ARM: unwind: Use arm_get_current_stackframe
  ARM: traps: Make use of the frame_pointer macro
  ARM: oprofile: Use of arm_get_current_stackframe

 arch/arm/include/asm/ptrace.h      |  6 ++++++
 arch/arm/include/asm/stacktrace.h  | 12 ++++++++++++
 arch/arm/include/asm/thread_info.h |  6 ++++++
 arch/arm/kernel/perf_event.c       |  5 +----
 arch/arm/kernel/time.c             |  5 +----
 arch/arm/kernel/traps.c            |  6 ++++--
 arch/arm/kernel/unwind.c           |  8 +++-----
 arch/arm/oprofile/common.c         |  5 +----
 8 files changed, 34 insertions(+), 19 deletions(-)

-- 
1.8.1.5
