From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Sep 2018 16:41:19 +0200
Subject: [PATCH v5 11/12] ARM64: add dma remap for BrcmSTB PCIe
In-Reply-To: <1537367527-20773-12-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-12-git-send-email-jim2101024@gmail.com>
Message-ID: <20180919144119.GB29096@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 10:32:06AM -0400, Jim Quinlan wrote:
> +#if defined(CONFIG_ARM64)

Please use plain #ifdef where possible.

> +dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
> +{
> +	return brcm_phys_to_dma(dev, paddr);
> +}
> +
> +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
> +{
> +	return brcm_dma_to_phys(dev, dev_addr);
> +}
> +#endif

How is this going to work for a kernel with BrcmSTB built in, but running
on a more standard arm64 SOC?

I suspect we really just want a set of ranges hanging off struct device
(conditional on a config option).  Each SoC can then fill it at boot
time, and if it is non-NULL the DMA code will use it instead of
calling __phys_to_dma and __dma_to_phys.  In fact the single range
version could probably just replace the existing dma_pfn_offset
field.
