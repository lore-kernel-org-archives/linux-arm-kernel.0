From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Jun 2016 18:20:06 +0100
Subject: [PATCH 06/32] arm64: Fix physical to DMA mappings.
In-Reply-To: <1464817421-8519-7-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-7-git-send-email-kraxel@redhat.com>
Message-ID: <20160602172006.GF24938@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 11:43:15PM +0200, Gerd Hoffmann wrote:
> From: mzoran <mzoran@crowfest.net>
> 
> Gets USB and networking to work on Raspberry Pi 3 in 64 bit.
> 
> created by mzoran at crowfest.net
> 
> [ kraxel: some cleanups ]
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  arch/arm64/include/asm/dma-mapping.h | 73 ++++++++++++++++++++++++++++++++++--
>  arch/arm64/include/asm/memory.h      |  8 ++++

We had a similar patch already here:

http://article.gmane.org/gmane.linux.ports.arm.kernel/500565

Maybe you need some alignment with other contributing RPi3 patches.

> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 72a3025..ab4c65e 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -226,6 +226,14 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #endif
>  #endif
>  
> +#ifndef __virt_to_bus
> +#define __virt_to_bus	__virt_to_phys
> +#define __bus_to_virt	__phys_to_virt
> +#define __pfn_to_bus(x)	__pfn_to_phys(x)
> +#define __bus_to_pfn(x)	__phys_to_pfn(x)
> +#endif

Do you really need these macros? What's with the #ifndef, anything going
to override them?

-- 
Catalin
