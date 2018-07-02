From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  2 Jul 2018 16:33:24 -0600
Subject: [PATCH 0/6] perf: Add ioctl for PMU driver configuration 
Message-ID: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set follows what has been done for filters by adding an ioctl
to communicate PMU specific driver configuration to the kernel.

Patch 01 and 02 provide the functionality in user space while patch 04
and 05 take care of the kernel part.  Patches 03 and 06 use the newly
added functionality to communicate the selection of CoreSight sink
for each event.

This functionality is needed to identify the CoreSight sink to use when
working with CPU-wide trace scenarios.  It also paves the way to support
complex tracer configurations where dozens of trace parameters need to
be communicated to the CoreSight PMU driver.

Applies cleanly on v4.18-rc3.

Best regards,
Mathieu

Mathieu Poirier (6):
  perf tools: Use ioctl to communicate driver configuration to kernel
  perf tools: Make perf_evsel accessible to PMU driver configuration
    code
  perf tools: Use ioctl function to send sink configuration to kernel
  perf/aux: Make perf_event accessible to setup_aux()
  perf/core: Use ioctl to communicate driver configuration to kernel
  coresight: Use PMU driver configuration for sink selection

 arch/s390/kernel/perf_cpum_sf.c                  |   4 +-
 arch/x86/events/intel/bts.c                      |   4 +-
 arch/x86/events/intel/pt.c                       |   5 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c | 134 ++++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm-perf.h |  10 ++
 drivers/perf/arm_spe_pmu.c                       |   6 +-
 include/linux/perf_event.h                       |  56 +++++++++-
 include/uapi/linux/perf_event.h                  |   1 +
 kernel/events/core.c                             | 110 +++++++++++++++++++
 kernel/events/ring_buffer.c                      |   2 +-
 tools/include/uapi/linux/perf_event.h            |   1 +
 tools/perf/arch/arm/util/cs-etm.c                |  60 +++-------
 tools/perf/arch/arm/util/cs-etm.h                |   3 +-
 tools/perf/util/drv_configs.c                    |  30 ++---
 tools/perf/util/evsel.c                          |   7 ++
 tools/perf/util/evsel.h                          |   1 +
 tools/perf/util/pmu.h                            |   3 +-
 17 files changed, 345 insertions(+), 92 deletions(-)

-- 
2.7.4
