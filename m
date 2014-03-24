From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Mon, 24 Mar 2014 14:50:00 +0100
Subject: [PATCH 2/3] IXP4xx: Fix DMA masks.
In-Reply-To: <m37g7liwdb.fsf@intrepid.localdomain>
References: <m3siq9iyt2.fsf@intrepid.localdomain>
 <m37g7liwdb.fsf@intrepid.localdomain>
Message-ID: <20140324145000.4098c8c7@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 23 Mar 2014 01:36:48 +0100
Krzysztof Halasa <khc@pm.waw.pl> wrote:

> Now, devices will have 32-bit default DMA masks (0xFFFFFFFF) as per DMA API.
> 
> Fixes:
> $ ifconfig eth0 up
>
> Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>

Tested-by: Simon Kagstrom <simon.kagstrom@netinsight.net>

> +#ifdef CONFIG_PCI
> +static int ixp4xx_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
> +{
> +	return (dma_addr + size) > SZ_64M;
> +}
> +
> +static int ixp4xx_platform_notify_remove(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		dmabounce_unregister_dev(dev);
> +
> +	return 0;
> +}
> +#endif
> +
> +/*
> + * Setup DMA mask to 64MB on PCI devices and 4 GB on all other things.
> + */
> +static int ixp4xx_platform_notify(struct device *dev)
> +{
> +	dev->dma_mask = &dev->coherent_dma_mask;
> +
> +#ifdef CONFIG_PCI
> +	if (dev_is_pci(dev)) {
> +		dev->coherent_dma_mask = DMA_BIT_MASK(28); /* 64 MB */
> +		dmabounce_register_dev(dev, 2048, 4096, ixp4xx_needs_bounce);
> +		return 0;
> +	}
> +#endif

I would simply remove the #ifdef CONFIG_PCI statements: dev_is_pci(dev)
should return false at compile time if CONFIG_PCI is not set, and then
I'd trust the compiler to simply remove all dead code.

// Simon
