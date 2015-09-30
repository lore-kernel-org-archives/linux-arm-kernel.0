From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 30 Sep 2015 15:45:20 +0300
Subject: [RFC PATCH 18/20] coresight: etm3x: pushing down perf
 configuration to tracer
In-Reply-To: <1442593594-10665-19-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <1442593594-10665-19-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <878u7ojctb.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> +#define ETM3X_SUPPORTED_OPTIONS (ETMCR_CYC_ACC | ETMCR_TIMESTAMP_EN)
> +
> +static int etm_parse_event_config(struct etm_drvdata *drvdata,
> +				  struct perf_event *event)
> +{
> +	u64 config = event->attr.config;
> +
> +	/*
> +	 * At this time only cycle accurate and timestamp options are
> +	 * available.  As such clear everything else that may have been
> +	 * configured and set the ETM control register based on what was
> +	 * requested.
> +	 */
> +	config &= ETM3X_SUPPORTED_OPTIONS;

You want to make sure no bits outside of this mask are set in config,
though, and return -EINVAL. Below you're even checking for it:

> +	if (etm_parse_event_config(drvdata, event))
> +		return -EINVAL;

Regards,
--
Alex
