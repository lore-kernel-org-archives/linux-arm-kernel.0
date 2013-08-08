From: zonque@gmail.com (Daniel Mack)
Date: Thu, 08 Aug 2013 10:35:08 +0200
Subject: [PATCH 01/12] dma: mmp_pdma: add protect when alloc/free phy
 channels
In-Reply-To: <20130807124011.GB2383@localhost>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
 <1375870770-14263-2-git-send-email-zonque@gmail.com>
 <20130807124011.GB2383@localhost>
Message-ID: <5203583C.20109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.08.2013 14:40, Ezequiel Garcia wrote:
> Daniel,
> 
> It's good to see this effort is moving forward!
> 
> I just have a minor nitpick.

I just realized that Vinod already commited this patch to his tree, so I
won't be sending it again.


Daniel

> 
> On Wed, Aug 07, 2013 at 12:19:19PM +0200, Daniel Mack wrote:
>>  
>>  #define tx_to_mmp_pdma_desc(tx) container_of(tx, struct mmp_pdma_desc_sw, async_tx)
>> @@ -219,6 +220,7 @@ static struct mmp_pdma_phy *lookup_phy(struct mmp_pdma_chan *pchan)
>>  	int prio, i;
>>  	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(pchan->chan.device);
>>  	struct mmp_pdma_phy *phy;
>> +	unsigned long flags;
>>  
>>  	/*
>>  	 * dma channel priorities
>> @@ -227,6 +229,8 @@ static struct mmp_pdma_phy *lookup_phy(struct mmp_pdma_chan *pchan)
>>  	 * ch 8 - 11, 24 - 27  <--> (2)
>>  	 * ch 12 - 15, 28 - 31  <--> (3)
>>  	 */
>> +
>> +	spin_lock_irqsave(&pdev->phy_lock, flags);
>>  	for (prio = 0; prio <= (((pdev->dma_channels - 1) & 0xf) >> 2); prio++) {
>>  		for (i = 0; i < pdev->dma_channels; i++) {
>>  			if (prio != ((i & 0xf) >> 2))
>> @@ -234,14 +238,30 @@ static struct mmp_pdma_phy *lookup_phy(struct mmp_pdma_chan *pchan)
>>  			phy = &pdev->phy[i];
>>  			if (!phy->vchan) {
>>  				phy->vchan = pchan;
>> +				spin_unlock_irqrestore(&pdev->phy_lock, flags);
> 
> Isn't it better to goto ...
> 
>>  				return phy;
>>  			}
>>  		}
>>  	}
>>  
> 
> ... here?
> 
> I think it's generally cleaner and less error-prone.
> 
>> +	spin_unlock_irqrestore(&pdev->phy_lock, flags);
>>  	return NULL;
>>  }
>>  
> 
