From: grant.likely@linaro.org (Grant Likely)
Date: Fri, 06 Mar 2015 20:20:42 +0000
Subject: [PATCH v9 03/21] ACPI: add arm64 to the platforms that use ioremap
In-Reply-To: <1424853601-6675-4-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-4-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150306202042.C6F53C40AA9@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Feb 2015 16:39:43 +0800
, Hanjun Guo <hanjun.guo@linaro.org>
 wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> Now with the base changes to the arm memory mapping it is safe
> to convert to using ioremap to map in the tables after
> acpi_gbl_permanent_mmap is set.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

LGTM.

Reviewed-by: Grant Likely <grant.likely@linaro.org>

> ---
>  drivers/acpi/osl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index f9eeae8..39748bb 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -336,11 +336,11 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
>  	return NULL;
>  }
>  
> -#ifndef CONFIG_IA64
> -#define should_use_kmap(pfn)   page_is_ram(pfn)
> -#else
> +#if defined(CONFIG_IA64) || defined(CONFIG_ARM64)
>  /* ioremap will take care of cache attributes */
>  #define should_use_kmap(pfn)   0
> +#else
> +#define should_use_kmap(pfn)   page_is_ram(pfn)
>  #endif
>  
>  static void __iomem *acpi_map(acpi_physical_address pg_off, unsigned long pg_sz)
> -- 
> 1.9.1
> 
