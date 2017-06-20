From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Mon, 19 Jun 2017 22:54:36 -0300
Subject: [GIT PULL 00/23] perf/core improvements and fixes
Message-ID: <20170620015459.29381-1-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ingo,

	I merged tip/perf/urgent into tip/perf/core before rebasing with these
patches, please consider pulling, 

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 8052bd8243e823a0954bcbafda8f91072598f13d:

  Merge remote-tracking branch 'tip/perf/urgent' into perf/core (2017-06-19 15:14:35 -0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.13-20170719

for you to fetch changes up to dfe1c6d7efa8ead6878b73216d4c891a28207528:

  perf config: Refactor the code using 'ret' variable in cmd_config() (2017-06-19 22:05:55 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

User visible:

- Allow adding and removing fields to the default 'perf script' columns,
  using + or - as field prefixes to do so (Andi Kleen)

- Display titles in left frame in the annotate browser (Jin Yao)

- Allow resolving the DSO name with 'perf script -F brstack{sym,off},dso'
  (Mark Santaniello)

- Support function filtering in 'perf ftrace' (Namhyung Kim)

- Allow specifying function call depth in 'perf ftrace' (Namhyumg Kim)

Infrastructure:

- Adopt __noreturn, __printf, __scanf, noinline, __packed and __aligned
  __alignment__(()) markers, to make the tools/ source code base to be
  more compact and look more like kernel code (Arnaldo Carvalho de Melo)

- Remove unnecessary check in annotate_browser_write() (Jin Yao)

- Return arch from symbol__disassemble() so that callers, such as
  the annotate TUI browser to use arch specific formattings, such
  as the upcoming instruction micro-op fusion on Intel Core (Jin Yao)

- Remove superfluous check before use in the coresight code base (Kim
  Phillips)

- Remove unused SAMPLE_SIZE defines and BTS priv array (Kim Phillips)

- Error handling fix/tidy ups in 'perf config' (Taeung Song)

- Avoid error in the BPF proggie built with clang in 'perf test llvm'
  when PROFILE_ALL_BRANCHES is set (Wang Nan)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (1):
      perf script: Allow adding and removing fields

Arnaldo Carvalho de Melo (7):
      tools: Adopt __noreturn from kernel sources
      tools: Adopt __printf from kernel sources
      tools: Adopt __scanf from kernel sources
      perf tools: Use __maybe_unused consistently
      tools: Adopt noinline from kernel sources
      tools: Adopt __packed from kernel sources
      tools: Adopt __aligned from kernel sources

Jin Yao (3):
      perf report: Remove unnecessary check in annotate_browser_write()
      perf annotate browser: Display titles in left frame
      perf annotate: Return arch from symbol__disassemble() and save it in browser

Kim Phillips (2):
      perf coresight: Remove superfluous check before use
      perf intel-pt/bts: Remove unused SAMPLE_SIZE defines and bts priv array

Mark Santaniello (2):
      perf script: Support -F brstack,dso and brstacksym,dso
      perf script: Support -F brstackoff,dso

Namhyung Kim (4):
      perf ftrace: Show error message when fails to set ftrace files
      perf ftrace: Move setup_pager before opening trace_pipe
      perf ftrace: Add option for function filtering
      perf ftrace: Add -D option for depth filter

Taeung Song (3):
      perf config: Invert an if statement to reduce nesting in cmd_config()
      perf config: Check error cases of {show_spec, set}_config()
      perf config: Refactor the code using 'ret' variable in cmd_config()

Wang Nan (1):
      perf test llvm: Avoid error when PROFILE_ALL_BRANCHES is set

 tools/include/linux/compiler-gcc.h                 |  10 ++
 tools/include/linux/compiler.h                     |   4 +
 tools/perf/Documentation/perf-ftrace.txt           |  33 +++++
 tools/perf/Documentation/perf-script.txt           |  12 +-
 tools/perf/arch/arm/util/cs-etm.c                  |  29 ++--
 tools/perf/arch/x86/util/intel-bts.c               |   4 -
 tools/perf/arch/x86/util/intel-pt.c                |   4 -
 tools/perf/bench/numa.c                            |   2 +-
 tools/perf/builtin-config.c                        |  67 +++++----
 tools/perf/builtin-ftrace.c                        | 159 +++++++++++++++++++--
 tools/perf/builtin-script.c                        | 146 +++++++++++++++++--
 tools/perf/builtin-top.c                           |   2 +-
 tools/perf/jvmti/jvmti_agent.h                     |   2 -
 tools/perf/jvmti/libjvmti.c                        |   5 +-
 tools/perf/pmu-events/jevents.c                    |   4 -
 tools/perf/tests/bp_signal.c                       |   3 +-
 tools/perf/tests/bp_signal_overflow.c              |   3 +-
 tools/perf/tests/bpf-script-test-prologue.c        |   9 ++
 tools/perf/tests/dwarf-unwind.c                    |  15 +-
 tools/perf/ui/browsers/annotate.c                  |  54 ++++---
 tools/perf/ui/gtk/annotate.c                       |   3 +-
 tools/perf/util/annotate.c                         |  10 +-
 tools/perf/util/annotate.h                         |   4 +-
 tools/perf/util/cache.h                            |   3 +-
 tools/perf/util/debug.h                            |  11 +-
 tools/perf/util/evlist.h                           |   3 +-
 tools/perf/util/evsel.c                            |   3 +-
 tools/perf/util/genelf_debug.c                     |   5 +-
 tools/perf/util/header.c                           |   3 +-
 tools/perf/util/intel-bts.c                        |   2 -
 tools/perf/util/intel-pt-decoder/intel-pt-log.h    |   4 +-
 tools/perf/util/pmu.h                              |   4 +-
 tools/perf/util/probe-event.h                      |   4 +-
 .../util/scripting-engines/trace-event-python.c    |   3 +-
 tools/perf/util/strbuf.h                           |   4 +-
 tools/perf/util/usage.c                            |   6 +-
 tools/perf/util/util.h                             |  18 +--
 37 files changed, 496 insertions(+), 161 deletions(-)

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support, objtool where it is supported and samples/bpf/, ditto.
Where clang is available, it is also used to build perf with/without libelf.

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
   2 alpine:3.5: Ok
   3 alpine:3.6: Ok
   4 alpine:edge: Ok
   5 android-ndk:r12b-arm: Ok
   6 archlinux:latest: Ok
   7 centos:5: Ok
   8 centos:6: Ok
   9 centos:7: Ok
  10 debian:7: Ok
  11 debian:8: Ok
  12 debian:9: Ok
  13 debian:experimental: Ok
  14 debian:experimental-x-arm64: Ok
  15 debian:experimental-x-mips: Ok
  16 debian:experimental-x-mips64: Ok
  17 debian:experimental-x-mipsel: Ok
  18 fedora:20: Ok
  19 fedora:21: Ok
  20 fedora:22: Ok
  21 fedora:23: Ok
  22 fedora:24: Ok
  23 fedora:24-x-ARC-uClibc: Ok
  24 fedora:25: Ok
  25 fedora:rawhide: Ok
  26 mageia:5: Ok
  27 opensuse:13.2: Ok
  28 opensuse:42.1: Ok
  29 opensuse:tumbleweed: Ok
  30 ubuntu:12.04.5: Ok
  31 ubuntu:14.04.4: Ok
  32 ubuntu:14.04.4-x-linaro-arm64: Ok
  33 ubuntu:15.10: Ok
  34 ubuntu:16.04: Ok
  35 ubuntu:16.04-x-arm: Ok
  36 ubuntu:16.04-x-arm64: Ok
  37 ubuntu:16.04-x-powerpc: Ok
  38 ubuntu:16.04-x-powerpc64: Ok
  39 ubuntu:16.04-x-powerpc64el: Ok
  40 ubuntu:16.04-x-s390: Ok
  41 ubuntu:16.10: Ok
  42 ubuntu:17.04: Ok
  #

  # uname -a
  Linux jouet 4.12.0-rc4+ #1 SMP Fri Jun 9 12:59:23 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
  # perf test
   1: vmlinux symtab matches kallsyms            : Ok
   2: Detect openat syscall event                : Ok
   3: Detect openat syscall event on all cpus    : Ok
   4: Read samples using the mmap interface      : Ok
   5: Parse event definition strings             : Ok
   6: Simple expression parser                   : Ok
   7: PERF_RECORD_* events & perf_sample fields  : Ok
   8: Parse perf pmu format                      : Ok
   9: DSO data read                              : Ok
  10: DSO data cache                             : Ok
  11: DSO data reopen                            : Ok
  12: Roundtrip evsel->name                      : Ok
  13: Parse sched tracepoints fields             : Ok
  14: syscalls:sys_enter_openat event fields     : Ok
  15: Setup struct perf_event_attr               : Ok
  16: Match and link multiple hists              : Ok
  17: 'import perf' in python                    : Ok
  18: Breakpoint overflow signal handler         : Ok
  19: Breakpoint overflow sampling               : Ok
  20: Number of exit events of a simple workload : Ok
  21: Software clock events period values        : Ok
  22: Object code reading                        : Ok
  23: Sample parsing                             : Ok
  24: Use a dummy software event to keep tracking: Ok
  25: Parse with no sample_id_all bit set        : Ok
  26: Filter hist entries                        : Ok
  27: Lookup mmap thread                         : Ok
  28: Share thread mg                            : Ok
  29: Sort output of hist entries                : Ok
  30: Cumulate child hist entries                : Ok
  31: Track with sched_switch                    : Ok
  32: Filter fds with revents mask in a fdarray  : Ok
  33: Add fd to a fdarray, making it autogrow    : Ok
  34: kmod_path__parse                           : Ok
  35: Thread map                                 : Ok
  36: LLVM search and compile                    :
  36.1: Basic BPF llvm compile                    : Ok
  36.2: kbuild searching                          : Ok
  36.3: Compile source for BPF prologue generation: Ok
  36.4: Compile source for BPF relocation         : Ok
  37: Session topology                           : Ok
  38: BPF filter                                 :
  38.1: Basic BPF filtering                      : Ok
  38.2: BPF pinning                              : Ok
  38.3: BPF prologue generation                  : Ok
  38.4: BPF relocation checker                   : Ok
  39: Synthesize thread map                      : Ok
  40: Remove thread map                          : Ok
  41: Synthesize cpu map                         : Ok
  42: Synthesize stat config                     : Ok
  43: Synthesize stat                            : Ok
  44: Synthesize stat round                      : Ok
  45: Synthesize attr update                     : Ok
  46: Event times                                : Ok
  47: Read backward ring buffer                  : Ok
  48: Print cpu map                              : Ok
  49: Probe SDT events                           : Ok
  50: is_printable_array                         : Ok
  51: Print bitmap                               : Ok
  52: perf hooks                                 : Ok
  53: builtin clang support                      : Skip (not compiled in)
  54: unit_number__scnprintf                     : Ok
  55: x86 rdpmc                                  : Ok
  56: Convert perf time to TSC                   : Ok
  57: DWARF unwind                               : Ok
  58: x86 instruction decoder - new instructions : Ok
  59: Intel cqm nmi context read                 : Skip
  #
  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_tags_O: make tags
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                 make_static_O: make LDFLAGS=-static
                make_no_gtk2_O: make NO_GTK2=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
              make_no_libbpf_O: make NO_LIBBPF=1
                   make_help_O: make help
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
         make_install_prefix_O: make install prefix=/tmp/krava
            make_no_auxtrace_O: make NO_AUXTRACE=1
                    make_doc_O: make doc
                   make_pure_O: make
           make_no_libbionic_O: make NO_LIBBIONIC=1
                 make_perf_o_O: make perf.o
              make_clean_all_O: make clean all
            make_no_libaudit_O: make NO_LIBAUDIT=1
             make_no_libperl_O: make NO_LIBPERL=1
            make_install_bin_O: make install-bin
            make_no_demangle_O: make NO_DEMANGLE=1
                make_install_O: make install
                  make_debug_O: make DEBUG=1
           make_no_backtrace_O: make NO_BACKTRACE=1
               make_no_slang_O: make NO_SLANG=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                make_no_newt_O: make NO_NEWT=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
              make_no_libelf_O: make NO_LIBELF=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
             make_util_map_o_O: make util/map.o
           make_no_libunwind_O: make NO_LIBUNWIND=1
           make_no_libpython_O: make NO_LIBPYTHON=1
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
