From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 15:27:40 +0100
Subject: [PATCH v2 09/18] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
In-Reply-To: <1407166105-17675-10-git-send-email-hanjun.guo@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-10-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140818142740.GU20043@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 04:28:16PM +0100, Hanjun Guo wrote:
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 022f4ad..a81898d 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -12,6 +12,8 @@
>  #ifndef _ASM_ACPI_H
>  #define _ASM_ACPI_H
>  
> +#include <asm/smp_plat.h>
> +
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
>  /*
> @@ -59,6 +61,18 @@ static inline void disable_acpi(void)
>  	acpi_noirq = 1;
>  }
>  
> +u32 pack_mpidr_into_32_bits(u64 mpidr);

I would define this as a static inline function here.

> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index e32321c..4007313 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -64,6 +64,38 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
>  	return 0;
>  }
>  
> +/*
> + * On ARM platform, MPIDR value is the hardware ID as apic ID
> + * on Intel platforms
> + */
> +static int map_gicc_mpidr(struct acpi_subtable_header *entry,
> +		int device_declaration, u32 acpi_id, int *mpidr)
> +{
> +	struct acpi_madt_generic_interrupt *gicc =
> +	    container_of(entry, struct acpi_madt_generic_interrupt, header);
> +
> +	if (!(gicc->flags & ACPI_MADT_ENABLED))
> +		return -ENODEV;
> +
> +	/* In the GIC interrupt model, logical processors are
> +	 * required to have a Processor Device object in the DSDT,
> +	 * so we should check device_declaration here
> +	 */
> +	if (device_declaration && (gicc->uid == acpi_id)) {
> +		/*
> +		 * Only bits [0:7] Aff0, bits [8:15] Aff1, bits [16:23] Aff2
> +		 * and bits [32:39] Aff3 are meaningful, so pack the Affx
> +		 * fields into a single 32 bit identifier to accommodate the
> +		 * acpi processor drivers.
> +		 */
> +		*mpidr = ((gicc->arm_mpidr & 0xff00000000) >> 8)
> +			 | gicc->arm_mpidr;

You can use pack_mpidr_into_32_bits().

-- 
Catalin
