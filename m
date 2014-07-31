From: olof@lixom.net (Olof Johansson)
Date: Wed, 30 Jul 2014 23:54:26 -0700
Subject: [PATCH 10/19] ARM64 / ACPI: Get the enable method for SMP
 initialization in ACPI way
In-Reply-To: <1406206825-15590-11-git-send-email-hanjun.guo@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-11-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140731065426.GA876@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 24, 2014 at 09:00:16PM +0800, Hanjun Guo wrote:
> +/*
> + * In ACPI mode, the cpu possible map was enumerated before SMP
> + * initialization when MADT table was parsed, so we can get the
> + * possible map here to initialize CPUs.
> + */

The DT smp init will warn if the kernel has been build with too low NR_CPUS.
Does the ACPI core already warn, or did that go missing with this separate code
path?

> +static void __init acpi_smp_init_cpus(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (cpu_acpi_read_ops(cpu) != 0)
> +			continue;
> +
> +		cpu_ops[cpu]->cpu_init(NULL, cpu);
> +	}
> +}
> +
> +void __init smp_init_cpus(void)
> +{
> +	if (acpi_disabled)
> +		of_smp_init_cpus();
> +	else
> +		acpi_smp_init_cpus();

I'm liking these deeply split code paths less and less every time I see
them. :(

I would prefer to set up shared state in separate functions, but keep the
control flow the same. Right now you're splitting it completely.

I.e. split data setup between the two, but do the loop calling cpu_init()
the same way. (Yes, that will require you to refactor the DT code path
a bit too...)


-Olof
