From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 20 Jun 2017 10:50:46 +0200
Subject: [GIT PULL 00/23] perf/core improvements and fixes
In-Reply-To: <20170620015459.29381-1-acme@kernel.org>
References: <20170620015459.29381-1-acme@kernel.org>
Message-ID: <20170620085046.juccgaldhdh3fosl@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	I merged tip/perf/urgent into tip/perf/core before rebasing with these
> patches, please consider pulling, 
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 8052bd8243e823a0954bcbafda8f91072598f13d:
> 
>   Merge remote-tracking branch 'tip/perf/urgent' into perf/core (2017-06-19 15:14:35 -0300)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.13-20170719
> 
> for you to fetch changes up to dfe1c6d7efa8ead6878b73216d4c891a28207528:
> 
>   perf config: Refactor the code using 'ret' variable in cmd_config() (2017-06-19 22:05:55 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> User visible:
> 
> - Allow adding and removing fields to the default 'perf script' columns,
>   using + or - as field prefixes to do so (Andi Kleen)
> 
> - Display titles in left frame in the annotate browser (Jin Yao)
> 
> - Allow resolving the DSO name with 'perf script -F brstack{sym,off},dso'
>   (Mark Santaniello)
> 
> - Support function filtering in 'perf ftrace' (Namhyung Kim)
> 
> - Allow specifying function call depth in 'perf ftrace' (Namhyumg Kim)
> 
> Infrastructure:
> 
> - Adopt __noreturn, __printf, __scanf, noinline, __packed and __aligned
>   __alignment__(()) markers, to make the tools/ source code base to be
>   more compact and look more like kernel code (Arnaldo Carvalho de Melo)
> 
> - Remove unnecessary check in annotate_browser_write() (Jin Yao)
> 
> - Return arch from symbol__disassemble() so that callers, such as
>   the annotate TUI browser to use arch specific formattings, such
>   as the upcoming instruction micro-op fusion on Intel Core (Jin Yao)
> 
> - Remove superfluous check before use in the coresight code base (Kim
>   Phillips)
> 
> - Remove unused SAMPLE_SIZE defines and BTS priv array (Kim Phillips)
> 
> - Error handling fix/tidy ups in 'perf config' (Taeung Song)
> 
> - Avoid error in the BPF proggie built with clang in 'perf test llvm'
>   when PROFILE_ALL_BRANCHES is set (Wang Nan)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (1):
>       perf script: Allow adding and removing fields
> 
> Arnaldo Carvalho de Melo (7):
>       tools: Adopt __noreturn from kernel sources
>       tools: Adopt __printf from kernel sources
>       tools: Adopt __scanf from kernel sources
>       perf tools: Use __maybe_unused consistently
>       tools: Adopt noinline from kernel sources
>       tools: Adopt __packed from kernel sources
>       tools: Adopt __aligned from kernel sources
> 
> Jin Yao (3):
>       perf report: Remove unnecessary check in annotate_browser_write()
>       perf annotate browser: Display titles in left frame
>       perf annotate: Return arch from symbol__disassemble() and save it in browser
> 
> Kim Phillips (2):
>       perf coresight: Remove superfluous check before use
>       perf intel-pt/bts: Remove unused SAMPLE_SIZE defines and bts priv array
> 
> Mark Santaniello (2):
>       perf script: Support -F brstack,dso and brstacksym,dso
>       perf script: Support -F brstackoff,dso
> 
> Namhyung Kim (4):
>       perf ftrace: Show error message when fails to set ftrace files
>       perf ftrace: Move setup_pager before opening trace_pipe
>       perf ftrace: Add option for function filtering
>       perf ftrace: Add -D option for depth filter
> 
> Taeung Song (3):
>       perf config: Invert an if statement to reduce nesting in cmd_config()
>       perf config: Check error cases of {show_spec, set}_config()
>       perf config: Refactor the code using 'ret' variable in cmd_config()
> 
> Wang Nan (1):
>       perf test llvm: Avoid error when PROFILE_ALL_BRANCHES is set
> 
>  tools/include/linux/compiler-gcc.h                 |  10 ++
>  tools/include/linux/compiler.h                     |   4 +
>  tools/perf/Documentation/perf-ftrace.txt           |  33 +++++
>  tools/perf/Documentation/perf-script.txt           |  12 +-
>  tools/perf/arch/arm/util/cs-etm.c                  |  29 ++--
>  tools/perf/arch/x86/util/intel-bts.c               |   4 -
>  tools/perf/arch/x86/util/intel-pt.c                |   4 -
>  tools/perf/bench/numa.c                            |   2 +-
>  tools/perf/builtin-config.c                        |  67 +++++----
>  tools/perf/builtin-ftrace.c                        | 159 +++++++++++++++++++--
>  tools/perf/builtin-script.c                        | 146 +++++++++++++++++--
>  tools/perf/builtin-top.c                           |   2 +-
>  tools/perf/jvmti/jvmti_agent.h                     |   2 -
>  tools/perf/jvmti/libjvmti.c                        |   5 +-
>  tools/perf/pmu-events/jevents.c                    |   4 -
>  tools/perf/tests/bp_signal.c                       |   3 +-
>  tools/perf/tests/bp_signal_overflow.c              |   3 +-
>  tools/perf/tests/bpf-script-test-prologue.c        |   9 ++
>  tools/perf/tests/dwarf-unwind.c                    |  15 +-
>  tools/perf/ui/browsers/annotate.c                  |  54 ++++---
>  tools/perf/ui/gtk/annotate.c                       |   3 +-
>  tools/perf/util/annotate.c                         |  10 +-
>  tools/perf/util/annotate.h                         |   4 +-
>  tools/perf/util/cache.h                            |   3 +-
>  tools/perf/util/debug.h                            |  11 +-
>  tools/perf/util/evlist.h                           |   3 +-
>  tools/perf/util/evsel.c                            |   3 +-
>  tools/perf/util/genelf_debug.c                     |   5 +-
>  tools/perf/util/header.c                           |   3 +-
>  tools/perf/util/intel-bts.c                        |   2 -
>  tools/perf/util/intel-pt-decoder/intel-pt-log.h    |   4 +-
>  tools/perf/util/pmu.h                              |   4 +-
>  tools/perf/util/probe-event.h                      |   4 +-
>  .../util/scripting-engines/trace-event-python.c    |   3 +-
>  tools/perf/util/strbuf.h                           |   4 +-
>  tools/perf/util/usage.c                            |   6 +-
>  tools/perf/util/util.h                             |  18 +--
>  37 files changed, 496 insertions(+), 161 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
