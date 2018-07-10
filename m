From: hch@lst.de (Christoph Hellwig)
Date: Tue, 10 Jul 2018 20:04:33 +0200
Subject: [RFC PATCH 1/4] dma-mapping: Generalise dma_32bit_limit flag
In-Reply-To: <a85a5fe22fced65b2960251fc6e8d8f1e68f828a.1531239284.git.robin.murphy@arm.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
 <a85a5fe22fced65b2960251fc6e8d8f1e68f828a.1531239284.git.robin.murphy@arm.com>
Message-ID: <20180710180433.GB26285@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 06:17:16PM +0100, Robin Murphy wrote:
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 8be8106270c2..95e185347e34 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -183,7 +183,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
>  	 * Various PCI/PCIe bridges have broken support for > 32bit DMA even
>  	 * if the device itself might support it.
>  	 */
> -	if (dev->dma_32bit_limit && mask > DMA_BIT_MASK(32))
> +	if (dev->bus_dma_mask && mask > dev->bus_dma_mask)
>  		return 0;

The comment above this check needs an updated (or just be removed).

Also we still have a few architectures not using dma-direct. I guess
most were doing fine without such limits anyway, but at least arm
will probably need an equivalent check.
