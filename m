From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 16 Sep 2016 09:49:57 -0600
Subject: [PATCH V8 0/7] perf: Driver specific configuration for PMU
Message-ID: <1474041004-13956-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This iteration split the __get_cpuid() work in the main Makefile and 
moves the driver configuration code out of file evlist.c and evsel.c so
that `perf test python` can succeed.  Other than moving things around
this set is keeping the code and functionality unchanged. 

Also tested with `make -C tool/perf build-test`

Thanks,
Mathieu


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

---
Changes for V8:
- Splitted what used to be 1/5 in the V7 patchset. 
- Moved code around to avoid failing 'perf test pythong'.
- Tested with `make -C tool/perf build-test`.

Changes for V7:
- Got rid of a miscellaneous debug message.
- Rebased to v4.8-rc4
- Added Jiri Olsa's Acked-by.

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


Mathieu Poirier (7):
  perf tools: confining __get_cpuid() to x86 architecture
  perf tools: making coresight PMU listable
  perf tools: adding coresight etm PMU record capabilities
  perf tools: add infrastructure for PMU specific configuration
  perf tools: pushing configuration down to PMU driver
  perf tools: adding PMU configuration to tools
  perf tools: adding sink configuration for cs_etm PMU

 MAINTAINERS                              |   5 +
 tools/perf/Documentation/perf-record.txt |  12 +
 tools/perf/Makefile.config               |  11 +-
 tools/perf/arch/arm/util/Build           |   2 +
 tools/perf/arch/arm/util/auxtrace.c      |  54 +++
 tools/perf/arch/arm/util/cs-etm.c        | 617 +++++++++++++++++++++++++++++++
 tools/perf/arch/arm/util/cs-etm.h        |  26 ++
 tools/perf/arch/arm/util/pmu.c           |  36 ++
 tools/perf/arch/arm64/util/Build         |   4 +
 tools/perf/builtin-record.c              |  10 +
 tools/perf/builtin-stat.c                |   9 +
 tools/perf/builtin-top.c                 |  13 +
 tools/perf/util/Build                    |   1 +
 tools/perf/util/auxtrace.c               |   1 +
 tools/perf/util/auxtrace.h               |   1 +
 tools/perf/util/cs-etm.h                 |  74 ++++
 tools/perf/util/drv_configs.c            |  77 ++++
 tools/perf/util/drv_configs.h            |  26 ++
 tools/perf/util/evsel.h                  |   2 +
 tools/perf/util/parse-events.c           |   7 +-
 tools/perf/util/parse-events.h           |   1 +
 tools/perf/util/parse-events.l           |  22 ++
 tools/perf/util/parse-events.y           |  11 +
 tools/perf/util/pmu.h                    |   2 +
 24 files changed, 1019 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/arch/arm/util/auxtrace.c
 create mode 100644 tools/perf/arch/arm/util/cs-etm.c
 create mode 100644 tools/perf/arch/arm/util/cs-etm.h
 create mode 100644 tools/perf/arch/arm/util/pmu.c
 create mode 100644 tools/perf/util/cs-etm.h
 create mode 100644 tools/perf/util/drv_configs.c
 create mode 100644 tools/perf/util/drv_configs.h

-- 
2.7.4
