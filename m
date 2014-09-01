From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Sep 2014 16:53:34 +0200
Subject: [RFC PATCH 5/7] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <1409327670-3495-6-git-send-email-will.deacon@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <1409327670-3495-6-git-send-email-will.deacon@arm.com>
Message-ID: <24828990.FUj2gbXJJY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 August 2014 16:54:28 Will Deacon wrote:
>  static void of_dma_configure(struct platform_device *pdev)
>  {
> -       u64 dma_addr, paddr, size;
> +       u64 dma_addr, paddr, size, mask;
>         int ret;
> -       bool coherent;
> +       bool coherent, iommu;
>         unsigned long offset;
>         struct device *dev = &pdev->dev;
>  
> +       /*
> +        * Set default dma-mask to 32 bit. Drivers are expected to setup
> +        * the correct supported dma_mask.
> +        */
> +       mask = DMA_BIT_MASK(32);
> +
>         ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
> -       offset = ret < 0 ? 0 : PFN_DOWN(paddr - dma_addr);
> -       dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
> +       if (ret < 0) {
> +               dma_addr = offset = 0;
> +               size = mask;
> +       } else {
> +               offset = PFN_DOWN(paddr - dma_addr);
> +               dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
> +       }
>  
>         coherent = of_dma_is_coherent(dev->of_node);
>         dev_dbg(dev, "device is%sdma coherent\n",
>                 coherent ? " " : " not ");
>  
> -       /*
> -        * Set default dma-mask to 32 bit. Drivers are expected to setup
> -        * the correct supported dma_mask.
> -        */
> -       arch_setup_dma_ops(dev, DMA_BIT_MASK(32), offset, coherent);
> +       iommu = !of_iommu_configure(dev);
> +       dev_dbg(dev, "device is%sbehind an iommu\n",
> +               iommu ? " " : " not ");
> +
> +       arch_setup_dma_ops(dev, mask, dma_addr, size, offset, coherent, iommu);
>  }

Hmm, I was actually expecting of_iommu_configure() to be called from inside
arch_setup_dma_ops(), leaving the choice for how it's set up to the
architecture for now. It's probably not a big difference either way.

	Arnd
