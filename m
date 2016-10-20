From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Oct 2016 17:37:49 +0100
Subject: [PATCH v14 4/9] acpi/arm64: Add GTDT table parse driver
In-Reply-To: <1475086637-1914-5-git-send-email-fu.wei@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-5-git-send-email-fu.wei@linaro.org>
Message-ID: <20161020163719.GC27598@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As a heads-up, on v4.9-rc1 I see conflicts at least against
arch/arm64/Kconfig. Luckily git am -3 seems to be able to fix that up
automatically, but this will need to be rebased before the next posting
and/or merging.

On Thu, Sep 29, 2016 at 02:17:12AM +0800, fu.wei at linaro.org wrote:
> +static int __init map_gt_gsi(u32 interrupt, u32 flags)
> +{
> +	int trigger, polarity;
> +
> +	if (!interrupt)
> +		return 0;

Urgh.

Only the secure interrupt (which we do not need) is optional in this
manner, and (hilariously), zero appears to also be a valid GSIV, per
figure 5-24 in the ACPI 6.1 spec.

So, I think that:

(a) we should not bother parsing the secure interrupt
(b) we should drop the check above
(c) we should report the spec issue to the ASWG

> +/*
> + * acpi_gtdt_c3stop - got c3stop info from GTDT
> + *
> + * Returns 1 if the timer is powered in deep idle state, 0 otherwise.
> + */
> +bool __init acpi_gtdt_c3stop(void)
> +{
> +	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
> +
> +	return !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
> +}

It looks like this can differ per interrupt. Shouldn't we check the
appropriate one?

> +int __init acpi_gtdt_init(struct acpi_table_header *table)
> +{
> +	void *start;
> +	struct acpi_table_gtdt *gtdt;
> +
> +	gtdt = container_of(table, struct acpi_table_gtdt, header);
> +
> +	acpi_gtdt_desc.gtdt = gtdt;
> +	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
> +
> +	if (table->revision < 2) {
> +		pr_debug("Revision:%d doesn't support Platform Timers.\n",
> +			 table->revision);
> +		return 0;
> +	}
> +
> +	if (!gtdt->platform_timer_count) {
> +		pr_debug("No Platform Timer.\n");
> +		return 0;
> +	}
> +
> +	start = (void *)gtdt + gtdt->platform_timer_offset;
> +	if (start < (void *)table + sizeof(struct acpi_table_gtdt)) {
> +		pr_err(FW_BUG "Failed to retrieve timer info from firmware: invalid data.\n");
> +		return -EINVAL;
> +	}
> +	acpi_gtdt_desc.platform_timer_start = start;
> +
> +	return gtdt->platform_timer_count;
> +}

This is never used as anything other than a status code.

Just return zero; we haven't parsed the platform timers themselves at
this point anyway.

Thanks,
Mark.
