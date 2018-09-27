From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 27 Sep 2018 18:02:10 +0200
Subject: perf segmentation fault from NULL dereference
In-Reply-To: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
Message-ID: <20180927160210.GF6916@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 04:53:40PM +0100, John Garry wrote:
> Hi,
> 
> I am seeing this perf crash on my arm64-based system:
> 
> root at localhost:~# ./perf_debug_ record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
> perf: Segmentation fault
> Obtained 9 stack frames.
> ./perf_debug_() [0x4c5ef8]
> [0xffff82ba267c]
> ./perf_debug_() [0x4bc5a8]
> ./perf_debug_() [0x419550]
> ./perf_debug_() [0x41a928]
> ./perf_debug_() [0x472f58]
> ./perf_debug_() [0x473210]
> ./perf_debug_() [0x4070f4]
> /lib/aarch64-linux-gnu/libc.so.6(__libc_start_main+0xe0) [0xffff8294c8a0]
> Segmentation fault (core dumped)
> 
> I find 'cycles' event is fine.
> 
> I bisected the issue to here:
> commit bfd8f72c2778f5bd63dc9eb6d23bd7a0d99cff6d (HEAD, refs/bisect/bad)
> Author: Andi Kleen <ak@linux.intel.com>
> Date:   Fri Nov 17 13:42:58 2017 -0800
> 
>     perf record: Synthesize unit/scale/... in event update
> 
>     Move the code to synthesize event updates for scale/unit/cpus to a
>     common utility file, and use it both from stat and record.
> 
>     This allows to access scale and other extra qualifiers from perf script.
> 
>     Signed-off-by: Andi Kleen <ak@linux.intel.com>
>     Acked-by: Jiri Olsa <jolsa@kernel.org>
>     Link:
> http://lkml.kernel.org/r/20171117214300.32746-2-andi at firstfloor.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> I am suspicious that this is a real issue, as this patch has been in
> mainline for some time...
> 
> This simple change fixes the issue me:
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 91e6d9c..f4fd826 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3576,7 +3576,7 @@ int perf_event__process_feature(struct perf_tool
> *tool,
>      int max, err;
>      u16 type;
> 
> -    if (!evsel->own_cpus)
> +    if (!evsel->own_cpus || !(evsel->attr.read_format & PERF_FORMAT_ID)) //
> roundabout check for !evsel->id
>          return 0;
> 
>      ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);
> 
> It turns out that evsel->id is NULL on a call to
> perf_event__process_feature(), which upsets this code:
> 
>     ev->header.type = PERF_RECORD_EVENT_UPDATE;
>     ev->header.size = (u16)size;
>     ev->type = PERF_EVENT_UPDATE__CPUS;
>     ev->id   = evsel->id[0];
> 
> Please me let me know if a valid issue so we can get a fix in.

yea, I can see how we can get here with event having
its own CPUs, and we allocate the id array later at
the time we map the event

I wonder instead of skipping on this feature, we should
allocate the id array, like below

I did not test that.. need to find the server having event
with its own cpus.. also need to make sure evsel->cpus is
the way to go in here

thanks,
jirka


---
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1ec1d9bc2d63..fb2a0dab3978 100644
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
@@ -3579,6 +3580,11 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
	if (!evsel->own_cpus)
		return 0;
 
+	if (!evsel->id ||
+	    perf_evsel__alloc_id(evsel, cpu_map__nr(evsel->cpus),
+				 thread_map__nr(evsel->threads)))
+		return -ENOMEM;
+
	ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);
	if (!ev)
		return -ENOMEM;
