From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  7 Nov 2014 16:25:25 +0000
Subject: [PATCH 00/11] arm: perf: add support for heterogeneous PMUs
Message-ID: <1415377536-12841-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In systems with heterogeneous CPUs (e.g. big.LITTLE) the associated PMUs
also differ in terms of the supported set of events, the precise
behaviour of each of those events, and the number of event counters.
Thus it is not possible to expose these PMUs as a single logical PMU.

Instead a logical PMU is created per CPU microarchitecture, which events
can target directly:

$ perf stat \
  -e armv7_cortex_a7/config=0x11/ \
  -e armv7_cortex_a15/config=0x11/ \
  ./test

 Performance counter stats for './test':

           7980455      armv7_cortex_a7/config=0x11/                                    [27.29%]
           9947934      armv7_cortex_a15/config=0x11/                                    [72.66%]

       0.016734833 seconds time elapsed

This series is based atop of my recent preparatory rework [1,2].

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/295820.html
[2] https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/log/?h=perf/updates

Mark Rutland (11):
  of: Add empty of_get_next_parent stub
  perf: allow for PMU-specific event filtering
  arm: perf: treat PMUs as CPU affine
  arm: perf: filter unschedulable events
  arm: perf: reject multi-pmu groups
  arm: perf: probe number of counters on affine CPUs
  arm: perf: document PMU affinity binding
  arm: perf: add functions to parse affinity from dt
  arm: perf: parse cpu affinity from dt
  arm: perf: remove singleton PMU restriction
  arm: dts: vexpress: describe all PMUs in TC2 dts

 Documentation/devicetree/bindings/arm/pmu.txt | 104 +++++++-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts    |  36 ++-
 arch/arm/include/asm/pmu.h                    |  13 +
 arch/arm/kernel/perf_event.c                  |  61 ++++-
 arch/arm/kernel/perf_event_cpu.c              | 356 +++++++++++++++++++++-----
 arch/arm/kernel/perf_event_v7.c               |  41 +--
 include/linux/of.h                            |   5 +
 include/linux/perf_event.h                    |   5 +
 kernel/events/core.c                          |   8 +-
 9 files changed, 534 insertions(+), 95 deletions(-)

-- 
1.9.1
