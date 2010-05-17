From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 May 2010 14:45:49 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in
	theARMv6 DMA cache ops
In-Reply-To: <309002C0DA137042828828FC53D7A93492FA313892@IL-MB01.marvell.com>
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
	<1274096577.6053.46.camel@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA313892@IL-MB01.marvell.com>
Message-ID: <1274103949.6053.54.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-17 at 13:04 +0100, Ronen Shitrit wrote:
> > As I said in a previous e-mail, it's the sync operation that does an
> > invalidate and this would affect the data in the buffer. Hence the patch
> > to make the invalidate operation non-destructive (as long as your CPU
> > doesn't do speculative loads into the D-cache or they can be disabled).
> >
> > [Ronen Shitrit] What about I-cache prefetch? Unified cache?
> 
> The "sync_for_cpu" operation (from device case) first invalidates the L2
> cache and then invalidates the L1 using a LDR/STR pair and cache op.
> [Ronen Shitrit] So for v6-MP, if no D-cache spec pref, why do you need to inv the L1 at all?

No, you are correct. The ___dma_single_dev_to_cpu(FROM_DEVICE) function
calls outer_inv_range() followed by dmac_unmap_area(). The latter,
however, is a no-op with my DMA workaround patch.

-- 
Catalin
