From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Apr 2013 10:12:31 +0100
Subject: [RFC PATCH 00/11] Topology bindings / Perf for big.LITTLE systems
Message-ID: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches implement perf support for big.LITTLE systems
(e.g. the A15x2 A7x3 coretile). The current implementation of one
virtual PMU across all CPUs is modified to have one virtual PMU per set
of compatible CPUs (e.g. one for the A15s, one for the A7s). Multiple
compatible clusters may be combined in one virtual PMU.

The affinity of these virtual PMUs is determined by the affinity of
interrupts for constituent physical PMUs. An interrupts-affinity
property is added to the PMU devicetree binding to handle this, which
refers to nodes in a topology description. When affinity information is
not provided, affinity information is determined in the same way as the
current implementation - interrupts are in order of (logical) cpu id,
and each is affine to a single CPU.

The topology description is necessary due to the lax nature of MPIDR
assignments in the wild, making them unsuitable in general for
determining the hierarchical structure of CPUs and clusters.

I've had a couple of previous attempts at representing this information in
devicetree [1,2], this series adds an example consumer (perf) and adds more
general infrastructure rather than limiting the use of the binding to
interrupts only.

Patches are based on v3.9-rc6.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/128205.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137290.html

Lorenzo Pieralisi (1):
  Documentation: DT: arm: define CPU topology bindings

Mark Rutland (10):
  arm: add functions to parse cpu affinity from dt
  arm: perf: clean up PMU names
  arm: perf: use IDR types for CPU PMUs
  arm: perf: make get_hw_events take arm_pmu
  arm: perf: dynamically allocate cpu hardware data
  arm: perf: treat PMUs as CPU affine
  arm: perf: probe number of counters on affine CPUs
  arm: perf: parse cpu affinity from dt
  arm: perf: allow multiple CPU PMUs to be registered
  arm: dts: add all PMUs for A15x2 A7x3 coretile

 Documentation/devicetree/bindings/arm/pmu.txt      |   7 +
 Documentation/devicetree/bindings/arm/topology.txt | 524 +++++++++++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  44 +-
 arch/arm/include/asm/dt_affinity.h                 |  12 +
 arch/arm/include/asm/pmu.h                         |   3 +-
 arch/arm/kernel/devtree.c                          | 139 ++++++
 arch/arm/kernel/perf_event.c                       |  32 +-
 arch/arm/kernel/perf_event_cpu.c                   | 270 ++++++++---
 arch/arm/kernel/perf_event_v6.c                    |  16 +-
 arch/arm/kernel/perf_event_v7.c                    |  55 ++-
 arch/arm/kernel/perf_event_xscale.c                |  20 +-
 arch/arm/oprofile/common.c                         |   8 +-
 12 files changed, 1004 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/topology.txt
 create mode 100644 arch/arm/include/asm/dt_affinity.h

-- 
1.8.1.1
