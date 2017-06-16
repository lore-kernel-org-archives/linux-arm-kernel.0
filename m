From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 16 Jun 2017 08:31:25 -0600
Subject: [PATCH 2/2] perf coresight: Remove superfluous check before use
In-Reply-To: <20170615125521.80cc128dc856bc1f2e61b730@arm.com>
References: <20170615125521.80cc128dc856bc1f2e61b730@arm.com>
Message-ID: <20170616143125.GA30102@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 12:55:21PM -0500, Kim Phillips wrote:
> cs_etm_evsel is guaranteed to be set at this point in the function.
> 
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 29361d9b635a..8e1e9469caf2 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -202,19 +202,18 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  		pr_debug2("%s snapshot size: %zu\n", CORESIGHT_ETM_PMU_NAME,
>  			  opts->auxtrace_snapshot_size);
>  
> -	if (cs_etm_evsel) {
> -		/*
> -		 * To obtain the auxtrace buffer file descriptor, the auxtrace
> -		 * event must come first.
> -		 */
> -		perf_evlist__to_front(evlist, cs_etm_evsel);
> -		/*
> -		 * In the case of per-cpu mmaps, we need the CPU on the
> -		 * AUX event.
> -		 */
> -		if (!cpu_map__empty(cpus))
> -			perf_evsel__set_sample_bit(cs_etm_evsel, CPU);
> -	}
> +	/*
> +	 * To obtain the auxtrace buffer file descriptor, the auxtrace
> +	 * event must come first.
> +	 */
> +	perf_evlist__to_front(evlist, cs_etm_evsel);
> +
> +	/*
> +	 * In the case of per-cpu mmaps, we need the CPU on the
> +	 * AUX event.
> +	 */
> +	if (!cpu_map__empty(cpus))
> +		perf_evsel__set_sample_bit(cs_etm_evsel, CPU);

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  
>  	/* Add dummy event to keep tracking */
>  	if (opts->full_auxtrace) {
> -- 
> 2.11.0
> 
