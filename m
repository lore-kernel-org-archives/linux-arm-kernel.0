From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Oct 2016 20:10:24 +0100
Subject: [PATCH 00/10] arm64: move thread_info off of the task stack
Message-ID: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Building atop of Andy's work on x86 and generic code, these patches move
arm64's thread_info off of the stack and into task_struct. This protects
thread_info from corruption in the face of stack overflow, and serves as
a step towards fully robust stack overflow handling, which will be
addressed by subsequent patches.

These patches are based atop of a preparatory series [1] (itself based
on v4.9-rc1) that's also necessary for s390. I've placed those patches
in a branch [2] on my kernel.org repo, along with this series [3]. I'm
hoping that the prep work will be able to become a stable branch/tag
soon.

I've given the series some light testing on a couple of SMP arm64
platforms, but this has yet to see a thorough beating; please do try to
make this fall over!

Since RFC [4]:
* Rely on prior patches to make thread_info arch-specific
* Make smp_processor_id() use a per-cpu variable
* Split out current_stack_pointer
* Make SMP actually work

[1] http://lkml.kernel.org/r/1476901693-8492-1-git-send-email-mark.rutland at arm.com
[2] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=core/ti-stack-split
[3] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=arm64/ti-stack-split
[4] http://lkml.kernel.org/r/1473947349-14521-1-git-send-email-mark.rutland at arm.com

Thanks,
Mark.

Mark Rutland (10):
  arm64: thread_info remove stale items
  arm64: asm-offsets: remove unused definitions
  arm64: factor out current_stack_pointer
  arm64: traps: simplify die() and __die()
  arm64: prep stack walkers for THREAD_INFO_IN_TASK
  arm64: move sp_el0 and tpidr_el1 into cpu_suspend_ctx
  arm64: smp: prepare for smp_processor_id() rework
  arm64: make cpu number a percpu variable
  arm64: assembler: introduce ldr_this_cpu
  arm64: split thread_info from task stack

 arch/arm64/Kconfig                     |  1 +
 arch/arm64/include/asm/Kbuild          |  1 -
 arch/arm64/include/asm/assembler.h     | 19 +++++++++++++++----
 arch/arm64/include/asm/current.h       | 22 ++++++++++++++++++++++
 arch/arm64/include/asm/percpu.h        |  2 ++
 arch/arm64/include/asm/perf_event.h    |  2 ++
 arch/arm64/include/asm/smp.h           |  7 ++++++-
 arch/arm64/include/asm/stack_pointer.h |  9 +++++++++
 arch/arm64/include/asm/suspend.h       |  2 +-
 arch/arm64/include/asm/thread_info.h   | 32 +-------------------------------
 arch/arm64/kernel/asm-offsets.c        |  3 +--
 arch/arm64/kernel/entry.S              |  6 +++---
 arch/arm64/kernel/head.S               | 11 ++++++-----
 arch/arm64/kernel/process.c            | 33 +++++++++++++++++++++++++++------
 arch/arm64/kernel/return_address.c     |  1 +
 arch/arm64/kernel/sleep.S              |  3 ---
 arch/arm64/kernel/smp.c                | 14 +++++++++++---
 arch/arm64/kernel/stacktrace.c         |  6 ++++++
 arch/arm64/kernel/suspend.c            |  6 ------
 arch/arm64/kernel/traps.c              | 14 +++++++-------
 arch/arm64/mm/proc.S                   |  6 ++++++
 21 files changed, 127 insertions(+), 73 deletions(-)
 create mode 100644 arch/arm64/include/asm/current.h
 create mode 100644 arch/arm64/include/asm/stack_pointer.h

-- 
1.9.1
