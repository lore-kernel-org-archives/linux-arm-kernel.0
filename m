From: timur@codeaurora.org (Timur Tabi)
Date: Sun, 13 Mar 2016 18:28:38 -0500
Subject: [PATCH 3/4] arm64: pmu: Add support for probing with ACPI
In-Reply-To: <1457911398-22412-4-git-send-email-jeremy.linton@arm.com>
References: <1457911398-22412-1-git-send-email-jeremy.linton@arm.com>
 <1457911398-22412-4-git-send-email-jeremy.linton@arm.com>
Message-ID: <56E5F7A6.3030905@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jeremy Linton wrote:
> +	int i, count, irq;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	acpi_parse_boot_cpu();
> +
> +	/* Must have irq for boot boot cpu, at least */
> +	if (pirq->gsi == 0)
> +		return -EINVAL;
> +
> +	irq = acpi_register_gsi(NULL, pirq->gsi, pirq->trigger,
> +				ACPI_ACTIVE_HIGH);
> +
> +	if (irq_is_percpu(irq))
> +		count = 1;
> +	else
> +		for (i = 1, count = 1; i < NR_CPUS; i++)
> +			if (pmu_irqs[i].gsi)
> +				++count;

You could more simply with:

	int count = 1
	...
	if (!irq_is_percpu(irq))
		for (i = 1; i < NR_CPUS; i++)
			if (pmu_irqs[i].gsi)
				++count;



-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
