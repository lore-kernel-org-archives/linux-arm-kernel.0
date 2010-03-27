From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Mar 2010 22:52:40 +0000
Subject: [PATCH 1/1] [RFCv2] arm: add half-word __xchg
In-Reply-To: <1269535366-25175-1-git-send-email-virtuoso@slind.org>
References: <20100318135008.GA11800@Krystal>
	<1269535366-25175-1-git-send-email-virtuoso@slind.org>
Message-ID: <20100327225240.GC13203@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 06:42:46PM +0200, Alexander Shishkin wrote:
> +/*
> + * emulate __xchg() using 32-bit __cmpxchg()
> + */
> +static inline unsigned long __xchg_generic(unsigned long x,
> +						 volatile void *ptr, int size)
> +{
> +	unsigned long *ptrbig = (unsigned long *)((unsigned long)ptr & ~3UL);
> +	int shift = ((unsigned)ptr - (unsigned)ptrbig) * 8;

I wonder if we should be using __alignof__ here.

	unsigned long *ptrbig = (unsigned long *)((unsigned long)ptr &
		(__alignof__(unsigned long) - 1));

Rest of the patch looks fine; it'd be nice to get some tested-by's for it
though.
