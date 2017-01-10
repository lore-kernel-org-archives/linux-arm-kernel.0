From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jan 2017 14:15:57 +0100
Subject: [PATCH] virtio_mmio: Set DMA masks appropriately
In-Reply-To: <50defbbe87d75db85a9d22f914258975d661208a.1484051089.git.robin.murphy@arm.com>
References: <50defbbe87d75db85a9d22f914258975d661208a.1484051089.git.robin.murphy@arm.com>
Message-ID: <2220292.9CN9cxzsPe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 10, 2017 12:26:01 PM CET Robin Murphy wrote:
> @@ -548,6 +550,14 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>         if (vm_dev->version == 1)
>                 writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
>  
> +       rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +       if (rc)
> +               rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));

You don't seem to do anything different when 64-bit DMA is unsupported.
How do you prevent the use of kernel buffers that are above the first 4G
here?

> +       else if (vm_dev->version == 1)
> +               dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32 + PAGE_SHIFT));

Why is this limitation only for the coherent mask?

	Arnd
