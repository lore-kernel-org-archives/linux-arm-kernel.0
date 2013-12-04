From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 04 Dec 2013 22:25:16 +0800
Subject: [RFC part3 PATCH 1/2] clocksource / arch_timer: Use ACPI GTDT
 table to initialize arch timer
In-Reply-To: <20131203170407.GA16025@e106331-lin.cambridge.arm.com>
References: <1386088891-2917-1-git-send-email-hanjun.guo@linaro.org>
 <1386088891-2917-2-git-send-email-hanjun.guo@linaro.org>
 <20131203170407.GA16025@e106331-lin.cambridge.arm.com>
Message-ID: <529F3B4C.1080400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?12?04? 01:04, Mark Rutland wrote:
> On Tue, Dec 03, 2013 at 04:41:30PM +0000, Hanjun Guo wrote:
>> ACPI GTDT (Generic Timer Description Table) contains information for
>> arch timer initialization, this patch use this table to probe arm timer.
>>
>> GTDT table is used for ARM/ARM64 only, please refer to chapter 5.2.24
>> of ACPI 5.0 spec for detailed inforamtion
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/clocksource/arm_arch_timer.c |  129 ++++++++++++++++++++++++++++++----
>>   include/clocksource/arm_arch_timer.h |    7 +-
>>   2 files changed, 120 insertions(+), 16 deletions(-)
>   
> [...]
>
>> +#ifdef CONFIG_ACPI
>> +void __init arch_timer_acpi_init(void)
>> +{
>> +	struct acpi_table_gtdt *gtdt;
>> +	acpi_size tbl_size;
>> +	int trigger, polarity;
>> +	void __iomem *base = NULL;
>> +
>> +	if (acpi_disabled)
>> +		return;
>> +
>> +	if (arch_timers_present & ARCH_CP15_TIMER) {
>> +		pr_warn("arch_timer: already initialized, skipping\n");
>> +		return;
>> +	}
>> +
>> +	if (ACPI_FAILURE(acpi_get_table_with_size(ACPI_SIG_GTDT, 0,
>> +			(struct acpi_table_header **)&gtdt, &tbl_size))) {
>> +		pr_err("arch_timer: GTDT table not defined\n");
>> +		return;
>> +	}
>> +
>> +	arch_timers_present |= ARCH_CP15_TIMER;
>> +
>> +	/*
>> +	 * Get the timer frequency. Since there is no frequency info
>> +	 * in the GTDT table, so we should read it from CNTFREG register
>> +	 * or hard code here to wait for the new ACPI spec available.
>> +	 */
> If the core's CNTFRQ register does not hold the correct value, that is a
> horrendous firmware bug. The clock-frequency property in the DT is a
> horrific workaround for buggy firmware.
>
> We should not duplicate it in ACPI; people should be strongly encouraged
> to fix their firmware to do what it is supposed to do.
>
> Rely on CNTFRQ only. If it is wrong, then bail out. Let's not create a
> fertile environment for buggy firmware.

Great, this can make things much simple, and the information which contains
in ACPI GTDT table can be sufficient for timer initialization.


>> +	if (!gtdt->address) {
>> +		arch_timer_rate = arch_timer_get_cntfrq();
>> +	} else {
>> +		base = ioremap(gtdt->address, CNTFRQ);
>> +		if (!base) {
>> +			pr_warn("arch_timer: unable to map arch timer base address\n");
>> +			return;
>> +		}
>> +
>> +		arch_timer_rate = readl_relaxed(base + CNTFRQ);
>> +		iounmap(base);
>> +	}
>> +
>> +	if (!arch_timer_rate) {
>> +		/* Hard code here to set frequence ? */
>> +		pr_warn("arch_timer: Could not get frequency from GTDT table or CNTFREG\n");
>> +	}
>> +
>> +	if (gtdt->secure_pl1_interrupt) {
>> +		trigger = (gtdt->secure_pl1_flags & ACPI_GTDT_INTERRUPT_MODE) ?
>> +			ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>> +		polarity =
>> +			(gtdt->secure_pl1_flags & ACPI_GTDT_INTERRUPT_POLARITY)
>> +			? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +		arch_timer_ppi[0] = acpi_register_gsi(NULL,
>> +				gtdt->secure_pl1_interrupt, trigger, polarity);
>> +	}
> This pattern looks like it can be factored out. I don't see why the
> driver needs to have such intimate knowledge of the interrrupt.
>
>> +	if (gtdt->non_secure_pl1_interrupt) {
>> +		trigger =
>> +			(gtdt->non_secure_pl1_flags & ACPI_GTDT_INTERRUPT_MODE)
>> +			? ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>> +		polarity =
>> +		(gtdt->non_secure_pl1_flags & ACPI_GTDT_INTERRUPT_POLARITY)
>> +			? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +		arch_timer_ppi[1] = acpi_register_gsi(NULL,
>> +			gtdt->non_secure_pl1_interrupt, trigger, polarity);
>> +	}
>> +	if (gtdt->virtual_timer_interrupt) {
>> +		trigger = (gtdt->virtual_timer_flags & ACPI_GTDT_INTERRUPT_MODE)
>> +			? ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>> +		polarity =
>> +		(gtdt->virtual_timer_flags & ACPI_GTDT_INTERRUPT_POLARITY)
>> +			? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +		arch_timer_ppi[2] = acpi_register_gsi(NULL,
>> +			gtdt->virtual_timer_interrupt, trigger, polarity);
>> +	}
>> +	if (gtdt->non_secure_pl2_interrupt) {
>> +		trigger =
>> +			(gtdt->non_secure_pl2_flags & ACPI_GTDT_INTERRUPT_MODE)
>> +			? ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>> +		polarity =
>> +		(gtdt->non_secure_pl2_flags & ACPI_GTDT_INTERRUPT_POLARITY)
>> +			? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +		arch_timer_ppi[3] = acpi_register_gsi(NULL,
>> +			gtdt->non_secure_pl2_interrupt, trigger, polarity);
>> +	}
> Please factor out the interrupt parsing.

Ok, will try to factor it out in next version.

Thanks for the comments.

Hanjun
