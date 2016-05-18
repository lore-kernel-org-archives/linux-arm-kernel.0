From: lv.zheng@intel.com (Zheng, Lv)
Date: Wed, 18 May 2016 03:06:35 +0000
Subject: [PATCH 1/3] ACPI: table upgrade: use cacheable map for tables
In-Reply-To: <1463486765-31827-2-git-send-email-aleksey.makarov@linaro.org>
References: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
 <1463486765-31827-2-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BBA2E5F@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> From: Aleksey Makarov [mailto:aleksey.makarov at linaro.org]
> Subject: [PATCH 1/3] ACPI: table upgrade: use cacheable map for tables
> 
> The new memory allocated in acpi_table_initrd_init() is used to
> copy the upgraded tables to it.  So it should be mapped with
> early_memunmap() instead of early_ioremap().
> 
> This is critical for ARM.
> 
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
[Lv Zheng] 
Acked-by: Lv Zheng <lv.zheng@intel.com>

Thanks
-Lv

> ---
>  drivers/acpi/tables.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index a372f9e..449a649 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -578,10 +578,10 @@ static void __init acpi_table_initrd_init(void *data,
> size_t size)
>  			clen = size;
>  			if (clen > MAP_CHUNK_SIZE - slop)
>  				clen = MAP_CHUNK_SIZE - slop;
> -			dest_p = early_ioremap(dest_addr & PAGE_MASK,
> +			dest_p = early_memremap(dest_addr & PAGE_MASK,
>  						 clen + slop);
>  			memcpy(dest_p + slop, src_p, clen);
> -			early_iounmap(dest_p, clen + slop);
> +			early_memunmap(dest_p, clen + slop);
>  			src_p += clen;
>  			dest_addr += clen;
>  			size -= clen;
> --
> 2.8.2
