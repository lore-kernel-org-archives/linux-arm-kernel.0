From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 May 2010 12:42:57 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in
	theARMv6 DMA cache ops
In-Reply-To: <309002C0DA137042828828FC53D7A93492FA313858@IL-MB01.marvell.com>
References: <309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
	<1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
	<20100512184852.GC22371@n2100.arm.linux.org.uk>
	<20100512185903.GD22371@n2100.arm.linux.org.uk>
	<1273699275.16677.10.camel@e102109-lin.cambridge.arm.com>
	<093A0EAA-42DF-4C72-BAC2-617B25A9165F@marvell.com>
	<1273739217.30713.6.camel@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA3132B2@IL-MB01.marvell.com>
	<20100516150117.GC23961@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA31362D@IL-MB01.marvell.com>
	<20100517065712.GA23118@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A93492FA3136B1@IL-MB01.marvell.com>
	<1274090432.6053.4.camel@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA313858@IL-MB01.marvell.com>
Message-ID: <1274096577.6053.46.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-17 at 14:29 +0300, Ronen Shitrit wrote:
> From: Catalin Marinas [mailto:catalin.marinas at arm.com] 
> On Mon, 2010-05-17 at 10:34 +0300, Ronen Shitrit wrote:
> > After some more thinking, I think I found the problem...
> > 
> > DMA for receive should operate as follows:
> > 1) CPU will map (invalidate) the buffers for the DMA
> > 2) DMA will place the buffers and ack the CPU
> > 3) The CPU will call unmap which will invalidate the buffers again
> 
> (3) doesn't happen with my patch - the unmap function is now a no-op
> since the invalidate operation is destructive.
> 
> [Ronen Shitrit] so how do you protect your self from I-cache spec prefetch?

Strictly looking at the DMA cache maintenance, the API only cares about
the D-side or unified (the I-side is handled by the kernel via other
functions like flush_dcache_page).

> Do you have a unified L2?

Yes, it's a unified L2, so I-cache prefetching can cause allocation into
the L2 cache. The L2 cache is considered "outer cache" in Linux and
invalidated explicitly both before and after the DMA transfer (from
device). Since the L2 (at least on the RealView boards) is common to all
the processors, there is no need for tricks like read/write for
ownership, so the invalidation doesn't affect the underlying RAM.

> As I said in a previous e-mail, it's the sync operation that does an
> invalidate and this would affect the data in the buffer. Hence the patch
> to make the invalidate operation non-destructive (as long as your CPU
> doesn't do speculative loads into the D-cache or they can be disabled).
> 
> [Ronen Shitrit] What about I-cache prefetch? Unified cache?

The "sync_for_cpu" operation (from device case) first invalidates the L2
cache and then invalidates the L1 using a LDR/STR pair and cache op. So
a the LDR would see the data in RAM rather than some speculatively
loaded value in the L2.

-- 
Catalin
