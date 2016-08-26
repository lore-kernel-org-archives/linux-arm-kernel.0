From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 26 Aug 2016 15:42:45 +0100
Subject: [PATCH v7 5/9] arm64: pmu: Add support for probing with ACPI
References: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
 <1471985280-2243-6-git-send-email-jeremy.linton@arm.com>
Message-ID: <87inunoal6.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

A few comments below.

Jeremy Linton <jeremy.linton@arm.com> writes:

> From: Mark Salter <msalter@redhat.com>
>
> In the case of ACPI, the PMU IRQ information is contained in the
> MADT table. Also, since the PMU does not exist as a device in the
> ACPI DSDT table, it is necessary to create a platform device so
> that the appropriate driver probing is triggered.
>

The commit title and message are not true after the re-organisation from
v6. We don't create the platform devices until Patch 8. Maybe something
along the lines of -

"parse the core PMU interrupts from MADT"

More comments below.

> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/smp.c      |  5 +++++
>  drivers/perf/Kconfig         |  4 ++++
>  drivers/perf/Makefile        |  1 +
>  drivers/perf/arm_pmu_acpi.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/perf/arm_pmu.h |  7 ++++++
>  5 files changed, 68 insertions(+)
>  create mode 100644 drivers/perf/arm_pmu_acpi.c
>

[...]

> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> new file mode 100644
> index 0000000..e784714
> --- /dev/null
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -0,0 +1,51 @@
> +/*
> + * ARM ACPI PMU support
> + *
> + * Copyright (C) 2015 Red Hat Inc.
> + * Author: Mark Salter <msalter@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include <asm/cpu.h>
> +#include <linux/acpi.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
> +#include <linux/list.h>
> +#include <linux/perf/arm_pmu.h>
> +#include <linux/platform_device.h>
> +
> +struct pmu_irq {
> +	int  gsi;
> +	int  trigger;
> +	bool registered;
> +};
> +
> +static struct pmu_irq pmu_irqs[NR_CPUS] __initdata;
> +
> +/*
> + * Called from acpi_map_gic_cpu_interface()'s MADT parsing during boot.

The comment needs an update after the rename in Patch 4.


[...]

> +static int __init pmu_acpi_init(void)
> +{
> +	int err = -ENOMEM;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	return err;
> +}
> +arch_initcall(pmu_acpi_init);

The function definition and the arch_initcall don't add any
functionality here and can both be moved to Patch 8.

Thanks,
Punit

> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index ef4b760..012deb7 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -158,4 +158,11 @@ int arm_pmu_device_probe(struct platform_device *pdev,
>  
>  #endif /* CONFIG_ARM_PMU */
>  
> +#ifdef CONFIG_ARM_PMU_ACPI
> +struct acpi_madt_generic_interrupt;
> +void arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic);
> +#else
> +#define arm_pmu_parse_acpi(a, b) do { } while (0)
> +#endif /* CONFIG_ARM_PMU_ACPI */
> +
>  #endif /* __ARM_PMU_H__ */
