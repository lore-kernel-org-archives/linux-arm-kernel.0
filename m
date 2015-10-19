From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Mon, 19 Oct 2015 16:44:34 +0300
Subject: [PATCH V2 19/30] coresight: etb10: implementing the setup_aux()
 API
In-Reply-To: <1445192687-24112-20-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
 <1445192687-24112-20-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87lhazgegt.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> Adding an ETB10 specific auxiliary area setup operation to be
> used by the perf framework when events are initialised.
>
> Part of this operation involves modeling the mmap'ed area based
> on the specific ways a sink buffer gathers information.

It really doesn't seem to be ETB10 specific at all. When you add more
sinks, you'll probably end up copying this code every time.

Furthermore,

> +static void *etb_setup_aux(struct coresight_device *csdev, int cpu,
> +			   void **pages, int nr_pages, bool overwrite)
> +{
> +	int node, pg;
> +	struct cs_buffers *buf;
> +
> +	if (cpu == -1)
> +		cpu = smp_processor_id();
> +	node = cpu_to_node(cpu);
> +
> +	buf = kzalloc_node(offsetof(struct cs_buffers, addr[nr_pages]),
> +			   GFP_KERNEL, node);
> +	if (!buf)
> +		return NULL;
> +
> +	buf->snapshot = overwrite;
> +	buf->nr_pages = nr_pages;
> +
> +	/* Record information about buffers */
> +	for (pg = 0; pg < buf->nr_pages; pg++)
> +		buf->addr[pg] = pages[pg];
> +
> +	return buf;
> +}
> +

this one is so generic that I'm tempted to move this into perf's
ring_buffer code, because by the looks of it we'll need it pretty much
in every setup_aux().

Regards,
--
Alex
