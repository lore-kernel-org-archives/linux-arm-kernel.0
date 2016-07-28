From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 28 Jul 2016 10:39:51 +0100
Subject: [PATCH v11] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <1469640545-5848-1-git-send-email-fu.wei@linaro.org>
References: <1469640545-5848-1-git-send-email-fu.wei@linaro.org>
Message-ID: <f018fd18-03e7-3247-7d65-af430092230e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/07/16 18:29, fu.wei at linaro.org wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>
> This commit provides APEI arch-specific bits for aarch64
>
> Meanwhile,
> (1)add a new subfunction "hest_ia32_init" for
> "acpi_disable_cmcff" which is used by IA-32 Architecture
> Corrected Machine Check (CMC).
> (2)move HEST type (ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) checking to
> a generic place.
> (3)select HAVE_ACPI_APEI when EFI and ACPI is set on ARM64,
> because arch_apei_get_mem_attribute is using efi_mem_attributes on ARM64.
>
> [Fu Wei: improve && upstream]
>


> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 5420cb0..d3d02dc 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -17,6 +17,7 @@
>
>  #include <asm/cputype.h>
>  #include <asm/smp_plat.h>
> +#include <asm/tlbflush.h>
>
>  /* Macros for consistency checks of the GICC subtable of MADT */
>  #define ACPI_MADT_GICC_LENGTH	\
> @@ -110,8 +111,21 @@ static inline const char *acpi_get_enable_method(int cpu)
>  }
>
>  #ifdef	CONFIG_ACPI_APEI
> +#define acpi_disable_cmcff 1
>  pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
> -#endif
> +
> +/*
> + * Despite its name, this function must still broadcast the TLB
> + * invalidation in order to ensure other CPUs don't up with with junk

Please fix the comment above ^^^.


Suzuki
