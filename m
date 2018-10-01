From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 1 Oct 2018 13:52:26 +0100
Subject: [PATCH v15 07/16] arm64: add image head flag definitions
In-Reply-To: <20180928064841.14117-8-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-8-takahiro.akashi@linaro.org>
Message-ID: <20181001125225.7tlfzt5n25sckhyy@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 03:48:32PM +0900, AKASHI Takahiro wrote:
> Those image head's flags will be used later by kexec_file loader.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Acked-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/include/asm/boot.h | 15 +++++++++++++++
>  arch/arm64/kernel/head.S      |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
> index 355e552a9175..0bab7eed3012 100644
> --- a/arch/arm64/include/asm/boot.h
> +++ b/arch/arm64/include/asm/boot.h
> @@ -5,6 +5,21 @@
>  
>  #include <asm/sizes.h>
>  
> +#define ARM64_MAGIC		"ARM\x64"
> +
> +#define HEAD_FLAG_BE_SHIFT		0
> +#define HEAD_FLAG_PAGE_SIZE_SHIFT	1
> +#define HEAD_FLAG_BE_MASK		0x1
> +#define HEAD_FLAG_PAGE_SIZE_MASK	0x3
> +
> +#define HEAD_FLAG_BE			1

These already exist in some form in arch/arm64/kernel/image.h; can we
please factor those out rather than duplicating them?

I'd be happy if you'd update image.h to use the new HEAD_FLAG_* names,
and removed the old definitions.

> +#define HEAD_FLAG_PAGE_SIZE_4K		1
> +#define HEAD_FLAG_PAGE_SIZE_16K		2
> +#define HEAD_FLAG_PAGE_SIZE_64K		3

I appreciate these are new, since we didn't previously need definitions.

Thanks,
Mark.

> +
> +#define head_flag_field(flags, field) \
> +		(((flags) >> field##_SHIFT) & field##_MASK)
> +
>  /*
>   * arm64 requires the DTB to be 8 byte aligned and
>   * not exceed 2MB in size.
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index b0853069702f..8cbac6232ed1 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -91,7 +91,7 @@ _head:
>  	.quad	0				// reserved
>  	.quad	0				// reserved
>  	.quad	0				// reserved
> -	.ascii	"ARM\x64"			// Magic number
> +	.ascii	ARM64_MAGIC			// Magic number
>  #ifdef CONFIG_EFI
>  	.long	pe_header - _head		// Offset to the PE header.
>  
> -- 
> 2.19.0
> 
