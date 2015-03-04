From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 04 Mar 2015 23:36:11 +0100
Subject: [PATCH v9 06/21] ACPI: fix acpi_os_ioremap for arm64
In-Reply-To: <1424853601-6675-7-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-7-git-send-email-hanjun.guo@linaro.org>
Message-ID: <8319080.yo6LBolOJB@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 25, 2015 04:39:46 PM Hanjun Guo wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> The acpi_os_ioremap() function may be used to map normal RAM or IO
> regions. The current implementation simply uses ioremap_cache(). This
> will work for some architectures, but arm64 ioremap_cache() cannot be
> used to map IO regions which don't support caching. So for arm64, use
> ioremap() for non-RAM regions.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/arm64/include/asm/acpi.h | 13 +++++++++++++
>  include/acpi/acpi_io.h        |  4 ++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 8b837ab..40e0924 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -12,8 +12,21 @@
>  #ifndef _ASM_ACPI_H
>  #define _ASM_ACPI_H
>  
> +#include <linux/mm.h>
> +
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
> +/* ACPI table mapping after acpi_gbl_permanent_mmap is set */
> +static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> +					    acpi_size size)
> +{
> +	if (!page_is_ram(phys >> PAGE_SHIFT))
> +		return ioremap(phys, size);
> +
> +	return ioremap_cache(phys, size);
> +}
> +#define acpi_os_ioremap acpi_os_ioremap
> +
>  #define acpi_strict 1	/* No out-of-spec workarounds on ARM64 */
>  extern int acpi_disabled;
>  extern int acpi_noirq;
> diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> index 444671e..dd86c5f 100644
> --- a/include/acpi/acpi_io.h
> +++ b/include/acpi/acpi_io.h
> @@ -3,11 +3,15 @@
>  
>  #include <linux/io.h>
>  
> +#include <asm/acpi.h>
> +
> +#ifndef acpi_os_ioremap
>  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>  					    acpi_size size)
>  {
>         return ioremap_cache(phys, size);
>  }
> +#endif
>  
>  void __iomem *__init_refok
>  acpi_os_map_iomem(acpi_physical_address phys, acpi_size size);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
