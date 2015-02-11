From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 11 Feb 2015 15:39:51 +0100
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150211111106.GA9154@leverpostej>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150211095339.0a2e4e7b@bbrezillon> <20150211111106.GA9154@leverpostej>
Message-ID: <15161976.Wa237n7AUZ@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 11, 2015 11:11:06 AM Mark Rutland wrote:
> On Wed, Feb 11, 2015 at 08:53:39AM +0000, Boris Brezillon wrote:
> > Hi Mark,
> > 
> > On Tue, 10 Feb 2015 20:48:36 +0000
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > On Tue, Feb 10, 2015 at 03:52:01PM +0000, Boris Brezillon wrote:
> > > > Hi Mark,
> > > > 
> > > > On Tue, 10 Feb 2015 15:36:28 +0000
> > > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > > 
> > > > > Hi Boris,
> > > > > 
> > > > > On Thu, Jan 29, 2015 at 10:33:38AM +0000, Boris Brezillon wrote:
> > > > > > Add documentation for the virtual irq demuxer.
> > > > > > 
> > > > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > > > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > > > > ---
> > > > > >  .../bindings/interrupt-controller/dumb-demux.txt   | 41 ++++++++++++++++++++++
> > > > > >  1 file changed, 41 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > > > > new file mode 100644
> > > > > > index 0000000..b9a7830
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > > > > @@ -0,0 +1,41 @@
> > > > > > +* Virtual Interrupt Demultiplexer
> > > > > > +
> > > > > > +This virtual demultiplexer simply forward all incoming interrupts to its
> > > > > > +enabled/unmasked children.
> > > > > > +It is only intended to be used by hardware that do not provide a proper way
> > > > > > +to demultiplex a source interrupt, and thus have to wake all their children
> > > > > > +up so that they can possibly handle the interrupt (if needed).
> > > > > > +This can be seen as an alternative to shared interrupts when at least one
> > > > > > +of the interrupt children is a timer (and require the irq to stay enabled
> > > > > > +on suspend) while others are not. This will prevent calling irq handlers of
> > > > > > +non timer devices while they are suspended.
> > > > > 
> > > > > This sounds like a DT-workaround for a Linux implementation problem, and
> > > > > I don't think this the right way to solve your problem.
> > > > 
> > > > I understand your concern, but why are you answering while I asked for
> > > > DT maintainers reviews for several days (if not several weeks).
> > > > 
> > > > > 
> > > > > Why does this have to be in DT at all? Why can we not fix the core to
> > > > > handle these details?
> > > > 
> > > > We already discussed that with Rob and Thomas, and hiding such a
> > > > demuxer chip is not an easy task.
> > > > I'm open to any suggestion to do that, though I'd like you (I mean DT
> > > > guys) to provide a working implementation (or at least a viable concept)
> > > > that would silently demultiplex an irq.
> > > > 
> > > > > 
> > > > > I am very much not keen on this binding.
> > > > 
> > > > Yes, but do you have anything else to propose.
> > > > We're experiencing this warning for 2 releases now, and this is time to
> > > > find a solution (even if it's not a perfect one).
> > > 
> > > Thoughts on the patch below?
> > 
> > That's pretty much what I proposed in my first attempt to solve this
> > problem [1] (except for a few things commented below).
> > Anyway, Thomas suggested to go for the "dumb/virt irq demultiplexer"
> > approach instead.
> 
> There is one fundamental difference in that this patch does not require
> drivers to be updated (the new flag is only used internally). Which
> avoids having to patch every single driver that could possibly be used
> in combination with one wanting interrupts during suspend.
> 
> Any used which did not explicitly request with IRQF_NO_SUSPEND will not
> receive interrupts during suspend.
> 
> [...]
> 
> > > +static irqreturn_t __handle_irq_event_percpu(unsigned int irq, struct irqaction *action)
> > > +{
> > > +	/*
> > > +	 * During suspend we must not call potentially unsafe irq handlers.
> > > +	 * See suspend_suspendable_actions.
> > > +	 */
> > > +	if (unlikely(action->flags & IRQF_NO_ACTION))
> > > +		return IRQ_NONE;
> > 
> > Thomas was trying to avoid any new conditional code in the interrupt
> > handling path, that's why I added a suspended_action list in my
> > proposal.
> > Even if your 'unlikely' statement make things better I'm pretty sure it
> > adds some latency.
> 
> I can see that we don't want to add more code here to keep things
> clean/pure, but I find it hard to believe that a single bit test and
> branch (for data that should be hot in the cache) are going to add
> measurable latency to a path that does pointer chasing to get to the
> irqaction in the first place. I could be wrong though, and I'm happy to
> benchmark.

You don't have to.  There are people who care about every single branch
in the interrupt handling hot path.

Really, we can't add any suspend-related checks here (and the majority
of people who care about those latencies don't give a damn about system
suspend).

Rafael
