From: jglauber@cavium.com (Jan Glauber)
Date: Fri, 23 Jun 2017 15:01:25 +0200
Subject: [PATCH v6 0/3] Cavium ARM64 uncore PMU support
Message-ID: <20170623130128.11006-1-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for various PMU counters found on the Cavium ThunderX and
OcteonTx SoC.

The driver provides common "uncore" functions to avoid code duplication and
support adding more device PMUs (like L2 cache) in the future.

Probe and removal of the PMUs is done by hooking into the ThunderX EDAC
driver as this driver owns all the PCI devices containing the PMU counters.

Patches are on top of 4.12-rc6.

Changes to v5:
- Only allow built-in CONFIG_CAVIUM_PMU
- Drop unneeded export of perf_event_update_userpage()
- Simplify callbacks in edac code, move CONFIG_CAVIUM_PMU check
  to header file
- Fix some sparse static warnings
- Add documentation
- Fix OCX TLK event_valid check
- Add group validation in event_init
- Add a guard variable to prevent calling init twice
- Use kasprintf and fix pmu name allocation
- Remove unneeded check for embedded pmu
- Loop around local64_cmpxchg
- Simplify cvm_pmu_lmc_event_valid
- Fix list_add error case

Jan Glauber (3):
  perf: cavium: Support memory controller PMU counters
  perf: cavium: Support transmit-link PMU counters
  perf: cavium: Add Documentation

 Documentation/perf/cavium-pmu.txt |  74 +++++
 drivers/edac/thunderx_edac.c      |  13 +-
 drivers/perf/Kconfig              |   9 +
 drivers/perf/Makefile             |   1 +
 drivers/perf/cavium_pmu.c         | 643 ++++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h        |   1 +
 include/linux/perf/cavium_pmu.h   |  54 ++++
 7 files changed, 794 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/perf/cavium-pmu.txt
 create mode 100644 drivers/perf/cavium_pmu.c
 create mode 100644 include/linux/perf/cavium_pmu.h

-- 
2.9.0.rc0.21.g7777322
