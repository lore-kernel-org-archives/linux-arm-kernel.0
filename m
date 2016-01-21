From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 21 Jan 2016 08:06:57 -0800
Subject: RCU lockup? (was: Re: [PATCH v2 tip/core/rcu 10/14] rcu: Don't
 redundantly disable irqs in rcu_irq_{enter,exit}())
In-Reply-To: <CAMuHMdWz0U-uUs1Ox_13YOA0AfVPTx24nTA3=hx5Z5kcHr8SbQ@mail.gmail.com>
References: <CAMuHMdWz0U-uUs1Ox_13YOA0AfVPTx24nTA3=hx5Z5kcHr8SbQ@mail.gmail.com>
Message-ID: <20160121160657.GW3818@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 02:22:56PM +0100, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Thu, Dec 10, 2015 at 12:10 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > This commit replaces a local_irq_save()/local_irq_restore() pair with
> > a lockdep assertion that interrupts are already disabled.  This should
> > remove the corresponding overhead from the interrupt entry/exit fastpaths.
> >
> > This change was inspired by the fact that Iftekhar Ahmed's mutation
> > testing showed that removing rcu_irq_enter()'s call to local_ird_restore()
> > had no effect, which might indicate that interrupts were always enabled
> > anyway.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  include/linux/rcupdate.h   |  4 ++--
> >  include/linux/rcutiny.h    |  8 ++++++++
> >  include/linux/rcutree.h    |  2 ++
> >  include/linux/tracepoint.h |  4 ++--
> >  kernel/rcu/tree.c          | 32 ++++++++++++++++++++++++++------
> >  5 files changed, 40 insertions(+), 10 deletions(-)
> 
> This commit (7c9906ca5e582a773fff696975e312cef58a7386) is triggering lock ups
> during boot on r8a7791/koelsch (dual Cortex A15). Probably this commit does not
> contain the real bug, but a symptom.

On the off-chance that it is related, here is Ding Tianhong's patch
that addressed some lockups:

http://www.eenyhelp.com/patch-rfc-locking-mutexes-dont-spin-owner-when-wait-list-not-null-help-215929641.html

Does that help in your case?

> Unfortunately I cannot reproduce it with CONFIG_PROVE_RCU=y.
> 
> I started seeing the issue when disabling an innocent option in
> shmobile_defconfig. I tracked it down to the removal of an unused C function,
> containing hardware support for another system. Replacing the C function by
> a dummy function with the right number of "asm("nop")"s (depending on kernel
> version and/or kernel config, sigh) made the issue go away.
> Adding or removing nops makes the issue reappear, and has some impact on
> how early the issue happens (sometimes as late as early userspace).
> Adding a multiple of 16 nops has no impact.
> So it looks like something that should be cacheline-aligned isn't...

The other possibility is that it is timing related.  Either way, fun
to find...

> CONFIG_TREE_RCU=y
> 
> Do you have a suggestion?

Only trying Ding's patch...

							Thanx, Paul
