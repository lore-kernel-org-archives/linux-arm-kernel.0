From: jglauber@cavium.com (Jan Glauber)
Date: Mon, 25 Sep 2017 14:34:55 +0200
Subject: [PATCH v10 0/7] Cavium ARM64 uncore PMU support
Message-ID: <20170925123502.17289-1-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for various PMU counters found on the Cavium ThunderX and
OcteonTx SoC.

The PMU driver provides common "uncore" functions to avoid code duplication
and support adding more device PMUs (like L2 cache) in the future.

Changes to v9:
- Fix build error in first EDAC patch
- Use alphabetic ordering in some places
- Store pmu name in struct pmu
- Use devm_*
- Remove mapping of LMC events, expose hardware event numbers
  directly
- Simplify event removal

Changes to v8:
- Wrapper for PCI devices

Jan Glauber (7):
  edac: thunderx: Remove suspend/resume support
  perf: export perf_event_update_userpage()
  edac,soc: thunderx: Add wrapper for EDAC LMC PCI device
  edac,soc: thunderx: Add wrapper for EDAC OCX PCI device
  perf: cavium: Support memory controller PMU counters
  perf: cavium: Support transmit-link PMU counters
  perf: cavium: Add Documentation

 Documentation/perf/cavium-pmu.txt |  75 +++++
 drivers/edac/Kconfig              |   3 +
 drivers/edac/thunderx_edac.c      |  92 +-----
 drivers/perf/Kconfig              |  15 +
 drivers/perf/Makefile             |   1 +
 drivers/perf/cavium_pmu.c         | 660 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/Kconfig               |   1 +
 drivers/soc/Makefile              |   1 +
 drivers/soc/cavium/Kconfig        |  14 +
 drivers/soc/cavium/Makefile       |   2 +
 drivers/soc/cavium/cavium_lmc.c   |  53 +++
 drivers/soc/cavium/cavium_ocx.c   |  49 +++
 include/linux/cpuhotplug.h        |   1 +
 include/linux/soc/cavium/lmc.h    |  12 +
 include/linux/soc/cavium/ocx.h    |  12 +
 kernel/events/core.c              |   1 +
 16 files changed, 913 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/perf/cavium-pmu.txt
 create mode 100644 drivers/perf/cavium_pmu.c
 create mode 100644 drivers/soc/cavium/Kconfig
 create mode 100644 drivers/soc/cavium/Makefile
 create mode 100644 drivers/soc/cavium/cavium_lmc.c
 create mode 100644 drivers/soc/cavium/cavium_ocx.c
 create mode 100644 include/linux/soc/cavium/lmc.h
 create mode 100644 include/linux/soc/cavium/ocx.h

-- 
2.9.0.rc0.21.g7777322
