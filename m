From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 11 Jul 2018 15:16:33 +0100
Subject: [PATCH 0/6] coresight: perf: Support for tmc-etr backed buffers
Message-ID: <1531318599-8840-1-git-send-email-suzuki.poulose@arm.com>
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

Changes since [0] :
 - Drop buffer rotation logic for etr-buf
 - Do not use perf ring buffer. (Add support later)
 - Fix handling of sink, preventing mixed modes of operation.

[0] - TMC ETR perf support
 - http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/574875.html

Suzuki K Poulose (6):
  coresight: Fix handling of sinks
  coresight: tmc-etr: Handle driver mode specific ETR buffers
  coresight: tmc-etr: Relax collection of trace from sysfs mode
  coresight: Convert driver messages to dev_dbg
  coresight: perf: Remove reset_buffer call back for sinks
  coresight: etm-perf: Add support for ETR backend

 .../coresight/coresight-dynamic-replicator.c       |   4 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |  62 +---
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   9 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |   4 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |   4 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |   4 +-
 drivers/hwtracing/coresight/coresight-replicator.c |   4 +-
 drivers/hwtracing/coresight/coresight-stm.c        |   4 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  66 +---
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 337 +++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.c        |   4 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |   4 +
 drivers/hwtracing/coresight/coresight-tpiu.c       |   4 +-
 drivers/hwtracing/coresight/coresight.c            |  22 +-
 include/linux/coresight.h                          |   5 +-
 15 files changed, 375 insertions(+), 162 deletions(-)

-- 
2.7.4
