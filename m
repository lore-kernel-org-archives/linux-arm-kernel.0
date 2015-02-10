From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Feb 2015 15:41:57 +0000
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <54D95DB8.9010308@codeaurora.org>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <54D95DB8.9010308@codeaurora.org>
Message-ID: <20150210154157.GL8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 09, 2015 at 05:24:08PM -0800, Stephen Boyd wrote:
> On 02/05/15 08:11, Russell King - ARM Linux wrote:
> > On Thu, Feb 05, 2015 at 06:29:18AM -0800, Paul E. McKenney wrote:
> >> Works for me, assuming no hidden uses of RCU in the IPI code.  ;-)
> > Sigh... I kind'a new it wouldn't be this simple.  The gic code which
> > actually raises the IPI takes a raw spinlock, so it's not going to be
> > this simple - there's a small theoretical window where we have taken
> > this lock, written the register to send the IPI, and then dropped the
> > lock - the update to the lock to release it could get lost if the
> > CPU power is quickly cut at that point.
> 
> Hm.. at first glance it would seem like a similar problem exists with
> the completion variable. But it seems that we rely on the call to
> complete() fom the dying CPU to synchronize with wait_for_completion()
> on the killing CPU via the completion's wait.lock.
> 
> void complete(struct completion *x)
> {
>         unsigned long flags;
> 
>         spin_lock_irqsave(&x->wait.lock, flags);
>         x->done++;
>         __wake_up_locked(&x->wait, TASK_NORMAL, 1);
>         spin_unlock_irqrestore(&x->wait.lock, flags);
> }
> 
> and
> 
> static inline long __sched
> do_wait_for_common(struct completion *x,
>                   long (*action)(long), long timeout, int state)
>                         ...
> 			spin_unlock_irq(&x->wait.lock);
> 			timeout = action(timeout);
> 			spin_lock_irq(&x->wait.lock);
> 
> 
> so the power can't really be cut until the killing CPU sees the lock
> released either explicitly via the second cache flush in cpu_die() or
> implicitly via hardware.

Correct - so the caller of wait_for_completion_timeout() needs to
re-acquire the cache line after the complete() in order to return
successfully - which means that the spin_unlock_irqrestore() on the
dying CPU _must_ have become visible to other observers for the
requesting CPU to proceed.

> Maybe we can do the same thing here by using a
> spinlock for synchronization between the IPI handler and the dying CPU?
> So lock/unlock around the IPI sending from the dying CPU and then do a
> lock/unlock on the killing CPU before continuing.

It would be nice, but it means exporting irq_controller_lock from irq_gic.c.
It's doable, but it's really not nice - it creates a layering issue, buy
making arch/arm/kernel/smp.c depend on symbols exported from
drivers/irqchip/irq-gic.c.

> > Also, we _do_ need the second cache flush in place to ensure that the
> > unlock is seen to other CPUs.
> >
> > We could work around that by taking and releasing the lock in the IPI
> > processing function... but this is starting to look less attractive
> > as the lock is private to irq-gic.c.
> 
> With Daniel Thompson's NMI fiq patches at least the lock would almost
> always be gone, except for the bL switcher users. Another solution might
> be to put a hotplug lock around the bL switcher code and then skip
> taking the lock in gic_raise_softirq() if the IPI is our special hotplug
> one. Conditional locking is pretty ugly though, so perhaps this isn't
> such a great idea.

I haven't even thought about the implications of that yet. :)  We need to
fix the already existing in-kernel code before we consider not-yet-merged
code.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
