From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Jan 2014 11:26:47 +0000
Subject: [PATCH 17/20] clocksource / arch_timer: Use ACPI GTDT table to
 initialize arch timer
In-Reply-To: <1389961514-13562-18-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-18-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140127112647.GC16516@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 12:25:11PM +0000, Hanjun Guo wrote:
> ACPI GTDT (Generic Timer Description Table) contains information for
> arch timer initialization, this patch use this table to probe arm timer.
> 
> GTDT table is used for ARM/ARM64 only, please refer to chapter 5.2.24
> of ACPI 5.0 spec for detailed inforamtion
> 
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/clocksource/arm_arch_timer.c |  100 +++++++++++++++++++++++++++++-----
>  1 file changed, 85 insertions(+), 15 deletions(-)

[...]

> +static void __init register_arch_interrupt(u32 interrupt, u32 flags,
> +					int *arch_timer_ppi)
> +{
> +	int trigger, polarity;
> +
> +	if (!interrupt || !arch_timer_ppi)
> +		return;
> +
> +	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
> +			: ACPI_LEVEL_SENSITIVE;
> +
> +	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
> +			: ACPI_ACTIVE_HIGH;
> +
> +	*arch_timer_ppi = acpi_register_gsi(NULL, interrupt, trigger,
> +						polarity);
> +}

Why does this take a pointer to the irq rather than returning the irq
(as with irq_of_parse_and_map)?

This looks awfully generic. Are the timer interrupts encoded specially
or is this useful for parsing other interrupts?

> +
> +static int __init acpi_parse_gtdt(struct acpi_table_header *table)
> +{
> +	struct acpi_table_gtdt *gtdt;
> +
> +	gtdt = (struct acpi_table_gtdt *)table;
> +	if (!gtdt)
> +		return -EINVAL;
> +
> +	arch_timer_rate = arch_timer_get_cntfrq();
> +
> +	if (!arch_timer_rate) {
> +		pr_warn("arch_timer: Could not get frequency from CNTFREG\n");

s/CNTFREG/CNTFREQ/

This is probably worth a pr_err at least, the system is unlikely to get
very far if the timers don't work.

Thanks,
Mark.
