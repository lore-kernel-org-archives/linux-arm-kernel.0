From: adharmap@codeaurora.org (adharmap at codeaurora.org)
Date: Fri, 23 Oct 2009 14:48:31 -0700 (PDT)
Subject: [PATCH] Use Normal uncached memory rather than Strongly
	Ordered on ARMv6+
In-Reply-To: <20091023213307.GB29639@n2100.arm.linux.org.uk>
References: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
	<20091023100639.GA19437@n2100.arm.linux.org.uk>
	<1256293374.6564.27.camel@pc1117.cambridge.arm.com>
	<20091023103420.GC19437@n2100.arm.linux.org.uk>
	<1256295591.6564.42.camel@pc1117.cambridge.arm.com>
	<20091023113001.GA22853@n2100.arm.linux.org.uk>
	<1256299512.6564.74.camel@pc1117.cambridge.arm.com>
	<20091023123600.GB22853@n2100.arm.linux.org.uk>
	<1256316861.6564.154.camel@pc1117.cambridge.arm.com>
	<20091023171227.GA29639@n2100.arm.linux.org.uk>
	<20091023213307.GB29639@n2100.arm.linux.org.uk>
Message-ID: <bc95b89e28b2adb81ad3861017647e1e.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


In addition we would need to change mb() rmb() wmb() to expand to dmb() for
arch = v7


Abhijeet Dharmapurikar

> On Fri, Oct 23, 2009 at 06:12:27PM +0100, Russell King - ARM Linux wrote:
>> As far as I'm concerned, we've spent far too long discussing this issue
>> -
>> there's nothing really to discuss.  We need dma_alloc_coherent() to use
>> its own page protection modifier, which causes it to behave the same as
>> dma_alloc_writecombine() on ARMv7, and with the existing behaviour (for
>> the time being) on ARMv6 and below.  We should leave pgprot_noncached()
>> well alone until we know that its other places need to be changed.
>
> And here is the patch which does this.  Note that it also ensures that
> NX is set for these pages on both ARMv6 and later.
>
> diff --git a/arch/arm/include/asm/pgtable.h
> b/arch/arm/include/asm/pgtable.h
> index 201ccaa..1139768 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -304,13 +304,23 @@ PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
>
>  static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
>
> +#define __pgprot_modify(prot,mask,bits)		\
> +	__pgprot((pgprot_val(prot) & ~(mask)) | (bits))
> +
>  /*
>   * Mark the prot value as uncacheable and unbufferable.
>   */
>  #define pgprot_noncached(prot) \
> -	__pgprot((pgprot_val(prot) & ~L_PTE_MT_MASK) | L_PTE_MT_UNCACHED)
> +	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_UNCACHED)
>  #define pgprot_writecombine(prot) \
> -	__pgprot((pgprot_val(prot) & ~L_PTE_MT_MASK) | L_PTE_MT_BUFFERABLE)
> +	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_BUFFERABLE)
> +#if __LINUX_ARM_ARCH__ >= 7
> +#define pgprot_dmacoherent(prot) \
> +	__pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_BUFFERABLE)
> +#else
> +#define pgprot_dmacoherent(prot) \
> +	__pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_UNCACHED)
> +#endif
>
>  #define pmd_none(pmd)		(!pmd_val(pmd))
>  #define pmd_present(pmd)	(pmd_val(pmd))
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index b30925f..7a976bb 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -328,7 +328,7 @@ dma_alloc_coherent(struct device *dev, size_t size,
> dma_addr_t *handle, gfp_t gf
>  	}
>
>  	return __dma_alloc(dev, size, handle, gfp,
> -			   pgprot_noncached(pgprot_kernel));
> +			   pgprot_dmacoherent(pgprot_kernel));
>  }
>  EXPORT_SYMBOL(dma_alloc_coherent);
>
> @@ -379,7 +379,7 @@ static int dma_mmap(struct device *dev, struct
> vm_area_struct *vma,
>  int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
>  		      void *cpu_addr, dma_addr_t dma_addr, size_t size)
>  {
> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	vma->vm_page_prot = pgprot_dmacoherent(vma->vm_page_prot);
>  	return dma_mmap(dev, vma, cpu_addr, dma_addr, size);
>  }
>  EXPORT_SYMBOL(dma_mmap_coherent);
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
