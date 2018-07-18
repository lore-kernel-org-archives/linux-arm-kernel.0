From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 18 Jul 2018 15:48:00 -0600
Subject: [PATCH v3 0/7] perf: Add ioctl for PMU driver configuration
Message-ID: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set adds the capability to communiate event specific configuration
to the PMU kernel driver using an ioctl().  The functionatlity is made
generic enough for anyone to use but is targeted at the identification
of CoreSight sinks when operating in CPU-wide trace scenarios.

Applies cleanly on v4.18-rc5.

Thanks,
Mathieu

---
Changes for V3:
. Return an error for CPU-wide scenarios while the feature is being
  implemented (Kim)
. Proper initialisation for event::hw::drv_config::lock (Kim)

Changes for V2:
. Fixed s390 problem reported by buildbot.
. Removed uneeded check in perf_event_process_drv_config() (Jiri)
. Reordered data copy in perf_event_set_drv_config() (Jiri)
. Went from 2 to 1 step driver configuration process (Alex)
. Moved structure name "perf_drv_config" to "pmu_drv_config".

V1: https://lkml.org/lkml/2018/7/2/1008

Mathieu Poirier (7):
  perf: Introduce ioctl to communicate driver configuration to kernel
  perf/core: Use ioctl to communicate driver configuration to kernel
  perf/aux: Make perf_event accessible to setup_aux()
  coresight: Use PMU driver configuration for sink selection
  perf tools: Use ioctl to communicate driver configuration to kernel
  perf tools: Make perf_evsel accessible to PMU driver configuration
    code
  perf tools: Use ioctl function to send sink configuration to kernel

 arch/s390/kernel/perf_cpum_sf.c                  |   6 +-
 arch/x86/events/intel/bts.c                      |   4 +-
 arch/x86/events/intel/pt.c                       |   5 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c | 140 ++++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm-perf.h |   4 +
 drivers/perf/arm_spe_pmu.c                       |   6 +-
 include/linux/perf_event.h                       |  47 +++++++-
 include/uapi/linux/perf_event.h                  |   1 +
 kernel/events/core.c                             |  78 +++++++++++++
 kernel/events/ring_buffer.c                      |   2 +-
 tools/include/uapi/linux/perf_event.h            |   1 +
 tools/perf/arch/arm/util/cs-etm.c                |  60 +++-------
 tools/perf/arch/arm/util/cs-etm.h                |   3 +-
 tools/perf/util/drv_configs.c                    |  30 ++---
 tools/perf/util/evsel.c                          |   7 ++
 tools/perf/util/evsel.h                          |   1 +
 tools/perf/util/pmu.h                            |   3 +-
 17 files changed, 305 insertions(+), 93 deletions(-)

-- 
2.7.4
