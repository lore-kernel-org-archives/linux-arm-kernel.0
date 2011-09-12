From: tixy@yxit.co.uk (Tixy)
Date: Mon, 12 Sep 2011 08:09:13 +0100
Subject: [PATCH v2 09/10] ARM: kprobes: Add some benchmarking to test
	module
In-Reply-To: <alpine.LFD.2.00.1109112241310.20358@xanadu.home>
References: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
	<1315652706-2900-10-git-send-email-tixy@yxit.co.uk>
	<alpine.LFD.2.00.1109112241310.20358@xanadu.home>
Message-ID: <1315811353.2255.35.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-09-11 at 22:58 -0400, Nicolas Pitre wrote:
> On Sat, 10 Sep 2011, Tixy wrote:
> 
> > From: Jon Medhurst <tixy@yxit.co.uk>
> > 
> > These benchmarks show the basic speed of kprobes and verify the success
> > of optimisations done to the emulation of typical function entry
> > instructions (i.e. push/stmdb).
> > 
> > Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
> > ---
> 
> [...]
> 
> > +#ifdef CONFIG_THUMB2_KERNEL
> > +#define wide ".w"
> > +#else
> > +#define wide
> > +#endif
> 
> I suppose you can't reuse the W() macro from arch/arm/include/asm/unified.h 
> here...
> 
> > +static int benchmark(void(*fn)(void))
> > +{
> > +	int t, n;
> > +	for (n = 1000; ; n *= 2) {
> > +		struct timeval before;
> > +		struct timeval after;
> > +		int i;
> > +
> > +		do_gettimeofday(&before);
> > +
> > +		for (i = n; i > 0; --i)
> > +			fn();
> > +
> > +		do_gettimeofday(&after);
> > +		t = after.tv_usec - before.tv_usec;
> > +		if (t < 0)
> > +			t += 1000000; /* Adjust time if it wrapped */
> > +		if (t >= 250000)
> > +			break; /* Stop once we took more than 0.25 seconds */
> > +	}
> > +	return t / (n / 1000); /* Return time in nano-seconds */
> > +};
> 
> I think that using sched_clock() here might be a better choice than 
> do_gettimeofday().  It is certainly much lower overhead and easier to 
> use.

When googling for sched_clock I came across a five year old posting [1]
by Russell saying that uses of sched_clock() for timing intervals is
broken because the range of values it gives doesn't fill all the bits in
the returned integer, leading to a discontinuity when the value wraps.

However, looking at the current implementations of sched_clock() they
seems to have full 64-bit range, and git history shows a new common
infrastructure for sched_clock being added at the end of last year. So
is the full 64-bit range now defined for the sched_clock on API on ARM?

-- 
Tixy 

[1] http://lkml.indiana.edu/hypermail/linux/kernel/0605.0/0425.html
