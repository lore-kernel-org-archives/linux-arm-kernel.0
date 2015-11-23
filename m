From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 23 Nov 2015 11:32:52 -0700
Subject: [RESEND PATCH V4 00/26] Coresight integration with perf
Message-ID: <1448303598-11249-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I haven't received much in terms of comments from this iteration.
Even if all comments from previous posts have been addressed it would
feel better to have a few "Reviewed-by:" before adding this to my
tree.

This patchset aims to integrate configuration and control of
the Coresight tracers with the perf sub-system.

The goal is to use PMUs to represent tracers and the auxiliary
buffer enhancement to collect processor traces.  As such a lot
of work is done to move the current Coresight sysFS oriented
configuration and control commands to perf's AUX API.

For the time being the work concentrates on ETMv3 and ETB1.0
sink buffer.  Work on ETMv4 and other type of sink buffers
will follow once a foundation has been established.

Best regards,
Mathieu

Changes since V3:
* Rebased to GKH's char-misc-next tree (e2d8680741ed).

Changes since V2:
* Rebased to v4.3.
* Used the -M option to "git format-patch".
* Decoupled tracers and path - both are now completely independent.
* Moved path enablement/release to Perf's add/del functions.
* Moved PM runtime operations to the coresight core rather than
  individual drivers.
* Enhanced mutual exclusion scheme between perf and sysFS.
* Removed architecture specific define in perf cmd line tool.
* Got rid of unused fields in structure 'cs_buffers'.
* Enhanced changelog for patch 16/26.

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

Mathieu Poirier (26):
  coresight: etm3x: moving etm_readl/writel to header file
  coresight: etm3x: moving sysFS entries to dedicated file
  coresight: etm3x: unlocking tracers in default arch init
  coresight: etm3x: splitting struct etm_drvdata
  coresight: etm3x: implementing 'cpu_id()' API
  coresight: associating path with session rather than tracer
  coresight: moving PM runtime operations to core framework
  coresight: etm3x: adding operation mode for etm_enable()
  coresight: add API to get sink from path
  coresight: etm3x: set progbit to stop trace collection
  coresight: etm3x: changing default trace configuration
  coresight: etm3x: consolidating initial config
  coresight: etm3x: implementing user/kernel mode tracing
  coresight: etm3x: adding perf_get/set_config() API
  coresight: etm3x: implementing perf_enable/disable() API
  perf: changing pmu::setup_aux() parameter to include event
  coresight: etb10: moving to local atomic operations
  coresight: adding operation mode for sink->enable()
  coresight: etb10: implementing AUX space API
  coresight: etm-perf: new PMU driver for ETM tracers
  coresight: introducing a global trace ID function
  coresight: updating documentation to reflect integration with perf
  perf tools: making function set_max_cpu_num() non static
  perf tools: adding perf_session to *info_prive_size()
  perf tools: making coresight PMU listable
  perf tools: adding coresight etm PMU record capabilities

 Documentation/trace/coresight.txt                  |  138 +-
 MAINTAINERS                                        |    4 +
 arch/x86/kernel/cpu/perf_event_intel_bts.c         |    4 +-
 arch/x86/kernel/cpu/perf_event_intel_pt.c          |    5 +-
 drivers/hwtracing/coresight/Kconfig                |    1 +
 drivers/hwtracing/coresight/Makefile               |    4 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |  268 ++-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  438 +++++
 drivers/hwtracing/coresight/coresight-etm-perf.h   |   32 +
 drivers/hwtracing/coresight/coresight-etm.h        |  143 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 1442 +++++++++++++++
 drivers/hwtracing/coresight/coresight-etm3x.c      | 1875 +++++---------------
 drivers/hwtracing/coresight/coresight-etm4x.c      |    8 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |    2 -
 drivers/hwtracing/coresight/coresight-priv.h       |   15 +
 .../coresight/coresight-replicator-qcom.c          |    4 -
 drivers/hwtracing/coresight/coresight-replicator.c |    2 -
 drivers/hwtracing/coresight/coresight-tmc.c        |    7 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |    4 +-
 drivers/hwtracing/coresight/coresight.c            |  330 ++--
 include/linux/coresight-pmu.h                      |   39 +
 include/linux/coresight.h                          |   36 +-
 include/linux/perf_event.h                         |    2 +-
 kernel/events/ring_buffer.c                        |    2 +-
 tools/perf/arch/arm/util/Build                     |    2 +
 tools/perf/arch/arm/util/auxtrace.c                |   48 +
 tools/perf/arch/arm/util/cs_etm.c                  |  466 +++++
 tools/perf/arch/arm/util/cs_etm.h                  |   44 +
 tools/perf/arch/arm/util/pmu.c                     |   34 +
 tools/perf/arch/x86/util/intel-bts.c               |    4 +-
 tools/perf/arch/x86/util/intel-pt.c                |    4 +-
 tools/perf/config/Makefile                         |   17 +-
 tools/perf/util/auxtrace.c                         |    8 +-
 tools/perf/util/auxtrace.h                         |    7 +-
 tools/perf/util/cpumap.c                           |    2 +-
 tools/perf/util/cpumap.h                           |    1 +
 36 files changed, 3787 insertions(+), 1655 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-etm-perf.c
 create mode 100644 drivers/hwtracing/coresight/coresight-etm-perf.h
 create mode 100644 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
 create mode 100644 include/linux/coresight-pmu.h
 create mode 100644 tools/perf/arch/arm/util/auxtrace.c
 create mode 100644 tools/perf/arch/arm/util/cs_etm.c
 create mode 100644 tools/perf/arch/arm/util/cs_etm.h
 create mode 100644 tools/perf/arch/arm/util/pmu.c

-- 
1.9.1
