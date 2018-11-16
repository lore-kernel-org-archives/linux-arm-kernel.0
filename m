From: andrew.murray@arm.com (Andrew Murray)
Date: Fri, 16 Nov 2018 10:24:03 +0000
Subject: [PATCH 00/10] perf/core: Generalise event exclusion checking
Message-ID: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many PMU drivers do not have the capability to exclude counting events
that occur in specific contexts such as idle, kernel, guest, etc. These
drivers indicate this by returning an error in their event_init upon
testing the events attribute flags.

However this approach requires that each time a new event modifier is
added to perf, all the perf drivers need to be modified to indicate that
they don't support the attribute. This results in additional boiler-plate
code common to many drivers that needs to be maintained. An example of
this is the addition of exclude_host and exclude_guest in 2011 yet many
PMU drivers do not support this or indicate an error on events that make
use of it.

This patch generalises the test for exclusion and updates PMU drivers to
use it. This is a functional change as some PMU drivers will now correctly
report that they don't support certain events whereas they previously did.

An alternative approach might have been to provide a static perf_event_attr
with exclusion events set such that each PMU driver could compare against
(see ref [1]) - however this is less readable. A longer term approach may
instead be for PMU's to advertise their capabilities on registration.

All drivers touched by this patchset have been compile tested.

[1] https://lore.kernel.org/patchwork/patch/325116/
~                                                               

Andrew Murray (10):
  perf/core: Add macro to test for event exclusion flags
  arm: perf/core: generalise event exclusion checking with perf macro
  arm: perf: add additional validation to set_event_filter
  powerpc: perf/core: generalise event exclusion checking with perf
    macro
  powerpc/pmu/fsl: add additional validation to event_init
  alpha: perf/core: generalise event exclusion checking with perf macro
  x86: perf/core: generalise event exclusion checking with perf macro
  perf/core: Remove unused perf_flags
  drivers/perf: perf/core: generalise event exclusion checking with perf
    macro
  perf/doc: update design.txt for exclude_{host|guest} flags

 arch/alpha/kernel/perf_event.c           |  4 +---
 arch/arm/kernel/perf_event_v7.c          |  2 ++
 arch/arm/mach-imx/mmdc.c                 |  8 +-------
 arch/arm/mm/cache-l2x0-pmu.c             |  7 +------
 arch/powerpc/perf/core-fsl-emb.c         |  2 ++
 arch/powerpc/perf/hv-24x7.c              |  7 +------
 arch/powerpc/perf/hv-gpci.c              |  7 +------
 arch/powerpc/perf/imc-pmu.c              | 14 ++------------
 arch/x86/events/amd/ibs.c                | 11 +----------
 arch/x86/events/amd/iommu.c              |  3 +--
 arch/x86/events/amd/power.c              |  8 +-------
 arch/x86/events/amd/uncore.c             |  3 +--
 arch/x86/events/intel/cstate.c           |  7 +------
 arch/x86/events/intel/rapl.c             |  7 +------
 arch/x86/events/intel/uncore.c           |  3 +--
 arch/x86/events/intel/uncore_snb.c       |  7 +------
 arch/x86/events/msr.c                    |  7 +------
 drivers/perf/arm-cci.c                   |  7 +------
 drivers/perf/arm-ccn.c                   |  5 +----
 drivers/perf/arm_dsu_pmu.c               |  7 +------
 drivers/perf/arm_pmu.c                   |  9 +--------
 drivers/perf/hisilicon/hisi_uncore_pmu.c |  7 +------
 drivers/perf/qcom_l2_pmu.c               |  3 +--
 drivers/perf/qcom_l3_pmu.c               |  3 +--
 drivers/perf/xgene_pmu.c                 |  3 +--
 include/linux/perf_event.h               |  9 +++++++++
 include/uapi/linux/perf_event.h          |  2 --
 tools/include/uapi/linux/perf_event.h    |  2 --
 tools/perf/design.txt                    |  4 ++++
 29 files changed, 41 insertions(+), 127 deletions(-)

-- 
2.7.4
