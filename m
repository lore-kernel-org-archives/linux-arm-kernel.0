From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Wed, 2 Mar 2016 17:29:54 +0000
Subject: [PATCH] Change the spin_lock/unlock_irq interface in
 proc_alloc_inum() function
In-Reply-To: <56D688FC.9020202@huawei.com>
References: <1456886879-28128-1-git-send-email-majun258@huawei.com>
 <20160302030941.GH17997@ZenIV.linux.org.uk>
 <56D688FC.9020202@huawei.com>
Message-ID: <20160302172954.GI17997@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 02:32:28PM +0800, majun (F) wrote:

> Sorry,I made a wrong example for this problem.
> I want to say this interface may change the irq status after this function
> be called.

It can't - either it's called with irqs enabled, in which case it returns
the same way, or it's called with irqs disabled, in which case it's a trouble
waiting to happen as soon as the allocation there (or in proc_mkdir(), etc.)
happens to block and failure to restore irq state is the least of your
concerns, because when you return from schedule() you *will* have irq enabled,
no matter what.

Take a look at __schedule():
...
        local_irq_disable();
        rcu_note_context_switch();

        /*
         * Make sure that signal_pending_state()->signal_pending() below
         * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
         * done by the caller to avoid the race with signal_wake_up().
         */
        smp_mb__before_spinlock();
        raw_spin_lock(&rq->lock);
...
                rq = context_switch(rq, prev, next); /* unlocks the rq */
and in context_switch() (right after switch_to()) we call finish_task_switch(),
which calls finish_lock_switch(), which does raw_spin_unlock_irq(&rq->lock),
which does local_irq_enable().

And no, it doesn't save the irq state anywhere - both disable and enable
are unconditional.  schedule() always returns with irqs enabled.

Don't call blocking things with irqs disabled.  If design of some of your
drivers depends on being able to do that, sorry, but it'll have to be changed.
