From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 4 Dec 2014 01:03:10 +0100 (CET)
Subject: [PATCH 03/12] irqchip: gic: define register_routable_domain_ops
 conditional
In-Reply-To: <547F5EBD.6040705@arm.com>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
 <1417565531-4507-4-git-send-email-stefan@agner.ch>
 <5174649.NxPq80uDz8@wuerfel> <alpine.DEB.2.11.1412031303000.16275@nanos>
 <8eccedc781df2636a132dae449cbe774@agner.ch>
 <547F5EBD.6040705@arm.com>
Message-ID: <alpine.DEB.2.11.1412040057090.16275@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Dec 2014, Marc Zyngier wrote:
> On 03/12/14 17:28, Stefan Agner wrote:
> > On 2014-12-03 14:04, Thomas Gleixner wrote:
> >> The shared interrupts are allocated through the router domain which
> >> decides whether the interrupt can be assigned to a particular core or
> >> not. If it can be assigned it allocates the corresponding interrupt in
> >> the parent domain, sets up the routing and everything just works.
> > 
> > What do you mean by the shared state in the drawing above? Currently, I
> > check whether a interrupt is already used by the other core by reading
> > the register (do this configuration register reflect the "shared state"
> > in your drawing?).
> 
> I think that is basically it. It should only be the register that
> decides on the actual routing. BTW, how do you arbitrate between
> concurrent accesses to this register? Or is only the A5 allowed to
> change it?

What I meant with 'shared state' is basically the configuration
register space. Plus depending on the mechanism you want to use for
correlating the routing between the A5 and the M4 some shared memory
state, locking, IPC or whatever you need for this.
 
> >> http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/log/?h=irq/irqdomain-arm
> >>
> > 
> > Thanks for the link. So my work would involve to support domain
> > hierarchy for NVIC (proper irq_domain_ops, introduce arm,routable-irqs
> > property, anything else?) and then make use of the hierarchy code in my
> > MSCM driver like for instance the mtk-sysirq driver...?
> 
> I don't think we need the arm,routable-irq property at all, and I'm
> looking at refactoring the crossbar thingy to remove most of its
> entanglement with the GIC.
> 
> All you need to know is the range of interrupts you're allowed to
> request through the "routable" domain. The inner-most irqchip shouldn't
> even know about it (after all, they are just wires coming in). It should
> be the duty of the outer-most irqchip (the "router") to generate the
> correct request to the GIC/NVIC. So all the knowledge should be at the
> router level.
> 
> The mtk-sysrq code is indeed a good example of what you can do.

The gic-v2m MSI stuff is probably helpful as well.
 
> > What is the state of the IRQ domain hierarchy, when will it go upstream?
> 
> Scheduled for 3.19, if everything goes according to plan. Don't think we
> can go back anyway... ;-)

Indeed. That would be a major headache...

Thanks,

	tglx
