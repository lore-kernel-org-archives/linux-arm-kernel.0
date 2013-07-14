From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Jul 2013 14:09:50 +0100
Subject: Call for testing/opinions: Optimized memset/memcpy
In-Reply-To: <loom.20130714T124137-382@post.gmane.org>
References: <loom.20130713T172357-560@post.gmane.org>
 <20130713172445.GL32054@1wt.eu> <loom.20130713T232124-511@post.gmane.org>
 <20130714061354.GS32054@1wt.eu> <loom.20130714T124137-382@post.gmane.org>
Message-ID: <20130714130949.GR24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 14, 2013 at 11:00:50AM +0000, Harm Hanemaaijer wrote:
> What is interesting is that
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0388f/Caccifbd.html,
> and several other sources (such as other
> optimized memcpy implementations) document the cache line size of the Cortex
> A9 as 32 bytes, which is an anomaly in the armv7 family. However, it looks
> like the kernel is defining L1_CACHE_BYTES as 64 (L1_CACHE_SHIFT == 6) for
> all armv7 platforms, which looks like a serious configuring error for Cortex
> A9.

You're making wrong assumptions about what L1_CACHE_BYTES is.

Firstly, L1_CACHE_BYTES is not dynamic - it's a build time constant.
You have to make a decision what value it is to be set to when you
build the kernel.  This is because it gets used to determine the
alignment of structures built into the kernel image, amongst other
things, and we can't dynamically relink the kernel at boot time.

So please, get out of your mind any idea that L1_CACHE_BYTES somehow
relates to the exact CPU you're running on.  It doesn't.

What it relates to is the *maximum* cache line size of *any* CPU that
we will run on.

Take a moment to think about why given the above.  If you're booting on
a 32 byte cache line CPU, will a structure aligned for a 64 byte cache
line also be aligned for a 32-byte cache line?  How about the reverse
case?

Now, there are various ARMv7 Cortex CPUs that have 64 byte cache lines
out there in the wild - Cortex A8 and Cortex A15 are two examples, both
of them are ARMv7 CPUs.

As we can't distinguish at run time between these, and we are working for
a single zImage kernel, we have to assume that ARMv7 means a 64 byte cache
line as far as the L1_CACHE_* constants are concerned.  Yes, we used to
set it for OMAP3 and some Samsung SoC too, but then others came along and
single zImage too - and that all makes trying to reduce it down to the
minimum rather pointless.

So, no, this is *not* a "serious configuring error" at all.  It is totally
intended to be this way.
