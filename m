From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 17 Jan 2018 10:52:09 -0700
Subject: [PATCH v3 00/10] perf tools: Add support for CoreSight trace decoding
Message-ID: <1516211539-5166-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaldo,

This patchset adds support for per-thread CoreSight trace decoding from the
"perf report" interface.  It is largely modelled on what has been done for
intelPT traces and currently targets the ETMv4 architecture.  Support for
cpu-wide scenarios and ETMv3/PTMv1.1 will follow shortly.

The trace decoding support is done using the Open CoreSight Decoding
Library (openCSD), a stand alone open source project available here [1].
Integration of the openCSD library with the perf tools follow what has
been done for other support libraries.  If the library has been installed
on a system the build scripts will automatially include support for
CoreSight trace decoding.  The status of the library on the system is
displayed when adding the VF=1 option as per Jiri's patch [2]:

...			timerfd: [ on  ]
...			sched_getcpu: [ on  ]
...			sdt: [ OFF ]
...			setns: [ on  ]
...			libopencsd: [ on  ] <---

Instructions on how to build and install the openCSD library are provided
in the HOWTO.md of the project repository.  We elected to keep the decoder
library independent of the kernel tree as it is also used outside of the
perf toolset and various non-linux projects.

The work applies cleanly to [3] and depend on the following patches [4, 5].

Lastly there is a divergence of opinions on whether the decoding library
should be part of the kernel tree or live on its own as we chose to do -
your point of view on the matter would be greatly appreciated.

Regards,
Mathieu

[1]. https://github.com/Linaro/OpenCSD
[2]. https://marc.info/?l=linux-kernel&m=151549001914932&w=2
[3]. git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
[4]. https://marc.info/?l=linux-kernel&m=151561673423088&w=2
[5]. https://marc.info/?l=linux-kernel&m=151579875721440&w=2

Changes for V3:
. Rebased to Acme's latest tree (a72594ca5c70)
. Fixed indentation in Makefile.feature as per Jiri's request

Changes for V2:
. Rebased to Acme's latest (321e85e9458a)
. Following what has been done for libdw and libbabeltrace and added the
  possibililty to use alternate header/library for development purposes.


Mathieu Poirier (8):
  perf tools: Integrating the CoreSight decoding library
  perf tools: Add initial entry point for decoder CoreSight traces
  perf tools: Add decoder mechanic to support dumping trace data
  perf tools: Add support for decoding CoreSight trace data
  perf tools: Add functionality to communicate with the openCSD decoder
  pert tools: Add queue management functionality
  perf tools: Add full support for CoreSight trace decoding
  perf tools: Add mechanic to synthesise CoreSight trace packets

Tor Jeremiassen (2):
  perf tools: Add processing of coresight metadata
  MAINTAINERS: Adding entry for CoreSight trace decoding

 MAINTAINERS                                     |    3 +-
 tools/build/Makefile.feature                    |    3 +-
 tools/build/feature/Makefile                    |    7 +-
 tools/build/feature/test-all.c                  |    5 +
 tools/perf/Makefile.config                      |   25 +
 tools/perf/Makefile.perf                        |    2 +
 tools/perf/util/Build                           |    6 +
 tools/perf/util/auxtrace.c                      |    2 +
 tools/perf/util/cs-etm-decoder/Build            |    1 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  513 ++++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  105 +++
 tools/perf/util/cs-etm.c                        | 1023 +++++++++++++++++++++++
 tools/perf/util/cs-etm.h                        |   18 +
 13 files changed, 1710 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/util/cs-etm-decoder/Build
 create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
 create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
 create mode 100644 tools/perf/util/cs-etm.c

-- 
2.7.4
