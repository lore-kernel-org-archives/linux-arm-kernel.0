From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Feb 2015 14:17:49 +0000
Subject: [PATCH v8 14/21] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
In-Reply-To: <1422881149-8177-15-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-15-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150203141749.GA32536@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 12:45:42PM +0000, Hanjun Guo wrote:
> Introduce a new function map_gicc_mpidr() to allow MPIDRs to be obtained
> from the GICC Structure introduced by ACPI 5.1.
> 
> MPIDR is the CPU hardware ID as local APIC ID on x86 platform, so we use
> MPIDR not the GIC CPU interface ID to identify CPUs.
> 
> Further steps would typedef a phys_id_t for in arch code(with
> appropriate size and a corresponding invalid value, say ~0) and use that
> instead of an int in drivers/acpi/processor_core.c to store phys_id, then
> no need for mpidr packing.

I don't understand why we don't fix this now, and I'm very worried that
this patch leaves much potential for FW bugs due to potential Linux
bugs.

Having a function called cpu_physical_id which _does not_ return a
physical ID makes no sense to me. Any time we really need a physical
ID, we're still going to have to unpack it (in an architecture-specific
manner).

I am very worried that we're either going to miss some
packing/unpacking, or FW tables are going to end up being written
incorrectly to match (broken) assumptions that this causes Linux to
make.

If we don't actually need the physical ID, but just an ID that fits in
an int, then we have the logical ID which we can use instead. Having an
intermediary ID that is neither logical nor physical is pointless.

While I appreciate that changing the core to allow for an
architecutre-defined physical ID type is not necessarily a trivial or
enjoyable exercise, I believe that it is necessary for the health of
ACPI on ARM.

The points above have been brought up repeatedly. Please do not sweep
them under the rug this time. Please fix this properly.

Thanks,
Mark.

> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/include/asm/acpi.h | 30 ++++++++++++++++++++++++++++++
>  drivers/acpi/processor_core.c | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 8984aa5..7e825b9 100644
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
>  #define acpi_strict 1	/* No out-of-spec workarounds on ARM64 */
> @@ -45,6 +47,34 @@ static inline void enable_acpi(void)
>  	acpi_noirq = 0;
>  }
>  
> +/* MPIDR value provided in GICC structure is 64 bits, but the
> + * existing phys_id (CPU hardware ID) using in acpi processor
> + * driver is 32-bit, to conform to the same datatype we need
> + * to repack the GICC structure MPIDR.
> + *
> + * bits other than following 32 bits are defined as 0, so it
> + * will be no information lost after repacked.
> + *
> + * Bits [0:7] Aff0;
> + * Bits [8:15] Aff1;
> + * Bits [16:23] Aff2;
> + * Bits [32:39] Aff3;
> + */
> +static inline u32 pack_mpidr(u64 mpidr)
> +{
> +	return (u32) ((mpidr & 0xff00000000) >> 8) | mpidr;
> +}
> +
> +/*
> + * The ACPI processor driver for ACPI core code needs this macro
> + * to find out this cpu was already mapped (mapping from CPU hardware
> + * ID to CPU logical ID) or not.
> + *
> + * cpu_logical_map(cpu) is the mapping of MPIDR and the logical cpu,
> + * and MPIDR is the cpu hardware ID we needed to pack.
> + */
> +#define cpu_physical_id(cpu) pack_mpidr(cpu_logical_map(cpu))
> +
>  /*
>   * It's used from ACPI core in kdump to boot UP system with SMP kernel,
>   * with this check the ACPI core will not override the CPU index
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index 02e4839..5ac12e4 100644
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
> +		 * bits other than [0:7] Aff0, [8:15] Aff1, [16:23] Aff2 and
> +		 * [32:39] Aff3 must be 0 which is defined in ACPI 5.1, so pack
> +		 * the Affx fields into a single 32 bit identifier to accommodate
> +		 * the acpi processor drivers.
> +		 */
> +		*mpidr = ((gicc->arm_mpidr & 0xff00000000) >> 8)
> +			 | gicc->arm_mpidr;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int map_madt_entry(int type, u32 acpi_id)
>  {
>  	unsigned long madt_end, entry;
> @@ -99,6 +131,9 @@ static int map_madt_entry(int type, u32 acpi_id)
>  		} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
>  			if (!map_lsapic_id(header, type, acpi_id, &phys_id))
>  				break;
> +		} else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT) {
> +			if (!map_gicc_mpidr(header, type, acpi_id, &phys_id))
> +				break;
>  		}
>  		entry += header->length;
>  	}
> @@ -131,6 +166,8 @@ static int map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
>  		map_lsapic_id(header, type, acpi_id, &phys_id);
>  	else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC)
>  		map_x2apic_id(header, type, acpi_id, &phys_id);
> +	else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT)
> +		map_gicc_mpidr(header, type, acpi_id, &phys_id);
>  
>  exit:
>  	kfree(buffer.pointer);
> -- 
> 1.9.1
> 
> 
