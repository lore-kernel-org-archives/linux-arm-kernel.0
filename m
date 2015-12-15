From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 15 Dec 2015 17:56:50 +0100
Subject: [BISECTED] rcu_sched self-detected stall since 3.17
In-Reply-To: <20151201130404.GL3816@twins.programming.kicks-ass.net>
References: <564F3DCA.1080907@arm.com>
 <20151201130404.GL3816@twins.programming.kicks-ass.net>
Message-ID: <20151215165650.GA13604@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry again for the huge delay.

And all I can say is that I am all confused.

On 12/01, Peter Zijlstra wrote:
>
> On Fri, Nov 20, 2015 at 03:35:38PM +0000, Vladimir Murzin wrote:
> > commit 743162013d40ca612b4cb53d3a200dff2d9ab26e
> > Author: NeilBrown <neilb@suse.de>
> > Date:   Mon Jul 7 15:16:04 2014 +1000

That patch still looks correct to me.

> > and if I apply following diff I don't see stalls anymore.
> >
> > diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> > index a104879..2d68cdb 100644
> > --- a/kernel/sched/wait.c
> > +++ b/kernel/sched/wait.c
> > @@ -514,9 +514,10 @@ EXPORT_SYMBOL(bit_wait);
> >
> >  __sched int bit_wait_io(void *word)
> >  {
> > +       io_schedule();
> > +
> >         if (signal_pending_state(current->state, current))
> >                 return 1;
> > -       io_schedule();
> >         return 0;
> >  }
> >  EXPORT_SYMBOL(bit_wait_io);

I can't understand why this change helps. But note that it actually removes
the signal_pending_state() check from bit_wait_io(), current->state is always
TASK_RUNNING after return from schedule(), signal_pending_state() will always
return zero.

This means that after this change wait_on_page_bit_killable() will spin in a
busy-wait loop if the caller is killed.

> The reason this is broken is that schedule() will no-op when there is a
> pending signal, while raising a signal will also issue a wakeup.

But why this is wrong? We should notice signal_pending_state() on the next
iteration.

> Thus the right thing to do is check for the signal state after,

I think this check should work on both sides. The only difference is that
you obviously can't use current->state after schedule().

I still can't understand the problem.

Oleg.
