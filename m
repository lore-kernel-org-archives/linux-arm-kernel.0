From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 4 Jul 2014 15:42:57 +0200
Subject: [PATCHv4 4/5] arm: use genalloc for the atomic pool
In-Reply-To: <1404324218-4743-5-git-send-email-lauraa@codeaurora.org>
References: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>
 <1404324218-4743-5-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140704134254.GA4142@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 11:03:37AM -0700, Laura Abbott wrote:
[...]
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
[...]
> index f5190ac..02a1939 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -26,6 +26,7 @@
>  #include <linux/io.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sizes.h>
> +#include <linux/genalloc.h>

Includes should be sorted alphabetically. I realize that's not the case
for this particular file, but the downside of that is that your patch no
longer applies cleanly on top of linux-next because some other patch did
add linux/cma.h at the same location.

>  static int __init early_coherent_pool(char *p)
>  {
> -	atomic_pool.size = memparse(p, &p);
> +	atomic_pool_size = memparse(p, &p);
>  	return 0;
>  }
>  early_param("coherent_pool", early_coherent_pool);
>  
> +

There's a gratuituous blank line her.

I also need the below hunk on top of you patch to make this compile on
ARM.

Thierry

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b323032f0850..460aaf965a87 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1250,11 +1250,13 @@ static int __iommu_remove_mapping(struct device *dev, dma_addr_t iova, size_t si
 
 static struct page **__atomic_get_pages(void *addr)
 {
-	struct dma_pool *pool = &atomic_pool;
-	struct page **pages = pool->pages;
-	int offs = (addr - pool->vaddr) >> PAGE_SHIFT;
+	struct page *page;
+	phys_addr_t phys;
+
+	phys = gen_pool_virt_to_phys(atomic_pool, (unsigned long)addr);
+	page = phys_to_page(phys);
 
-	return pages + offs;
+	return (struct page **)page;
 }
 
 static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a2487f12b2fc..764f53565958 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -441,7 +441,6 @@ remove_mapping:
 	dma_common_free_remap(addr, atomic_pool_size, VM_USERMAP);
 destroy_genpool:
 	gen_pool_destroy(atomic_pool);
-	atomic_pool == NULL;
 free_page:
 	if (!dma_release_from_contiguous(NULL, page, nr_pages))
 		__free_pages(page, get_order(atomic_pool_size));
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140704/a3416bd7/attachment.sig>
