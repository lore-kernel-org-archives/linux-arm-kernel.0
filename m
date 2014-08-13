From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Aug 2014 16:05:40 +0100
Subject: [PATCH v4] irqchip: gic: Allow gic_arch_extn hooks to call
 into scheduler
In-Reply-To: <20140813145526.GF32301@codeaurora.org>
References: <1407938238-21413-1-git-send-email-sboyd@codeaurora.org>
 <20140813142257.GK30401@n2100.arm.linux.org.uk>
 <20140813145526.GF32301@codeaurora.org>
Message-ID: <20140813150540.GL30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 07:55:26AM -0700, Stephen Boyd wrote:
> On 08/13, Russell King - ARM Linux wrote:
> > On Wed, Aug 13, 2014 at 06:57:18AM -0700, Stephen Boyd wrote:
> > > Commit 1a6b69b6548c (ARM: gic: add CPU migration support,
> > > 2012-04-12) introduced an acquisition of the irq_controller_lock
> > > in gic_raise_softirq() which can lead to a spinlock recursion if
> > > the gic_arch_extn hooks call into the scheduler (via complete()
> > > or wake_up(), etc.). This happens because gic_arch_extn hooks are
> > > normally called with the irq_controller_lock held and calling
> > > into the scheduler may cause us to call smp_send_reschedule()
> > > which will grab the irq_controller_lock again. Here's an example
> > > from a vendor kernel (note that the gic_arch_extn hook code here
> > > isn't actually in mainline):
> > 
> > Here's a question: why would you want to call into the scheduler from
> > the gic_arch_extn code?
> 
> In this case we want to send a message to another processor when
> an interrupt is enabled that's only a wakeup interrupt in certain
> low power states. It's done sort of indirectly, but basically we
> block that low power state from being entered so we can ensure
> that the interrupt wakes us up from a lighter version of suspend.

No, that's not the correct answer for the question I asked.  I did not
ask "why would you want to call into the IRQ code from the scheduler".
I asked "why would you want to call into the scheduler from the
gic_arch_extn code?"

That's a completely different question.  Let me rephrase to try and get
an answer to my question: Why are you calling complete() or wake_up()
from the gic_arch_extn code?

> > static int __disable_irq_nosync(unsigned int irq)
> > {
> >         unsigned long flags;
> >         struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
> 
> We got the lock here.

Yes, Daniel pointed that out, which makes this fine of course.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
