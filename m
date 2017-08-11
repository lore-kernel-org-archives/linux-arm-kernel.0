From: hch@lst.de (Christoph Hellwig)
Date: Fri, 11 Aug 2017 20:01:06 +0200
Subject: [PATCH 2/2] of: Restrict DMA configuration
In-Reply-To: <82633e62b64e28dc18bc466319065b92faf2414f.1502468875.git.robin.murphy@arm.com>
References: <0819179085df6c41c70e83a2c5c138b95c0386b3.1502468875.git.robin.murphy@arm.com>
 <82633e62b64e28dc18bc466319065b92faf2414f.1502468875.git.robin.murphy@arm.com>
Message-ID: <20170811180106.GB1921@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 05:29:57PM +0100, Robin Murphy wrote:
> The good news is that DT already gives us the ammunition to do the right
> thing - anything lacking a "dma-ranges" property should be considered
> not to have a mapping of DMA address space from its children to its
> parent, thus anything for which of_dma_get_range() does not succeed does
> not need DMA configuration.

That sounds like a good heuristic.

At least in theory apparently :(

> The bad news is that strictly enforcing that would likely break just
> about every FDT platform out there, since most authors have either not
> considered the property at all or have mistakenly assumed that omitting
> "dma-ranges" is equivalent to including the empty property. Thus we have
> little choice but to special-case platform, AMBA and PCI devices so they
> continue to receive configuration unconditionally as before. At least
> anything new will have to get it right in future...

That still sounds like a useful compromise.

>  	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>  	if (ret < 0) {
> +		/*
> +		 * For legacy reasons, we have to assume some devices need
> +		 * DMA configuration regardless of whether "dma-ranges" is
> +		 * correctly specified or not.
> +		 */
> +		if (!dev_is_pci(dev) &&
> +#ifdef CONFIG_ARM_AMBA
> +		    dev->bus != &amba_bustype &&
> +#endif
> +		    dev->bus != &platform_bus_type)
> +			return ret == -ENODEV ? 0 : ret;
> +

It would be really nice to have dev_is_amba and dev_is_plaform helpers
to reduce the ifdef mess.

But it should be okay even without that cleanup.

> +	if (!size)
> +		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);

I find this way to deal with an overflow really odd, but given that it's
just moved around I'm not going to complain.
