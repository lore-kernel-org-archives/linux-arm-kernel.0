From: kernel@martin.sperl.org (Martin Sperl)
Date: Wed, 13 Jan 2016 14:38:40 +0100
Subject: [PATCH V2 6/8] dmaengine: bcm2835: move controlblock chain
 generation into separate method
In-Reply-To: <20160113132333.GC11130@localhost>
References: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
 <1452187987-2605-7-git-send-email-kernel@martin.sperl.org>
 <20160113132333.GC11130@localhost>
Message-ID: <56965360.4010600@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.01.2016 14:23, Vinod Koul wrote:
> On Thu, Jan 07, 2016 at 05:33:04PM +0000, kernel at martin.sperl.org wrote:
>
>> +static inline bool bcm2835_dma_is_lite(struct bcm2835_chan *c)
>> +{
>> +	/* dma channels >= 7 are LITE channels */
>> +	return (c->ch >= 7);
>
> Why not DT data here as well

See other email with comments on DT.

>
>> +}
>> +
>> +static inline size_t bcm2835_dma_max_frame_length(struct bcm2835_chan *c)
>> +{
>> +	/* lite and normal channels have different max frame length */
>> +	return bcm2835_dma_is_lite(c) ? MAX_LITE_DMA_LEN : MAX_DMA_LEN;
>
> Or rather get length from DT..
See other email with comments on DT.

>> +	/* allocate and setup the descriptor. */
>> +	d = kzalloc(sizeof(*d) + frames * sizeof(struct bcm2835_cb_entry),
>> +		    gfp);
>
> odd style.. btw should flag be GFP_NOWAIT ..?
gfp was used as a method-argument - see your comment below.

>
>> +		/* fill in the control block */
>> +		control_block = cb_entry->cb;
>> +		control_block->info = info;
>> +		control_block->src = src;
>> +		control_block->dst = dst;
>> +		if (buf_len) {
>> +			control_block->length = min(max_len, len);
>> +			if (period_len &&
>> +			    (total_len + control_block->length >=
>> +			     period_len)) {
>> +				/* set to end of period_len */
>> +				control_block->length =
>> +					period_len - total_len;
>> +				/* add extrainfo when cyclic */
>> +				if (cyclic)
>> +					control_block->info |=
>> +						finalextrainfo;
>> +				/* and reset total_len */
>> +				total_len = 0;
>> +			}
>
> this looks hard to read, perhpas a helper will make it look better
Perhaps - I can look...
>
>> +	/* the last frame requires extra flags */
>> +	d->cb_list[d->frames - 1].cb->info |= finalextrainfo;
>> +
>> +	/* check the size - if there is some missmatch,
>> +	 * then this is detected here
>> +	 */
>
> this is not kernel style for multi-line comments
I know - this came up with a different patch-set

>
>>   	/* Grab configuration */
>>   	if (!is_slave_direction(direction)) {
>> -		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
>> +		dev_err(chan->device->dev,
>> +			"%s: bad direction?\n", __func__);
>
> unrelated change
OK

>
>> -	/* Now allocate and setup the descriptor. */
>> -	d = kzalloc(sizeof(*d), GFP_NOWAIT);
>> -	if (!d)
>> -		return NULL;
>> +	/* warn if buf_len is not a multiple of period_lenas this may leed
>> +	 * to unexpected latencies for interrupts and thus audiable clicks
>> +	 */
>
> here too

as this code is new and there are a few more issues that have been seen
it was included here...

>
>>   	/*
>> -	 * Iterate over all frames, create a control block
>> -	 * for each frame and link them together.
>> +	 * allocate the CB chain
>> +	 * note that we need to use GFP_ATOMIC, as the ALSA i2s dmaengine
>
> dmaengine drivers use GFP_NOWAIT in these cases
OK we were not sure if this was "permissible" or would result in rare
issues...

I will wait on the generic DT discussion before sending any updates
incorporating both...
