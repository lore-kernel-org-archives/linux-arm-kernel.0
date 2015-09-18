From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:14 -0600
Subject: [RFC PATCH 00/20] Coresight integration with perf 
Message-ID: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
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

Enhancement to the perf command line tool can be found here [1].
It is based on v4.2 but a rebase to v4.3-rcX will be available
shortly.

Best regards,
Mathieu

[1]. https://git.linaro.org/people/mathieu.poirier/coresight.git/shortlog/refs/heads/perf-v4.2 

Mathieu Poirier (20):
  coresight: etm3x: splitting 'etm_enable_hw()' operations
  coresight: etm3x: implementing 'is_enabled()' API
  coresight: etm3x: implementing 'cpu_id()' API
  coresight: etm3x: using chip logic to start/stop traces
  coresight: etm3x: adapting default tracer setting for perf
  coresight: etm3x: unlocking tracer in default arch init
  coresight: etb10: implementing the setup_aux() API
  coresight: etb10: implementing buffer set and unset APIs
  coresight: etb10: implementing buffer update API
  coresight: etb10: adding snapshot mode feature
  coresight: making coresight_build_paths() public
  coresight: keeping track of enabled sink buffers
  coresight: etm-perf: new PMU driver for ETM tracers
  coresight: etm-perf: implementing 'event_init()' API
  coresight: etm-perf: implementing 'setup_aux()' API
  coresight: etm-perf: implementing trace related APIs
  coresight: etm-perf: adding symbolic link for CPUs
  coresight: etm3x: pushing down perf configuration to tracer
  coresight: etm3x: implementing perf's user/kernel mode
  coresight: updating documentation to reflect integration with perf

 Documentation/trace/coresight.txt                | 116 ++++++-
 MAINTAINERS                                      |   1 +
 drivers/hwtracing/coresight/Makefile             |   2 +-
 drivers/hwtracing/coresight/coresight-etb10.c    | 232 ++++++++++++++
 drivers/hwtracing/coresight/coresight-etm-perf.c | 383 +++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm-perf.h |  27 ++
 drivers/hwtracing/coresight/coresight-etm.h      |   2 +
 drivers/hwtracing/coresight/coresight-etm3x.c    | 309 ++++++++++++++----
 drivers/hwtracing/coresight/coresight-priv.h     |   4 +
 drivers/hwtracing/coresight/coresight.c          |  14 +-
 include/linux/coresight-pmu.h                    |  18 ++
 include/linux/coresight.h                        |  32 +-
 12 files changed, 1075 insertions(+), 65 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-etm-perf.c
 create mode 100644 drivers/hwtracing/coresight/coresight-etm-perf.h
 create mode 100644 include/linux/coresight-pmu.h

-- 
1.9.1
