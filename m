From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 May 2011 12:19:55 +0100
Subject: [PATCH 1/5] ARM: cache: ensure MVA is cacheline aligned in
	flush_kern_dcache_area
In-Reply-To: <1305890399-29075-1-git-send-email-will.deacon@arm.com>
References: <1305890399-29075-1-git-send-email-will.deacon@arm.com>
Message-ID: <1305890399-29075-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The v6 and v7 implementations of flush_kern_dcache_area do not align
the passed MVA to the size of a cacheline in the data cache. If a
misaligned address is used, only a subset of the requested area will
be flushed. This has been observed to cause failures in SMP boot where
the secondary_data initialised by the primary CPU is not cacheline
aligned, causing the secondary CPUs to read incorrect values for their
pgd and stack pointers.

This patch ensures that the base address is cacheline aligned before
flushing the d-cache.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/cache-v6.S |    1 +
 arch/arm/mm/cache-v7.S |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index c96fa1b..73b4a8b 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -176,6 +176,7 @@ ENDPROC(v6_coherent_kern_range)
  */
 ENTRY(v6_flush_kern_dcache_area)
 	add	r1, r0, r1
+	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
 1:
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index dc18d81..d32f02b 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -221,6 +221,8 @@ ENDPROC(v7_coherent_user_range)
 ENTRY(v7_flush_kern_dcache_area)
 	dcache_line_size r2, r3
 	add	r1, r0, r1
+	sub	r3, r2, #1
+	bic	r0, r0, r3
 1:
 	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line / unified line
 	add	r0, r0, r2
-- 
1.7.0.4
