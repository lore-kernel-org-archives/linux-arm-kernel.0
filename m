From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Dec 2015 13:12:43 +0000
Subject: [PATCH v7 3/3] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <56617243.5050602@arm.com>
References: <1447698128-8490-1-git-send-email-james.morse@arm.com>
 <1447698128-8490-4-git-send-email-james.morse@arm.com>
 <8F6484A9-18B9-4A81-B58D-528D81BC196D@gmail.com>
 <20151127114715.GA25499@e104818-lin.cambridge.arm.com>
 <56617243.5050602@arm.com>
Message-ID: <20151204131242.GG10123@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 11:00:19AM +0000, James Morse wrote:
> On 27/11/15 11:47, Catalin Marinas wrote:
> > With this approach, we could run softirq either on the IRQ stack or on
> > the process stack. One such process is softirqd, so there shouldn't be a
> > problem since its goal is to run softirqs. But do_softirq() may be
> > invoked from other contexts (network stack), I'm not sure what the stack
> > looks like at that point.
> 
> As long as we don't reduce the stack sizes yet - nothing has changed. We
> already run __do_softirq() on other task's stacks via __irq_exit().

Yes, the difference would be that we can run it on the IRQ stack but it
doesn't solve explicit do_softirq() invocations from other contexts.

> > We could just do like x86 and always switch to the IRQ stack before
> > invoking __do_softirq(). I don't think we lose much.
> 
> I will add an extra patch to do this - its not as straight forward as I
> would like - as both ksoftirqd and softirq on irq_stack call
> do_softirq_own_stack() with irq_count == 0.

Yes, so do_softirq_own_stack() would do:

1. Increment and test irq_count
2. If old value was 0, switch to the IRQ stack while saving the previous
   SP
3. Call __do_softirq
5. Decrement irq_count
4. Restore previous SP if irq_count is 0
5. RET

One thing I'm not clear about is whether __do_softirq can be preempted
when executed in process context, it could mess up our stack
assumptions.

-- 
Catalin
