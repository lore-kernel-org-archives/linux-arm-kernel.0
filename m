From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 30 Jun 2016 15:09:31 +0100
Subject: [PATCH] efi: arm64: add debugfs node to dump UEFI runtime page
 tables
In-Reply-To: <1467280906-31158-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1467280906-31158-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160630140930.GD20363@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 12:01:46PM +0200, Ard Biesheuvel wrote:
> Register the debugfs node 'efi_page_tables' to allow the UEFI runtime
> page tables to be inspected. Note that ARM does not have 'asm/ptdump.h'
> [yet] so for now, this is arm64 only.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> This patch could be helpful in assessing the series 'arm64: avoid block
> entries that we need to split later' that I sent out yesterday.

It's probably worth noting that this is based on the arm64 for-next/core
branch. I don't know if/how we can orgnise branches for merging this.

>  drivers/firmware/efi/arm-runtime.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 17ccf0a8787a..4197a1da013d 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -39,6 +39,26 @@ static struct mm_struct efi_mm = {
>  	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
>  };
>  
> +#ifdef CONFIG_ARM64

If you use CONFIG_ARM64_PTDUMP for the moment, then we won't have some
unused structs lying around when the feature is unused.

Otherwise, I agree that this is a useful debuging feature. FWIW, either
way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> +#include <asm/ptdump.h>
> +
> +static struct ptdump_info efi_ptdump_info = {
> +	.mm		= &efi_mm,
> +	.markers	= (struct addr_marker[]){
> +		{ 0,		"UEFI runtime start" },
> +		{ TASK_SIZE_64,	"UEFI runtime end" }
> +	},
> +	.base_addr	= 0,
> +};
> +
> +static int __init ptdump_init(void)
> +{
> +	return ptdump_register(&efi_ptdump_info, "efi_page_tables");
> +}
> +device_initcall(ptdump_init);
> +
> +#endif
> +
>  static bool __init efi_virtmap_init(void)
>  {
>  	efi_memory_desc_t *md;
> -- 
> 2.7.4
> 
