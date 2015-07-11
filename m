From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 11 Jul 2015 10:02:51 +0200 (CEST)
Subject: [PATCH V3] trace/events: add chip name and hwirq to irq entry
 tracepoint
In-Reply-To: <2686ba70b03b3e16c94f93052aa56703.squirrel@www.codeaurora.org>
References: <1435162650-32266-1-git-send-email-ankgupta@codeaurora.org>
 <20150624124227.1cddbbac@gandalf.local.home>
 <alpine.DEB.2.11.1507052326100.3916@nanos>
 <2686ba70b03b3e16c94f93052aa56703.squirrel@www.codeaurora.org>
Message-ID: <alpine.DEB.2.11.1507110953140.17353@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Jul 2015, Ankit Gupta wrote:
> > On Wed, 24 Jun 2015, Steven Rostedt wrote:
> >> > +
> >> > +#define show_chip_name(irq)					\
> >> > +	(irq_get_irq_data(irq)					\
> >> > +			 ? irq_get_irq_data(irq)->chip->name	\
> >> > +			 : "NULL")
> >> > +
> >> > +#define show_hwirq(irq)						\
> >> > +	(irq_get_irq_data(irq)					\
> >> > +			 ? irq_get_irq_data(irq)->hwirq		\
> >> > +			 : -ENODEV)
> >>
> >> Note these magic functions will only be useful for the tracefs reads of
> >> the trace files. Userspace tools that extract the data (like perf and
> >> trace-cmd), will have no idea of how to parse it.
> >>
> >> I'm not against doing this, but I'm just letting you know what the
> >> effect of this change will be.
> >
> > What's worse is, that they are racy against a concurrent teardown of
> > the interrupt. Not a good idea ...
> >
> 
> Agree, I'll save the chip-name and hwirq in the struct. This technique
> using the same macros to save the chip-name and hwirq in the struct also
> works well with trace-cmd.

Though I really doubt that this is the proper way to go. Why do you want
to store redundant information on every tracepoint?

That does not make any sense.

What we really want is an interface to query the interrupt association
(linux interrupt number, chip, domain, hwirq, ...) in one go when the
tracer starts and have tracepoints which keep track of irq setup and
teardown.

That way we keep the hotpath tracepoints tiny and the analysis tools
can create rich tracepoints for postprocessing. That's how perf is
working as well.

Thanks,

	tglx
