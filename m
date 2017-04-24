From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Apr 2017 16:51:25 +0100
Subject: [PATCH] arm64: fix the overlap between the kernel image and
 vmalloc address
In-Reply-To: <58FDFD90.8050300@huawei.com>
References: <1493025729-21505-1-git-send-email-zhongjiang@huawei.com>
 <20170424104456.GA4343@leverpostej> <58FDFD90.8050300@huawei.com>
Message-ID: <20170424155125.GA5972@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 09:28:48PM +0800, zhong jiang wrote:
> On 2017/4/24 18:44, Mark Rutland wrote:
> > So the issue is that we have the callchain below for a kernel image
> > address:
> >
> > read_kcore()
> > ->is_vmalloc_or_module_addr() // returns true
> > ->vread()
> > -->aligned_vread()
> > --->vmalloc_to_page()
> >
> > In is_vmalloc{,or_module}_addr() we just check the addr against
> > VMALLOC_START and VMALLOC_END, so they will return true for a kernel
> > image address.
> >
> > Then, we call vmalloc_to_page(). While this only handles mappings made
> > at page granularity, the kernel image mapping may have used sections. So
> > this tries a bogus walk to the pte level.

> > Should we special-case kernel image handling, e.g. with new
> > is_kernel_image_addr() / kernel_image_to_page() helpers?

>   yes ,  it seems to the best way to implents it  without performance back.

> The following patch is the implment. Any thought?
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> 
>   diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b84615b..851ac35 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -475,6 +475,15 @@ static inline bool is_vmalloc_addr(const void *x)
>         return false;
>  #endif
>  }
> +
> +static inline bool is_kernel_image_addr(const void *x)
> +{
> +       unsigned long addr = (unsigned long)x;
> +
> +       return addr >= (unsigned long)_stext && addr < (unsigned long)_end;
> +
> +}
> +
>  #ifdef CONFIG_MMU
>  extern int is_vmalloc_or_module_addr(const void *x);
>  #else
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 3ca82d4..9a9ef65 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -229,6 +229,42 @@ int is_vmalloc_or_module_addr(const void *x)
>         return is_vmalloc_addr(x);
>  }
> 
> +static struct page *kernel_image_to_page(const void *kernel_addr, pgd_t *pgd)
> +{
> +       unsigned long addr = (unsigned long)kernel_addr;
> +       struct page *page = NULL;
> +       pud_t *pud;
> +       pmd_t *pmd;
> +       pte_t *pte;
> +
> +       if (pgd_none(*pgd))
> +               goto out;
> +
> +       pud = pud_offset(pgd, addr);
> +       if (pud_none(*pud))
> +               goto out;
> +
> +       if (pud_sect(*pud))
> +               return pud_page(*pud);

The *_sect() helpers are arch-specific, so we cannot use them in generic
code. This would need to be architecture-specific.

Secondly, this will return head page of the section regardless of which
page in the section the address corresponds to

> +
> +       pmd = pmd_offset(*pmd, addr);
> +       if (pmd_none(*pmd))
> +               goto out;
> +
> +       if (pmd_sect(*pmd))
> +               return pmd_page(*pmd);

Likewise on both counts.

> +
> +       pte = pte_offset_kernel(pmd, addr);
> +       if (pte_none(*pte))
> +               goto out;
> +
> +       page = pte_page(*pte);
> +
> +out:
> +       return page;
> +
> +}

Given we know what the address should map to, I don't think we need to
walk the page tables here. I think this can be:

static struct page *kernel_image_to_page(const void *addr)
{
	return virt_to_page(lm_alias(vmalloc_addr));
}

> +
>  /*
>    * Walk a vmap address to the struct page it maps.
>    */
> @@ -244,6 +280,9 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
>          */
>         VIRTUAL_BUG_ON(!is_vmalloc_or_module_addr(vmalloc_addr));
> 
> +       if (is_kernel_image_addr(vmalloc_addr))
> +               return kernel_image_to_page(vmalloc_addr, pgd);

It's not clear to me that this is the right place for this to live.

It might be best to code the kernel image logic directly in kcore (and
kmem), assuming everyone's OK with that approach.

Thanks,
Mark.
