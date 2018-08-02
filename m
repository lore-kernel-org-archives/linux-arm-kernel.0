From: hch@lst.de (Christoph Hellwig)
Date: Thu, 2 Aug 2018 14:43:28 +0200
Subject: [PATCH] arm64: remove dummy_dma_ops
In-Reply-To: <bbb22836-8f2f-5b2f-4801-342643fd9c1b@arm.com>
References: <20180802121318.5785-1-hch@lst.de>
 <bbb22836-8f2f-5b2f-4801-342643fd9c1b@arm.com>
Message-ID: <20180802124328.GA24812@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2018 at 01:32:17PM +0100, Robin Murphy wrote:
> On 02/08/18 13:13, Christoph Hellwig wrote:
>> Returning NULL from get_arch_dma_ops makes all DMA mapping routines
>> retourn sensible errors, so remove the dummy ops.
>
> Does it? AFAICS all of the non-optional callbacks will still either 
> BUG_ON(!ops) or blindly dereference the null pointer. Have I lost track of 
> another cleanup patch somewhere?

First thing any driver needs to do is dma_set_mask, which first calls
dma_supported:

static inline int dma_supported(struct device *dev, u64 mask)
{
        const struct dma_map_ops *ops = get_dma_ops(dev);

	if (!ops)
		return 0;
	...
}
