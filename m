From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 20 Oct 2015 14:37:58 +0300
Subject: [PATCH V2 19/30] coresight: etb10: implementing the setup_aux()
 API
In-Reply-To: <1445192687-24112-20-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
 <1445192687-24112-20-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <874mhlhisp.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

>  /**
> + * struct cs_buffer - keep track of a recording session' specifics
> + * @cur:	index of the current buffer
> + * @nr_pages:	max number of pages granted to us
> + * @nr_bufs:	number of clustered pages
> + * @offset:	offset within the current buffer
> + * @size:	how much space we have for this run
> + * @data_size:	how much we collected in this run
> + * @head:	head of the ring buffer
> + * @lost:	other than zero if we had a HW buffer wrap around
> + * @snapshot:	is this run in snapshot mode
> + * @addr:	virtual address this buffer starts at
> + */
> +struct cs_buffers {
> +	unsigned int		cur;
> +	unsigned int		nr_pages;
> +	unsigned int		nr_bufs;

This one is not really used.

> +	unsigned long		offset;
> +	unsigned long		size;

And this one seems to be only set in one place.

> +	local_t			data_size;
> +	local_t			head;

And so is this one.

> +	local_t			lost;
> +	bool			snapshot;
> +	void			*addr[0];

And this one seems to be a copy of what perf's ring buffer gives us.

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

Yes, buf::addr is a copy of @pages. You could save some space by just
saving @pages, it's going to be around until pmu::free_aux().

Regards,
--
Alex
