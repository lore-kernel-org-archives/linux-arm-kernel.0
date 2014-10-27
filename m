From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Oct 2014 12:06:30 +0000
Subject: [PATCHv2 0/9] Prepatory rework for multi-PMU support.
Message-ID: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series performs inital preparation for big.LITTLE perf support. It
depends on the CCI rework posted previously [1], as the removal of
get_hw_events and the percpu rework is incompatible with the single
global set of events the CCI has.

Since v1 [2]:

* Added cpu_pmu_destroy to clean up dynamically allocated data and cpu
  notifiers in failure paths. Due to this change I've dropped the
  existing tags from patches 8 and 9.

* Make pmu_probe_table const.

* Removed the unintentional newline change from patch 3, and added a new
  patch to make format strings use newlines consistently.

* In patch 4 the armpmu_map_event type variable remains an int, but the
  (redundant) check against PERF_TYPE_MAX is removed such that it is
  only used for an equality check, as per [3].

As a result of this series:

* The callchain handling is split from the PMU driver, as with metag,
  powerpc, sh, and x86. This enables callchain handling for software
  events when the kernel is built without CONFIG_HW_PERF_EVENTS.

* Legacy MIDR-based PMU probing is factored into a table that a
  subsequent series will split into separate drivers. On its own this
  should not result in a behavioural change.

* The ARM PMU accounting structures are reorganised and absorbed by
  struct arm_pmu, which will make possible the allocation and management
  of multiple PMUs in a later patch series.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/295509.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/295820.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296088.html

Mark Rutland (9):
  arm: perf: factor out callchain code
  arm: perf: add missing pr_info newlines
  arm: perf: make PMU probing data-driven
  arm: perf: use IDR types for CPU PMUs
  arm: perf: limit size of accounting data
  arm: perf: kill get_hw_events()
  arm: perf: fold percpu_pmu into pmu_hw_events
  arm: perf: dynamically allocate cpu hardware data
  arm: perf: fold hotplug notifier into arm_pmu

 arch/arm/include/asm/perf_event.h   |   2 +-
 arch/arm/include/asm/pmu.h          |  36 +++++++-
 arch/arm/kernel/Makefile            |   2 +-
 arch/arm/kernel/perf_callchain.c    | 137 +++++++++++++++++++++++++++
 arch/arm/kernel/perf_event.c        | 162 ++++----------------------------
 arch/arm/kernel/perf_event_cpu.c    | 179 ++++++++++++++++++------------------
 arch/arm/kernel/perf_event_v6.c     |  12 +--
 arch/arm/kernel/perf_event_v7.c     |  14 +--
 arch/arm/kernel/perf_event_xscale.c |  20 ++--
 9 files changed, 301 insertions(+), 263 deletions(-)
 create mode 100644 arch/arm/kernel/perf_callchain.c

-- 
1.9.1
