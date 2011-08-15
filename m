From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Aug 2011 14:55:01 +0100
Subject: [RFC PATCH 00/15] ARM: perf: support multiple PMUs
Message-ID: <1313416516-8006-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

System (AKA nest or uncore) PMUs exist on devices which are not affine
to a single CPU. They usually cannot be directly associated with
individual tasks and are asynchronous with respect to the current
execution. Examples of devices which could have system PMUs include L2
cache controllers, GPUs and memory buses.

The following patch series refactors the ARM PMU backend, enabling
new PMUs to reuse the existing code. This should allow for system PMUs
to be supported in future. Further work will be required to get perf to
fully understand system PMUs, but this provides something usable.

The framework is intended to be used by system PMUs which hang off core
platform components (e.g. L2 cache, AXI bus). If a device is complex
enough or separate enough from core functionality to have its own
driver, it should implement its own PMU handling using the core perf
API directly.

The first patch ("perf: provide PMU when initing events") is currently
sitting in the tip tree, but as it's required for event initialization
to function (and hence for the PMU to be usable), it's provided here
for convenience.

The series is based on Will Deacon's perf-updates branch at:
	git://linux-arm.org/linux-2.6-wd.git perf-updates

An example driver using the framework (supporting the PMU present in
L220/PL310 level 2 cache controllers) can be found at:
	git://linux-arm.org/linux-2.6-wd.git perf-l2x0-wip

Any comments would be welcome.

Thanks,
Mark.

Mark Rutland (15):
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

 arch/arm/include/asm/pmu.h          |   64 +++++++
 arch/arm/kernel/perf_event.c        |  318 +++++++++++++++++------------------
 arch/arm/kernel/perf_event_v6.c     |   73 ++++++---
 arch/arm/kernel/perf_event_v7.c     |   74 +++++---
 arch/arm/kernel/perf_event_xscale.c |   76 +++++----
 kernel/events/core.c                |    4 +-
 6 files changed, 359 insertions(+), 250 deletions(-)
