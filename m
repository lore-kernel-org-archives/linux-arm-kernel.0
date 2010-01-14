From: jamie.iles@picochip.com (Jamie Iles)
Date: Thu, 14 Jan 2010 12:14:11 +0000
Subject: ARM perf events support v5
Message-ID: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is the 5th revision of the ARM performance events support. This initially
targets software events on all platforms and hardware events on v6 platforms
with hooks for later platforms to be added later.

Changes since the previous revison are:
	- compile fixes for systems without a pmu.
	- remove mutex from pmu.c and replace with bitset based lock
	- removal of BUG()'s and replace with warnings

Also required are:
	ARM: 5866/1: arm ptrace: use unsigned types for kernel pt_regs
	sched/perf: Make sure irqs are disabled for perf_event_task_sched_in()

Both of these can be found in tip/master.

Jamie Iles (5):
      arm: provide a mechanism to reserve performance counters
      arm/oprofile: reserve the PMU when starting
      arm: use the spinlocked, generic atomic64 support
      arm: enable support for software perf events
      arm/perfevents: implement perf event support for ARMv6

 arch/arm/Kconfig                        |   16 +
 arch/arm/include/asm/atomic.h           |    4 +
 arch/arm/include/asm/perf_event.h       |   31 +
 arch/arm/include/asm/pmu.h              |   75 ++
 arch/arm/kernel/Makefile                |    2 +
 arch/arm/kernel/perf_event.c            | 1342 +++++++++++++++++++++++++++++++
 arch/arm/kernel/pmu.c                   |  105 +++
 arch/arm/mm/fault.c                     |    7 +
 arch/arm/oprofile/op_model_arm11_core.c |    4 +-
 arch/arm/oprofile/op_model_arm11_core.h |    4 +-
 arch/arm/oprofile/op_model_mpcore.c     |   42 +-
 arch/arm/oprofile/op_model_v6.c         |   30 +-
 arch/arm/oprofile/op_model_v7.c         |   30 +-
 arch/arm/oprofile/op_model_v7.h         |    4 +-
 arch/arm/oprofile/op_model_xscale.c     |   35 +-
 15 files changed, 1667 insertions(+), 64 deletions(-)
