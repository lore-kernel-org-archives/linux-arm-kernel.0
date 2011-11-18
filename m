From: dsaxena@plexity.net (Deepak Saxena)
Date: Thu, 17 Nov 2011 16:03:20 -0800
Subject: [PATCH 11/23] ARM: mach-ixp23xx: remove arch specific special
 handling for ioremap
In-Reply-To: <1321422521-1138-12-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
 <1321422521-1138-12-git-send-email-nico@fluxnic.net>
Message-ID: <20111118000320.GA16897@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 16 2011, at 00:48, Nicolas Pitre was caught saying:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> A generic version should replace this later.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Looks good to me, specially in sync with the generic ioremap().
I don't have HW to test anymore, Lennert, can you test this
series on the IXP?

Reviewed-by: Deepak Saxena <dsaxena@linaro.org>

> ---
>  arch/arm/mach-ixp23xx/include/mach/io.h |   29 -----------------------------
>  1 files changed, 0 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/mach-ixp23xx/include/mach/io.h b/arch/arm/mach-ixp23xx/include/mach/io.h
> index a1749d0fd8..4ce4353b9f 100644
> --- a/arch/arm/mach-ixp23xx/include/mach/io.h
> +++ b/arch/arm/mach-ixp23xx/include/mach/io.h
> @@ -20,33 +20,4 @@
>  #define __io(p)		((void __iomem*)((p) + IXP23XX_PCI_IO_VIRT))
>  #define __mem_pci(a)	(a)
>  
> -static inline void __iomem *
> -ixp23xx_ioremap(unsigned long addr, unsigned long size, unsigned int mtype)
> -{
> -	if (addr >= IXP23XX_PCI_MEM_START &&
> -		addr <= IXP23XX_PCI_MEM_START + IXP23XX_PCI_MEM_SIZE) {
> -		if (addr + size > IXP23XX_PCI_MEM_START + IXP23XX_PCI_MEM_SIZE)
> -			return NULL;
> -
> -		return (void __iomem *)
> - 			((addr - IXP23XX_PCI_MEM_START) + IXP23XX_PCI_MEM_VIRT);
> -	}
> -
> -	return __arm_ioremap(addr, size, mtype);
> -}
> -
> -static inline void
> -ixp23xx_iounmap(void __iomem *addr)
> -{
> -	if ((((u32)addr) >= IXP23XX_PCI_MEM_VIRT) &&
> -	    (((u32)addr) < IXP23XX_PCI_MEM_VIRT + IXP23XX_PCI_MEM_SIZE))
> -		return;
> -
> -	__iounmap(addr);
> -}
> -
> -#define __arch_ioremap	ixp23xx_ioremap
> -#define __arch_iounmap	ixp23xx_iounmap
> -
> -
>  #endif
> -- 
> 1.7.7.1.431.g10b2a
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
"People think all we need to fix our predicament is a free source of
energy, but I think we need to change out behaviour. More energy would
just deplete the Earth's lifeblood faster." - Janine Benyius
