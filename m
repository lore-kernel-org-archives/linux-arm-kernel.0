From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Sep 2011 22:06:15 +0100
Subject: [GIT PULL] Perf, PMU and hw_breakpoint updates for 3.2
Message-ID: <20110901210614.GA5209@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull these perf/pmu/hw_breakpoint updates for 3.2. Note that the
patch entitled "perf: provide PMU when initing events" is a cherry-pick
from tip/master.

I would have waited until -rc5 to send this, but I'm on holiday without
internet for the next couple of weeks. Instead this is taken against
the recent merge commit of your fixes branch by Linus.

Thanks,

Will


The following changes since commit 90e93648c41bd29a72f6ec55ce27a23c209eab8c:

  Merge branch 'fixes' of master.kernel.org:/home/rmk/linux-2.6-arm (2011-08-29 16:34:07 -0700)

are available in the git repository at:

  git://linux-arm.org/linux-2.6-wd.git for-rmk

Mark Rutland (17):
      ARM: perf: de-const struct arm_pmu
      perf: provide PMU when initing events
      ARM: perf: only register a CPU PMU when present
      ARM: perf: clean up event group validation
      ARM: perf: remove active_mask
      ARM: perf: move active_events into struct arm_pmu
      ARM: perf: move platform device to struct arm_pmu
      ARM: perf: indirect access to cpu_hw_events
      ARM: perf: remove unnecessary armpmu->stop
      ARM: perf: lock PMU registers per-CPU
      ARM: perf: add type field to struct arm_pmu
      ARM: perf: refactor event mapping
      ARM: perf: add support for multiple PMUs
      ARM: perf: remove event limit from pmu_hw_events
      ARM: perf: remove cpu-related misnomers
      ARM: perf: move arm_pmu into <asm/pmu.h>
      ARM: perf: Remove unnecessary armpmu->enable()s

Will Deacon (15):
      ARM: PMU: move CPU PMU platform device handling and init into perf
      ARM: perf: use cpumask_t to record active IRQs
      ARM: perf: use u32 instead of unsigned long for PMNC register
      ARM: perf: use integers for ARMv7 event indices
      ARM: perf: index ARMv7 event counters starting from zero
      ARM: perf: index Xscale and ARMv6 event counters starting from zero
      ARM: perf: index PMU registers from zero
      ARM: perf: allow armpmu to implement mode exclusion
      ARM: perf: add mode exclusion for Cortex-A15 PMU
      ARM: hw_breakpoint: add initial Cortex-A15 (debug v7.1) support
      ARM: hw_breakpoint: reserve one breakpoint for watchpoint stepping
      ARM: hw_breakpoint: add support for multiple watchpoints
      ARM: hw_breakpoint: trap undef instruction exceptions in reset_ctrl_regs
      ARM: hw_breakpoint: reduce the number of WARN_ONCE invocations
      Merge branches 'hwbreak', 'perf/updates' and 'perf/system-pmus' into for-rmk

 arch/arm/include/asm/hw_breakpoint.h |    2 +
 arch/arm/include/asm/pmu.h           |   93 ++++++--
 arch/arm/kernel/hw_breakpoint.c      |  270 ++++++++++++--------
 arch/arm/kernel/perf_event.c         |  475 ++++++++++++++++++----------------
 arch/arm/kernel/perf_event_v6.c      |   87 +++++--
 arch/arm/kernel/perf_event_v7.c      |  395 ++++++++++++++--------------
 arch/arm/kernel/perf_event_xscale.c  |   90 ++++---
 arch/arm/kernel/pmu.c                |  182 +-------------
 kernel/events/core.c                 |    4 +-
 9 files changed, 807 insertions(+), 791 deletions(-)
