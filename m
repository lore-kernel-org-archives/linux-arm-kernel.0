From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 11 Sep 2018 13:54:09 -0600
Subject: [PATCH v2 2/2] coresight: tmc: Fix writing barrier packets for
 ring buffer
In-Reply-To: <1536652366-17119-3-git-send-email-leo.yan@linaro.org>
References: <1536652366-17119-1-git-send-email-leo.yan@linaro.org>
 <1536652366-17119-3-git-send-email-leo.yan@linaro.org>
Message-ID: <20180911195409.GA17613@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

On Tue, Sep 11, 2018 at 03:52:46PM +0800, Leo Yan wrote:
> When tmc driver updates ring buffer and detects the ETB RAM has a wrap
> around, in the head of ring buffer the first four words is filled trace
> data by reading out RRD register, but the driver simply discards the
> first four words and leave the memory to store the barrier packets with
> value 0x7fff,ffff.  As result we get below data content in the buffer:
> 
>   +--------+--------+--------+--------+--------+--------+--------+
>   | trace0 | trace1 | trace2 | trace3 | trace4 | trace5 |  ...   |
>   |   v    |   v    |   v    |   v    |        |        |        |
>   | barrier| barrier| barrier| barrier|        |        |        |
>   +--------+--------+--------+--------+--------+--------+--------+


Right, that is how things are.

> 
> On the other hand, the ring buffer actually has enough space for saving

s/ring buffer/perf ring buffer/

I understood what you meant because of history and context but otherwise someone
can easily get lost.

> both barrier packets and trace data from ETB RAM.  Ideally we should
> save both barrier packets and complete trace data in the ETB RAM for the
> wrap around case.  So below is the ideal data content we can get: the
> first four words are for barrier packets and then save trace data from
> reading the first word from RRD register.
> 
>   +--------+--------+--------+--------+--------+--------+--------+
>   | barrier| barrier| barrier| barrier| trace0 | trace1 |  ...   |
>   +--------+--------+--------+--------+--------+--------+--------+

I thought about doing just that when I first looked at this driver but decided
the gains were small compared to the efforts (and messy code that comes with
it).  I mean, the internal component buffer has already wrapped around,
potentially several times, I am not convinced that saving 4 byte will change a
whole lot.

> 
> To achieve this purpose, this patch introduces a variable 'barrier_sz'
> to present the barrier packets length is to be written into the ring
> buffer.  There have two cases that we will lose trace data so need to
> insert the barrier packets between two discontinuous trace data block;
> the first one case is the ETB RAM is in full state, another case is the
> ring buffer has no enough space for trace data at this time.
> 
> We firstly need to reserve memory space in the ring buffer for barrier
> packets and the left memory space can be used to save trace data. This
> patch caps the value 'barrier_sz' so ensure barrier length is not longer
> than ring buffer and calculate the rest memory space for 'to_read' for
> trace data recording.

As usual a changelog should emphasise on "why" rather than "what".

> 
> At the data saving stage, the patch firstly saves barrier packets
> without reading RRD register so that will not lose trace data; after
> that it will save trace data by accessing RRD register.  At the end, the
> read data length is the sum value of barrier length 'barrier_sz' plus
> trace data length 'to_read'.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 37 ++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index b54a3db..6265370 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -367,7 +367,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>  	u32 *buf_ptr;
>  	u64 read_ptr, write_ptr;
>  	u32 status;
> -	unsigned long offset, to_read;
> +	unsigned long offset, to_read, barrier_sz = 0;
>  	struct cs_buffers *buf = sink_config;
>  	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
> @@ -398,11 +398,19 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>  	}
>  
>  	/*
> -	 * The TMC RAM buffer may be bigger than the space available in the
> -	 * perf ring buffer (handle->size).  If so advance the RRP so that we
> -	 * get the latest trace data.
> +	 * Drop some trace data when the TMC RAM buffer is full or bigger than
> +	 * perf ring buffer.  Since the trace data is discontinuous so need to
> +	 * insert barrier packets.
>  	 */
> -	if (to_read > handle->size) {
> +	if (lost || to_read > handle->size)
> +		barrier_sz = CORESIGHT_BARRIER_PKT_SIZE;
> +
> +	/*
> +	 * The sum of trace data and inserted barriers may be bigger than the
> +	 * space available in the perf ring buffer (handle->size).  If so
> +	 * advance the RRP so that we get the latest trace data.
> +	 */
> +	if (to_read + barrier_sz > handle->size) {
>  		u32 mask = 0;

If the internal buffer is bigger than the perf ring buffer there isn't much we
can do - we will end up clobbering traces regardless as the current
implementation does.  As such I don't see the need to account for the size of
the barrier packet.

>  
>  		/*
> @@ -424,11 +432,15 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>  			break;
>  		}
>  
> +		/* Make sure barrier isn't out of bound */
> +		barrier_sz = min_t(u32, barrier_sz, handle->size);
> +
>  		/*
> -		 * Make sure the new size is aligned in accordance with the
> +		 * Firstly reserve the memory for inserted barrier packets;
> +		 * make sure the new size is aligned in accordance with the
>  		 * requirement explained above.
>  		 */
> -		to_read = handle->size & mask;
> +		to_read = (handle->size - barrier_sz) & mask;
>  		/* Move the RAM read pointer up */
>  		read_ptr = (write_ptr + drvdata->size) - to_read;
>  		/* Make sure we are still within our limits */
> @@ -447,13 +459,14 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>  	barrier = barrier_pkt;
>  
>  	/* for every byte to read */
> -	for (i = 0; i < to_read; i += 4) {
> +	for (i = 0; i < to_read + barrier_sz; i += 4) {
>  		buf_ptr = buf->data_pages[cur] + offset;
> -		*buf_ptr = readl_relaxed(drvdata->base + TMC_RRD);
>  
> -		if (lost && *barrier) {
> +		if (i < barrier_sz) {
>  			*buf_ptr = *barrier;
>  			barrier++;

I think we have a problem here - see how Suzuki has implemented function
tmc_etb_dump_hw() in this file.  I'm pretty sure his intention was to address
this loop as well (since the processing is the same) but it slipped through the
cracks somewhere.  

Anyways, if you want to move forward with this feature please add a patch that
ends up using coresight_insert_barrier_packet() before doing anything else.

I also think that if we do it for one component, the same scheme has to be
enacted for all the sinks.  So ETB, TMC-ETB, TMC-ETF, ETR-CM and ETR-SG.  As I
said, not sure it is worth the trouble just to save 4 byte.

> +		} else {
> +			*buf_ptr = readl_relaxed(drvdata->base + TMC_RRD);
>  		}
>  
>  		offset += 4;
> @@ -469,7 +482,11 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>  	if (buf->snapshot) {
>  		handle->head = (cur * PAGE_SIZE) + offset;
>  		to_read = buf->nr_pages << PAGE_SHIFT;
> +	} else {
> +		/* Sum of trace data size and barrier size */
> +		to_read = to_read + barrier_sz;
>  	}
> +

Extra cosmetic modification.

Regards,
Mathieu

>  	CS_LOCK(drvdata->base);
>  
>  	return to_read;
> -- 
> 2.7.4
> 
