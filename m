From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Sun, 14 Jul 2013 18:21:33 +0300
Subject: Call for testing/opinions: Optimized memset/memcpy
In-Reply-To: <loom.20130714T124137-382@post.gmane.org>
References: <loom.20130713T172357-560@post.gmane.org>
 <20130713172445.GL32054@1wt.eu>
 <loom.20130713T232124-511@post.gmane.org>
 <20130714061354.GS32054@1wt.eu>
 <loom.20130714T124137-382@post.gmane.org>
Message-ID: <20130714182133.7971180d@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 14 Jul 2013 11:00:50 +0000 (UTC)
Harm Hanemaaijer <fgenfb@yahoo.com> wrote:

> Willy Tarreau <w <at> 1wt.eu> writes:
> 
> > 
> > Please find the results attached. It seems that memcpy improved by 0.8%
> > though that's not even certain.
> > 
> 
> What is interesting is that
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0388f/Caccifbd.html,
> and several other sources (such as other
> optimized memcpy implementations) document the cache line size of the Cortex
> A9 as 32 bytes, which is an anomaly in the armv7 family.

Yes, the cache line size is 32 bytes in Cortex-A9. However in order to
mitigate poor memory memory bandwidth utilization, the L2 cache
controller implements 'double linefill' feature:

    http://infocenter.arm.com/help/topic/com.arm.doc.ddi0246h/CHDHIECI.html

But 'double linefill' only first appeared in r3p0 revision of L2C-310
L2 cache controller (also known as PL310) and was a bit buggy in the
revisions older than r3p2 according to the errata list:

    http://infocenter.arm.com/help/topic/com.arm.doc.uan0013b/index.html

Which only makes double linefill usable in modern Cortex-A9 based SoCs
such as Exynos4412, but unfortunately not in the older Cortex-A9 based
systems.

When double linefill is enabled, two cache lines are allocated at once
in L2, so for the memcpy alike workloads it looks somewhat similar to
real 64 byte cache line size. Welcome to the diverse world of ARM
hardware :)

-- 
Best regards,
Siarhei Siamashka
