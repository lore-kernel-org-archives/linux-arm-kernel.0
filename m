From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 11 Sep 2011 22:58:03 -0400 (EDT)
Subject: [PATCH v2 09/10] ARM: kprobes: Add some benchmarking to test
	module
In-Reply-To: <1315652706-2900-10-git-send-email-tixy@yxit.co.uk>
References: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
	<1315652706-2900-10-git-send-email-tixy@yxit.co.uk>
Message-ID: <alpine.LFD.2.00.1109112241310.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 10 Sep 2011, Tixy wrote:

> From: Jon Medhurst <tixy@yxit.co.uk>
> 
> These benchmarks show the basic speed of kprobes and verify the success
> of optimisations done to the emulation of typical function entry
> instructions (i.e. push/stmdb).
> 
> Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
> ---

[...]

> +#ifdef CONFIG_THUMB2_KERNEL
> +#define wide ".w"
> +#else
> +#define wide
> +#endif

I suppose you can't reuse the W() macro from arch/arm/include/asm/unified.h 
here...

> +static int benchmark(void(*fn)(void))
> +{
> +	int t, n;
> +	for (n = 1000; ; n *= 2) {
> +		struct timeval before;
> +		struct timeval after;
> +		int i;
> +
> +		do_gettimeofday(&before);
> +
> +		for (i = n; i > 0; --i)
> +			fn();
> +
> +		do_gettimeofday(&after);
> +		t = after.tv_usec - before.tv_usec;
> +		if (t < 0)
> +			t += 1000000; /* Adjust time if it wrapped */
> +		if (t >= 250000)
> +			break; /* Stop once we took more than 0.25 seconds */
> +	}
> +	return t / (n / 1000); /* Return time in nano-seconds */
> +};

I think that using sched_clock() here might be a better choice than 
do_gettimeofday().  It is certainly much lower overhead and easier to 
use.


Nicolas
