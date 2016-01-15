From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 15 Jan 2016 17:08:46 +0000
Subject: [Xen-devel] [PATCH v2 03/16] Xen: xlate: Use page_to_xen_pfn
 instead of page_to_pfn
In-Reply-To: <1452840929-19612-4-git-send-email-zhaoshenglong@huawei.com>
References: <1452840929-19612-1-git-send-email-zhaoshenglong@huawei.com>
 <1452840929-19612-4-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <alpine.DEB.2.02.1601151558010.16178@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Jan 2016, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Use page_to_xen_pfn in case of 64KB page.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  drivers/xen/xlate_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
> index 9692656..b9fcc2c 100644
> --- a/drivers/xen/xlate_mmu.c
> +++ b/drivers/xen/xlate_mmu.c
> @@ -227,7 +227,7 @@ int __init xen_xlate_map_ballooned_pages(xen_pfn_t **gfns, void **virt,
>  		return rc;
>  	}
>  	for (i = 0; i < nr_grant_frames; i++)
> -		pfns[i] = page_to_pfn(pages[i]);
> +		pfns[i] = page_to_xen_pfn(pages[i]);

Shannon, thanks for the patch.

Keeping in mind that in the 64K case, kernel pages are 64K but xen pages
are still 4K, I think you also need to allocate
(nr_grant_frames/XEN_PFN_PER_PAGE) kernel pages (assuming that they are
allocated contiguously): nr_grant_frames refers to 4K pages, while
xen_xlate_map_ballooned_pages is allocating pages on a 64K granularity
(sizeof(pages[0]) == 64K).

Be careful that alloc_xenballooned_pages deals with 64K pages (because
it deals with kernel pages), while xen_pfn_t is always 4K based (because
it deals with Xen pfns).

Please test it with and without CONFIG_ARM64_64K_PAGES. Thanks!



>  	vaddr = vmap(pages, nr_grant_frames, 0, PAGE_KERNEL);
>  	if (!vaddr) {
> -- 
> 2.0.4
> 
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
> 
