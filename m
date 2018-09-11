From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 11 Sep 2018 15:49:50 -0600
Subject: [PATCH 0/5] coresight: Output debug messages only in sysFS mode
Message-ID: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Status messages related to the establishment of paths between source and
sinks are not useful outside of a debugging environment and clogs the log
files needlessly.  They also trigger the lockdep mechanic when operating
from perf since they call output functions during process context switch.

This patch is fixing the problem by allowing debugging information to be
emitted only when operating from sysFS.  This doesn't change the 
debugging capability of the system since 1) everything that is done from
perf is built on top of the sysFS mode and 2) debugging output is
completely useless under perf.

Regards,
Mathieu 

Mathieu Poirier (5):
  coresight: Make path enable/disable aware of operation mode
  coresight: Make link components aware of operation mode
  coresight: Make sink disable functions aware of operation mode
  coresight: Define macro to replace dev_dbg() boiler plate code
  coresight: Allow drivers to be verbose only in sysFS mode

 .../coresight/coresight-dynamic-replicator.c       |  8 +++----
 drivers/hwtracing/coresight/coresight-etb10.c      |  8 +++----
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  4 ++--
 drivers/hwtracing/coresight/coresight-etm3x.c      |  7 ++++--
 drivers/hwtracing/coresight/coresight-etm4x.c      |  8 +++++--
 drivers/hwtracing/coresight/coresight-funnel.c     | 10 ++++----
 drivers/hwtracing/coresight/coresight-priv.h       |  9 +++++++-
 drivers/hwtracing/coresight/coresight-replicator.c |  8 +++----
 drivers/hwtracing/coresight/coresight-stm.c        |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    | 14 +++++------
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  4 ++--
 drivers/hwtracing/coresight/coresight-tpiu.c       |  6 ++---
 drivers/hwtracing/coresight/coresight.c            | 27 +++++++++++-----------
 include/linux/coresight.h                          |  8 ++++---
 14 files changed, 71 insertions(+), 52 deletions(-)

-- 
2.7.4
