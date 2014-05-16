From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 16 May 2014 14:11:25 -0400 (EDT)
Subject: [PATCH v3] arm: ioremap: Fix static vm area boundary check.
In-Reply-To: <1400232920-25079-1-git-send-email-Li.Xiubo@freescale.com>
References: <1400232920-25079-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <alpine.LFD.2.11.1405161403400.17310@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 May 2014, Xiubo Li wrote:

> For each vmalloc area, there is one guard page at the end of it.
> so the vm->size = PAGE_ALIGN(offset + request size) + guard page size.

Nope.  There is no guard page for statically created vmalloc areas.


> Signed-off-by: Richard Lee <superlibj8301@gmail.com>
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  arch/arm/mm/ioremap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index be69333..758e8f7 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -49,14 +49,18 @@ static struct static_vm *find_static_vm_paddr(phys_addr_t paddr,
>  	struct vm_struct *vm;
>  
>  	list_for_each_entry(svm, &static_vmlist, list) {
> +		phys_addr_t paddr_end, phys_addr_end;
> +
>  		vm = &svm->vm;
>  		if (!(vm->flags & VM_ARM_STATIC_MAPPING))
>  			continue;
>  		if ((vm->flags & VM_ARM_MTYPE_MASK) != VM_ARM_MTYPE(mtype))
>  			continue;
>  
> -		if (vm->phys_addr > paddr ||
> -			paddr + size - 1 > vm->phys_addr + vm->size - 1)
> +		/* The PAGE_SIZE here is vmalloc area's guard page */
> +		phys_addr_end = vm->phys_addr + vm->size - PAGE_SIZE - 1;
> +		paddr_end = paddr + size - 1;
> +		if (vm->phys_addr > paddr || paddr_end > phys_addr_end)
>  			continue;
>  
>  		return svm;
> -- 
> 1.8.4
> 
