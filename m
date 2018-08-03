From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 3 Aug 2018 16:05:22 +0100
Subject: [PATCH] arm64: remove dummy_dma_ops
In-Reply-To: <20180802124328.GA24812@lst.de>
References: <20180802121318.5785-1-hch@lst.de>
 <bbb22836-8f2f-5b2f-4801-342643fd9c1b@arm.com>
 <20180802124328.GA24812@lst.de>
Message-ID: <55940a06-4418-287c-1a6c-3db18a0e3ddd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/18 13:43, Christoph Hellwig wrote:
> On Thu, Aug 02, 2018 at 01:32:17PM +0100, Robin Murphy wrote:
>> On 02/08/18 13:13, Christoph Hellwig wrote:
>>> Returning NULL from get_arch_dma_ops makes all DMA mapping routines
>>> retourn sensible errors, so remove the dummy ops.
>>
>> Does it? AFAICS all of the non-optional callbacks will still either
>> BUG_ON(!ops) or blindly dereference the null pointer. Have I lost track of
>> another cleanup patch somewhere?
> 
> First thing any driver needs to do is dma_set_mask, which first calls
> dma_supported:
> 
> static inline int dma_supported(struct device *dev, u64 mask)
> {
>          const struct dma_map_ops *ops = get_dma_ops(dev);
> 
> 	if (!ops)
> 		return 0;
> 	...
> }
> 

Yeah, apart from all the drivers that don't. After last week's fun I'm 
not putting any reliance in that assumption ;)

Of course, the combination of a cheeky legacy driver assuming 32-bit DMA 
*and* busted firmware failing to describe that device properly should be 
rare enough that this change is almost certainly a non-issue in 
practice, but I'm still never going to say I love it.

Robin.
