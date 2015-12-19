From: rabin@rab.in (Rabin Vincent)
Date: Sat, 19 Dec 2015 18:27:05 +0100
Subject: [PATCH V7 24/24] perf tools: adding coresight etm PMU record
 capabilities
In-Reply-To: <1450472361-426-25-git-send-email-mathieu.poirier@linaro.org>
References: <1450472361-426-1-git-send-email-mathieu.poirier@linaro.org>
 <1450472361-426-25-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20151219172705.GC2437@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 01:59:20PM -0700, Mathieu Poirier wrote:
> +struct auxtrace_record
> +*auxtrace_record__init(struct perf_evlist *evlist, int *err)
> +{
> +	struct perf_pmu	*cs_etm_pmu;
> +	struct perf_evsel *evsel;
> +	bool found_etm = false;
> +
> +	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
> +
> +	 if (evlist) {
> +		evlist__for_each(evlist, evsel) {
> +			if (cs_etm_pmu &&
> +			    evsel->attr.type == cs_etm_pmu->type)
> +				found_etm = true;
> +		}
> +	}
> +
> +	if (found_etm)
> +		return cs_etm_record_init(err);
> +
> +	*err = -EINVAL;

This should not set an error code when found_etm is false.  Otherwise
any attempt to uses perf record without a cs_etm event enabled errors
out.

> +	return NULL;
> +}
