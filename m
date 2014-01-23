From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 Jan 2014 17:50:31 +0000
Subject: [PATCH 11/20] ARM64 / ACPI: Get the enable method for SMP
 initialization
In-Reply-To: <1389961514-13562-12-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-12-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140123175031.GJ27520@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 12:25:05PM +0000, Hanjun Guo wrote:
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -48,6 +48,7 @@
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
>  #include <asm/ptrace.h>
> +#include <asm/acpi.h>
>  
>  /*
>   * as from 2.5, kernels no longer have an init_tasks structure
> @@ -280,7 +281,7 @@ static void (*smp_cross_call)(const struct cpumask *, unsigned int);
>   * cpu logical map array containing MPIDR values related to logical
>   * cpus. Assumes that cpu_logical_map(0) has already been initialized.
>   */
> -void __init smp_init_cpus(void)
> +static int __init of_smp_init_cpus(void)
>  {
>  	struct device_node *dn = NULL;
>  	unsigned int i, cpu = 1;
> @@ -364,6 +365,10 @@ next:
>  		cpu++;
>  	}
>  
> +	/* No device tree or no CPU node in DT */
> +	if (cpu == 1 && !bootcpu_valid)
> +		return -ENODEV;
> +
>  	/* sanity check */
>  	if (cpu > NR_CPUS)
>  		pr_warning("no. of cores (%d) greater than configured maximum of %d - clipping\n",
> @@ -371,7 +376,7 @@ next:
>  
>  	if (!bootcpu_valid) {
>  		pr_err("DT missing boot CPU MPIDR, not enabling secondaries\n");
> -		return;
> +		return -EINVAL;
>  	}
>  
>  	/*
> @@ -381,6 +386,39 @@ next:
>  	for (i = 0; i < NR_CPUS; i++)
>  		if (cpu_logical_map(i) != INVALID_HWID)
>  			set_cpu_possible(i, true);
> +
> +	return 0;
> +}
> +
> +/*
> + * In ACPI mode, the cpu possible map was enumerated before SMP
> + * initialization when MADT table was parsed, so we can get the
> + * possible map here to initialize CPUs.
> + */
> +static void __init acpi_smp_init_cpus(void)
> +{
> +	int cpu;
> +	const char *enable_method;
> +
> +	for_each_possible_cpu(cpu) {
> +		enable_method = acpi_get_enable_method(cpu);
> +		if (!enable_method)
> +			continue;
> +
> +		cpu_ops[cpu] = cpu_get_ops(enable_method);
> +		if (!cpu_ops[cpu])
> +			continue;
> +
> +		cpu_ops[cpu]->cpu_init(NULL, cpu);
> +	}
> +}
> +
> +void __init smp_init_cpus(void)
> +{
> +	if (!of_smp_init_cpus())
> +		return;
> +
> +	acpi_smp_init_cpus();
>  }

With DT we initialise the cpu_ops[0] via cpu_read_bootcpu_ops() called
from setup_arch(). This is needed because with PSCI we use cpu_ops for
power management even if it's a UP system. Do you get a some kernel
warning about device node for the boot cpu not found?

> --- a/drivers/acpi/plat/arm-core.c
> +++ b/drivers/acpi/plat/arm-core.c
> @@ -367,6 +367,32 @@ static void __init acpi_process_madt(void)
>  }
>  
>  /*
> + * To see PCSI is enabled or not.
> + *
> + * PSCI is not available for ACPI 5.0, return FALSE for now.
> + *
> + * FIXME: should we introduce early_param("psci", func) for test purpose?
> + */
> +static bool acpi_psci_smp_available(int cpu)
> +{
> +	return FALSE;
> +}
> +
> +static const char *enable_method[] = {
> +	"psci",
> +	"spin-table",
> +	NULL
> +};
> +
> +const char *acpi_get_enable_method(int cpu)
> +{
> +	if (acpi_psci_smp_available(cpu))
> +		return enable_method[0];
> +	else
> +		return enable_method[1];
> +}

You could just use literal strings here, actually even ignoring PSCI
until available.

-- 
Catalin
