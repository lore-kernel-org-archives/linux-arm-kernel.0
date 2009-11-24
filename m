From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2009 15:36:24 +0000
Subject: CAS implementation may be broken
In-Reply-To: <4B0BF899.7060106@45mercystreet.com>
References: <4B08055C.3000408@45mercystreet.com>
	<1258989196.8088.28.camel@pc1117.cambridge.arm.com>
	<4B0BF899.7060106@45mercystreet.com>
Message-ID: <20091124153624.GC14462@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 04:15:37PM +0100, Toby Douglass wrote:
> So, now I'm puzzled.  I was under the impression it was possible to use  
> LL/SC to solve ABA.

Well, what you can do is:

	LL
	compute new value
	SC

The problem for LL/SC architectures is that this creates a big region
where we hope that no one else performs another 'load locked' operation.

LL/SC based architectures doing this traditionally fall fowl of a problem.
Consider the following:

do {
	LL
	complex computation to new value
	SC
} while (store failed)

and have that running on two CPUs trying to modify the same location.  It
can hang both CPUs up in that loop for a _very_ long time.  This is
primerily why we've ended up with a CAS implementation, and everything
is implemented as:

	do {
		load current
		compute new value
		do {
			LL old
			old == current?
				SC new
		} while SC failed
	} while old != current

(I argued initially for a LL / SC interface but the arguments I was making
were shot down by Linus et.al. as completely unreasonable and technically
idiotic.)

Actually, I'm rather surprised that our existing LDREX/STREX implementations
don't suffer from this problem.  Consider two CPUs operating in lock-step:

	CPU0		CPU1
	ldrex
	add		ldrex
	strex (fails)	add
	repeat		strex (fails)
	ldrex		repeat
	add		ldrex
	strex (fails)	add
	repeat		strex (fails)
	...		repeat
			...

In this scenario, the loops _never_ terminate.  The usual solution is to
add delays into the loop which depend on the CPU number, thus ensuring
that two CPUs execute a different number of instructions each time around
the loop.

> My feeling in this, for what it's worth, is that this seems an excessive  
> requirement for something which is necessary for lock-free data  
> structures; they are becoming important as the number of cores in SMP  
> systems continues to double.

Hasn't the lock-free issue been solved by things like rcu?
