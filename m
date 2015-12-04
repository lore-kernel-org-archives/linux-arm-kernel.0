From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Dec 2015 18:40:39 +0000
Subject: [PATCH v8 4/4] arm64: switch to irq_stack during softirq
In-Reply-To: <5661A5B0.3080504@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-5-git-send-email-james.morse@arm.com>
 <20151204140119.GL10123@e104818-lin.cambridge.arm.com>
 <5661A5B0.3080504@arm.com>
Message-ID: <20151204184038.GQ10123@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 02:39:44PM +0000, James Morse wrote:
> On 04/12/15 14:01, Catalin Marinas wrote:
> > On Fri, Dec 04, 2015 at 11:02:28AM +0000, James Morse wrote:
> >> +ENTRY(__do_softirq_on_irqstack)
> >> +	push	x19, lr
> >> +	push	x25, x26
> >> +
> >> +	irq_stack_entry lr
> >> +
> >> +	/* irq_stack_entry leaves irq_count in x25 */
> >> +	ldr	x1, [x25]
> >> +	add	x1, x1, #1
> >> +	str	x1, [x25]
> >> +
> >> +	bl	__do_softirq
> >> +
> >> +	ldr	x1, [x25]
> >> +	sub	x1, x1, #1
> >> +	str	x1, [x25]
> >> +
> >> +	irq_stack_exit
> >> +
> >> +	pop x25, x26
> >> +	pop x19, lr
> >> +	ret
> >> +ENDPROC(__do_softirq_on_irqstack)
> > 
> > I was thinking of doing do_softirq_own_stack() entirely in assembly
> > without the need to check for on_irq_stack() check in C, just a test of
> > the irq_count value.
> 
> I tried that, but couldn't get it to work - maybe I'm missing a trick:
> 
> There are at least two ways into do_softirq_own_stack():
> el1_irq() -> __irq_exit() -> do_softirq_own_stack(),
> as well as:
> cpu_switch_to(ksoftirqd) -> do_softirq_own_stack()

If it was only these two cases, I think it would have been easier as in
both scenarios the stack is nearly empty. But there is another call to
do_softirq() from netif_rx_ni() and I'm not sure how the stack looks
like at this point. That's why I suggested that we always switch to a
different stack for softirqs.

> In both cases irq_count == 0 because do_softirq_own_stack() is where we
> update irq_count [0]. I can only see two ways to tell them apart,
> increment irq_count in el1_irq(), (which we don't like), or have that
> bounds checking.

I now see the problem. Looking at x86, they increment irq_count for
every interrupt (as per Jungseok's early patch).

> (We could increase hardirq_count() in el?_irq(), which would mean
> in_irq()/in_interrupt() always returns true when on the irq_stack, which
> would stop softirqs being processed here... but that is a fairly
> significant change in behaviour.)

So I think the options are (a) irq_count increment in el?_irq or (b)
check the current stack before switching. I'll think about it until
Monday ;).

BTW, at which point does in_irq() return true for an interrupt (and when
it ceases to do so)?

-- 
Catalin
