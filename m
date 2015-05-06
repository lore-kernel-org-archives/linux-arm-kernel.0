From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 May 2015 13:46:29 +0100
Subject: [PATCH] arm64/perf: add ACPI support
In-Reply-To: <1430491548-9896-1-git-send-email-msalter@redhat.com>
References: <1430491548-9896-1-git-send-email-msalter@redhat.com>
Message-ID: <20150506124628.GB14922@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, May 01, 2015 at 03:45:48PM +0100, Mark Salter wrote:
> When using ACPI, the perf_event irq info needs to be parsed
> from the MADT and a corresponding platform device needs to
> be created and registered. The only change to the existing
> driver is a check to avoid unnecessary devicetree parsing.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  arch/arm64/kernel/perf_event.c | 106 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 195991d..1e53b26 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -31,6 +31,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/uaccess.h>
> +#include <linux/acpi.h>
>  
>  #include <asm/cputype.h>
>  #include <asm/irq.h>
> @@ -1315,6 +1316,10 @@ static int armpmu_device_probe(struct platform_device *pdev)
>  	if (!cpu_pmu)
>  		return -ENODEV;
>  
> +	/* skip the devicetree parsing if we're using ACPI */
> +	if (!acpi_disabled)
> +		goto done;

Can we invert the logic here and move the DT parsing into a new function,
please? That way it's clearer to read the ACPI and DT paths, I think.

> +
>  	irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
>  	if (!irqs)
>  		return -ENOMEM;
> @@ -1350,6 +1355,7 @@ static int armpmu_device_probe(struct platform_device *pdev)
>  	else
>  		kfree(irqs);
>  
> +done:
>  	cpu_pmu->plat_device = pdev;
>  	return 0;
>  }
> @@ -1368,6 +1374,106 @@ static int __init register_pmu_driver(void)
>  }
>  device_initcall(register_pmu_driver);
>  
> +#ifdef CONFIG_ACPI
> +struct acpi_pmu_irq {
> +	int gsi;
> +	int trigger;
> +};
> +
> +static struct acpi_pmu_irq acpi_pmu_irqs[NR_CPUS] __initdata;

Does this have to be allocated statically?

> +static int __init
> +acpi_parse_pmu_irqs(struct acpi_subtable_header *header,
> +		    const unsigned long end)
> +{
> +	struct acpi_madt_generic_interrupt *gic;
> +	int cpu;
> +	u64 mpidr;
> +
> +	gic = (struct acpi_madt_generic_interrupt *)header;
> +	if (BAD_MADT_ENTRY(gic, end))
> +		return -EINVAL;
> +
> +	mpidr = gic->arm_mpidr & MPIDR_HWID_BITMASK;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (cpu_logical_map(cpu) != mpidr)
> +			continue;
> +
> +		acpi_pmu_irqs[cpu].gsi = gic->performance_interrupt;
> +		if (gic->flags & ACPI_MADT_PERFORMANCE_IRQ_MODE)
> +			acpi_pmu_irqs[cpu].trigger = ACPI_EDGE_SENSITIVE;
> +		else
> +			acpi_pmu_irqs[cpu].trigger = ACPI_LEVEL_SENSITIVE;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int __init pmu_acpi_init(void)
> +{
> +	struct platform_device *pdev;
> +	struct acpi_pmu_irq *pirq = acpi_pmu_irqs;
> +	struct resource	*res, *r;
> +	int err = -ENOMEM;
> +	int i, count, irq;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
> +				      acpi_parse_pmu_irqs, num_possible_cpus());

Now we have three places parsing the MADT:

  - The SMP boot code
  - The GIC code
  - The PMU code

The first is called from acpi_init_cpus via setup.c, the second is called
from acpi_irq_init via irqchip.c and for the third you're proposing an
initcall...

Given that the acpi_gic_init() invocation from acpi_irq_init has a comment
making it sound like something better is coming along, is there a chance
that we could tidy up the MADT parsing so that it's at least called from
some common place?


> +	/* Must have irq for boot boot cpu, at least */
> +	if (count <= 0 || pirq->gsi == 0)
> +		return -EINVAL;
> +
> +	irq = acpi_register_gsi(NULL, pirq->gsi, pirq->trigger,
> +				ACPI_ACTIVE_HIGH);

Some platforms (unfortunately, this is more common than I'd like) OR all
of the per-cpu SPIs together and we have to play games to get that working.
I can imagine that being described in ACPI by having the same interrupt
number for each core but that interrupt *not* being percpu (i.e. not a PPI).

I don't particularly care for supporting this configuration, but we should
explicitly reject this case and fail the probe.

> +	if (irq_is_percpu(irq))
> +		count = 1;

Should we sanity check that all cores have the same interrupt number?

> +
> +	pdev = platform_device_alloc("arm-pmu", -1);
> +	if (!pdev)
> +		goto err_free_gsi;

Won't we end up unregistering too many GSIs in this error case?

> +
> +	res = kcalloc(count, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		goto err_free_device;

Likewise.

> +
> +	for (i = 0, r = res; i < count; i++, pirq++, r++) {
> +		if (i)
> +			irq = acpi_register_gsi(NULL, pirq->gsi, pirq->trigger,
> +						ACPI_ACTIVE_HIGH);

Is there no polarity field, like we have in the GTDT for the architected
timer?

Will
