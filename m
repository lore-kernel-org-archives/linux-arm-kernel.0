From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Nov 2009 16:27:14 +0000
Subject: CAS implementation may be broken
In-Reply-To: <20091124153624.GC14462@n2100.arm.linux.org.uk>
References: <4B08055C.3000408@45mercystreet.com>
	<1258989196.8088.28.camel@pc1117.cambridge.arm.com>
	<4B0BF899.7060106@45mercystreet.com>
	<20091124153624.GC14462@n2100.arm.linux.org.uk>
Message-ID: <1259080034.16239.23.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-11-24 at 15:36 +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 24, 2009 at 04:15:37PM +0100, Toby Douglass wrote:
> > So, now I'm puzzled.  I was under the impression it was possible to use 
> > LL/SC to solve ABA.
> 
> Well, what you can do is:
> 
>         LL
>         compute new value
>         SC
> 
> The problem for LL/SC architectures is that this creates a big region
> where we hope that no one else performs another 'load locked' operation.

As I replied to Jamie, the long computation above may introduce some
live-lock situation on some hardware implementations (I think in general
it needs to avoid cache line evictions).

> (I argued initially for a LL / SC interface but the arguments I was making
> were shot down by Linus et.al. as completely unreasonable and technically
> idiotic.)

Maybe because other architectures don't allow for many instructions
between LL and SC.

> Actually, I'm rather surprised that our existing LDREX/STREX implementations
> don't suffer from this problem.  Consider two CPUs operating in lock-step:
> 
>         CPU0            CPU1
>         ldrex
>         add             ldrex
>         strex (fails)   add
>         repeat          strex (fails)
>         ldrex           repeat
>         add             ldrex
>         strex (fails)   add
>         repeat          strex (fails)
>         ...             repeat
>                         ...
> 
> In this scenario, the loops _never_ terminate.  The usual solution is to
> add delays into the loop which depend on the CPU number, thus ensuring
> that two CPUs execute a different number of instructions each time around
> the loop.

I thought we already have a hardware solution or this. There was an
erratum for ARM11MPCore r0p0 where we had to add the delay in software
but it's no longer needed.

> > My feeling in this, for what it's worth, is that this seems an excessive 
> > requirement for something which is necessary for lock-free data 
> > structures; they are becoming important as the number of cores in SMP 
> > systems continues to double.
> 
> Hasn't the lock-free issue been solved by things like rcu?

RCU allows only one writer (and multiple readers). The completely
lock-free algorithm would allow multiple writers (multiple threads
popping from a stack in Toby's original problem).

-- 
Catalin
