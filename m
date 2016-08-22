From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Mon, 22 Aug 2016 19:40:16 +0300
Subject: [PATCH V5 9/9] coresight: etm-perf: incorporating sink definition
 from cmd line
In-Reply-To: <1470932464-726-10-git-send-email-mathieu.poirier@linaro.org>
References: <1470932464-726-1-git-send-email-mathieu.poirier@linaro.org>
 <1470932464-726-10-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <8737lwn4en.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> +enum {
> +	ETM_TOKEN_SINK_CPU,
> +	ETM_TOKEN_SINK,
> +	ETM_TOKEN_ERR,
> +};
> +
> +static const match_table_t drv_cfg_tokens = {
> +	{ETM_TOKEN_SINK_CPU, "sink=cpu%d:%s"},
> +	{ETM_TOKEN_SINK, "sink=%s"},
> +	{ETM_TOKEN_ERR, NULL},
> +};

Wait, but we just parsed away the '=' and the whole thing is now a
linked list of { key, value }?

This also answers my question from the other email about the use cases
for sending in ascii strings. In my opinion, all this is completely
unnecessary.

> +static int
> +etm_set_drv_configs(struct perf_event *event,
> +		    struct list_head *drv_configs)
> +{
> +	char *config, *sink;
> +	int len;
> +	struct perf_drv_config *drv_config;
> +	void *old_sink;
> +
> +	list_for_each_entry(drv_config, drv_configs, entry) {
> +		/* ETM HW configuration needs a sink specification */
> +		if (!drv_config->option)
> +			return -EINVAL;
> +
> +		len = strlen(drv_config->config) + strlen("=") +
> +		      strlen(drv_config->option) + 1;
> +
> +		config = kmalloc(len, GFP_KERNEL);
> +		if (!config)
> +			return -ENOMEM;
> +
> +		/* Reconstruct user configuration */
> +		snprintf(config, len, "%s=%s",
> +			 drv_config->config, drv_config->option);

Wait, what? We parse this *twice*?

There's basically a malloc+snprintf[which could have been
kasprintf()]+match_token just to see if drv_config::option starts with a
'cpu%d:'?

Regards,
--
Alex
