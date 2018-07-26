From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 26 Jul 2018 13:54:38 +0100
Subject: [PATCH v3 00/13] coresight: perf: Support for TMC ETR backend
Message-ID: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the support for using the tmc-etr in perf mode for
storing the trace to system RAM. The ETR uses a separate buffer (double
buffering) for storing the trace. This is copied back to the ring buffer
when the event is stopped. We try to match the ETR buffer to the larger
of perf ring buffer or the size configured for the ETR via sysfs. This
allows tuning the buffer size to prevent overflows and loosing trace
data, as we don't have overflow interrupt support (yet).

Applies on coresight/next

Changes since v2:
 - Split hotplug lock cleanup from per-cpu path management
 - Add support for tracing on hotplugged CPUs (based on patch by Mathieu)
 - Fix handling of perf mode in etb10 driver
 - Fix CS_UNLOCK() typo in ETR perf driver
 - Rename call backs from tmc_etr_<op>_perf_buffer => tmc_<op>_etr_buffer
   to be consistent with ETF driver
 - Modify the commit description for removing set_buffer call back.

Changes since v1 :
 - Fix path for each CPU where the event might be recorded.
 - Handle errors in enabling source
 - Remove set_buffer callback to avoid complicating the error handling.
 - Fix a bug in handling sysfs mode specific buffers

Changes since [0] :
 - Drop buffer rotation logic for etr-buf
 - Do not use perf ring buffer. (Add support later)
 - Fix handling of sink, preventing mixed modes of operation.

[0] - TMC ETR perf support
 - http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/574875.html


Suzuki K Poulose (13):
  coresight: Fix handling of sinks
  coresight: etb10: Fix handling of perf mode
  coresight: perf: Fix per cpu path management
  coresight: perf: Avoid unncessary CPU hotplug read lock
  coresight: perf: Allow tracing on hotplugged CPUs
  coresight: perf: Disable trace path upon source error
  coresight: tmc-etr: Handle driver mode specific ETR buffers
  coresight: tmc-etr: Relax collection of trace from sysfs mode
  coresight: Convert driver messages to dev_dbg
  coresight: perf: Remove reset_buffer call back for sinks
  coresight: perf: Add helper to retrieve sink configuration
  coresight: perf: Remove set_buffer call back
  coresight: etm-perf: Add support for ETR backend

 .../coresight/coresight-dynamic-replicator.c       |   4 +-
 drivers/hwtracing/coresight/coresight-etb10.c      | 100 +++----
 drivers/hwtracing/coresight/coresight-etm-perf.c   | 134 +++++----
 drivers/hwtracing/coresight/coresight-etm-perf.h   |  26 ++
 drivers/hwtracing/coresight/coresight-etm3x.c      |   4 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |   4 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |   4 +-
 drivers/hwtracing/coresight/coresight-priv.h       |   2 +-
 drivers/hwtracing/coresight/coresight-replicator.c |   4 +-
 drivers/hwtracing/coresight/coresight-stm.c        |   4 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  94 +++---
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 327 ++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc.c        |   4 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |   4 +
 drivers/hwtracing/coresight/coresight-tpiu.c       |   6 +-
 drivers/hwtracing/coresight/coresight.c            |  31 +-
 include/linux/coresight.h                          |  12 +-
 17 files changed, 517 insertions(+), 247 deletions(-)

-- 
2.7.4
