From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 30 Jan 2012 10:01:51 +0100
Subject: [PATCH] at_hdmac: bugfix for enabling channel irq
In-Reply-To: <4F159394.7040409@atmel.com>
References: <201201171023.q0HANwSE024485@gatekeeper.vosshq.de>
 <4F159394.7040409@atmel.com>
Message-ID: <4F265C7F.4070500@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2012 04:28 PM, Nicolas Ferre :
> On 01/17/2012 10:28 AM, Nikolaus Voss :
>> commit 463894705e4089d0ff69e7d877312d496ac70e5b deleted redundant
>> chan_id and chancnt initialization in dma drivers as this is done
>> in dma_async_device_register().
>>
>> However, atc_enable_irq() relied on chan_id set before registering
>> the device, what left only channel 0 functional for this driver.
>>
>> This patch introduces atc_enable/disable_chan_irq() as a variant
>> of atc_enable/disable_irq() with the channel as explicit argument.
>>
>> Signed-off-by: Nikolaus Voss <n.voss@weinmann.de>
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: stable <stable@vger.kernel.org>
> 
> Vinod, can you please queue it in a "fixes" branch for 3.3. The stable
> tag is needed to address errors in 3.2 kernel series.


Vinod, ping?


> Nikolaus, thanks for your fix.
> 
> Best regards,
> 
>> ---
>>  drivers/dma/at_hdmac.c      |    4 ++--
>>  drivers/dma/at_hdmac_regs.h |   17 ++++++++---------
>>  2 files changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
>> index fcfa0a8..a60adbf 100644
>> --- a/drivers/dma/at_hdmac.c
>> +++ b/drivers/dma/at_hdmac.c
>> @@ -1286,7 +1286,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
>>  
>>  		tasklet_init(&atchan->tasklet, atc_tasklet,
>>  				(unsigned long)atchan);
>> -		atc_enable_irq(atchan);
>> +		atc_enable_chan_irq(atdma, i);
>>  	}
>>  
>>  	/* set base routines */
>> @@ -1353,7 +1353,7 @@ static int __exit at_dma_remove(struct platform_device *pdev)
>>  		struct at_dma_chan	*atchan = to_at_dma_chan(chan);
>>  
>>  		/* Disable interrupts */
>> -		atc_disable_irq(atchan);
>> +		atc_disable_chan_irq(atdma, chan->chan_id);
>>  		tasklet_disable(&atchan->tasklet);
>>  
>>  		tasklet_kill(&atchan->tasklet);
>> diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
>> index aa4c9ae..5aa82b4 100644
>> --- a/drivers/dma/at_hdmac_regs.h
>> +++ b/drivers/dma/at_hdmac_regs.h
>> @@ -326,28 +326,27 @@ static void atc_dump_lli(struct at_dma_chan *atchan, struct at_lli *lli)
>>  }
>>  
>>  
>> -static void atc_setup_irq(struct at_dma_chan *atchan, int on)
>> +static void atc_setup_irq(struct at_dma *atdma, int chan_id, int on)
>>  {
>> -	struct at_dma	*atdma = to_at_dma(atchan->chan_common.device);
>> -	u32		ebci;
>> +	u32 ebci;
>>  
>>  	/* enable interrupts on buffer transfer completion & error */
>> -	ebci =    AT_DMA_BTC(atchan->chan_common.chan_id)
>> -		| AT_DMA_ERR(atchan->chan_common.chan_id);
>> +	ebci =    AT_DMA_BTC(chan_id)
>> +		| AT_DMA_ERR(chan_id);
>>  	if (on)
>>  		dma_writel(atdma, EBCIER, ebci);
>>  	else
>>  		dma_writel(atdma, EBCIDR, ebci);
>>  }
>>  
>> -static inline void atc_enable_irq(struct at_dma_chan *atchan)
>> +static void atc_enable_chan_irq(struct at_dma *atdma, int chan_id)
>>  {
>> -	atc_setup_irq(atchan, 1);
>> +	atc_setup_irq(atdma, chan_id, 1);
>>  }
>>  
>> -static inline void atc_disable_irq(struct at_dma_chan *atchan)
>> +static void atc_disable_chan_irq(struct at_dma *atdma, int chan_id)
>>  {
>> -	atc_setup_irq(atchan, 0);
>> +	atc_setup_irq(atdma, chan_id, 0);
>>  }
>>  
>>  
> 
> 


-- 
Nicolas Ferre
