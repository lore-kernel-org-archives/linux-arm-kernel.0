From: joelf@ti.com (Joel Fernandes)
Date: Fri, 11 Apr 2014 15:56:00 -0500
Subject: [PATCH v2 08/14] DMA: edma: Use different eventq for cyclic
 channels
In-Reply-To: <20140411164755.GE32284@intel.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
 <1396357575-30585-9-git-send-email-peter.ujfalusi@ti.com>
 <5346C88E.8010504@ti.com> <20140411164755.GE32284@intel.com>
Message-ID: <534856E0.1040806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2014 11:47 AM, Vinod Koul wrote:
> On Thu, Apr 10, 2014 at 11:36:30AM -0500, Joel Fernandes wrote:
>> On 04/01/2014 08:06 AM, Peter Ujfalusi wrote:
>>> To improve latency with cyclic DMA operation it is preferred to
>>> use different eventq/tc than the default which is used by all
>>> other drivers (mmc, spi, i2c, etc).
>>> When preparing the cyclic dma ask for non default queue for the
>>> channel which is going to be used with cyclic mode.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>>  drivers/dma/edma.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
>>> index 1dd9e8806975..10048b40fac8 100644
>>> --- a/drivers/dma/edma.c
>>> +++ b/drivers/dma/edma.c
>>> @@ -628,6 +628,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
>>>  		edesc->pset[i].opt |= TCINTEN;
>>>  	}
>>>  
>>> +	/* Use different eventq/tc for cyclic DMA to reduce latency */
>>> +	edma_request_non_default_queue(echan->ch_num);
>>> +
>>>  	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
>>>  }
>>>  
>>>
>>
>> Is there any way to guarantee that the non-default queue is of the
>> highest priority, or in other words default queue is of lowest priority.
> well as we are discussing in other thread, it would make sense to pass the
> required priority (i am using audio so pls give me highest one)
> 

Yes, I'm aware of that part of the discussion ;) I also replied there.
This post was sent much earlier on.

thanks,

-Joel
