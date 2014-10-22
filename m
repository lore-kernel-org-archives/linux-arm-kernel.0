From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Oct 2014 10:50:19 +0100
Subject: [PATCH 2/8] arm: perf: make PMU probing data-driven
In-Reply-To: <5446CF2E.4070301@codeaurora.org>
References: <1413897084-19715-1-git-send-email-mark.rutland@arm.com>
 <1413897084-19715-3-git-send-email-mark.rutland@arm.com>
 <5446CF2E.4070301@codeaurora.org>
Message-ID: <20141022095019.GA22642@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 10:25:02PM +0100, Stephen Boyd wrote:
> On 10/21/2014 06:11 AM, Mark Rutland wrote:
> > diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
> > index 4bf4cce..79c1cf4 100644
> > --- a/arch/arm/kernel/perf_event_cpu.c
> > +++ b/arch/arm/kernel/perf_event_cpu.c
> > @@ -241,48 +241,34 @@ static struct platform_device_id cpu_pmu_plat_device_ids[] = {
> >  	{},
> >  };
> >  
> > +static struct pmu_probe_info pmu_probe_table[] = {
> 
> const?

Sure. Done.

> > +	ARM_PMU_PROBE(ARM_CPU_PART_ARM1136, armv6_1136_pmu_init),
> > +	ARM_PMU_PROBE(ARM_CPU_PART_ARM1156, armv6_1156_pmu_init),
> > +	ARM_PMU_PROBE(ARM_CPU_PART_ARM1176, armv6_1176_pmu_init),
> > +	ARM_PMU_PROBE(ARM_CPU_PART_ARM11MPCORE, armv6mpcore_pmu_init),
> > +	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A8, armv7_a8_pmu_init),
> > +	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A9, armv7_a9_pmu_init),
> > +	XSCALE_PMU_PROBE(ARM_CPU_XSCALE_ARCH_V1, xscale1pmu_init),
> > +	XSCALE_PMU_PROBE(ARM_CPU_XSCALE_ARCH_V2, xscale2pmu_init),
> > +	{ /* sentinel value */ }
> > +};
> > +
> >  /*
> >   * CPU PMU identification and probing.
> >   */
> >  static int probe_current_pmu(struct arm_pmu *pmu)
> >  {
> >  	int cpu = get_cpu();
> > +	unsigned int cpuid = read_cpuid_id();
> >  	int ret = -ENODEV;
> > +	struct pmu_probe_info *info;
> >  
> > -	pr_info("probing PMU on CPU %d\n", cpu);
> > +	pr_info("probing PMU on CPU %d", cpu);
> 
> Why drop the newline?

Unintentional -- at one point I'd changed the print while debugging and
must have messed up trying to restore it to its original state. I've
restored the newline locally.

> Looks like all the other prints in this file are missing the newline.

Hmm. All other pr_info instances are missing newlines, but pr_err and
pr_warning instances have them. It looks like we get lucky with the next
print having a log prefix, and this causing the existing text to be
flushed.

I'll put together a cleanup patch introducing the relevant newlines.

Thanks,
Mark.
