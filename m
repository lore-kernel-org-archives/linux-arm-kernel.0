From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 20 Jul 2016 14:38:14 -0600
Subject: [PATCH V2 0/6] perf: Driver specific configuration for PMU
Message-ID: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the possiblity of specifying PMU driver configuration
directly from the perf command line.  Anything that falls within the
event specifiers '/.../' and that is preceeded by the '@' symbol is
treated as a configurable.  Two formats are supported, @cfg and
@cfg=config.

For example:

perf record -e some_event/@cfg1/ ...

or

perf record -e some_event/@cfg2=config/ ...

or

perf record -e some_event/@cfg1, at cfg2=config/ ...

The above are all valid configuration and will see the strings 'cfg1'
and 'cfg2=config' sent to the PMU driver for parsing and interpretation
using the existing ioctl() mechanism.

The primary customers for this feature are the CoreSight drivers where
the selection of a sink (where trace data is accumulated) needs to be
done in a previous, and separated step, from the launching of the perf
command.

As such something that used to be a two-step process:

# echo 1 > /sys/bus/coresight/devices/20070000.etr/enable_sink
# perf record -e cs_etm//u --per-thread  uname

is integrated in a single command:

# perf record -e cs_etm/@sink=20070000.etr/u --per-thread  uname

The patches include both the kernel and user space part so that the
solution is complete and found in a single place.

It is based on [1] and assumes this set [2] has been applied.

Thanks,
Mathieu

Changes for V2:
- Rebased to [1] as per Jiri's request.

[1]. git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
[2]. https://lkml.org/lkml/2016/7/20/519

Mathieu Poirier (6):
  perf/core: Adding PMU driver specific configuration
  perf: Passing struct perf_event to function setup_aux()
  perf tools: add infrastructure for PMU specific configuration
  perf tools: pushing driver configuration down to the kernel
  coresight: adding sink parameter to function coresight_build_path()
  coresight: etm-perf: incorporating sink definition from cmd line

 arch/x86/events/intel/bts.c                      |   4 +-
 arch/x86/events/intel/pt.c                       |   5 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c | 105 ++++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-priv.h     |   3 +-
 drivers/hwtracing/coresight/coresight.c          |  40 ++++++---
 include/linux/perf_event.h                       |  11 ++-
 include/uapi/linux/perf_event.h                  |   1 +
 kernel/events/core.c                             |  16 ++++
 kernel/events/ring_buffer.c                      |   2 +-
 tools/include/uapi/linux/perf_event.h            |   1 +
 tools/perf/builtin-record.c                      |   9 ++
 tools/perf/util/evlist.c                         |  24 ++++++
 tools/perf/util/evlist.h                         |   3 +
 tools/perf/util/evsel.c                          |  33 +++++++
 tools/perf/util/evsel.h                          |   7 ++
 tools/perf/util/parse-events.c                   |  76 +++++++++++-----
 tools/perf/util/parse-events.h                   |   1 +
 tools/perf/util/parse-events.l                   |  12 +++
 tools/perf/util/parse-events.y                   |  11 +++
 19 files changed, 321 insertions(+), 43 deletions(-)

-- 
2.7.4
