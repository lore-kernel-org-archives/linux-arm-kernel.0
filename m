From: adrian.hunter@intel.com (Adrian Hunter)
Date: Fri, 16 Sep 2016 15:43:53 +0300
Subject: [PATCH V6 2/3] perf tools: new tracepoint specific function
In-Reply-To: <1473957428-28311-3-git-send-email-mathieu.poirier@linaro.org>
References: <1473957428-28311-1-git-send-email-mathieu.poirier@linaro.org>
 <1473957428-28311-3-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <2f60edf3-e5f0-9fce-3a17-bd12cd33b835@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/09/16 19:37, Mathieu Poirier wrote:
> Making function perf_evsel__append_filter() static and
> introducing a new tracepoint specific function to append
> filters.  That way we eliminate redundant code and avoid
> formatting mistake.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/builtin-trace.c     | 7 +++----
>  tools/perf/util/evsel.c        | 9 +++++++--
>  tools/perf/util/evsel.h        | 3 +--
>  tools/perf/util/parse-events.c | 4 ++--
>  4 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 4c2704332c14..34effab09f39 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2148,11 +2148,10 @@ static int trace__set_ev_qualifier_filter(struct trace *trace)
>  	if (filter == NULL)
>  		goto out_enomem;
>  
> -	if (!perf_evsel__append_filter(trace->syscalls.events.sys_enter,
> -				       "(%s) && (%s)", filter)) {
> +	if (!perf_evsel__append_tp_filter(trace->syscalls.events.sys_enter,
> +					  filter)) {
>  		sys_exit = trace->syscalls.events.sys_exit;
> -		err = perf_evsel__append_filter(sys_exit,
> -						"(%s) && (%s)", filter);
> +		err = perf_evsel__append_tp_filter(sys_exit, filter);
>  	}
>  
>  	free(filter);
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index b93369745e08..a99e82d97df2 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1045,8 +1045,8 @@ int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter)
>  	return -1;
>  }
>  
> -int perf_evsel__append_filter(struct perf_evsel *evsel,
> -			      const char *fmt, const char *filter)
> +static int perf_evsel__append_filter(struct perf_evsel *evsel,
> +				     const char *fmt, const char *filter)
>  {
>  	char *new_filter;
>  
> @@ -1062,6 +1062,11 @@ int perf_evsel__append_filter(struct perf_evsel *evsel,
>  	return -1;
>  }
>  
> +int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter)
> +{
> +	return perf_evsel__append_filter(evsel, "(%s) && (%s)", filter);
> +}
> +
>  int perf_evsel__enable(struct perf_evsel *evsel)
>  {
>  	int nthreads = thread_map__nr(evsel->threads);
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 7ab59f15892f..36ed0997e65b 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -233,8 +233,7 @@ void perf_evsel__set_sample_id(struct perf_evsel *evsel,
>  			       bool use_sample_identifier);
>  
>  int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter);
> -int perf_evsel__append_filter(struct perf_evsel *evsel,
> -			      const char *fmt, const char *filter);
> +int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter);
>  int perf_evsel__apply_filter(struct perf_evsel *evsel, int ncpus, int nthreads,
>  			     const char *filter);
>  int perf_evsel__enable(struct perf_evsel *evsel);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 9692300585f6..751b48fc641c 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1762,7 +1762,7 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
>  		return -1;
>  	}
>  
> -	if (perf_evsel__append_filter(evsel, "(%s) && (%s)", str) < 0) {
> +	if (perf_evsel__append_tp_filter(evsel, str) < 0) {
>  		fprintf(stderr,
>  			"not enough memory to hold filter string\n");
>  		return -1;
> @@ -1793,7 +1793,7 @@ static int add_exclude_perf_filter(struct perf_evsel *evsel,
>  
>  	snprintf(new_filter, sizeof(new_filter), "common_pid != %d", getpid());
>  
> -	if (perf_evsel__append_filter(evsel, "(%s) && (%s)", new_filter) < 0) {
> +	if (perf_evsel__append_tp_filter(evsel, new_filter) < 0) {
>  		fprintf(stderr,
>  			"not enough memory to hold filter string\n");
>  		return -1;
> 
