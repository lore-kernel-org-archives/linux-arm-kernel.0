From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Aug 2014 16:05:44 +0100
Subject: [PATCH 4/7] arm64/efi: uefi_init error handling fix
In-Reply-To: <1408007731-15081-4-git-send-email-dyoung@redhat.com>
References: <1408007731-15081-1-git-send-email-dyoung@redhat.com>
 <1408007731-15081-4-git-send-email-dyoung@redhat.com>
Message-ID: <20140815150544.GX27466@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 10:15:29AM +0100, Dave Young wrote:
> There's one early memmap leak in uefi_init error path, fix it and slightly tune
> the error handling code.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Reported-by: Will Deacon <will.deacon@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>

Thanks for fixing this.

Will

> ---
>  arch/arm64/kernel/efi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index e72f310..6ed0362 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -89,7 +89,8 @@ static int __init uefi_init(void)
>  	 */
>  	if (efi.systab->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE) {
>  		pr_err("System table signature incorrect\n");
> -		return -EINVAL;
> +		retval = -EINVAL;
> +		goto out;
>  	}
>  	if ((efi.systab->hdr.revision >> 16) < 2)
>  		pr_warn("Warning: EFI system table version %d.%02d, expected 2.00 or greater\n",
> @@ -103,6 +104,7 @@ static int __init uefi_init(void)
>  		for (i = 0; i < (int) sizeof(vendor) - 1 && *c16; ++i)
>  			vendor[i] = c16[i];
>  		vendor[i] = '\0';
> +		early_memunmap(c16, sizeof(vendor));
>  	}
>  
>  	pr_info("EFI v%u.%.02u by %s\n",
> @@ -113,9 +115,8 @@ static int __init uefi_init(void)
>  	if (retval == 0)
>  		set_bit(EFI_CONFIG_TABLES, &efi.flags);
>  
> -	early_memunmap(c16, sizeof(vendor));
> +out:
>  	early_memunmap(efi.systab,  sizeof(efi_system_table_t));
> -
>  	return retval;
>  }
>  
> -- 
> 1.8.3.1
> 
> 
