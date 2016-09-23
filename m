From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 23 Sep 2016 07:22:46 +0200
Subject: [GIT PULL 00/15] perf/core improvements and fixes
In-Reply-To: <1474578779-14095-1-git-send-email-acme@kernel.org>
References: <1474578779-14095-1-git-send-email-acme@kernel.org>
Message-ID: <20160923052246.GA24145@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> The following changes since commit 89f1c2c59c4aef8e26edbc7db5175e6ffb0e9ec7:
> 
>   Merge tag 'perf-core-for-mingo-20160920' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2016-09-20 23:32:02 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-20160922
> 
> for you to fetch changes up to 2d831454140f28fa643b78deede4511b9e2c9e5f:
> 
>   perf hists: Make hists__fprintf_headers function global (2016-09-22 13:08:59 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements:
> 
> New features:
> 
> - Add support for interacting with Coresight PMU ETMs/PTMs, that are IP blocks
>   to perform hardware assisted tracing on a ARM CPU core (Mathieu Poirier)
> 
> Infrastructure:
> 
> - Histogram prep work for the upcoming c2c tool (Jiri Olsa)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Jiri Olsa (9):
>       perf evsel: Remove superfluous initialization of weight
>       perf hists: Use bigger buffer for stdio headers
>       perf hists: Add __hist_entry__snprintf function
>       perf tools: Make reset_dimensions global
>       perf tools: Make output_field_add and sort_dimension__add global
>       perf tools: Make several sorting functions global
>       perf tools: Make several display functions global
>       perf hists: Make __hist_entry__snprintf function global
>       perf hists: Make hists__fprintf_headers function global
> 
> Mathieu Poirier (6):
>       perf tools: Confine __get_cpuid() to x86 architecture
>       perf tools: Make coresight PMU listable
>       perf tools: Add coresight etm PMU record capabilities
>       perf pmu: Push configuration down to PMU driver
>       perf tools: Add PMU configuration to tools
>       perf tools: Add sink configuration for cs_etm PMU
> 
>  MAINTAINERS                         |   5 +
>  tools/perf/Makefile.config          |  11 +-
>  tools/perf/arch/arm/util/Build      |   2 +
>  tools/perf/arch/arm/util/auxtrace.c |  54 ++++
>  tools/perf/arch/arm/util/cs-etm.c   | 617 ++++++++++++++++++++++++++++++++++++
>  tools/perf/arch/arm/util/cs-etm.h   |  26 ++
>  tools/perf/arch/arm/util/pmu.c      |  36 +++
>  tools/perf/arch/arm64/util/Build    |   4 +
>  tools/perf/builtin-record.c         |  10 +
>  tools/perf/builtin-stat.c           |   9 +
>  tools/perf/builtin-top.c            |  13 +
>  tools/perf/ui/browsers/hists.c      |   2 +-
>  tools/perf/ui/hist.c                |   2 +-
>  tools/perf/ui/stdio/hist.c          |  14 +-
>  tools/perf/util/Build               |   1 +
>  tools/perf/util/auxtrace.c          |   1 +
>  tools/perf/util/auxtrace.h          |   1 +
>  tools/perf/util/cs-etm.h            |  74 +++++
>  tools/perf/util/drv_configs.c       |  77 +++++
>  tools/perf/util/drv_configs.h       |  26 ++
>  tools/perf/util/evsel.c             |   2 -
>  tools/perf/util/hist.h              |   5 +
>  tools/perf/util/pmu.h               |   2 +
>  tools/perf/util/sort.c              |  16 +-
>  tools/perf/util/sort.h              |  11 +
>  25 files changed, 1001 insertions(+), 20 deletions(-)
>  create mode 100644 tools/perf/arch/arm/util/auxtrace.c
>  create mode 100644 tools/perf/arch/arm/util/cs-etm.c
>  create mode 100644 tools/perf/arch/arm/util/cs-etm.h
>  create mode 100644 tools/perf/arch/arm/util/pmu.c
>  create mode 100644 tools/perf/util/cs-etm.h
>  create mode 100644 tools/perf/util/drv_configs.c
>  create mode 100644 tools/perf/util/drv_configs.h
> 
>   [root at zoo ~]# time dm
>    1  73.911 alpine:3.4: Ok
>    2  26.890 android-ndk:r12b-arm: Ok
>    3  77.833 archlinux:latest: Ok
>    4  40.814 centos:5: Ok
>    5  64.151 centos:6: Ok
>    6  75.720 centos:7: Ok
>    7  68.960 debian:7: Ok
>    8  75.606 debian:8: Ok
>    9  75.127 fedora:20: Ok
>   10  80.186 fedora:21: Ok
>   11  80.157 fedora:22: Ok
>   12  83.273 fedora:23: Ok
>   13  91.566 fedora:24: Ok
>   14  37.720 fedora:24-x-ARC-uClibc: Ok
>   15  98.492 fedora:rawhide: Ok
>   16 100.555 mageia:5: Ok
>   17  94.140 opensuse:13.2: Ok
>   18  95.476 opensuse:42.1: Ok
>   19 106.037 opensuse:tumbleweed: Ok
>   20  75.951 ubuntu:12.04.5: Ok
>   21  52.138 ubuntu:14.04: Ok
>   22  94.814 ubuntu:14.04.4: Ok
>   23  100.525 ubuntu:15.10: Ok
>   24  93.813 ubuntu:16.04: Ok
>   25  85.214 ubuntu:16.04-x-arm: Ok
>   26  83.487 ubuntu:16.04-x-arm64: Ok
>   27  82.918 ubuntu:16.04-x-powerpc64: Ok
>   28  84.189 ubuntu:16.04-x-powerpc64el: Ok
>   29  93.162 ubuntu:16.10: Ok
>   
>   real	38m13.568s
>   user	0m2.379s
>   sys	0m2.402s
>   [root at zoo ~]# 
> 
>   [root at jouet ~]# perf test
>    1: vmlinux symtab matches kallsyms                          : Ok
>    2: detect openat syscall event                              : Ok
>    3: detect openat syscall event on all cpus                  : Ok
>    4: read samples using the mmap interface                    : Ok
>    5: parse events tests                                       : Ok
>    6: Validate PERF_RECORD_* events & perf_sample fields       : Ok
>    7: Test perf pmu format parsing                             : Ok
>    8: Test dso data read                                       : Ok
>    9: Test dso data cache                                      : Ok
>   10: Test dso data reopen                                     : Ok
>   11: roundtrip evsel->name check                              : Ok
>   12: Check parsing of sched tracepoints fields                : Ok
>   13: Generate and check syscalls:sys_enter_openat event fields: Ok
>   14: struct perf_event_attr setup                             : Ok
>   15: Test matching and linking multiple hists                 : Ok
>   16: Try 'import perf' in python, checking link problems      : Ok
>   17: Test breakpoint overflow signal handler                  : Ok
>   18: Test breakpoint overflow sampling                        : Ok
>   19: Test number of exit event of a simple workload           : Ok
>   20: Test software clock events have valid period values      : Ok
>   21: Test object code reading                                 : Ok
>   22: Test sample parsing                                      : Ok
>   23: Test using a dummy software event to keep tracking       : Ok
>   24: Test parsing with no sample_id_all bit set               : Ok
>   25: Test filtering hist entries                              : Ok
>   26: Test mmap thread lookup                                  : Ok
>   27: Test thread mg sharing                                   : Ok
>   28: Test output sorting of hist entries                      : Ok
>   29: Test cumulation of child hist entries                    : Ok
>   30: Test tracking with sched_switch                          : Ok
>   31: Filter fds with revents mask in a fdarray                : Ok
>   32: Add fd to a fdarray, making it autogrow                  : Ok
>   33: Test kmod_path__parse function                           : Ok
>   34: Test thread map                                          : Ok
>   35: Test LLVM searching and compiling                        :
>   35.1: Basic BPF llvm compiling test                          : Ok
>   35.2: Test kbuild searching                                  : Ok
>   35.3: Compile source for BPF prologue generation test        : Ok
>   35.4: Compile source for BPF relocation test                 : Ok
>   36: Test topology in session                                 : Ok
>   37: Test BPF filter                                          :
>   37.1: Test basic BPF filtering                               : Ok
>   37.2: Test BPF prologue generation                           : Ok
>   37.3: Test BPF relocation checker                            : Ok
>   38: Test thread map synthesize                               : Ok
>   39: Test cpu map synthesize                                  : Ok
>   40: Test stat config synthesize                              : Ok
>   41: Test stat synthesize                                     : Ok
>   42: Test stat round synthesize                               : Ok
>   43: Test attr update synthesize                              : Ok
>   44: Test events times                                        : Ok
>   45: Test backward reading from ring buffer                   : Ok
>   46: Test cpu map print                                       : Ok
>   47: Test SDT event probing                                   : Ok
>   48: Test is_printable_array function                         : Ok
>   49: Test bitmap print                                        : Ok
>   50: x86 rdpmc test                                           : Ok
>   51: Test converting perf time to TSC                         : Ok
>   52: Test dwarf unwind                                        : Ok
>   53: Test x86 instruction decoder - new instructions          : Ok
>   54: Test intel cqm nmi context read                          : Skip
>   [root at jouet ~]#

Pulled, thanks a lot Arnaldo!

	Ingo
