From: Nikolay.Borisov@arm.com (Nikolay Borisov)
Date: Tue, 13 May 2014 10:46:51 +0100
Subject: [PATCH 0/7] Fix handling of FP in THUMB2 mode
Message-ID: <1399974418-4995-1-git-send-email-Nikolay.Borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, most code which deals with stack unwinding relies on the fact 
that the frame pointer is stored in register R11. This is primary done via 
referencing the ARM_fp inside the pt_regs array as well as calling the 
thread_saved_fp macro. Unfortunately, this is not true in the case when 
the kernel is compiled in THUMB2 mode, since gcc uses exclusively R7 
to be the frame pointer. 


This patch series aims to rectify the situation in the following ways: 

 * Patch 1/7 Changes the way the thread_saved_fp macro is defined so that
 THUMB2 case is automatically handled. It has already been tested and reviewed. 
 
 * Patch 2/7 Introduces a new function - arm_get_current_stack_frame, which 
 just copies the appropriate registers from "struct pt_regs" into 
 "struct stackframe". This replaces several places where common code such 
 as "copy regs.{pc, lr, sp, fp} to frame.{pc, lr, sp, fp}" is present. It is
 implemented by using the newly-introduced frame_pointer(regs) macro which
 decides which register to extract based on the current kernel compile option
 (CONFIG_THUMB2_KERNEL).

 * Patches 3-5,7 Actualy "flip the switch" so that code can start
 using the new function. 

 * Patch 6/7 Introduces the correct changes in traps.c where only the
 * frame_pointer and not a full "struct stack" frame is being passed. 


Nikolay Borisov (7):
  ARM: Make thread_save_fp macro aware of THUMB2 mode
  ARM: Introduce arm_get_current_stack_frame()
  ARM: perf: Make perf use arm_get_current_stackframe
  ARM: time: Make use of arm_get_current_stackframe
  ARM: unwind: Use arm_get_current_stackframe
  ARM: traps: Make use of the frame_pointer macro
  ARM: oprofile: Use of arm_get_current_stackframe

 arch/arm/include/asm/ptrace.h      | 3 +++
 arch/arm/include/asm/stacktrace.h  | 5 +++++
 arch/arm/include/asm/thread_info.h | 6 ++++++
 arch/arm/kernel/perf_event.c       | 5 +----
 arch/arm/kernel/stacktrace.c       | 9 +++++++++
 arch/arm/kernel/time.c             | 5 +----
 arch/arm/kernel/traps.c            | 6 ++++--
 arch/arm/kernel/unwind.c           | 8 +++-----
 arch/arm/oprofile/common.c         | 5 +----
 9 files changed, 33 insertions(+), 19 deletions(-)

-- 
1.8.1.5
