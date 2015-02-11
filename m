From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 11 Feb 2015 16:51:36 +0100
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150211151237.GN9154@leverpostej>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <2437801.56xPyk3atd@vostro.rjw.lan> <20150211151237.GN9154@leverpostej>
Message-ID: <1487331.cgC9j5u0aF@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 11, 2015 03:12:38 PM Mark Rutland wrote:
> On Wed, Feb 11, 2015 at 03:17:20PM +0000, Rafael J. Wysocki wrote:
> > On Wednesday, February 11, 2015 02:43:45 PM Mark Rutland wrote:
> > > [...]
> > > 
> > > > > > > > +static irqreturn_t __handle_irq_event_percpu(unsigned int irq, struct irqaction *action)
> > > > > > > > +{
> > > > > > > > +	/*
> > > > > > > > +	 * During suspend we must not call potentially unsafe irq handlers.
> > > > > > > > +	 * See suspend_suspendable_actions.
> > > > > > > > +	 */
> > > > > > > > +	if (unlikely(action->flags & IRQF_NO_ACTION))
> > > > > > > > +		return IRQ_NONE;
> > > > > > > 
> > > > > > > Thomas was trying to avoid any new conditional code in the interrupt
> > > > > > > handling path, that's why I added a suspended_action list in my
> > > > > > > proposal.
> > > > > > > Even if your 'unlikely' statement make things better I'm pretty sure it
> > > > > > > adds some latency.
> > > > > > 
> > > > > > I can see that we don't want to add more code here to keep things
> > > > > > clean/pure, but I find it hard to believe that a single bit test and
> > > > > > branch (for data that should be hot in the cache) are going to add
> > > > > > measurable latency to a path that does pointer chasing to get to the
> > > > > > irqaction in the first place. I could be wrong though, and I'm happy to
> > > > > > benchmark.
> > > > > 
> > > > > Again, I don't have enough experience to say this is (or isn't)
> > > > > impacting irq handling latency, I'm just reporting what Thomas told me.
> > > > > 
> > > > > > 
> > > > > > It would be possible to go for your list shuffling approach here while
> > > > > > still keeping the flag internal and all the logic hidden away in
> > > > > > kernel/irq/pm.c. I wasn't sure how actions could be manipulated during
> > > > > > suspend, which made me wary of moving them to a separate list.
> > > > > 
> > > > > Moving them to a temporary list on suspend and restoring them on
> > > > > resume should not be a problem.
> > > > > The only drawback I see is that actions might be reordered after the
> > > > > first resume (anyway, relying on shared irq action order is dangerous
> > > > > IMHO).
> > > > 
> > > > We considered doing that too and saw some drawbacks (in addition to the
> > > > reordering of actions you've mentioned).  It added just too much complexity
> > > > to the IRQ suspend-resume code.
> > > > 
> > > > I, personally, would be fine with adding an IRQ flag to silence the
> > > > warning mentioned by Alexandre.  Something like IRQD_TIMER_SHARED that would
> > > > be set automatically if someone requested IRQF_TIMER | IRQF_SHARED.
> > > > 
> > > > Thoughts?
> > > 
> > > Even if the timer driver does that, we still require the other handlers
> > > sharing the line to do the right thing across suspend, no? So either
> > > their actions need to be masked at suspend time, or the handlers need to
> > > detect when they're called during suspend and return early.
> > 
> > Well, the issue at hand is about things that share an IRQ with a timer AFAICS.
> > 
> > That is odd enough already and I'd say everyone in that situation needs to
> > be prepared to take the pain (including having to check if the device is not
> > suspended in their interrupt handlers).
> 
> IMO if the line is shared it would be ideal for the core to mask the
> action (as that's essentially the behaviour when the line isn't shared
> with an IRQF_NO_SUSPEND action), but that's not esseential if a flag is
> OK for now.
> 
> > And quite frankly they need to do that already, because we've never suspended
> > timer IRQs.
> 
> This is a very good point.
> 
> > > So for the flag at request time approach to work, all the drivers using
> > > the interrupt would have to flag they're safe in that context.
> > 
> > Something like IRQF_"I can share the line with a timer" I guess?  That wouldn't
> > hurt and can be checked at request time even.
> 
> I guess that would have to imply IRQF_SHARED, so we'd have something
> like:
> 
> IRQF_SHARED_SUSPEND_OK - This handler is safe to call spuriously during
> 			 suspend in the case the line is shared. The
> 			 handler will not access unavailable hardware
> 			 or kernel infrastructure during this period.
> 
> #define __IRQF_SUSPEND_SPURIOUS		0x00040000
> #define	IRQF_SHARED_SUSPEND_OK		(IRQF_SHARED | __IRQF_SUSPEND_SPURIOUS)

What about

#define __IRQF_TIMER_SIBLING_OK	0x00040000
#define	IRQF_SHARED_TIMER_OK	(IRQF_SHARED | __IRQF_TIMER_SIBLING_OK)

The "suspend" part is kind of a distraction to me here, because that really
only is about sharing an IRQ with a timer and the "your interrupt handler
may be called when the device is suspended" part is just a consequence of that.

So IMO it's better to have "TIMER" in the names to avoid encouraging people to
abuse this for other purposes not related to timers.

Rafael
