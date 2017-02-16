From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2017 16:12:55 -0000
Subject: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
In-Reply-To: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
Message-ID: <2103911.qf9H68dkRp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 29, 2016 11:45:03 PM CET Nikita Yushchenko wrote:
> 
>  static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
>  {
> +#ifdef CONFIG_PCI
> +       if (dev_is_pci(hwdev)) {
> +               struct pci_dev *pdev = to_pci_dev(hwdev);
> +               struct pci_host_bridge *br = pci_find_host_bridge(pdev->bus);
> +
> +               if (br->dev.dma_mask && (*br->dev.dma_mask) &&
> +                               (mask & (*br->dev.dma_mask)) != mask)
> +                       return 0;
> +       }
> +#endif
>         if (swiotlb)
>                 return swiotlb_dma_supported(hwdev, mask);
>         return 1;
> 

I think it's wrong to make this a special case for PCI.

Instead, we should follow the dma-ranges properties during dma_set_mask()
to ensure we don't set a mask that any of the parents up to the root
cannot support.

	Arnd
