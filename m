From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Jul 2014 12:00:34 +0100
Subject: [PATCH 3/3] arm64: Use include/asm-generic/io.h
In-Reply-To: <1404918699-17284-3-git-send-email-thierry.reding@gmail.com>
References: <1404918699-17284-1-git-send-email-thierry.reding@gmail.com>
 <1404918699-17284-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140710110034.GI16137@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 04:11:39PM +0100, Thierry Reding wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a497556520d4..a428ac1573e7 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -20,7 +20,6 @@ config ARM64
>  	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>  	select GENERIC_CPU_AUTOPROBE
>  	select GENERIC_EARLY_IOREMAP
> -	select GENERIC_IOMAP
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_SCHED_CLOCK
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index e0ecdcf6632d..00c7f9faf2a3 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
[...]
> @@ -235,8 +155,7 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
>  #define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
>  #define iounmap				__iounmap
>  
> -#define ARCH_HAS_IOREMAP_WC
> -#include <asm-generic/iomap.h>
> +#include <asm-generic/io.h>

We don't currently have PCIe support in mainline for arm64 but what I
had in mind with the generic iomap is that functions like ioread32_rep
first check whether the address is an IO address or a memory one and
calls the insl or mmio_insl accordingly. With your generic
implementation, this check disappears.

The question is whether this functionality would still be needed.

-- 
Catalin
