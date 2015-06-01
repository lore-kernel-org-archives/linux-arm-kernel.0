From: will.deacon@arm.com (Will Deacon)
Date: Mon, 1 Jun 2015 11:50:31 +0100
Subject: [GIT PULL] ARM perf updates for 4.2
Message-ID: <20150601105031.GH1641@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please can you pull the following ARM perf updates for 4.2?

There's quite a lot here, most of it from Mark Rutland, who has been
working on big.LITTLE PMU support for a while now. His work also brings
us significantly closer to moving the bulk of the CPU PMU driver out
into drivers/, where it can be shared with arm64.

As part of this work, there is a small patch to perf/core, which has
been Acked-by PeterZ and doesn't conflict with tip/perf/core at present.
I've kept that patch on a separate branch, merged in here, so that the
tip guys can pull it too if any unexpected issues crop up.

Please note that there is a conflict with mainline, since we remove
perf_event_cpu.c. The correct resolution is also to remove the file,
since the changes there are already reflected in the rework (and this
resolution is already included in linux-next).

Any issues, just shout.

Cheers,

Will

--->8

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/perf

for you to fetch changes up to 74cf0bc75f1671b8da3b2e6ef7b2dc75cab0016a:

  arm: perf: unify perf_event{,_cpu}.c (2015-05-28 17:13:26 +0100)

----------------------------------------------------------------
Hou Pengyang (1):
      arm: perf: Fix callchain parse error with kernel tracepoint events

Mark Rutland (12):
      perf: allow for PMU-specific event filtering
      arm: perf: make of_pmu_irq_cfg take arm_pmu
      arm: perf: treat PMUs as CPU affine
      arm: perf: filter unschedulable events
      arm: perf: probe number of counters on affine CPUs
      arm: perf: remove singleton PMU restriction
      arm: perf: kill off unused pm callbacks
      arm: perf: share arm_pmu_device_probe
      arm: perf: factor out xscale pmu driver
      arm: perf: factor out armv6 pmu driver
      arm: perf: factor out armv7 pmu driver
      arm: perf: unify perf_event{,_cpu}.c

Will Deacon (1):
      Merge branch 'perf/core' into perf/updates

 arch/arm/include/asm/perf_event.h   |   7 +
 arch/arm/include/asm/pmu.h          |  19 +-
 arch/arm/kernel/Makefile            |   4 +-
 arch/arm/kernel/perf_event.c        | 408 ++++++++++++++++++++++++++++++++---
 arch/arm/kernel/perf_event_cpu.c    | 415 ------------------------------------
 arch/arm/kernel/perf_event_v6.c     |  49 +++--
 arch/arm/kernel/perf_event_v7.c     | 129 ++++++-----
 arch/arm/kernel/perf_event_xscale.c |  32 ++-
 include/linux/perf_event.h          |   5 +
 kernel/events/core.c                |   8 +-
 10 files changed, 527 insertions(+), 549 deletions(-)
 delete mode 100644 arch/arm/kernel/perf_event_cpu.c
