From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 19 May 2015 14:43:33 +0200
Subject: [RFC] arm: Add for atomic half word exchange
In-Reply-To: <1795987946.405311432034410830.JavaMail.weblogic@ep2mlwas07a>
References: <1795987946.405311432034410830.JavaMail.weblogic@ep2mlwas07a>
Message-ID: <20150519124333.GC3644@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 11:20:13AM +0000, Sarbojit Ganguly wrote:
> On Tuesday 19 May 2015 09:39:33 Sarbojit Ganguly wrote:
> > Since 16 bit half word exchange was not there and MCS based
> > qspinlock by Waiman's xchg_tail() requires an atomic exchange on a
> > half word, here is a small modification to __xchg() code.

Can you actually see a performance improvement with the qspinlock code
on ARM ?

The real improvements on x86 were on NUMA systems; although there were
real improvements on light loads as well.


Note that ARM (or any load-store arch) could get rid of all the cmpxchg
loops in that code. Although I suppose we replaced the most common ones
with these unconditional atomics already -- like that xchg16 -- so
implementing those with ll/sc, as you did, should be near optimal.
