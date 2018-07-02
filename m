From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  2 Jul 2018 22:59:41 +0100
Subject: [PATCH v4 0/7] arm64: perf: Support for chained counters
Message-ID: <1530568788-26458-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series adds support for counting PMU events using 64bit counters
for arm64 PMU.

The Arm v8 PMUv3 supports combining two adjacent 32bit counters
(low even and hig odd counters) to count a given "event" in 64bit mode.
This series adds the support for 64bit events in the core arm_pmu driver
infrastructure and adds the support for armv8 64bit kernel PMU to use
chained counters to count in 64bit mode. For CPU cycles, we use the cycle
counter in 64bit mode, only when requested. If the cycle counter is not
available, we fall back to chaining the counters.

Tested on Juno, Fast models. Applies on 4.18-rc3

Changes since v3:
 - Rename format string "bits64" => "long"
 - Add clear_event_idx call back for all PMU backends
 - Address style comments
 - Add Acked-by's

Changes since v2:
 - Clean up select counter routine. (Mark Rutland)
 - Stop PMU while processing overflows (Mark Rutland)
 - Drop special allocation algorithm for chain indices
 - Since we access the counters when the PMU is stopped,
   get rid of the unncessary barriers.
 - Ensure a counter is allocated when checking for chained event

Change since v1:
 - Remove unnecessary isb()s in chain counter reads/writes
 - Fix event programming order for counters
 - Tighten chain counter event read sequence
 - Set chain event to count in all ELs
 - Cleanup helpers to be consistent
 - Fix build break on xcale PMU (reported by kbuild-robot)
 - Remove the explicit counter width field from pmu backends and default
   to 32bit.
 - Rename flag ARMPMU_EVT_LONG => ARMPMU_EVT_64BIT and
   the format string "chain" => "bits64". (Unfortunately we can't use "64bit"
   and I am open for suggestion on a better name)
 - Rename armpmu_get_event_max_period() => armpmu_event_max_period()
 - For 64bit CPU cycles events, allow chaining if cycle counter is
   not available.


Suzuki K Poulose (7):
  arm_pmu: Clean up maximum period handling
  arm_pmu: Change API to support 64bit counter values
  arm_pmu: Add support for 64bit event counters
  arm_pmu: Tidy up clear_event_idx call backs
  arm64: perf: Clean up armv8pmu_select_counter
  arm64: perf: Disable PMU while processing counter overflows
  arm64: perf: Add support for chaining event counters

 arch/arm/kernel/perf_event_v6.c     |  14 +-
 arch/arm/kernel/perf_event_v7.c     |  14 +-
 arch/arm/kernel/perf_event_xscale.c |  10 +-
 arch/arm64/kernel/perf_event.c      | 251 +++++++++++++++++++++++++++++-------
 drivers/perf/arm_pmu.c              |  42 +++---
 include/linux/perf/arm_pmu.h        |  11 +-
 6 files changed, 260 insertions(+), 82 deletions(-)

-- 
2.7.4
