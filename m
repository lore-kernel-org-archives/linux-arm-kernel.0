From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Fri, 29 Jan 2016 18:17:37 -0300
Subject: [GIT PULL 00/16] perf/core improvements and fixes
Message-ID: <1454102273-16431-1-git-send-email-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

See http://www.infradead.org/rpr.html

Hi Ingo,

	This is on top of the previously submitted perf-core-for-mingo tag,
please consider applying,

- Arnaldo

The following changes since commit 5ac76283b32b116c58e362e99542182ddcfc8262:

  perf cpumap: Auto initialize cpu__max_{node,cpu} (2016-01-26 16:08:36 -0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-2

for you to fetch changes up to 814568db641f6587c1e98a3a85f214cb6a30fe10:

  perf build: Align the names of the build tests: (2016-01-29 17:51:04 -0300)

----------------------------------------------------------------
New features:

- Port 'perf kvm stat' to PowerPC (Hemant Kumar)

Infrastructure:

- Use the 'feature-dump' target to do the feature checks just once and then
  add code to reuse that in the tests/make makefile, speeding up the
  'make -C tools/perf build-test' target (Wang Nan)

- Reduce the number of tests the 'build-test' target do to those that don't
  pollute the source tree (Arnaldo Carvalho de Melo)

- Improve the output of the build tests a bit by aligning the name of the
  tests, more can be done to filter out uninteresting info in the output
  (Arnaldo Carvalho de Melo)

- Add perf_evlist pointer to *info_priv_size(), more prep work for
  supporting the coresight architecture (Mathieu Poirier)

- Improve the 'perf test bp_signal' test (Wang Nan)

- Check environment before starting the BPF 'perf test', so that we can just
  'Skip' older kernels instead of 'FAIL'ing them (Wang Nan)

- Fix cpumode of synthesized buildid event (Wang Nan)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (2):
      perf tools: Speed up build-tests by reducing the number of builds tested
      perf build: Align the names of the build tests:

Hemant Kumar (4):
      perf kvm/{x86,s390}: Remove dependency on uapi/kvm_perf.h
      perf kvm/{x86,s390}: Remove const from kvm_events_tp
      perf kvm/powerpc: Port perf kvm stat to powerpc
      perf kvm/powerpc: Add support for HCALL reasons

Jiri Olsa (1):
      perf build: Fix feature-dump checks, we need to test all features

Mathieu Poirier (1):
      perf auxtrace: Add perf_evlist pointer to *info_priv_size()

Wang Nan (8):
      tools build: Check basic headers for test-compile feature checker
      perf build: Remove all condition feature check {C,LD}FLAGS
      perf build: Use feature dump file for build-test
      perf buildid: Fix cpumode of buildid event
      perf test: Check environment before start real BPF test
      perf test: Improve bp_signal
      perf tools: Move timestamp creation to util
      perf record: Use OPT_BOOLEAN_SET for buildid cache related options

 tools/build/Makefile.feature                   |   8 ++
 tools/build/feature/test-compile.c             |   2 +
 tools/perf/Makefile                            |  11 +-
 tools/perf/arch/powerpc/Makefile               |   2 +
 tools/perf/arch/powerpc/util/Build             |   1 +
 tools/perf/arch/powerpc/util/book3s_hcalls.h   | 123 ++++++++++++++++++
 tools/perf/arch/powerpc/util/book3s_hv_exits.h |  33 +++++
 tools/perf/arch/powerpc/util/kvm-stat.c        | 170 +++++++++++++++++++++++++
 tools/perf/arch/s390/util/kvm-stat.c           |  10 +-
 tools/perf/arch/x86/util/intel-bts.c           |   4 +-
 tools/perf/arch/x86/util/intel-pt.c            |   4 +-
 tools/perf/arch/x86/util/kvm-stat.c            |  16 ++-
 tools/perf/builtin-buildid-cache.c             |  14 +-
 tools/perf/builtin-kvm.c                       |  38 ++++--
 tools/perf/builtin-record.c                    |  12 +-
 tools/perf/config/Makefile                     | 101 +++++++--------
 tools/perf/tests/bp_signal.c                   | 140 ++++++++++++++++----
 tools/perf/tests/bpf.c                         |  37 ++++++
 tools/perf/tests/make                          |  39 +++++-
 tools/perf/util/auxtrace.c                     |   7 +-
 tools/perf/util/auxtrace.h                     |   6 +-
 tools/perf/util/build-id.c                     |   6 +-
 tools/perf/util/kvm-stat.h                     |   8 +-
 tools/perf/util/util.c                         |  17 +++
 tools/perf/util/util.h                         |   1 +
 25 files changed, 688 insertions(+), 122 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/book3s_hcalls.h
 create mode 100644 tools/perf/arch/powerpc/util/book3s_hv_exits.h
 create mode 100644 tools/perf/arch/powerpc/util/kvm-stat.c
