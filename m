From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 20 Oct 2015 12:56:47 +0300
Subject: [PATCH V2 20/30] coresight: etb10: implementing buffer
 set/reset() API
In-Reply-To: <1445192687-24112-21-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
 <1445192687-24112-21-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <877fmhhnhc.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> Implementing perf related APIs to activate and terminate
> a trace session.  More specifically dealing with the sink
> buffer's internal mechanic along with perf's API to start
> and stop interactions with the ring buffers.

A matter of preference, but I'd say that it would be easier to review
this part if you merged all the buffer related patches together.

> +static void etb_reset_buffer(struct coresight_device *csdev,
> +			     struct perf_output_handle *handle,
> +			     void *sink_config)
> +{
> +	struct cs_buffers *buf = sink_config;
> +	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
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

Does it make sense to do this in etb_update_buffer() instead?

> +		perf_aux_output_end(handle, local_xchg(&buf->data_size, 0),
> +				    local_xchg(&buf->lost, 0));

The corresponding perf_aux_output_begin() is done in etm_event_add(),
I'd suggest that you do this in etm_event_del(),
unconditionally. Otherwise you're risking ending up with a refcount leak
and all sorts of horror.

Regards,
--
Alex
