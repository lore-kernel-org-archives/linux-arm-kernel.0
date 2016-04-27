From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Apr 2016 16:11:17 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <20160427135859.GC20646@e104818-lin.cambridge.arm.com>
References: <1461612094-30939-1-git-send-email-grygorii.strashko@ti.com>
 <878tzzpq19.fsf@intel.com>
 <20160427135859.GC20646@e104818-lin.cambridge.arm.com>
Message-ID: <9452408.uEOOA4q1YW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2016 14:59:00 Catalin Marinas wrote:
> 
> I would be in favour of a dma_inherit() function as well. We could hack
> something up in the arch code (like below) but I would rather prefer an
> explicit dma_inherit() call by drivers creating such devices.
> 
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index ba437f090a74..ea6fb9b0e8fa 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -29,8 +29,11 @@ extern struct dma_map_ops dummy_dma_ops;
>  
>  static inline struct dma_map_ops *__generic_dma_ops(struct device *dev)
>  {
> -       if (dev && dev->archdata.dma_ops)
> -               return dev->archdata.dma_ops;
> +       while (dev) {
> +               if (dev->archdata.dma_ops)
> +                       return dev->archdata.dma_ops;
> +               dev = dev->parent;
> +       }

I think this would be a very bad idea: we don't want to have random
devices be able to perform DMA just because their parent devices
have been set up that way.

	Arnd
