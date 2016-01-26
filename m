From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 26 Jan 2016 17:53:56 +0200
Subject: [PATCH V8 16/23] coresight: etb10: implementing AUX API
In-Reply-To: <1452807977-8069-17-git-send-email-mathieu.poirier@linaro.org>
References: <1452807977-8069-1-git-send-email-mathieu.poirier@linaro.org>
 <1452807977-8069-17-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <8760yg72wb.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> Adding an ETB10 specific AUX area operations to be used
> by the perf framework when events are initialised.
>
> Part of this operation involves modeling the mmap'ed area
> based on the specific ways a sink buffer gathers information.

I don't mind being CC'd on the rest of the patches too, btw. :)

> +static unsigned long etb_reset_buffer(struct coresight_device *csdev,
> +				      struct perf_output_handle *handle,
> +				      void *sink_config, bool *lost)
> +{
> +	unsigned long size = 0;
> +	struct cs_buffers *buf = sink_config;
> +
> +	if (buf) {
> +		/*
> +		 * In snapshot mode ->data_size holds the new address of the
> +		 * ring buffer's head.  The size itself is the whole address
> +		 * range since we want the latest information.
> +		 */
> +		if (buf->snapshot)
> +			handle->head = local_xchg(&buf->data_size,
> +						  buf->nr_pages << PAGE_SHIFT);
> +
> +		/*
> +		 * Tell the tracer PMU how much we got in this run and if
> +		 * something went wrong along the way.  Nobody else can use
> +		 * this cs_buffers instance until we are done.  As such
> +		 * resetting parameters here and squaring off with the ring
> +		 * buffer API in the tracer PMU is fine.
> +		 */
> +		*lost = local_xchg(&buf->lost, 0);

This is a thin ice, you can't really make assumptions about bool's
storage size or even type, afaict.

> +		size = local_xchg(&buf->data_size, 0);
> +	}
> +
> +	return size;
> +}
> +
> +static void etb_update_buffer(struct coresight_device *csdev,
> +			      struct perf_output_handle *handle,
> +			      void *sink_config)
> +{
> +	int i, cur;
> +	u8 *buf_ptr;
> +	u32 read_ptr, write_ptr, capacity;
> +	u32 status, read_data, to_read;
> +	unsigned long flags, offset;
> +	struct cs_buffers *buf = sink_config;
> +	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	if (!buf)
> +		return;
> +
> +	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);

This spinlock seems to be held over the entire readout operation,
however, I can't find clear rules wrt what structures etc are serialized
on it. Instead, the comment says "only one at a time pls". Same for
etm's big drvdata spinlock.

Regards,
--
Alex
