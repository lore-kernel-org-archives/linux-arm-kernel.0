From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Jan 2015 11:17:56 +0000
Subject: [PATCH v7 11/17] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
In-Reply-To: <1421247905-3749-12-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-12-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150120111756.GE25575@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 03:04:59PM +0000, Hanjun Guo wrote:
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

Nitpick: I would clarify the comment here since "meaningful" doesn't
necessarily mean that the other bits are 0. And if they are not, the
above masking is not enough. Looking at the ACPI 5.1 spec, bits other
than Aff[0-3] must be zero.

Same for the pack_mpidr() comment.

-- 
Catalin
