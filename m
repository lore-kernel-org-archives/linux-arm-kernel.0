From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 14 Jul 2012 08:22:44 -0400 (EDT)
Subject: [PATCH v2 01/15] ARM: Add fixed PCI i/o mapping
In-Reply-To: <1342231451-28861-2-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <1342231451-28861-2-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1207140815220.14068@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jul 2012, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds a fixed virtual mapping for PCI i/o addresses. The mapping is
> located at the last 2MB of vmalloc region (0xfee00000-0xff000000). 2MB
> is used to align with PMD size, but IO_SPACE_LIMIT is 1MB. The space
> is reserved just before .map_io and can be mapped at any time later with
> pci_ioremap_io.
> 
> This has changed completely from the 1st implementation which only
> supported creating the static mapping at .map_io.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Nicolas Pitre <nico@linaro.org>

A few comments below:

> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index cf4528d..c5ca07b 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -31,6 +31,7 @@
>  
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> +#include <asm/mach/pci.h>
>  
>  #include "mm.h"
>  
> @@ -791,6 +792,18 @@ void __init iotable_init(struct map_desc *io_desc, int nr)
>  	}
>  }
>  
> +void __init vm_reserve_area_early(unsigned long addr, unsigned long size)
> +{
> +	struct vm_struct *vm;
> +
> +	vm = early_alloc_aligned(sizeof(*vm), __alignof__(*vm));
> +	vm->addr = (void *)addr;
> +	vm->size = size;
> +	vm->flags = VM_IOREMAP | VM_ARM_STATIC_MAPPING;
> +	vm->caller = vm_reserve_area_early;

This is not providing much useful information when looking at 
/proc/vmallocinfo anymore.  What about adding a void *caller argument to 
this function and initializing vm->caller with it to identify the true 
origin of the region?

> +	vm_area_add_early(vm++);

Why ++ ?

Other than that...

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
