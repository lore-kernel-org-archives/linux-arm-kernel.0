From: joelf@ti.com (Joel Fernandes)
Date: Mon, 12 Aug 2013 19:05:33 -0500
Subject: [PATCH v3 01/12] dma: edma: Setup parameters to DMA MAX_NR_SG
 at a time
In-Reply-To: <52088B8B.9040000@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
 <1375719297-12871-2-git-send-email-joelf@ti.com> <52088B8B.9040000@ti.com>
Message-ID: <5209784D.8080502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Responding to other comments in this post,

On 08/12/2013 02:15 AM, Sekhar Nori wrote:

[..]
>>  	if (unlikely(!echan || !sgl || !sg_len))
>>  		return NULL;
>> @@ -262,8 +262,11 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
>>  
>>  	edesc->pset_nr = sg_len;
>>  
>> -	for_each_sg(sgl, sg, sg_len, i) {
>> -		/* Allocate a PaRAM slot, if needed */
>> +	/* Allocate a PaRAM slot, if needed */
>> +
>> +	num_slots_needed = sg_len > MAX_NR_SG ? MAX_NR_SG : sg_len;
> 
> nslots = min(MAX_NR_SG, sg_len);

Changed to this, with the +1

> 
>> +
>> +	for (i = 0; i < num_slots_needed; i++) {
>>  		if (echan->slot[i] < 0) {
>>  			echan->slot[i] =
>>  				edma_alloc_slot(EDMA_CTLR(echan->ch_num),
>> @@ -273,6 +276,10 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
>>  				return NULL;
>>  			}
>>  		}
>> +	}
>> +
>> +	/* Configure PaRAM sets for each SG */
>> +	for_each_sg(sgl, sg, sg_len, i) {
>>  
>>  		acnt = dev_width;
>>  
>> @@ -330,6 +337,7 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
>>  		/* Configure A or AB synchronized transfers */
>>  		if (edesc->absync)
>>  			edesc->pset[i].opt |= SYNCDIM;
>> +
> 
> Random extra newline.

Removing..

> 
> The patch as such is fine, but I dont think it makes lot of sense
> standalone. This needs to be merged into the patch where you actually
> handle the entire SG list in batches.

I think it does actually, this patch just takes care of preparing the
param set list correctly and allocating slots. It doesn't the actual DMA
or take part in the algorithm. As a result, the patch can be reused
incase in future the main algorithm is rewritten in a subsequent series.
Further this patch was reused straight from old implementation so it
proved to be useful being a separate patch last time. I also plan to
rewrite just this functionality in the future.

Thanks,

-Joel
