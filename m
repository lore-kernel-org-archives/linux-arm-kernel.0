From: anurupvasu@gmail.com (Anurup M)
Date: Wed,  7 Dec 2016 11:50:56 -0500
Subject: [PATCH v2 00/10] perf: arm64: Support for Hisilicon SoC Hardware
 event counters
Message-ID: <1481129456-159241-1-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Garry <john.garry@huawei.com>

Provide Support for Hisilicon SoC(HiP05/06/07) Hardware event counters.
The Hisilicon SoC HiP0x series has many uncore or non-CPU performance
events and counters units.

This patch series is implemented refering to arm-cci, Intel/AMD uncore and
also the cavium thunderX and xgene uncore pmu patches.
This v2 version has addressed the review comments of v1 version.

Support for Hisilicon L3 cache(L3C) and Misclennaneous nodes(MN) hardware
events and counters are added in this implementation.

The Hisilicon uncore PMUs can be found under /sys/bus/event_source/devices.
The counters are exported via sysfs in the corresponding events files
under the PMU directory so the perf tool can list the event names.

ToDo:
1) The counter overflow handling is currently unsupported in this
   patch series.
2) ACPI support.

Version history
---------------

v2
--
- Fix review comments of v2 version.
- Move djtag driver to drivers/perf/hisilicon.
- Have separate PMU instance for each L3 cache banks.
- Modify device properties in DTS as per review comments.
- Handle hardware version difference.
- Change compatible names of djtag so use prefix hisi-
  and remove chip version as driver only depend on djtag
  hw version.
- use devm_kzalloc.
- Remove DDRC changes in this series. As the DDRC PMU doesnot
  depend on djtag it will be send separately.

v1
--
-Initial version with support for L3C, MN and DDRC event counters
-Djtag driver is used to access registers of L3 cache and MN.

Anurup M (7):
  arm64: MAINTAINERS: hisi: Add hisilicon SoC PMU support
  dt-bindings: perf: hisi: Add Devicetree bindings for Hisilicon SoC PMU
  Documentation: perf: hisi: Documentation for HIP05/06/07 PMU event
    counting.
  perf: hisi: Update Kconfig for Hisilicon PMU support
  perf: hisi: Add support for Hisilicon SoC event counters
  perf: hisi: Add sysfs attributes for L3 cache(L3C) PMU
  dts: arm64: hip06: Add Hisilicon SoC PMU support

Shaokun Zhang (1):
  perf: hisi: Miscellanous node(MN) event counting in perf

Tan Xiaojun (2):
  dt-bindings: hisi: Add Hisilicon HiP05/06/07 Djtag dts bindings
  drivers: perf: hisi: Add support for Hisilicon Djtag driver

 .../devicetree/bindings/arm/hisilicon/djtag.txt    |  66 ++
 .../devicetree/bindings/arm/hisilicon/pmu.txt      |  98 +++
 Documentation/perf/hisi-pmu.txt                    |  75 +++
 MAINTAINERS                                        |   9 +
 arch/arm64/boot/dts/hisilicon/hip06.dtsi           |  78 +++
 drivers/perf/Kconfig                               |   8 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/hisilicon/Makefile                    |   1 +
 drivers/perf/hisilicon/djtag.c                     | 729 +++++++++++++++++++++
 drivers/perf/hisilicon/djtag.h                     |  39 ++
 drivers/perf/hisilicon/hisi_uncore_l3c.c           | 629 ++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_mn.c            | 516 +++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c           | 365 +++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h           | 128 ++++
 14 files changed, 2742 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
 create mode 100644 Documentation/perf/hisi-pmu.txt
 create mode 100644 drivers/perf/hisilicon/Makefile
 create mode 100644 drivers/perf/hisilicon/djtag.c
 create mode 100644 drivers/perf/hisilicon/djtag.h
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_l3c.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_mn.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.h

-- 
2.1.4
