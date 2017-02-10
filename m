From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Feb 2017 10:13:29 +0000
Subject: [PATCH v2 05/14] arm64: efi: remove forbidden values from the
 PE/COFF header
In-Reply-To: <1486554947-3964-6-git-send-email-ard.biesheuvel@linaro.org>
References: <1486554947-3964-1-git-send-email-ard.biesheuvel@linaro.org>
 <1486554947-3964-6-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170210101329.GD28753@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 11:55:38AM +0000, Ard Biesheuvel wrote:
> Bring the PE/COFF header in line with the PE/COFF spec, by setting
> NumberOfSymbols to 0, and removing the section alignment flags.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I take it that in practice EFI implementations don't care about these?
Assuming so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Otherwise, we might want to fix this first, so that we can easily
backport it.

Thanks,
Mark.

> ---
>  arch/arm64/kernel/efi-header.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
> index 9b24ce130afb..515624bbfcd0 100644
> --- a/arch/arm64/kernel/efi-header.S
> +++ b/arch/arm64/kernel/efi-header.S
> @@ -15,7 +15,7 @@ coff_header:
>  	.short	2					// nr_sections
>  	.long	0 					// TimeDateStamp
>  	.long	0					// PointerToSymbolTable
> -	.long	1					// NumberOfSymbols
> +	.long	0					// NumberOfSymbols
>  	.short	section_table - optional_header		// SizeOfOptionalHeader
>  	.short	0x206					// Characteristics.
>  							// IMAGE_FILE_DEBUG_STRIPPED |
> @@ -88,7 +88,7 @@ section_table:
>  	.long	0					// PointerToLineNumbers
>  	.short	0					// NumberOfRelocations
>  	.short	0					// NumberOfLineNumbers
> -	.long	0x42100040				// Characteristics (section flags)
> +	.long	0x42000040				// Characteristics (section flags)
>  
>  
>  	.ascii	".text"
> @@ -104,7 +104,7 @@ section_table:
>  	.long	0					// PointerToLineNumbers
>  	.short	0					// NumberOfRelocations
>  	.short	0					// NumberOfLineNumbers
> -	.long	0xe0500020				// Characteristics
> +	.long	0xe0000020				// Characteristics
>  
>  #ifdef CONFIG_DEBUG_EFI
>  	/*
> -- 
> 2.7.4
> 
