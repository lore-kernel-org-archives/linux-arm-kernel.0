From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 1 Mar 2018 11:50:07 +0000
Subject: [PATCH v2] arm64: Revert L1_CACHE_SHIFT back to 6 (64-byte cache
 line size)
In-Reply-To: <f85cb667-479a-4bf5-bc07-b3ad2064a9af@arm.com>
References: <20180228184720.25467-1-catalin.marinas@arm.com>
 <f85cb667-479a-4bf5-bc07-b3ad2064a9af@arm.com>
Message-ID: <20180301115006.3lhtwvknc4huet5p@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Wed, Feb 28, 2018 at 07:18:47PM +0000, Robin Murphy wrote:
> On 28/02/18 18:47, Catalin Marinas wrote:
> > +static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
> > +{
> > +	if (!dev->dma_mask)
> > +		return false;
> > +
> > +	/*
> > +	 * Force swiotlb buffer bouncing when ARCH_DMA_MINALIGN < CWG. The
> > +	 * swiotlb bounce buffers are aligned to (1 << IO_TLB_SHIFT).
> > +	 */
> 
> The relevance of the second half of that comment isn't entirely obvious - I
> assume you're referring to the fact that the IOTLB slab size happens to
> conveniently match the largest possible CWG?

Yes, that's the idea. I could have added "are /sufficiently/ aligned",
though it doesn't make it much clearer.

> I wonder somewhat if it's worth going even further down the ridiculously
> over-cautious route and adding a BUILD_BUG_ON(IO_TLB_SHIFT < 11), just so
> we'd get a heads-up in future if this could otherwise become silently
> broken...

I wouldn't bother as we should be ok with smaller IO_TLB_SHIFT. Also, if
CWG is zero, we assume ARCH_DMA_MINALIGN in Linux rather than the
architectural maximum of 2K.

Thanks for reviewing.

-- 
Catalin
