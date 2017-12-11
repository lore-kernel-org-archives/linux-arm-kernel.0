From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Dec 2017 17:55:40 +0000
Subject: [PATCH 5/5] arm_pmu: acpi: request IRQs up-front
In-Reply-To: <20171211173647.GA3275@arm.com>
References: <20171101141239.45340-1-mark.rutland@arm.com>
 <20171101141239.45340-6-mark.rutland@arm.com>
 <20171211173647.GA3275@arm.com>
Message-ID: <20171211175539.jqjxyoa4vtwrakl3@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 05:36:47PM +0000, Will Deacon wrote:
> On Wed, Nov 01, 2017 at 02:12:39PM +0000, Mark Rutland wrote:
> > We can't request IRQs in atomic context, so for ACPI systems we'll have
> > to request them up-front, and later associate them with CPUs.
> > 
> > This patch reorganises the arm_pmu code to do so. As we no longer have
> > the arm_pmu strucutre at probe time, a number of prototypes need to be
> > adjusted, requiring changes to the common arm_pmu code and arm_pmu
> > platform code.

> > +void armpmu_bind_cpu(struct arm_pmu *armpmu, int cpu)
> >  {
> > -	struct arm_pmu_platdata *platdata = armpmu_get_platdata(armpmu);
> > -	unsigned long irq_flags;
> > -	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
> > -	int irq = per_cpu(hw_events->irq, cpu);
> > -	if (!irq)
> > -		return 0;
> > -
> > -	if (platdata && platdata->irq_flags) {
> > -		irq_flags = platdata->irq_flags;
> > -	} else {
> > -		irq_flags = ARM_PMU_IRQ_FLAGS;
> > -	}
> > -
> >  	per_cpu(cpu_armpmu, cpu) = armpmu;
> 
> Can we not make the binding implicit in armpmu_{request,free}_irq?

Unfortunately not.

As mentioned in the commit message (typo and all), in the ACPI case, we
need to request/free IRQs before we know the PMU.

Mark.
