From: rabin@rab.in (Rabin Vincent)
Date: Sat, 19 Dec 2015 18:23:14 +0100
Subject: [PATCH V7 17/24] coresight: etb10: implementing AUX space API
In-Reply-To: <1450472361-426-18-git-send-email-mathieu.poirier@linaro.org>
References: <1450472361-426-1-git-send-email-mathieu.poirier@linaro.org>
 <1450472361-426-18-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20151219172314.GB2437@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 01:59:13PM -0700, Mathieu Poirier wrote:
> +static void etb_update_buffer(struct coresight_device *csdev,
> +			      struct perf_output_handle *handle,
> +			      void *sink_config)
> +{
> +	int i, cur;
> +	u32 *buf_ptr;

...

> +	for (i = 0; i < to_read; i += 4) {
> +		buf_ptr = buf->data_pages[cur] + offset;
> +		read_data = readl_relaxed(drvdata->base +
> +					  ETB_RAM_READ_DATA_REG);
> +		*buf_ptr++ = read_data >> 0;
> +		*buf_ptr++ = read_data >> 8;
> +		*buf_ptr++ = read_data >> 16;
> +		*buf_ptr++ = read_data >> 24;

buf_ptr should either be changed to a u8* or just the first write should
be present.  Otherwise this overwrites lots of memory.

> +
> +		offset += 4;
> +		if (offset >= PAGE_SIZE) {
