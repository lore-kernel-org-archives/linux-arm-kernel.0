From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Oct 2016 20:14:48 +0100
Subject: Disabling an interrupt in the handler locks the system up
In-Reply-To: <580A60ED.3030307@free.fr>
References: <580A4460.2090306@free.fr>
 <a79e2d2c-8ec8-744f-50fb-8c39216aa23e@arm.com>
 <580A60ED.3030307@free.fr>
Message-ID: <20161021201448.3f4a0a7a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Oct 2016 20:39:41 +0200
Mason <slash.tmp@free.fr> wrote:

> On 21/10/2016 19:46, Marc Zyngier wrote:
> 
> > On 21/10/16 17:37, Mason wrote:
> >  
> >> On my platform, one HW block pulls the interrupt line high
> >> as long as it remains idle, and low when it is busy.
> >>
> >> The device tree node is:
> >>
> >> 		test at 22222 {
> >> 			compatible = "vendor,testme";
> >> 			interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
> >> 		};  
> > 
> > I assume that this is for the sake of the discussion, and that you do
> > not actually intend to put together such a monstrosity.  
> 
> It's just missing a reg properties to be a valid node, right?

If connecting a device that signals its interrupt as level low to an
input line configured as level high doesn't strike you as a major
issue, nothing will. At that point, you can put anything you want in
your DT.

> 
> >> I wrote a minimal driver which registers the irq.
> >> And in the interrupt handler, I disable said irq.
> >>
> >> Since the irq is IRQ_TYPE_LEVEL_HIGH, it will fire as soon as
> >> it is registered (because the block is idle).
> >>
> >> Here is the code I've been running, request_irq doesn't return.  
> > 
> > [...]
> >   
> >> And here's what I get when I try to load the module:
> >> (I'm using the default CONFIG_RCU_CPU_STALL_TIMEOUT=21)  
> > 
> > [...]
> >   
> >> Are we not supposed to disable the irq in the handler?  
> > 
> > You can. It then depends on what your interrupt controller does to
> > actually ensure that the interrupt is disabled. Only you can trace it on
> > your HW to find out.  
> 
> I'm using an upstream driver on v4.9-rc1
> 
> http://lxr.free-electrons.com/source/drivers/irqchip/irq-tango.c
> 
> Given that the system locks up, is it possible there is a bug
> in the driver?

That's possible.

> Which call-back handles enabling/disabling interrupts?

How about irq_unmask/irq_mask?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
