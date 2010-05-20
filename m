From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 May 2010 14:21:52 +0100
Subject: [PATCH 4/7] ARM: The v6_dma_inv_range() function must preserve data
	on SMP
In-Reply-To: <20100520131833.7521.66668.stgit@e102109-lin.cambridge.arm.com>
References: <20100520131833.7521.66668.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100520132152.7521.95985.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent patch for DMA cache maintenance on ARM11MPCore added a write
for ownership trick to the v6_dma_inv_range() function. Such operation
destroys data already present in the buffer. However, this function is
used with with dma_sync_single_for_device() which is supposed to
preserve the existing data transfered into the buffer. This patch adds a
combination of read/write for ownership to preserve the original data.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Ronen Shitrit <rshitrit@marvell.com>
---
 arch/arm/mm/cache-v6.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

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
