From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Apr 2017 15:50:57 +0100
Subject: [PATCH] perf evsel: Fix to perf-stat malloc corruption on arm64
 platforms
In-Reply-To: <1493198780-25415-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1493198780-25415-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <20170426145057.GK27156@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ganapatrao,

Thanks for tracking this down.

On Wed, Apr 26, 2017 at 02:56:20PM +0530, Ganapatrao Kulkarni wrote:
> In some cases, ncpus used for perf_evsel__alloc_fd and for
> perf_evsel__close are not the same, this is causing memory
> overwrite/corruption.

It would be good if we could enumerate when this occurs.

>From what I can tell, the problem occurs when opening a thread-bound
event on PMU with a cpus/cpumask in sysfs.

For perf-stat we create events using create_perf_stat_counter(). There
we see !target_has_cpu(), so we call perf_evsel__open_per_thread(). Thus
perf_evsel__open() is passed NULL cpus, and creates an empty cpu_map. As
cpus->nr = 1, we get 1 * nthreads fds allocated, and open events for
each of these.

Later, we try to close events using perf_evlist__close(). This doesn't
take target_has_cpu() into account, but sees evsel->cpus is non-NULL
(since the PMU had a cpus/cpumask file), and tries to close events for
cpus->nr * nthreads, and goes out-of-bounds of the fd array.

> 
> Fixing issue by using same ncpus in perf_evsel__alloc_fd.
> 
> This bug is more evident on arm64 platforms, which uses
> cpu_map(cpus) for PMU core devices.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  tools/perf/util/evsel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ac59710..0dc94d7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1489,7 +1489,9 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
>  		nthreads = threads->nr;
>  
>  	if (evsel->fd == NULL &&
> -	    perf_evsel__alloc_fd(evsel, cpus->nr, nthreads) < 0)
> +	    perf_evsel__alloc_fd(evsel,
> +				evsel->cpus ? evsel->cpus->nr : cpus->nr,
> +				nthreads) < 0)

Unfortunately, I don't think this is the right fix.

Looking@the logic I added in commit:

  9f21b815be863218 ("perf evlist: Only open events on CPUs an evsel permit").

... in some cases (e.g. when using perf record with cpu-bound events),
evsel->cpus may contain a subset of evlist->cpus, and thus the use of
evsel->cpus->nr here may lower the number of entries allocated, such
that the manipulation of fds will go out-of-bounds.

I think that to properly solve this, we need a more invasive rework,
ensuring that open/manipulation/close always deal with the same set of
cpus and threads for a given evsel.

I'm taking a look into that now.

Thanks,
Mark.
