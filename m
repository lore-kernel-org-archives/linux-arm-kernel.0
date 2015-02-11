From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Feb 2015 11:11:06 +0000
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150211095339.0a2e4e7b@bbrezillon>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <1422527620-8308-4-git-send-email-boris.brezillon@free-electrons.com>
 <20150210153628.GF9432@leverpostej>
 <20150210165201.634bc04b@bbrezillon>
 <20150210204835.GL9432@leverpostej>
 <20150211095339.0a2e4e7b@bbrezillon>
Message-ID: <20150211111106.GA9154@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 08:53:39AM +0000, Boris Brezillon wrote:
> Hi Mark,
> 
> On Tue, 10 Feb 2015 20:48:36 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Tue, Feb 10, 2015 at 03:52:01PM +0000, Boris Brezillon wrote:
> > > Hi Mark,
> > > 
> > > On Tue, 10 Feb 2015 15:36:28 +0000
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > 
> > > > Hi Boris,
> > > > 
> > > > On Thu, Jan 29, 2015 at 10:33:38AM +0000, Boris Brezillon wrote:
> > > > > Add documentation for the virtual irq demuxer.
> > > > > 
> > > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > > > ---
> > > > >  .../bindings/interrupt-controller/dumb-demux.txt   | 41 ++++++++++++++++++++++
> > > > >  1 file changed, 41 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > > > new file mode 100644
> > > > > index 0000000..b9a7830
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > > > @@ -0,0 +1,41 @@
> > > > > +* Virtual Interrupt Demultiplexer
> > > > > +
> > > > > +This virtual demultiplexer simply forward all incoming interrupts to its
> > > > > +enabled/unmasked children.
> > > > > +It is only intended to be used by hardware that do not provide a proper way
> > > > > +to demultiplex a source interrupt, and thus have to wake all their children
> > > > > +up so that they can possibly handle the interrupt (if needed).
> > > > > +This can be seen as an alternative to shared interrupts when at least one
> > > > > +of the interrupt children is a timer (and require the irq to stay enabled
> > > > > +on suspend) while others are not. This will prevent calling irq handlers of
> > > > > +non timer devices while they are suspended.
> > > > 
> > > > This sounds like a DT-workaround for a Linux implementation problem, and
> > > > I don't think this the right way to solve your problem.
> > > 
> > > I understand your concern, but why are you answering while I asked for
> > > DT maintainers reviews for several days (if not several weeks).
> > > 
> > > > 
> > > > Why does this have to be in DT at all? Why can we not fix the core to
> > > > handle these details?
> > > 
> > > We already discussed that with Rob and Thomas, and hiding such a
> > > demuxer chip is not an easy task.
> > > I'm open to any suggestion to do that, though I'd like you (I mean DT
> > > guys) to provide a working implementation (or at least a viable concept)
> > > that would silently demultiplex an irq.
> > > 
> > > > 
> > > > I am very much not keen on this binding.
> > > 
> > > Yes, but do you have anything else to propose.
> > > We're experiencing this warning for 2 releases now, and this is time to
> > > find a solution (even if it's not a perfect one).
> > 
> > Thoughts on the patch below?
> 
> That's pretty much what I proposed in my first attempt to solve this
> problem [1] (except for a few things commented below).
> Anyway, Thomas suggested to go for the "dumb/virt irq demultiplexer"
> approach instead.

There is one fundamental difference in that this patch does not require
drivers to be updated (the new flag is only used internally). Which
avoids having to patch every single driver that could possibly be used
in combination with one wanting interrupts during suspend.

Any used which did not explicitly request with IRQF_NO_SUSPEND will not
receive interrupts during suspend.

[...]

> > +static irqreturn_t __handle_irq_event_percpu(unsigned int irq, struct irqaction *action)
> > +{
> > +	/*
> > +	 * During suspend we must not call potentially unsafe irq handlers.
> > +	 * See suspend_suspendable_actions.
> > +	 */
> > +	if (unlikely(action->flags & IRQF_NO_ACTION))
> > +		return IRQ_NONE;
> 
> Thomas was trying to avoid any new conditional code in the interrupt
> handling path, that's why I added a suspended_action list in my
> proposal.
> Even if your 'unlikely' statement make things better I'm pretty sure it
> adds some latency.

I can see that we don't want to add more code here to keep things
clean/pure, but I find it hard to believe that a single bit test and
branch (for data that should be hot in the cache) are going to add
measurable latency to a path that does pointer chasing to get to the
irqaction in the first place. I could be wrong though, and I'm happy to
benchmark.

It would be possible to go for your list shuffling approach here while
still keeping the flag internal and all the logic hidden away in
kernel/irq/pm.c. I wasn't sure how actions could be manipulated during
suspend, which made me wary of moving them to a separate list.

> > +	return action->handler(irq, action->dev_id);
> > +}
> > +
> >  irqreturn_t
> >  handle_irq_event_percpu(struct irq_desc *desc, struct irqaction *action)
> >  {
> > @@ -140,7 +151,7 @@ handle_irq_event_percpu(struct irq_desc *desc, struct irqaction *action)
> >  		irqreturn_t res;
> >  
> >  		trace_irq_handler_entry(irq, action);
> > -		res = action->handler(irq, action->dev_id);
> > +		res = __handle_irq_event_percpu(irq, action);
> >  		trace_irq_handler_exit(irq, action, res);
> >  
> >  		if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pF enabled interrupts\n",
> > diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> > index 3ca5325..9d8a71f 100644
> > --- a/kernel/irq/pm.c
> > +++ b/kernel/irq/pm.c
> > @@ -43,9 +43,6 @@ void irq_pm_install_action(struct irq_desc *desc, struct irqaction *action)
> >  
> >  	if (action->flags & IRQF_NO_SUSPEND)
> >  		desc->no_suspend_depth++;
> > -
> > -	WARN_ON_ONCE(desc->no_suspend_depth &&
> > -		     desc->no_suspend_depth != desc->nr_actions);
> 
> Hm, actually this WARN_ON was here to detect offending drivers
> (those mixing handler with and without IRQF_NO_SUSPEND on a shared irq).
> IMO, removing it is not such a good idea.

I'm not sure I follow. This patch remove the reason we care, no? 

When going for suspend the patch uses the mismatch to detect whether it
needs to mask out any actions for the desc.

If unexpected interrupts can be generated from devices we're masking the
actions for things could go wrong, but that's also the case with the
demux. So if we need the warning here we should also have one in the
demux to that effect...

Thanks,
Mark.
