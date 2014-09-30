From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 30 Sep 2014 23:49:15 +0200 (CEST)
Subject: [RFT v2 01/24] irqdomain: Introduce new interfaces to support
 hierarchy irqdomains
In-Reply-To: <542A8C5E.3040901@huawei.com>
References: <1411740145-30626-1-git-send-email-jiang.liu@linux.intel.com>
 <1411740145-30626-2-git-send-email-jiang.liu@linux.intel.com>
 <54294F1C.30606@huawei.com>
 <alpine.DEB.2.02.1409291707410.22082@ionos.tec.linutronix.de>
 <542A8C5E.3040901@huawei.com>
Message-ID: <alpine.DEB.2.11.1409302337130.4455@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Sep 2014, Abel wrote:
> On 2014/9/29 23:53, Thomas Gleixner wrote:
> What I suggest is something like:
> 
> for (iter = domain; iter; iter = iter->parent) {
> 	ret = iter->ops->alloc(iter, virq, nr_irqs, arg);
> 	if (ret < 0) {
> 		mutex_unlock(&irq_domain_mutex);
> 		goto out_free_irq_data;
> 	}
> }
> 
> in this way, the core infrastructure guarantees allocating down the
> irqdomain hierarchy, and the implementers of domain_ops->alloc()
> need not to call irq_domain_alloc_irqs_parent() any longer, just do
> the things they have to.

That makes sense. I misunderstood you then.

> > So we cannot define upfront how deep an ack/mask/unmask/... has to be
> > propagated down the chain. This needs a careful consideration in terms
> > of functionality and we want to be able to do performance shortcuts as
> > well.
> > 
> 
> Yes, I got it. And one more thing I concerned is that when hierarchy
> irqdomains is enabled, shouldn't the ack_parent() be called by default
> by the irqchip->irq_ack() of each domain to ensure all the domains in
> the delivery path ack this interrupt?

In the pure theory of design, yes. But that will cause pointless
overhead on particular systems.

On a particular system the ack of the top level domain C, i.e. the one
which is facing the device and is handled by the core irq flow
handler, might be enough because B does not require an ack and A is
implicitely acked by iret or some other magic instruction in the low
level entry path. And because we know that C can only be on top of B
and B is on top of A we want the flexibility to avoid going down the
full chain for nothing in the interrupt hot path.

So yes, in theory it should go down all levels, but in practice we
dont want to enforce it :)

Thanks,

	tglx
