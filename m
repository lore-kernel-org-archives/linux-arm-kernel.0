From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 8 Aug 2016 14:48:42 +0100
Subject: [PATCH 1/1] irqchip: irq-gic: forward SGI to itself for
 cortex-a7 single core
In-Reply-To: <20160808132847.GB17680@shlinux2>
References: <1470642594-30455-1-git-send-email-peter.chen@nxp.com>
 <20160808105026.GA12649@leverpostej>
 <HE1PR04MB1450C6BE844A31C95CEE3BE18B1B0@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <20160808130754.GB12649@leverpostej>
 <20160808132847.GB17680@shlinux2>
Message-ID: <20160808134842.GE12649@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2016 at 09:28:47PM +0800, Peter Chen wrote:
> On Mon, Aug 08, 2016 at 02:07:54PM +0100, Mark Rutland wrote:
> > I see that for arm64 we have:
> > 
> > static inline bool arch_irq_work_has_interrupt(void)
> > {
> > 	return !!__smp_cross_call;
> > }
> > 
> > Could we do similarly for ARM, and ony register gic_raise_softirq if
> > we have non-zero SGI targets?
> > 
> > If I've understood correctly, that would make things behave as they do
> > for UP on you system.

[...]

> > If self-IPI is necessary, then this would be up to the GIC code to
> > solve.
> > 
> > For that case, it would be nicer if we could detect whether this was
> > necessary based on the GIC registers alone. That way we handle the
> > various ways this can be integrated, aren't totally relient on the DT,
> > work in VMs, etc.
> 
> How we can detect IPI capabilities based on GIC register?

Check the mask associated with SGIs, as we do for gic_get_cpumask(). If
this is zero, we have a non-multiprocessor GIC (or one that's otherwise
broken), and can't do SGI in the usual way.

However, it only makes sense to do this if self-IPI is truly a
necessity. Given there are other interrupt controllers that can't do
self-IPI, avoiding self-IPI in general would be a better strategy,
avoiding churn in each and every driver...

Thanks,
Mark.
