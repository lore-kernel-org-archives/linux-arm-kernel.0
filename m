From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 30 Sep 2014 15:37:49 +0200
Subject: [PATCH] sched, time: cmpxchg does not work on 64-bit variable
In-Reply-To: <542AA33E.2050008@redhat.com>
References: <2547036.UshV4pXvhf@wuerfel>
 <542AA33E.2050008@redhat.com>
Message-ID: <20140930133749.GD4241@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 08:34:06AM -0400, Rik van Riel wrote:
> On 09/30/2014 07:56 AM, Arnd Bergmann wrote:
> > A recent change to update the stime/utime members of task_struct 
> > using atomic cmpxchg broke configurations on 32-bit machines with 
> > CONFIG_VIRT_CPU_ACCOUNTING_GEN set, because that uses 64-bit 
> > nanoseconds, leading to a link-time error:
> > 
> > kernel/built-in.o: In function `cputime_adjust': :(.text+0x25234):
> > undefined reference to `__bad_cmpxchg'
> > 
> > This reverts the change that caused the problem, I suspect the real
> > fix is to conditionally use cmpxchg64 instead, but I have not
> > checked if that will work on all architectures.
> 
> I see that kernel/sched/clock.c uses cmpxchg64 in a non
> architecture, non 64 bit specific piece of code, and
> nobody complained about that file not building, so I have
> to assume cmpxchg64 works :)

That code is only ever used on x86 and ia64, most other archs have
managed to not mess up their clocks quite as bad.
