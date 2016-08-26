From: james.morse@arm.com (James Morse)
Date: Fri, 26 Aug 2016 10:45:11 +0100
Subject: [PATCH v2] efi: arm64: treat regions with WT/WC set but WB cleared
 as memory
In-Reply-To: <1472141829-12026-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1472141829-12026-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <57C00FA7.8010908@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 25/08/16 17:17, Ard Biesheuvel wrote:
> Currently, memory regions are only recorded in the memblock memory table
> if they have the EFI_MEMORY_WB memory type attribute set. In case the
> region is of a reserved type, it is also marked as MEMBLOCK_NOMAP, which
> will leave it out of the linear mapping.
> 
> However, memory regions may legally have the EFI_MEMORY_WT or EFI_MEMORY_WC
> attributes set, and the EFI_MEMORY_WB cleared, in which case the region in
> question is obviously backed by normal memory, but is not recorded in the
> memblock memory table at all.

I've been hitting this when applying weird (but permissible) attributes to the
ACPI regions. Currently without WB we map these as device memory, then let
acpica make unaligned accesses to it.

This patch fixes all that, and from the conversation on irc, the 'UC only' case
for ACPI tables is x86-legacy, and should never happen.


> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index c49d50e68aee..c2ac5975fd5d 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -163,18 +163,22 @@ static __init int is_reserve_region(efi_memory_desc_t *md)
>  	case EFI_BOOT_SERVICES_DATA:
>  	case EFI_CONVENTIONAL_MEMORY:
>  	case EFI_PERSISTENT_MEMORY:
> -		return 0;
> +		/*
> +		 * According to the spec, these regions are no longer reserved
> +		 * after calling ExitBootServices(). However, we can only use
> +		 * them as System RAM if they can be mapped writeback cacheable.
> +		 */
> +		return (md->attribute & EFI_MEMORY_WB);
>  	default:
>  		break;

Micro-nit: break here in order to immediately return false looks a bit odd...


>  	}
> -	return is_normal_ram(md);
> +	return false;
>  }


Tested-by: James Morse <james.morse@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>


Thanks!

James
