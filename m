From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Dec 2015 12:26:46 +0000
Subject: [PATCH v3 5/7] arm64: move kernel mapping out of linear region
In-Reply-To: <1447672998-20981-6-git-send-email-ard.biesheuvel@linaro.org>
References: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447672998-20981-6-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151207122642.GA7083@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 12:23:16PM +0100, Ard Biesheuvel wrote:
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 23cfc08fc8ba..d3e4b5d6a8d2 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
[...]
> @@ -210,7 +210,15 @@ section_table:
>  ENTRY(stext)
>  	bl	preserve_boot_args
>  	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
> -	adrp	x24, __PHYS_OFFSET
> +
> +	/*
> +	 * Before the linear mapping has been set up, __va() translations will
> +	 * not produce usable virtual addresses unless we tweak PHYS_OFFSET to
> +	 * compensate for the offset between the kernel mapping and the base of
> +	 * the linear mapping. We will undo this in map_mem().
> +	 */

Minor typo in comment: I guess you meant "__pa() translations will not
produce usable...".

> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index 5a22a119a74c..f6272f450688 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -63,7 +63,8 @@ static struct addr_marker address_markers[] = {
>  	{ PCI_IO_END,		"PCI I/O end" },
>  	{ MODULES_VADDR,	"Modules start" },
>  	{ MODULES_END,		"Modules end" },
> -	{ PAGE_OFFSET,		"Kernel Mapping" },
> +	{ KIMAGE_VADDR,		"Kernel Mapping" },
> +	{ PAGE_OFFSET,		"Linear Mapping" },
>  	{ -1,			NULL },
>  };

Apart from this, please change the pr_notice() in mem_init() to show the
linear mapping at the end (keep them in ascending order).

-- 
Catalin
