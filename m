From: dyoung@redhat.com (Dave Young)
Date: Wed, 25 Jul 2018 20:31:29 +0800
Subject: [PATCH v12 04/16] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
In-Reply-To: <20180724065759.19186-5-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-5-takahiro.akashi@linaro.org>
Message-ID: <20180725123129.GA2361@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/18 at 03:57pm, AKASHI Takahiro wrote:
> Memblock list is another source for usable system memory layout.
> So move powerpc's arch_kexec_walk_mem() to common code so that other
> memblock-based architectures, particularly arm64, can also utilise it.
> A moved function is now renamed to kexec_walk_memblock() and integrated
> into kexec_locate_mem_hole(), which will now be usable for all
> architectures with no need for overriding arch_kexec_walk_mem().
> 
> kexec_walk_memblock() will not work for kdump in this form, this will be
> fixed in the next patch.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Acked-by: James Morse <james.morse@arm.com>
> ---
>  arch/powerpc/kernel/machine_kexec_file_64.c | 54 -------------------
>  include/linux/kexec.h                       |  2 -
>  kernel/kexec_file.c                         | 58 ++++++++++++++++++++-
>  3 files changed, 56 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
> index 0bd23dc789a4..5357b09902c5 100644
> --- a/arch/powerpc/kernel/machine_kexec_file_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_file_64.c
> @@ -24,7 +24,6 @@
>  
>  #include <linux/slab.h>
>  #include <linux/kexec.h>
> -#include <linux/memblock.h>
>  #include <linux/of_fdt.h>
>  #include <linux/libfdt.h>
>  #include <asm/ima.h>
> @@ -46,59 +45,6 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>  	return kexec_image_probe_default(image, buf, buf_len);
>  }
>  
> -/**
> - * arch_kexec_walk_mem - call func(data) for each unreserved memory block
> - * @kbuf:	Context info for the search. Also passed to @func.
> - * @func:	Function to call for each memory block.
> - *
> - * This function is used by kexec_add_buffer and kexec_locate_mem_hole
> - * to find unreserved memory to load kexec segments into.
> - *
> - * Return: The memory walk will stop when func returns a non-zero value
> - * and that value will be returned. If all free regions are visited without
> - * func returning non-zero, then zero will be returned.
> - */
> -int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> -			int (*func)(struct resource *, void *))
> -{
> -	int ret = 0;
> -	u64 i;
> -	phys_addr_t mstart, mend;
> -	struct resource res = { };
> -
> -	if (kbuf->top_down) {
> -		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
> -						&mstart, &mend, NULL) {
> -			/*
> -			 * In memblock, end points to the first byte after the
> -			 * range while in kexec, end points to the last byte
> -			 * in the range.
> -			 */
> -			res.start = mstart;
> -			res.end = mend - 1;
> -			ret = func(&res, kbuf);
> -			if (ret)
> -				break;
> -		}
> -	} else {
> -		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
> -					NULL) {
> -			/*
> -			 * In memblock, end points to the first byte after the
> -			 * range while in kexec, end points to the last byte
> -			 * in the range.
> -			 */
> -			res.start = mstart;
> -			res.end = mend - 1;
> -			ret = func(&res, kbuf);
> -			if (ret)
> -				break;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
>  /**
>   * setup_purgatory - initialize the purgatory's global variables
>   * @image:		kexec image.
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 49ab758f4d91..c196bfd11bee 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -184,8 +184,6 @@ int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
>  					const Elf_Shdr *relsec,
>  					const Elf_Shdr *symtab);
>  
> -int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> -			       int (*func)(struct resource *, void *));
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>  int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index bf39df5e5bb9..2f0691b0f8ad 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -16,6 +16,7 @@
>  #include <linux/file.h>
>  #include <linux/slab.h>
>  #include <linux/kexec.h>
> +#include <linux/memblock.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
>  #include <linux/fs.h>
> @@ -501,6 +502,55 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
>  	return locate_mem_hole_bottom_up(start, end, kbuf);
>  }
>  
> +#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK)
> +static int kexec_walk_memblock(struct kexec_buf *kbuf,
> +			       int (*func)(struct resource *, void *))
> +{
> +	int ret = 0;
> +	u64 i;
> +	phys_addr_t mstart, mend;
> +	struct resource res = { };
> +
> +	if (kbuf->top_down) {
> +		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
> +						&mstart, &mend, NULL) {
> +			/*
> +			 * In memblock, end points to the first byte after the
> +			 * range while in kexec, end points to the last byte
> +			 * in the range.
> +			 */
> +			res.start = mstart;
> +			res.end = mend - 1;
> +			ret = func(&res, kbuf);
> +			if (ret)
> +				break;
> +		}
> +	} else {
> +		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
> +					NULL) {
> +			/*
> +			 * In memblock, end points to the first byte after the
> +			 * range while in kexec, end points to the last byte
> +			 * in the range.
> +			 */
> +			res.start = mstart;
> +			res.end = mend - 1;
> +			ret = func(&res, kbuf);
> +			if (ret)
> +				break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +#else
> +static int kexec_walk_memblock(struct kexec_buf *kbuf,
> +			       int (*func)(struct resource *, void *))
> +{
> +	return 0;
> +}
> +#endif
> +
>  /**
>   * arch_kexec_walk_mem - call func(data) on free memory regions
>   * @kbuf:	Context info for the search. Also passed to @func.
> @@ -510,7 +560,7 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
>   * and that value will be returned. If all free regions are visited without
>   * func returning non-zero, then zero will be returned.
>   */
> -int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> +static int arch_kexec_walk_mem(struct kexec_buf *kbuf,
>  			       int (*func)(struct resource *, void *))
>  {
>  	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> @@ -538,7 +588,11 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>  	if (kbuf->mem)
>  		return 0;
>  
> -	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
> +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
> +		ret = kexec_walk_memblock(kbuf, locate_mem_hole_callback);
> +	else
> +		ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);

AKASHI, since it is not weak function now, it would be better to rename
the function for example name it as kexec_walk_resource()

Other than this,

Acked-by: Dave Young <dyoung@redhat.com>

>  
>  	return ret == 1 ? 0 : -EADDRNOTAVAIL;
>  }
> -- 
> 2.18.0
> 

Thanks
Dave
