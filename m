From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 18 Jul 2017 12:26:14 -0400
Subject: [PATCH V3 1/2] dmaengine: qcom_hidma: introduce memset support
In-Reply-To: <20170718161956.GV3053@localhost>
References: <1498789858-18583-1-git-send-email-okaya@codeaurora.org>
 <20170718161956.GV3053@localhost>
Message-ID: <29d47cc4-f618-7253-6f59-41f10e7b4b87@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 7/18/2017 12:19 PM, Vinod Koul wrote:
> On Thu, Jun 29, 2017 at 10:30:57PM -0400, Sinan Kaya wrote:
> 
>> @@ -410,7 +410,40 @@ static int hidma_alloc_chan_resources(struct dma_chan *dmach)
>>  		return NULL;
>>  
>>  	hidma_ll_set_transfer_params(mdma->lldev, mdesc->tre_ch,
>> -				     src, dest, len, flags);
>> +				     src, dest, len, flags,
>> +				     HIDMA_TRE_MEMCPY);
>> +
>> +	/* Place descriptor in prepared list */
>> +	spin_lock_irqsave(&mchan->lock, irqflags);
>> +	list_add_tail(&mdesc->node, &mchan->prepared);
>> +	spin_unlock_irqrestore(&mchan->lock, irqflags);
> 
> This change looks suspicious, cna you clarify the need to do this?
> 
> 

Diff looks weird for some reason. I noticed that too.

I just added HIDMA_TRE_MEMCPY parameter to hidma_ll_set_transfer_params() function call
from hidma_prep_dma_memcpy() and created a new hidma_prep_dma_memset() function very
similar to memcpy with HIDMA_TRE_MEMSET call difference.

My suggestion is to use kdiff or another visual tool to look at the change.

Sinan
-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
