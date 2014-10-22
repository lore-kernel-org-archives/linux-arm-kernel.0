From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Oct 2014 15:49:08 +0100
Subject: [PATCH 02/10] arm64/efi: set PE/COFF section alignment to 4 KB
In-Reply-To: <1413987713-30528-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1413987713-30528-1-git-send-email-ard.biesheuvel@linaro.org>
 <1413987713-30528-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141022144908.GD4010@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 03:21:45PM +0100, Ard Biesheuvel wrote:
> Position independent AArch64 code needs to be linked and loaded at the
> same relative offset from a 4 KB boundary, or adrp/add and adrp/ldr
> pairs will not work correctly. (This is how PC relative symbol
> references with a 4 GB reach are emitted)
> 
> We need to declare this in the PE/COFF header, otherwise the PE/COFF
> loader may load the Image and invoke the stub at an offset which
> violates this rule.
> 
> Reviewed-by: Roy Franz <roy.franz@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> v2: added comment explaining '.align 12' in head.S
> ---
>  arch/arm64/kernel/head.S | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 8c06c9d269d2..8ae84d8c2a8c 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -161,7 +161,7 @@ optional_header:
>  
>  extra_header_fields:
>  	.quad	0				// ImageBase
> -	.long	0x20				// SectionAlignment
> +	.long	0x1000				// SectionAlignment
>  	.long	0x8				// FileAlignment
>  	.short	0				// MajorOperatingSystemVersion
>  	.short	0				// MinorOperatingSystemVersion
> @@ -228,7 +228,15 @@ section_table:
>  	.short	0		// NumberOfRelocations  (0 for executables)
>  	.short	0		// NumberOfLineNumbers  (0 for executables)
>  	.long	0xe0500020	// Characteristics (section flags)
> -	.align 5
> +
> +	/*
> +	 * EFI will load stext onwards at the 4k section alignment
> +	 * described in the PE/COFF header. To ensure that instruction
> +	 * sequences using an adrp and a :lo12: immediate will function
> +	 * correctly at this alignment, we must ensure that stext is
> +	 * placed at a 4k boundary in the Image to begin with.
> +	 */
> +	.align 12
>  #endif
>  
>  ENTRY(stext)
> -- 
> 1.8.3.2
> 
> 
