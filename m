From: rshitrit@marvell.com (Ronen Shitrit)
Date: Wed, 12 May 2010 18:03:05 +0300
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in the
	ARMv6	DMA cache ops
In-Reply-To: <1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
	<1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
Message-ID: <309002C0DA137042828828FC53D7A93492FA312C4E@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the fast response.
The kernel doesn't hang but the NFS can't complete loading the FS, seems like DMA data corruption...
The patch below seems to solve the issue :)
I guess we can't assure that the 2nd scenario below won't happen...

Regards
Ronen Shitrit

-----Original Message-----
From: Catalin Marinas [mailto:catalin.marinas at arm.com] 
Sent: Wednesday, May 12, 2010 4:56 PM
To: Ronen Shitrit
Cc: linux-arm-kernel at lists.infradead.org
Subject: RE: [PATCH 2/8] ARM: Implement read/write for ownership in the ARMv6 DMA cache ops

On Wed, 2010-05-12 at 15:51 +0300, Ronen Shitrit wrote:
> I'm using ARM v6 MP core.
> I have applied this patch above 2.6.34-rc7 and my system hang while
> booting from NFS (through e1000 nic).

Does the whole kernel hang or it's just user space?

> Previously I used 2.6.32 with the cache broadcast IPI mask and it
> worked just fine for me.
> I have noticed that if I remove the str, write for ownership, in the
> dma_inv the system boot just fine.

The only way to invalidate the caches on all the CPUs is to force a
write so that the cache line is moved to modified/exclusive mode (no
other CPUs has the cache line) and then invalidate.

Drivers shouldn't call dma_inv_range if they have valid date in that
buffer (that's why I removed the dma_inv_range call from
dma_unmap_area).

Could try the patch below:

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index e46ecd8..332b48c 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -212,7 +212,8 @@ v6_dma_inv_range:
 #endif
 1:
 #ifdef CONFIG_SMP
-	str	r0, [r0]			@ write for ownership
+	ldr	r2, [r0]			@ read for ownership
+	str	r2, [r0]			@ write for ownership
 #endif
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D line

> - Why was the IPI solution dropped?

It can cause deadlock in some circumstances (there was a thread some
time ago).

> - I can think of few cases the above str might be problematic:
> 1) CPU 0 is doing inv, after the str cpu 1 change the line and then
> cpu 0 inv the line... probably won't happen since the dma buffer
> shouldn't be used by more the one CPU...

This shouldn't happen. Even without my patch, doing a cache line
invalidation would erase the data written by CPU1, so the same
corruption.

> 2) CPU 0 is doing inv, the str write garbage which get to the DRAM
> because of eviction and break the assumption that inv shouldn't change
> the DRAM...

This may be the case but is there such situation? The above patch should
fix it but it slows down the invalidate operation further.

Thanks.

-- 
Catalin
