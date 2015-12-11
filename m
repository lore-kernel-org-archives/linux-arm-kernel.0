From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 11 Dec 2015 16:00:32 +0200
Subject: [PATCH V6 18/26] coresight: etb10: implementing AUX space API
In-Reply-To: <1449176702-13213-19-git-send-email-mathieu.poirier@linaro.org>
References: <1449176702-13213-1-git-send-email-mathieu.poirier@linaro.org>
 <1449176702-13213-19-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87h9jpccfz.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> +static void *etb_get_config(struct coresight_device *csdev, int cpu,
> +			    void **pages, int nr_pages, bool overwrite)
> +{
> +	int node;
> +	struct cs_buffers *buf;
> +
> +	if (cpu == -1)
> +		cpu = smp_processor_id();
> +	node = cpu_to_node(cpu);
> +
> +	buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
> +	if (!buf)
> +		return NULL;
> +
> +	buf->snapshot = overwrite;
> +	buf->nr_pages = nr_pages;
> +	buf->data_pages = pages;
> +
> +	return buf;
> +}

Nitpick: why is this called "get_config"? I was just looking for
something else and noticed that both sources and sinks have
.get_config() callback (I was looking for the source's one), but this
guy doesn't seem to be getting any config, but rather allocating a
buffer descriptor.

Regards,
--
Alex
