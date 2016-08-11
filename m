From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 11 Aug 2016 10:20:55 -0600
Subject: [PATCH V5 0/9] perf: Driver specific configuration for PMU
Message-ID: <1470932464-726-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fifth revision mostly address a comment by Peter Z. to do the initial
configuration option parsing in the perf core rather than individual
drivers.  Further parsing is still needed in the PMU since configuration
options are driver specific.  Let's use this as new starting point for
further enhancement (as I am sure some will be needed).

A patch documenting the new ioctl() will be sent out immediately after this
one.

I have also taken the liberty to roll in this set another serie[1] that was
not picked up for the 4.8 cycle.  This is based on mainline 4.8-rc1 since[2]
is still on 4.7.

This patchset adds the possiblity of specifying PMU driver configuration
directly from the perf command line.  Anything that falls within the
event specifiers '/.../' and that is preceded by the '@' symbol is
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

Thanks,
Mathieu

Changes for V5:
- Made commit log in 5/9 more descriptive.
- Addressed missing return code in builtin-top.c.
- Overhauled the kernel portion to do parsing in the core.

Changes for V4:
- Pushing PMU driver configuration for 'perf top'.
- Rebased to the latest perf/core branch[1]. 

Changes for V3:
- Added comment for function drv_str() that explains the reason for
  keeping the entire token intact.
- Added driver config terms to the existing list of config terms.
- Added documenation for driver specific configuration.
- Pushing PMU driver configuration for 'perf stat' as well.  
- Preventing users from selecting a sink from sysFS _and_ perf.

Changes for V2:
- Rebased to [1] as per Jiri's request.

[1]. https://lkml.org/lkml/2016/7/20/519
[2]. git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core

Mathieu Poirier (9):
  tools: Copy the header file needed by perf tools
  perf tools: making coresight PMU listable
  perf tools: adding coresight etm PMU record capabilities
  perf/core: Adding PMU driver specific configuration
  perf: Passing struct perf_event to function setup_aux()
  perf tools: add infrastructure for PMU specific configuration
  perf tools: pushing driver configuration down to the kernel
  coresight: adding sink parameter to function coresight_build_path()
  coresight: etm-perf: incorporating sink definition from cmd line

 MAINTAINERS                                      |   5 +
 arch/x86/events/intel/bts.c                      |   4 +-
 arch/x86/events/intel/pt.c                       |   5 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c | 143 +++++-
 drivers/hwtracing/coresight/coresight-priv.h     |   3 +-
 drivers/hwtracing/coresight/coresight.c          |  43 +-
 include/linux/perf_event.h                       |  33 +-
 include/uapi/linux/perf_event.h                  |   1 +
 kernel/events/core.c                             | 179 +++++++-
 kernel/events/ring_buffer.c                      |   2 +-
 tools/include/linux/coresight-pmu.h              |  39 ++
 tools/include/uapi/linux/perf_event.h            |   1 +
 tools/perf/Documentation/perf-record.txt         |  12 +
 tools/perf/MANIFEST                              |   1 +
 tools/perf/Makefile.config                       |  11 +-
 tools/perf/Makefile.perf                         |   3 +
 tools/perf/arch/arm/util/Build                   |   2 +
 tools/perf/arch/arm/util/auxtrace.c              |  54 +++
 tools/perf/arch/arm/util/cs-etm.c                | 559 +++++++++++++++++++++++
 tools/perf/arch/arm/util/cs-etm.h                |  23 +
 tools/perf/arch/arm/util/pmu.c                   |  34 ++
 tools/perf/arch/arm64/util/Build                 |   4 +
 tools/perf/builtin-record.c                      |   9 +
 tools/perf/builtin-stat.c                        |   8 +
 tools/perf/builtin-top.c                         |  12 +
 tools/perf/util/auxtrace.c                       |   1 +
 tools/perf/util/auxtrace.h                       |   1 +
 tools/perf/util/cs-etm.h                         |  74 +++
 tools/perf/util/evlist.c                         |  21 +
 tools/perf/util/evlist.h                         |   3 +
 tools/perf/util/evsel.c                          |  24 +
 tools/perf/util/evsel.h                          |   5 +
 tools/perf/util/parse-events.c                   |   7 +-
 tools/perf/util/parse-events.h                   |   1 +
 tools/perf/util/parse-events.l                   |  22 +
 tools/perf/util/parse-events.y                   |  11 +
 36 files changed, 1331 insertions(+), 29 deletions(-)
 create mode 100644 tools/include/linux/coresight-pmu.h
 create mode 100644 tools/perf/arch/arm/util/auxtrace.c
 create mode 100644 tools/perf/arch/arm/util/cs-etm.c
 create mode 100644 tools/perf/arch/arm/util/cs-etm.h
 create mode 100644 tools/perf/arch/arm/util/pmu.c
 create mode 100644 tools/perf/util/cs-etm.h

-- 
2.7.4
