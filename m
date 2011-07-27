From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 27 Jul 2011 18:43:46 +0900
Subject: [RFC PATCH] DMA: PL330: Update PL330 DMAC to support runtime PM
In-Reply-To: <20110727085348.GB21584@n2100.arm.linux.org.uk>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
	<1311744697-10264-2-git-send-email-boojin.kim@samsung.com>
	<4E2FACC3.2010109@samsung.com>
	<20110727085348.GB21584@n2100.arm.linux.org.uk>
Message-ID: <4E2FDDD2.3070106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Jul 27, 2011 at 03:14:27PM +0900, Chanwoo Choi wrote:
>> +#ifdef CONFIG_PM_RUNTIME
>> +	struct dma_pl330_chan *pch;
>> +	struct dma_pl330_dmac *pdmac;
>> +#endif
>>  
>>  	dma_cap_zero(mask);
>>  	dma_cap_set(info->cap, mask);
>>  
>>  	chan = dma_request_channel(mask, pl330_filter, (void *)dma_ch);
>>  
>> +#ifdef CONFIG_PM_RUNTIME
>> +	pch = container_of(chan, struct dma_pl330_chan, chan);
>> +	pdmac = pch->dmac;
>> +
>> +	pm_runtime_get_sync(pdmac->pif.dev);
>> +#endif
> 
> This is not the right way to do this.  The pm runtime stuff should be
> internal to the PL330 driver.  Take a moment to think about this:
> 
> You need to wake it up just before a transfer starts.  You need to
> put it back to sleep just after the last transfer has finished.
> That gives you a hint where the calls need to be.
> 
> That can only be done from within the PL330 driver.
> 

Thanks for your comment&hint.

I will repost the patch which support runtime pm of PL330 in internal to the PL330 driver.

Regards,
Chanwoo Choi
