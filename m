From: yalin.wang2010@gmail.com (yalin wang)
Date: Mon, 12 Oct 2015 14:00:38 +0800
Subject: [PATCH] ARM:mm: fix kmap_atomic_to_page
In-Reply-To: <1444129773-12632-1-git-send-email-chanho.min@lge.com>
References: <1444129773-12632-1-git-send-email-chanho.min@lge.com>
Message-ID: <3B252F19-0EE2-4CE3-81B5-E8BED7212A2D@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Oct 6, 2015, at 19:09, Chanho Min <chanho.min@lge.com> wrote:
> 
> Since kmap_atomic returns the pkmap address without a new mapping to
> fixmap for the page that is already mapped by kmap, It should be
> considered for the pkmap address in kmap_atomic_to_page.
> 
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> ---
> arch/arm/mm/highmem.c |   11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
> index 45aeaac..3e973b7 100644-
> --- a/arch/arm/mm/highmem.c
> +++ b/arch/arm/mm/highmem.c
> @@ -145,8 +145,13 @@ struct page *kmap_atomic_to_page(const void *ptr)
> {
> 	unsigned long vaddr = (unsigned long)ptr;
> 
> -	if (vaddr < FIXADDR_START)
> -		return virt_to_page(ptr);
> +	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP)) {
> +		int i = PKMAP_NR(vaddr);
> +		return pte_page(pkmap_page_table[i]);
> +	}
> +
> +	if (vaddr >= FIXADDR_START)
> +		return pte_page(get_fixmap_pte(vaddr));
> 
> -	return pte_page(get_fixmap_pte(vaddr));
> +	return virt_to_page(ptr);
> }
> -- 
> 1.7.9.5
> 
why not change like this,
more simple :

diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index 9df5f09..4eeed3d 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -152,8 +152,7 @@ struct page *kmap_atomic_to_page(const void *ptr)
 {
        unsigned long vaddr = (unsigned long)ptr;
 
-       if (vaddr < FIXADDR_START)
-               return virt_to_page(ptr);
-
-       return pte_page(get_fixmap_pte(vaddr));
+       if (vaddr >= FIXADDR_START && vaddr <= FIXADDR_TOP)
+               return pte_page(get_fixmap_pte(vaddr));
+       return kmap_to_page(ptr);
 }



Thanks
