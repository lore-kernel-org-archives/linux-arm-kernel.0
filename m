From: anurupvasu@gmail.com (Anurup M)
Date: Sun, 19 Feb 2017 13:49:10 -0500
Subject: [PATCH v4 00/11] perf: arm64: Support for Hisilicon SoC Hardware
 event counters
Message-ID: <1487530150-42300-1-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide Support for Hisilicon SoC(HiP05/06/07) Hardware event counters.
The Hisilicon SoC HiP0x series has many uncore or non-CPU performance
events and counters units.

This patch series is implemented refering to arm-cci, Intel/AMD uncore and
also the cavium thunderX and xgene uncore pmu patches.
This v4 version has addressed the review comments of v3 and previous versions.

Support for Hisilicon L3 cache(L3C) and Miscellaneous nodes(MN) hardware
events and counters are added in this implementation.

The uncore PMU units are registered as separate PMUs. 
e.g. in the case of L3 cache, which consist of 4 banks/instances, each bank
is registered with perf as separate PMU, as each bank have separate control
registers and interrupts. These units are also not CPU affine in the current
chip versions.

The Hisilicon uncore PMUs can be found under /sys/bus/event_source/devices.
The counters are exported via sysfs in the corresponding events files
under the PMU directory so the perf tool can list the event names.

ToDo:
1) ACPI support.

Version history
---------------
v4
--
- Counter overflow IRQ handling for MN PMU.
- Use hrtimer to avoid counter overflow in L3 Cache PMU.
- Use hisi-cpu- and hisi-io- for djtag compatible field.
- Fix reveiw comments in v3 version.

v3
--
- Fix review comments of v2 version.
- Handle event groups. Do not allow group of mixed PMUs.
- Use hip0x prefix for compatible names.
- Fix all sparse and gcc W=1 warnings.

v2
--
- Fix review comments of v1 version.
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

Anurup M (8):
  arm64: MAINTAINERS: hisi: Add hisilicon SoC PMU support
  dt-bindings: perf: hisi: Add Devicetree bindings for Hisilicon SoC PMU
  Documentation: perf: hisi: Documentation for HiP05/06/07 PMU event
    counting.
  drivers: perf: hisi: Update Kconfig for Hisilicon PMU support
  drivers: perf: hisi: Add support for Hisilicon SoC event counters
  drivers: perf: hisi: use poll method to avoid L3C counter overflow
  drivers: perf: hisi: Handle counter overflow IRQ in MN PMU
  dts: arm64: hip07: Add Hisilicon SoC PMU support

Shaokun Zhang (1):
  drivers: perf: hisi: Miscellanous node(MN) event counting in perf

Tan Xiaojun (2):
  dt-bindings: hisi: Add Hisilicon HiP05/06/07 Djtag dts bindings
  drivers: perf: hisi: Add support for Hisilicon Djtag driver

 .../devicetree/bindings/arm/hisilicon/djtag.txt    |  76 ++
 .../devicetree/bindings/arm/hisilicon/pmu.txt      | 103 +++
 Documentation/perf/hisi-pmu.txt                    |  76 ++
 MAINTAINERS                                        |   9 +
 arch/arm64/boot/dts/hisilicon/hip07.dtsi           |  94 ++-
 drivers/perf/Kconfig                               |   8 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/hisilicon/Makefile                    |   1 +
 drivers/perf/hisilicon/djtag.c                     | 773 +++++++++++++++++++++
 drivers/perf/hisilicon/djtag.h                     |  40 ++
 drivers/perf/hisilicon/hisi_uncore_l3c.c           | 652 +++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_mn.c            | 611 ++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c           | 460 ++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h           | 137 ++++
 14 files changed, 3011 insertions(+), 30 deletions(-)
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
