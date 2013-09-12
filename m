From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 13 Sep 2013 00:12:24 +0200 (CEST)
Subject: [RFC PATCH 1/4] DRIVERS: IRQCHIP: Add crossbar irqchip driver
In-Reply-To: <alpine.DEB.2.02.1309122334370.4089@ionos.tec.linutronix.de>
References: <1379000351-15672-1-git-send-email-r.sricharan@ti.com>
 <1379000351-15672-2-git-send-email-r.sricharan@ti.com>
 <20130912205417.GA539@radagast>
 <alpine.DEB.2.02.1309122334370.4089@ionos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.02.1309130010110.4089@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Sep 2013, Thomas Gleixner wrote:

> On Thu, 12 Sep 2013, Felipe Balbi wrote:
> 
> > On Thu, Sep 12, 2013 at 09:09:08PM +0530, Sricharan R wrote:
> > > +unsigned int crossbar_request_irq(struct irq_data *d)
> > > +{
> > > +	int cb_no = d->hwirq;
> > > +	int virq = allocate_free_irq(cb_no);
> > > +	void *irq = &cb->crossbar_map[cb_no].hwirq;
> > > +	int err;
> > > +
> > > +	err = request_threaded_irq(virq, crossbar_irq, NULL,
> > > +				   0, "CROSSBAR", irq);
> > 
> > this is wrong, why don't you just set crossbar up as a chained handler.
> 
> That's just a detail, which does not solve the underlying problem of
> the crossbar -> GIC mapping.

And actually the thing is the other way round:

GIC distributes to crossbar, so the underlying GIC irq would be the
chained handler.

Still does not solve the setup/request_irq issue.

Thanks,

	tglx
