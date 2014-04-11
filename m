From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 11 Apr 2014 09:39:10 +0300
Subject: [PATCH v2 10/14] dma: edma: Simplify direction configuration
 in edma_config_pset()
In-Reply-To: <53471DC5.4090001@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
 <1396357575-30585-11-git-send-email-peter.ujfalusi@ti.com>
 <53471DC5.4090001@ti.com>
Message-ID: <53478E0E.8040709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2014 01:40 AM, Joel Fernandes wrote:
> On 04/01/2014 08:06 AM, Peter Ujfalusi wrote:
>> We only support DEV_TO_MEM or MEM_TO_DEV directions with edma driver and the
>> check for the direction has been already done in the function calling
>> edma_config_pset().
>> The error reporting is redundant and also the "else if ()" can be removed.
>>
> 
> NAK. Please don't do this. I have been working on MEM_TO_MEM support as
> well so leave it as it is for future.

Sure. It is still valid to say that the error else {} will never going to
happen since you have the same check in the calling function and they already
filtered the non implemented direction.

I'll leave this out from v3.

-- 
P?ter

> 
> Thanks,
> -Joel
> 
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/edma.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
>> index 855766672aa9..d954099650ae 100644
>> --- a/drivers/dma/edma.c
>> +++ b/drivers/dma/edma.c
>> @@ -372,14 +372,12 @@ static int edma_config_pset(struct dma_chan *chan, struct edmacc_param *pset,
>>  		src_cidx = cidx;
>>  		dst_bidx = 0;
>>  		dst_cidx = 0;
>> -	} else if (direction == DMA_DEV_TO_MEM)  {
>> +	} else {
>> +		/* DMA_DEV_TO_MEM */
>>  		src_bidx = 0;
>>  		src_cidx = 0;
>>  		dst_bidx = acnt;
>>  		dst_cidx = cidx;
>> -	} else {
>> -		dev_err(dev, "%s: direction not implemented yet\n", __func__);
>> -		return -EINVAL;
>>  	}
>>  
>>  	pset->opt = EDMA_TCC(EDMA_CHAN_SLOT(echan->ch_num));
>>
> 
