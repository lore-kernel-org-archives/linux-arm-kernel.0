From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 08:51:32 +0200
Subject: [RFC] arm: Add for atomic half word exchange
In-Reply-To: <1348896100.440561432098574765.JavaMail.weblogic@ep2mlwas07a>
References: <1348896100.440561432098574765.JavaMail.weblogic@ep2mlwas07a>
Message-ID: <2528978.P5FT0BVksd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 May 2015 05:09:35 Sarbojit Ganguly wrote:

> > ------- Original Message -------
> > Sender : Peter Zijlstra<peterz@infradead.org>
> > Date : May 19, 2015 21:43 (GMT+09:00)
> > Title : Re: [RFC] arm: Add for atomic half word exchange
> > 
> > On Tue, May 19, 2015 at 11:20:13AM +0000, Sarbojit Ganguly wrote:
> > > On Tuesday 19 May 2015 09:39:33 Sarbojit Ganguly wrote:
> > > > Since 16 bit half word exchange was not there and MCS based
> > > > qspinlock by Waiman's xchg_tail() requires an atomic exchange on a
> > > > half word, here is a small modification to __xchg() code.
> > 
> > Can you actually see a performance improvement with the qspinlock code
> > on ARM ?
> > 
> > The real improvements on x86 were on NUMA systems; although there were
> > real improvements on light loads as well.
> > 
> > 
> > Note that ARM (or any load-store arch) could get rid of all the cmpxchg
> > loops in that code. Although I suppose we replaced the most common ones
> > with these unconditional atomics already -- like that xchg16 -- so
> > implementing those with ll/sc, as you did, should be near optimal.
>
> Yes, the main advantage of Qspinlock code can be observed in NUMA but
> when I tested in an embedded system, a slight advantage was observed.

Is this a multi-cluster SMP system? Those can behave like NUMA
machines in some ways.

We could easily limit the use of 16-bit xchg() to ARMv7 machines
by using

	select ARCH_USE_QUEUED_SPINLOCKS if !SMP_ON_UP

or

	select ARCH_USE_QUEUED_SPINLOCKS if !CPU_V6

when enabling the qspinlock implementation.

	Arnd
