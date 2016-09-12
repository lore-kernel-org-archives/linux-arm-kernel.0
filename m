From: adrian.hunter@intel.com (Adrian Hunter)
Date: Mon, 12 Sep 2016 12:20:25 +0300
Subject: [PATCH V4] perf tools: adding support for address filters
In-Reply-To: <1473359122-1045-1-git-send-email-mathieu.poirier@linaro.org>
References: <1473359122-1045-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <35064099-0123-0b68-3103-99adf96bb57b@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/16 21:25, Mathieu Poirier wrote:
> This patch makes it possible to use the current filter
> framework with address filters.  That way address filters for
> HW tracers such as CoreSight and IntelPT can be communicated
> to the kernel drivers.
> 
> CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> ---
> Changes for V4:
>  - Added support for address filters over more than one
>    nibble.
>  - Removed Jiri's ack, this version is too different from
>    what was reviewed.
> 
> Changes for V3:
>  - Added Jiri's ack.
>  - Rebased to v4.8-rc5.
> 
> Changes for V2:
>  - Rebased to v4.8-rc4.
>  - Revisited error path.
> ---
>  tools/perf/util/evsel.c        | 17 +++++++++++++++++
>  tools/perf/util/evsel.h        |  2 ++
>  tools/perf/util/parse-events.c | 39 ++++++++++++++++++++++++++++++++++-----
>  3 files changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d40f852d2de2..5d809ffb85bc 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1046,6 +1046,23 @@ int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter)
>  	return -1;
>  }
>  
> +int perf_evsel__append_addr_filter(struct perf_evsel *evsel,
> +				   const char *filter)


perf_evsel__append_filter() already parameterizes the conjunction.  Perhaps it
should parameterize the format, then there is only one function e.g.

int perf_evsel__append_filter(struct perf_evsel *evsel,
			      const char *fmt, const char *filter)
{
	char *new_filter;

	if (evsel->filter == NULL)
		return perf_evsel__set_filter(evsel, filter);

	if (asprintf(&new_filter, fmt, evsel->filter, filter) > 0) {
		free(evsel->filter);
		evsel->filter = new_filter;
		return 0;
	}

	return -1;
}


> +{
> +	char *new_filter;
> +
> +	if (evsel->filter == NULL)
> +		return perf_evsel__set_filter(evsel, filter);
> +
> +	if (asprintf(&new_filter, "%s,%s", evsel->filter, filter) > 0) {
> +		free(evsel->filter);
> +		evsel->filter = new_filter;
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> +
>  int perf_evsel__append_filter(struct perf_evsel *evsel,
>  			      const char *op, const char *filter)
>  {
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 8ceb7ebb51f5..15ca5f85e946 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -235,6 +235,8 @@ void perf_evsel__set_sample_id(struct perf_evsel *evsel,
>  			       bool use_sample_identifier);
>  
>  int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter);
> +int perf_evsel__append_addr_filter(struct perf_evsel *evsel,
> +				   const char *filter);
>  int perf_evsel__append_filter(struct perf_evsel *evsel,
>  			      const char *op, const char *filter);
>  int perf_evsel__apply_filter(struct perf_evsel *evsel, int ncpus, int nthreads,
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 2eb8b1ed4cc8..3e158ad7eeb8 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1760,20 +1760,49 @@ foreach_evsel_in_last_glob(struct perf_evlist *evlist,
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
> +	if (evsel == NULL)
> +		goto err;
> +
> +	if (evsel->attr.type == PERF_TYPE_TRACEPOINT) {
> +		if (perf_evsel__append_filter(evsel, "&&", str) < 0) {
> +			fprintf(stderr,
> +				"not enough memory to hold filter string\n");
> +			return -1;
> +		}
> +
> +		return 0;
>  	}
>  
> -	if (perf_evsel__append_filter(evsel, "&&", str) < 0) {
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
> +	if (!nr_addr_filters)
> +		goto err;
> +
> +	if (perf_evsel__append_addr_filter(evsel, str) < 0) {
>  		fprintf(stderr,
>  			"not enough memory to hold filter string\n");
>  		return -1;
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
