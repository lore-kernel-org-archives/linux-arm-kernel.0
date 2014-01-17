From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jan 2014 15:12:42 +0100
Subject: [PATCH 09/20] ARM64 / ACPI: Implement core functions for parsing
 MADT table
In-Reply-To: <1389961514-13562-10-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-10-git-send-email-hanjun.guo@linaro.org>
Message-ID: <201401171512.42850.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 January 2014, Hanjun Guo wrote:
>  
> +/*
> + * Local interrupt controller address,
> + * GIC cpu interface base address on ARM/ARM64
> + */
> +static u64 acpi_lapic_addr __initdata;

If it's cpu local, don't you need more than one address to support SMP?
Also, the variable appears to be write-only.

> +#define BAD_MADT_ENTRY(entry, end) (					\
> +	(!entry) || (unsigned long)entry + sizeof(*entry) > end ||	\
> +	((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
> +

Better make this an inline function.

> +static int __init
> +acpi_parse_gic(struct acpi_subtable_header *header, const unsigned long end)
> +{
> +	struct acpi_madt_generic_interrupt *processor = NULL;
> +
> +	processor = (struct acpi_madt_generic_interrupt *)header;

You don't need the initialization in the first line when you write to the
variable before reading it. Same in the other functions.

	Arnd
