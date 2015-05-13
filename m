From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 May 2015 17:12:22 +0100
Subject: [PATCH 0/7] ARM: perf: heterogeneous PMU support
Message-ID: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series (based on v4.1-rc2) implements multi-PMU support for 32-bit
ARM systems, allowing all CPU PMUs to be used in big.LITTLE
configurations. Later series will factor out the core code to drivers,
and migrate the arm64 perf code over to this shared core.

PMUs for different microarchitectures are different, with differing
numbers of counters, sets of supported events, and potentially differing
filtering features. Due to this, it is not possible to provide access to
all PMU features through a unified interface.

Instead, this series provides a logical PMU for each microarchitecture,
which provides events for a subset of CPUs in the system. Events are
allowed to migrate between CPUs of the same microarchitecture, but are
filtered before they can be scheduled on other CPUs. Each logical PMU
rejects CPU-bound events for CPUs of other microarchtiectures.

On an example system (TC2), two CPU PMUs can be seen under sysfs:

$ ls /sys/bus/event_source/devices/
armv7_cortex_a15  armv7_cortex_a7  breakpoint  software

Each PMU is given a dynamic (IDR) type that userspace tools can query
from sysfs, and events can be opened on multiple PMUs concurrently, but
will only be scheduled on the relevant CPUs:

$ perf stat -e armv7_cortex_a15/config=0x11/ -e armv7_cortex_a7/config=0x11/ ./spin

 Performance counter stats for './spin':

        2225274713 armv7_cortex_a15/config=0x11/                                    [18.54%]
        1780299356 armv7_cortex_a7/config=0x11/                                    [81.46%]

       2.233095584 seconds time elapsed

Currently events of PERF_TYPE_HARDWARE are routed to an arbitrary PMU,
as the perf core code simply iterates over the list of registered PMUs
until it finds some capable PMU. This means that unless the user
explicitly asks for events on all PMUs, events will not be counted all
of the time:

$ perf stat -e cycles ./spin

 Performance counter stats for './spin':

         763938622 cycles                    [59.12%]

       0.965428917 seconds time elapsed

$ perf stat -e cycles ./spin

 Performance counter stats for './spin':

     <not counted> cycles                  

       0.154772375 seconds time elapsed

It should be possible for the perf tool to detect heterogeneous PMUs via
sysfs, at which point it can open events on each logical PMU. As perf
top opens events on individual CPUs, these are routed to the appropriate
logical PMUs by the nature of the current logic in the core perf code.

Thanks,
Mark.

Mark Rutland (7):
  perf: allow for PMU-specific event filtering
  arm: perf: make of_pmu_irq_cfg take arm_pmu
  arm: perf: treat PMUs as CPU affine
  arm: perf: filter unschedulable events
  arm: perf: probe number of counters on affine CPUs
  arm: perf: remove singleton PMU restriction
  arm: dts: vexpress: describe all PMUs in TC2 dts

 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 14 ++++++++-
 arch/arm/include/asm/pmu.h                 |  1 +
 arch/arm/kernel/perf_event.c               | 38 +++++++++++++++++++++++
 arch/arm/kernel/perf_event_cpu.c           | 49 +++++++++++++++++-------------
 arch/arm/kernel/perf_event_v7.c            | 48 ++++++++++++++---------------
 include/linux/perf_event.h                 |  5 +++
 kernel/events/core.c                       |  8 ++++-
 7 files changed, 115 insertions(+), 48 deletions(-)

-- 
1.9.1
