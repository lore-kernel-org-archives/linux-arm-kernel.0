From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Dec 2015 13:47:54 +0000
Subject: [PATCH v8 3/4] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <20151204134636.GI10123@e104818-lin.cambridge.arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-4-git-send-email-james.morse@arm.com>
 <20151204134636.GI10123@e104818-lin.cambridge.arm.com>
Message-ID: <20151204134753.GJ10123@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 01:46:36PM +0000, Catalin Marinas wrote:
> On Fri, Dec 04, 2015 at 11:02:27AM +0000, James Morse wrote:
> > +/*
> > + * do_softirq_own_stack() is called from irq_exit() before __do_softirq()
> > + * re-enables interrupts, at which point we may re-enter el?_irq(). We
> > + * increase irq_count here so that el1_irq() knows that it is already on the
> > + * irq stack.
> > + *
> > + * Called with interrupts disabled, so we don't worry about moving cpu, or
> > + * being interrupted while modifying irq_count.
> > + *
> > + * This function doesn't actually switch stack.
> > + */
> > +void do_softirq_own_stack(void)
> > +{
> > +	int cpu = smp_processor_id();
> > +
> > +	WARN_ON_ONCE(!irqs_disabled());
> > +
> > +	if (on_irq_stack(current_stack_pointer, cpu)) {
> > +		IRQ_COUNT()++;
> > +		__do_softirq();
> > +		IRQ_COUNT()--;
> > +	} else {
> > +		__do_softirq();
> > +	}
> 
> Following your and my reply on the previous series, should we not
> _always_ switch to the irqstack here?

Ah, sorry, I now noticed that this is done in patch 4.

-- 
Catalin
