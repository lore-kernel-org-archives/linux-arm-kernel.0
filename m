From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 1 Dec 2015 12:12:47 +0200
Subject: [RFC v02 00/15] dmaengine: New 'universal' API for requesting
 channel
In-Reply-To: <13562653.8QgTG33tZS@wuerfel>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <13562653.8QgTG33tZS@wuerfel>
Message-ID: <565D729F.2000104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2015 04:18 PM, Arnd Bergmann wrote:
> On Monday 30 November 2015 15:45:30 Peter Ujfalusi wrote:
>> Changes since RFC v01:
>> - dma_request_chan(); lost the mask parameter
>> - The new API does not rely on RESOURCE_DMA, instead the dma_filter_map table
>>  will be used to provide the needed information to the filter function in
>>  legacy mode
>> - Extended the example patches to convert most of daVinci to use the new API to
>>  request the DMA channels.
> 
> Very nice overall. Just a few minor comments.
> 
>> static struct dma_filter_map da830_edma_map[] = {
>>         DMA_FILTER_ENTRY("davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0, 0)),
>>         DMA_FILTER_ENTRY("davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0, 1)),
>>         DMA_FILTER_ENTRY("davinci-mcasp.1", "rx", EDMA_CTLR_CHAN(0, 2)),
>>         DMA_FILTER_ENTRY("davinci-mcasp.1", "tx", EDMA_CTLR_CHAN(0, 3)),
>>         DMA_FILTER_ENTRY("davinci-mcasp.2", "rx", EDMA_CTLR_CHAN(0, 4)),
>>         DMA_FILTER_ENTRY("davinci-mcasp.2", "tx", EDMA_CTLR_CHAN(0, 5)),
>>         DMA_FILTER_ENTRY("spi_davinci.0", "rx", EDMA_CTLR_CHAN(0, 14)),
>>         DMA_FILTER_ENTRY("spi_davinci.0", "tx", EDMA_CTLR_CHAN(0, 15)),
>>         DMA_FILTER_ENTRY("da830-mmc.0", "rx", EDMA_CTLR_CHAN(0, 16)),
>>         DMA_FILTER_ENTRY("da830-mmc.0", "tx", EDMA_CTLR_CHAN(0, 17)),
>>         DMA_FILTER_ENTRY("spi_davinci.1", "rx", EDMA_CTLR_CHAN(0, 18)),
>>         DMA_FILTER_ENTRY("spi_davinci.1", "tx", EDMA_CTLR_CHAN(0, 19)),
>> };
> 
> I wonder if we should mandate that the lookup table is 'const'.

I had been wondering the same, I'll make it const for the next round.

> We could also drop the DMA_FILTER_ENTRY() macro above, and open-code the
> table like
> 
> static struct dma_filter_map da830_edma_map[] = {
>          { "davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0, 0)},
>          { "davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0, 1)},
>          { "davinci-mcasp.1", "rx", EDMA_CTLR_CHAN(0, 2)},
> 	 ...
> };
> 
> which is a little more compact and more obvious, but loses the
> named initializers.

We would need:
	{ "da830-mmc.0", "rx", (void*)EDMA_CTLR_CHAN(0, 16) },
	{ "da830-mmc.0", "tx", (void*)EDMA_CTLR_CHAN(0, 17) },

as we need to cast the param.
It is still compact, but having to add the (void*) casting makes it a bit ugly.

-- 
P?ter
