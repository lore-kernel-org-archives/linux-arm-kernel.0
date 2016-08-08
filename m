From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 8 Aug 2016 21:28:47 +0800
Subject: [PATCH 1/1] irqchip: irq-gic: forward SGI to itself for
 cortex-a7 single core
In-Reply-To: <20160808130754.GB12649@leverpostej>
References: <1470642594-30455-1-git-send-email-peter.chen@nxp.com>
 <20160808105026.GA12649@leverpostej>
 <HE1PR04MB1450C6BE844A31C95CEE3BE18B1B0@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <20160808130754.GB12649@leverpostej>
Message-ID: <20160808132847.GB17680@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2016 at 02:07:54PM +0100, Mark Rutland wrote:
> > >>
> > >> In this commit, we set TargetListFilter as 0b10 to fix this problem,
> > >> it forwards the interrupt only to CPU0 and only cortex-a7 single core
> > >> platform uses this setting currently.
> > >
> > >This is a generic property of the GIC architecture in UP systems, and is not specific
> > >to Cortex-A7. So checking for Cortex-A7 specifically doesn't solve the problem.
> > 
> > It is a SMP system, the is_smp returns true due to MPIDR is 0x80000000. This
> > platform is MPcore, just the cpu number is one.
> 
> Apologies, I see the distinction now. The CPU claims to have the
> multiprocessing extensions, and to be part of a multiprocessor system
> (despite the latter not being the case). The GIC is not a multiprocessor
> implementation as defined in the GIC architecture.
> 

It doesn't matter. Yes, it is my case.

> > Current kernel considers the hardware is IPI capable if is_smp is true, see
> > arch_irq_work_has_interrupt().  I think I should add additional condition
> > is_smp == true.
> 
> I see that for arm64 we have:
> 
> static inline bool arch_irq_work_has_interrupt(void)
> {
> 	return !!__smp_cross_call;
> }
> 
> Could we do similarly for ARM, and ony register gic_raise_softirq if
> we have non-zero SGI targets?
> 
> If I've understood correctly, that would make things behave as they do
> for UP on you system.
> 

I think it can work.

> > In my case, the cpufreq uses irq work, irq work tries to trigger IPI. See
> > sugov_update_commit-> irq_work_queue.
> > 
> > imx6ul is MPcore system, just single core. If ARM considers MPcore
> > system has IPI capabilities, and documentation is correct, then it is 
> > probably gic code's issue.
> 
> If self-IPI is necessary, then this would be up to the GIC code to
> solve.
> 
> For that case, it would be nicer if we could detect whether this was
> necessary based on the GIC registers alone. That way we handle the
> various ways this can be integrated, aren't totally relient on the DT,
> work in VMs, etc.
> 

How we can detect IPI capabilities based on GIC register?

-- 

Best Regards,
Peter Chen
