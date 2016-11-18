From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 18 Nov 2016 15:42:10 +0100
Subject: [PATCH] arm: spin one more cycle in timer-based delays
In-Reply-To: <582F0DD2.3030805@free.fr>
References: <582B0F61.6030903@free.fr> <20161118120630.GJ13470@arm.com>
 <20161118125409.GK1041@n2100.armlinux.org.uk>
 <582F0DD2.3030805@free.fr>
Message-ID: <20161118144210.GS3117@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 03:18:58PM +0100, Mason wrote:
> If I understand correctly, udelay is, in fact, a wrapper around
> several possible implementations. (Run-time decision on arch/arm)
> 
> 1) The "historical" software loop-based method, which is calibrated
> during init.
> 
> 2) A hardware solution, based on an actual timer, ticking away
> at a constant frequency.

I'd say clock, a timer would imply interrupts or somesuch, which is of
course not useful for udelay.

x86 with TSC uses this, although recent chips have grown an timed-mwait
instruction and that too can be used.

The TSC based ones (including the mwait) try very hard to not return
early.

> 3) others?

On x86 there's a variant that times itself based on io port accesses
which have a 'known' slowness.
