From: labbott@redhat.com (Laura Abbott)
Date: Fri, 15 Jan 2016 15:03:42 -0800
Subject: [PATCH] staging: ion: make the pte default none PTE_RDONLY
In-Reply-To: <1452825753-36364-1-git-send-email-puck.chen@hisilicon.com>
References: <1452825753-36364-1-git-send-email-puck.chen@hisilicon.com>
Message-ID: <56997ACE.80604@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(adding linux-arm and a few people)

On 01/14/2016 06:42 PM, Chen Feng wrote:
> The page is already alloc at ion_alloc function,
> ion_mmap map the alloced pages to user-space.
>
> The default prot can be PTE_RDONLY. Take a look at
> here:
> set_pte_at()
> arch/arm64/include/asm:
> 		if (pte_dirty(pte) && pte_write(pte))
> 			pte_val(pte) &= ~PTE_RDONLY;
> 		else
> 			pte_val(pte) |= PTE_RDONLY;
>
> So with the dirty bit,it can improve the efficiency
> and donnot need to handle memory fault when use access.
>
> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
> Signed-off-by: Wei Dong <weidong2@hisilicon.com>
> Reviewed-by: Zhuangluan Su <suzhuangluan@hisilicon.com>
> ---
>   drivers/staging/android/ion/ion.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index e237e9f..dba5942 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -1026,6 +1026,9 @@ static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
>   	if (!(buffer->flags & ION_FLAG_CACHED))
>   		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
>
> +	/*Default writeable*/
> +	vma->vm_page_prot = pte_mkdirty(vma->vm_page_prot);
> +
>   	mutex_lock(&buffer->lock);
>   	/* now map it to userspace */
>   	ret = buffer->heap->ops->map_user(buffer->heap, buffer, vma);
>

The extra fault is unfortunate but I'm skeptical about just setting
pte_mkdirty.

Catalin/Will, do you have any thoughts? Right now it seems like any
range mapped with remap_pfn_range will have this extra fault
behavior. Is marking the range dirty the best solution?

Thanks,
Laura
