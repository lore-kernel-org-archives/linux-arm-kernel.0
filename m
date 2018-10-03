From: jolsa@redhat.com (Jiri Olsa)
Date: Wed, 3 Oct 2018 13:36:43 +0200
Subject: [PATCH] perf tools: Allocate id array in
 perf_event__synthesize_event_update_cpus
In-Reply-To: <20181002111621.GA6357@krava>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
 <20180927160210.GF6916@krava>
 <4ac88076-60fa-4509-7fa0-2f99d73174d2@huawei.com>
 <20181002111621.GA6357@krava>
Message-ID: <20181003113643.GA31725@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2018 at 01:16:21PM +0200, Jiri Olsa wrote:
> On Tue, Oct 02, 2018 at 11:41:36AM +0100, John Garry wrote:
> 
> SNIP
> 
> > > 
> > > 
> > > ---
> > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > index 1ec1d9bc2d63..fb2a0dab3978 100644
> > > --- a/tools/perf/util/header.c
> > > +++ b/tools/perf/util/header.c
> > > @@ -29,6 +29,7 @@
> > >  #include "symbol.h"
> > >  #include "debug.h"
> > >  #include "cpumap.h"
> > > +#include "thread_map.h"
> > >  #include "pmu.h"
> > >  #include "vdso.h"
> > >  #include "strbuf.h"
> > > @@ -3579,6 +3580,11 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
> > > 	if (!evsel->own_cpus)
> > > 		return 0;
> > > 
> > > +	if (!evsel->id ||
> > 
> > for my test, evsel->id is NULL
> > 
> > > +	    perf_evsel__alloc_id(evsel, cpu_map__nr(evsel->cpus),
> > > +				 thread_map__nr(evsel->threads)))
> > 
> > and then this function is not called as we return immediately. So did you
> > really want this:
> > 
> > if (!evsel->id && perf_evsel__alloc_id(...))
> > 	return -ENOMEM;
> 
> ugh.. yes ;-) thanks for the fix.. I'll double
> check the logic and post the patch this week

actualy, we also need to populate those ids ;-)
so calling perf_evsel__store_ids instead..
attaching the full patch

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
id array, which is not defined at that time. Fixing this
by allocating the array and getting IDs before it's used.

Reported-by: John Garry <john.garry@huawei.com>
Link: http://lkml.kernel.org/n/tip-8x4n7o34yheigoxm1jibflm6 at git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/header.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1ec1d9bc2d63..14ca27f79d4a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -29,6 +29,7 @@
 #include "symbol.h"
 #include "debug.h"
 #include "cpumap.h"
+#include "thread_map.h"
 #include "pmu.h"
 #include "vdso.h"
 #include "strbuf.h"
@@ -3579,6 +3580,9 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
 	if (!evsel->own_cpus)
 		return 0;
 
+	if (!evsel->id && perf_evsel__store_ids(evsel, evsel->evlist))
+		return -ENOMEM;
+
 	ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);
 	if (!ev)
 		return -ENOMEM;
-- 
2.17.1
