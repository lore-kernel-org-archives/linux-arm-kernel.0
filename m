From: julien.grall@arm.com (Julien Grall)
Date: Tue, 29 Mar 2016 17:28:56 +0100
Subject: [PATCH v7 03/17] Xen: xlate: Use page_to_xen_pfn instead of
 page_to_pfn
In-Reply-To: <1458830676-27075-4-git-send-email-shannon.zhao@linaro.org>
References: <1458830676-27075-1-git-send-email-shannon.zhao@linaro.org>
 <1458830676-27075-4-git-send-email-shannon.zhao@linaro.org>
Message-ID: <56FAAD48.2010401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 24/03/16 14:44, Shannon Zhao wrote:
> Make xen_xlate_map_ballooned_pages work with 64K pages. In that case
> Kernel pages are 64K in size but Xen pages remain 4K in size. Xen pfns
> refer to 4K pages.
>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> ---
>   drivers/xen/xlate_mmu.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
> index 9692656..28f728b 100644
> --- a/drivers/xen/xlate_mmu.c
> +++ b/drivers/xen/xlate_mmu.c
> @@ -207,9 +207,12 @@ int __init xen_xlate_map_ballooned_pages(xen_pfn_t **gfns, void **virt,
>   	void *vaddr;
>   	int rc;
>   	unsigned int i;
> +	unsigned long nr_pages;
> +	xen_pfn_t xen_pfn = 0;
>
>   	BUG_ON(nr_grant_frames == 0);
> -	pages = kcalloc(nr_grant_frames, sizeof(pages[0]), GFP_KERNEL);
> +	nr_pages = DIV_ROUND_UP(nr_grant_frames, XEN_PFN_PER_PAGE);
> +	pages = kcalloc(nr_pages, sizeof(pages[0]), GFP_KERNEL);
>   	if (!pages)
>   		return -ENOMEM;
>
> @@ -218,22 +221,25 @@ int __init xen_xlate_map_ballooned_pages(xen_pfn_t **gfns, void **virt,
>   		kfree(pages);
>   		return -ENOMEM;
>   	}
> -	rc = alloc_xenballooned_pages(nr_grant_frames, pages);
> +	rc = alloc_xenballooned_pages(nr_pages, pages);
>   	if (rc) {
> -		pr_warn("%s Couldn't balloon alloc %ld pfns rc:%d\n", __func__,
> -			nr_grant_frames, rc);
> +		pr_warn("%s Couldn't balloon alloc %ld pages rc:%d\n", __func__,
> +			nr_pages, rc);
>   		kfree(pages);
>   		kfree(pfns);
>   		return rc;
>   	}
> -	for (i = 0; i < nr_grant_frames; i++)
> -		pfns[i] = page_to_pfn(pages[i]);
> +	for (i = 0; i < nr_grant_frames; i++) {
> +		if ((i % XEN_PFN_PER_PAGE) == 0)
> +			xen_pfn = page_to_xen_pfn(pages[i / XEN_PFN_PER_PAGE]);
> +		pfns[i] = pfn_to_gfn(xen_pfn++);
> +	}

Would it be possible to re-use xen_for_each_gfn? This will avoid 
open-coding the loop to break down the Linux page.

Regards,

-- 
Julien Grall
