From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Oct 2017 18:15:36 +0100
Subject: [PATCH 00/17] coresight: perf: TMC ETR backend support
Message-ID: <20171019171553.24056-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TMC-ETR supports routing the Coresight trace data to the
System memory. It supports two different modes in which the memory
could be used.

1) Contiguous memory - The memory is assumed to be physically
contiguous.

2) Scatter Gather list - The memory can be chunks of 4K pages,
which are specified in a table of pointers which itself could be
multiple 4K size pages.

To avoid the complications of the managing the buffer, this series
adds a layer for managing the ETR buffer, which makes the best possibly
choice based on what is available. The allocation can be tuned by passing
in flags, existing pages (e.g, perf ring buffer) etc.

Towards supporting ETR Scatter Gather mode, we introduce a generic TMC
scatter-gather table which can be used to manage the data and table pages.
The table can be filled in the format expected by the Scatter-Gather
mode.

The TMC ETR-SG mechanism doesn't allow starting the trace at non-zero
offset (required by perf). So we make some tricky changes to the table
at run time to allow starting at any "Page aligned" offset and then
wrap around to the beginning of the buffer with very less overhead.
See patches for more description.

The series also improves the way the ETR is controlled by different modes
(sysfs vs. perf) by keeping mode specific data. This allows access
to the trace data collected in sysfs mode, even when the ETR is
operated in perf mode. Also with the transparent management of the
buffer and scatter-gather mechanism, we can allow the user to
request for larger trace buffers for sysfs mode. This is supported
by providing a sysfs file, "buffer_size" which accepts a page aligned
size, which will be used by the ETR when allocating a buffer.

Finally, it cleans up the etm perf sink callbacks a little bit and
then adds the support for ETR sink. For the ETR, we try our best to
use the perf ring buffer as the target hardware buffer, provided :
 1) The ETR is dma coherent (since the pages will be shared with
    userspace perf tool).
 2) The perf is used in snapshot mode (The ETR cannot be stopped
    based on the size of the data written hence we could easily
    overwrite the buffer. We may be able to fix this in the future)
 3) The ETR supports the Scatter-Gather mode.

If we can't use the perf buffers directly, we fallback to using
software buffering where we have to copy the trace data back
to the perf ring buffer.

Suzuki K Poulose (17):
  coresight etr: Disallow perf mode temporarily
  coresight tmc: Hide trace buffer handling for file read
  coresight: Add helper for inserting synchronization packets
  coresight: Add generic TMC sg table framework
  coresight: Add support for TMC ETR SG unit
  coresight: tmc: Make ETR SG table circular
  coresight: tmc etr: Add transparent buffer management
  coresight: tmc: Add configuration support for trace buffer size
  coresight: Convert driver messages to dev_dbg
  coresight: etr: Track if the device is coherent
  coresight etr: Handle driver mode specific ETR buffers
  coresight etr: Relax collection of trace from sysfs mode
  coresight etr: Do not clean ETR trace buffer
  coresight: etr: Add support for save restore buffers
  coresight: etr_buf: Add helper for padding an area of trace data
  coresight: perf: Remove reset_buffer call back for sinks
  coresight perf: Add ETR backend support for etm-perf

 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |    8 +
 .../coresight/coresight-dynamic-replicator.c       |    4 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |   72 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |    9 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |    4 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |    4 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |    4 +-
 drivers/hwtracing/coresight/coresight-priv.h       |    8 +
 drivers/hwtracing/coresight/coresight-replicator.c |    4 +-
 drivers/hwtracing/coresight/coresight-stm.c        |    4 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  109 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 1665 ++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.c        |   75 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |  128 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |    4 +-
 include/linux/coresight.h                          |    5 +-
 16 files changed, 1837 insertions(+), 270 deletions(-)

-- 
2.13.6
