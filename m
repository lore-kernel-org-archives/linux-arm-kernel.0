From: shameerali.kolothum.thodi@huawei.com (Shameer Kolothum)
Date: Fri, 21 Sep 2018 16:08:00 +0100
Subject: [PATCH v3 0/3] arm64 SMMUv3 PMU driver with IORT support
Message-ID: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a driver for the SMMUv3 PMU into the perf framework.
It includes an IORT update to support PM Counter Groups.

This is based on the initial work done by Neil Leeder[1]

SMMUv3 PMCG devices are named as smmuv3_pmcg_<phys_addr_page>
where <phys_addr_page> is the physical page address of the SMMU PMCG.
For example, the PMCG at 0xff88840000 is named smmuv3_pmcg_ff88840

Usage example:
For common arch supported events:
perf stat -e smmuv3_pmcg_ff88840/transaction,filter_enable=1,
 filter_span=1,filter_stream_id=0x42/ -a pwd

For IMP DEF events:
perf stat -e smmuv3_pmcg_ff88840/event=id/ -a pwd

Sanity tested on HiSilicon platform. Further testing on supported
platforms are very much welcome.

v2 --> v3

-Addressed comments from Robin.
-Removed iort helper function to retrieve the PMCG reference smmu.
-PMCG devices are now named using the base address

v1 --> v2

- Addressed comments from Robin.
- Added an helper to retrieve the associated smmu dev and named PMUs
  to make the association visible to user.
- Added MSI support  for overflow irq

[1]https://www.spinics.net/lists/arm-kernel/msg598591.html

Neil Leeder (2):
  acpi: arm64: add iort support for PMCG
  perf: add arm64 smmuv3 pmu driver

Shameer Kolothum (1):
  perf/smmuv3: Add MSI irq support

 drivers/acpi/arm64/iort.c     |  78 ++++-
 drivers/perf/Kconfig          |   9 +
 drivers/perf/Makefile         |   1 +
 drivers/perf/arm_smmuv3_pmu.c | 794 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 870 insertions(+), 12 deletions(-)
 create mode 100644 drivers/perf/arm_smmuv3_pmu.c

-- 
2.7.4
