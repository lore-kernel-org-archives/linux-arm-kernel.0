From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu,  9 Feb 2017 22:39:08 -0300
Subject: [GIT PULL 00/32] perf/core improvements and fixes
Message-ID: <20170210013940.9998-1-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 53e74a112ce5c1c9b6a6923bdd6612133625d579:

  Merge tag 'perf-urgent-for-mingo-4.10-20170203' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2017-02-03 20:42:30 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.11-20170209

for you to fetch changes up to 7ea6856d6f5629d742edc23b8b76e6263371ef45:

  perf intel-pt: Use __fallthrough (2017-02-09 16:32:03 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

User visible:

- Add support for parsing Intel uncore vendor event files and add uncore
  vendor events for the Intel server processors (Haswell, Broadwell,
  IvyBridge), Xeon Phi (Knights Landing) and Broadwell DE (Andi Kleen)

- Support --symfs in 'perf probe' (Uwe Kleine-K?nig)

- Add support for generating bpf prologue on the aarch64 architecture (He Kuang)

- Show proper hint when SDT event not yet in place via 'perf probe' (Ravi Bangoria)

- Take into account symfs setting when reading file build ID (Victor Kamensky)

Infrastructure:

- Map gcc7's '__attribute__ ((fallthrough))', that warns when code
  associated to case blocks in switches continue into the next case entry,
  to '__falltrough' and use it where warned by gcc, tested on Fedora Rawhide
  (Arnaldo Carvalho de Melo)

- Fix buffer sizes used with snprintf that could lead to truncation,
  another warning introduced in gcc7 (Arnaldo Carvalho de Melo)

- Robustify do_generate_dynamic_list_file in libtraceevent (David Carrillo-Cisneros)

- Use zfree() in more places (Taeung Song)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (11):
      perf jevents: Parse eventcode as number
      perf jevents: Add support for parsing uncore json files
      perf pmu: Support per pmu json aliases
      perf pmu: Support event aliases for non cpu// pmus
      perf list: Add debug support for outputing alias string
      perf vendor events intel: Add uncore events for Haswell Server processor
      perf vendor events intel: Add uncore events for Broadwell Server
      perf vendor events intel: Add uncore events for IvyBridge Server
      perf vendor events intel: Add uncore events for Sandy Bridge Server
      perf vendor events intel: Add uncore events for Xeon Phi (Knights Landing)
      perf vendor events intel: Add uncore events for Broadwell DE

Arnaldo Carvalho de Melo (11):
      Merge remote-tracking branch 'tip/perf/urgent' into perf/core
      perf tools: Fix include of linux/mman.h
      tools include: Add a __fallthrough statement
      tools string: Use __fallthrough in perf_atoll()
      tools strfilter: Use __fallthrough
      perf top: Use __fallthrough
      perf thread_map: Correctly size buffer used with dirent->dt_name
      perf header: Fix handling of PERF_EVENT_UPDATE__SCALE
      perf bench numa: Avoid possible truncation when using snprintf()
      perf tests: Avoid possible truncation with dirent->d_name + snprintf
      perf intel-pt: Use __fallthrough

David Carrillo-Cisneros (1):
      tools lib traceevent: Robustify do_generate_dynamic_list_file

He Kuang (2):
      perf tools arm64: Add support for generating bpf prologue
      perf bpf: Add missing newline in debug messages

Micka?l Sala?n (1):
      tools lib bpf: Add missing header to the library

Ravi Bangoria (1):
      perf sdt: Show proper hint when event not yet in place via 'perf probe'

Taeung Song (4):
      perf tools: Only increase index if perf_evsel__new_idx() succeeds
      perf tools: Add missing check for failure in a zalloc() call
      perf tools: Use zfree() instead of ad hoc equivalent
      perf tools: Use zfree() to avoid keeping dangling pointers

Uwe Kleine-K?nig (1):
      perf probe: Add option --symfs

Victor Kamensky (1):
      perf symbols: Take into account symfs setting when reading file build ID

 Makefile                                           |   6 +-
 arch/x86/events/Makefile                           |  13 +-
 arch/x86/events/amd/Makefile                       |   7 +
 arch/x86/events/amd/uncore.c                       | 204 ++++++++-----
 arch/x86/events/intel/pt.c                         |   6 +
 include/linux/kprobes.h                            |  30 +-
 include/linux/perf_event.h                         |   2 +-
 kernel/events/core.c                               | 223 ++++++++------
 kernel/extable.c                                   |   9 +-
 kernel/kprobes.c                                   |  73 +++--
 tools/arch/arm/include/uapi/asm/kvm.h              |   9 +
 tools/arch/powerpc/include/uapi/asm/kvm.h          |   5 +
 tools/arch/x86/include/asm/cpufeatures.h           |  11 +
 tools/arch/x86/include/uapi/asm/vmx.h              |   5 +
 tools/build/Makefile.build                         |  10 +
 tools/include/linux/compiler.h                     |   9 +
 tools/lib/api/fs/fs.c                              |  16 +
 tools/lib/api/fs/fs.h                              |   1 +
 tools/lib/api/fs/tracing_path.c                    |  32 +-
 tools/lib/bpf/bpf.h                                |   1 +
 tools/lib/bpf/libbpf.c                             | 264 +++++++++++++++--
 tools/lib/bpf/libbpf.h                             |  19 +-
 tools/lib/subcmd/parse-options.h                   |  19 +-
 tools/lib/traceevent/Makefile                      |  14 +-
 tools/perf/Build                                   |   5 +-
 tools/perf/Documentation/perf-c2c.txt              |   2 +-
 tools/perf/Documentation/perf-ftrace.txt           |  36 +++
 tools/perf/Documentation/perf-kallsyms.txt         |  24 ++
 tools/perf/Documentation/perf-record.txt           |  14 +-
 tools/perf/Documentation/perf-sched.txt            |   2 +
 tools/perf/Documentation/perf-script.txt           |   4 +-
 tools/perf/Documentation/perf-trace.txt            |   8 +-
 tools/perf/Makefile.config                         |   6 +-
 tools/perf/Makefile.perf                           |   1 +
 tools/perf/arch/arm64/Makefile                     |   1 +
 tools/perf/arch/arm64/include/dwarf-regs-table.h   |  12 +-
 tools/perf/arch/arm64/util/dwarf-regs.c            |  15 +-
 tools/perf/bench/numa.c                            |   6 +-
 tools/perf/builtin-c2c.c                           |   3 +-
 tools/perf/builtin-ftrace.c                        | 265 +++++++++++++++++
 tools/perf/builtin-help.c                          |   8 +-
 tools/perf/builtin-kallsyms.c                      |  67 +++++
 tools/perf/builtin-kmem.c                          |   8 +-
 tools/perf/builtin-list.c                          |   3 +
 tools/perf/builtin-probe.c                         |   2 +
 tools/perf/builtin-record.c                        | 158 +++++++++-
 tools/perf/builtin-report.c                        |   4 +-
 tools/perf/builtin-sched.c                         | 130 ++++++++-
 tools/perf/builtin-script.c                        |   3 +-
 tools/perf/builtin-top.c                           |   6 +-
 tools/perf/builtin-trace.c                         | 120 ++++++--
 tools/perf/builtin.h                               |   2 +
 tools/perf/command-list.txt                        |   2 +
 tools/perf/perf.c                                  |  20 +-
 .../arch/x86/broadwellde/uncore-cache.json         | 317 ++++++++++++++++++++
 .../arch/x86/broadwellde/uncore-memory.json        |  83 ++++++
 .../arch/x86/broadwellde/uncore-power.json         |  84 ++++++
 .../arch/x86/broadwellx/uncore-cache.json          | 317 ++++++++++++++++++++
 .../arch/x86/broadwellx/uncore-interconnect.json   |  28 ++
 .../arch/x86/broadwellx/uncore-memory.json         |  83 ++++++
 .../arch/x86/broadwellx/uncore-power.json          |  84 ++++++
 .../pmu-events/arch/x86/haswellx/uncore-cache.json | 317 ++++++++++++++++++++
 .../arch/x86/haswellx/uncore-interconnect.json     |  28 ++
 .../arch/x86/haswellx/uncore-memory.json           |  83 ++++++
 .../pmu-events/arch/x86/haswellx/uncore-power.json |  84 ++++++
 .../pmu-events/arch/x86/ivytown/uncore-cache.json  | 322 +++++++++++++++++++++
 .../arch/x86/ivytown/uncore-interconnect.json      |  46 +++
 .../pmu-events/arch/x86/ivytown/uncore-memory.json |  75 +++++
 .../pmu-events/arch/x86/ivytown/uncore-power.json  | 249 ++++++++++++++++
 .../pmu-events/arch/x86/jaketown/uncore-cache.json | 209 +++++++++++++
 .../arch/x86/jaketown/uncore-interconnect.json     |  46 +++
 .../arch/x86/jaketown/uncore-memory.json           |  79 +++++
 .../pmu-events/arch/x86/jaketown/uncore-power.json | 248 ++++++++++++++++
 .../arch/x86/knightslanding/uncore-memory.json     |  42 +++
 tools/perf/pmu-events/jevents.c                    |  84 +++++-
 tools/perf/pmu-events/jevents.h                    |   4 +-
 tools/perf/pmu-events/pmu-events.h                 |   3 +
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/bpf.c                             |  42 ++-
 tools/perf/tests/builtin-test.c                    |   4 +
 tools/perf/tests/llvm.c                            |   2 +-
 tools/perf/tests/parse-events.c                    |   8 +-
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/tests/unit_number__scnprintf.c          |  37 +++
 tools/perf/ui/browsers/hists.c                     |  60 ++--
 tools/perf/ui/setup.c                              |   1 +
 tools/perf/util/Build                              |   1 +
 tools/perf/util/bpf-loader.c                       |   4 +-
 tools/perf/util/callchain.c                        |  16 +-
 tools/perf/util/config.c                           |  23 +-
 tools/perf/util/data-convert-bt.c                  |   7 +-
 tools/perf/util/dso.c                              |  48 ++-
 tools/perf/util/event.c                            |   2 +-
 tools/perf/util/evlist.c                           |  12 +-
 tools/perf/util/evlist.h                           |   2 +
 tools/perf/util/header.c                           |   7 +-
 tools/perf/util/hist.c                             |   4 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   5 +
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |   2 +
 tools/perf/util/intel-pt.c                         |   4 +-
 tools/perf/util/llvm-utils.c                       |   4 +-
 tools/perf/util/machine.c                          |  19 ++
 tools/perf/util/machine.h                          |   1 +
 tools/perf/util/parse-events.c                     |  69 +++--
 tools/perf/util/parse-events.y                     |  35 ++-
 tools/perf/util/pmu.c                              | 109 ++++---
 tools/perf/util/pmu.h                              |   1 +
 tools/perf/util/probe-event.c                      |  11 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   6 +-
 tools/perf/util/session.c                          |   2 +-
 tools/perf/util/strfilter.c                        |   1 +
 tools/perf/util/string.c                           |   2 +
 tools/perf/util/symbol.c                           |   6 +-
 tools/perf/util/thread_map.c                       |   2 +-
 tools/perf/util/trace-event-info.c                 |  71 +++--
 tools/perf/util/trace-event-parse.c                |  17 ++
 tools/perf/util/trace-event-read.c                 |  77 ++++-
 tools/perf/util/trace-event.h                      |   1 +
 tools/perf/util/unwind-libunwind-local.c           |  54 +++-
 tools/perf/util/util.c                             |  15 +-
 tools/perf/util/util.h                             |   3 +-
 tools/scripts/Makefile.include                     |  12 +-
 122 files changed, 5101 insertions(+), 550 deletions(-)
 create mode 100644 arch/x86/events/amd/Makefile
 create mode 100644 tools/perf/Documentation/perf-ftrace.txt
 create mode 100644 tools/perf/Documentation/perf-kallsyms.txt
 create mode 100644 tools/perf/builtin-ftrace.c
 create mode 100644 tools/perf/builtin-kallsyms.c
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
 create mode 100644 tools/perf/tests/unit_number__scnprintf.c

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support, objtool where it is supported and samples/bpf/, ditto.

Several are cross builds, the ones with -x-ARCH, and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

  # dm
   1 alpine:3.4: Ok
   2 android-ndk:r12b-arm: Ok
   3 archlinux:latest: Ok
   4 centos:5: Ok
   5 centos:6: Ok
   6 centos:7: Ok
   7 debian:7: Ok
   8 debian:8: Ok
   9 debian:experimental: Ok
  10 debian:experimental-x-arm64: Ok
  11 debian:experimental-x-mips: Ok
  12 debian:experimental-x-mips64: Ok
  13 debian:experimental-x-mipsel: Ok
  14 fedora:20: Ok
  15 fedora:21: Ok
  16 fedora:22: Ok
  17 fedora:23: Ok
  18 fedora:24: Ok
  19 fedora:24-x-ARC-uClibc: Ok
  20 fedora:25: Ok
  21 fedora:rawhide: Ok
  22 mageia:5: Ok
  23 opensuse:13.2: Ok
  24 opensuse:42.1: Ok
  25 opensuse:tumbleweed: Ok
  26 ubuntu:12.04.5: Ok
  27 ubuntu:14.04.4-x-linaro-arm64: Ok
  28 ubuntu:15.10: Ok
  29 ubuntu:16.04: Ok
  30 ubuntu:16.04-x-arm: Ok
  31 ubuntu:16.04-x-arm64: Ok
  32 ubuntu:16.04-x-powerpc: Ok
  33 ubuntu:16.04-x-powerpc64: Ok
  34 ubuntu:16.04-x-powerpc64el: Ok
  35 ubuntu:16.04-x-s390: Ok
  36 ubuntu:16.10: Ok

  # perf test
   1: vmlinux symtab matches kallsyms            : Ok
   2: Detect openat syscall event                : Ok
   3: Detect openat syscall event on all cpus    : Ok
   4: Read samples using the mmap interface      : Ok
   5: Parse event definition strings             : Ok
   6: PERF_RECORD_* events & perf_sample fields  : Ok
   7: Parse perf pmu format                      : Ok
   8: DSO data read                              : Ok
   9: DSO data cache                             : Ok
  10: DSO data reopen                            : Ok
  11: Roundtrip evsel->name                      : Ok
  12: Parse sched tracepoints fields             : Ok
  13: syscalls:sys_enter_openat event fields     : Ok
  14: Setup struct perf_event_attr               : Ok
  15: Match and link multiple hists              : Ok
  16: 'import perf' in python                    : Ok
  17: Breakpoint overflow signal handler         : Ok
  18: Breakpoint overflow sampling               : Ok
  19: Number of exit events of a simple workload : Ok
  20: Software clock events period values        : Ok
  21: Object code reading                        : Ok
  22: Sample parsing                             : Ok
  23: Use a dummy software event to keep tracking: Ok
  24: Parse with no sample_id_all bit set        : Ok
  25: Filter hist entries                        : Ok
  26: Lookup mmap thread                         : Ok
  27: Share thread mg                            : Ok
  28: Sort output of hist entries                : Ok
  29: Cumulate child hist entries                : Ok
  30: Track with sched_switch                    : Ok
  31: Filter fds with revents mask in a fdarray  : Ok
  32: Add fd to a fdarray, making it autogrow    : Ok
  33: kmod_path__parse                           : Ok
  34: Thread map                                 : Ok
  35: LLVM search and compile                    :
  35.1: Basic BPF llvm compile                    : Ok
  35.2: kbuild searching                          : Ok
  35.3: Compile source for BPF prologue generation: Ok
  35.4: Compile source for BPF relocation         : Ok
  36: Session topology                           : Ok
  37: BPF filter                                 :
  37.1: Basic BPF filtering                      : Ok
  37.2: BPF pinning                              : Ok
  37.3: BPF prologue generation                  : Ok
  37.4: BPF relocation checker                   : Ok
  38: Synthesize thread map                      : Ok
  39: Remove thread map                          : Ok
  40: Synthesize cpu map                         : Ok
  41: Synthesize stat config                     : Ok
  42: Synthesize stat                            : Ok
  43: Synthesize stat round                      : Ok
  44: Synthesize attr update                     : Ok
  45: Event times                                : Ok
  46: Read backward ring buffer                  : Ok
  47: Print cpu map                              : Ok
  48: Probe SDT events                           : Ok
  49: is_printable_array                         : Ok
  50: Print bitmap                               : Ok
  51: perf hooks                                 : Ok
  52: builtin clang support                      : Skip (not compiled in)
  53: unit_number__scnprintf                     : Ok
  54: x86 rdpmc                                  : Ok
  55: Convert perf time to TSC                   : Ok
  56: DWARF unwind                               : Ok
  57: x86 instruction decoder - new instructions : Ok
  58: Intel cqm nmi context read                 : Skip
  # 

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
             make_no_libperl_O: make NO_LIBPERL=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                 make_perf_o_O: make perf.o
                   make_pure_O: make
         make_install_prefix_O: make install prefix=/tmp/krava
           make_no_libunwind_O: make NO_LIBUNWIND=1
                 make_static_O: make LDFLAGS=-static
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
            make_no_auxtrace_O: make NO_AUXTRACE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                   make_help_O: make help
                    make_doc_O: make doc
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                   make_tags_O: make tags
                  make_debug_O: make DEBUG=1
            make_install_bin_O: make install-bin
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
              make_no_libbpf_O: make NO_LIBBPF=1
             make_util_map_o_O: make util/map.o
              make_no_libelf_O: make NO_LIBELF=1
             make_no_libnuma_O: make NO_LIBNUMA=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_no_gtk2_O: make NO_GTK2=1
              make_clean_all_O: make clean all
                make_no_newt_O: make NO_NEWT=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                make_install_O: make install
           make_no_libpython_O: make NO_LIBPYTHON=1
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
               make_no_slang_O: make NO_SLANG=1
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
