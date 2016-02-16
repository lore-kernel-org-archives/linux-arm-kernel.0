From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 16 Feb 2016 11:36:44 -0800
Subject: Writes, smp_wmb(), and transitivity?
In-Reply-To: <CA+55aFxaQEvDrzecmZUQ5QfKzU4ei6E-+NpsW5hYp3ouaLP98g@mail.gmail.com>
References: <20160215175825.GA15878@linux.vnet.ibm.com>
 <CA+55aFxaQEvDrzecmZUQ5QfKzU4ei6E-+NpsW5hYp3ouaLP98g@mail.gmail.com>
Message-ID: <20160216193644.GV6719@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 10:59:08AM -0800, Linus Torvalds wrote:
> On Mon, Feb 15, 2016 at 9:58 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > Two threads:
> >
> >         int a, b;
> >
> >         void thread0(void)
> >         {
> >                 WRITE_ONCE(a, 1);
> >                 smp_wmb();
> >                 WRITE_ONCE(b, 2);
> >         }
> >
> >         void thread1(void)
> >         {
> >                 WRITE_ONCE(b, 1);
> >                 smp_wmb();
> >                 WRITE_ONCE(a, 2);
> >         }
> >
> >         /* After all threads have completed and the dust has settled... */
> >
> >         BUG_ON(a == 1 && b == 1);
> 
> So the more I look at that kind of litmus test, the less I think that
> we should care, because I can't come up with a scenario in where that
> kind of test makes sense. without even a possibility of any causal
> relationship between the two, I can't say why we'd ever care about the
> ordering of the (independent) writes to the individual variables.
> 
> If somebody can make up a causal chain, things differ. But as long as
> all the CPU's are just doing locally ordered writes, I don't think we
> need to care about a global store ordering.

Works for me!  (Yes, I can artificially generate a use case for this
thing, but all the ones I have come up with have some better and more
sane way to get the job done.  So I completely agree with your not caring
about it.)

So for transitivity, we focus on causal chains, where one task writes
to some variable that the next task reads.

In addition, if all threads use full memory barriers throughout, as in
smp_mb(), then full ordering is of course provided regardless of the
pattern of reads and writes.

							Thanx, Paul
