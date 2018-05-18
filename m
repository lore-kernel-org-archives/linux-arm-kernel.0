From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Fri, 18 May 2018 10:28:09 -0700
Subject: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent
 implementation
In-Reply-To: <20180518132731.GA31125@lst.de>
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-3-hch@lst.de>
 <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
 <20180518132731.GA31125@lst.de>
Message-ID: <482e343c-bc87-9c0e-b6a8-bb69bcbeecda@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2018 06:23 AM, hch at lst.de wrote:
>   Fri, May 18, 2018 at 01:03:46PM +0000, Alexey Brodkin wrote:
>> Note mmc_get_dma_dir() is just "data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE".
>> I.e. if we're preparing for sending data dma_noncoherent_map_sg() will have DMA_TO_DEVICE which
>> is quite OK for passing to dma_noncoherent_sync_sg_for_device() but in case of reading we'll have
>> DMA_FROM_DEVICE which we'll pass to dma_noncoherent_sync_sg_for_device() in dma_noncoherent_map_sg().
>>
>> I'd say this is not entirely correct because IMHO arch_sync_dma_for_cpu() is supposed to only be used
>> in case of DMA_FROM_DEVICE and arch_sync_dma_for_device() only in case of DMA_TO_DEVICE.
> arc overrides the dir paramter of the dma_sync_single_for_device/
> dma_sync_single_for_cpu calls.  My patches dropped that, and I have
> restored that, and audit for the other architectures is pending.

Right, for now lets retain that and do a sweeping audit of @direction - to me it 
seems extraneous (as it did 10 years ago), but I'm not an expert in this are so 
perhaps it is needed for some device / arches and it would be good to understand 
that finally.

> That being said the existing arc code still looks rather odd as it
> didn't do the same thing for the scatterlist versions of the calls.
> I've thrown in a few patches into my new tree to make the sg versions
> make the normal calls, and to clean up the area a bit.

Not calling names or anything here, but it doesn't exist for sg variants, because 
I didn't write that code :-)
It was introduced by your commi:

2016-01-20 052c96dbe33b arc: convert to dma_map_ops
