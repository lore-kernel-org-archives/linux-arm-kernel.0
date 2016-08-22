From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Mon, 22 Aug 2016 19:18:50 +0300
Subject: [PATCH V5 4/9] perf/core: Adding PMU driver specific configuration
In-Reply-To: <1470932464-726-5-git-send-email-mathieu.poirier@linaro.org>
References: <1470932464-726-1-git-send-email-mathieu.poirier@linaro.org>
 <1470932464-726-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <8760qsn5ed.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> This patch somewhat mimics the work done on address filters to
> add the infrastructure needed to pass PMU specific HW
> configuration to the driver before a session starts.

Looks like a lot of work to do something that can be taken care of
entirely in userspace. A few comments below.

Btw, please don't forget to CC me on the kernel perf patches.

> +static struct perf_drv_config *
> +perf_drv_config_new(int cpu, struct list_head *drv_config_list)
> +{
> +	int node = cpu_to_node(cpu == -1 ? 0 : cpu);
> +	struct perf_drv_config *drv_config;
> +
> +	drv_config = kzalloc_node(sizeof(*drv_config), GFP_KERNEL, node);
> +	if (!drv_config)
> +		return ERR_PTR(-ENOMEM);

So it's the only error that this function may return.

> +
> +	INIT_LIST_HEAD(&drv_config->entry);
> +	list_add_tail(&drv_config->entry, drv_config_list);
> +
> +	return drv_config;
> +}
> +
> +static void free_drv_config_list(struct list_head *drv_config_list)
> +{
> +	struct perf_drv_config *drv_config, *itr;
> +
> +	list_for_each_entry_safe(drv_config, itr, drv_config_list, entry) {
> +		list_del(&drv_config->entry);
> +		kfree(drv_config->config);
> +		kfree(drv_config->option);
> +		kfree(drv_config);
> +	}
> +}
> +
> +/* How long does a configuration option really need to be?  */
> +#define PERF_DRV_CONFIG_MAX	128

Considering that you're already limiting the entire input buffer to
PAGE_SIZE, this is redundant.

> +
>  /*
> - * hrtimer based swevent callback
> + * PMU specific driver configuration as specified from user space.
> + * The data come in the form of an ascii string pushed down to the kernel
> + * using an ioctl() call.
> + *
> + * Two format are accepted: a singleton and in pairs.  All of the following
> + * are valid: cfg1, cfg2=config2, cfg3=anything_is_possible.

What's the difference between 'config2' and 'anything_is_possible'?

> + *
> + * It is up to each PMU driver to make sure they can work with the
> + * submitted configurables.
>   */
> +static int
> +perf_event_parse_drv_config(struct perf_event *event, char *options,
> +			    struct list_head *drv_config_list)
> +{
> +	char *token;
> +	int ret;
> +	struct perf_drv_config *drv_config;
> +
> +	/*
> +	 * First split the @options string in nibbles.  Using the above
> +	 * example "cfg1", "cfg2=option2" and "cfg3=anything_is_possible"

"cfg2=config2", if you're referring to the comment at the top.

> +	 * will be processed.
> +	 */
> +	while ((token = strsep(&options, ",")) != NULL) {
> +		char *nibble, *config, *option;
> +
> +		if (!*token)
> +			continue;

So empty configs are valid?

> +
> +		/* Allocate a new driver config structure and queue it. */
> +		drv_config = perf_drv_config_new(event->cpu, drv_config_list);
> +		if (IS_ERR(drv_config)) {
> +			ret = PTR_ERR(drv_config);

We know it's ENOMEM, no need for ERR_PTR()->PTR_ERR().

> +			goto fail;
> +		}
> +
> +		/*
> +		 * The nibbles are either a "config" or a "config=option"
> +		 * pair.  First get the config part.  Since strsep() sets
> +		 * @nibble to the next valid token, nibble will be equal to
> +		 * the option part or NULL after the first call.
> +		 */
> +		nibble = token;
> +		config = strsep(&nibble, "=");
> +		option = nibble;

So '@,=,=,=,=,=,=,=,=,' is a valid driver configuration, by the looks of
it?

> +
> +		/* This shouldn't be happening */

Indeed.

> +		if (!config) {
> +			ret = -EINVAL;
> +			goto fail;
> +		}

Regards,
--
Alex
