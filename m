From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 13 Jan 2015 15:34:49 +0000
Subject: [PATCH 1/2] arm64: Fix overlapping VA allocations
In-Reply-To: <1421091408-10660-2-git-send-email-mark.rutland@arm.com>
References: <1421091408-10660-1-git-send-email-mark.rutland@arm.com>
 <1421091408-10660-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20150113153448.GE16524@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 07:36:47PM +0000, Mark Rutland wrote:
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -26,6 +26,7 @@
>  
>  #include <asm/byteorder.h>
>  #include <asm/barrier.h>
> +#include <asm/memory.h>
>  #include <asm/pgtable.h>
>  #include <asm/early_ioremap.h>
>  #include <asm/alternative.h>
> @@ -145,8 +146,8 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>   *  I/O port access primitives.
>   */
>  #define arch_has_dev_port()	(1)
> -#define IO_SPACE_LIMIT		(SZ_32M - 1)
> -#define PCI_IOBASE		((void __iomem *)(MODULES_VADDR - SZ_32M))
> +#define IO_SPACE_LIMIT		(PCI_IO_END - PCI_IO_START - 1)
> +#define PCI_IOBASE		((void __iomem *)PCI_IO_START)

I've seen at least couple of places where IO_SPACE_LIMIT is used as a
mark. So I would prefer it to be something like (power-of-two - 1)
rather than some random (size - 1).

> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -45,7 +45,9 @@
>  #define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
>  #define MODULES_END		(PAGE_OFFSET)
>  #define MODULES_VADDR		(MODULES_END - SZ_64M)
> -#define FIXADDR_TOP		(MODULES_VADDR - SZ_2M - PAGE_SIZE)
> +#define PCI_IO_END		(MODULES_VADDR - SZ_2M)
> +#define PCI_IO_START		(PCI_IO_END - SZ_32M)
> +#define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
>  #define TASK_SIZE_64		(UL(1) << VA_BITS)

So you could make PCI_IO_START MODULES_VADDR - SZ_16M and FIXADDR_TOP
just below it (or above as it was before, I don't really care).

>  #ifdef CONFIG_COMPAT
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index cf33f33..203a6cf 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -52,8 +52,8 @@ static struct addr_marker address_markers[] = {
>  	{ 0,			"vmemmap start" },
>  	{ 0,			"vmemmap end" },
>  #endif
> -	{ (unsigned long) PCI_IOBASE,		"PCI I/O start" },
> -	{ (unsigned long) PCI_IOBASE + SZ_16M,	"PCI I/O end" },
> +	{ PCI_IO_START,		"PCI I/O start" },
> +	{ PCI_IO_END,		"PCI I/O end" },
>  	{ FIXADDR_START,	"Fixmap start" },
>  	{ FIXADDR_TOP,		"Fixmap end" },
>  	{ MODULES_VADDR,	"Modules start" },
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index bac492c..9f2406d 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -35,6 +35,7 @@
>  #include <linux/efi.h>
>  
>  #include <asm/fixmap.h>
> +#include <asm/memory.h>
>  #include <asm/sections.h>
>  #include <asm/setup.h>
>  #include <asm/sizes.h>
> @@ -291,7 +292,7 @@ void __init mem_init(void)
>  		  MLM((unsigned long)virt_to_page(PAGE_OFFSET),
>  		      (unsigned long)virt_to_page(high_memory)),
>  #endif
> -		  MLM((unsigned long)PCI_IOBASE, (unsigned long)PCI_IOBASE + SZ_16M),
> +		  MLM(PCI_IO_START, PCI_IO_END),
>  		  MLK(FIXADDR_START, FIXADDR_TOP),
>  		  MLM(MODULES_VADDR, MODULES_END),
>  		  MLM(PAGE_OFFSET, (unsigned long)high_memory),

If you change the order of FIX_ADDR_TOP with the PCI_IO_START, so you
should change the printed order as well.

-- 
Catalin
