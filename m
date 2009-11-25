From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 25 Nov 2009 01:24:06 +0000
Subject: CAS implementation may be broken
In-Reply-To: <4B0BF899.7060106@45mercystreet.com>
References: <4B08055C.3000408@45mercystreet.com>
	<1258989196.8088.28.camel@pc1117.cambridge.arm.com>
	<4B0BF899.7060106@45mercystreet.com>
Message-ID: <20091125012406.GB13142@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Toby Douglass wrote:
> Catalin Marinas wrote:
> Interestingly, I saw a day or two ago that there is a double-word 
> version of LDREX.  The atomic-ptr project, which forms the basis of the 
> GCC garbage collector, relies on this; it does not in fact use LL/SC on 
> ARM, but rather uses double-word CAS using a pointer-counter pair.

Note that pointer-counter is not really reliable.

If a thread is suspended for the time taken for exactly 2^32 operations
by other threads, it fails.  (Assuming 32-bit pointer + 32-bit counter).

That's unlikely, but not impossible.

Consider a program with 100 threads and one CPU, each thread in a
tight loop doing atomic_op(&p) and some other things.  It's quite
reasonable for 1 thread to be descheduled for the amount of time taken
for 2^32 iterations from all the other threads, if the pointer-counter
CAS operation is fast, which it increasingly is.

Remember, this is one CPU so it's in L1 cache, and modern CPUs execute
2^32 operations in a single second.  CAS operations are not
single-cycle _yet_, but they continue to get faster.

With 100 threads running without sleeping, the kernel may well
deschedule one of them for several seconds as it cycles through them
all and gives them "non-interactive" timeslices.

It's also quite likely to wrap if someone used kill -STOP, and later
kill -CONT on a thread, or if they're debugging one of the threads.

Of course even if the counter wraps, you still have to be 1/2^32
unlucky to see the same value.  But that's enough to make it unreliable.

-- Jamie
