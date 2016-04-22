From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 22 Apr 2016 18:01:21 +0100
Subject: [PATCH v2 6/6] efi/arm*: add support to dump the EFI page tables
In-Reply-To: <1461343688-8552-7-git-send-email-ard.biesheuvel@linaro.org>
References: <1461343688-8552-1-git-send-email-ard.biesheuvel@linaro.org>
 <1461343688-8552-7-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160422170112.GS10606@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 06:48:08PM +0200, Ard Biesheuvel wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> Occasionally it's useful to inspect the page tables used for EFI runtime
> services, similarly to those cases where it's useful to be able to
> inspect the kernel page tables.
> 
> Now that the kernel page table dump code has been made generic, use it
> to export the EFI runtime services page tables under debugfs (as
> "efi_page_tables").
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> [ ardb: mildly refactored for compatibility with ARM ]
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/arm-runtime.c | 21 ++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 6ae21e41a429..c48fc2f5413b 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -27,6 +27,7 @@
>  #include <asm/mmu.h>
>  #include <asm/pgalloc.h>
>  #include <asm/pgtable.h>
> +#include <asm/ptdump.h>
>  
>  extern u64 efi_system_table;
>  
> @@ -133,3 +134,23 @@ void efi_virtmap_unload(void)
>  	efi_set_pgd(current->active_mm);
>  	preempt_enable();
>  }
> +
> +static const struct addr_marker efi_addr_markers[] = {
> +	{ 0,	"EFI runtime services" },
> +	{ -1 },
> +};
> +
> +static struct ptdump_info efi_ptdump_info = {
> +	.mm		= &efi_mm,
> +	.markers	= efi_addr_markers,
> +	.base_addr	= 0,
> +	.max_addr	= SZ_1G,
> +};

I see that max_addr isn't used for arm64, and for ARM it's only used in
one place. It doesn't seem great to have that on arm64 given it's
unused.

Do we actually need max_addr? Is there any reason not to always dump
whole tables?

I guess you're trying to avoid dumping the kernel VA range on 32-bit?

Thanks,
Mark.

> +
> +static int efi_ptdump_init(void)
> +{
> +	if (!efi_enabled(EFI_RUNTIME_SERVICES))
> +		return 0;
> +	return ptdump_register(&efi_ptdump_info, "efi_page_tables");
> +}
> +device_initcall(efi_ptdump_init);
> -- 
> 2.7.4
> 
