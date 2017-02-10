From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 10 Feb 2017 08:38:04 +0100
Subject: [GIT PULL 00/32] perf/core improvements and fixes
In-Reply-To: <20170210013940.9998-1-acme@kernel.org>
References: <20170210013940.9998-1-acme@kernel.org>
Message-ID: <20170210073804.GA14923@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 53e74a112ce5c1c9b6a6923bdd6612133625d579:
> 
>   Merge tag 'perf-urgent-for-mingo-4.10-20170203' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2017-02-03 20:42:30 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.11-20170209
> 
> for you to fetch changes up to 7ea6856d6f5629d742edc23b8b76e6263371ef45:
> 
>   perf intel-pt: Use __fallthrough (2017-02-09 16:32:03 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> User visible:
> 
> - Add support for parsing Intel uncore vendor event files and add uncore
>   vendor events for the Intel server processors (Haswell, Broadwell,
>   IvyBridge), Xeon Phi (Knights Landing) and Broadwell DE (Andi Kleen)
> 
> - Support --symfs in 'perf probe' (Uwe Kleine-K?nig)
> 
> - Add support for generating bpf prologue on the aarch64 architecture (He Kuang)
> 
> - Show proper hint when SDT event not yet in place via 'perf probe' (Ravi Bangoria)
> 
> - Take into account symfs setting when reading file build ID (Victor Kamensky)
> 
> Infrastructure:
> 
> - Map gcc7's '__attribute__ ((fallthrough))', that warns when code
>   associated to case blocks in switches continue into the next case entry,
>   to '__falltrough' and use it where warned by gcc, tested on Fedora Rawhide
>   (Arnaldo Carvalho de Melo)
> 
> - Fix buffer sizes used with snprintf that could lead to truncation,
>   another warning introduced in gcc7 (Arnaldo Carvalho de Melo)
> 
> - Robustify do_generate_dynamic_list_file in libtraceevent (David Carrillo-Cisneros)
> 
> - Use zfree() in more places (Taeung Song)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (11):
>       perf jevents: Parse eventcode as number
>       perf jevents: Add support for parsing uncore json files
>       perf pmu: Support per pmu json aliases
>       perf pmu: Support event aliases for non cpu// pmus
>       perf list: Add debug support for outputing alias string
>       perf vendor events intel: Add uncore events for Haswell Server processor
>       perf vendor events intel: Add uncore events for Broadwell Server
>       perf vendor events intel: Add uncore events for IvyBridge Server
>       perf vendor events intel: Add uncore events for Sandy Bridge Server
>       perf vendor events intel: Add uncore events for Xeon Phi (Knights Landing)
>       perf vendor events intel: Add uncore events for Broadwell DE
> 
> Arnaldo Carvalho de Melo (11):
>       Merge remote-tracking branch 'tip/perf/urgent' into perf/core
>       perf tools: Fix include of linux/mman.h
>       tools include: Add a __fallthrough statement
>       tools string: Use __fallthrough in perf_atoll()
>       tools strfilter: Use __fallthrough
>       perf top: Use __fallthrough
>       perf thread_map: Correctly size buffer used with dirent->dt_name
>       perf header: Fix handling of PERF_EVENT_UPDATE__SCALE
>       perf bench numa: Avoid possible truncation when using snprintf()
>       perf tests: Avoid possible truncation with dirent->d_name + snprintf
>       perf intel-pt: Use __fallthrough
> 
> David Carrillo-Cisneros (1):
>       tools lib traceevent: Robustify do_generate_dynamic_list_file
> 
> He Kuang (2):
>       perf tools arm64: Add support for generating bpf prologue
>       perf bpf: Add missing newline in debug messages
> 
> Micka?l Sala?n (1):
>       tools lib bpf: Add missing header to the library
> 
> Ravi Bangoria (1):
>       perf sdt: Show proper hint when event not yet in place via 'perf probe'
> 
> Taeung Song (4):
>       perf tools: Only increase index if perf_evsel__new_idx() succeeds
>       perf tools: Add missing check for failure in a zalloc() call
>       perf tools: Use zfree() instead of ad hoc equivalent
>       perf tools: Use zfree() to avoid keeping dangling pointers
> 
> Uwe Kleine-K?nig (1):
>       perf probe: Add option --symfs
> 
> Victor Kamensky (1):
>       perf symbols: Take into account symfs setting when reading file build ID
> 
>  Makefile                                           |   6 +-
>  arch/x86/events/Makefile                           |  13 +-
>  arch/x86/events/amd/Makefile                       |   7 +
>  arch/x86/events/amd/uncore.c                       | 204 ++++++++-----
>  arch/x86/events/intel/pt.c                         |   6 +
>  include/linux/kprobes.h                            |  30 +-
>  include/linux/perf_event.h                         |   2 +-
>  kernel/events/core.c                               | 223 ++++++++------
>  kernel/extable.c                                   |   9 +-
>  kernel/kprobes.c                                   |  73 +++--
>  tools/arch/arm/include/uapi/asm/kvm.h              |   9 +
>  tools/arch/powerpc/include/uapi/asm/kvm.h          |   5 +
>  tools/arch/x86/include/asm/cpufeatures.h           |  11 +
>  tools/arch/x86/include/uapi/asm/vmx.h              |   5 +
>  tools/build/Makefile.build                         |  10 +
>  tools/include/linux/compiler.h                     |   9 +
>  tools/lib/api/fs/fs.c                              |  16 +
>  tools/lib/api/fs/fs.h                              |   1 +
>  tools/lib/api/fs/tracing_path.c                    |  32 +-
>  tools/lib/bpf/bpf.h                                |   1 +
>  tools/lib/bpf/libbpf.c                             | 264 +++++++++++++++--
>  tools/lib/bpf/libbpf.h                             |  19 +-
>  tools/lib/subcmd/parse-options.h                   |  19 +-
>  tools/lib/traceevent/Makefile                      |  14 +-
>  tools/perf/Build                                   |   5 +-
>  tools/perf/Documentation/perf-c2c.txt              |   2 +-
>  tools/perf/Documentation/perf-ftrace.txt           |  36 +++
>  tools/perf/Documentation/perf-kallsyms.txt         |  24 ++
>  tools/perf/Documentation/perf-record.txt           |  14 +-
>  tools/perf/Documentation/perf-sched.txt            |   2 +
>  tools/perf/Documentation/perf-script.txt           |   4 +-
>  tools/perf/Documentation/perf-trace.txt            |   8 +-
>  tools/perf/Makefile.config                         |   6 +-
>  tools/perf/Makefile.perf                           |   1 +
>  tools/perf/arch/arm64/Makefile                     |   1 +
>  tools/perf/arch/arm64/include/dwarf-regs-table.h   |  12 +-
>  tools/perf/arch/arm64/util/dwarf-regs.c            |  15 +-
>  tools/perf/bench/numa.c                            |   6 +-
>  tools/perf/builtin-c2c.c                           |   3 +-
>  tools/perf/builtin-ftrace.c                        | 265 +++++++++++++++++
>  tools/perf/builtin-help.c                          |   8 +-
>  tools/perf/builtin-kallsyms.c                      |  67 +++++
>  tools/perf/builtin-kmem.c                          |   8 +-
>  tools/perf/builtin-list.c                          |   3 +
>  tools/perf/builtin-probe.c                         |   2 +
>  tools/perf/builtin-record.c                        | 158 +++++++++-
>  tools/perf/builtin-report.c                        |   4 +-
>  tools/perf/builtin-sched.c                         | 130 ++++++++-
>  tools/perf/builtin-script.c                        |   3 +-
>  tools/perf/builtin-top.c                           |   6 +-
>  tools/perf/builtin-trace.c                         | 120 ++++++--
>  tools/perf/builtin.h                               |   2 +
>  tools/perf/command-list.txt                        |   2 +
>  tools/perf/perf.c                                  |  20 +-
>  .../arch/x86/broadwellde/uncore-cache.json         | 317 ++++++++++++++++++++
>  .../arch/x86/broadwellde/uncore-memory.json        |  83 ++++++
>  .../arch/x86/broadwellde/uncore-power.json         |  84 ++++++
>  .../arch/x86/broadwellx/uncore-cache.json          | 317 ++++++++++++++++++++
>  .../arch/x86/broadwellx/uncore-interconnect.json   |  28 ++
>  .../arch/x86/broadwellx/uncore-memory.json         |  83 ++++++
>  .../arch/x86/broadwellx/uncore-power.json          |  84 ++++++
>  .../pmu-events/arch/x86/haswellx/uncore-cache.json | 317 ++++++++++++++++++++
>  .../arch/x86/haswellx/uncore-interconnect.json     |  28 ++
>  .../arch/x86/haswellx/uncore-memory.json           |  83 ++++++
>  .../pmu-events/arch/x86/haswellx/uncore-power.json |  84 ++++++
>  .../pmu-events/arch/x86/ivytown/uncore-cache.json  | 322 +++++++++++++++++++++
>  .../arch/x86/ivytown/uncore-interconnect.json      |  46 +++
>  .../pmu-events/arch/x86/ivytown/uncore-memory.json |  75 +++++
>  .../pmu-events/arch/x86/ivytown/uncore-power.json  | 249 ++++++++++++++++
>  .../pmu-events/arch/x86/jaketown/uncore-cache.json | 209 +++++++++++++
>  .../arch/x86/jaketown/uncore-interconnect.json     |  46 +++
>  .../arch/x86/jaketown/uncore-memory.json           |  79 +++++
>  .../pmu-events/arch/x86/jaketown/uncore-power.json | 248 ++++++++++++++++
>  .../arch/x86/knightslanding/uncore-memory.json     |  42 +++
>  tools/perf/pmu-events/jevents.c                    |  84 +++++-
>  tools/perf/pmu-events/jevents.h                    |   4 +-
>  tools/perf/pmu-events/pmu-events.h                 |   3 +
>  tools/perf/tests/Build                             |   1 +
>  tools/perf/tests/bpf.c                             |  42 ++-
>  tools/perf/tests/builtin-test.c                    |   4 +
>  tools/perf/tests/llvm.c                            |   2 +-
>  tools/perf/tests/parse-events.c                    |   8 +-
>  tools/perf/tests/tests.h                           |   1 +
>  tools/perf/tests/unit_number__scnprintf.c          |  37 +++
>  tools/perf/ui/browsers/hists.c                     |  60 ++--
>  tools/perf/ui/setup.c                              |   1 +
>  tools/perf/util/Build                              |   1 +
>  tools/perf/util/bpf-loader.c                       |   4 +-
>  tools/perf/util/callchain.c                        |  16 +-
>  tools/perf/util/config.c                           |  23 +-
>  tools/perf/util/data-convert-bt.c                  |   7 +-
>  tools/perf/util/dso.c                              |  48 ++-
>  tools/perf/util/event.c                            |   2 +-
>  tools/perf/util/evlist.c                           |  12 +-
>  tools/perf/util/evlist.h                           |   2 +
>  tools/perf/util/header.c                           |   7 +-
>  tools/perf/util/hist.c                             |   4 +-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   5 +
>  .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |   2 +
>  tools/perf/util/intel-pt.c                         |   4 +-
>  tools/perf/util/llvm-utils.c                       |   4 +-
>  tools/perf/util/machine.c                          |  19 ++
>  tools/perf/util/machine.h                          |   1 +
>  tools/perf/util/parse-events.c                     |  69 +++--
>  tools/perf/util/parse-events.y                     |  35 ++-
>  tools/perf/util/pmu.c                              | 109 ++++---
>  tools/perf/util/pmu.h                              |   1 +
>  tools/perf/util/probe-event.c                      |  11 +-
>  .../perf/util/scripting-engines/trace-event-perl.c |   6 +-
>  tools/perf/util/session.c                          |   2 +-
>  tools/perf/util/strfilter.c                        |   1 +
>  tools/perf/util/string.c                           |   2 +
>  tools/perf/util/symbol.c                           |   6 +-
>  tools/perf/util/thread_map.c                       |   2 +-
>  tools/perf/util/trace-event-info.c                 |  71 +++--
>  tools/perf/util/trace-event-parse.c                |  17 ++
>  tools/perf/util/trace-event-read.c                 |  77 ++++-
>  tools/perf/util/trace-event.h                      |   1 +
>  tools/perf/util/unwind-libunwind-local.c           |  54 +++-
>  tools/perf/util/util.c                             |  15 +-
>  tools/perf/util/util.h                             |   3 +-
>  tools/scripts/Makefile.include                     |  12 +-
>  122 files changed, 5101 insertions(+), 550 deletions(-)
>  create mode 100644 arch/x86/events/amd/Makefile
>  create mode 100644 tools/perf/Documentation/perf-ftrace.txt
>  create mode 100644 tools/perf/Documentation/perf-kallsyms.txt
>  create mode 100644 tools/perf/builtin-ftrace.c
>  create mode 100644 tools/perf/builtin-kallsyms.c
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
>  create mode 100644 tools/perf/tests/unit_number__scnprintf.c

Pulled, thanks a lot Arnaldo!

	Ingo
