From: anurupvasu@gmail.com (Anurup M)
Date: Tue, 28 Jun 2016 05:50:21 -0400
Subject: [PATCH 0/8] arm64:perf: Support for Hisilicon SoC Hardware event
 counters
Message-ID: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide Support for Hisilicon SoC Hardware event counters.
The Hisilicon SoC Hi161x series has many uncore or non-CPU performance
events and counters units.

This patch is implemented refering to arm-cci, Intel/AMD uncore and
also the cavium thunderX pmu patches.

Support for Hisilicon L3 cache(LLC) hardware events and counters are added
in this implementation.

The Hisilicon PMU datastructures are designed so as to support uncore
and also CPU specific events in future.

The Hisilicon LLC has four banks for a Super CPU Cluster(consists of
 16 CPU cores) and each LLC bank has separate hardware events and counters.
In the current implementation, the count from all these banks are summarized
and total count is output.

The Hisilicon uncore PMUs can be found under /sys/bus/event_source/devices.
The counters are exported via sysfs in the corresponding events files
under the PMU directory so the perf tool can list the event names.

Note:
This is very initial patchset for Hisilicon SoC PMU support shared for
review. Please review and share comments.
This patchset depends on the Hisilicon Djtag driver for r/w access to
Hisilicon SoC PMU registers, which is not upstreamed yet. The patches for
Djtag driver shall be send for review soon.

TODO:
        1. Counter overflow interrupt handling support to be added.
        2. CPU notifier to migrate to available online CPU's in case
           of CPU DOWN. Also mapping CPU cores to the current SCCL.
        3. Support for counting of individual LLC banks

Anurup M (8):
  arm64:perf: Add Devicetree bindings for Hisilicon SoC PMU
  arm64:MAINTAINERS:hisi: Add hisilicon SoC PMU support
  arm64:perf: Update Kconfig for Hisilicon PMU support
  arm64:perf: Add support for Hisilicon SoC event counters
  arm64:perf: L3 cache(LLC) event counting in perf
  arm64:perf: Makefile for Hisilicon ARMv8 PMU
  arm64:perf: Update Makefile for Hisilicon PMU support
  arm64:perf: L3 cache(LLC) event listing in perf

 .../devicetree/bindings/arm/hisilicon/pmu.txt      |  32 ++
 MAINTAINERS                                        |   8 +
 drivers/perf/Kconfig                               |   9 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/hisilicon/Makefile                    |   1 +
 drivers/perf/hisilicon/hisi_uncore_llc.c           | 613 +++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_llc.h           | 100 ++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c           | 521 +++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h           | 144 +++++
 9 files changed, 1429 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
 create mode 100644 drivers/perf/hisilicon/Makefile
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_llc.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_llc.h
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.h

-- 
2.1.4
