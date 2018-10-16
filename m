From: shameerali.kolothum.thodi@huawei.com (Shameer Kolothum)
Date: Tue, 16 Oct 2018 13:49:16 +0100
Subject: [PATCH v4 0/4] arm64 SMMUv3 PMU driver with IORT support
Message-ID: <20181016124920.24708-1-shameerali.kolothum.thodi@huawei.com>
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
 filter_span=1,filter_stream_id=0x42/ -a netperf

For IMP DEF events:
perf stat -e smmuv3_pmcg_ff88840/event=id/ -a netperf

This is sanity tested on a HiSilicon platform that requires
a quirk to run  it properly. As per HiSilicon erratum  #162001800,
PMCG event counter registers (SMMU_PMCG_EVCNTRn) on HiSilicon Hip08
platforms are read only and this prevents the software from setting
the initial period on event start. Unfortunately we were a bit late
in the cycle to detect this issue and now require software workaround
for this. Patch #4 is added to this series to provide a workaround
for this issue.

Further testing on supported platforms are very much welcome.

v3 --> v4

-Addressed comments from Jean and Robin.
-Merged dma config callbacks as per Lorenzo's comments(patch #1).
-Added handling of Global(Counter0) filter settings mode(patch #2).
-Added patch #4 to address HiSilicon erratum  #162001800
-
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

Shameer Kolothum (2):
  perf/smmuv3: Add MSI irq support
  perf/smmuv3_pmu: Enable HiSilicon Erratum 162001800 quirk

 drivers/acpi/arm64/iort.c     |  97 ++++-
 drivers/perf/Kconfig          |   9 +
 drivers/perf/Makefile         |   1 +
 drivers/perf/arm_smmuv3_pmu.c | 959 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1045 insertions(+), 21 deletions(-)
 create mode 100644 drivers/perf/arm_smmuv3_pmu.c

-- 
2.7.4
