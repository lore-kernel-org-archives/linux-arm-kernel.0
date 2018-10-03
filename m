From: jolsa@redhat.com (Jiri Olsa)
Date: Wed, 3 Oct 2018 23:20:52 +0200
Subject: [PATCH] perf tools: Store ids for events with their own cpus
 perf_event__synthesize_event_update_cpus
In-Reply-To: <20181003141627.GA6341@krava>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
 <20180927160210.GF6916@krava>
 <4ac88076-60fa-4509-7fa0-2f99d73174d2@huawei.com>
 <20181002111621.GA6357@krava> <20181003113643.GA31725@krava>
 <594506a2-8cb3-3d09-82ab-5cb6d8c31ed0@huawei.com>
 <20181003141627.GA6341@krava>
Message-ID: <20181003212052.GA32371@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2018 at 04:16:27PM +0200, Jiri Olsa wrote:
> On Wed, Oct 03, 2018 at 03:08:10PM +0100, John Garry wrote:
> > On 03/10/2018 12:36, Jiri Olsa wrote:
> > > On Tue, Oct 02, 2018 at 01:16:21PM +0200, Jiri Olsa wrote:
> > > > On Tue, Oct 02, 2018 at 11:41:36AM +0100, John Garry wrote:
> > > > 
> > > > SNIP
> > > > 
> > > > > > 
> > > > > > 
> > > > > > ---
> > > > > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > > > > index 1ec1d9bc2d63..fb2a0dab3978 100644
> > > > > > --- a/tools/perf/util/header.c
> > > > > > +++ b/tools/perf/util/header.c
> > > > > > @@ -29,6 +29,7 @@
> > > > > >  #include "symbol.h"
> > > > > >  #include "debug.h"
> > > > > >  #include "cpumap.h"
> > > > > > +#include "thread_map.h"
> > > > > >  #include "pmu.h"
> > > > > >  #include "vdso.h"
> > > > > >  #include "strbuf.h"
> > > > > > @@ -3579,6 +3580,11 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
> > > > > > 	if (!evsel->own_cpus)
> > > > > > 		return 0;
> > > > > > 
> > > > > > +	if (!evsel->id ||
> > > > > 
> > > > > for my test, evsel->id is NULL
> > > > > 
> > > > > > +	    perf_evsel__alloc_id(evsel, cpu_map__nr(evsel->cpus),
> > > > > > +				 thread_map__nr(evsel->threads)))
> > > > > 
> > > > > and then this function is not called as we return immediately. So did you
> > > > > really want this:
> > > > > 
> > > > > if (!evsel->id && perf_evsel__alloc_id(...))
> > > > > 	return -ENOMEM;
> > > > 
> > > > ugh.. yes ;-) thanks for the fix.. I'll double
> > > > check the logic and post the patch this week
> > > 
> > > actualy, we also need to populate those ids ;-)
> > > so calling perf_evsel__store_ids instead..
> > > attaching the full patch
> > > 
> > > thanks,
> > > jirka
> > > 
> > 
> > Hi Jirka,
> > 
> > Can you please double-check your new patch, as I'm getting this now:
> > root at localhost:~# ./perf_debug record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.001 MB perf.data (6 samples) ]
> > root at localhost:~# ./perf_debug report
> > 0xe8 [0]: failed to process type: 461
> > Error:
> > failed to process sample
> > # To display the perf.data header info, please use --header/--header-only
> > option
> > #
> > root at localhost:~#
> 
> ok, I need to get a machine to test this.. but it looks like
> any sample-able events with cpumask are in arm :-\ will try
> to get some..

got an arm server and patch below works for me.. could you please test?

thanks,
jirka


---

John reported crash when recording on an event under
pmu with cpumask defined:

  root at localhost:~# ./perf_debug_ record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
  perf: Segmentation fault
  Obtained 9 stack frames.
  ./perf_debug_() [0x4c5ef8]
  [0xffff82ba267c]
  ./perf_debug_() [0x4bc5a8]
  ./perf_debug_() [0x419550]
  ./perf_debug_() [0x41a928]
  ./perf_debug_() [0x472f58]
  ./perf_debug_() [0x473210]
  ./perf_debug_() [0x4070f4]
  /lib/aarch64-linux-gnu/libc.so.6(__libc_start_main+0xe0) [0xffff8294c8a0]
  Segmentation fault (core dumped)

We synthesize an update event that needs to touch the evsel
id array, which is not defined at that time. Fixing this by
forcing the id allocation for events with theeir own cpus.

Reported-by: John Garry <john.garry@huawei.com>
Link: http://lkml.kernel.org/n/tip-8x4n7o34yheigoxm1jibflm6 at git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-report.c | 1 +
 tools/perf/util/evsel.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c0703979c51d..257c9c18cb7e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -980,6 +980,7 @@ int cmd_report(int argc, const char **argv)
 			.id_index	 = perf_event__process_id_index,
 			.auxtrace_info	 = perf_event__process_auxtrace_info,
 			.auxtrace	 = perf_event__process_auxtrace,
+			.event_update	 = perf_event__process_event_update,
 			.feature	 = process_feature_event,
 			.ordered_events	 = true,
 			.ordering_requires_timestamps = true,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ac6cfb8b085e..7a0d5fbaf3c1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1088,6 +1088,9 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
+	if (evsel->own_cpus)
+		evsel->attr.read_format |= PERF_FORMAT_ID;
+
 	/*
 	 * Apply event specific term settings,
 	 * it overloads any global configuration.
-- 
2.17.1
