From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Aug 2013 12:09:27 +0100
Subject: [PATCH RFC 1/8] arm: make SWIOTLB available
In-Reply-To: <1375292732-7627-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1307311833040.4893@kaball.uk.xensource.com>
 <1375292732-7627-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20130801110927.GF24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 06:45:25PM +0100, Stefano Stabellini wrote:
> +static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> +{
> +	unsigned int offset = paddr & ~PAGE_MASK;
> +	return pfn_to_dma(dev, paddr >> PAGE_SHIFT) + offset;
> +}
> +
> +static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
> +{
> +	unsigned int offset = dev_addr & ~PAGE_MASK;
> +	return (dma_to_pfn(dev, dev_addr) << PAGE_SHIFT) + offset;
> +}

These two helpers look fine on the face of it.

> +static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
> +{
> +	if (!dev->dma_mask)
> +		return 0;
> +
> +	return addr + size - 1 <= *dev->dma_mask;
> +}

You may wish to have a closer look at the DMA bounce code, because this
assumes that DMA masks are a set of zeros followed by a set of ones.
That may not always be the case (and we have the odd platform where that
isn't the case.)

It has always bugged me that we call this thing a dma _mask_ and then
much kernel code treats it as a limit - it should've been called "dma
limit" if that's how it was to be interpreted.  If it really is a _mask_
then the right way to test whether a DMA address/size is possible is:

	u64 limit, mask = *dev->dma_mask;

	limit = (mask + 1) & ~mask;
	if (limit && size > limit)
		return 0;

	if ((addr | (addr + size - 1)) & ~mask)
		return 0;

	return 1;

The first checks whether 'size' fits within the least significant
contiguous set of '1' bits in the DMA mask, and the second checks
whether the region itself contains any address bits which may not
meet the DMA mask.

I guess if we aren't going to encounter any of these cases anymore,
your test is entirely sufficient.
