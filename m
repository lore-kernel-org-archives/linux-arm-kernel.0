From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 5 Sep 2016 10:52:39 +0100
Subject: [PATCH] arm64: mm: drop fixup_init() and mm.h
In-Reply-To: <1473067775-26284-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1473067775-26284-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160905095239.GA6826@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 05:29:35PM +0800, Kefeng Wang wrote:
> There is only fixup_init() in mm.h , and it is only called
> in free_initmem(), so move the codes from fixup_init() into
> free_initmem(), then drop fixup_init() and mm.h.

[...]

> +++ b/arch/arm64/mm/init.c
> @@ -47,8 +47,6 @@
>  #include <asm/tlb.h>
>  #include <asm/alternative.h>
>  
> -#include "mm.h"
> -
>  /*
>   * We need to be able to catch inadvertent references to memstart_addr
>   * that occur (potentially in generic code) before arm64_memblock_init()
> @@ -485,7 +483,12 @@ void free_initmem(void)
>  {
>  	free_reserved_area(__va(__pa(__init_begin)), __va(__pa(__init_end)),
>  			   0, "unused kernel");
> -	fixup_init();
> +	/*
> +	 * Unmap the __init region but leave the VM area in place. This
> +	 * prevents the region from being reused for kernel modules, which
> +	 * is not supported by kallsyms.
> +	 */
> +	unmap_kernel_range((u64)__init_begin, (u64)(__init_end - __init_begin));

Please also include <linux/vmalloc.h> above. That is where the prototype
of unmap_kernel_range is defined.

We were getting away without that in mm/mmu.c, but we should fix it up
now.

Otherwise, the patch looks good to me. With the above fixed up:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
