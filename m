From: joelf@ti.com (Joel Fernandes)
Date: Thu, 17 Apr 2014 20:02:30 -0500
Subject: [patch 5/6] edma: Make reading the position of active channels
 work
In-Reply-To: <5350761C.6010109@ti.com>
References: <20140417133737.892475126@linutronix.de>
 <20140417143249.889774979@linutronix.de> <5350761C.6010109@ti.com>
Message-ID: <535079A6.6090301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 07:47 PM, Joel Fernandes wrote:
> On 04/17/2014 09:40 AM, Thomas Gleixner wrote:
>> Reading destination and source is pointless. In DEV_TO_MEM transfers
>> we are only interested in the destination, in MEM_TO_DEV we care about
>> the source. In MEM_TO_MEM it really does not matter which one you
>> read.
>>
>> Remove the extra pointer and select dest/source via a bool.
>>
>> Reading the src/dst data from an active parameter set in the EDMA
>> parameter RAM is not reliable, as there might be a concurrent update
>> from the controller.
>>
>> But experimentation showed, that a double readout with comparing the
>> results and a limited loop works nicely. I've actually never found a
>> case where the loop limit triggered, but we have it there for sanity
>> reasons. In case it triggers we return -EBUSY and let the caller deal
>> with it.
>>
>> Remove the export of this function while at it. The only potential
>> user is the dmaengine and that's always builtin.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  arch/arm/common/edma.c             |   48 ++++++++++++++++++++++++++-----------
>>  include/linux/platform_data/edma.h |    2 -
>>  2 files changed, 35 insertions(+), 15 deletions(-)
>>
>> Index: linux/arch/arm/common/edma.c
>> ===================================================================
>> --- linux.orig/arch/arm/common/edma.c
>> +++ linux/arch/arm/common/edma.c
>> @@ -994,29 +994,49 @@ void edma_set_dest(unsigned slot, dma_ad
>>  EXPORT_SYMBOL(edma_set_dest);
>>  
>>  /**
>> - * edma_get_position - returns the current transfer points
>> + * edma_get_position - returns the current transfer point
>>   * @slot: parameter RAM slot being examined
>> - * @src: pointer to source port position
>> - * @dst: pointer to destination port position
>> + * @pos:  where to store the data
>> + * @dst:  true selects the dest position, false the source
>>   *
>> - * Returns current source and destination addresses for a particular
>> - * parameter RAM slot.  Its channel should not be active when this is called.
>> + * Return 0 indicates a stable readout. -EBUSY indicates that the
>> + * readout failed due to concurrent updates.
>> + *
>> + * Call this on active channels with care. For inactive channels this
>> + * never fails.
>>   */
>> -void edma_get_position(unsigned slot, dma_addr_t *src, dma_addr_t *dst)
>> +int edma_get_position(unsigned slot, dma_addr_t *pos, bool dst)
>>  {
>> -	struct edmacc_param temp;
>> -	unsigned ctlr;
>> +	u32 dat, ctlr, offs;
>> +	int i;
>>  
>>  	ctlr = EDMA_CTLR(slot);
>>  	slot = EDMA_CHAN_SLOT(slot);
>>  
>> -	edma_read_slot(EDMA_CTLR_CHAN(ctlr, slot), &temp);
>> -	if (src != NULL)
>> -		*src = temp.src;
>> -	if (dst != NULL)
>> -		*dst = temp.dst;
>> +	if (slot >= edma_cc[ctlr]->num_slots)
>> +		return -EINVAL;
>> +
>> +	offs = PARM_OFFSET(slot);
>> +	offs += dst ? PARM_DST : PARM_SRC;
>> +
>> +	/*
>> +	 * If the channel is active, we need to double read as we
>> +	 * might see half updated data. We limit this to 5
>> +	 * attempts. If that fails we return -EBUSY and let the caller
>> +	 * deal with it.
>> +	 */
>> +	dat = edma_read(ctlr, offs);
>> +	for (i = 0; i < 5; i++) {
>> +		u32 tmp = edma_read(ctlr, offs);
>> +
>> +		if (tmp == dat) {
>> +			*pos = dat;
>> +			return 0;
>> +		}
>> +		dat = tmp;
>> +	}
>> +	return -EBUSY;
>>  }
>> -EXPORT_SYMBOL(edma_get_position);
>>  
>>  /**
> 
> The access is synchronized though and you shouldn't see unreliable
> results, unless you _are_ seeing unreliable results in which case it
> could be a silicon issue.
> 
> The original code also doesn't have the double read so I would just drop
> that, unless you are seeing reliability issues.
> 
> Here's a thread that discusses it and the end conclusion is that it
> should be fine (Kyle Kastile is one of the EDMA hardware designers).
> http://e2e.ti.com/support/dsp/davinci_digital_media_processors/f/99/t/66011.aspx

I'm sorry to have messed up Kyle's name, its Kyle Castille ;-)

thanks,
 -Joel
