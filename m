From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 4 Mar 2015 20:30:37 -0800
Subject: [GIT PULL 00/21] perf/core improvements and fixes
In-Reply-To: <1423688955-8094-1-git-send-email-acme@kernel.org>
References: <1423688955-8094-1-git-send-email-acme@kernel.org>
Message-ID: <CAA3XUr0LNX0E9kWbrzsTcMMs7ukq-Mt4XDWyQyWDyLfXqtSRTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaldo, Ingo,

What happened with this pull request? I already
see in v4.0-rc2 changes additions to one requested
by this pull request, but I don't see this series itself.

For example e370a3d57664cd5e39c0b95d157ebc841b568409
"perf symbols: Define EM_AARCH64 for older OSes" by David
is already in v4.0-rc2 and it is supposed to be addition to
"perf symbols: Ignore mapping symbols on aarch64" that is part
of this pull request but it did not make into v4.0-rcX yet. Looks
quite strange.

Thanks,
Victor

On 11 February 2015 at 13:08, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> Hi Ingo,
>
>         Please consider pulling,
>
> - Arnaldo
>
> The following changes since commit 2fde4f94e0a9531251e706fa57131b51b0df042e:
>
>   perf: Decouple unthrottling and rotating (2015-02-04 08:07:16 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo
>
> for you to fetch changes up to 39f5704399042fff5f0d5f6af32bbbc3e787a897:
>
>   perf tools: Define _GNU_SOURCE on pthread_attr_setaffinity_np feature check (2015-02-11 17:38:55 -0300)
>
> ----------------------------------------------------------------
> perf/core improvement and fixes:
>
> User visible:
>
> - No need to explicitely enable evsels for workload started from perf, let it
>   be enabled via perf_event_attr.enable_on_exec, removing some events that take
>   place in the 'perf trace' before a workload is really started by it.
>   (Arnaldo Carvalho de Melo)
>
> - Fix to handle optimized not-inlined functions in 'perf probe' (Masami Hiramatsu)
>
> - Update 'perf probe' man page (Masami Hiramatsu)
>
> Infrastructure:
>
> Arnaldo Carvalho de Melo (4):
> - Introduce {trace_seq_do,event_format_}_fprintf functions to allow
>   a default tracepoint field list printer to be used in tools that allows
>   redirecting output to a file. (Arnaldo Carvalho de Melo)
>
> - The man page for pthread_attr_set_affinity_np states that _GNU_SOURCE
>   must be defined before pthread.h, do it to fix the build in some
>   systems (Josh Boyer)
>
> - Cleanups in 'perf buildid-cache' (Masami Hiramatsu)
>
> - Fix dso cache test case (Namhyung Kim)
>
> - Do Not rely on dso__data_read_offset() to open DSO (Namhyung Kim)
>
> - Make perf aware of tracefs (Steven Rostedt).
>
> - Fix build by defining STT_GNU_IFUNC for glibc 2.9 and older (Vinson Lee)
>
> - AArch64 symbol resolution fixes (Victor Kamensky)
>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       tools lib traceevent: Introduce trace_seq_do_fprintf function
>       perf tools: Introduce event_format__fprintf method
>       perf trace: No need to enable evsels for workload started from perf
>       perf evlist: Fix typo in comment
>
> Josh Boyer (1):
>       perf tools: Define _GNU_SOURCE on pthread_attr_setaffinity_np feature check
>
> Masami Hiramatsu (4):
>       perf probe: Fix to handle optimized not-inlined functions
>       perf probe: Update man page
>       perf buildid-cache: Remove unneeded debugdir parameters
>       perf buildid-cache: Consolidate .build-id cache path generators
>
> Namhyung Kim (3):
>       perf test: Fix dso cache testcase
>       perf tests: Do not rely on dso__data_read_offset() to open dso
>       perf tools: Fix a dso open fail message
>
> Steven Rostedt (Red Hat) (6):
>       perf tools: Do not check debugfs MAGIC for tracing files
>       tools lib fs: Add helper to find mounted file systems
>       tools lib api fs: Add tracefs mount helper functions
>       tools lib api debugfs: Add DEBUGFS_DEFAULT_PATH macro
>       tools lib api fs: Add {tracefs,debugfs}_configured() functions
>       perf tools: Make perf aware of tracefs
>
> Victor Kamensky (2):
>       perf symbols: Ignore mapping symbols on aarch64
>       perf symbols: debuglink should take symfs option into account
>
> Vinson Lee (1):
>       perf symbols: Define STT_GNU_IFUNC for glibc 2.9 and older.
>
>  tools/lib/api/Makefile                    |  4 ++
>  tools/lib/api/fs/debugfs.c                | 69 +++++++---------------
>  tools/lib/api/fs/debugfs.h                | 13 +----
>  tools/lib/api/fs/findfs.c                 | 63 ++++++++++++++++++++
>  tools/lib/api/fs/findfs.h                 | 23 ++++++++
>  tools/lib/api/fs/tracefs.c                | 78 +++++++++++++++++++++++++
>  tools/lib/api/fs/tracefs.h                | 21 +++++++
>  tools/lib/traceevent/event-parse.h        |  2 +
>  tools/lib/traceevent/trace-seq.c          | 13 +++--
>  tools/perf/Documentation/perf-probe.txt   | 16 +++++-
>  tools/perf/builtin-buildid-cache.c        | 37 ++++++------
>  tools/perf/builtin-trace.c                |  4 +-
>  tools/perf/config/feature-checks/Makefile |  2 +-
>  tools/perf/tests/dso-data.c               | 22 ++++---
>  tools/perf/tests/open-syscall-all-cpus.c  |  7 ++-
>  tools/perf/tests/open-syscall.c           |  7 ++-
>  tools/perf/tests/parse-events.c           | 13 ++++-
>  tools/perf/util/build-id.c                | 96 +++++++++++++++++++------------
>  tools/perf/util/build-id.h                |  4 +-
>  tools/perf/util/cache.h                   |  1 +
>  tools/perf/util/dso.c                     |  8 +--
>  tools/perf/util/dwarf-aux.c               | 15 +++++
>  tools/perf/util/dwarf-aux.h               |  3 +
>  tools/perf/util/evlist.c                  |  3 +-
>  tools/perf/util/parse-events.c            | 19 ------
>  tools/perf/util/parse-events.h            |  2 +-
>  tools/perf/util/probe-event.c             | 24 +++++---
>  tools/perf/util/probe-finder.c            | 12 ++--
>  tools/perf/util/symbol-elf.c              | 11 ++--
>  tools/perf/util/trace-event-parse.c       | 12 +++-
>  tools/perf/util/trace-event.h             |  3 +
>  tools/perf/util/util.c                    | 60 +++++++++++++++----
>  tools/perf/util/util.h                    |  1 +
>  33 files changed, 468 insertions(+), 200 deletions(-)
>  create mode 100644 tools/lib/api/fs/findfs.c
>  create mode 100644 tools/lib/api/fs/findfs.h
>  create mode 100644 tools/lib/api/fs/tracefs.c
>  create mode 100644 tools/lib/api/fs/tracefs.h
