From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 31 May 2013 11:59:15 +0100
Subject: [PATCH RFC 5/6] arm64/xen: implement xen_remap on arm64
In-Reply-To: <1369930713-6063-5-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1305301705500.4799@kaball.uk.xensource.com>
 <1369930713-6063-5-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20130531105915.GC18045@localhost.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 05:18:32PM +0100, Stefano Stabellini wrote:
> --- a/arch/arm/include/asm/xen/page.h
> +++ b/arch/arm/include/asm/xen/page.h
> @@ -90,6 +90,10 @@ static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
>  	return __set_phys_to_machine(pfn, mfn);
>  }
>  
> +#ifdef CONFIG_ARM64
> +#define xen_remap(cookie, size) __ioremap((cookie), (size), __pgprot(PROT_NORMAL))
> +#else
>  #define xen_remap(cookie, size) __arm_ioremap((cookie), (size), MT_MEMORY);
> +#endif

Now I saw the ARM-specific part. Can you not use something like
ioremap_cached() which would give normal cacheable memory (at least on
ARMv7).

>  #endif /* _ASM_ARM_XEN_PAGE_H */
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 2e12258..0e9c9ac 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -228,6 +228,7 @@ extern void __iounmap(volatile void __iomem *addr);
>  #define PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_DIRTY)
>  #define PROT_DEVICE_nGnRE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_ATTRINDX(MT_DEVICE_nGnRE))
>  #define PROT_NORMAL_NC		(PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL_NC))
> +#define PROT_NORMAL		(PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
>  
>  #define ioremap(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
>  #define ioremap_nocache(addr, size)	__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))

Of course we need to add ioremap_cached() for arm64 but until now we
didn't need it.

-- 
Catalin
