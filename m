From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Dec 2011 14:57:47 +0000
Subject: [RFC PATCH v2 0/6] ARM: Remove the __ARCH_WANT_INTERRUPTS_ON_CTXSW
 definition
Message-ID: <1324306673-4282-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is version 2 of the set of patches for removing
__ARCH_WANT_INTERRUPTS_ON_CTXSW on ARM. The series was updated to allow
for the pgd switch not to be deferred if switch_mm() is called with
interrupts enabled. This is required for cases where switch_mm() is
called directly (currently from use_mm() and idle_task_exit()) without a
corresponding finish_arch_post_lock_switch() call. The original changes
to activate_mm() were also reverted since switch_mm() can do the actual
pgd switch when the interrupts are enabled.

If there are no objections, I'd like to push the series to -next to get
more exposure (the patches are aimed for 3.4-rc1 unless other issues are
found in the meantime).


The original series description:

This set of patches removes the use of __ARCH_WANT_INTERRUPTS_ON_CTXSW
on ARM.

As a background, the ARM architecture versions consist of two main sets
with regards to the MMU switching needs:

1. ARMv5 and earlier have VIVT caches and they require a full cache and
   TLB flush at every context switch.
2. ARMv6 and later have VIPT caches and the TLBs are tagged with an ASID
   (application specific ID). The number of ASIDs is limited to 256 and
   the allocation algorithm requires IPIs when all the ASIDs have been
   used.

Both cases above require interrupts enabled during context switch for
latency reasons (1) or deadlock avoidance (2).

The first patch in the series introduces a new scheduler hook invoked
after the rq->lock is released and interrupts enabled. The subsequent
two patches change the ARM context switching code (for processors in
category 2 above) to use a reserved TTBR value instead of a reserved
ASID. The 4th patch removes the __ARCH_WANT_INTERRUPTS_ON_CTXSW
definition for ASID-capable processors by deferring the new ASID
allocation to the post-lock switch hook.

The last patch also removes __ARCH_WANT_INTERRUPTS_ON_CTXSW for ARMv5
and earlier processors. It defers the cpu_switch_mm call to the
post-lock switch hook. Since this is only running on UP systems and the
preemption is disabled during context switching, it assumes that the old
mm is still valid until the post-lock switch hook.

The series has been tested on Cortex-A9 (vexpress) and ARM926
(versatile). Comments are welcome.

Thanks,

Catalin


Catalin Marinas (4):
  sched: Introduce the finish_arch_post_lock_switch() scheduler hook
  ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on ASID-capable CPUs
  ARM: Remove current_mm per-cpu variable
  ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on pre-ARMv6 CPUs

Will Deacon (2):
  ARM: Use TTBR1 instead of reserved context ID
  ARM: Allow ASID 0 to be allocated to tasks

 arch/arm/include/asm/mmu_context.h |  103 +++++++++++++++++++++++++++---------
 arch/arm/include/asm/system.h      |    7 ---
 arch/arm/include/asm/thread_info.h |    1 +
 arch/arm/mm/context.c              |   40 ++++++--------
 arch/arm/mm/proc-v7.S              |    9 +---
 kernel/sched.c                     |    4 ++
 6 files changed, 103 insertions(+), 61 deletions(-)
