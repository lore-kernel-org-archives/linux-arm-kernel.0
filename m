From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 04 Mar 2015 23:46:19 +0100
Subject: [PATCH v9 14/21] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
In-Reply-To: <1424853601-6675-15-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-15-git-send-email-hanjun.guo@linaro.org>
Message-ID: <2411054.s4TkmAUKjT@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 25, 2015 04:39:54 PM Hanjun Guo wrote:
> Introduce a new function map_gicc_mpidr() to allow MPIDRs to be obtained
> from the GICC Structure introduced by ACPI 5.1.
> 
> The ARM architecture defines the MPIDR register as the CPU hardware
> identifier. This patch adds the code infrastructure to retrieve the MPIDR
> values from the ARM ACPI GICC structure in order to look-up the kernel CPU
> hardware ids required by the ACPI core code to identify CPUs.
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/include/asm/acpi.h | 12 ++++++++++++
>  drivers/acpi/processor_core.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 9719921..9a23369 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -13,6 +13,8 @@
>  #define _ASM_ACPI_H
>  
>  #include <linux/mm.h>
> +#include <asm/cputype.h>
> +#include <asm/smp_plat.h>
>  
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
> @@ -27,6 +29,9 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>  }
>  #define acpi_os_ioremap acpi_os_ioremap
>  
> +typedef u64 phys_cpuid_t;
> +#define CPU_PHYS_ID_INVALID INVALID_HWID
> +

Any chance to combine this with patch [2/21]?  Or at least put them next to each
other in the series so as to indicate that they are related or *mention* patch
[2/21] in the changelog here?

IMO, you really need to define phys_cpuid_t in a common place or people will
forget that it may be 64-bit, because they'll only be looking at their arch.

>  #define acpi_strict 1	/* No out-of-spec workarounds on ARM64 */
>  extern int acpi_disabled;
>  extern int acpi_noirq;
> @@ -59,6 +64,13 @@ static inline void enable_acpi(void)
>  }
>  
>  /*
> + * The ACPI processor driver for ACPI core code needs this macro
> + * to find out this cpu was already mapped (mapping from CPU hardware
> + * ID to CPU logical ID) or not.
> + */
> +#define cpu_physical_id(cpu) cpu_logical_map(cpu)
> +
> +/*
>   * It's used from ACPI core in kdump to boot UP system with SMP kernel,
>   * with this check the ACPI core will not override the CPU index
>   * obtained from GICC with 0 and not print some error message as well.
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index a5547dc..8654adb 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -83,6 +83,31 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
>  	return 0;
>  }
>  
> +/*
> + * Retrieve the ARM CPU physical identifier (MPIDR)
> + */
> +static int map_gicc_mpidr(struct acpi_subtable_header *entry,
> +		int device_declaration, u32 acpi_id, phys_cpuid_t *mpidr)
> +{
> +	struct acpi_madt_generic_interrupt *gicc =
> +	    container_of(entry, struct acpi_madt_generic_interrupt, header);
> +
> +	if (!(gicc->flags & ACPI_MADT_ENABLED))
> +		return -ENODEV;
> +
> +	/* device_declaration means Device object in DSDT, In the
> +	 * GIC interrupt model, logical processors are required to
> +	 * have a Processor Device object in the DSDT, so we should
> +	 * check device_declaration here
> +	 */
> +	if (device_declaration && (gicc->uid == acpi_id)) {
> +		*mpidr = gicc->arm_mpidr;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static phys_cpuid_t map_madt_entry(int type, u32 acpi_id)
>  {
>  	unsigned long madt_end, entry;
> @@ -111,6 +136,9 @@ static phys_cpuid_t map_madt_entry(int type, u32 acpi_id)
>  		} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
>  			if (!map_lsapic_id(header, type, acpi_id, &phys_id))
>  				break;
> +		} else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT) {
> +			if (!map_gicc_mpidr(header, type, acpi_id, &phys_id))
> +				break;
>  		}
>  		entry += header->length;
>  	}
> @@ -143,6 +171,8 @@ static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
>  		map_lsapic_id(header, type, acpi_id, &phys_id);
>  	else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC)
>  		map_x2apic_id(header, type, acpi_id, &phys_id);
> +	else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT)
> +		map_gicc_mpidr(header, type, acpi_id, &phys_id);
>  
>  exit:
>  	kfree(buffer.pointer);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
