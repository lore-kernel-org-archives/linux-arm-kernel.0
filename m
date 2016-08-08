From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 8 Aug 2016 14:07:54 +0100
Subject: [PATCH 1/1] irqchip: irq-gic: forward SGI to itself for
 cortex-a7 single core
In-Reply-To: <HE1PR04MB1450C6BE844A31C95CEE3BE18B1B0@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <1470642594-30455-1-git-send-email-peter.chen@nxp.com>
 <20160808105026.GA12649@leverpostej>
 <HE1PR04MB1450C6BE844A31C95CEE3BE18B1B0@HE1PR04MB1450.eurprd04.prod.outlook.com>
Message-ID: <20160808130754.GB12649@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2016 at 12:00:35PM +0000, Peter Chen wrote:
>  
> >
> >On Mon, Aug 08, 2016 at 03:49:54PM +0800, Peter Chen wrote:
> >> According to Cortex-A7 MPCore TRM, ch8.3.1, Distributor register
> >> summary,
> >> GICD_ITARGETSRn:
> >>
> >> 	The register that contains the SGI and PPI interrupts is
> >>        	read-only and the value is implementation defined. For
> >>        	Cortex-A7 configurations with only one processor, these
> >>        	registers are RAZ/WI.
> >>
> >> So, the GICD_ITARGETSR[0..7] is read-only, and the value is 0 for
> >> cortex-a7 single core platform if the SoC is cortex-a7 mpcore version.
> >> So the cupmask from gic_get_cpumask is 0.
> >>
> >> At ARM Generic Interrupt Controller Architecture version 2.0,
> >> ch4.3.15 Software Generated Interrupt Register, GICD_SGIR, The
> >> distributor will process the requested SGI according to register
> >> TargetListFilter and CPUTargetList. At current gic code, it takes
> >> TargetListFilter as 0b00, and forward the interrupt to cpumask
> >> (variable map at gic_raise_softirq) getting from gic_get_cpumask.
> >> but cpumask is 0 according to above explanation for cortex-a7 single
> >> core platform, so, both TargetListFilter and CPUTargetList are 0, and
> >> the distributor does not forward the interrupt to any CPU interface
> >> according to gic documentation, then the SGI can't be occurred.
> >>
> >> We have found this problem at nxp imx6ul platform, which is a
> >> cortex-a7 single core platform, the irq work (triggered by SGI at ARM)
> >> can't be occurred which is needed for cpufreq, then the system has
> >> failed to boot and reboot [1].
> >>
> >> In this commit, we set TargetListFilter as 0b10 to fix this problem,
> >> it forwards the interrupt only to CPU0 and only cortex-a7 single core
> >> platform uses this setting currently.
> >
> >This is a generic property of the GIC architecture in UP systems, and is not specific
> >to Cortex-A7. So checking for Cortex-A7 specifically doesn't solve the problem.
> 
> It is a SMP system, the is_smp returns true due to MPIDR is 0x80000000. This
> platform is MPcore, just the cpu number is one.

Apologies, I see the distinction now. The CPU claims to have the
multiprocessing extensions, and to be part of a multiprocessor system
(despite the latter not being the case). The GIC is not a multiprocessor
implementation as defined in the GIC architecture.

> Current kernel considers the hardware is IPI capable if is_smp is true, see
> arch_irq_work_has_interrupt().  I think I should add additional condition
> is_smp == true.

I see that for arm64 we have:

static inline bool arch_irq_work_has_interrupt(void)
{
	return !!__smp_cross_call;
}

Could we do similarly for ARM, and ony register gic_raise_softirq if
we have non-zero SGI targets?

If I've understood correctly, that would make things behave as they do
for UP on you system.

> >As Russell pointed out in [2], this is a generic infrastructure problem, and there are
> >other systems where HW might not have a self-IPI.
> 
> If the HW is UP, it is no problem. The irq work will not trigger IPI.
> 
> > I note that core code already
> >handles that in some cases, e.g. in generic_exec_single where we just disable
> >interrupts and run the work locally rather than sending a self-IPI.
> >
> >How/where exactly is this self-IPI raised? Can we follow the example of
> >generic_exec_single there?
> 
> In my case, the cpufreq uses irq work, irq work tries to trigger IPI. See
> sugov_update_commit-> irq_work_queue.
> 
> imx6ul is MPcore system, just single core. If ARM considers MPcore
> system has IPI capabilities, and documentation is correct, then it is 
> probably gic code's issue.

If self-IPI is necessary, then this would be up to the GIC code to
solve.

For that case, it would be nicer if we could detect whether this was
necessary based on the GIC registers alone. That way we handle the
various ways this can be integrated, aren't totally relient on the DT,
work in VMs, etc.

Thanks,
Mark.

> >[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/430545.html
> >[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/430849.html
