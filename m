From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 13 Jun 2016 10:40:20 +0100
Subject: [PATCH v5 4/5] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <DF4PR84MB0041D17321244DFB84979A84D9530@DF4PR84MB0041.NAMPRD84.PROD.OUTLOOK.COM>
References: <1462981062-24909-1-git-send-email-sudeep.holla@arm.com>
 <1462981062-24909-5-git-send-email-sudeep.holla@arm.com>
 <DF4PR84MB0041D17321244DFB84979A84D9530@DF4PR84MB0041.NAMPRD84.PROD.OUTLOOK.COM>
Message-ID: <575E7F84.2000106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/06/16 05:47, Sajjan, Vikas C wrote:
> Hi Sudeep,
>

[...]

> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -13,6 +13,7 @@
>
>   #define pr_fmt(fmt) "psci: " fmt
>
> +#include <linux/acpi.h>
>   #include <linux/arm-smccc.h>
>   #include <linux/cpuidle.h>
>   #include <linux/errno.h>
> @@ -310,11 +311,66 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
>   	return ret;
>   }
>
> +#ifdef CONFIG_ACPI
> +#include <acpi/processor.h>
> +
> +static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu) {
> +	int i, count;
> +	u32 *psci_states;
> +	struct acpi_processor *pr;
> +	struct acpi_lpi_state *lpi;
> +
> +	pr = per_cpu(processors, cpu);
> +	if (unlikely(!pr || !pr->flags.has_lpi))
>
> Any particular reason for _not_ considering CST flag here.
> Or you are planning to add CST support in some other patch set.
>

Are you referring the old C-state objects ? We don't support them on
ARM64. Only LPIs are support. The ARM FFH is not defined for CST, only
for LPIs.

-- 
Regards,
Sudeep
