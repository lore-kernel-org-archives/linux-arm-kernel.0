From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 7 Apr 2017 15:49:31 +0100
Subject: [PATCHv2 14/16] drivers/perf: arm_pmu: add ACPI framework
In-Reply-To: <20170407142706.GN19342@arm.com>
References: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
 <1491503363-17731-15-git-send-email-mark.rutland@arm.com>
 <20170407142706.GN19342@arm.com>
Message-ID: <20170407144931.GA858@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 07, 2017 at 03:27:06PM +0100, Will Deacon wrote:
> Hi Mark,
> 
> Just a couple of minor comments below.
> 
> On Thu, Apr 06, 2017 at 07:29:21PM +0100, Mark Rutland wrote:

> > +static int arm_pmu_acpi_parse_irq(int cpu)

> > +static void arm_pmu_acpi_unparse_irq(int cpu)

> "unparse" is a bit weird. Can you rename this register/unregister please?

Sure thing; that's much better.

[...]

> > +static int arm_pmu_acpi_parse_irqs(void)
> > +{
> > +	int cpu, irq;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		int irq = arm_pmu_acpi_parse_irq(cpu);
> > +		if (irq < 0) {
> > +			pr_warn("Unable to parse ACPI PMU IRQ for CPU%d: %d\n",
> > +				cpu, irq);
> > +			goto out_err;
> > +		} else if (irq == 0) {
> > +			pr_warn("No ACPI PMU IRQ for CPU%d\n", cpu);
> > +		}
> > +
> > +		per_cpu(pmu_irqs, cpu) = irq;
> > +	}
> > +
> > +	return 0;
> > +
> > +out_err:
> > +	for_each_possible_cpu(cpu) {
> > +		arm_pmu_acpi_unparse_irq(cpu);
> > +		per_cpu(pmu_irqs, cpu) = 0;
> > +	}
> 
> It might work at the moment (I really can't tell), but I'd rather we didn't
> unregister GSIs that we didn't register.

Urgh, yes.

That gets really more fun if you consider PPIs (which could be
mismatched).

If we're happy with a hideous loop we can do:

	int irq, cpu, irq_cpu;

	for_each_possible_cpu(cpu) {
		irq = per_cpu(pmu_irqs, cpu);
		if (!irq)
			continue;

		arm_pmu_acpi_unparse_irq(cpu);

		/* blat all instances of the irq we just freed */
		for_each_possible_cpu(irq_cpu) {
			if (per_cpu(pmu_irqs, irq_cpu) != irq)
				continue;
			per_cpu(pmu_irqs, irq_cpu) = 0;
		}
	}

... which I'll spin for v3.

Thanks,
Mark.
