From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Jan 2018 13:09:21 +0000
Subject: [PATCH] arm64: mm: ignore memory above supported physical
 address size
In-Reply-To: <1516302791-7692-1-git-send-email-kristina.martsenko@arm.com>
References: <1516302791-7692-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <20180119130920.kzursyjzcyhvi6bk@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 07:13:11PM +0000, Kristina Martsenko wrote:
> When booting a kernel without 52-bit PA support (e.g. a kernel with 4k
> pages) on a system with 52-bit memory, the kernel will currently try to
> use the 52-bit memory and crash. Fix this by ignoring any memory higher
> than what the kernel supports.
> 
> Fixes: f77d281713d4 ("arm64: enable 52-bit physical address support")
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
>  arch/arm64/mm/init.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 672094ed7e07..285745b2ca38 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -366,6 +366,9 @@ void __init arm64_memblock_init(void)
>  	/* Handle linux,usable-memory-range property */
>  	fdt_enforce_memory_region();
>  
> +	/* Remove memory above our supported physical address size */
> +	memblock_remove(1ULL << PHYS_MASK_SHIFT, ULLONG_MAX);
> +
>  	/*
>  	 * Ensure that the linear region takes up exactly half of the kernel
>  	 * virtual address space. This way, we can distinguish a linear address

It looks fine. I'll queue it for 4.16.

Thanks.

-- 
Catalin
