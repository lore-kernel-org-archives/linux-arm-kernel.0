From: jolsa@redhat.com (Jiri Olsa)
Date: Tue, 2 Oct 2018 13:16:21 +0200
Subject: perf segmentation fault from NULL dereference
In-Reply-To: <4ac88076-60fa-4509-7fa0-2f99d73174d2@huawei.com>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
 <20180927160210.GF6916@krava>
 <4ac88076-60fa-4509-7fa0-2f99d73174d2@huawei.com>
Message-ID: <20181002111621.GA6357@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2018 at 11:41:36AM +0100, John Garry wrote:

SNIP

> > 
> > 
> > ---
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 1ec1d9bc2d63..fb2a0dab3978 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -29,6 +29,7 @@
> >  #include "symbol.h"
> >  #include "debug.h"
> >  #include "cpumap.h"
> > +#include "thread_map.h"
> >  #include "pmu.h"
> >  #include "vdso.h"
> >  #include "strbuf.h"
> > @@ -3579,6 +3580,11 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
> > 	if (!evsel->own_cpus)
> > 		return 0;
> > 
> > +	if (!evsel->id ||
> 
> for my test, evsel->id is NULL
> 
> > +	    perf_evsel__alloc_id(evsel, cpu_map__nr(evsel->cpus),
> > +				 thread_map__nr(evsel->threads)))
> 
> and then this function is not called as we return immediately. So did you
> really want this:
> 
> if (!evsel->id && perf_evsel__alloc_id(...))
> 	return -ENOMEM;

ugh.. yes ;-) thanks for the fix.. I'll double
check the logic and post the patch this week

jirka

> 
> This looks to work:
> 
> root at localhost:~# ./perf_debug_ record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.001 MB perf.data (7 samples) ]
> root at localhost:~# ./perf_debug_ report
> # To display the perf.data header info, please use --header/--header-only
> option
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 7  of event 'armv8_pmuv3_0/br_mis_pred/'
> # Event count (approx.): 8260
> #
> # Overhead  Command  Shared Object      Symbol
> # ........  .......  .................  ......................
> #
>     78.28%  sleep    libc-2.23.so       [.] 0x00000000000faef0
>     20.53%  sleep    [kernel.kallsyms]  [k] vmacache_find
>      1.09%  sleep    [kernel.kallsyms]  [k] find_vma
>      0.10%  perf_de  [kernel.kallsyms]  [k] perf_event_exec
> 
> 
> #
> # (Cannot load tips.txt file, please install perf!)
> #
> root at localhost:~#
> 
> 
> > +		return -ENOMEM;
> > +
> > 	ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);
> > 	if (!ev)
> > 		return -ENOMEM;
> > 
> > .
> > 
> 
> 
> Thanks,
> John
> 
