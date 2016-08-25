From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 25 Aug 2016 14:20:40 -0600
Subject: [PATCH V6 0/5] perf: Driver specific configuration for PMU 
Message-ID: <1472156445-24283-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this latest revision the whole solution is kept in user space, using
the sysFS interface to communicate the sink information to the driver
rather than using an ioctl().

Patch 1, 2 and 3 have been ack'ed a while back and are included for
reference.  Patch 4 and 5 carry all the changes for this revision.


Original blurb:
---------------

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

# perf record -e cs_etm/@20070000.etr/u --per-thread  uname

Thanks,
Mathieu

Changes for V6:
- Using sysFS rather than an ioctl() to communicate command line
  parameters to the CoreSight PMU.

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


Mathieu Poirier (5):
  perf tools: making coresight PMU listable
  perf tools: adding coresight etm PMU record capabilities
  perf tools: add infrastructure for PMU specific configuration
  perf tools: Pushing configuration down to PMU driver
  perf tools: adding sink configuration for cs_etm PMU

 MAINTAINERS                              |   5 +
 tools/perf/Documentation/perf-record.txt |  12 +
 tools/perf/Makefile.config               |  11 +-
 tools/perf/arch/arm/util/Build           |   2 +
 tools/perf/arch/arm/util/auxtrace.c      |  54 +++
 tools/perf/arch/arm/util/cs-etm.c        | 617 +++++++++++++++++++++++++++++++
 tools/perf/arch/arm/util/cs-etm.h        |  26 ++
 tools/perf/arch/arm/util/pmu.c           |  37 ++
 tools/perf/arch/arm64/util/Build         |   4 +
 tools/perf/builtin-record.c              |   9 +
 tools/perf/builtin-stat.c                |   8 +
 tools/perf/builtin-top.c                 |  12 +
 tools/perf/util/auxtrace.c               |   1 +
 tools/perf/util/auxtrace.h               |   1 +
 tools/perf/util/cs-etm.h                 |  74 ++++
 tools/perf/util/evlist.c                 |  18 +
 tools/perf/util/evlist.h                 |   3 +
 tools/perf/util/evsel.c                  |  40 ++
 tools/perf/util/evsel.h                  |   4 +
 tools/perf/util/parse-events.c           |   7 +-
 tools/perf/util/parse-events.h           |   1 +
 tools/perf/util/parse-events.l           |  22 ++
 tools/perf/util/parse-events.y           |  11 +
 tools/perf/util/pmu.h                    |   2 +
 24 files changed, 976 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/arch/arm/util/auxtrace.c
 create mode 100644 tools/perf/arch/arm/util/cs-etm.c
 create mode 100644 tools/perf/arch/arm/util/cs-etm.h
 create mode 100644 tools/perf/arch/arm/util/pmu.c
 create mode 100644 tools/perf/util/cs-etm.h

-- 
2.7.4
