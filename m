From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 3 Jul 2015 15:06:01 +0100
Subject: [PATCH v3 2/3] ACPI / ARM64: add BAD_MADT_GICC_ENTRY() macro
In-Reply-To: <1435880916-2153-3-git-send-email-al.stone@linaro.org>
References: <1435880916-2153-1-git-send-email-al.stone@linaro.org>
 <1435880916-2153-3-git-send-email-al.stone@linaro.org>
Message-ID: <20150703140601.GL25907@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 02, 2015 at 05:48:35PM -0600, Al Stone wrote:
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 39248d3..a3c26a4 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -19,6 +19,17 @@
>  #include <asm/psci.h>
>  #include <asm/smp_plat.h>
>  
> +/* Macros for consistency checks of the GICC subtable of MADT */
> +#define ACPI_MADT_GICC_51_LENGTH       76
> +#define ACPI_MADT_GICC_60_LENGTH       80
> +
> +#define BAD_MADT_GICC_ENTRY(entry, end) (                                   \
> +		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
> +		((ACPI_FADT_SPEC_VERSION == ACPI_FADT_SPEC_VERSION_51) &&   \
> +		 (entry->header.length != ACPI_MADT_GICC_51_LENGTH))    ||  \
> +		((ACPI_FADT_SPEC_VERSION == ACPI_FADT_SPEC_VERSION_60) &&   \
> +		 (entry->header.length != ACPI_MADT_GICC_60_LENGTH)))

This looks ugly but, well, we could live with this.

However, I'd like to avoid having to extend this macro every time we get
a new spec released, like 6.1 defining another 80 or 84 etc. So, how
about we only update this when there is an actual change in the length?
Something like:

#define ACPI_MADT_GICC_LENGTH	({					\
	u8 length;							\
	if (ACPI_FADT_SPEC_VERSION < ACPI_FADT_SPEC_VERSION_6_0)	\
		length = 76;						\
	else								\
		length = 80;						\
	length;								\
})

or just:

#define ACPI_MADT_GICC_LENGTH	\
	(ACPI_FADT_SPEC_VERSION < ACPI_FADT_SPEC_VERSION_6_0 ? 76 : 80)

(the latter is simpler but may not look nice if we change it again in
6.1; though we could re-write this macro when needed, not a problem)

-- 
Catalin
