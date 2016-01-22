From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Fri, 22 Jan 2016 12:44:12 -0800
Subject: RCU lockup? (was: Re: [PATCH v2 tip/core/rcu 10/14] rcu: Don't
 redundantly disable irqs in rcu_irq_{enter,exit}())
In-Reply-To: <CAMuHMdUjkAkBsJM=BF3tSBw5kHOhLXEb9LRbe-ncQf+huWj8Yw@mail.gmail.com>
References: <CAMuHMdWz0U-uUs1Ox_13YOA0AfVPTx24nTA3=hx5Z5kcHr8SbQ@mail.gmail.com>
 <20160121160657.GW3818@linux.vnet.ibm.com>
 <CAMuHMdUjkAkBsJM=BF3tSBw5kHOhLXEb9LRbe-ncQf+huWj8Yw@mail.gmail.com>
Message-ID: <20160122204412.GN3818@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 09:55:44AM +0100, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Thu, Jan 21, 2016 at 5:06 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Thu, Jan 21, 2016 at 02:22:56PM +0100, Geert Uytterhoeven wrote:
> >> On Thu, Dec 10, 2015 at 12:10 AM, Paul E. McKenney
> >> <paulmck@linux.vnet.ibm.com> wrote:
> >> > This commit replaces a local_irq_save()/local_irq_restore() pair with
> >> > a lockdep assertion that interrupts are already disabled.  This should
> >> > remove the corresponding overhead from the interrupt entry/exit fastpaths.
> >> >
> >> > This change was inspired by the fact that Iftekhar Ahmed's mutation
> >> > testing showed that removing rcu_irq_enter()'s call to local_ird_restore()
> >> > had no effect, which might indicate that interrupts were always enabled
> >> > anyway.
> >> >
> >> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >> > ---
> >> >  include/linux/rcupdate.h   |  4 ++--
> >> >  include/linux/rcutiny.h    |  8 ++++++++
> >> >  include/linux/rcutree.h    |  2 ++
> >> >  include/linux/tracepoint.h |  4 ++--
> >> >  kernel/rcu/tree.c          | 32 ++++++++++++++++++++++++++------
> >> >  5 files changed, 40 insertions(+), 10 deletions(-)
> >>
> >> This commit (7c9906ca5e582a773fff696975e312cef58a7386) is triggering lock ups
> >> during boot on r8a7791/koelsch (dual Cortex A15). Probably this commit does not
> >> contain the real bug, but a symptom.
> >
> > On the off-chance that it is related, here is Ding Tianhong's patch
> > that addressed some lockups:
> >
> > http://www.eenyhelp.com/patch-rfc-locking-mutexes-dont-spin-owner-when-wait-list-not-null-help-215929641.html
> >
> > Does that help in your case?
> 
> Unfortunately not.

We could revert the RCU patch without any real problems -- it is after
all just an optimization.

Hmmm...  One issue that we have seen before is that the irq-disabled
indication is a software flag that is not always in sync with
hardware conditions.  Might it be that we are hitting a situation where
irqs_disabled() is giving the wrong answer, thus suppressing the lockdep
warning?

								Thanx, Paul
