From: adrian.hunter@intel.com (Adrian Hunter)
Date: Thu, 8 Sep 2016 15:30:11 +0300
Subject: [PATCH V3] perf tools: adding support for address filters
In-Reply-To: <1473178763-2870-1-git-send-email-mathieu.poirier@linaro.org>
References: <1473178763-2870-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <5c2ce087-d30e-4ab7-3e91-311f1397ebc3@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/16 19:19, Mathieu Poirier wrote:
> This patch makes it possible to use the current filter
> framework with address filters.  That way address filters for
> HW tracers such as CoreSight and IntelPT can be communicated
> to the kernel drivers.
> 
> CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
> Changes for V3:
>  - Added Jiri's ack.
>  - Rebased to v4.8-rc5.
> 
> Changes for V2:
>  - Rebased to v4.8-rc4.
>  - Revisited error path.
> 
> ---
>  tools/perf/util/parse-events.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 2eb8b1ed4cc8..1df413fbf7f8 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1760,12 +1760,26 @@ foreach_evsel_in_last_glob(struct perf_evlist *evlist,
>  static int set_filter(struct perf_evsel *evsel, const void *arg)
>  {
>  	const char *str = arg;
> +	bool found = false;
> +	int nr_addr_filters = 0;
> +	struct perf_pmu *pmu = NULL;
>  
> -	if (evsel == NULL || evsel->attr.type != PERF_TYPE_TRACEPOINT) {
> -		fprintf(stderr,
> -			"--filter option should follow a -e tracepoint option\n");
> -		return -1;
> -	}
> +	if (evsel == NULL)
> +		goto err;
> +
> +	while ((pmu = perf_pmu__scan(pmu)) != NULL)
> +		if (pmu->type == evsel->attr.type) {
> +			found = true;
> +			break;
> +		}
> +
> +	if (found)
> +		perf_pmu__scan_file(pmu, "nr_addr_filters",
> +				    "%d", &nr_addr_filters);
> +
> +
> +	if (evsel->attr.type != PERF_TYPE_TRACEPOINT && !nr_addr_filters)
> +		goto err;
>  
>  	if (perf_evsel__append_filter(evsel, "&&", str) < 0) {

Address filters cannot be joined with "&&" and the parentheses in
perf_evsel__append_filter() won't work either.

>  		fprintf(stderr,
> @@ -1774,6 +1788,12 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
>  	}
>  
>  	return 0;
> +
> +err:
> +	fprintf(stderr,
> +		"--filter option should follow a -e tracepoint or HW tracer option\n");
> +
> +	return -1;
>  }
>  
>  int parse_filter(const struct option *opt, const char *str,
> 
