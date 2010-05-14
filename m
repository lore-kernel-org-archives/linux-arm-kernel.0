From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 May 2010 17:42:31 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in
	theARMv6 DMA cache ops
In-Reply-To: <1273854594.28312.82.camel@e102109-lin.cambridge.arm.com>
References: <20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
	<1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
	<20100512184852.GC22371@n2100.arm.linux.org.uk>
	<20100512185903.GD22371@n2100.arm.linux.org.uk>
	<1273699275.16677.10.camel@e102109-lin.cambridge.arm.com>
	<093A0EAA-42DF-4C72-BAC2-617B25A9165F@marvell.com>
	<1273739217.30713.6.camel@e102109-lin.cambridge.arm.com>
	<20100513135456.GH18984@mvista.com>
	<1273760120.30713.67.camel@e102109-lin.cambridge.arm.com>
	<20100513203423.GQ18984@mvista.com>
	<1273854594.28312.82.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1273855351.28312.98.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-05-14 at 17:29 +0100, Catalin Marinas wrote:
> What I think I missed in my patch (and didn't show up with a sata drive)
> is the "sync" operations. The dma_sync_single_for_device(FROMDEVICE)
> corrupts the existing buffer.
> 
> I'll post an updated patch shortly.

Actually I think the hunk that I posted earlier should be enough:


diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index a4a6840..aa3ac32 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -216,7 +216,8 @@ v6_dma_inv_range:
 #endif
 1:
 #ifdef CONFIG_SMP
-	str	r0, [r0]			@ write for ownership
+	ldr	r2, [r0]			@ read for ownership
+	str	r2, [r0]			@ write for ownership
 #endif
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D line


The dma_sync_single_for_cpu() eventually calls dmac_unmap_area() which
on ARM11MPCore became a no-op. There is no problem since this function
call is always preceded by a call to either dma_map_single() or
dma_sync_single_to_device(), both of them calling dma_map_area() which
does the cache invalidation.

With the patch above, v6_dma_inv_range() is no longer destructive so the
transferred data to the SDRAM is preserved. We could even re-instate the
v6_dma_unmap_area() function but for performance reasons I would leave
it as a no-op.

Russell, are you ok with such change? Since you already applied the
original patch as #6111, I will send an additional patch with this fix
(I'm sending it directly to the patch system as I won't have access to
my work PC this weekend. Feel free to apply or reject).

Thanks.

-- 
Catalin
