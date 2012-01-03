From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 17:41:23 +0000
Subject: [PATCH] ARM: imx6: fix v7_invalidate_l1 by adding I-Cache
 invalidation
In-Reply-To: <20111231092148.GG12182@S2100-06.ap.freescale.net>
References: <1325237200-10610-1-git-send-email-shawn.guo@linaro.org>
 <CAB4PhKexxJM+rWhgdQfu9vB16KVT6QpN1ye4kH88pNiLnEyL+Q@mail.gmail.com>
 <20111231092148.GG12182@S2100-06.ap.freescale.net>
Message-ID: <20120103174123.GE2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 31, 2011 at 05:21:49PM +0800, Shawn Guo wrote:
> I was ever told by Russell that ARM_ARM permits that cache holds random
> data out of a power-up.  But I'm not sure if the validity mark can also
> be randomized.

It's worse than that: the ARM ARM says that some caches may require a
CPU specific sequence to initialize them after power-up.  It's also
implemenation defined whether entries in the cache can be hit while
the caches are disabled.  I believe that there's nothing mentioned
about the state of the validity bits either (which, from my reading,
could be in a random state.)

As far as the architecture goes, it doesn't matter provided there is
an implementation defined sequence which results in the caches being
properly initialized.

I suspect that an implementation which choses to leave the validity bits
in a random state _and_ which searches the instruction cache with I=0 in
the control register would not be reasonable as each time you power up,
you're playing russian roulette with the contents of the I cache
interfering with the very first instruction to be executed by the CPU.

However, an implementation which guaranteed that there wouldn't be an
I-cache entry at the reset vector, and specified a sequence which would
fit inside one cache line, and which had the properties above _would_
conform.

So, this makes for a really interesting situation: by the time we get
anywhere near the kernel, it may already be too late to invalidate the
caches if it hasn't already been done.

We really need boot loaders to have already initialized the caches.
In the case of secondary CPU bringup, it's possible that the secondary
CPU may start executing from our trampoline code, and this is why
platforms are able to specify their own initial code for this.
