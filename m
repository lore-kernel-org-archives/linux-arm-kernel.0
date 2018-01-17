From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Wed, 17 Jan 2018 17:04:40 -0300
Subject: [PATCH v3 00/10] perf tools: Add support for CoreSight trace
 decoding
In-Reply-To: <1516211539-5166-1-git-send-email-mathieu.poirier@linaro.org>
References: <1516211539-5166-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20180117200440.GH12842@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Wed, Jan 17, 2018 at 10:52:09AM -0700, Mathieu Poirier escreveu:
> Hi Arnaldo,
> 
> This patchset adds support for per-thread CoreSight trace decoding from the
> "perf report" interface.  It is largely modelled on what has been done for
> intelPT traces and currently targets the ETMv4 architecture.  Support for
> cpu-wide scenarios and ETMv3/PTMv1.1 will follow shortly.
> 
> The trace decoding support is done using the Open CoreSight Decoding
> Library (openCSD), a stand alone open source project available here [1].
> Integration of the openCSD library with the perf tools follow what has
> been done for other support libraries.  If the library has been installed
> on a system the build scripts will automatially include support for
> CoreSight trace decoding.  The status of the library on the system is
> displayed when adding the VF=1 option as per Jiri's patch [2]:
> 
> ...			timerfd: [ on  ]
> ...			sched_getcpu: [ on  ]
> ...			sdt: [ OFF ]
> ...			setns: [ on  ]
> ...			libopencsd: [ on  ] <---
> 
> Instructions on how to build and install the openCSD library are provided
> in the HOWTO.md of the project repository.  We elected to keep the decoder
> library independent of the kernel tree as it is also used outside of the
> perf toolset and various non-linux projects.
> 
> The work applies cleanly to [3] and depend on the following patches [4, 5].
> 
> Lastly there is a divergence of opinions on whether the decoding library
> should be part of the kernel tree or live on its own as we chose to do -
> your point of view on the matter would be greatly appreciated.

We have all sorts of models with perf:

1) Code that perf has that other projects expressed interest in using in
the past but that we so far failed to make generic in a way that
external projects could use, with proper versioning, etc.

It lives in tools/perf/util/ but should move to tools/lib/ while
transitioning in the direction of a lib external projects could use
(evsel, evlist, for instance). I'm not in a hurry to make that happen,
lots of other stuff sucking my time.

2) Code that we moved to tools/lib/ and that are since being used by
other projects, such as tools/lib/subcmd/ that is used by tools/objtool/

3) Code that we started directly in tools/lib/ and that now are even
maintained outside the perf tools group, but continue being used by
perf, such as tools/lib/bpf/

4) Code that we try to share with the kernel, but using a copy that we
automatically check for drift so that we can analyse how to update our
copy, such as tools/include/ and tools/lib/rbtree.c

And of course we use a ton of external libraries, some that are mature,
like the elf libraries and that probably people are used to have
installed already and some that are more recent, like libbabeltrace.

Then there is the public you want to please, how easy they will find to
use your work, think of what would happen if Linus Torvalds or Ingo
Molnar would try to, out of the blue, use this ARM trace decoding
support in perf, would they get it working super fast and without the
slighest amount of hassle?

If you think they would be pleased, you're on to a winner! :-)

- Arnaldo

> Regards,
> Mathieu
> 
> [1]. https://github.com/Linaro/OpenCSD
> [2]. https://marc.info/?l=linux-kernel&m=151549001914932&w=2
> [3]. git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
> [4]. https://marc.info/?l=linux-kernel&m=151561673423088&w=2
> [5]. https://marc.info/?l=linux-kernel&m=151579875721440&w=2
> 
> Changes for V3:
> . Rebased to Acme's latest tree (a72594ca5c70)
> . Fixed indentation in Makefile.feature as per Jiri's request
> 
> Changes for V2:
> . Rebased to Acme's latest (321e85e9458a)
> . Following what has been done for libdw and libbabeltrace and added the
>   possibililty to use alternate header/library for development purposes.
> 
> 
> Mathieu Poirier (8):
>   perf tools: Integrating the CoreSight decoding library
>   perf tools: Add initial entry point for decoder CoreSight traces
>   perf tools: Add decoder mechanic to support dumping trace data
>   perf tools: Add support for decoding CoreSight trace data
>   perf tools: Add functionality to communicate with the openCSD decoder
>   pert tools: Add queue management functionality
>   perf tools: Add full support for CoreSight trace decoding
>   perf tools: Add mechanic to synthesise CoreSight trace packets
> 
> Tor Jeremiassen (2):
>   perf tools: Add processing of coresight metadata
>   MAINTAINERS: Adding entry for CoreSight trace decoding
> 
>  MAINTAINERS                                     |    3 +-
>  tools/build/Makefile.feature                    |    3 +-
>  tools/build/feature/Makefile                    |    7 +-
>  tools/build/feature/test-all.c                  |    5 +
>  tools/perf/Makefile.config                      |   25 +
>  tools/perf/Makefile.perf                        |    2 +
>  tools/perf/util/Build                           |    6 +
>  tools/perf/util/auxtrace.c                      |    2 +
>  tools/perf/util/cs-etm-decoder/Build            |    1 +
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  513 ++++++++++++
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  105 +++
>  tools/perf/util/cs-etm.c                        | 1023 +++++++++++++++++++++++
>  tools/perf/util/cs-etm.h                        |   18 +
>  13 files changed, 1710 insertions(+), 3 deletions(-)
>  create mode 100644 tools/perf/util/cs-etm-decoder/Build
>  create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>  create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>  create mode 100644 tools/perf/util/cs-etm.c
> 
> -- 
> 2.7.4
