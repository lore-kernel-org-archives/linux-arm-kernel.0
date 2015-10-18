From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:17 -0600
Subject: [PATCH V2 00/30] Coresight integration with perf
Message-ID: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset aims to integrate configuration and control of
the Coresight tracers with the perf sub-system.

The goal is to use PMUs to represent tracers and the auxiliary
buffer enhancement to collect processor traces.  As such a lot
of work is done to move the current Coresight sysFS oriented
configuration and control commands to perf's AUX API.

For the time being the work concentrates on ETMv3 and ETB1.0
sink buffers.  Work on ETMv4 and other type of sink buffers
will follow once a foundation has been established.

Best regards,
Mathieu

Changes since V1:
 * Fixed typos in typographical error in documentation.
 * Moved to a multi session support scheme.
 * Split static and dynamic tracer configuration.
 * Fixed configuration for user and kernel space tracing.
 * Using WARN_ON_ONCE() rather than WARN_ON().
 * Implemented strategy to prevent tracers from being used simultaneously.
 * Changed sink_ops::unset_buffer() to sink_ops::reset_buffer().
 * Moves ETM's sysFS interface from driver core to dedicated file.
 * Removed spinlock in "etm_cpu_id()".
 * Aggregated PMU driver pieces in a single patch.
 * Added user space changes and rebased everything to v4.3-rc5. 

Mathieu Poirier (30):
  coresight: etm3x: moving etm_readl/writel to header file
  coresight: etm3x: moving sysFS entries to dedicated file
  coresight: etm3x: unlocking tracers in default arch init
  coresight: etm3x: splitting struct etm_drvdata
  coresight: etm3x: set progbit to stop trace collection
  coresight: clearly labeling source operarions
  coresight: etm3x: moving etm_drvdata::enable to atomic field
  coresight: etm3x: implementing 'cpu_id()' API
  coresight: etm3x: changing default trace configuration
  coresight: etm3x: consolidating initial config
  coresight: etm3x: implementing user/kernel mode tracing
  coresight: etm3x: adding perf_get/set_config() API
  coresight: etm3x: implementing perf_enable/disable() API
  coresight: etm3x: implementing perf_start/stop() API
  coresight: making coresight_build_paths() public
  coresight: keeping track of enabled sink buffers
  perf: changing pmu::setup_aux() parameter to include event
  coresight: etb10: moving to local atomic operations
  coresight: etb10: implementing the setup_aux() API
  coresight: etb10: implementing buffer set/reset() API
  coresight: etb10: implementing buffer update API
  coresight: etm-perf: new PMU driver for ETM tracers
  coresight: updating documentation to reflect integration with perf
  perf tools: making function set_max_cpu_num() non static
  perf tools: adding perf_session to *info_prive_size()
  perf tools: making source devices path broadly accessible
  perf build: adding X86 auxiliary specific flags
  perf tools: making coresight PMU listable
  perf tools: adding coresight define for auxtrace
  perf tools: adding coresight etm PMU record capabilities

 Documentation/trace/coresight.txt                  |  138 +-
 arch/x86/kernel/cpu/perf_event_intel_bts.c         |    4 +-
 arch/x86/kernel/cpu/perf_event_intel_pt.c          |    5 +-
 drivers/hwtracing/coresight/Makefile               |    4 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |  247 ++-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  533 ++++++
 drivers/hwtracing/coresight/coresight-etm-perf.h   |   27 +
 drivers/hwtracing/coresight/coresight-etm.h        |  151 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 1442 ++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm3x.c      | 1724 ++++----------------
 drivers/hwtracing/coresight/coresight-etm4x.c      |    8 +-
 drivers/hwtracing/coresight/coresight-priv.h       |    4 +
 drivers/hwtracing/coresight/coresight.c            |   27 +-
 include/linux/coresight.h                          |   51 +-
 include/linux/perf_event.h                         |    2 +-
 kernel/events/ring_buffer.c                        |    2 +-
 tools/perf/arch/arm/util/Build                     |    2 +
 tools/perf/arch/arm/util/auxtrace.c                |   48 +
 tools/perf/arch/arm/util/cs_etm.c                  |  444 +++++
 tools/perf/arch/arm/util/cs_etm.h                  |   37 +
 tools/perf/arch/arm/util/pmu.c                     |   18 +
 tools/perf/arch/x86/util/Build                     |    6 +-
 tools/perf/arch/x86/util/intel-bts.c               |    4 +-
 tools/perf/arch/x86/util/intel-pt.c                |    4 +-
 tools/perf/arch/x86/util/pmu.c                     |    2 +-
 tools/perf/builtin-inject.c                        |    2 +-
 tools/perf/builtin-record.c                        |    2 +-
 tools/perf/config/Makefile                         |   19 +-
 tools/perf/util/Build                              |    6 +-
 tools/perf/util/auxtrace.c                         |    8 +-
 tools/perf/util/auxtrace.h                         |    9 +-
 tools/perf/util/cpumap.c                           |    2 +-
 tools/perf/util/cpumap.h                           |    1 +
 tools/perf/util/intel-bts.h                        |   11 +
 tools/perf/util/intel-pt-decoder/Build             |    2 +-
 tools/perf/util/intel-pt.h                         |   15 +
 tools/perf/util/pmu.c                              |    2 -
 tools/perf/util/pmu.h                              |    1 +
 38 files changed, 3531 insertions(+), 1483 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-etm-perf.c
 create mode 100644 drivers/hwtracing/coresight/coresight-etm-perf.h
 create mode 100644 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
 create mode 100644 tools/perf/arch/arm/util/auxtrace.c
 create mode 100644 tools/perf/arch/arm/util/cs_etm.c
 create mode 100644 tools/perf/arch/arm/util/cs_etm.h
 create mode 100644 tools/perf/arch/arm/util/pmu.c

-- 
1.9.1
