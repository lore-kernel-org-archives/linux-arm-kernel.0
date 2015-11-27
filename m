From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Nov 2015 11:47:16 +0000
Subject: [PATCH v7 3/3] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <8F6484A9-18B9-4A81-B58D-528D81BC196D@gmail.com>
References: <1447698128-8490-1-git-send-email-james.morse@arm.com>
 <1447698128-8490-4-git-send-email-james.morse@arm.com>
 <8F6484A9-18B9-4A81-B58D-528D81BC196D@gmail.com>
Message-ID: <20151127114715.GA25499@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 11:26:08PM +0900, Jungseok Lee wrote:
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
> > +		per_cpu(irq_count, cpu)++;
> > +		__do_softirq();
> > +		per_cpu(irq_count, cpu)--;
> > +	} else {
> > +		__do_softirq();
> > +	}
> > +}
> 
> I'm really interested in feedbacks from other folks since, as you know
> well, softirq could be handled using a process stack under this design.

With this approach, we could run softirq either on the IRQ stack or on
the process stack. One such process is softirqd, so there shouldn't be a
problem since its goal is to run softirqs. But do_softirq() may be
invoked from other contexts (network stack), I'm not sure what the stack
looks like at that point.

We could just do like x86 and always switch to the IRQ stack before
invoking __do_softirq(). I don't think we lose much.

-- 
Catalin
