From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 17:17:35 +0000
Subject: [patch v11 12/23] ARM64 / ACPI: Parse MADT for SMP initialization
In-Reply-To: <1427205776-5060-13-git-send-email-hanjun.guo@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-13-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150325171735.GI14585@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 10:02:45PM +0800, Hanjun Guo wrote:
> +/**
> + * acpi_map_gic_cpu_interface - generates a logical cpu number
> + * and map to MPIDR represented by GICC structure
> + * @mpidr: CPU's hardware id to register, MPIDR represented in MADT
> + * @enabled: this cpu is enabled or not
> + *
> + * Returns the logical cpu number which maps to MPIDR
> + */
> +static int __init acpi_map_gic_cpu_interface(u64 mpidr, u8 enabled)

So here we have an u8 enabled.

> +static int __init
> +acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
> +				const unsigned long end)
> +{
> +	struct acpi_madt_generic_interrupt *processor;
> +
> +	processor = (struct acpi_madt_generic_interrupt *)header;
> +
> +	if (BAD_MADT_ENTRY(processor, end))
> +		return -EINVAL;
> +
> +	acpi_table_print_madt_entry(header);
> +
> +	acpi_map_gic_cpu_interface(processor->arm_mpidr & MPIDR_HWID_BITMASK,
> +		processor->flags & ACPI_MADT_ENABLED);

and here processor->flags is u32. Luckily, ACPI_MADT_ENABLED is 1 and we
don't lose any information. So either make the enabled above a bool or
simply pass the flags with the check in acpi_map_gic_cpu_interface()
(personal preference for the latter).

Apart from this:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
