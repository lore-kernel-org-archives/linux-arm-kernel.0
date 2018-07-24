From: shameerali.kolothum.thodi@huawei.com (Shameer Kolothum)
Date: Tue, 24 Jul 2018 12:45:11 +0100
Subject: [PATCH v2 0/4] arm64 SMMUv3 PMU driver with IORT support
Message-ID: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a driver for the SMMUv3 PMU into the perf framework.
It includes an IORT update to support PM Counter Groups.

This is based on the initial work done by Neil Leeder[1]

SMMUv3 PMCG devices are named as arm_smmu_v3_x_pmcg_y where x
denotes the associated smmuv3 dev id(if any) and y denotes the
pmu dev id.

Usage example:
For common arch supported events:
perf stat -e arm_smmu_v3_0_pmcg_6/transaction,filter_enable=1,
 filter_span=1,filter_stream_id=0x42/ -a pwd

For IMP DEF events:
perf stat -e arm_smmu_v3.0_pmcg.6/event=id/ -a pwd

Sanity tested on HiSilicon platform. Further testing on supported
platforms are very much welcome.

v1 --> v2

- Addressed comments from Robin.
- Added an helper to retrieve the associated smmu dev and named PMUs
  to make the association visible to user.
- Added MSI support  for overflow irq

[1]https://www.spinics.net/lists/arm-kernel/msg598591.html

Neil Leeder (2):
  acpi: arm64: add iort support for PMCG
  perf: add arm64 smmuv3 pmu driver

Shameer Kolothum (2):
  acpi: arm64: iort helper to find the associated smmu of pmcg node
  perf/smmuv3: Add MSI irq support

 drivers/acpi/arm64/iort.c     | 179 +++++++--
 drivers/perf/Kconfig          |   9 +
 drivers/perf/Makefile         |   1 +
 drivers/perf/arm_smmuv3_pmu.c | 901 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi_iort.h     |   4 +
 5 files changed, 1063 insertions(+), 31 deletions(-)
 create mode 100644 drivers/perf/arm_smmuv3_pmu.c

-- 
2.7.4
