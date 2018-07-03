From: james.morse@arm.com (James Morse)
Date: Tue, 3 Jul 2018 17:36:24 +0100
Subject: [PATCH v10 03/14] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
In-Reply-To: <20180623022058.10935-4-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-4-takahiro.akashi@linaro.org>
Message-ID: <8a59db79-6379-550b-b20e-01036626904e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 23/06/18 03:20, AKASHI Takahiro wrote:
> Memblock list is another source for usable system memory layout.
> A merged new arch_kexec_walk_mem() will walk through either io resource
> list or memblock list depending on CONFIG_ARCH_DISCARD_MEMBLOCK so that
> arm64, in addition to powerpc, will be able to utilize this generic
> function for kexec_file.

> diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
> index 0bd23dc789a4..3d4be91786ce 100644
> --- a/arch/powerpc/kernel/machine_kexec_file_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_file_64.c

Does this file still need its memblock.h include?


> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 63c7ce1c0c3e..563acd1c9a61 100644
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
> @@ -501,6 +502,53 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
>  	return locate_mem_hole_bottom_up(start, end, kbuf);
>  }
>  
> +#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK)

The only caller is also guarded by these same ifdefs. Can't we remove this and
rely on the compilers dead-code elimination to remove this function when its not
needed?


> +static int kexec_walk_memblock(struct kexec_buf *kbuf,
> +			       int (*func)(struct resource *, void *))
> +{
> +	u64 i;
> +	phys_addr_t mstart, mend;
> +	struct resource res = { };
> +	int ret = 0;


Keeping this patch as 'just' moving code would avoid having to play
spot-the-difference:

> +	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> +		return func(&crashk_res, kbuf);

This will be new for powerpc, but any attempt to use it should be caught by
arch_kexec_kernel_image_probe(), which has:
|	/* We don't support crash kernels yet. */
|	if (image->type == KEXEC_TYPE_CRASH)
|		return -EOPNOTSUPP;


Looks good to me! For what its worth:
Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
