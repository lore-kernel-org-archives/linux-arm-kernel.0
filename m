From: dyoung@redhat.com (Dave Young)
Date: Sun, 30 Sep 2018 18:10:01 +0800
Subject: [PATCH v15 05/16] kexec_file: kexec_walk_memblock() only walks a
 dedicated region at kdump
In-Reply-To: <20180928064841.14117-6-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-6-takahiro.akashi@linaro.org>
Message-ID: <20180930101001.GE6950@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/18 at 03:48pm, AKASHI Takahiro wrote:
> In kdump case, there exists only one dedicated memblock region as usable
> memory (crashk_res). With this patch, kexec_walk_memblock() runs a given
> callback function on this region.
> 
> Cosmetic change: 0 to MEMBLOCK_NONE at for_each_free_mem_range*()
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>

Acked-by: Dave Young <dyoung@redhat.com>

> ---
>  kernel/kexec_file.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 370d7eab49fe..2f615a7968dd 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -511,8 +511,11 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
>  	phys_addr_t mstart, mend;
>  	struct resource res = { };
>  
> +	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> +		return func(&crashk_res, kbuf);
> +
>  	if (kbuf->top_down) {
> -		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
> +		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, MEMBLOCK_NONE,
>  						&mstart, &mend, NULL) {
>  			/*
>  			 * In memblock, end points to the first byte after the
> @@ -526,8 +529,8 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
>  				break;
>  		}
>  	} else {
> -		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
> -					NULL) {
> +		for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
> +					&mstart, &mend, NULL) {
>  			/*
>  			 * In memblock, end points to the first byte after the
>  			 * range while in kexec, end points to the last byte
> -- 
> 2.19.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave
