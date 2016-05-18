From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 12:52:28 +0200
Subject: [PATCH] arm64: Allow for different DMA and CPU bus offsets
In-Reply-To: <1463563981-69722-1-git-send-email-agraf@suse.de>
References: <1463563981-69722-1-git-send-email-agraf@suse.de>
Message-ID: <12218676.p29ELivsix@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 May 2016 11:33:01 Alexander Graf wrote:
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index ba437f0..67bf8e1 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -66,12 +66,16 @@ static inline bool is_device_dma_coherent(struct device *dev)
>  
>  static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
> -       return (dma_addr_t)paddr;
> +       dma_addr_t dev_addr = (dma_addr_t)paddr;
> +
> +       return dev_addr - (dma_addr_t)__pfn_to_phys(dev->dma_pfn_offset);
>  }
>  
>  static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
>  {
> -       return (phys_addr_t)dev_addr;
> +       phys_addr_t paddr = (phys_addr_t)dev_addr;
> +
> +       return paddr + __pfn_to_phys(dev->dma_pfn_offset);
>  }
>  

The patch looks ok overall, but I think it's better to use an open-coded
shift instead of __pfn_to_phys/__pfn_to_phys here: those helpers convert
between actual page frame numbers and addresses, which may not always
be a 1:1 relationship, e.g. if someone wants to work around the crazy
"Principles of ARM Memory Maps White Paper" layout.

	Arnd
