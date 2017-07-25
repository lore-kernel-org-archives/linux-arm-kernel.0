From: jglauber@cavium.com (Jan Glauber)
Date: Tue, 25 Jul 2017 17:04:19 +0200
Subject: [PATCH v8 0/3] Cavium ARM64 uncore PMU support
Message-ID: <20170725150422.4775-1-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for various PMU counters found on the Cavium ThunderX and
OcteonTx SoC.

The driver provides common "uncore" functions to avoid code duplication and
support adding more device PMUs (like L2 cache) in the future.

Changes to v7:
- Check return code of kasprintf
- Check return code of ioremap
- Add some more comments
- Only call perf_pmu_register after event_init() assignment and list_add
- Various cosmetics

Changes to v6:
- Make driver stand-alone again without hooking into EDAC
- depend on ARCH_THUNDER

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

 Documentation/perf/cavium-pmu.txt |  75 +++++
 drivers/perf/Kconfig              |   8 +
 drivers/perf/Makefile             |   1 +
 drivers/perf/cavium_pmu.c         | 646 ++++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h        |   1 +
 5 files changed, 731 insertions(+)
 create mode 100644 Documentation/perf/cavium-pmu.txt
 create mode 100644 drivers/perf/cavium_pmu.c

-- 
2.9.0.rc0.21.g7777322
