From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  3 Feb 2016 11:38:58 -0700
Subject: [PATCH V9 00/18] Coresight integration with perf 
Message-ID: <1454524756-10628-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the ninth iteration of this serie.  Changes are minor and don't
affect how the integration is done.

One notable thing is the absence of the patches adding support for this
PMU at the user space perf tool level.  Those will be lumped with the
rest of the user space trace decoding solution currently being worked
on.

This set is based on [1] and assumes [2] and [3] have been applied.

Best regards,
Mathieu

[1]. https://git.linaro.org/kernel/coresight.git/shortlog/refs/heads/next 
[2]. http://www.spinics.net/lists/arm-kernel/msg479330.html
[3]. https://lkml.org/lkml/2016/1/26/793 

Original description:

This patchset aims to integrate configuration and control of
the Coresight tracers with the perf sub-system.

The goal is to use PMUs to represent tracers and the auxiliary
buffer enhancement to collect processor traces.  As such a lot
of work is done to move the current Coresight sysFS oriented
configuration and control commands to perf's AUX API.

For the time being the work concentrates on ETMv3 and ETB1.0
sink buffer.  Work on ETMv4 and other type of sink buffers
will follow once a foundation has been established.

Changes since V8:
* Rebased to v4.5-rc2.
* Fixed the possibility of a type overflow in etb_reset_buffer().
* Removed unneeded spinlock grab in etb_update_buffer().
* Removed unneeded event->cpu range check in etm_event_init().
* Removed warning when perf_aux_output_begin() fails in etm_event_start().
* Added warning when a sink can't be found in etm_event_start().
* As stated above, removed patches related to the user space perf tools.

Changes since V7:
* Moved coresight_release_path() a workqueue context, preventing
  pm_runtime_put_sync() from being called from an invalid
  (i.e interrupt) context.
* Fixed wrong 'buf_ptr' type in function etb_update_buffer().
* In function auxtrace_record__init(), no longer setting the 'err'
  pointer to '-EINVAL'.
* Removing erroneous call to kfree() in function etm_disable_sysfs(). 

[1]. https://git.linaro.org/kernel/coresight.git/shortlog/refs/heads/next 
[2]. http://www.spinics.net/lists/arm-kernel/msg474573.html 

Changes since V6:
* Rebased to 4.4-rc5.
* Thanks to [1], all tracer configuration now happens
  when events are scheduled.

[1]. https://lwn.net/Articles/667573/

Changes since V5:
* Addressed Arnaldo's comment about using a struct perf_evlist rather
  than a struct perf_session.
* Addressed kbuild test robot's anomaly report [1].
* Moved perf_aux_output_{begin|end} to etm_event_{start|stop} in
  accordance with [2].

[1]. https://lkml.org/lkml/2015/11/30/46
[2]. http://thread.gmane.org/gmane.linux.kernel/2099328/focus=2099343

Changes since V4:
* Reworked the way event configuration information is kept, fixing
  a few corner cases when doing per CPU tracing.
* Rebased on 4.4-rc1.
* Added 'Cc' to specific perf related patches in the hope of suscitating
  interest from reviewers, i.e perf maintainers.

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




Mathieu Poirier (18):
  coresight: associating path with session rather than tracer
  coresight: add API to get sink from path
  coresight: moving PM runtime operations to core framework
  coresight: etm3x: moving etm_readl/writel to header file
  coresight: etm3x: moving sysFS entries to dedicated file
  coresight: etm3x: unlocking tracers in default arch init
  coresight: etm3x: splitting struct etm_drvdata
  coresight: etm3x: adding operation mode for etm_enable()
  coresight: etm3x: set progbit to stop trace collection
  coresight: etm3x: changing default trace configuration
  coresight: etm3x: consolidating initial config
  coresight: etm3x: implementing user/kernel mode tracing
  coresight: etm3x: implementing perf_enable/disable() API
  coresight: etb10: moving to local atomic operations
  coresight: etb10: adding operation mode for sink->enable()
  coresight: etb10: implementing AUX API
  coresight: etm-perf: new PMU driver for ETM tracers
  coresight: introducing a global trace ID function

 drivers/hwtracing/coresight/Kconfig                |    1 +
 drivers/hwtracing/coresight/Makefile               |    4 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |  273 ++-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  393 +++++
 drivers/hwtracing/coresight/coresight-etm-perf.h   |   32 +
 drivers/hwtracing/coresight/coresight-etm.h        |  142 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 1272 ++++++++++++++
 drivers/hwtracing/coresight/coresight-etm3x.c      | 1816 +++++---------------
 drivers/hwtracing/coresight/coresight-etm4x.c      |   10 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |    2 -
 drivers/hwtracing/coresight/coresight-priv.h       |   15 +
 .../coresight/coresight-replicator-qcom.c          |    4 -
 drivers/hwtracing/coresight/coresight-replicator.c |    2 -
 drivers/hwtracing/coresight/coresight-tmc.c        |    7 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |    4 +-
 drivers/hwtracing/coresight/coresight.c            |  326 ++--
 include/linux/coresight-pmu.h                      |   39 +
 include/linux/coresight.h                          |   31 +-
 18 files changed, 2756 insertions(+), 1617 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-etm-perf.c
 create mode 100644 drivers/hwtracing/coresight/coresight-etm-perf.h
 create mode 100644 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
 create mode 100644 include/linux/coresight-pmu.h

-- 
2.1.4
