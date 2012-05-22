From: minchan@kernel.org (Minchan Kim)
Date: Tue, 22 May 2012 16:07:45 +0900
Subject: [PATCHv2 3/4] mm: vmalloc: add VM_DMA flag to indicate areas
 used by dma-mapping framework
In-Reply-To: <1337252085-22039-4-git-send-email-m.szyprowski@samsung.com>
References: <1337252085-22039-1-git-send-email-m.szyprowski@samsung.com>
 <1337252085-22039-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4FBB3B41.8010102@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2012 07:54 PM, Marek Szyprowski wrote:

> Add new type of vm_area intented to be used for consisten mappings
> created by dma-mapping framework.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  include/linux/vmalloc.h |    1 +
>  mm/vmalloc.c            |    3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 6071e91..8a9555a 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -14,6 +14,7 @@ struct vm_area_struct;		/* vma defining user mapping in mm_types.h */
>  #define VM_USERMAP	0x00000008	/* suitable for remap_vmalloc_range */
>  #define VM_VPAGES	0x00000010	/* buffer for pages was vmalloc'ed */
>  #define VM_UNLIST	0x00000020	/* vm_struct is not listed in vmlist */
> +#define VM_DMA		0x00000040	/* used by dma-mapping framework */
>  /* bits [20..32] reserved for arch specific ioremap internals */

>  

>  /*
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 8cb7f22..9c13bab 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2582,6 +2582,9 @@ static int s_show(struct seq_file *m, void *p)
>  	if (v->flags & VM_IOREMAP)
>  		seq_printf(m, " ioremap");
>  
> +	if (v->flags & VM_DMA)
> +		seq_printf(m, " dma");
> +


Hmm, VM_DMA would become generic flag?
AFAIU, maybe VM_DMA would be used only on ARM arch.
Of course, it isn't performance sensitive part but there in no reason to check it, either
in other architecture except ARM.

I suggest following as

#ifdef CONFIG_ARM
#define VM_DMA	0x00000040
#else
#define VM_DMA	0x0
#end

Maybe it could remove check code at compile time.

>  	if (v->flags & VM_ALLOC)
>  		seq_printf(m, " vmalloc");
>  



-- 
Kind regards,
Minchan Kim
